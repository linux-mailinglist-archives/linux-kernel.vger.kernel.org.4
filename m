Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6407699B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBPRTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjBPRTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:19:36 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39144D600
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=pSG7F73R1rppNDNH3Xrp1LB6LUhL+JEyy8YTmbkRxXE=; b=J4XtXSmyhMe/Vd2uWFDon0Saiq
        s3uPORujAUy+a9Lpdl7r2cw5dMhaRCuAEWINHKWYdvt4MJGfLh2ybBieLXCC+pLGeDCs9jM9aCezM
        O4ZLxZAaWAG0b9mKn/HMZ66da7i+AumD/N2dNN4gMbMowJcYZsaM4Na4tB4fymgqYlcU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pShuw-005CsB-7Q; Thu, 16 Feb 2023 18:19:34 +0100
Date:   Thu, 16 Feb 2023 18:19:34 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 1/3] mfd: tqmx86: do not access I2C_DETECT register
 through io_base
Message-ID: <Y+5lptaM0cnj+WBi@lunn.ch>
References: <59041b6d888c886edef5a97fc6e3319d235e101a.1676557968.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59041b6d888c886edef5a97fc6e3319d235e101a.1676557968.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
> +	i2c_det = inb(TQMX86_REG_I2C_DETECT);

I think it would be good to add a comment, since it now looks out of
place compared to all the other ioread8().

      Andrew
