Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E269D848
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBUCEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjBUCEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:04:04 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E529914498;
        Mon, 20 Feb 2023 18:04:03 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id bg11so2871422oib.5;
        Mon, 20 Feb 2023 18:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u1dqJgOyyF1gVqdLsNGzGEEgiXpoRAuhWlKicwwL2E=;
        b=Xsu9k6oEVUKXPebChxwQr4gSgrMantGX/RpSYihGCxdGmGTUIp9BL9bqFwCTiI3J9R
         Ofz+g6Uv4LymDdAzW6j50xci4k1VeatAZiBI7aYx3ABFD4i3j2p4Kam5n84BphL1JnGC
         643b8CRpj2GhuN0jiLPXwfygg0e5VryoRAQGJ+GKe45M4J//el61qTw1PVUBKrRlRWFh
         6v24sjbuvrCC5QO/10kEEgg4wbX8ZRNmEoGu84YMUYQ/CmcXhyaETlmaWz8XUesZoLmz
         0wzf3Gfz9i9L6YphPDqUeznmMEuw+bQSyIoGlHz5U0dcBaPAvc3t3lIJNVvd3xvE5s+7
         vC2Q==
X-Gm-Message-State: AO0yUKXMUWi2tIDYa7Q7fsIB8pJhMUoc5WHuog2njhwyVudLfmx/qaJ2
        KOskX1BtLVlvSWPD3Gcxck1c1VOGDw==
X-Google-Smtp-Source: AK7set+Mhv11/kQ/8HGMt4nvXDhitVgC4Qw5M0iyD3Q5Rm7A6Zy3pxuo2Sve9oVNjfKCoVHlMonQmA==
X-Received: by 2002:a05:6808:48e:b0:37a:d6dc:a742 with SMTP id z14-20020a056808048e00b0037ad6dca742mr5070574oid.6.1676945043155;
        Mon, 20 Feb 2023 18:04:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p84-20020acabf57000000b0037841fb9a65sm5544242oif.5.2023.02.20.18.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:04:02 -0800 (PST)
Received: (nullmailer pid 814909 invoked by uid 1000);
        Tue, 21 Feb 2023 02:04:01 -0000
Date:   Mon, 20 Feb 2023 20:04:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andrew Davis <afd@ti.com>, kernel@pyra-handheld.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        letux-kernel@openphoenux.org,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: fix compatible record for GTA04
 board
Message-ID: <167694504105.814849.13739306703872130380.robh@kernel.org>
References: <38b49aad0cf33bb5d6a511edb458139b58e367fd.1676566002.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b49aad0cf33bb5d6a511edb458139b58e367fd.1676566002.git.hns@goldelico.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2023 17:46:43 +0100, H. Nikolaus Schaller wrote:
> Vendor of the GTA04 boards is and always was
> Golden Delicious Computers GmbH&Co. KG, Germany
> and not Texas Instruments.
> 
> Maybe, TI was references here because the GTA04 was based on
> the BeagleBoard design which is designated as "ti,omap3-beagle".
> 
> While we are looking at vendors of omap3 based devices, we also
> add the record for OpenPandora. The DTS files for the pandora
> device already make use of it.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  arch/arm/boot/dts/omap3-gta04.dtsi                     | 3 +--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

