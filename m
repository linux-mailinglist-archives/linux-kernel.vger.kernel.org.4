Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF625643805
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiLEWYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiLEWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:24:31 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0A5643D;
        Mon,  5 Dec 2022 14:24:26 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-14449b7814bso10253698fac.3;
        Mon, 05 Dec 2022 14:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co/zzkCX57YjiIHZ6diFtz/RTM1yDwFRLGgy9CALn3k=;
        b=H6hxhtsiMDnJ57bkXu45hE90S1TcAiBJv9wn796FyjdZwPJE7BW971IgSHczblL+Sn
         QCP3YV1OnJ4qxPJM6rzxYIdFzhxEKz2nk/mQniZh4MrKQLUWwnVm+hhT87TcT95Acmyn
         F1WwPOZbQ+NqdvlSwNuzBQwTtDgGNeBSs/EXRlzf3f+8rXmA0yfgsVExF8oebU7jQRT2
         fjcfkFKTYZ/nV9cU+ylrqtxRtgbUZFzirq+NGfDWziUHyhfVKP4BEhkGzUunkIBBOLoo
         ozoAQv3sNHKsdRTp1FqazKNaN1rQNyzK+C/I8Id+3tnIC9lcLyrpR/TFUMezL/gb9tq8
         9BgQ==
X-Gm-Message-State: ANoB5pkdzsWgZgX32vEGjzEipnWqRZ4Tka4ngH5JWuu5YxuXG/zsJJWP
        BQatwfqzejaCjDWim8SqgQ==
X-Google-Smtp-Source: AA0mqf5KPUlOKZlk8T+En9HAYLNzQISM+hJVBszps97tjWaKv7NPMdh/GkYpXW4fVkzPRyfrlNTQ5g==
X-Received: by 2002:a05:6870:bf0f:b0:13b:b20d:5c72 with SMTP id qh15-20020a056870bf0f00b0013bb20d5c72mr38013206oab.200.1670279066004;
        Mon, 05 Dec 2022 14:24:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m23-20020a4ad517000000b004a085ddc771sm5971373oos.6.2022.12.05.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:24:25 -0800 (PST)
Received: (nullmailer pid 2797234 invoked by uid 1000);
        Mon, 05 Dec 2022 22:24:24 -0000
Date:   Mon, 5 Dec 2022 16:24:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     venture@google.com, linux-kernel@vger.kernel.org, joel@jms.id.au,
        pbrobinson@gmail.com, skhan@linuxfoundation.org, arnd@arndb.de,
        adrian.hunter@intel.com, benjaminfair@google.com,
        linux-mmc@vger.kernel.org, yuenn@google.com,
        ulf.hansson@linaro.org, davidgow@google.com,
        openbmc@lists.ozlabs.org, krakoczy@antmicro.com,
        andy.shevchenko@gmail.com, briannorris@chromium.org,
        tali.perry1@gmail.com, devicetree@vger.kernel.org,
        avifishman70@gmail.com, gsomlo@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI
 controller
Message-ID: <167027906409.2797176.10003950661420135791.robh@kernel.org>
References: <20221205085351.27566-1-tmaimon77@gmail.com>
 <20221205085351.27566-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205085351.27566-2-tmaimon77@gmail.com>
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


On Mon, 05 Dec 2022 10:53:50 +0200, Tomer Maimon wrote:
> Add binding for Nuvoton NPCM SDHCI controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
