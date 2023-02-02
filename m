Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D171687AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjBBKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBBKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:51:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52207304F;
        Thu,  2 Feb 2023 02:51:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24AB2B8255D;
        Thu,  2 Feb 2023 10:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FC3C433D2;
        Thu,  2 Feb 2023 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675335011;
        bh=1Y4msb8HKqisz6WtPDfC58eZbJAg0tpZAMC5s1XfPWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5uzUmvAh+yrTW3QZNlxMMS8lLvc40e4DSP2E384Hu9OxnyIlk4BnM6a7+Aaz0Qts
         Or6MDjLlwI8WvSoJ2D3Af8Nig4NI1A7rXPg4Q4N3/G5Q/9IoDfHvT5RMzLFxbI+Z0G
         GxFHoN+0BauQR3RHPBn/kHVcxzVlnx6BjDP4/bqk=
Date:   Thu, 2 Feb 2023 11:50:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 0/3] dt-bindings: serial/mtd/mc/ata: use MC peripheral
 props
Message-ID: <Y9uVWz32O1vuIXpk@kroah.com>
References: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127093217.60818-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:32:14AM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> Dependencies
> ============
> I think entire patchset should go via one tree (Rob's). Patch #2 depends on
> patch #1.  Patch #3 could go separate tree as long as others are in the
> linux-next.  However for simplicity let's push everything through Rob's DT
> tree?

No objection from me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
