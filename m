Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963495BE74E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiITNki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiITNkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:40:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F133DF00;
        Tue, 20 Sep 2022 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=uHsVIKwUI5dRJ3ABvK5Yix+1T5ZMOgqYYRMZklF24hY=; b=OD
        2gC41oRuuTQmUQYEDNo11mnHE4sllCw6danUWtGcNVmtXlRT712OV48GfTj+V7GM5H4srAEVsm3XG
        9BiIHPH+789MjfFvPlx8alNy9hsIcKt6yDh9kM15D5tso9GJhh2cKtFwpvqtTjVN0NdzNduAVbQ9p
        jHU+Z+NqvZJ+oSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oadU6-00HH6z-ON; Tue, 20 Sep 2022 15:40:22 +0200
Date:   Tue, 20 Sep 2022 15:40:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] ARM: mvebu: add audio I2S controller to Armada 38x
 Device Tree
Message-ID: <YynCxr4VKGeShFGR@lunn.ch>
References: <20220920132648.2008-1-pali@kernel.org>
 <20220920132648.2008-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920132648.2008-3-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:26:45PM +0200, Pali Rohár wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> This commit adds the description of the I2S controller to the Marvell
> Armada 38x SoC's Device Tree, as well as its pin configuration.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Tested-by: Nadav Haklai <nadavh@marvell.com>
> Tested-by: Lior Amsalem <alior@marvell.com>
> [pali: Fix i2s-pins name]
> Signed-off-by: Pali Rohár <pali@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
