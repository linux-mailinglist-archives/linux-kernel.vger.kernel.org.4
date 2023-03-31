Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6916D2251
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjCaOYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCaOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:24:28 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5649DE
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:24:27 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id n1so10848492ili.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272666; x=1682864666;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6UCEBU5mLz9QdxPqNmojtQa38OeHK3XeLs0yM78qHDU=;
        b=ysa2qjifmTJO9JHHygIj29NmPqr7X++zxe0C5SngoNEYEgnb6q3wTU0Ve8V3Hk83qq
         xyyQcuFNn2Joc/XP++7VT03IfLitF+LM8DOP0xJ/cRTKpR8InW0+3C31Mbh7F4ztZUnN
         zCwyOiMRX2fzNPiOUI2aIg9/HgN+XbXvLdihCmNm2Bn3LDgvSfYnMYm8EToTOrGMPf4J
         osR6kfHsUdXfrRt0vB+TpSvVef8YETc489yJTl/1WCscdnWZZqFjVrNKxgL4vB/EFSrR
         ZsF7jEu35iOjh6Q4RD19FIcrALibJKiLmUQfYeA4xvDxLcjtld6MgCvxU/RzPK2vfkfP
         Ae1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272666; x=1682864666;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UCEBU5mLz9QdxPqNmojtQa38OeHK3XeLs0yM78qHDU=;
        b=SaqKkV7yXH3tLR4vsv6DvJBos1gAFMBxz/I3ALBAeNBiSQjNX14KAq3RwZOgvE/VLu
         WgpHLnaMDagQiSH2Tokn1Ub4KYjtpz6khU0MU8qlBrJt2Oqg0D5wQwRo7lLw05ZZ9uZ3
         J1gsTfUvtUKdgbba/InZBIiLfpVWRCz8h/CBC4Q92jksHhA/H9IPEe4huSqPvxK895o7
         yUfgfyGy8BMgQX0LJ8zrSNJxkRIdeBltE03mLHq8qEhTV45uzbxYj/0N/VpzAFLwCGIY
         DTHaq6gCMIbKoWoCa2XGw7yR7ZGszGyaQg4R4hNTvmU/liJxPB9FdKOFz8EaiiFJtqrx
         qZUg==
X-Gm-Message-State: AAQBX9f2JC3Bb8/YKtu86ZNtvk39s5WD6Iojo+CI0ShS0YCcb1pSDP1l
        XCw8gpoIuI1AydmVQ1Qgb2W1Wg==
X-Google-Smtp-Source: AKy350YVgRKOO4Y8oepZkwpgSMnl2j7X6N2/BaBvJ1LPgAjZRmKLiJF6tNiaXZIiQzSXa2KbugpiaA==
X-Received: by 2002:a05:6e02:4cb:b0:323:f57c:806d with SMTP id f11-20020a056e0204cb00b00323f57c806dmr14994799ils.3.1680272666593;
        Fri, 31 Mar 2023 07:24:26 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id g3-20020a056e020d0300b003230c7d6a3csm657043ilj.67.2023.03.31.07.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:24:25 -0700 (PDT)
Message-ID: <88a4808c-5f45-cb07-83bb-039f9d832b5b@linaro.org>
Date:   Fri, 31 Mar 2023 09:24:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 00/26] Drivers for gunyah hypervisor
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-1-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 7:06 PM, Elliot Berman wrote:
> Gunyah is a Type-1 hypervisor independent of any
> high-level OS kernel, and runs in a higher CPU privilege level. It does
> not depend on any lower-privileged OS kernel/code for its core
> functionality. This increases its security and can support a much smaller
> trusted computing base than a Type-2 hypervisor.
> 
> Gunyah is an open source hypervisor. The source repo is available at
> https://github.com/quic/gunyah-hypervisor.

I've done a pretty detailed review again, and got further along
than I did last time.  Things are definitely looking better, but
I have found some bugs that need to be addressed.

I also make a lot of comments about grouping certain sets of
definitions into enumerated types.  Also I tend to notice when
things aren't done consistently, and I mention that a lot.

There are silly suggestions all over about alignment of
things--these are mainly to make the code look prettier,
though that's a matter of opinion.

I still prefer having lines generally closer to 80 columns
wide, but I've already mentioned that...

I really focused on the code, and not the documentation.
In fact I didn't even pay much attention to your patch
headers either.  I did not review the SCM calls yet.

So in summary I have not reviewed patches 1, 2, 16, 17,
and 26.  I try to look at everything in my next review,
which I hope will be final (or very close).

					-Alex

> The diagram below shows the architecture.
> 
> ::
> 
>           VM A                    VM B
>       +-----+ +-----+  | +-----+ +-----+ +-----+
>       |     | |     |  | |     | |     | |     |
>   EL0 | APP | | APP |  | | APP | | APP | | APP |
>       |     | |     |  | |     | |     | |     |
>       +-----+ +-----+  | +-----+ +-----+ +-----+
>   ---------------------|-------------------------
>       +--------------+ | +----------------------+
>       |              | | |                      |
>   EL1 | Linux Kernel | | |Linux kernel/Other OS |   ...
>       |              | | |                      |
>       +--------------+ | +----------------------+
>   --------hvc/smc------|------hvc/smc------------
>       +----------------------------------------+
>       |                                        |
>   EL2 |            Gunyah Hypervisor           |
>       |                                        |
>       +----------------------------------------+
> 
> Gunyah provides these following features.
> 

. . .

