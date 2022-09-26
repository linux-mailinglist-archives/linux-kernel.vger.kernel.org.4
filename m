Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F995EB0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiIZTI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiIZTIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:08:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC62E23175
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=Lagm1lgiVICpYYlD6spdCWdL8atz+TcE9arjcgZyXHI=; b=KD
        QSmdTDonZqdmlUzSf4l7Iwy6+XgxPWBUnsOZ0J58yO9TSMQxxGQlmCCJi+E5DBizSecOd0ZV4fOGU
        C4Qiq6hQ4zaXGaUq1MpLJOfHsYc6G3t3kCOPOJ6NPhstzSOxtrwApyahtLvaTNcj8JwqvywJ2nWNp
        lQOLVGqdNHRuNuU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1octSd-000KoL-Hu; Mon, 26 Sep 2022 21:08:11 +0200
Date:   Mon, 26 Sep 2022 21:08:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Marcin Wojtas <mw@semihalf.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: kirkwood: enable Kirkwood driver for Armada 38x
 platforms
Message-ID: <YzH4m2piUuPcYJmD@lunn.ch>
References: <20220920132648.2008-2-pali@kernel.org>
 <20220926110533.13475-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926110533.13475-1-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 01:05:33PM +0200, Pali Rohár wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> The audio unit of Marvell Armada38x SoC is similar to the ones comprised by
> other Marvell SoCs (Kirkwood, Dove and Armada 370). Therefore KW audio
> driver can be used to support it and this commit adds new compatible string
> to identify Armada 38x variant.
> 
> Two new memory regions are added: first one for PLL configuration and
> the second one for choosing one of audio I/O modes (I2S or S/PDIF).
> For the latter purpose a new optional DT property is added ('spdif-mode').
> 
> kirkwood-i2s driver is extended by adding a new init function for Armada
> 38x flavor and also a routine that enables PLL output (i.e. MCLK)
> configuration.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Tested-by: Star_Automation <star@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Reviewed-by: Lior Amsalem <alior@marvell.com>
> Tested-by: Lior Amsalem <alior@marvell.com>
> Signed-off-by: Hezi Shahmoon <hezi@marvell.com>
> Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
> [pali: Fix support for pre-38x SoCs]
> Signed-off-by: Pali Rohár <pali@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
