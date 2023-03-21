Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217736C2A81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCUGgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCUGgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B355B19134
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3131619AF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A62C433D2;
        Tue, 21 Mar 2023 06:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679380562;
        bh=hjpmKVCfJjiunCS+UqjKpfVFOG/NCn48vxCrtPdc2f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQVTeiPu8ROJvAK212VTcjbazQfY9IU4l9qXHA8eOgk6V6D7R/MawW8rbGRj9MJaQ
         gFEjD9VSLhMD8BJL03vnXozWWRuxJomyPVJRqH5TMEC/QQPd2mFuCpntSoB2nUPWrk
         JB5Omyyxs34DCs3NdUZ1qJTVyAOUqfGNxUz0kpbQ=
Date:   Tue, 21 Mar 2023 07:35:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Message-ID: <ZBlQT2Os/hB2Rxqh@kroah.com>
References: <20230320182103.46350-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320182103.46350-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:21:03AM +0800, Yangtao Li wrote:
> ecryptfs has been inactive for a long time, and in fact the filesystem
> has no active maintainers. I sent a patch last August, no response
> till now. Let's mark it as Orphan status.
> 
> Maybe in 2025 we can remove this unmaintained file system?
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Why send this to me?

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 541e7dc05f48..4a6236d5a6ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7270,7 +7270,7 @@ F:	drivers/media/dvb-frontends/ec100*
>  ECRYPT FILE SYSTEM
>  M:	Tyler Hicks <code@tyhicks.com>
>  L:	ecryptfs@vger.kernel.org
> -S:	Odd Fixes
> +S:	Orphan

Why not also cc: the two email addresses here?  And if this is really
orphaned, then remove them as well, right?

>  W:	http://ecryptfs.org
>  W:	https://launchpad.net/ecryptfs
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git

These all too need to go if this really is orphaned code.  But first,
try sending it to the right people (like the linux-fs mailing list as
well?)

thanks,

greg k-h
