Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED57418F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjF1TjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:39:17 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:59262 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjF1TjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:39:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5684261455;
        Wed, 28 Jun 2023 19:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677A3C433C0;
        Wed, 28 Jun 2023 19:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687981152;
        bh=83XYM/DReKyvcU92JrKZ+ZnnQewtSZEK6Hq/ZNfGPNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qi2MP1VAVewD4qR1RN4jCHNVMVxB0e2KLvnuf8uaaMUGiCHR5CfyxkXY4CNKRVbaV
         t2kXilzoYfqtDaLGvRKrNppHiCNFsbJdHrjLwtoHD0odhYZvwllS15XUXmV/he0XE4
         oBb8cB3e1pwZxGqdFgke1gb7jpPg5JSPsDESbwRo=
Date:   Wed, 28 Jun 2023 21:39:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     ashok.raj@intel.com, tglx@linutronix.de,
        stable-commits@vger.kernel.org
Subject: Re: Patch "x86/smp: Cure kexec() vs. mwait_play_dead() breakage" has
 been added to the 4.14-stable tree
Message-ID: <2023062859-snowboard-surrogate-8484@gregkh>
References: <2023062810-override-roundup-e5bf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023062810-override-roundup-e5bf@gregkh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:32:12PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     x86/smp: Cure kexec() vs. mwait_play_dead() breakage
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      x86-smp-cure-kexec-vs.-mwait_play_dead-breakage.patch
> and it can be found in the queue-4.14 subdirectory.

Oops, nope, this breaks the build on 4.14.y :(
