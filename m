Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7A667CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjALRoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240345AbjALRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:44:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDE718A6;
        Thu, 12 Jan 2023 09:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13451B81ED9;
        Thu, 12 Jan 2023 17:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB20FC433EF;
        Thu, 12 Jan 2023 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673542981;
        bh=vXMxe8Lys61OG4HEhooEd7XMUn0HYqZGcKqpMKIc+yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEmDJtMaHXDcx7z27pzFdlq6Dr/UhDqk1VYHEw7aofW022EaHBu54AAreRtWeIfop
         mXEHxfBm57MUdjxj/5FfTeESU7KQJ5jXacvNtdIaO809s5bZpsK4P9pnUeGU56k7Sx
         PNLTpMxLYa/u/g0+yke/pbKxjP1YVLjieBQAKf4z0WsO+NQmOU8fUI99OOM/8FwBRc
         0FzfhzKOEdTf2/GVwcBYxh7sgHhVjgigRwl7ujI/ArqkbRUndtaX/CJDCZCv3qY05P
         NCc4aZ385L+Uvnk+NEYiG5YOd0sjlZhyJv/WgY8yVjro+dH4EnW18uKrB56GJpHH7F
         WAUVxeNRhP0yQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pG0yr-0006jV-E0; Thu, 12 Jan 2023 18:03:09 +0100
Date:   Thu, 12 Jan 2023 18:03:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Michael Adler <michael.adler@siemens.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] USB: serial: cp210x: add SCALANCE LPE-9000 device id
Message-ID: <Y8A9TWhDEN2pm42Q@hovoldconsulting.com>
References: <20230103134850.53229-1-michael.adler@siemens.com>
 <20230103134850.53229-2-michael.adler@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103134850.53229-2-michael.adler@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 02:48:50PM +0100, Michael Adler wrote:
> Added the USB serial console device ID for Siemens SCALANCE LPE-9000
> which have a USB port for their serial console.
> 
> Signed-off-by: Michael Adler <michael.adler@siemens.com>

Applied, thanks!

Johan
