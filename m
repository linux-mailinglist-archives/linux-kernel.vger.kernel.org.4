Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F407415C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjF1Py7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:54:59 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:42199 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjF1Py4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:54:56 -0400
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-785d738d3feso2053839f.0;
        Wed, 28 Jun 2023 08:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967696; x=1690559696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvM2j4MFWu2+tkWUIYPaSox/q0gO7Yl+tyqnCdAuB4I=;
        b=VqV4Oy24RqMUr5Ez3dhnwo9oCXjOGf7T2njLBOAqfTWF1lmP47A5RQwh/jB/bfsPMh
         aZgJFBKDibABZ1p5REC8ifWboXoHEf9YjSWuxN75LehnIFdQyWIbsoWbhDPbDNl2onVG
         ERFtYRbznrJyDJhq0SaFKh9KW2UXMnWt3ChNCugEZ60to0NDgH7tdQEl9d+yDRv9Obv2
         Cn6CMmwwPFzHAsZ7m3SHsdugTnXkHkqaPJb3DzIcFbZy8Pj337C5X+/bvv8e11MLmckE
         jqT9oe9TwEA+FXd+oOtgJd/AFUgPyPcgUNJ2ryV/KTqZ96m4CPu4xO1pa/IRXRCl0CX8
         YWcA==
X-Gm-Message-State: AC+VfDy+SLjILjeEsVL49CJI1up746RbohwytPvTzM6c9TKKo9cqNVKR
        rTjPKfuTFxpd2DgegnvZ+g==
X-Google-Smtp-Source: ACHHUZ7vOyiGVJcVU0xLxr6GOynYLXsRfMlwVF8aoB5Ye4p2RGPwCEIj1VqWd7eoGZKz85FYYMaI6A==
X-Received: by 2002:a05:6602:418a:b0:783:4135:5b96 with SMTP id bx10-20020a056602418a00b0078341355b96mr1207753iob.5.1687967695956;
        Wed, 28 Jun 2023 08:54:55 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s5-20020a02cc85000000b0042acb1ec82bsm1991384jap.112.2023.06.28.08.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:54:55 -0700 (PDT)
Received: (nullmailer pid 541922 invoked by uid 1000);
        Wed, 28 Jun 2023 15:54:53 -0000
Date:   Wed, 28 Jun 2023 09:54:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: q6apm: add firmware-name bindings
Message-ID: <20230628155453.GA537917-robh@kernel.org>
References: <20230628102621.15016-1-srinivas.kandagatla@linaro.org>
 <20230628102621.15016-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628102621.15016-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:26:19AM +0100, Srinivas Kandagatla wrote:
> Add bindings to get firmare-name from DT, this will provide more flexibility
> to specify platform specific firmware file name and location. Also this brings
> tplg firmware name inline with other board specific firmware locations.

tplg?

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,q6apm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> index ef1965aca254..c783451145ef 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
> @@ -31,6 +31,10 @@ properties:
>      unevaluatedProperties: false
>      description: Qualcomm DSP audio ports
>  
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string

Already has a type, so you can drop.

No default? Or pattern it should match? 

> +    description: Audio Topology Firmware name
> +
>    '#sound-dai-cells':
>      const: 0
>  
> @@ -38,6 +42,7 @@ required:
>    - compatible
>    - bedais
>    - dais
> +  - firmware-name

Causes warnings. Test you bindings.

>  
>  unevaluatedProperties: false
>  
> -- 
> 2.21.0
> 
