Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F766A49A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjB0SYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjB0SYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:24:15 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5997326595;
        Mon, 27 Feb 2023 10:23:57 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id bi17so5943405oib.3;
        Mon, 27 Feb 2023 10:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdADJJit9jcEYXlvIJLOYn0H4Qs7tlr87LcMHE1QWmc=;
        b=oj1TFtLRgcTaxiVdwoYXOuC4TpAc87aWgeum5mVZcgP44rgRLg80M3JK4H9Nyu7ZWO
         oyhN+XIJZrZhQkMERk0UAv6C2uCryjF26VJYO0JZ0ngIZgoeFkbzv23zkCZ4rsNHhAfw
         kuQ8aucRfSh7kDOwivIFs4VSM/SrGML9KXGRpqfa0VrSAUnWZ4fj9hHThwRhyhftsPhO
         m9kN5IZaYu9P0NxBpj+Rh/ytOMgD2Hc9kWTe9jItEKoEpUuwa5K9YIPrP+De7QWMSmRZ
         /+DAeRJx1qFsv1scC9T5AIAYwuzWzowHrkCVloR52qmAebCcDF5chB03jATWqRxQ7Ipf
         TxcQ==
X-Gm-Message-State: AO0yUKW630uZ8pmziqFDDFK7H17rCdCDpUv3ExTU34rqdw3nVh+oCfuZ
        wFETccvoBAuqHVwujYTUrw==
X-Google-Smtp-Source: AK7set9igeideAjhDzRYNAY9NTgciq3AiH9XqtzFMJ+V5Pw/ePArDgnZ4jp/40iF7p3nRA/oT352pQ==
X-Received: by 2002:a05:6808:b0c:b0:384:4585:737f with SMTP id s12-20020a0568080b0c00b003844585737fmr49483oij.14.1677522236506;
        Mon, 27 Feb 2023 10:23:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t22-20020a4adbd6000000b00524f546997esm2930636oou.0.2023.02.27.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:23:56 -0800 (PST)
Received: (nullmailer pid 600045 invoked by uid 1000);
        Mon, 27 Feb 2023 18:23:55 -0000
Date:   Mon, 27 Feb 2023 12:23:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: Re: [RFC PATCH 13/16] dt-bindings: pinctrl: mediatek: mt8186: rename
 to mediatek,mt8186-pinctrl
Message-ID: <20230227182355.GA587025-robh@kernel.org>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-14-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222183932.33267-14-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:39:29PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Rename pinctrl-mt8186.yaml to mediatek,mt8186-pinctrl.yaml to be on par
> with the compatible string and other mediatek dt-binding schemas.

These renames doing the same transform can all be 1 patch. Either way:

Acked-by: Rob Herring <robh@kernel.org>
