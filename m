Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC55FEC0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJNJto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJNJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:49:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E1013CE1;
        Fri, 14 Oct 2022 02:49:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE68521980;
        Fri, 14 Oct 2022 09:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665740977;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Chc8cqCy7+7hV5FzunozPlYX2fd3eEbSewJ75xe2C0=;
        b=UNv/55UUJpTSrv2xw8+QTzzUg8rN1JIw8V6MngqcCimpCYt94mEmdcwl8Ocze1hRu1DDgM
        OVApkQQUq5eCicoZcPCnqGpEu95DWOlXpqocnX0riozgzqZrqL/i8U98EYtpWW61Twf8pX
        MDUs+amkOfE74ru7DpFPFIRP1a06Y04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665740977;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Chc8cqCy7+7hV5FzunozPlYX2fd3eEbSewJ75xe2C0=;
        b=C3SXhJHprY9vxP2JnTT1eboPNkdP+JNscnoMjQRG3OUHTjKbGk8vIPBjjsMEcY6N8wpokb
        9d9+wyj0+5uIrqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A7E513A4A;
        Fri, 14 Oct 2022 09:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UaudJLEwSWNrLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 09:49:37 +0000
Date:   Fri, 14 Oct 2022 11:49:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [GIT PULL] Kbuild updates for v6.1-rc1
Message-ID: <20221014094930.GB13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 11:29:44PM +0900, Masahiro Yamada wrote:
> Masahiro Yamada (35):
>       kbuild: remove the target in signal traps when interrupted
>       kbuild: add phony targets to ./Kbuild
>       kbuild: hard-code KBUILD_ALLDIRS in scripts/Makefile.package
>       kbuild: check sha1sum just once for each atomic header
>       kbuild: do not deduplicate modules.order
>       nios2: move core-y in arch/nios2/Makefile to arch/nios2/Kbuild
>       kbuild: remove duplicated dependency between modules and modules_check

This patch merged as f75a03340c2c2eea772e4d59412135021afea493 breaks
build of modules when it's specified by path like 'make fs/btrfs/'. The
'make M=fs/btrfs' works but I don't see any reason why the former should
stop working. Also the patch does not mention anything like that so it's
most likely a bug.
