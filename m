Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AD5B8A10
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiINOMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiINOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:12:52 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5734C20BC0;
        Wed, 14 Sep 2022 07:12:47 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-127d10b4f19so41228513fac.9;
        Wed, 14 Sep 2022 07:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SPyIRI2qTfSO2auACHjp148Yr0cJMKWfWPP3G131wXU=;
        b=t96/vH5/9GB7Eta089omBEugVF5xihEsKoZAzr3U1yIJCcZUsXUFkpf1LsUm72X468
         4RjA7kBiy+UnffeCkWNDckOL9lqQ5jDQ9YgNGHrvUy6tQN9LyxPk5sXKuvXfSk6LZiXD
         f/RnDGwiDc4y+E6TVXlb5/5Tt/hpF+4HnKTs8BhKeycZ70Ezf1WqsdSqJWYdMaveZDsG
         QoRQ77fPZR3zSQXGRp62mUzPCmbuN5YzVnBwOv3qShV1Ixi+tuKOWAep7z508m2IxNgh
         3Vlm3yPdSoZHCtEd8keU47fr7a44Q4FKQlZ/RY8Gih7TB465GvXuXTB97+DowgZyFxl4
         J+3Q==
X-Gm-Message-State: ACgBeo1xN2kQu2nyIxgBAzyHCW5uhgGXsRdvjtMycTh/WPsx7aQlCEgR
        McdwETqRF1tNvQslwRiMOw==
X-Google-Smtp-Source: AA6agR7QeunMWJohZIlFuCMAfUkU6WKkOLpkzcAPqf/clN22a3MXHYUvpcOCZ79QPAgMSv29PpsnAA==
X-Received: by 2002:aca:5b0b:0:b0:344:bea0:8c88 with SMTP id p11-20020aca5b0b000000b00344bea08c88mr1980979oib.225.1663164766562;
        Wed, 14 Sep 2022 07:12:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t184-20020a4a54c1000000b0044b0465bd07sm6451845ooa.20.2022.09.14.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:12:46 -0700 (PDT)
Received: (nullmailer pid 2131256 invoked by uid 1000);
        Wed, 14 Sep 2022 14:12:45 -0000
Date:   Wed, 14 Sep 2022 09:12:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     allen-kh.cheng@mediatek.com, devicetree@vger.kernel.org,
        chunkuang.hu@kernel.org, rex-bc.chen@mediatek.com,
        moudy.ho@mediatek.com, matthias.bgg@gmail.com,
        jason-jh.lin@mediatek.com, linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: Add display mutex
 support for MT6795
Message-ID: <20220914141245.GA2131194-robh@kernel.org>
References: <20220913140121.403637-1-angelogioacchino.delregno@collabora.com>
 <20220913140121.403637-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913140121.403637-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 16:01:20 +0200, AngeloGioacchino Del Regno wrote:
> Add compatible for MT6795 Helio X10 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
