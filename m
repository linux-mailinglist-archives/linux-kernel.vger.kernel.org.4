Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB96F6ED069
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjDXOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjDXOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:38:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08449D1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:38:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so33912634a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682347099; x=1684939099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UD6WNsJ81KdluYPWiuoh5gHquWj5SMJKiIoyl574A0=;
        b=nmwdn06+Dxx+8kaczPZ+9PMrA2HAuNPq93ZwXXLdIFTW+W7oFpNj4xUAy5px5rc45b
         w3DOUB3VJjkAerFl/FgUAvcKqFvXYvWtiny5o64tbH9kmS4taYQCRYr+H7jHYiWhHnNK
         jVD8CSIf9euhFl+z2S8uDqMO3kVDljswhcGA0fQ7+6uj3GiqQIjSej+hxw6L6qWlKF+g
         WRWQJFmQqJFo583tJSB7xoA3Cw9l0/jBMhneU1saHten69vSED0/2159q+y2x+BsErAn
         IAk+wbXUij09gLHey5yHP0FwrNKJIaFCtscCxnJ0sPHQ9iqma1mboR3cNQHD/I71pPJK
         pF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347099; x=1684939099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UD6WNsJ81KdluYPWiuoh5gHquWj5SMJKiIoyl574A0=;
        b=ggUp4hEhaqqGq7Z/7LcI0AdFqhKNpZaP5b9mdTBM8+fBmDI1y+97/uZ9pAjzvUcYgM
         utMSKaRDsW2CKDfPtm+Wh40VSXt2Be8jpPE0ktDCpsA5iraVec0nmJNEk2KsWAxFUr0u
         MVTW64V1i9NeuW/ZOB6GKPwqkUwUJufigeCai1cjesgT7CXD94bT7hW6hqJuPejHcinS
         C+urQOvX0ALvPcnKXAoRU75P+JgGp70ANveeFE4uH5X8XffXnXjewzW6NfQOWkoK/oD2
         2ffwUfnb8Too5wrkna6nYgs0B/MEmGqoULW44SgUqSqC7KQYq3D5q0U1kLxlnKHUbKuM
         OkbQ==
X-Gm-Message-State: AAQBX9dfo/EkezBQ/aC1lq41jX0kLsaKBq4JO8I6LFESvwhRiDQonaGq
        zrw8Vf4LaX+WHXm0fQxxMNoXeg==
X-Google-Smtp-Source: AKy350ZtVE2S48g70+3ucGJmrlrqjqFO/shAOESwAkaxb9KtuxS+i+Qsth44hiMLaANH/O/30MoKUQ==
X-Received: by 2002:a05:6402:4413:b0:4af:7bdc:188e with SMTP id y19-20020a056402441300b004af7bdc188emr17266897eda.16.1682347098840;
        Mon, 24 Apr 2023 07:38:18 -0700 (PDT)
Received: from [10.105.146.163] ([88.128.92.195])
        by smtp.gmail.com with ESMTPSA id t22-20020a056402021600b00509d1c6dcefsm2222139edv.13.2023.04.24.07.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:38:18 -0700 (PDT)
Message-ID: <3f2a4979-2219-d1ed-ac48-75fbb0bce80d@linaro.org>
Date:   Mon, 24 Apr 2023 16:38:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 1/3] dt-bindings: hwmon: esm: Add ESM support
 for TI K3 devices
Content-Language: en-US
To:     Neha Malcom Francis <n-francis@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, kristo@kernel.org
References: <20230424105011.70674-1-n-francis@ti.com>
 <20230424105011.70674-2-n-francis@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424105011.70674-2-n-francis@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 12:50, Neha Malcom Francis wrote:
> Document the binding for TI K3 ESM (Error Signaling Module) block.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  .../bindings/hwmon/ti,j721e-esm.yaml          | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,j721e-esm.yaml


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

