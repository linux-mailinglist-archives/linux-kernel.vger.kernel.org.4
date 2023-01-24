Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05D96794A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjAXKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAXKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:02:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1A11E89
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:02:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so12441587wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7+2ObP6hwGfYv8AoClcbY4T+NA4DE6TZB+TmM9ZmmE=;
        b=Qrm3AJfL/kw1YbFePRK1oUcqKcOxpjENw5HzCbfcFTD48Htaa1hSvGC/HSbVSuigeD
         ymfmSmQwAPDkCVcJcDW797QKZOEqV8gWVGpvLohdmWBS7UVfq5MhfwlocVGOSjaT4pu6
         tZBtmjY3y/CJL6GQGIF5bHV258lDpHDnVdOPU5NABATZywZhILE7m2QCYZIJx7niHVnK
         ePzHLlc/I408cWUSeDAalrRBA11wkadAxv92tDdWVQRgXkDqaAzyyhqm4HkO+AYCB5oI
         yJMYm/e/PceuZGu/c9tonmlvYQYpGl0BVdyFJe2RxvzG41bbzAf11WY+j2EtQjuepJsY
         gGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7+2ObP6hwGfYv8AoClcbY4T+NA4DE6TZB+TmM9ZmmE=;
        b=gImoH9CPN1UmSWElBAcDsYdRyqXbM1jUL7vTmkgXbzASProY/FsV4rZVHs6/44ds1d
         aEYvTNu0pK3n52qPPE57m7aTifg0DHOKt1WqBz5SbZgDNArEtKtE0lzZL5NAjgbq+aKw
         tbvkflfQEtE3WVLizBr+hkjnRlHxSE9YzdEDsYD5gFklDSvTSMFuk3MoHsCNZJ0PKxkp
         wXy1UMGmIeqGLiNqkdx5QigWGspsPi58CVx35xo4JdXJJtI0+EMHvwOLW4Q8jGqLb0bw
         CsYwGy6Ri2845v7cJh2eHWkrYmrxU3UqLnH55+Ir/NOV+Sx7Sgi7ppXLmdGBnOlMmIO9
         HteQ==
X-Gm-Message-State: AFqh2kqPqBhCWYrwq+a5ffYkEMwGwXvCQiwp7b/Ef6jjBeWgVV92/Hjg
        yBy6/IfHOhcsNjXielDfpCf0jg==
X-Google-Smtp-Source: AMrXdXuVShf4vzB3MRnsGM1yCSL18NhLSOQCh97phU6rXE44vNaCzhjcUEtLDEHz4IHu5gDEqcTYNw==
X-Received: by 2002:a05:600c:89a:b0:3cf:6e78:e2ca with SMTP id l26-20020a05600c089a00b003cf6e78e2camr34965451wmp.5.1674554575278;
        Tue, 24 Jan 2023 02:02:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003d9df9e59c4sm13866978wmq.37.2023.01.24.02.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:02:54 -0800 (PST)
Message-ID: <37a95380-ee68-5c3a-3b96-48cc8b525f19@linaro.org>
Date:   Tue, 24 Jan 2023 11:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 05/10] dt-bindings: soc: fsl: cpm_qe: Add QMC
 controller
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
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
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230113103759.327698-1-herve.codina@bootlin.com>
 <20230113103759.327698-6-herve.codina@bootlin.com>
 <316ddb81-8d13-71dd-3396-412e31cfb880@linaro.org>
 <20230124104232.183cc9ff@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124104232.183cc9ff@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 10:42, Herve Codina wrote:
> Hi Krzysztof,
> 
> On Tue, 17 Jan 2023 12:31:09 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 13/01/2023 11:37, Herve Codina wrote:
>>> Add support for the QMC (QUICC Multichannel Controller)
>>> available in some PowerQUICC SoC such as MPC885 or MPC866.
>>>
>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>> ---
>>>  .../bindings/soc/fsl/cpm_qe/fsl,qmc.yaml      | 164 ++++++++++++++++++
>>>  1 file changed, 164 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
>>> new file mode 100644
>>> index 000000000000..3ec52f1635c8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,qmc.yaml
>>> @@ -0,0 +1,164 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,qmc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: PowerQUICC CPM QUICC Multichannel Controller (QMC)
>>> +
>>> +maintainers:
>>> +  - Herve Codina <herve.codina@bootlin.com>
>>> +
>>> +description: |
>>> +  The QMC (QUICC Multichannel Controller) emulates up to 64 channels within
>>> +  one serial controller using the same TDM physical interface routed from
>>> +  TSA.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - fsl,mpc885-scc-qmc
>>> +          - fsl,mpc866-scc-qmc
>>> +      - const: fsl,cpm1-scc-qmc
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: SCC (Serial communication controller) register base
>>> +      - description: SCC parameter ram base
>>> +      - description: Dual port ram base
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: scc_regs
>>> +      - const: scc_pram
>>> +      - const: dpram
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +    description: SCC interrupt line in the CPM interrupt controller
>>> +
>>> +  fsl,tsa:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: phandle to the TSA
>>> +
>>> +  fsl,tsa-cell-id:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [1, 2, 3]
>>> +    description: |
>>> +      TSA cell ID (dt-bindings/soc/fsl,tsa.h defines these values)
>>> +       - 1: SCC2
>>> +       - 2: SCC3
>>> +       - 3: SCC4  
>>
>> Is this used as argument to tsa? If so, this should be part of fsl,tsa
>> property, just like we do for all syscon-like phandles.
> 
> Yes, indeed.
> I will move 'fsl,tsa' to 'fsl,tsa-cell' with 'fsl,tsa-cell' a phandle/number
> pair (the phandle to TSA node and the TSA cell id to use)

Move to fsl,tsa, not from.


Best regards,
Krzysztof

