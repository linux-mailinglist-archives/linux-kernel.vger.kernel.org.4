Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FB65F6DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJFSxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJFSxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:53:16 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A9C6941;
        Thu,  6 Oct 2022 11:53:12 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so3217266fac.7;
        Thu, 06 Oct 2022 11:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeee9Rr7jOAcATV5bBfTzwtN4fPcyxHttU5yk2BU/SY=;
        b=PD6+YhNBFjFKDvDWHgARwtS7R0mI7jMoe9d3LNgl9Fjv+NbjW+K1Ep+4M8qH7+KFIT
         fHsK+8/6Qk9RM0skiCP0k8uM0pmO/JpeVFwRoJs35APl4HysjGOIvwCNbyPFk3I2RSGB
         2Ts5v6Aj8gGLmlIIyNLr6FdzAOf7LA9AWfFTPLiGnxvYG5fBX2UMHe0fJsRWeCRgT8Lv
         gq9a8wolr9PX8IY9R+j1s1XZKV7KKtk4Vw5vAVnD8zgAatABtjqgobvqYB+GDc+l1swo
         miHzVLZstl9PNqZtlAYsOuptFY3M7VyEBnR+CY8ZNrg6g8UMIO7Ms5tgcwbZ4bmjNUy3
         +h7w==
X-Gm-Message-State: ACrzQf0djaroc2U/a7EMhZZRC4fV2pGEWHuUSLP9xPDmnv/mxouTS1kj
        wpFuxo6/Fic++xbGmXYrxA==
X-Google-Smtp-Source: AMsMyM7vENBvoax0UUACSUWvm/Yhjv+8TS5Ns+hZv0leddoiFQ0qcEP9taDDKRVnqrRT53lnby1d/w==
X-Received: by 2002:a05:6870:b01c:b0:133:3666:1ecc with SMTP id y28-20020a056870b01c00b0013336661eccmr522250oae.45.1665082391128;
        Thu, 06 Oct 2022 11:53:11 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id o6-20020a056870524600b0012d939eb0bfsm209379oai.34.2022.10.06.11.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 11:53:10 -0700 (PDT)
Received: (nullmailer pid 27055 invoked by uid 1000);
        Thu, 06 Oct 2022 18:53:09 -0000
Date:   Thu, 6 Oct 2022 13:53:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v4 2/2] dt-bindings: gpio: Add gpio-latch binding document
Message-ID: <166508237779.26843.14601884317777687978.robh@kernel.org>
References: <20221006083031.2259006-1-s.hauer@pengutronix.de>
 <20221006083031.2259006-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006083031.2259006-3-s.hauer@pengutronix.de>
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

On Thu, 06 Oct 2022 10:30:31 +0200, Sascha Hauer wrote:
> This adds a binding for a GPIO multiplexer driver based on latches
> connected to other GPIOs.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v3:
>     - Introduce delays between GPIO toggles as suggested by Serge Semin
> 
>     Changes since v1:
>     - Add license to binding file
> 
>  .../devicetree/bindings/gpio/gpio-latch.yaml  | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
