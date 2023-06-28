Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB417418FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF1Tkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjF1Tkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CEE1BE8;
        Wed, 28 Jun 2023 12:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01DE46145E;
        Wed, 28 Jun 2023 19:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF58C433C8;
        Wed, 28 Jun 2023 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687981231;
        bh=PjICkIsEO4cNRymDTDZN2WwPqCjqTKxRlWt52yCM0Ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYC/WTGnr0zkC1k+NEtaWRNlexegfZ+JmCbcWUatFez+LSajfD6Tuz4HTleTDQ1OF
         dP61joqvFRW9owRpinSLnWClmwXEaaPYp1P6nk5PldEFJsM2Eh6B7bRH9O3mRb/V2p
         ryuiNv5xnd/V7m3TI4RF8hmwZX21SvKjnH++1ofg=
Date:   Wed, 28 Jun 2023 21:40:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ashok.raj@intel.com, tglx@linutronix.de,
        stable-commits@vger.kernel.org
Subject: Re: Patch "x86/smp: Cure kexec() vs. mwait_play_dead() breakage" has
 been added to the 4.14-stable tree
Message-ID: <2023062812-regime-demote-14f8@gregkh>
References: <2023062810-override-roundup-e5bf@gregkh>
 <2023062859-snowboard-surrogate-8484@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062859-snowboard-surrogate-8484@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:39:09PM +0200, Greg KH wrote:
> On Wed, Jun 28, 2023 at 09:32:12PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     x86/smp: Cure kexec() vs. mwait_play_dead() breakage
> > 
> > to the 4.14-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      x86-smp-cure-kexec-vs.-mwait_play_dead-breakage.patch
> > and it can be found in the queue-4.14 subdirectory.
> 
> Oops, nope, this breaks the build on 4.14.y :(

And on 4.19.y, 5.4.y, 5.10.y, and 5.15.y, so dropped from all of them as
well.
