Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D3867811D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjAWQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjAWQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:14:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C977B1041A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:14:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6836122A68;
        Mon, 23 Jan 2023 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674490473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x5NC6tI/oIxqD827mritRxDrqkayTHCyLe81Ki8EKE8=;
        b=VSuYUpUan3fqn07bwHmGqrJXbSBqmdmZYK2dxI5SP14O/wqZVNWJQNLxGjw1csXWIO3nKO
        ksmMC9AqCcSjxAcbijlxKQB3Z/UHQjJUSBZtGimbBe5JEkGYnhXZH3MsuFSkb8eOkNo7+5
        ZuTeG+uK7LSK+3x9tYQk78pSyXHuZ7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674490473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x5NC6tI/oIxqD827mritRxDrqkayTHCyLe81Ki8EKE8=;
        b=LiElTtFK0PYL9AX1XErQCQRJBc3ZTohTLQTE2CJiCQw5hIoGB2tjYQsqU2wroCmva1r7hK
        Q7Nnk0EYaL6ZfsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BC79134F5;
        Mon, 23 Jan 2023 16:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHpZFmmyzmOgbwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Jan 2023 16:14:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E1332A06B5; Mon, 23 Jan 2023 17:14:32 +0100 (CET)
Date:   Mon, 23 Jan 2023 17:14:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Diederik de Haas <didi.debian@cknow.org>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] udf: Fix full name of the GPL
Message-ID: <20230123161432.tcbq745zw32yibr3@quack3>
References: <20230122191603.59359-1-didi.debian@cknow.org>
 <20230123154839.k3d6maptnxvb3fw3@quack3>
 <2072706.5Xk3ikgrb0@prancing-pony>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2072706.5Xk3ikgrb0@prancing-pony>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-01-23 16:58:22, Diederik de Haas wrote:
> On Monday, 23 January 2023 16:48:39 CET Jan Kara wrote:
> > On Sun 22-01-23 20:16:03, Diederik de Haas wrote:
> > > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> > > ---
> > > fs/udf/ecma_167.h | 2 +-
> > > fs/udf/osta_udf.h | 2 +-
> > > 2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > Thanks. I've added the patch to my tree.
> 
> While I initially saw it as a spelling error, I've since changed my view that 
> it would actually be changing the license and I'm not qualified to do that.
> See https://lore.kernel.org/lkml/2281101.Yu7Ql3qPJb@prancing-pony/
> 
> While it seemed reasonable to *assume* that the GNU General Public License was 
> meant, I (now) think that is not sufficient when it comes to legal/license 
> material, which this is. I think, but I'm not a lawyer.
> 
> So maybe it's better to remove/revert it from your tree?

OK, let's err on the safe side ;) Patch removed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
