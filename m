Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288446063F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJTPOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJTPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:14:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35893D9C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:14:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D942A22970;
        Thu, 20 Oct 2022 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666278855;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ph63C4qHFULN+Di57OFgvEPR0litexahJmBFlk4Mz8U=;
        b=NPcG95xGqHeTnNSoF5Sfs0cdLk6FPHC6NUdPjAkifcthjzqPpFF3MY3KjZ3pk3aDRtmr/Y
        yj5w77+ySjHV7uXJ3i/gHjN16yJvejSAfbJdOlFkQSmOcIIGf68HLPFlJN9O8eNQTwAyan
        6g2AAsPU6++bpTUtSOn9cxMVlnXPDzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666278855;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ph63C4qHFULN+Di57OFgvEPR0litexahJmBFlk4Mz8U=;
        b=numa6Soy5dYx3QSu3PcNlQXGPMDl+dUigudsVgmpiVS4XGkYxH2fy/S2XjTkICfv9wma0P
        9eO5SA5+HQnZLvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A49B413AF5;
        Thu, 20 Oct 2022 15:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LRAUJsdlUWO8fQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 20 Oct 2022 15:14:15 +0000
Date:   Thu, 20 Oct 2022 17:14:13 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>
Subject: Re: [PATCH 1/1] kernel/utsname_sysctl.c: Add missing enum uts_proc
 value
Message-ID: <Y1FlxYr9IF7Phy1u@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221020150645.11719-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020150645.11719-1-pvorel@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

[ Cc regressions@lists.linux.dev ]

Kind regards,
Petr

> bfca3dd3d068 added new struct ctl_table uts_kern_table[], but not new
> enum uts_proc value. It broke the notification mechanism between the
> sethostname syscall and the pollers of /proc/sys/kernel/hostname.

> The table uts_kern_table is addressed within uts_proc_notify by the enum
> value, that's why new enum value is needed.

> Fixes: bfca3dd3d068 ("kernel/utsname_sysctl.c: print kernel arch")

> Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,

> I'm sorry to introduce a regression.

> Torsten Hilbrich reported [1] that hostnamectl set-hostname foo
> which does poll() got affected by bfca3dd3d068. He also wrote a
> reproducer [2] which does not require systemd, I tested the patch on
> dracut initramfs.

> Kind regards,
> Petr

> [1] https://lore.kernel.org/lkml/0c2b92a6-0f25-9538-178f-eee3b06da23f@secunet.com/
> [2] https://lore.kernel.org/lkml/ec9e00b9-8b47-7918-c39b-8b0069003169@secunet.com/2-hostname-poll-test.c

>  include/linux/utsname.h | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index 2b1737c9b244..bf7613ba412b 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -10,6 +10,7 @@
>  #include <uapi/linux/utsname.h>

>  enum uts_proc {
> +	UTS_PROC_ARCH,
>  	UTS_PROC_OSTYPE,
>  	UTS_PROC_OSRELEASE,
>  	UTS_PROC_VERSION,
