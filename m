Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C935E72324A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjFEVcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjFEVcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:32:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A104D9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:32:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso20952195e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686000718; x=1688592718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdtlZbGAkXgs/Vgno8yQ9QNGBZimOlkL72Nu0Bg8k+Y=;
        b=hCpDQdAOQAsN0KrmTo4NPJi5jsjUcQ+ZKvey4LhxLjTNk8K1cdJ0Z+RZywiaNMkFE1
         6rWujBvNtD2W+MkBpxkbBUfynFPkShIEKVzP0QegqWVv+Mh+fbUIcMQTbwAbwn+18NGh
         gnVAXi6wef8KV+4Se9cv9OPRakbRjW16JvTXvya980pPL9Lv77ir2UCbVuVYh9S0inyS
         ckDvvBpsUbalZvqE+Pda/p6R/dL1iTcn8DkwqbWBw3/74MEKd5RlSFhOAU2MerTmkR6l
         HGz35+7emchd0ltBHotukD8KwezuzeQ37pzewa8QDcauW3Gwc9V3IfdiZDyHRwSklnxn
         5WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686000718; x=1688592718;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdtlZbGAkXgs/Vgno8yQ9QNGBZimOlkL72Nu0Bg8k+Y=;
        b=XQUSAbJ7dC4PdTF8mo+H6zs9UFPr+gHDgFhuG7Ia2M1ih2U/esrTJmdKOC5RUeUwtt
         oFztQd+nKaqm58s8VUocbnTyKDxmZk9IpQPXOFLspY4Ko5MvopE9XjnktQs/Mo6e8/Lk
         e2/tXx4s9UsS6V/d91fjNE1QUb8Yd/rsUrUPvKwIF7PIgMIlKkFmhEwTRR++oUWd/ZeK
         FeqT7+r2QRufkzUjTTG2nD9R2SiOUZZs2aS4nqHMhhUPDn4HJQ3XJwnRq3yXFHzkYkwU
         SzRK26XxLeMWxojq5vOh2tWj6YVO72tkpDbVOVhV37jWVM1fMZZjOYLZ8deLjmTnmb7z
         XrdA==
X-Gm-Message-State: AC+VfDyKcxjzM4FeILXbvg1TrSF/gd2q3ahNWkbE32D4xpik5xnH2d5b
        WdyNEfgdh/T1oRCqXlogAwQzEg==
X-Google-Smtp-Source: ACHHUZ6lWvMTq3ozM+uLT+gXd8KyCXMiLT1Z1YrPpbDygdUMGqAd2VxYHLeEV6vZV5cmdGfCW+uIAw==
X-Received: by 2002:a1c:4c1a:0:b0:3f6:7fb:b60e with SMTP id z26-20020a1c4c1a000000b003f607fbb60emr300135wmf.35.1686000718695;
        Mon, 05 Jun 2023 14:31:58 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id g7-20020a5d6987000000b0030632833e74sm10760624wru.11.2023.06.05.14.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 14:31:57 -0700 (PDT)
Message-ID: <32754b3a-ccdb-f3cf-cbc7-f3590cc86cbf@linaro.org>
Date:   Mon, 5 Jun 2023 22:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 04/24] virt: gunyah: msgq: Add hypercalls to send and
 receive messages
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-5-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230509204801.2824351-5-quic_eberman@quicinc.com>
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



On 09/05/2023 21:47, Elliot Berman wrote:
> Add hypercalls to send and receive messages on a Gunyah message queue.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   arch/arm64/gunyah/gunyah_hypercall.c | 31 ++++++++++++++++++++++++++++
>   include/linux/gunyah.h               |  6 ++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
> index 2166d5dab869..2b2a63e9b9e5 100644
> --- a/arch/arm64/gunyah/gunyah_hypercall.c
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -33,6 +33,8 @@ EXPORT_SYMBOL_GPL(arch_is_gh_guest);
>   						   fn)
>   
>   #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
> +#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
> +#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
>   
>   /**
>    * gh_hypercall_hyp_identify() - Returns build information and feature flags
> @@ -52,5 +54,34 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
>   }
>   EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
>   
> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, u64 tx_flags, bool *ready)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_SEND, capid, size, (uintptr_t)buff, tx_flags, 0, &res);
> +
> +	if (res.a0 == GH_ERROR_OK)
> +		*ready = !!res.a1;
> +
> +	return res.a0;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_msgq_send);
> +
> +enum gh_error gh_hypercall_msgq_recv(u64 capid, void *buff, size_t size, size_t *recv_size,
> +					bool *ready)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_RECV, capid, (uintptr_t)buff, size, 0, &res);
> +
> +	if (res.a0 == GH_ERROR_OK) {
> +		*recv_size = res.a1;
> +		*ready = !!res.a2;
> +	}
> +
> +	return res.a0;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
> +
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 6b36cf4787ef..01a6f202d037 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -111,4 +111,10 @@ static inline u16 gh_api_version(const struct gh_hypercall_hyp_identify_resp *gh
>   
>   void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
>   
> +#define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
> +
> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, u64 tx_flags, bool *ready);
> +enum gh_error gh_hypercall_msgq_recv(u64 capid, void *buff, size_t size, size_t *recv_size,
> +					bool *ready);
> +
>   #endif
