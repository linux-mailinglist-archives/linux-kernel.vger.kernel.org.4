Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246C05BB07D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIPPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIPPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:45:25 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FB761DA6;
        Fri, 16 Sep 2022 08:45:24 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id u5-20020a4a5705000000b0044b34c2c89cso3586434ooa.9;
        Fri, 16 Sep 2022 08:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8pzyxbJayro/M9TXsSXTdNd+d231RQYEZs5oZ2uJtWY=;
        b=JI1ta2dNkh7f96aU9l2Wxig+aZzibNKjvVTCEI+ImO+QjqF9xwiMNNHcl2RZuYeRgV
         KaP+dZMl5Kvrxkg/5wCOZExqiLUZHv4Cj2QOKfcNhCryjG7fbFYnugiUPsJUkvAXqWWy
         D8G4IOn7gogYSm7idEwvhnvSqMnbqG0V+K6P3fBzfZyOlPXks6m/KCyAobGzr0vIV455
         9Ubr81rGXelf6Jfc7FezxcnLngNKvAbzGqm7hl7dxhuUPTi/ic7HEN5mFlGX4+hBcHSu
         cGkqyXpm964MHsFxyblLmwPEW6jOPc8PObOmZ0n46WHqOo+5eZVsluATW4NojcPn8rxN
         Kf7w==
X-Gm-Message-State: ACrzQf3ZZqCONPm9t1UrfPANllLLEruHJl23nwHF/qTfhHUotmcDVbSy
        XhGzefAEmXDOC/phJSrR2g==
X-Google-Smtp-Source: AMsMyM73orFT+ANpDhz6RWdVQqbQwjKW9DoX1c3Ywrbtrb5xiRCpmy9Zxe/Maf7Qkhx3MiTY94hN/w==
X-Received: by 2002:a4a:a9c2:0:b0:467:f2d3:f21a with SMTP id h2-20020a4aa9c2000000b00467f2d3f21amr2327219oon.47.1663343123769;
        Fri, 16 Sep 2022 08:45:23 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d3-20020a9d5e03000000b00636d4e8d480sm10030896oti.19.2022.09.16.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:45:23 -0700 (PDT)
Received: (nullmailer pid 2038375 invoked by uid 1000);
        Fri, 16 Sep 2022 15:45:22 -0000
Date:   Fri, 16 Sep 2022 10:45:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, houlong.wei@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: mediatek: mmsys: Reference to
 mediatek,gce-mailbox.yaml
Message-ID: <20220916154522.GA2035736-robh@kernel.org>
References: <20220916080742.26851-1-angelogioacchino.delregno@collabora.com>
 <20220916080742.26851-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916080742.26851-2-angelogioacchino.delregno@collabora.com>
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

On Fri, Sep 16, 2022 at 10:07:42AM +0200, AngeloGioacchino Del Regno wrote:
> The GCE mailbox documentation was converted to DT schema: replace
> mtk-gce.txt references to mediatek,gce-mailbox.yaml

Just squash this into patch 1.

Rob
