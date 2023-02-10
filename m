Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311B5691E22
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjBJLXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjBJLXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:23:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262776C7E5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:23:20 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so6031979wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xI9gYztVh8CUauySkPThsaIJ2I1/Wnh8PrWXbxjNzZ0=;
        b=NRHJCgKQ2tlzZWl8sU4Ssukk4rUijhHHujOK7KFzcVRGnkKk/4V/UhLudq5HHKstUS
         219eo6DzkvmGzmoQuv4mjeip6BcEcBe8Y97VSeJ+/OHpofacv4dXl6scozKw3Xag6IXG
         sKF4y1hbrbQlG2V+P9uVn0Q2DWddNC94dwi70kmO6LGp87Fvysh/RWzZQMFe1TD+203C
         0jHwbB4fgeMueG/VLFiur5ERomy/zCIUoHQbjcMVfcBD4ljzcO5yXE8MMl7Eo7NyuPRQ
         jFUwF2GlprRII38nIlnalovb4+dKRzBQaOOoh8mbbipqcpkghTb87HG+jPq6E16dZQWQ
         EXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xI9gYztVh8CUauySkPThsaIJ2I1/Wnh8PrWXbxjNzZ0=;
        b=2fMa/I+IZHvmzE8i0vq6Q6oOjRjxf3K+bm3/b/haHbj+bDR1KHP4I2+Z9GsPjmauHz
         kEPfd20/2Lee52TOW+3kGoO29AAzp+z3iCr2gp3nFU4fNbMnLvN7B8cTPeFgNQikkat9
         F1qhigWINTQ76ytoZBA5956HgJ2rJVkyQZsFcQHe6MAfvKUAocwshlf8jfhwPpQMj4fU
         TrccMZr6MMJu328n0sNIWXVvmlKORrjhUehlzMBbWuQzt+PRu9m8/XYB2VPqDeff/aeP
         tvltp/R5/XOpmzu+8T7xQSBdtfv3rG56MtDs/D1ydxpvYBfTMpwlSToFNmGHgmAfUMD8
         dymA==
X-Gm-Message-State: AO0yUKWb7rZMt8ujGvgCJTSjjwiMSyHuSQTJp8v/XfHpo3HchHdgq9By
        q30A3DQGnFUlQGUIg6eU96w+IA==
X-Google-Smtp-Source: AK7set+legodxv6KBlkbkD44DJSD+6EChFSzBsO0IZtYTmpH0QN9n6LRbkTpKJ8iSAhd7hSblH2b8A==
X-Received: by 2002:a05:600c:4393:b0:3de:1d31:1043 with SMTP id e19-20020a05600c439300b003de1d311043mr12023706wmn.21.1676028198740;
        Fri, 10 Feb 2023 03:23:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003dc48a2f997sm7816142wmc.17.2023.02.10.03.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:23:18 -0800 (PST)
Message-ID: <f8727f1c-c0e3-f14a-8d4d-8d0f294e480a@linaro.org>
Date:   Fri, 10 Feb 2023 12:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 8/8] dt-bindings: remoteproc: qcom: sc7280-adsp-pil:
 Add missing properties
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org,
        quic_mohs@quicinc.com
References: <1675700201-12890-1-git-send-email-quic_srivasam@quicinc.com>
 <1675700201-12890-9-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1675700201-12890-9-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 17:16, Srinivasa Rao Mandadapu wrote:
> Add reg-names and power-domain-names for remoteproc ADSP pheripheral

typo: peripheral

> loader. Add firmware-name property to distinguish and load different
> firmware binaries of various vendors.
> Change qcom,halt-regs property phandle to tcsr_1 from tcsr_mutex.
> Also add required-opps property and change power domain from LCX to CX,
> which is actual PD to be controlled, for setting appropriate
> performance state.
> This is to make compatible with remoteproc ADSP PIL driver and
> latest device tree changes.
> 
> Fixes: 8490a99586ab ("dt-bindings: remoteproc: qcom: Add SC7280 ADSP support")
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 30 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> index 94ca7a0..7addc7d 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> @@ -23,6 +23,11 @@ properties:
>        - description: qdsp6ss register
>        - description: efuse q6ss register
>  
> +  reg-names:
> +    items:
> +      - const: qdsp6ss_base
> +      - const: lpass_efuse

So your commit adding the bindings:
https://lore.kernel.org/all/1664368073-13659-2-git-send-email-quic_srivasam@quicinc.com/

was already incomplete because the same patchset added undocumented
properties.

I have no clue what is happening with AudioReach sound/ADSP code - it's
like random set of changes here and there, without coordination. Drivers
come without bindings, DTS comes before bindings...

Is your DTS in this patches matching this binding? If so, usage cannot
be before the binding is introduced.

Best regards,
Krzysztof

