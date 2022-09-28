Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFB5EE042
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiI1PZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiI1PYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:24:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2AD5BC3D;
        Wed, 28 Sep 2022 08:23:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D40C3B82034;
        Wed, 28 Sep 2022 15:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DC2C433C1;
        Wed, 28 Sep 2022 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664378634;
        bh=9SIVS1Ktay/VjvIG1Tb63vZHKdfb93SgqGY3i3lFWHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=seAUZILZ+WhEwxK58YX7ABSmr+ZqeVa/Q2ap9X2g653i2tjww1KSqfPR/bn1JQRF2
         BzBinLgdhYVGxfTdsXBc9BiSt+u4w8vsm10ziMZQ5jqNVcy33mctlyPXD3/ZuOqnJV
         KioubTnY6W/hQ8Iq3iowWuYMI41hf6F39VCm/cByErgfd6iBF4hzf1wAnjfYOTF0Hp
         kbTDmMcPnG9scsLXNrFz4o204QMW6P1YrO3HhCbx3Q8rr1J74Y5yVR+Jqf8huCEWen
         YiVD224EYn+z9TfM3Ww00DZrc2dZnhrkMnRMeVMC/wWDazLxkhXJfR/eeYCTXtc559
         El5hP+sh11vZw==
Date:   Wed, 28 Sep 2022 16:23:47 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sergiu.Moga@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, Kavyasree.Kotagiri@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v5 1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI
 child node ref binding
Message-ID: <YzRnAy0DrfBilz8d@google.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
 <20220922113347.144383-2-sergiu.moga@microchip.com>
 <YzRiVwzJYXtat1O5@google.com>
 <7a0c45e2-85fc-b5b0-d1de-a9e06a20bb42@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a0c45e2-85fc-b5b0-d1de-a9e06a20bb42@microchip.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022, Sergiu.Moga@microchip.com wrote:

> On 28.09.2022 18:03, Lee Jones wrote:
> > On Thu, 22 Sep 2022, Sergiu Moga wrote:
> > 
> >> Another functionality of FLEXCOM is that of SPI. In order for
> >> the proper validation of the SPI children nodes through the binding
> >> to occur, the proper binding for SPI must be referenced.
> >>
> >> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>
> >>
> >> v1 -> v2:
> >> - use full schema paths
> >>
> >>
> >> v2 -> v3:
> >> - Added Reviewed-by tag, previously this was [PATCH 3]
> >>
> >>
> >> v3 -> v4:
> >> - Nothing, previously this was [PATCH 5]
> >>
> >>
> >> v4 -> v5:
> >> - Nothing
> >>
> >>
> >>
> >>   .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml       | 5 ++---
> >>   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > Not sure how these can be handled.
> > 
> > I guess I cannot take these until the other patches are applied.
> > 
> > NB: The patch doesn't apply cleanly anyway, so will need to be rebased.
> > 
> 
> 
> Hello,
> 
> The sama5d2-flexcom binding related patches are dependent on:
> https://lore.kernel.org/linux-arm-kernel/20220916075744.1879428-1-kavyasree.kotagiri@microchip.com/

I would be very cautious about relying on comments made in the
cover-letter.  Better to make this a hard requirement and place them
in the same patch-set.

-- 
Lee Jones [李琼斯]
