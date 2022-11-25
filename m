Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255FC638AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiKYM6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiKYM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:58:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CCC27CE9;
        Fri, 25 Nov 2022 04:58:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 290FD1FD63;
        Fri, 25 Nov 2022 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669381124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOiD9ianBiK3WSdhkTFKawbGbHxzkZa1OpZlesKwxwg=;
        b=CE7srKW4HlBYiMGla3w9Z4/Krm+Q2CWl3QbNYEZt0g5MFdcYmt5NQzomMQAM1LniG5S52H
        uDX3MOBuMUXcGxBwGksUsB2Lwg3tCoKTbcqM5Dp/leITFkFU9ekryT1OpfmTOYfi6HmXjf
        vh4qcYF7m90dz1TAJmpc8d3kKn3jyp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669381124;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOiD9ianBiK3WSdhkTFKawbGbHxzkZa1OpZlesKwxwg=;
        b=LkmXBh3KMsb1J3DVq5Z+aP5/+fZjqX7OvzYdq57CUb/Ob396AgLH8uANbtmR6gg0wKzLd6
        lh+F3HpOvH1Wu8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E47A613A08;
        Fri, 25 Nov 2022 12:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0NhDNgO8gGOGPQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 25 Nov 2022 12:58:43 +0000
Date:   Fri, 25 Nov 2022 13:58:41 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nand tree with the mtd-fixes
 tree
Message-ID: <20221125135841.134310ba@endymion.delvare>
In-Reply-To: <20221125100504.5424c3ad@xps-13>
References: <20221125094634.665b079c@canb.auug.org.au>
        <20221125100504.5424c3ad@xps-13>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 10:05:04 +0100, Miquel Raynal wrote:
> sfr@canb.auug.org.au wrote on Fri, 25 Nov 2022 09:46:34 +1100:
> > Today's linux-next merge of the nand tree got a conflict in:
> > 
> >   drivers/mtd/nand/onenand/Kconfig
> > 
> > between commit:
> > 
> >   c717b9b7d6de ("mtd: onenand: omap2: add dependency on GPMC")
> > 
> > from the mtd-fixes tree and commit:
> > 
> >   b46ff0780f17 ("mtd: onenand: omap2: Drop obsolete dependency on COMPILE_TEST")  
> 
> As this commit is not super urgent and because I want to make the merge
> process as smooth as possible, I'll drop it from my branches. Please
> rebase and resend when -rc1 is out and I'll apply right away.

Noted, no problem.

-- 
Jean Delvare
SUSE L3 Support
