Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC5673D69
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjASPXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:23:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A7548A0E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15F85614AE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA31C433D2;
        Thu, 19 Jan 2023 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674141824;
        bh=qaEs0nDtvp0ZtjyoQ1vwECp/cH7c+pc0ALExhEWHdZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3Av7k5MmHphBcPY58HZifb1vq6Lwd2J5C59+D5Ugpl/lkpvOo4jw7F5tk53k9Yh6
         z7xeu7Wtj/IyWtXb3p5RrB0yaH/7UgTkppQXsPwe7ZL+EccSlaxJAy9TT2H8jmp95/
         OwXoQYQXrrjLzQ6cHiidN110f5GhnL8Plk57h/P4=
Date:   Thu, 19 Jan 2023 16:23:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 0/3] VT: Support >32x32 fonts for hidpi displays
Message-ID: <Y8lgfoBoEcWyyWr7@kroah.com>
References: <20230119151914.931619963@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119151914.931619963@ens-lyon.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:19:14PM +0100, Samuel Thibault wrote:
> Hello,
> 
> This patch series adds to Linux and kbd the support for fonts larger than 32x32
> by dropping the oldish VGA constraints that don't apply to fb-based consoles.
> 
> The change from v2 is only to completely drop the sisusb part, so that it
> applies cleanly e.g. on latest Linus' tree.

That was fast, thanks!!!  I'll go queue this up now.


