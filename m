Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C36A1439
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBXAPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBXAPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:15:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E58446153
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:15:13 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so1060299pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnsL+pGfqbSaj40dlXSygHui8rkzCXGh8NQYT1OtVjc=;
        b=MEMyJaQw67L5JtHF1XZ61OYT6n+VfEM4YMA80P0tKRQfHyK6eOM2UnebOQdeamv+xT
         yz2NB/ixM+eJktRajoBHzOa6L7dT2+CXtbR/pOqZGAHeq9z5a9z03YJ341hIx6xxxeoL
         h+IutQs/R34YpzIUCI2D62wQKZ8qveteFtJOf6WvLi4PawfWnxcu/s6MoTWhsJ6bIVkm
         JWB0JPg9ASJdw1+MZYPjQC5D3pD5S12YsD7Dk5SRBebuwl/9Wk1g90CacKGm/yWcAqQJ
         p+28peXucCwPRkbo6f4iUAB4JqxQqU4Q+iKlqjmi0Qg+j0xJNiPRzKPqGYm+Rfx4E0g5
         huKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnsL+pGfqbSaj40dlXSygHui8rkzCXGh8NQYT1OtVjc=;
        b=EVPH+fQF2e1Z9Bc5HE2olEROF2HBoOgkNnfKAzAvAHL8rgIxfUeh9JBxLRT2rnRAL3
         VRrzyhibwOZVOOTYuVg3Oxv7aaOzD4PJqepZmc/VtY0rIyBNNMsIPjossn6qhaWAOw0Z
         S4kj4i9mbvCfbh7tc8+vF78DpOhHB11qRpFhBt5Lenv06G6iI6gA6hYQjykgfpgL4aoC
         MUuyKR5AwegZiMf5/yeqvhSClNNf6a/lm15ffjBp9fUe78OjzRCm+2NN35Z0V8PGg/cJ
         aOwINu605SDV+lgJDNcWaKtB9GUytRmBdg2P5lREWhp6980b4lS40X/n9Z/tAI5bNjlq
         QR9A==
X-Gm-Message-State: AO0yUKXVQ69yuj0eou+i/T9lv04qZc37b6/EW9Ma1IFnp/+ggnHhgHBd
        JiGp5OXrAyWfRsBaenTQ68nSpw==
X-Google-Smtp-Source: AK7set+H1Oed36cehxC8KiJPC3s0ckOpweO6g64c5qWByIUOeqKQ8bas15lSHf/5Y113qatq+WyDfg==
X-Received: by 2002:a05:6a20:7d99:b0:cc:4db1:12fc with SMTP id v25-20020a056a207d9900b000cc4db112fcmr2303043pzj.46.1677197712594;
        Thu, 23 Feb 2023 16:15:12 -0800 (PST)
Received: from [10.211.55.3] (c-73-221-130-71.hsd1.wa.comcast.net. [73.221.130.71])
        by smtp.gmail.com with ESMTPSA id q18-20020a62e112000000b005a7ae8b3a09sm3528645pfh.32.2023.02.23.16.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 16:15:12 -0800 (PST)
Message-ID: <d4cdae93-a003-d07f-3074-3542a231747b@linaro.org>
Date:   Thu, 23 Feb 2023 18:15:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 06/26] virt: gunyah: msgq: Add hypercalls to send and
 receive messages
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212303.3307536-1-quic_eberman@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <20230214212303.3307536-1-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 3:23 PM, Elliot Berman wrote:
> Add hypercalls to send and receive messages on a Gunyah message queue.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   arch/arm64/gunyah/gunyah_hypercall.c | 32 ++++++++++++++++++++++++++++
>   include/linux/gunyah.h               |  7 ++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
> index f30d06ee80cf..2ca9ab098ff6 100644
> --- a/arch/arm64/gunyah/gunyah_hypercall.c
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -38,6 +38,8 @@ EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
>   						   fn)
>   
>   #define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
> +#define GH_HYPERCALL_MSGQ_SEND			GH_HYPERCALL(0x801B)
> +#define GH_HYPERCALL_MSGQ_RECV			GH_HYPERCALL(0x801C)
>   
>   /**
>    * gh_hypercall_hyp_identify() - Returns build information and feature flags
> @@ -57,5 +59,35 @@ void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identi
>   }
>   EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
>   
> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags,
> +					bool *ready)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_SEND, capid, size, buff, tx_flags, 0, &res);
> +
> +	if (res.a0 == GH_ERROR_OK)
> +		*ready = res.a1;
> +
> +	return res.a0;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_msgq_send);
> +
> +enum gh_error gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size,
> +					bool *ready)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_MSGQ_RECV, capid, buff, size, 0, &res);
> +
> +	if (res.a0 == GH_ERROR_OK) {
> +		*recv_size = res.a1;

Is there any chance the 64-bit size is incompatible
with size_t?  (Too big?)

> +		*ready = res.a2;

		*ready = !!res.a2;

> +	}
> +
> +	return res.a0;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_msgq_recv);
> +
>   MODULE_LICENSE("GPL");
>   MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 3fef2854c5e1..cb6df4eec5c2 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -112,4 +112,11 @@ struct gh_hypercall_hyp_identify_resp {
>   
>   void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
>   
> +#define GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH		BIT(0)
> +
> +enum gh_error gh_hypercall_msgq_send(u64 capid, size_t size, uintptr_t buff, int tx_flags,
> +					bool *ready);

Why uintptr_t?  Why not just pass a host pointer (void *)
and do whatever conversion is necessary inside the function?

					-Alex

> +enum gh_error gh_hypercall_msgq_recv(u64 capid, uintptr_t buff, size_t size, size_t *recv_size,
> +					bool *ready);
> +
>   #endif

