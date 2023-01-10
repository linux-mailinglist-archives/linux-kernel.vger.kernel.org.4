Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44D5664424
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbjAJPJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbjAJPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:09:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D35D410;
        Tue, 10 Jan 2023 07:08:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9E7CD772FE;
        Tue, 10 Jan 2023 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673363307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMbfvw9VPhE4xhx9UJlu8IMWthM+lSG29AO9lWd2ERk=;
        b=HIFyKH+16P3kVvQ2Ml5w5VXXiMvn9nLN2x7nVlYmiOfz+FIq8kFB40luGChq4q2WKCCFBS
        dByMFrJnSegbAb2P9hUUBarIBYZXp2myBfacrljj5+nDmbbI+KGF8AMHjFTEF8uQFacG/H
        DZBru62KB5LE/ENqkHtbK98dbKqAzqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673363307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMbfvw9VPhE4xhx9UJlu8IMWthM+lSG29AO9lWd2ERk=;
        b=Z6CmRom1jLM6Z2Lr/kcQmHPxdn6a4p8y2H9OC0PYk1BRm/+ujjsFbQ+AmMQSSf2o/sckER
        96EM6xsH3izkXKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9064C1358A;
        Tue, 10 Jan 2023 15:08:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OCc0I2t/vWPAdQAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 10 Jan 2023 15:08:27 +0000
Date:   Tue, 10 Jan 2023 16:08:27 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/rtla: Explicitly list libtraceevent dependency
Message-ID: <20230110150827.chdwhg6h6d4owxai@carbon.lan>
References: <20230110131805.16242-1-dwagner@suse.de>
 <42d1e999-79a6-94dc-cc88-77520ddce068@kernel.org>
 <20230110140814.2yz4if2e2fasnu7t@carbon.lan>
 <94fd6fb5-c87a-b02e-40bc-b2e2c99529d5@kernel.org>
 <20230110144536.knepnpxsp4mw67no@carbon.lan>
 <20230110095137.18168c29@gandalf.local.home>
 <20230110095347.3662c3ba@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110095347.3662c3ba@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 09:53:47AM -0500, Steven Rostedt wrote:
> On Tue, 10 Jan 2023 09:51:37 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > There's many interfaces that require the libtraceevent header files to work
> > with libtracefs. Anything that uses libtracefs must also use libtraceevent,
> > as libtracefs is really just an extension of libtraceevent.

Okay, in this case I am going update the Meson build to add the necessary
explicit dependency:

++ b/src/meson.build
@@ -50,6 +50,7 @@ libtracefs_static = static_library(
 pkg = import('pkgconfig')
 pkg.generate(
     libtracefs,
+    libraries: [libtraceevent_dep],
     subdirs: 'libtracefs',
     filebase: meson.project_name(),
     name: meson.project_name(),


$ cat /tmp/trace-cmd/lib64/pkgconfig/libtracefs.pc
prefix=/tmp/trace-cmd
includedir=${prefix}/include
libdir=${prefix}/lib64

Name: libtracefs
Description: Manage trace fs
URL: https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
Version: 1.6.3
Requires: libtraceevent >=  1.7.0
Libs: -L${libdir} -ltracefs
Cflags: -I${includedir}/libtracefs

$ PKG_CONFIG_PATH=/tmp/trace-cmd
$ pkg-config --libs libtracefs
-L/tmp/trace-cmd/lib64 -ltracefs -ltraceevent
