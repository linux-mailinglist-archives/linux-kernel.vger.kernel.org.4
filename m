Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80D6A49B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjB0S2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0S2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:28:38 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B84C674;
        Mon, 27 Feb 2023 10:28:37 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-172a623ad9aso8295604fac.13;
        Mon, 27 Feb 2023 10:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAghNcZOo+DAEQczVV+zv0Sggl3SkEdcXf3iJdRX+qk=;
        b=OUkPwmEvflkLguE5alwGcSqXhZiIduv5OUQFGnZFHBnXltl/m0nws7520LpbvtbFZm
         stTgzoFGqZtd4lYCwWm98YHT0R5EJDNHP2sKAIy00n6JaLuqN1Ri439TS2gTwEAsW2WJ
         hxaM89vOl6ZQkCkTHHQk08gVXChEdfbiwEvFRWOJP6nvD7Zz+tDO4UnaAzo0oxccWcc8
         URvs+XpXDRv32Cpb0r1h3+g8SGTdMZ3N3FS+kN9ZIPm1FAlSPUEXvtKCOzMOPys1/tal
         pskmVvUtGkK1/IJBXr62neSWo6tbLDKg8Q4RoVOuCXD0G2/ejyOCvM+If3d1VT5ai3XP
         vjkA==
X-Gm-Message-State: AO0yUKWjYdk5+n7jsNEA+kaMcpHtfD5JrdE7iTQpG8tAB/UOAhshBaFT
        tVPTqOTFUTwaKOZ5pUVrFQ==
X-Google-Smtp-Source: AK7set/ULx8pV2pjX31TC7ROkyj+jY51+b6GTXfea/+pI9KrZayzKReMok9/Qx/EcdnrO9jg9Ki0Ww==
X-Received: by 2002:a05:6870:350f:b0:172:6b1b:ea34 with SMTP id k15-20020a056870350f00b001726b1bea34mr11703038oah.8.1677522514914;
        Mon, 27 Feb 2023 10:28:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870034100b001724d631f92sm2520796oaf.30.2023.02.27.10.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 10:28:34 -0800 (PST)
Received: (nullmailer pid 639117 invoked by uid 1000);
        Mon, 27 Feb 2023 18:28:33 -0000
Date:   Mon, 27 Feb 2023 12:28:33 -0600
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
Subject: Re: [RFC PATCH 16/16] dt-bindings: pinctrl: mediatek: improve schemas
Message-ID: <20230227182833.GA605986-robh@kernel.org>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-17-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222183932.33267-17-arinc.unal@arinc9.com>
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

On Wed, Feb 22, 2023 at 09:39:32PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Some schemas include "MediaTek", some "Mediatek". Rename all to "MediaTek"
> to address the naming inconsistency.
> 
> Change the style of description properties to plain style where there's no
> need to preserve the line endings, and vice versa.
> 
> Fit the schemas to 80 columns for each line.
> 
> Set patternProperties to '^.*mux.*$' on mediatek,mt7986-pinctrl.yaml.

This at least should be a separate patch. Really, this is probably 3 
patches.

The changes themselves look fine.

Rob

