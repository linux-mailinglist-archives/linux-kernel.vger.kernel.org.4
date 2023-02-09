Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F2B6910F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBITHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBITHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:07:31 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B25CAD15;
        Thu,  9 Feb 2023 11:07:30 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id bh15so2500924oib.4;
        Thu, 09 Feb 2023 11:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljNnToeTIL1TFk9BZIDWfKvJLhPyA6JgaKeGR7D+Uy8=;
        b=Wqua+6pxuFi6oAnYLNUGvVHskErAB164JIuCWrZGLQefpGPMDKOa+wfpIQZlUKd0HM
         uDoRpCO5OFEAFlaRMlXYEhFKWk0rPnh0FGxnirZ80VrPcvfyYE5+pDqOk+tMK26duLFt
         3OR4gATIQwB9P+Bgv+6dmLWtibAJmyWYZ0xRmXcLfvwcFsM0cLn+dWkWZAoDFhsNpt4M
         TU0Cnpq2fFRggGTVcoMwMMtk5H1sRXEMlCQmucyZO4ZOOlI8dDmdR8sT49YmgQreWsD9
         s7cal84ZoxTlRD4fV0SEYPOiDVuSX5Ju7mq3WifrtX30s+QocBCf9kfc0KV89QFN4HFZ
         c/Hg==
X-Gm-Message-State: AO0yUKWUVmUP6bUiZkVXunYY8AaUdEdM558pCrkRpRPMoTQRlpTPhJuk
        V9NpJ2hh8TmNwjWTnPOw2w==
X-Google-Smtp-Source: AK7set9kNL5f2SUSoOcy3zcL5Ej8M7/ppJqU+XYT7yBpDlUf9vvh4vTus6vEzRSNOxkw8vmpoD8elw==
X-Received: by 2002:a05:6808:6292:b0:378:1e37:ff44 with SMTP id du18-20020a056808629200b003781e37ff44mr6380288oib.33.1675969649382;
        Thu, 09 Feb 2023 11:07:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m128-20020acabc86000000b0037880fdb1f6sm1200297oif.24.2023.02.09.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 11:07:28 -0800 (PST)
Received: (nullmailer pid 647682 invoked by uid 1000);
        Thu, 09 Feb 2023 19:07:27 -0000
Date:   Thu, 9 Feb 2023 13:07:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     bchihi@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        rdunlap@infradead.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, krzysztof.kozlowski+dt@linaro.org,
        ye.xingchen@zte.com.cn, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v14 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers
Message-ID: <167596964747.647630.15058465615417584783.robh@kernel.org>
References: <20230209105628.50294-1-bchihi@baylibre.com>
 <20230209105628.50294-3-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209105628.50294-3-bchihi@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Feb 2023 11:56:24 +0100, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS thermal controllers dt-binding definition for mt8192 and mt8195.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  .../thermal/mediatek,lvts-thermal.yaml        | 142 ++++++++++++++++++
>  .../thermal/mediatek,lvts-thermal.h           |  19 +++
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
>  create mode 100644 include/dt-bindings/thermal/mediatek,lvts-thermal.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

