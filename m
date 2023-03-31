Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722E26D2266
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjCaOZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjCaOZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:25:18 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700D20303
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:25:04 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j2so4556231ila.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272704; x=1682864704;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u2DKRWokxdgFHFKK9gKH+IOprEI8thh0AGrCKbdGi4w=;
        b=RbnLRCaLKbxYJSXuHmiUbzKL6mD8U9zonSzHyaUaRB1/V3UHPD4gtQKsl6tSVwqIN9
         zLvgDzW1ScNkMDyYujTOmBiyu7vtEpgCXWO272QdHB3GyVHyLS2YWk0vvydEH53kzGgS
         13UVDi9Vo0e6ZaeKk3++OQ3JOAtO5JnL6AbEFVEeF0f2jb1RHcmYQrtkbmO644PzjADF
         ObwM41wE3xqkvkZ/F137cceCZhm0awNWBo+LbF053a0HeBlYZf7ix6o7S7u46mq3ODv7
         DpZTvebnlkZoIlcEks5oYO0uUOzOMl0chxoNwbGyzFm9Let7zvln3QUlFCMDK6UXzUdq
         mwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272704; x=1682864704;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2DKRWokxdgFHFKK9gKH+IOprEI8thh0AGrCKbdGi4w=;
        b=g9BNsb6UB5v/fii6GPMXAjN/0ZvjnlF0qx92Gri85BlQmiIX1cadq4evbFmAxsQv2V
         zr99L3+0neVBPiRHHMDlfN2x2Sp5we3uvGTdAa9ZoZpt3Aa0O7GSEGKtT5dHCasOer6f
         OFifmroA1ilUv4VFTUHEydbiEFrP2Pl9hwZWqZJkD2MRtgSaEmKT+8mqYRHUsD+FkHhC
         PAxwMu4cV98tWx7Y8T6zPtFDnJizzvJMZN7RRrOMx/OyFKJtZSBQ9PkAerLzTbNU/npR
         sBt7dhVS+BIXgUg0F8s6QXCDtSgiGAXWZVWFL7zJQ1qyi/F8bGqfbw0zAbFqhmjSE/3O
         xZmA==
X-Gm-Message-State: AAQBX9dQdPyBzKBKKpdaW2vJz/xS5T38u1xeGB4Wh6O5SeZGTkqHZQiE
        1OEijOdzEMVKEP8k7jLzPW5VWw==
X-Google-Smtp-Source: AKy350aDhKvOw9mwCosjWKdjOjXLs4ZIU5w9nwygH8V2n8hkd1yNtA2VKND5cjez00k1fpPbkLu72Q==
X-Received: by 2002:a92:907:0:b0:326:2d3a:c770 with SMTP id y7-20020a920907000000b003262d3ac770mr6423077ilg.26.1680272704208;
        Fri, 31 Mar 2023 07:25:04 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id m36-20020a056638272400b003c4f7dd7554sm669484jav.5.2023.03.31.07.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:25:03 -0700 (PDT)
Message-ID: <947e17c0-c157-148c-035b-f9578466a6e1@linaro.org>
Date:   Fri, 31 Mar 2023 09:25:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 06/26] virt: gunyah: msgq: Add hypercalls to send and
 receive messages
To:     Elliot Berman <quic_eberman@quicinc.com>,
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
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-7-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-7-quic_eberman@quicinc.com>
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
> Add hypercalls to send and receive messages on a Gunyah message queue.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

One comment below.	-Alex

> ---
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

The tx_flags argument--being a mask of some kind--should be unsigned,
and perhaps 64 bits wide.  The only caller passes a u64 value here
(which would technically be truncated).

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

