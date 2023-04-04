Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A976D654D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjDDO1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjDDO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:27:37 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43544A7;
        Tue,  4 Apr 2023 07:27:32 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id j6so17136331ilr.7;
        Tue, 04 Apr 2023 07:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5fCjkpzhMrLdCd6YE6Gj8KInI7KEOI/E2WjYOm2J5E=;
        b=KvIdSC0s6EH+eVH3o8cyurD2j8+X6hK9DbulwcbLpAQ1troVojWe5oYWiH125vN8zC
         ey1gktt5MX3RMT3TC43HiqPOkyXkbimw9pGsFzaPtKdVbxpzYXfT9EndWRQQ8ORTddTQ
         zfpWdBPr6Vg0ft7jq8XKfTI+PAYyUXWEwtNgzqnN9NKQE33FazIXascPPZuXL/oEn4Wm
         tK0/Fa59x7JNFNQ4YULckF4wPGiAdOEeAq/LCvOWHm6n3F+SB//csjfs51ZMedqXuPmd
         KTgHnmDPwO5diAreRM9S/7v+XK/7QzsTyTTIT8ojyWYi5IKLydzdRecNw6Gw/DIpdDJ6
         tWlQ==
X-Gm-Message-State: AAQBX9e5OILydQPFetoBhROCCKEK0ZCQXboQrTuSgyoUUPqbwJsVJsrc
        gfWkI7XlRgB8J27cc0Dy5+H+tTlp1Q==
X-Google-Smtp-Source: AKy350Ybe9J9RjgT9nlmTSU6u1gQPWSSnkUo94oqYTwSnLUpGluAy7QTWx0ofhWEzV3bvW1FerTVqw==
X-Received: by 2002:a92:c80c:0:b0:326:2c14:a718 with SMTP id v12-20020a92c80c000000b003262c14a718mr2808220iln.32.1680618451529;
        Tue, 04 Apr 2023 07:27:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm12-20020a05663842cc00b0040631e8bf89sm3351879jab.38.2023.04.04.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:27:31 -0700 (PDT)
Received: (nullmailer pid 3836196 invoked by uid 1000);
        Tue, 04 Apr 2023 14:27:30 -0000
Date:   Tue, 4 Apr 2023 09:27:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 2/7] dt-bindings: phy: rockchip,inno-usb2phy: add rk3588
Message-ID: <168061844969.3836135.11919397961372852948.robh@kernel.org>
References: <20230403202307.120562-1-sebastian.reichel@collabora.com>
 <20230403202307.120562-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403202307.120562-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 22:23:02 +0200, Sebastian Reichel wrote:
> Add compatible for the USB2 phy in the Rockchip RK3588 SoC.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/phy/rockchip,inno-usb2phy.yaml   | 21 ++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

