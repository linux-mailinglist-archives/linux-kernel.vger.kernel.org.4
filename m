Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37284699ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBPRLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPRLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:11:06 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4064F31E0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=OkdQTz5QY6s5604d493x6osNCXYZggTtb4cgLgNxB5E=; b=frx4WhYsIROQeCuob8zYvPo64/
        WNV5iJq7KbgOc4/ZILh5emaiSviDnFllAtYZBsmi7y7tHws80ZcMvbmM3VhwmVVa1dYlVR8LHEjcX
        DXiWKo/AZM8l9gJYYzzSa3XgWKjs6u167/UYdj3eeA1SdTCbipLlGJRzjGjiG/nLbSGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pShmh-005CpA-7J; Thu, 16 Feb 2023 18:11:03 +0100
Date:   Thu, 16 Feb 2023 18:11:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 3/3] mfd: tqmx86: correct board names for TQMxE39x
Message-ID: <Y+5jp78f5+4kidWp@lunn.ch>
References: <59041b6d888c886edef5a97fc6e3319d235e101a.1676557968.git.matthias.schiffer@ew.tq-group.com>
 <31d3180d870dbfd386d5e21b3cdf2dd166f5d92f.1676557968.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d3180d870dbfd386d5e21b3cdf2dd166f5d92f.1676557968.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:34:24PM +0100, Matthias Schiffer wrote:
> It seems that this driver was developed based on preliminary documentation.

I cannot say anything about that. I just took the driver that Vadim
V.Vlasov <vvlasov@dev.rtsoft.ru> wrote and cleaned it up to kernel
standards and submitted it. I never found any documentation and i only
ever had access to one board to test on.

Thanks for fixing this.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


