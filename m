Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC65F3C7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 07:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJDFpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 01:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDFpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 01:45:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B71A830;
        Mon,  3 Oct 2022 22:45:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C4D32190B;
        Tue,  4 Oct 2022 05:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664862301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAYzHxW51Wjle631nz2ovLMzm+yY3Bm2JEKRDUI7a/k=;
        b=Ly1tUEQbd5GLn7BUBBUQZwXV85uyrlZOXyuoCs0NvGKm/kJm4gM/52RVmkRnrhMZ52Dvkz
        fEtuE3OIzv0e/4jbcke6rqoIGz3kbK1ZcdC75cQhpjexwsNqI+Af9qpK0n2JsYvun7eAXP
        63Q0oEt/tAxZj/qXACnsLoY4CdmCgY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664862301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAYzHxW51Wjle631nz2ovLMzm+yY3Bm2JEKRDUI7a/k=;
        b=rOAhD4zlXHDQFUwD2f2YSRTi0iVsOEAPLIqLBMsyTsj2qIDrydrLEiIUyt1NSrbyD06dBP
        EvCrXs1fQ3DFsuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FECD13A8F;
        Tue,  4 Oct 2022 05:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qkXVFV3IO2ODCwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 04 Oct 2022 05:45:01 +0000
Date:   Tue, 4 Oct 2022 07:44:59 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Daniel Hung-yu Wu <hywu@google.com>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: misc - atmel_captouch does not depend on OF
Message-ID: <20221004074459.35b58ed0@endymion.delvare>
In-Reply-To: <YzuuiJwdtnHYQK1G@google.com>
References: <20221003172953.30354439@endymion.delvare>
        <YzuuiJwdtnHYQK1G@google.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 20:54:48 -0700, Dmitry Torokhov wrote:
> Hi Jean,
> 
> On Mon, Oct 03, 2022 at 05:29:53PM +0200, Jean Delvare wrote:
> > The atmel_captouch driver does not actually depend on OF, it includes
> > a non-OF device ID which could be used to instantiate the device, and
> > the driver code is already prepared to be built with or without OF. So
> > drop the unneeded dependency.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Daniel Hung-yu Wu <hywu@google.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > The problem I'm trying to solve here is that "depends on OF ||
> > COMPILE_TEST" does not make sense since OF can now be enabled on all
> > architectures. One way to fix this is by removing the dependency
> > altogether (this patch).
> > 
> > If the driver is known to be needed only on OF-enabled systems then we
> > could leave the dependency on OF and only drop COMPILE_TEST (and
> > simplify the driver code accordingly). I have an alternative patch
> > doing that already. Tell me what you prefer, I'm fine either way.  
> 
> The driver is not operable on systems without OF:
> 
> static int atmel_captouch_probe(...
> 	...
> 
> 	node = dev->of_node;
> 	if (!node) {
> 		dev_err(dev, "failed to find matching node in device tree\n");
> 		return -EINVAL;
> 	}
> 
> 	if (of_property_read_bool(node, "autorepeat"))
> 
> So the reason for "depends on OF || COMPILE_TEST" is to avoid prompting
> users who actually try to configure real systems for drivers that make
> no sense for them while still allowing people interested in compile
> coverage to select COMPILE_TEST and enable more drivers.

OK, thanks for the clarification. Please disregard this patch then,
I'll send the other one.

-- 
Jean Delvare
SUSE L3 Support
