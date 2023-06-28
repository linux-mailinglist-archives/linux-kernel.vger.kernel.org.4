Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE06740FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjF1LWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjF1LWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:22:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C8199B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:22:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90A45612B7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B57C433C8;
        Wed, 28 Jun 2023 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687951334;
        bh=UdjHHtljdKh3TkXQroEwg38Q3AKyMrmSNqOVLycQtJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KP/PwtGwVBW3u/SU/ZVP3/tceDdK0E+OXV6gh9rkPageecR5oFeSyvJ0XrbFmI0/l
         t8HX9hoFcI+MHap1qdjlYEPfysK/iVKoo9XGM5NmzwIOHjMsWLBo//sbUmrbpxVv0g
         oP2uEFphx1ne6rwmHfUBPOcOi79LSQqKFfwofw7M=
Date:   Wed, 28 Jun 2023 13:22:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Graf <graf@amazon.de>
Cc:     Babis Chalios <bchalios@amazon.es>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, mzxreary@0pointer.de,
        xmarcalx@amazon.co.uk, Amit Shah <amit@kernel.org>
Subject: Re: [PATCH 0/1] User space notifications about VM cloning
Message-ID: <2023062834-lark-frostbite-9710@gregkh>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20f65557-766d-d954-f3ef-c26ad2b661dc@amazon.es>
 <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccec434-42f0-0ae8-8c7b-bea4646c5e7d@amazon.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 01:13:40PM +0200, Alexander Graf wrote:
> Hi folks,
> 
> On 16.06.23 17:07, Babis Chalios wrote:
> > Hello all,
> > 
> > Some time has passed since I sent this. Any comments/thoughts?
> 
> 
> Can we please get this merged somehow? Greg, any advise?
> 
> This is purely a device notification event to user space, similar to network
> link change events and the likes and has nothing to do with Jason's
> envisioned random reseed event exposure. We can happily send RFC patches for
> the latter after this is merged too.

Sure, I can take it, but it's the middle of the merge window and it's
too late for anything new right now, sorry.

I'll pick it up after 6.5-rc1 is out.

thanks,

greg k-h
