Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF9678979
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjAWVXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjAWVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:23:28 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541122BEEC;
        Mon, 23 Jan 2023 13:23:27 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 123-20020a4a0681000000b004faa9c6f6b9so2330440ooj.11;
        Mon, 23 Jan 2023 13:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8daWvhav3exVg13KsQMucbRN9RZn7I3X/4TrQdWi0uU=;
        b=oKzqeq2DonEiWX+KjLz62z5xgbTGk32zm162dg84APBJ01PauLgRCOnX722BSlRpyr
         /fMj/k65Cm21r/Nh7m5ar+mLFBf0sKlSLCxZuY9zZTq7V1StW8qXttzmHNoq3wxCxwYc
         Fk3MuNPVkGt5zdjhGToECKQPYHHkvnDuE8+d6yC7g8RQw3WcM5s9eZtYG+5RSYZkYE/r
         UQEIqNsZS3hO0pwKOlX+yLBHkOcCubUZ0vuK/ubyHze/guWYFchEaNJt6JzzxnbNIonL
         1WU2bXalQeDKI19JrW+CX3eI7EjYR/LSfl/7tmgVRkgOqxJ1gTLXUMnJfOaVmSlO1xzu
         u2WQ==
X-Gm-Message-State: AFqh2koY6UoVkgYNTYZKXIeccHAQGfgf1r4ufSwWN3AX0heAqqak8+vY
        2jxZEI7wZmiS7yrNDLViqg==
X-Google-Smtp-Source: AMrXdXvz7wXg7GEnoByWzAIaEXjJ/g1Rl1Ua/Jfxd+Wd1LTEufTC97JjA23GJCSB5bHJ4a/7wSBkpA==
X-Received: by 2002:a4a:370c:0:b0:4f2:a3c:e285 with SMTP id r12-20020a4a370c000000b004f20a3ce285mr13151556oor.4.1674509006545;
        Mon, 23 Jan 2023 13:23:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p9-20020a4ad449000000b004fb2935d0e7sm47610oos.36.2023.01.23.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:23:26 -0800 (PST)
Received: (nullmailer pid 2663747 invoked by uid 1000);
        Mon, 23 Jan 2023 21:23:25 -0000
Date:   Mon, 23 Jan 2023 15:23:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Miles Chen <miles.chen@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: add some compatible strings for
 MT7981
Message-ID: <167450900448.2663686.2248170035264417570.robh@kernel.org>
References: <cover.1674137304.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Jan 2023 14:11:35 +0000, Daniel Golle wrote:
> Add compatible strings for MT7981 to existing binding documenation
> at mediatek,apmixedsys.yaml and mediatek,topckgen.yaml.
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml | 1 +
>  Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml   | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
