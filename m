Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1533663AA32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiK1N4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiK1N4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:56:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FFEE39
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:56:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E41121B50;
        Mon, 28 Nov 2022 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669643774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkhskPyCJwgUEV7RLLLQCKd7o+qvCH5bVcDsV0x8RN4=;
        b=stUMV2hVLFmX0527MYCMl2ORlgvUzK9vqo91/bkXQ6AT+o1b6NHWzUqJb6It2t5r9Wjx44
        OixFQCmSGfeEHBDANOiqPiCvl/IvT2Jfb/uzwTyclQvJzfAXiSMWVfnE5rnGXU82J9Px40
        3iDlTQ97JuE44AeKlcPAUB+Z3fXXPqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669643774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkhskPyCJwgUEV7RLLLQCKd7o+qvCH5bVcDsV0x8RN4=;
        b=zH0Xx+ZLXAC1KWRoYGbsjKoua76/o4QxC+cCJnjBVBIErgefQpBNv/ZF+2k0cq+JJXErMN
        CyzYJjtW5hAG10Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 521CC1326E;
        Mon, 28 Nov 2022 13:56:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5H9dEv69hGN0FQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 28 Nov 2022 13:56:14 +0000
Date:   Mon, 28 Nov 2022 14:56:12 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: rsnd: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20221128145612.74ff3d25@endymion.delvare>
In-Reply-To: <Y4Sqn0xOP4R/fl9P@sirena.org.uk>
References: <20221127193441.0b54484d@endymion.delvare>
        <Y4Sqn0xOP4R/fl9P@sirena.org.uk>
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

Hi Mark,

On Mon, 28 Nov 2022 12:33:35 +0000, Mark Brown wrote:
> On Sun, Nov 27, 2022 at 07:34:41PM +0100, Jean Delvare wrote:
> > It is actually better to always build such drivers with OF enabled,
> > so that the test builds are closer to how each driver will actually be
> > built on its intended target. Building them without OF may not test
> > much as the compiler will optimize out potentially large parts of the
> > code. In the worst case, this could even pop false positive warnings.
> > Dropping COMPILE_TEST here improves the quality of our testing and
> > avoids wasting time on non-existent issues.  
> 
> As ever building without OF does not preclude building with OF.

I'm sorry, I'm not sure I understand what point you are trying to make
here.

Of course you can build a kernel with and without OF, and without my
patch, you could build the driver with and without OF. My point is that
there is no value in allowing that.

There are 2 use cases for COMPILE_TEST. The first use case is kernel
developers who make changes to a driver and want to be able to
test-build it. Now they can just enable OF and they will be able to
test-build the driver (and a better version of it, as explained in my
patch description). It is no different from enabling I2C if you need to
test-build an I2C driver, or enabling SPI if you need to test-build an
SPI driver, etc.

The second use case is the compilation farms. These will typically run
pre-defined real kernel configurations or allmodconfig or randconfig.
The first two options are not really affected by this change, only
randconfig is.

For randconfig, the limiting factor is the build power of the farm. So,
in a way, yes building without OF does preclude building with OF,
because you can test only one combination of options at once. Whenever
you build your driver without OF, you are wasting an opportunity to
build it with OF instead, which would test the code as it will actually
be used on its intended target, and thus is a better test.

You may argue that statistically, randconfig will select the driver
more often if it depends on OF || COMPILE_TEST rather than just OF.
That's true, but it's a matter of quantity versus quality. Would you
rather test build the code twice in its crippled form, which may
trigger false-positive warnings or hide actual warnings, or just once
in its proper form, where all warnings and build failures are real? I
definitely believe the latter is a better use of our resources.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
