Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA87B699B22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjBPRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBPRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:20:49 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B17D4C3ED
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=QcjUGkibmgCxBwS3NHhY2rAisOGKoTmWL3SBXTC5uV4=; b=419c+feYwusDkRHRkE7KwLXb0Z
        5bd4Ya1GIS44kRyFrwCcVMltJOr1OEKq7N7b/goo7cAyYqlNcYeI733XHVOPFEuWh5DAL/7Ic3QZb
        K/L29XUClBMm41YTHkudN7N0F70UDSCenmeTSOkrzhkK3yPGrN1H76s5tKKDzcil9qos=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pShw7-005Ct7-2s; Thu, 16 Feb 2023 18:20:47 +0100
Date:   Thu, 16 Feb 2023 18:20:47 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 2/3] mfd: tqmx86: specify IO port register range more
 precisely
Message-ID: <Y+5l76f0z/NnPXxK@lunn.ch>
References: <59041b6d888c886edef5a97fc6e3319d235e101a.1676557968.git.matthias.schiffer@ew.tq-group.com>
 <ac7875ea1e3a650b223622457faab79fed5addbe.1676557968.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7875ea1e3a650b223622457faab79fed5addbe.1676557968.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 03:34:23PM +0100, Matthias Schiffer wrote:
> Registers 0x160..0x17f are unassigned. Use 0x180 as base register and
> update offets accordingly.
> 
> Also change the size of the range to include 0x19f. While 0x19f is
> currently reserved for future extensions, so are several of the previous
> registers up to 0x19e, and it is weird to leave out just the last one.
> 
> Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
