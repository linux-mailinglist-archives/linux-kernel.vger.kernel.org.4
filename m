Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8B5BE755
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiITNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiITNlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:41:31 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BE43E64;
        Tue, 20 Sep 2022 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=Jh8iwPVSdo9zSHEgLJ83LwqnnxxcNEZPN4V8Cx7jJ6Y=; b=hc
        8LRCQwSgf0dJqaZ984Brtlu5wE0B35U8DK/RAr6QnuW/H0y29JwbffuxkgMOAeoPxGva/YQnAVGx1
        XLK3Lm7Q6lRs6Frgqq2aX8Vs+qW1Cldq4n90p8bu7FXeSJZ8AXa1OqIomGJ4svjBWyCHWKpntvIfg
        /RWFf/CiMSy5EAA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oadV7-00HH7d-3C; Tue, 20 Sep 2022 15:41:25 +0200
Date:   Tue, 20 Sep 2022 15:41:25 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] ARM: mvebu: add audio support to Armada 385 DB
Message-ID: <YynDBU/onOM8vzLr@lunn.ch>
References: <20220920132648.2008-1-pali@kernel.org>
 <20220920132648.2008-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220920132648.2008-4-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 03:26:46PM +0200, Pali Rohár wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> This commit adds the necessary Device Tree information to enable
> audio support on the Armada 385 DB platform. In details it:
> 
>  * Instantiates the CS42L51 audio codec on the I2C0 bus
> 
>  * Adds simple-card DT binding for audio on Armada 385 DB
> 
>  * Adds description for both analog I2S and S/PDIF I/O
> 
>  * Disabled by default
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
> Tested-by: Star_Automation <star@marvell.com>
> Tested-by: Lior Amsalem <alior@marvell.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
