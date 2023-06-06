Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B76272447F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjFFNds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbjFFNdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677EF90
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686058375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4K8gWe/vXeGXdiuXcKDCaSMYee+Pu+IXT6rwjSGTxTs=;
        b=En5P2UWbSozakoqGFul0ojN5kBBMD2zeZrbC3PTVA65z9hRRG5khVkHIGt41mjdffoFtzt
        CTXap1xtemue4Tjddh/H8S9mXCS+EWSfZnxfuFtp1uXw6YHg0Ezw2nzWzmiFYtlyWQWaD5
        64piAY+MxNU0YvOSUhMi1s1fGTVlL5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-JbQHYiBjNJysPpkkV8bNYw-1; Tue, 06 Jun 2023 09:32:52 -0400
X-MC-Unique: JbQHYiBjNJysPpkkV8bNYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFAE3858F14;
        Tue,  6 Jun 2023 13:32:51 +0000 (UTC)
Received: from localhost (unknown [10.22.34.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 499429E93;
        Tue,  6 Jun 2023 13:32:51 +0000 (UTC)
Date:   Tue, 6 Jun 2023 10:32:50 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.180-rt88
Message-ID: <ZH81gpWRD+KxZlGO@uudg.org>
References: <ZHZSlJFnTK1IpXeg@uudg.org>
 <20230606094855.v8zhk78I@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606094855.v8zhk78I@linutronix.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:48:55AM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-05-30 16:46:28 [-0300], Luis Claudio R. Goncalves wrote:
> > Hello RT-list!
> Hi,
> 
> > Support for deferred printing was removed in v5.10-rc1-rt1 by commit
> > 9153e3c5cb0c9 ("printk: remove deferred printing").
> 
> Sorry for not getting back to earlier, where you proposed the change.

No problems at all. I will create an rt-only release with the changes you
mentioned and then restart testing with 5.10.181 and 5.10.182with these
changes.

Thank you again!

Luis
 
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index 83c7734e98025..92e0656841128 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -609,7 +609,7 @@ static inline void print_hex_dump_debug(const char *prefix_str, int prefix_type,
> >  #define print_hex_dump_bytes(prefix_str, prefix_type, buf, len)	\
> >  	print_hex_dump_debug(prefix_str, prefix_type, 16, 1, buf, len, true)
> >  
> > -#ifdef CONFIG_PRINTK
> > +#if defined(CONFIG_PRINTK) && !defined(CONFIG_PREEMPT_RT)
> >  extern void __printk_safe_enter(void);
> >  extern void __printk_safe_exit(void);
> 
> This needs to go entirely. The "new" printk code does not need this safe
> functions also for !RT.
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 5f1c50a6bebc5..7e65e3ef16e3a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6057,7 +6057,6 @@ static void __build_all_zonelists(void *data)
> >  	 * tty_insert_flip_string_and_push_buffer() on other CPU might be
> >  	 * calling kmalloc(GFP_ATOMIC | __GFP_NOWARN) with port->lock held.
> >  	 */
> > -	printk_deferred_enter();
> 
> That is okay. However the commit, that introduced this
> 	a992c387b4118 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
> 
> also added a local_irq_safe a little higher up and it has to go, too.
> The code as-is should produce warnings once it enters this path.
> 
> >  	write_seqlock(&zonelist_update_seq);
> >  
> >  #ifdef CONFIG_NUMA
> 
> Sebastian
> 
---end quoted text---

