Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A535774D98E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjGJPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjGJPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:07:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F45D7;
        Mon, 10 Jul 2023 08:07:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3299C2000E;
        Mon, 10 Jul 2023 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689001650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7KXAFrQvuPr49rnyKVo0FOaAIy4o+Fv6v+KDOhj24M=;
        b=tVfZba1W3Y5eJu1lFnDi0pQ/3W7y65Pp899BjQim4yzG5gLKTaSrHDlEPL6TXKl/6jKTOK
        jioUvh9thGJShyLSIJEPX+7p7XVkmh2DiZDtbGuMiLrp1wJPcsh5O43kreeBlwK2lsh5pi
        AQ5pUzjZFDgPszmNNLeNv/cGzaGj4fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689001650;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x7KXAFrQvuPr49rnyKVo0FOaAIy4o+Fv6v+KDOhj24M=;
        b=UHH1aZiyHlZRWstBrfxYXxrjtQog6vE+pD9yz3WbT+w/pD5aKqMYqCk0mIDDVNayRyDbLg
        DmqryRsf1EnyNvBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ECC1913A05;
        Mon, 10 Jul 2023 15:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VHz1M7EerGQlWAAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 10 Jul 2023 15:07:29 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: linux-next: branches to be removed
References: <20230710172602.05d32c03@canb.auug.org.au>
Date:   Mon, 10 Jul 2023 11:07:28 -0400
In-Reply-To: <20230710172602.05d32c03@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 10 Jul 2023 17:26:02 +1000")
Message-ID: <87wmz7rej3.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> unicode			2022-04-28 18:19:09 -0400
>   git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git       for-next
>
> These branches are all empty except the last which just contains a
> commit that is the same patch of a commit in Linus' tree.

Please, keep it.  It is not a busy area for development, but we I'm
looking into a unicode version update soon that will go through
this tree.

-- 
Gabriel Krisman Bertazi
