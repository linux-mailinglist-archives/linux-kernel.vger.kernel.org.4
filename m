Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE306C244D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCTWNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjCTWNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:13:18 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491EF65BA;
        Mon, 20 Mar 2023 15:13:14 -0700 (PDT)
Date:   Mon, 20 Mar 2023 22:13:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679350392;
        bh=KSdQT7k7N7GHEaMkHF5+Yrr5WoqDVCJlRhrMOSHAodk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f430Xe/epq7KhYmX55uo0izJVp3KzAxBMVZqrNfj+ppvWmkWCijGWSjkAcPNHe3Zi
         8Tu06diQjyDH73UeInGo8w2U1FWemmF/m3Uku13BGaTPqirJiromBIKBMMZQWH6pF9
         ayvxUibiadsxxw2Wl9vO531xTX6PZdVRY/rn0h5s=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH 0/3] dyndbg: add source file name to prefix
Message-ID: <705ae57b-80af-4fae-a0c6-827db39711a6@t-8ch.de>
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

did you get a chance to look at this yet?

Thanks,
Thomas

On Mon, Jan 30, 2023 at 02:01:17AM +0000, Thomas Weißschuh wrote:
> Currently dyndbg has no facility to print the source file name of a
> debug statement.
> Without the source file the line number is of limited use.
> Also the dyndbg control file uses the filename as the primary index, so
> having it in the logmessage makes the relation clearer.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (3):
>       dyndbg: constify opt_array
>       dyndbg: increase PREFIX_SIZE to 128
>       dyndbg: add source filename to prefix
> 
>  Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
>  include/linux/dynamic_debug.h                     | 4 +++-
>  lib/dynamic_debug.c                               | 8 ++++++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> ---
> base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
> change-id: 20221223-dyndbg-filename-02e0879dae4b
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 
