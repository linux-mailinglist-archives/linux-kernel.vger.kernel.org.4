Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D9A63FC18
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiLAXdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiLAXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:33:26 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229BEB5C;
        Thu,  1 Dec 2022 15:33:26 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id y194-20020a4a45cb000000b004a08494e4b6so490310ooa.7;
        Thu, 01 Dec 2022 15:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV6CjuoOmDJCrT3HK8JiKWVQT6lYUA0pH9U3EEboe7E=;
        b=41S7YRolHDBLUzrWldnzlgHCOSlkyfK8SfjWLzALAwtJKjfLOTlMqdDzRDWfprtNVz
         aXBuMkCzrXzuADwhH6vChQTYXA96XnGFE1h9YFByyR4rvsYFv3iiWwJ2hLFqGWVxbqMA
         BPQctWC/YrxMMmAO0tZP7RhCElRj/+dMBw/mvbpiYOFSQRc+eD7GVymVzGL1ClOrE3Gk
         HIAjQHdZ4QH+M5kV2Y0fNOFqJOmLoED3uOQoY1o5Yd+3XK4/ImenXd7FVVOUEBfxdUFe
         xBaXHKgEPhoe0LaHSCBPj4Y2mYWZ5LHjAUngycab9nWgYlGsXt8QKv5xdKYf5c1vOYAY
         oWKQ==
X-Gm-Message-State: ANoB5pmjwARRlgPVskNMmZazVQmbifuB2/uQHoLPKnqGU4oMEa4Hjk+K
        FvD0VD14F1WaFyxzhjljCg==
X-Google-Smtp-Source: AA0mqf5M9nJX9KDi3rKXW1IQ32Xx7g8ROHxHwlWwX5hwmRYB/D8rbNNcafvpX5yJhj0k3R6jjdm63A==
X-Received: by 2002:a4a:ad49:0:b0:49b:c0e:3d5f with SMTP id s9-20020a4aad49000000b0049b0c0e3d5fmr29549672oon.69.1669937605311;
        Thu, 01 Dec 2022 15:33:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s34-20020a056870612200b0013d9bd4ad2esm3361315oae.12.2022.12.01.15.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:33:24 -0800 (PST)
Received: (nullmailer pid 1686225 invoked by uid 1000);
        Thu, 01 Dec 2022 23:33:23 -0000
Date:   Thu, 1 Dec 2022 17:33:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Flora Fu <flora.fu@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v7 3/8] dt-bindings: soc: mediatek: convert pwrap
 documentation
Message-ID: <166993759991.1686069.16535756664012746082.robh@kernel.org>
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
 <20221005-mt6357-support-v7-3-477e60126749@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v7-3-477e60126749@baylibre.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Nov 2022 16:57:02 +0100, Alexandre Mergnat wrote:
> - Convert soc/mediatek/pwrap.txt to soc/mediatek/mediatek,pwrap.yaml
> - Add syscon compatible const for mt8186 and mt8195 to match the DTS needs,
>   which is missing from pwrap.txt.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/leds/leds-mt6323.txt       |   2 +-
>  Documentation/devicetree/bindings/mfd/mt6397.txt   |   2 +-
>  .../bindings/soc/mediatek/mediatek,pwrap.yaml      | 147 +++++++++++++++++++++
>  .../devicetree/bindings/soc/mediatek/pwrap.txt     |  75 -----------
>  4 files changed, 149 insertions(+), 77 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
