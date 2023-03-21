Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7E6C363B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjCUPuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCUPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:50:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C7B4E5E8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:49:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o12so61476948edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679413779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qVyJMxLLt9V1BcoFqKd8pjnJHsSXtyBIzuBrMRPzTYg=;
        b=Z4mXDYQzwCqGi3T12yWoKMGSngcKpTRClrvVz9eAZISdwtm5ARW3pIZ5ddFP3xCzvV
         A4PeFHzEOSviauwirR/jzNaDTbK7oRVXMHvGbbI0YE9bQqMrtaZuQyd0p9Zte/w+ItQ7
         q0dNPJL6QkQZVlws9vTIvbYngjkpuoq1YftqCzOjphEz2VVXydhaqRvAKVp9iYruIMbn
         qicplBbMtQGSbt+pwuMIowR6H6+SXRBpzCeaTR9hilEKtCTMMJjJWHBrHTIFsx1/yS9H
         029K47ex37CaSHrPNZtL504KOWZUZFkh5N/8UQX4Xi9RbTN/THWIeh4/49nM0E02ugtU
         ecKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVyJMxLLt9V1BcoFqKd8pjnJHsSXtyBIzuBrMRPzTYg=;
        b=CQA+FNCnKlygMDZZUMTpRdzzJySbqvRSEBu8faTR67nJjyFNYqwrnVkFcTWs9VGz8N
         DhOb5TA6EHc5Lkm5971kbEUG9baAlaiaryn4LtNzGpArcTIv58/tsQ66hrrX+NTd7a0C
         l8AEXTMAmsxF7efmVAXZ4q03ohn9opUC701jptCmnZ60N0HgqCg3sqOVvbwe/V8f7HjH
         26oVcUdENNbLzX8Ol90lqYJy53hdkM5GbsvdorhR4eB/6loj4WptvrwHB+1Snqr3QNZO
         1YUNjbQIvnLWbSg9pY5WUtmVVBW9gZe5Uv/B67R6G+syKB+o9/o+u/eECPGBDx8Nnsnf
         Qa6w==
X-Gm-Message-State: AO0yUKUDbYLEhQAozkxRRy01bfS6zjcvIGQzEA/l5/X4NWGZn3Z+P91T
        UusVjHmXdWe9LB3lLWskU9mrVg==
X-Google-Smtp-Source: AK7set/v7EtXCG8c8bpthQcAsWwXbRQyN2L/SFPdqduXrbjXnxoJ3VSTiW1XBy8gfJysBk30r8vCYw==
X-Received: by 2002:a17:906:9bd8:b0:879:ab3:93d1 with SMTP id de24-20020a1709069bd800b008790ab393d1mr2982425ejc.4.1679413779316;
        Tue, 21 Mar 2023 08:49:39 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k6-20020a1709063e0600b00930aa50372csm5977851eji.43.2023.03.21.08.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:49:38 -0700 (PDT)
Message-ID: <55f401bf-5b52-bcf5-bab5-a73d3457c470@linaro.org>
Date:   Tue, 21 Mar 2023 15:49:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 06/26] virt: gunyah: msgq: Add hypercalls to send and
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
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-7-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230304010632.2127470-7-quic_eberman@quicinc.com>
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



On 04/03/2023 01:06, Elliot Berman wrote:
> Add hypercalls to send and receive messages on a Gunyah message queue.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   arch/arm64/gunyah/gunyah_hypercall.c | 31 ++++++++++++++++++++++++++++
>   include/linux/gunyah.h               |  6 ++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
> index 0d14e767e2c8..3420d8f286a9 100644
> --- a/arch/arm64/gunyah/gunyah_hypercall.c
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -41,6 +41,8 @@ EXPORT_SYMBOL_GPL(arch_is_gh_guest);
>   						   fn)
>   
>   #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
> +#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
> +#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
>   
>   /**
>    * gh_hypercall_hyp_identify() - Returns build information and feature flags
> @@ -60,5 +62,34 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
>   }
>   EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
>   
> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, int tx_flags, bool *ready)
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
> index bd080e3a6fc9..18cfbf5ee48b 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -108,4 +108,10 @@ struct gh_hypercall_hyp_identify_resp {
>   
>   void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
>   
> +#define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
> +
> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, void *buff, int tx_flags, bool *ready);
> +enum gh_error gh_hypercall_msgq_recv(u64 capid, void *buff, size_t size, size_t *recv_size,
> +					bool *ready);
> +
>   #endif
