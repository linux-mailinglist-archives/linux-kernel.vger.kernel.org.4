Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568FC6F69E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjEDL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjEDL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:26:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361BB59C6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:26:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so540399a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683199608; x=1685791608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAm0Ms50RBuBQUWsCH7mnryZ0Ty/pL6QPQW4ux5OXOc=;
        b=jRUeKBTv8reztpv61FqkPmZytNu1CYEVw/5vnkfOVUeU1o6Donl4SmGPXGLUxBpMj4
         7ScpHla2J1uUjs50HNs5N6fJpt5yc4WFOgooj5gxPR6zB2jw4LLBqcHvY/cKbTEs9yQ1
         v+cxEhecVPsShzhlzw1MAzGOambO/DT0SW0m3NPurOCaGDU2txwQKQxrGtQhVFRl0GFR
         cAR9teT4SUScVl45XQEdDLAQjtS8hQoh3jem27xQrC1cv3VHFCH4qkBs5ZM2K3FMo704
         0fo5ZQIrqDjYI+IUDcYHKbHz/hWQDD89gGDqNXGVrpb1wn9B8JUsvlrFAX75uTgZMS1M
         GjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683199608; x=1685791608;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAm0Ms50RBuBQUWsCH7mnryZ0Ty/pL6QPQW4ux5OXOc=;
        b=bQn8nsMJkZ/NZGg0LaxxVjFCsYZfpT4t5ON+yZgSNtI6vRrkqaFj8OMXDHOtXMv2ra
         6TTMDYNOLRJL70HzXIwUG61UGXC2i27SOxaLI030VedOwLE7C1RHk6Rp34WdLA1ruEdM
         oJM06At3zJpuru02aCTjCidaJa80TnQx2erRis0bGA7t1huUNV84ZXPostTGLvuXmxmj
         DGQqVBPyoLxSPIR96ou/08u5U3UGNNskQj4osj6J2PqiAaRseUTrU4AasH7B01JpQldM
         G6AsThAMKr3WISulVc09Z0CBbKSR/j5LTFwngkLPnWMuD8ktLa1uw+Rub7q8RpojAr2Q
         jVKg==
X-Gm-Message-State: AC+VfDwVg+b7cs11OWPUyfKc/5Pkk1eF8xx3MBy3ZLeuAfnAZTGm2bzB
        duU7NuvlJqG0kYAnI0e+HRCMQA==
X-Google-Smtp-Source: ACHHUZ5yK2lt/IMYfyS93awRoHs7nxXWC9mxqAyC9zaEYDSGdeRLwFZz8Pe8r/MHRR7wkuU3mMylDQ==
X-Received: by 2002:a17:907:268a:b0:94f:2020:b5fb with SMTP id bn10-20020a170907268a00b0094f2020b5fbmr5629405ejc.27.1683199608642;
        Thu, 04 May 2023 04:26:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id ml12-20020a170906cc0c00b009659c23e78fsm1113658ejb.215.2023.05.04.04.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 04:26:48 -0700 (PDT)
Message-ID: <a7f0b4e6-0594-024a-b416-fe778eee16fe@linaro.org>
Date:   Thu, 4 May 2023 13:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 11/18] arm64: dts: qcom: sm8450: Add Qualcomm ramoops
 minidump node
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-12-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1683133352-10046-12-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 19:02, Mukesh Ojha wrote:
> This enable dynamic reserve memory for Qualcomm ramoops device,
> Which will used to save ramoops frontend data and this region
> gets dumped on crash via Qualcomm's minidump infrastructure.
> qcom_pstore_minidump is the associated driver for this node.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 595533a..92d023f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -614,6 +614,17 @@
>  			reg = <0x0 0xed900000 0x0 0x3b00000>;
>  			no-map;
>  		};
> +
> +		qcom_ramoops_md_region:qcom_ramoops_md {

No underscores in node names. Didn't we talk about this?

Best regards,
Krzysztof

