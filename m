Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3D6F4D97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 01:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjEBXbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 19:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEBXbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 19:31:51 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877F3591
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 16:31:46 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id D5ED1C01D; Wed,  3 May 2023 01:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1683070304; bh=6sjh6l6NERLsu+JXUQWin9N0CADzXow+URLH3qXqjjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3Hv3qoBmvA2YVtjpyNUs+nF5IJ/J44szGSFt1JURWHL/ojSGsv/FGfDEr+mojxp7
         fx03JZV1THs4MXhxSxKROhJyd2sbOlXfbQuCD88+/3dMWOLVFQh64gJA/qxdf5zB0n
         QrCyRWkCj5nwnh13j7PMjovfWf9+2mIlHkRC4ZWfBlRHxEKEBOfVpAYUgrFrjOlgxQ
         btfvzczW/qgeThngnFzs3R1K/2+DyDw33F3MKbYapTWvMumBfH0xOqbkN2grUSrnAU
         aes9sl9pXZxMdtMGbyld4baeNgY2vYUrItiyn9EXSZs5fouq1OVUxz8Yx4O2pjq4oP
         4eNiMN9KwO6yg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 7C83FC009;
        Wed,  3 May 2023 01:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1683070304; bh=6sjh6l6NERLsu+JXUQWin9N0CADzXow+URLH3qXqjjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3Hv3qoBmvA2YVtjpyNUs+nF5IJ/J44szGSFt1JURWHL/ojSGsv/FGfDEr+mojxp7
         fx03JZV1THs4MXhxSxKROhJyd2sbOlXfbQuCD88+/3dMWOLVFQh64gJA/qxdf5zB0n
         QrCyRWkCj5nwnh13j7PMjovfWf9+2mIlHkRC4ZWfBlRHxEKEBOfVpAYUgrFrjOlgxQ
         btfvzczW/qgeThngnFzs3R1K/2+DyDw33F3MKbYapTWvMumBfH0xOqbkN2grUSrnAU
         aes9sl9pXZxMdtMGbyld4baeNgY2vYUrItiyn9EXSZs5fouq1OVUxz8Yx4O2pjq4oP
         4eNiMN9KwO6yg==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id e9aa5fcf;
        Tue, 2 May 2023 23:31:39 +0000 (UTC)
Date:   Wed, 3 May 2023 08:31:24 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Remove INET dependency
Message-ID: <ZFGdTDrPa1LD899y@codewreck.org>
References: <20230501190602.86281-1-jandryuk@gmail.com>
 <ZFAWaQbDR1_r5jf-@codewreck.org>
 <CAKf6xptMDRVet-C_1H7txPb_J_xq+XnNxwrQVbNWL_2JGnbHgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKf6xptMDRVet-C_1H7txPb_J_xq+XnNxwrQVbNWL_2JGnbHgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Andryuk wrote on Tue, May 02, 2023 at 08:03:15AM -0400:
> > Good catch.
> > Could you add depends on INET to NET_9P_FD in net/9p/Kconfig?
> 
> trans_fd.o builds without INET and without UNIX.  Looks like trying to
> use either TCP or UNIX sockets would lead to runtime errors, but it
> also supports generic file descriptors.  That could be useful for
> someone.   Since it builds, would it be okay to leave this patch
> unchanged, or do you still want the depends added?  Leaving the patch
> unchanged provides more flexibility, though the runtime errors may
> surprise users.  While I built a Xen kernel without INET or UNIX, that
> is an unusual scenario.  Typically INET and UNIX sockets will be built
> in anyway even without a depends.

Hmm, good point; the socket interface is common between INET and
UNIX.. And you're right about the ability to use plain fd as well.

How about 'imply INET'? That will automatically select INET when
enabled, but allow someone to disable it explicitly.

It's rare enough that I didn't know about it though, just found it in
Documentation/kbuild/kconfig-language.rst ...
I guess this version is fine as is if you think it's too minor, I agree
kernels without INET ought to be rare enough and if it builds for
randconfig tests I'm fine with this.

-- 
Dominique Martinet | Asmadeus
