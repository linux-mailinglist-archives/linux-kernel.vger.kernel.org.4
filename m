Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F6620EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiKHLVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiKHLV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:21:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F155DF588;
        Tue,  8 Nov 2022 03:21:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AF7B31F88B;
        Tue,  8 Nov 2022 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667906484;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xbmkf20b3GGM4eZ0HtjGYF5NWspQjalhLC9Jm7fCMLE=;
        b=ozJeG2GsmeG+ccya43ePXnCpQNI9eUSKS+zwcf3kmw0gbiou08Ttk4NUYP0Cr+ZK1Tvkey
        y9/dqlPHaSN4EjVFfZthECFTeiKHRXa/P09gwqdt4n70JMuJa5+RQXXHy0XoW65SajdfFX
        C0XtcGQVBVvqhBhgz1C60rWH0nMD/vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667906484;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xbmkf20b3GGM4eZ0HtjGYF5NWspQjalhLC9Jm7fCMLE=;
        b=jbHPkmkZ5J/MQ4g0AHvcgpzjHlv2izR25fX6Ksj+7aGZEGZlBfjOJfpyeIT4iyrmHxJ3AZ
        Ls3bEBVD3LTTXCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DDAD139F1;
        Tue,  8 Nov 2022 11:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x0/EHbQ7amOhNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 08 Nov 2022 11:21:24 +0000
Date:   Tue, 8 Nov 2022 12:21:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the btrfs tree
Message-ID: <20221108112102.GX5824@suse.cz>
Reply-To: dsterba@suse.cz
References: <20221108094229.1b530fec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108094229.1b530fec@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 09:42:29AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the btrfs tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ld: fs/btrfs/messages.o:(.opd+0x90): multiple definition of `abort_should_print_stack'; fs/btrfs/ctree.o:(.opd+0x270): first defined here
> ld: fs/btrfs/messages.o: in function `.abort_should_print_stack':
> messages.c:(.text.unlikely+0x55c): multiple definition of `.abort_should_print_stack'; fs/btrfs/ctree.o:ctree.c:(.text.unlikely+0x0): first defined here
> 
> Caused by commit
> 
>   8bb808c6ad91 ("btrfs: don't print stack trace when transaction is aborted due to ENOMEM")
> 
> from the btrfs-fixes tree interacting with commit
> 
>   c6f1e8101ccc ("btrfs: don't print stack trace when transaction is aborted due to ENOMEM")
> 
> from the btrfs tree.
> 
> I applied the following merge fix for today.

Thanks. We have development branch that moved a lot of code and fixes to
mainline are in different files. Locally I see that for-next builds fine
because the next-fixes is not merged to it but the linux-next tree
merges both. I'll do more build checks, sorry for inconvenience.
