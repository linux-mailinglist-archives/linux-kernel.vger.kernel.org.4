Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB46B1396
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCHVLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCHVLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:11:36 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF0BBBB0E;
        Wed,  8 Mar 2023 13:11:33 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1763e201bb4so177410fac.1;
        Wed, 08 Mar 2023 13:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4YSoa9uV0XKozIzNBn1e5mCInOvBfhbVHfU7vWcTBs=;
        b=5Z/qiKYwn5mIKWrIqQ95vKAxZFwGkPb//beYpM2QFSxc9hGhWpHREIzfwrq+8e/lFX
         HE4yVMlopyji2z7K0B/cjZiC3pn47sAJ1nmTwQcxe5C/9H7OOEb+8FKmSEDmIWpJcHvT
         2GwqVgIk4ppAPwDOWnlI0Hrq0pCJEkRCZF8RjbxtJkVa9iR8RqFRzFhAzOgiBjHvpsJ0
         nHWXo/suWX5pPQXVyWCgPJqOHM+oMTacV3Oyvmk6IAdxDLdJ9GKUR+N9NgHdttlU3d9f
         cQujtgsAzneFGFmYh+9/RvTWqZhHwbddHB5CtJuMIglBeoTr1EvfEdMBJESLOeVeWrfj
         GB9g==
X-Gm-Message-State: AO0yUKV92T/O/eEdI/2k5lHmaarK2xI/hM1dFe8WYfjJTtgI2ZJZeaJ6
        6zSFMOSU/jULKZqJIiX/1g==
X-Google-Smtp-Source: AK7set8BSBwdSSGBijkEh6MDrbv/vYZa5o4GV9y9Xt6AyzB5YrpY8yUqtauZKcJm+fhWhiavcjZDyQ==
X-Received: by 2002:a05:6870:e886:b0:172:4748:32d9 with SMTP id q6-20020a056870e88600b00172474832d9mr12216316oan.3.1678309893181;
        Wed, 08 Mar 2023 13:11:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id yy31-20020a056871259f00b00172426ebe58sm6597443oab.27.2023.03.08.13.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:11:32 -0800 (PST)
Received: (nullmailer pid 3850403 invoked by uid 1000);
        Wed, 08 Mar 2023 21:11:31 -0000
Date:   Wed, 8 Mar 2023 15:11:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
Subject: Re: [PATCH 15/20] dt-bindings: pinctrl: {mediatek,ralink}: fix
 formatting
Message-ID: <20230308211131.GA3803811-robh@kernel.org>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-16-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303002850.51858-16-arinc.unal@arinc9.com>
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

On Fri, Mar 03, 2023 at 03:28:44AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Change the style of description properties to plain style where there's no
> need to preserve the line endings, and vice versa.
> 
> Fit the schemas to 80 columns for each line.

I would just leave the enum cases alone and make this patch just about 
reformatting 'description' entries. Either way:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/mediatek,mt65xx-pinctrl.yaml      | 20 ++---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 31 ++++----
>  .../pinctrl/mediatek,mt6795-pinctrl.yaml      | 29 ++++----
>  .../pinctrl/mediatek,mt7620-pinctrl.yaml      |  2 +-
>  .../pinctrl/mediatek,mt7621-pinctrl.yaml      |  2 +-
>  .../pinctrl/mediatek,mt7622-pinctrl.yaml      | 24 +++---
>  .../pinctrl/mediatek,mt7981-pinctrl.yaml      | 33 +++++----
>  .../pinctrl/mediatek,mt7986-pinctrl.yaml      | 60 +++++++--------
>  .../pinctrl/mediatek,mt8183-pinctrl.yaml      | 24 +++---
>  .../pinctrl/mediatek,mt8186-pinctrl.yaml      | 43 ++++++-----
>  .../pinctrl/mediatek,mt8188-pinctrl.yaml      | 74 ++++++++++---------
>  .../pinctrl/mediatek,mt8192-pinctrl.yaml      | 43 +++++------
>  .../pinctrl/mediatek,mt8195-pinctrl.yaml      | 34 ++++-----
>  .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 26 ++++---
>  .../pinctrl/ralink,rt2880-pinctrl.yaml        |  2 +-
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        |  2 +-
>  .../pinctrl/ralink,rt3883-pinctrl.yaml        |  2 +-
>  17 files changed, 236 insertions(+), 215 deletions(-)
