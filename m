Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D55B6231
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiILUbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiILUbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:31:03 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E41E40BDA;
        Mon, 12 Sep 2022 13:31:02 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11eab59db71so26493297fac.11;
        Mon, 12 Sep 2022 13:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=g/UDc025mrWtsVvlPcb6aYSfww62RRfTqVjKHmF+7ik=;
        b=EsEen5nISvmO0ABaX2SNdURd8DnrwgImalBNey5iakDA1lQaKH2gY60jOY4EzevB6S
         Z016ONl1N9vi1TjYE4W9yt98S4pLWsrZUddMEoyDHmSb+Vha8yo1R9/Qo82M75InHb2t
         lMdzEkzNHA3UEmv58CrI25tN+S+nASa3M73TmHIcuWSay8pie58mSFbHlVTLQB7/iYgk
         ms7FPdzrwNiVeN8nd55sYFUI7LvJUgWGN+8aW8bcEwplUn6XxF8gIY4sFuxds6mzmZ30
         O3alt3fVpp+VBP/I48d2akYvUWULHiOFIA7jISfAbnC/GihPma3thTSf468kwlrC8rgV
         Rpng==
X-Gm-Message-State: ACgBeo07dupwGtBoL3ClqXlIlfvIe9MsNeGwqLaaiXAUqADgBA65rL2D
        x+08ES2rD2nOIEIpwiSVHg==
X-Google-Smtp-Source: AA6agR6XF9RQcPY40kpUXoOfzj6E6g1w/ffzTwA+bpiGExL1d5D2Wgl6YDwnA5faBNqCRi9W1we/Pg==
X-Received: by 2002:a05:6870:e413:b0:127:2f43:af44 with SMTP id n19-20020a056870e41300b001272f43af44mr66328oag.175.1663014661704;
        Mon, 12 Sep 2022 13:31:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id el40-20020a056870f6a800b0012b19b888bfsm6316443oab.47.2022.09.12.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 13:31:01 -0700 (PDT)
Received: (nullmailer pid 1782577 invoked by uid 1000);
        Mon, 12 Sep 2022 20:31:00 -0000
Date:   Mon, 12 Sep 2022 15:31:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Victor Wan <victor.wan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, YongHui Yu <yonghui.yu@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v9 4/5] dt-bindings: nand: meson: convert txt to yaml
Message-ID: <20220912203100.GA1782522-robh@kernel.org>
References: <20220907080405.28240-1-liang.yang@amlogic.com>
 <20220907080405.28240-5-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907080405.28240-5-liang.yang@amlogic.com>
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

On Wed, 07 Sep 2022 16:04:04 +0800, Liang Yang wrote:
> convert the amlogic,meson-name.txt to amlogic,meson-nand.yaml
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 55 -----------
>  .../bindings/mtd/amlogic,meson-nand.yaml      | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
