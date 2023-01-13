Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D473566954D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbjAMLQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbjAMLNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:13:55 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0165E0BC;
        Fri, 13 Jan 2023 03:11:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B235860401;
        Fri, 13 Jan 2023 11:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673608314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3J2L5hmxRpKBaSiCc7h8MYxDTVoLFSS4O0+jYcCJsY=;
        b=uVAx7bB9c34/N3vTgwNEgqbEOcvZaNNDsADFemAbrnEXV8mD704qLYCTwvul4vfBMDhbn2
        f/GWdbJQW5i0DFFbqSEdaQjpsT3Ao5pYeIDhEo/jUBSL3Wgfnqz5/ofnJiXIjAjzmR9is+
        zBVRHH6gkSwAYLCmWm2wLpGZ0rOmgjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673608314;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3J2L5hmxRpKBaSiCc7h8MYxDTVoLFSS4O0+jYcCJsY=;
        b=POoDZ6rDhdVB2MQY3wInGAkmudjrq+wm6WLtcx1XK24khMJD/+MSm2lfNmuNdJuQzhLSiQ
        yjNWV7lZheYgQiAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97AE21358A;
        Fri, 13 Jan 2023 11:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Cd1JHo8wWMGLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 13 Jan 2023 11:11:54 +0000
Message-ID: <eb806f57-15bf-eb7c-97ff-8c4f5dfd2c84@suse.cz>
Date:   Fri, 13 Jan 2023 12:11:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: duplicate patches in the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230113142306.27e2ee60@canb.auug.org.au>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230113142306.27e2ee60@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 04:23, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in other -next trees tree as different
> commits (but the same patches):
> 
>   280691a45437 ("mm/slab: add is_kmalloc_cache() helper function")
> (commit 61df28eb7788f in the slab tree)

Oops, that was unintentional on the slab tree side. It's part of 2-patch
series where the second one also depends on other changes in mm tree, so
both are going through mm. Will drop, thanks.

>   a8197833a9d3 ("kernel/irq/manage.c: disable_irq() might sleep.")
> (commit 17549b0f184d ("genirq: Add might_sleep() to disable_irq()")
> in the tip tree)
> 

