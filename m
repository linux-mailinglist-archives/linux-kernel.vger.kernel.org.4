Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0560E988
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiJZTrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiJZTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:47:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F227E22DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:47:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s24so13269496ljs.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJjRsujDl/3v+9Mf/eSBWkfplDNIchatoDdNLqZcg1w=;
        b=RhCNpnDflZSD5XHtPqzpeSJCPwFGlzWnDqMozcUdrOPtYCP9AE4ouqssPyrSh9lzG9
         3QRKJf6pRNYx/wUp0OI5LVpSIseeLcvvpriFJS53HP11SH8GQ6q9vczrrVykiXJZJG/Q
         W7qzYAaZJznwkkj7vHwVDLr6Wkbvl+WG6f1m889cBG8MhQqcwjprcx09r04HxP+Zo4nF
         ut+axCQ8T4q6i93I36aid/D5/SchNdcdXLFbpPfj4GVFkaMkLv8YAUK/3j4GDxwQUyue
         Rxix78k3GKPg1isz0CpMwfV66KvXkI26KsMoNI+DkYfGhFS2zS93CJVA0Ps4DlXzX7fB
         jv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJjRsujDl/3v+9Mf/eSBWkfplDNIchatoDdNLqZcg1w=;
        b=znyt3BClet/YE7k/NaTaVA5BETiHYtCtidexpORslti1uWPstXERwJpF9g3G+nI2jK
         jJONvpaVBQ33GRqv/QwxUW/GekO/j6Smc/nu/ddoBj/+Sp3SQHjP2UXQE9Y55QTWXORU
         T8hfWu+FoiSebWL7nKw2+t32whcnYSszG1XDdEY9KrXitn+SwDpZHVzyO4WmpHaT8n+o
         bDHEzCQKivR7bNf5aX7CykZqLkXJuxNpQfDx43ykua27mX8IFmtfOLBbIOPpsv1tEmQQ
         Z8uJ2Ltq0KsAYor+UUIWRZ7gQjbQb8iF/FCQ8Z/yQb2UnYTaVlNJlYTbswxqAakevbSj
         BN1Q==
X-Gm-Message-State: ACrzQf1gx1sZnw+MZuxjqU5iXMXfxwNNp6Uz+ym6lB4RCjewbBQmflBM
        eeHDtLSHVdYsNTsaMdFQfkY3kA==
X-Google-Smtp-Source: AMsMyM7U2yFByXQb4uotUhiQB0V/tO2+T+0Nol8A0/pMBDv1DjnXOhYEv4jUgj9ioEH6sA3z+XGReg==
X-Received: by 2002:a05:651c:a12:b0:26f:db13:4bd8 with SMTP id k18-20020a05651c0a1200b0026fdb134bd8mr17533154ljq.354.1666813622554;
        Wed, 26 Oct 2022 12:47:02 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id h2-20020a05651211c200b004acd6e441cesm942826lfr.205.2022.10.26.12.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:47:02 -0700 (PDT)
Message-ID: <71c3fdf1-b03d-391d-a731-de8a5a66fdca@linaro.org>
Date:   Wed, 26 Oct 2022 22:47:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 03/21] gunyah: Common types and error codes for Gunyah
 hypercalls
Content-Language: en-GB
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-4-quic_eberman@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221026185846.3983888-4-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 21:58, Elliot Berman wrote:
> Add architecture-independent standard error codes, types, and macros for
> Gunyah hypercalls.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   MAINTAINERS            |  1 +
>   include/linux/gunyah.h | 74 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
>   create mode 100644 include/linux/gunyah.h

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

