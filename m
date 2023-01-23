Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE65B678561
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjAWSyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjAWSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:54:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC85B83;
        Mon, 23 Jan 2023 10:54:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DC79B80DCC;
        Mon, 23 Jan 2023 18:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56358C433D2;
        Mon, 23 Jan 2023 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674500076;
        bh=FiuZdAGaNp61IwZfVi5rwYsfc6AAKrsNLyQa186Ax10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQO+XLBoJ/LxXEDBWLfYkAvx7Si+sExBRUBvFfl40v9sNk3VcQrC1GGEz/PLiSqOI
         UtZ0aGLb9Rqge+Oxab2mi9WoC1MmfamurEfi+vNUAcgxgjaILp8wtQRzkVWgW+Cnwx
         e8j+RzqxdZ+BiImyYfQTokjQy3VFhPjcOYviwho0=
Date:   Mon, 23 Jan 2023 19:54:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     corbet@lwn.net, javier.gonz@samsung.com, linux-doc@vger.kernel.org,
        a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        ndesaulniers@google.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof.c@samsung.com>
Subject: Re: [PATCH] docs: embargoed-hardware-issues: add embargoed HW
 contact for Samsung
Message-ID: <Y87X6tFlevIebcc6@kroah.com>
References: <20230123183926.249601-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230123183926.249601-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:39:26AM -0800, Luis Chamberlain wrote:
> After discussions internally at the company, Javier has been volunteered
> and is willing to be the embargoed hardware contact for Samsung.
> 
> Cc: Javier González <javier.gonz@samsung.com>
> Signed-off-by: Luis Chamberlain <mcgrof.c@samsung.com>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index b6b4481e2474..fbb754253cf7 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -251,6 +251,7 @@ an involved disclosed party. The current ambassadors list:
>    IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
>    Intel		Tony Luck <tony.luck@intel.com>
>    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> +  Samsung       Javier González <javier.gonz@samsung.com>

No tab?  :(
