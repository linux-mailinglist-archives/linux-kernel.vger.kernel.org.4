Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F98664385
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjAJOpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjAJOpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:45:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C7E1788C;
        Tue, 10 Jan 2023 06:45:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2746C6A7F8;
        Tue, 10 Jan 2023 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673361937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bC7TP9mQzckaGSKeAgIsfBs+hsL/F5D88B/c4h6SvvM=;
        b=KqGglBhGbeuUm4Pf7SpeJZYqnx4pOakUzbwLfoQWOP2VwlGvhlhFsIWj65cauX1vlogGut
        57HmdR4hLyUJ0r/1h1KkQQQM4xz+3cq3EuPHl9PHVUDSeFL6wqvWAew+7oCtv7AVRvRy2r
        v8PlIg6XboFdKg7sF/6UlRwbLgnMeDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673361937;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bC7TP9mQzckaGSKeAgIsfBs+hsL/F5D88B/c4h6SvvM=;
        b=bNO/lTbjWLVmhqYQMRQVnKKymix2GV+v/0v7D9T43FMqOpUZdcuJIc9CcUm7D/fRmEqkPE
        knBqYeGaxOzFdEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A87F1358A;
        Tue, 10 Jan 2023 14:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8hduBhF6vWPqaAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 10 Jan 2023 14:45:37 +0000
Date:   Tue, 10 Jan 2023 15:45:36 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/rtla: Explicitly list libtraceevent dependency
Message-ID: <20230110144536.knepnpxsp4mw67no@carbon.lan>
References: <20230110131805.16242-1-dwagner@suse.de>
 <42d1e999-79a6-94dc-cc88-77520ddce068@kernel.org>
 <20230110140814.2yz4if2e2fasnu7t@carbon.lan>
 <94fd6fb5-c87a-b02e-40bc-b2e2c99529d5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94fd6fb5-c87a-b02e-40bc-b2e2c99529d5@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 03:19:25PM +0100, Daniel Bristot de Oliveira wrote:
 > FWIW, this is change is also backwards compatible, meaning if you have system
> > which has a libtracefs.pkg installed which lists libtraceevent in its Libs:
> > section the 'pkg-config --libs libtracefs libtraceevent' command will return the
> > identically string which is '-ltracefs -ltraceevent'.
> 
> Yeah, we know it. I've added both in the initial implementation, but Steven suggested
> using only libtracefs because it depends on libtraceevent anyways. That is why
> I am re-checking with him.

Just to clarify, the generated pkg file by Meson is adding the libtraceevent
dependency in the private section. So this part should be okay. I would be
surprised if Meson would get this wrong at this point.

$ cat .build/meson-private/libtracefs.pc
prefix=/tmp/trace-cmd
includedir=${prefix}/include
libdir=${prefix}/lib64

Name: libtracefs
Description: Manage trace fs
URL: https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
Version: 1.6.3
Requires.private: libtraceevent >=  1.7.0
Libs: -L${libdir} -ltracefs
Cflags: -I${includedir}/libtracefs
