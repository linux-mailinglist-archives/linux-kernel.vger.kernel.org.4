Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A6870EDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbjEXG3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjEXG3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:29:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696419C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:29:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af225e5b4bso7570331fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684909775; x=1687501775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADXbD+WyjY/a3C44OvKKZGai/nGC+LFyoWdYlICKXPU=;
        b=VhBc9lZ9orvrj2dcBEqriY0TB/eqwSa95I70QFP2EHC5wHBfSTxeow1P+WLdJww3wX
         6PdfoE25ASVfJ7AhYeeYMXoAROF3x/kvD1q5OoTyo5n0C9aGK5pk/jjnTiLrcolbhkfb
         uKXsRwOzwIaH5yoZ7fX5ni3Lsqp5eg88BdxhacD2Wz6ysu3jCLM5Z0zBF0Vs4Ec0eAbt
         gsng+1J95y0U3iMOOU7O8TIg61aA1o/aj8G4+UHqFDF8L1gBd88//M+b+0dut4jlqrdY
         xp/SCvuiCQFpFPd1DJyPR5+IaT9QAM9HmQp2HABtSUWX7vG9LZOxS15hmqjOk0U/tEbs
         GXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684909775; x=1687501775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADXbD+WyjY/a3C44OvKKZGai/nGC+LFyoWdYlICKXPU=;
        b=ZLotcBDsApSP+EHlIiLRHJY1q2of52QnYWwPzsffKRzsq0OMHGLadzs91LqYozVafP
         Zejw2A7R1sPmg/5A+6fwkCD4yPOm4bs2szJVLEu3dHUrWC5+SCB3UhyfTUmyA0MmP9Cj
         36twKZHYxnD7vfvFxPghMrtbquvb+t7pzDYuEk+HTzpOzY+keo8XlVhCKikGQ+tVr6gu
         Ino9hQu8cQ1X9TtYxKrdZwfzOEbRQxcO1KlDjjd4NpM4Y4BTRYNPD/0Bzj1QkDwTupsr
         3VhOTB7B+09aPmSAf1QcFGnEFP2KF2KoTkdzVOmMpd1Q3iOb1RKx1PfnryG2BWaaA0f/
         dszQ==
X-Gm-Message-State: AC+VfDxKyPjBw++InIfu0UqEvlKZSdBDhbB44hlqhf6c6AJHM/mLLsNY
        3WhOLJMDFyUssQD7VEeAfs+z3pb1g9DRb6mxbxs=
X-Google-Smtp-Source: ACHHUZ66Vr30OJ4X4Ex15iX6UaQMJjBYrDgZH3iNJ2pRZpBzlC+ggVVqpBYvZPJm5yH2tY46yIjh4w==
X-Received: by 2002:a2e:a30d:0:b0:2b0:45ff:7959 with SMTP id l13-20020a2ea30d000000b002b045ff7959mr579995lje.51.1684909774956;
        Tue, 23 May 2023 23:29:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x26-20020a2e881a000000b002a8b08882dbsm1962672ljh.55.2023.05.23.23.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 23:29:34 -0700 (PDT)
Message-ID: <1dca6efc-3020-ce79-18f1-ae56bef4f688@linaro.org>
Date:   Wed, 24 May 2023 09:29:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v13 05/24] mailbox: Add Gunyah message queue mailbox
Content-Language: en-GB
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-6-quic_eberman@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230509204801.2824351-6-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 23:47, Elliot Berman wrote:
> Gunyah message queues are a unidirectional inter-VM pipe for messages up
> to 1024 bytes. This driver supports pairing a receiver message queue and
> a transmitter message queue to expose a single mailbox channel.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/message-queue.rst |   8 +
>   drivers/mailbox/Makefile                    |   2 +
>   drivers/mailbox/gunyah-msgq.c               | 212 ++++++++++++++++++++
>   include/linux/gunyah.h                      |  57 ++++++
>   4 files changed, 279 insertions(+)
>   create mode 100644 drivers/mailbox/gunyah-msgq.c
> 
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> index b352918ae54b..70d82a4ef32d 100644
> --- a/Documentation/virt/gunyah/message-queue.rst
> +++ b/Documentation/virt/gunyah/message-queue.rst

Note, this file is not a part of the patchset. Trying to apply the 
patchset results in rejects. Probably you missed the documentation patch 
when sending this series.

> @@ -61,3 +61,11 @@ vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
>         |               |         |                 |         |               |
>         |               |         |                 |         |               |
>         +---------------+         +-----------------+         +---------------+
> +
> +Gunyah message queues are exposed as mailboxes. To create the mailbox, create
> +a mbox_client and call `gh_msgq_init()`. On receipt of the RX_READY interrupt,
> +all messages in the RX message queue are read and pushed via the `rx_callback`
> +of the registered mbox_client.
> +
> +.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
> +   :identifiers: gh_msgq_init-- 
With best wishes
Dmitry

