Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E578168EEFF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjBHMdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHMdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:33:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DCD46AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBCBD616C2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78F1C433D2;
        Wed,  8 Feb 2023 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675859631;
        bh=YSGsMgMp0WvrPiFqf6V3+wia0fLCRW4B2b10cRrkjbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRlijVRxy2GcK9WefZEkbkAepqYOvvx1uVdfjtP8FDjG8hTpcX6c39EAGSHVcUom8
         iAA4lyB14fpeT3Ix49br8Dr8yVV4aEKU7do8SWwwugKT068RfAV3rJufCzo4JSto8L
         itnS7ygukGdU/Uxt07fx85SF2lGW1/FdxFwv1hsI=
Date:   Wed, 8 Feb 2023 13:33:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] const_structs.checkpatch.pl: add kobj_type
Message-ID: <Y+OWrAMLv3onxLAD@kroah.com>
References: <20230204-kobj_type-checkpatch-v1-1-9a94b04adbb2@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230204-kobj_type-checkpatch-v1-1-9a94b04adbb2@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 05:41:26AM +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  scripts/const_structs.checkpatch | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
> index 1eeb7b42c5b9..dc39d938ea77 100644
> --- a/scripts/const_structs.checkpatch
> +++ b/scripts/const_structs.checkpatch
> @@ -35,6 +35,7 @@ iwl_ops
>  kernel_param_ops
>  kgdb_arch
>  kgdb_io
> +kobj_type

Nice, I didn't realize we had such a list, thanks for this!

now queued up.

greg k-h
