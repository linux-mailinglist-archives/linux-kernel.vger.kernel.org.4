Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEA5680CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbjA3L6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbjA3L6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:58:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976FA2384F;
        Mon, 30 Jan 2023 03:57:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18C7221A3F;
        Mon, 30 Jan 2023 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675079855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1m5nCPvMubSRpk/17xcYp5pUmRsL6QuuECu72dMc74=;
        b=SkGhGHC8auYyUQFybJ2kKP75wJGtqpjnx7fLEEDcOYQEXtaiBuikGrkTjTtZGIsNpT3Xt2
        ioRpxkZzk0k3PLyoLf5NhXd91hHwmCrQpE4Ek2PUg5uAPT2tV7WwoMNRuF4vuamZD9ppub
        zrlWLXYzTFCWqZWaWPqA7Pud5/o7xbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675079855;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1m5nCPvMubSRpk/17xcYp5pUmRsL6QuuECu72dMc74=;
        b=R2dcKBTT2y6ua4cOayV6zRYBpflv1DyvyeI0/aYxgX9bsHLeBMG5TglBzFdhN9RLqL+Smf
        3UcON/VWK14n5GBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD3AE13444;
        Mon, 30 Jan 2023 11:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WVSGMK6w12NAMgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 30 Jan 2023 11:57:34 +0000
Date:   Mon, 30 Jan 2023 12:57:33 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Hung-yu Wu <hywu@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH RESEND] Input: atmel_captouch - drop obsolete dependency
 on COMPILE_TEST
Message-ID: <20230130125733.747d86e3@endymion.delvare>
In-Reply-To: <Y9csSoYNZmN3+eSy@google.com>
References: <20230127122816.02b6ea26@endymion.delvare>
        <Y9csSoYNZmN3+eSy@google.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
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

Hi Dmitry Torokhov,

On Sun, 29 Jan 2023 18:32:42 -0800, Dmitry Torokhov wrote:
> On Fri, Jan 27, 2023 at 12:28:16PM +0100, Jean Delvare wrote:
> > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> > is possible to test-build any driver which depends on OF on any
> > architecture by explicitly selecting OF. Therefore depending on
> > COMPILE_TEST as an alternative is no longer needed.
> > 
> > As a nice side effect, dropping the alternative dependency on
> > COMPILE_TEST allows removing preprocessor directives, which will
> > speed up the build.  
> 
> I believe I already have your patch in my "next" branch that is feeding
> into linux-next.

Oh right, sorry for the noise. I did not receive a formal ack from you
at the time, so I thought it got lost in traffic. I should have
double-checked, by bad.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
