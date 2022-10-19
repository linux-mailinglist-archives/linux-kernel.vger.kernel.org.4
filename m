Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C19E6045D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiJSMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiJSMt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:49:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6671C4921
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:32:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C8B0D1FD10;
        Wed, 19 Oct 2022 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666182680;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIVmI7hDWtRjXOIuomwqF0FtvW97AwrOu0bOOYmNl/k=;
        b=I2FxgsrVZxgTI3SNhCtv1KZIq3p15PWGTxC/zJehbKBREgGPOhjflvNBwcyNe6v3C7f08u
        kfN2gF1iE/M+VJTqg4QUXofOu0zAmO5VqBppmGFZyj3hCMm8E9g2JCBd4WT4iz8aIZ03E1
        SVlJDCe9ESlOMUUUGoCDhpslBtVs8dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666182680;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DIVmI7hDWtRjXOIuomwqF0FtvW97AwrOu0bOOYmNl/k=;
        b=C4SXbJ1ZHQnipSqi/Klx34IL6bKB9gSBm3wWxuzBkPDLExTCr7MOJFC3JATq+4/pp//Tnd
        X2RMp1gFs/FqzmDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F66213A36;
        Wed, 19 Oct 2022 12:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DaiCIRjuT2MjbAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 19 Oct 2022 12:31:20 +0000
Date:   Wed, 19 Oct 2022 14:31:18 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: v6.1-rc1: Regression in notification of sethostname changes
Message-ID: <Y0/uFkggIJMjxcpi@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com>
 <Y0/DlHMIPbRDG+fF@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0/DlHMIPbRDG+fF@pevik>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Torsten,

> > Hello Petr,

> > your commit

> > commit bfca3dd3d0680fc2fc7f659a152234afbac26e4d
> > Author: Petr Vorel <pvorel@suse.cz>
> > Date:   Thu Sep 1 21:44:03 2022 +0200

> >     kernel/utsname_sysctl.c: print kernel arch

> >     Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.

> >     This helps people who debug kernel with initramfs with minimal environment
> >     (i.e.  without coreutils or even busybox) or allow to open sysfs file
> >     instead of run 'uname -m' in high level languages.

> > broke the notification mechanism between the sethostname syscall and the pollers of /proc/sys/kernel/hostname.

> > The table uts_kern_table is addressed within uts_proc_notify by the enum value, however no new enum value was added in "enum uts_proc".

> > I noticed the problem when journald-systemd failed to detect hostname changes made with the sethostname syscall (as used by the hostname tool).
> > When setting the hostname through /proc/sys/kernel/hostname the poll notification was working.

> Thanks a lot for your report, working on a fix!
> Andrew, Greg, sorry for a regression.

Hi Torsten,

could you please post exact steps to reproduce the problem.
Although the required fix to add new enum into enum uts_proc is trivial,
I was not able to reproduce the problem with 6.1.0-rc1 (actually
6.1.0-rc1-4.g1d716d8-default which contains few extra patches).

# hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
opensuse-tumbleweed.20221001
opensuse-tumbleweed.20221001
opensuse-tumbleweed.20221001

# hostnamectl set-hostname foo; echo $?
0
# hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
foo
foo
foo

# hostname bar; echo $?
0
# hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
bar
bar
bar

# echo "baz" > /proc/sys/kernel/hostname
# hostname; hostnamectl hostname; cat /proc/sys/kernel/hostname
baz
baz
baz


# hostnamectl set-hostname foo; reboot
After reboot it's 'foo'.
What am I missing?

BTW I originally tested the feature only on dracut initramfs (with rapido [1]),
which obviously bypass systemd. For a fix I'm creating rpm package (binrpm-pkg).

Kind regards,
Petr

[1] https://github.com/rapido-linux/rapido

> Kind regards,
> Petr

> > 	Torsten
