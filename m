Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC56A96F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjCCMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCCMFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:05:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784391ACD1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:05:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF81617EF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB79C433D2;
        Fri,  3 Mar 2023 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845103;
        bh=3ZOGjIGeWwNTIrXyru4KB/MWI02fW2QP2DojpewzzTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJK84A9UOby+6cD8m2o/2ywdSIXzwqjN7GUkBh+pCqaejur8SuMkxGNyEvykguuu0
         C/tdr/njUgazUEn0xl3g3NK97VLe+gLZ9PUlFH/rAZzK0WwMCeiZMecYwlQ1xrsoFW
         GBVgHP90kzGmiSabnZCJh/I0bu6VgewavY61RMF0k5XWfQ/zRpkVpu4JFXqDDFLrP4
         6MD9bj6sLbk/WViQ8pZcRVIpN+Bj8CF8JjzT4TXr2iPAUVED0TrSfXL/LN8NOmYRUX
         Bz0LUoGAYBmvuOR0N3MkbDHBuGuxpmygpgAk0ofUu7PWG5X1gaE3xaLZzCsUQAzIBH
         mILisBocHwrmg==
Date:   Fri, 3 Mar 2023 12:04:59 +0000
From:   Lee Jones <lee@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH v2 2/3] mfd: tqmx86: specify IO port register range more
 precisely
Message-ID: <20230303120459.GK2420672@google.com>
References: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
 <db4677ac318b1283c8956f637f409995a30a31c3.1676892223.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db4677ac318b1283c8956f637f409995a30a31c3.1676892223.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023, Matthias Schiffer wrote:

> Registers 0x160..0x17f are unassigned. Use 0x180 as base register and
> update offets accordingly.
> 
> Also change the size of the range to include 0x19f. While 0x19f is
> currently reserved for future extensions, so are several of the previous
> registers up to 0x19e, and it is weird to leave out just the last one.
> 
> Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> Notes:
>     v2: add Reviewed-by from v1
> 
>  drivers/mfd/tqmx86.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
