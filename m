Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48FE6012A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJQPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJQPUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:20:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D7610B44
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 08:20:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 719B25C238;
        Mon, 17 Oct 2022 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666020013;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXq62A60+pMKZKKuVjTP18v1g4OQVI7mpEoEFf8zoDk=;
        b=oYKN/6JVziWp6WNMXPL7NIj9agtkqJ/BttNBHm1toojXa/mmuEFvg/J65gyXkTP9GZuGBv
        HU3R/hoas1yWYaGccdgaef8EituLlYGilvTgcnds4YGeOGBM92fTleR+ULfzkU0o8RR/k9
        gVI/r8o+nYGtVT4FYtyPKugTI7xdPqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666020013;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXq62A60+pMKZKKuVjTP18v1g4OQVI7mpEoEFf8zoDk=;
        b=WgEXHwFvKDV9mFJDQcd+IOPaYoPvjvcy1eKFrT+ZlcGiHSjnFrcXPKD9swcaBV0LcrJBa8
        ToQTAe4FgCN43uBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CB3113ABE;
        Mon, 17 Oct 2022 15:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KvB+AK1yTWMHHQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 17 Oct 2022 15:20:13 +0000
Date:   Mon, 17 Oct 2022 17:20:10 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     vapier@gentoo.org, chrubis@suse.cz, wanlong.gao@gmail.com,
        jstancek@redhat.com, stanislav.kholmanskikh@oracle.com,
        alexey.kodanev@oracle.com, ltp@lists.linux.it,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [LTP] [PATCH] MAINTAINERS: git://github -> https://github.com
 for linux-test-project
Message-ID: <Y01yqrDR/oEX8/o0@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221013214638.30953-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013214638.30953-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.

> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Could you please merge this? iit got ack from Cyril (the main maintainer
and me):
https://lore.kernel.org/ltp/20221013214638.30953-1-palmer@rivosinc.com/

Kind regards,
Petr

> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index d103b44fb40c..d118acdce8b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11972,7 +11972,7 @@ M:	Alexey Kodanev <alexey.kodanev@oracle.com>
>  L:	ltp@lists.linux.it (subscribers-only)
>  S:	Maintained
>  W:	http://linux-test-project.github.io/
> -T:	git git://github.com/linux-test-project/ltp.git
> +T:	git https://github.com/linux-test-project/ltp.git

>  LYNX 28G SERDES PHY DRIVER
>  M:	Ioana Ciornei <ioana.ciornei@nxp.com>
