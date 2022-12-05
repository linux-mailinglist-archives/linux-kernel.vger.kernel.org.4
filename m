Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0C6437E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiLEWSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiLEWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:18:33 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9BFE55;
        Mon,  5 Dec 2022 14:18:32 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id z14-20020a9d65ce000000b0067059c25facso57392oth.6;
        Mon, 05 Dec 2022 14:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=govnLjrP4Fxj7sUdOxeHJG+6MGMttXc6o52TAF+aeA0=;
        b=QbWSoeGFzC19rdokOlZVzvNUE2//9KBZla5MmpEMUZIC6agw0ogloZahSHbXHyAga2
         Ff5MdUB08/31U4usLKZhHaqEU1ZBP27RI6/8M7h9Nyy6xI5atDzSD6FmXGgaGZDwBS1v
         t/MFP1bbjlQbNCbcW7OIkgAs3kI/ptLpXMztJZEf6pxQHFLulx4euwbTvyFTzVH2dksW
         pGt+E5LtgqTbE8MXarb6qiTdyMZ4P2+tK9dydTfROdyftjf5Gco9JDPa3x7BbgyFZ0Do
         l7H8MpD3aUEqkSRadhxSY19aFH0F12p6XxC02So34BOya2H/+tsZSioEmCSVelj/hs16
         X/mg==
X-Gm-Message-State: ANoB5pmKI8yu6/dhcSSK1kaM7Z6mtlaA2NlHKInv1PpHTmos52IgsAuc
        HLQjotAJmtrcWhfs6rlpuA==
X-Google-Smtp-Source: AA0mqf6/sq0WFJP34e6KMdd5mSKmtAGYbu/PteD4TUYhuBeIHJ1QaRCLzKkKd9ek2ynXll/km6R32w==
X-Received: by 2002:a05:6830:201a:b0:66c:49e4:82f8 with SMTP id e26-20020a056830201a00b0066c49e482f8mr42203483otp.371.1670278712005;
        Mon, 05 Dec 2022 14:18:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cm5-20020a056830650500b0066b9a6bf3bcsm8209874otb.12.2022.12.05.14.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:18:31 -0800 (PST)
Received: (nullmailer pid 2788580 invoked by uid 1000);
        Mon, 05 Dec 2022 22:18:30 -0000
Date:   Mon, 5 Dec 2022 16:18:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] dt-bindings: leds: irled: gpio-ir-tx: convert to DT
 schema
Message-ID: <167027870915.2788492.2674725720889099343.robh@kernel.org>
References: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204104323.117974-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 04 Dec 2022 11:43:21 +0100, Krzysztof Kozlowski wrote:
> Convert the GPIO IR LED bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/leds/irled/gpio-ir-tx.txt        | 14 --------
>  .../bindings/leds/irled/gpio-ir-tx.yaml       | 36 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 37 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.yaml
> 

Applied, thanks!
