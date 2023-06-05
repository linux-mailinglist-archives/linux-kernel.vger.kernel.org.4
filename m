Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8373972301A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjFETrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjFETrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:47:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7833106
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:47:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33bbc91dcb7so26792485ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994459; x=1688586459;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dcbJythIts0cc1fwWPeCEyFxBgVskDL8p0CqCKAVuC4=;
        b=HujNsIzVmnL4LWFyMOxiap2Os2d1sMZjg0ElZcdznLxfye470Ws7kdmFle1fHPXj8F
         eNpUtyLvsqUEg2Rvml98si8zE86dF6KKzyoBUTIM/REFv+J1BqlIHQBqOuxayDQpmoGo
         qvHPtgaqw77cqtq0/t6CI3wvg2d5KISEH5JTpNuCtlymd9pdUshGeFBbc3fOJje4Fy9h
         Fls13CO3scJjq56MWlxKEHgfRBzw4B4QmYptGYINYTQuUwICUc2tsGOVg+5VrH5dCr39
         SkiZQyxnxFnWVflcV0IGIg4JR53NXwmAocMPe7ylQl1I3SKFdpxX67EBZPZLrQDM2ZMk
         2Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994459; x=1688586459;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcbJythIts0cc1fwWPeCEyFxBgVskDL8p0CqCKAVuC4=;
        b=Vvqi0WeJwd2ieXK48HuAPOBPL0Ha45VXQbrGPx02/8KouTsZmKl0Flf1PeZplMi3zb
         uTb+hl/oCstx2JcGlrolfdIkk8dBakvsOMWJu/C+bKh4SWa9h2KhcYTLeAWN7l8ITSp8
         iZ0kHMVSOwpQwLj71kfz8oj6eioz5KJxCTD6zw37eOvLFDIBAC2mbrTJ/pJ3N3m0u8S+
         U7jgcEMsk6wePcx0L44Q7NRoOJY40EodIB5Pn/rQ3P7UFGXgvG3cl8CwqrqizUqdC9hW
         rZOvJ4NZg4Z92A6335yP3kag0vF0wYuXjTZzj221Wc/atRX3oNJTmNd6/W+RUZ3aAdP1
         xzmw==
X-Gm-Message-State: AC+VfDxdq9JCVNz3D0mKQ5k6aCm5zpXtd4tQf/3nwM1kJZqCmVA2BgTY
        RXd9jdr1h0KAtwsEbFdJ7AsOIA==
X-Google-Smtp-Source: ACHHUZ4uyBenlMorqz51x6ZjxUg87PZ+PunoQonsP28HyrxBRkvYwflwlB1KDimnYtyVfP2QCcz+VA==
X-Received: by 2002:a92:cd09:0:b0:33a:efd3:add3 with SMTP id z9-20020a92cd09000000b0033aefd3add3mr86093iln.14.1685994459287;
        Mon, 05 Jun 2023 12:47:39 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id z4-20020a92cd04000000b003248469e5easm2523401iln.43.2023.06.05.12.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:47:38 -0700 (PDT)
Message-ID: <94dac3b3-79b1-125f-31a9-8d19cae23773@linaro.org>
Date:   Mon, 5 Jun 2023 14:47:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 04/24] virt: gunyah: msgq: Add hypercalls to send and
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
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-5-quic_eberman@quicinc.com>
Content-Language: en-US
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

On 5/9/23 3:47 PM, Elliot Berman wrote:
> Add hypercalls to send and receive messages on a Gunyah message queue.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I continue to dislike the long lines, but aside from that this
looks fine.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
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

