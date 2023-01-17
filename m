Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D852B66DC60
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjAQL25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbjAQL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:28:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B2D2D177
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:28:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j17so3441548wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7QySS8sX+rCfEVcFiwHdK87drcPLIRv7jTR3Ef+m7U=;
        b=GhTYI1bo1NtfTix5Cyo757ae2aRDocMqQr9D60ev6QWvCm4a5eV+2io6PjGmnMDZEk
         PWZsbPnsy8EBab75YCi86Fg8/DokN6jhraGvl9gn642eLGsOJzpD9OSTBckznQHTHVtG
         DLG8HK+bKJX59+/4H2tkvP5oVERBJiyL7hxxEx8jl/VPHJWDDEBpMvCpg9jie7+nQ5CE
         HXknNfPRRNtdC4UKN4ZLpqNDImcg7KJluYQqOBTbRx70xc1I3hygkT2Wr/qiaYGfN7cd
         mx3qr37/gcsYFm91tcOCIs3MeR4/SEwlHsNAvoUHXgETjDMGrX2y8ToLIcV+i7WILo2g
         8FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7QySS8sX+rCfEVcFiwHdK87drcPLIRv7jTR3Ef+m7U=;
        b=nrzd4Ig30mrU8yhoLr2UqtDm2Eht3OUAlJTCZ+CGDOJnC05cnzWL4VguO6kfGgtaH7
         U8xgHL7qpmL0KH/+W22hHw4xrYNOLcT5X9nm0+gfLoiGXsSr4h1EB7k0xV+bJrBD2qRs
         BwtR1B8UNIwtO2unDMlZMhkZ6AD81hnvnjzHxzdyu2Y2iXEhe0wwL2e0aBRIhqUxrohU
         8IH8cwPyX2nko12F/6ayTsxalCq7ZN8jWP3Nii03yLAYdKp57l2xjGc7GChitbB8ZaY0
         DzpZYTXOjIDa1a8IPjrSVhPaHQavqAtTZfIvZrk3B3Uuh08F0ZlgiGWkufhHB9E7z4mu
         h/Gw==
X-Gm-Message-State: AFqh2kp7K3cdPgwm05ohAaLvQvVAoqCucYOeS4AxSRbkrUl+lO6vRPj6
        e3cq1rdSPKTUhJtHQQPqCP/0Ag==
X-Google-Smtp-Source: AMrXdXtLnHaHuaeFv5L3Vh+VPC3Xb4+iZJCGtmnWJmdoM/jdqpG02sq79R8ekQkcRR1GCybLYG6nQg==
X-Received: by 2002:a05:600c:228d:b0:3d1:ee97:980 with SMTP id 13-20020a05600c228d00b003d1ee970980mr2748366wmf.7.1673954907271;
        Tue, 17 Jan 2023 03:28:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb06000000b002423620d356sm8398144wrr.35.2023.01.17.03.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:28:26 -0800 (PST)
Message-ID: <6e1a2182-ffbf-5684-dd2f-e3b862ad6763@linaro.org>
Date:   Tue, 17 Jan 2023 12:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 01/10] dt-bindings: soc: fsl: cpm_qe: Add TSA
 controller
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230113103759.327698-1-herve.codina@bootlin.com>
 <20230113103759.327698-2-herve.codina@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113103759.327698-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 11:37, Herve Codina wrote:
> Add support for the time slot assigner (TSA)
> available in some PowerQUICC SoC such as MPC885
> or MPC866.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,tsa.yaml      | 260 ++++++++++++++++++
>  include/dt-bindings/soc/fsl,tsa.h             |  13 +
>  2 files changed, 273 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,tsa.yaml
>  create mode 100644 include/dt-bindings/soc/fsl,tsa.h
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

