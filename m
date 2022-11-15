Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E881629B33
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbiKONwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiKONv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:51:57 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0652B1BE;
        Tue, 15 Nov 2022 05:50:54 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso8508483otq.11;
        Tue, 15 Nov 2022 05:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tJo2LBnY1zBMYmoeYVZXODudXysjv47CHxMSezRhas=;
        b=GMO08rm0ceqgpXYGSmO6cutzijjH11XEAB5TQWTGPhjLxsAH2u8lJ059ksIjytcZak
         YP/u1Uyiqz2qFLs3SJYTyoFqPSmuGyiRP5CVhY+cz+mvPTC/YPzkT8x9XEV9O3KNtElm
         k4qyI9asKdMSGcyV2jiYBembbeeQq1p4IEljf1qrgb4TWEH4ZkNEK96LV6dehlFeh5ll
         c7hQmrgrmd4kFNgypeIuYlxZML52VevIEJdpmY64fJouqeUNeSj9N38NCDEmX9oRQvgj
         tHS1p2CbbxXMO98BXjpJ+RuT0w0B7VtYuv9zlde3cV7lBc81dhHpGqfX+dFMBNwgsz3b
         +Lfg==
X-Gm-Message-State: ANoB5pkz0zClgQzeTU/RTT7xcZQXO8dUz7F6pcSRfl43FteN0jVRj3sd
        dFswdUJlWo7MWQnFhrgJOA==
X-Google-Smtp-Source: AA0mqf5lGkrgRN7jeCCRXlRu8timVYbU71gGIpGJj2PitosXKdwnkQmjCOrN+Axy5U4VY6Fjsuh0Ww==
X-Received: by 2002:a9d:2dc9:0:b0:66d:7a33:7c91 with SMTP id g67-20020a9d2dc9000000b0066d7a337c91mr5822157otb.227.1668520253573;
        Tue, 15 Nov 2022 05:50:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l9-20020a056870f14900b00127fbb7afffsm6548399oac.5.2022.11.15.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:50:53 -0800 (PST)
Received: (nullmailer pid 880448 invoked by uid 1000);
        Tue, 15 Nov 2022 13:50:55 -0000
Date:   Tue, 15 Nov 2022 07:50:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH v2 00/15] Initial Mediatek MT8365 SOC and MT8365-EVK
 board support
Message-ID: <20221115135055.GA870211-robh@kernel.org>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115025421.59847-1-bero@baylibre.com>
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

On Tue, Nov 15, 2022 at 03:54:06AM +0100, Bernhard Rosenkränzer wrote:
> This adds minimal support for the MediaTek 8365 SOC and the EVK reference
> board, allowing the board to boot to initramfs with serial port I/O.
> 
> GPIO keys are supported, MMC is partially supported (needs the clocks
> driver for full support).
> 
> v2:
>   - Add missing dt-bindings documentation
>   - Small cleanups addressing issues in v1 pointed out by Krzysztof Kozlowski

Other than this email, your patches are missing Content-Type headers yet 
are UTF-8 encoded. Looks like they've been edited in mutt as there are 
some mutt headers.

Rob
