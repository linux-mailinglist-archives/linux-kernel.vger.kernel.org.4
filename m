Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A30D6B6720
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCLOWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:22:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2873D0A3;
        Sun, 12 Mar 2023 07:22:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3DB5B80B4F;
        Sun, 12 Mar 2023 14:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB15C433D2;
        Sun, 12 Mar 2023 14:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678630931;
        bh=lxsoEfDwQTGwfTXIMqI8LaENNncVMNMnOPZu+T+NMWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LlVcfbFmhlrLQVlL/Dw5YfDdx/C0QVxNr+IMMZF+M3QHYuTkxWd434Rm1pEVl3C4X
         kRFM94pdYaMBy8WG1w5kN4UWNbSHqb88t4S8eEkOYCzOoXUGBQWlFQ3U71Xz15dw41
         Ac7DoZmS1zq+OoG+aKdIWTFMpBIrqjFQM4A84lnEIGkKmhSW6NrB1Zxnz83JLUcicP
         xFuXVxWOZQeIf3DU9DCDEvogLqY6Z9Jpzdqcfmgwy7yhZJJWrZiC1AT15spnXLL07U
         rRpzJtZTaZYo3+JXGwKB98E9wkX1+2owKjGE3YUAmdr10WFbGMmyc1sYYFExbBOO+l
         fxpaXk6Nph7KA==
Date:   Sun, 12 Mar 2023 14:22:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: light: add apds990x binding
Message-ID: <20230312142215.13ff34a2@jic23-huawei>
In-Reply-To: <e6cb5a4f-30ac-3918-c188-cd14ef31f780@linaro.org>
References: <20230308090219.12710-1-clamor95@gmail.com>
        <20230308090219.12710-2-clamor95@gmail.com>
        <20230311193426.5b1b7e53@jic23-huawei>
        <e6cb5a4f-30ac-3918-c188-cd14ef31f780@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 11:47:19 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 11/03/2023 20:34, Jonathan Cameron wrote:
> 
> >> +
> >> +additionalProperties: false
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupt  
> > It would nice to relax the need for an interrupt if the device is still useable
> > with timeouts etc.  Board folk have a habit of deciding they don't need to wire
> > up interrupts.  We can relax that a later date though if you prefer not to do
> > it now.  
> >> +  - vdd-supply
> >> +  - vled-supply  
> > 
> > Whilst true that the supplies need to be connected, that doesn't
> > mean they need to provided in the device tree binding.  If they are
> > always powered up I think we can fallback to stub regulators.  
> 
> We can, but others might not. The binding should still require them if
> they are required for device to work. Mark also made it clear recently:
> 
> https://lore.kernel.org/all/31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk/
> https://lore.kernel.org/all/5cd6764c-9b04-42ea-932d-9f14aa465605@sirena.org.uk/
> https://lore.kernel.org/all/f6f02138-8ef9-4a33-9b51-0b7cd371230f@sirena.org.uk/


OK. Then there are a lot of bindings to fix. Seems odd to me but meh it's
not something I care about.

Note this means that we can't have trivial-device.yaml for instance.

Ah well, I guess views change or crystallise over time or just differed
in the first place.

Jonathan

> 
> Best regards,
> Krzysztof
> 

