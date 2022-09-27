Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435D85EC9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiI0QkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiI0Qj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:39:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A6A59A7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 259A1B81C6E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 16:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896D2C433B5;
        Tue, 27 Sep 2022 16:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664296788;
        bh=+Ks04nNf/THltbyLOuBIwtvvZrQfvyac1+7jX+TrvKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWkl6TaeM0qEr9+xTncUetZKi9PngE4Vyy7qKo3fz4/hTx2lTqDvsrhIBn2dRph5H
         dRSqtlZdC2UUi2E+4y+7JMKkCSWoQC7e5vtwr4V92z92DxtFhbqzS6qtNVPGLhuFpw
         WJqRC+nsIBH4mSrQt/GOCNtL+AM1ot9CmjIJbKwA=
Date:   Tue, 27 Sep 2022 18:39:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Milan Broz <gmazyland@gmail.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: fix a crash when two processes delete the same
 directory
Message-ID: <YzMnUvz+eirBpRVi@kroah.com>
References: <alpine.LRH.2.02.2209260418360.16612@file01.intranet.prod.int.rdu2.redhat.com>
 <YzGYFBv0pdt+DQg+@kroah.com>
 <alpine.LRH.2.02.2209271206240.5208@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2209271206240.5208@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:09:19PM -0400, Mikulas Patocka wrote:
> 
> 
> On Mon, 26 Sep 2022, Greg Kroah-Hartman wrote:
> 
> > Can you see if 4abc99652812 ("kernfs: fix use-after-free in
> > __kernfs_remove") in linux-next fixes this for you or not?  It seems to
> > be the same issue, as was also reported at:
> > 	https://lore.kernel.org/r/7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp
> > 
> > thanks,
> > 
> > greg k-h
> 
> I'm running the test with the patch 4abc99652812 for 3 hours, no crash, so 
> it's probably ok.
> 
> Tested-by: Mikulas Patocka <mpatocka@redhat.com>

Wonderful, thanks!

greg k-h
