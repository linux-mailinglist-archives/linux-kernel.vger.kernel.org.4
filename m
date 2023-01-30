Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860FD68176B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbjA3RRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjA3RRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:17:42 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67B1B540;
        Mon, 30 Jan 2023 09:17:41 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso2849849otl.11;
        Mon, 30 Jan 2023 09:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4RubPRL2kEyc8xeXA3LZgpNmnA/nBwbKFeLVda0b/s=;
        b=2EoOMPMtxNTItqQtEga9kfSz35wWl6b0o8r2soiOP9OMt+AAZA2ISweBxlb8yMR/ew
         5T+olV+aN0Mgfi56Ong6DVEDwrH8EFPioZLaPZssoMgJVrEcQymrZvazTylKKR9VcruI
         ig5W49lyhOU6Lz215DOXdiSStuQkFXQn0QUyaYwHskFWy6zK7CFS1fj8RoUGWQL7VMUh
         mU2GKeSDX7yUXsYWYzgPX9SFjmgu902MmkM6MgOYmo897JDWRPZ+7MfjsdfLoSgb7B9u
         i8jCfrW8sR9Kx+jtotlxzAIBuaj1+7NCpZKRUXvXMmi7tvICINuGSLCoeWQkLLGpG44V
         TU2Q==
X-Gm-Message-State: AFqh2kqf0TlhHoRWqkOUCh8BJpnBicQ5cdFZv3sViZOdjdjS7I1mGiEv
        pdq2TGrLBgwwbxfOxXRciA==
X-Google-Smtp-Source: AMrXdXtb6w6SV90Lb/AyryZDCyhK6CzQbJhX9lwNjfTghvU21g3pcLvW7SaUvscKBqRGxWUDD1EENg==
X-Received: by 2002:a05:6830:39e1:b0:686:5fcd:8b52 with SMTP id bt33-20020a05683039e100b006865fcd8b52mr20002471otb.13.1675099060407;
        Mon, 30 Jan 2023 09:17:40 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n4-20020a9d4d04000000b0068bcd200247sm2058502otf.75.2023.01.30.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:17:39 -0800 (PST)
Received: (nullmailer pid 2946630 invoked by uid 1000);
        Mon, 30 Jan 2023 17:17:39 -0000
Date:   Mon, 30 Jan 2023 11:17:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        linux-kernel@vger.kernel.org,
        Johnson Wang <johnson.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sam Shih <sam.shih@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add bindings for MT7981 SoC
Message-ID: <167509905837.2946315.3326500381163697135.robh@kernel.org>
References: <cover.1674693008.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Jan 2023 00:34:15 +0000, Daniel Golle wrote:
> Add bindings for the MT7981 pinctrl driver. As MT7981 has most features
> in common with MT7986 (but has a different layout in terms on pinctrl
> and clocks), the existing mediatek,mt7986-pinctrl.yaml was used as an
> example to create a similar document covering MT7981.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../pinctrl/mediatek,mt7981-pinctrl.yaml      | 475 ++++++++++++++++++
>  1 file changed, 475 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
