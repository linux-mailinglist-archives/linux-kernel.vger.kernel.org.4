Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CAC6DEC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDLH0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDLH0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:26:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E880B8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:26:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF4101F6E6;
        Wed, 12 Apr 2023 07:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681284376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItDljydVAvwgC6zcUF15NCWeZckzCVnfcS0RvDvd3wk=;
        b=qvoCTJturKemh5FcCE82baywBlKobeOct9OEe+1b9j6Lb8Wjt5KkNq1qQpIBzdKyR1TK9x
        Hpc9sGjuX1gFSkjXgJprqVvOiFxgxCw8FUMQxFvrJ5csuhms++Cj1PxsitG3vvIFmol+ej
        kNOvtizi74NHVx+slRqIGGpPA7N6SrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681284376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ItDljydVAvwgC6zcUF15NCWeZckzCVnfcS0RvDvd3wk=;
        b=sUg4dCDkuGGygkKOh5mMlDTUHIlQ8hOzRdCUQvGvZum6XoaXbUvWSMWH0jqzASZbPkMxE0
        otNS2wx1U4hLnJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D17C13498;
        Wed, 12 Apr 2023 07:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qCKrJBhdNmR4OAAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 12 Apr 2023 07:26:16 +0000
Date:   Wed, 12 Apr 2023 10:26:16 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: rmem: Make reserved region name unique
Message-ID: <r3x3b6fyejqg3ftcgigdrevsnlhbfrae2gztejsa3cnduaebf4@z3reu7bj6b6n>
References: <20230411135035.106725-1-iivanov@suse.de>
 <437e9983-55e9-3f9d-a94b-c746922973da@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437e9983-55e9-3f9d-a94b-c746922973da@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On 04-11 18:53, Stefan Wahren wrote:
> 
> Am 11.04.23 um 15:50 schrieb Ivan T. Ivanov:
> > They could be multiple reserved memory regions,
> > so let's make their names unique.
> > 
> > This fixes following kernel error:
> > 
> > [    9.831285] sysfs: cannot create duplicate filename '/bus/nvmem/devices/rmem0'
> 
> could you please provide more background information:
> 
> - are two instances of rmem trying to create this file?
> - which exact platform is affect (Raspberry Pi 4), because the Hardware name
> from the trace is useless?
> - could you provide some reliable scenario/config to reproduce this issue?

I was sure your will be asking. :-)

I am using RPi4[0] for testing this. Device tree is based on sources
from here [1]. From this devicetree it is  obvious what is happening.

Unfortunately right now SUSE Bugzilla is under maintenance, so perhaps you
can't see the bug report [2]. In brief I am using latest Tumbleweed on this
device and you can imagine that error is happening always.

Regards,
Ivan

[0] Raspberry Pi 4 Model B Rev 1.1
[1] https://github.com/raspberrypi/linux/blob/rpi-6.2.y/arch/arm/boot/dts/bcm2711-rpi.dtsi#L57
[2] https://bugzilla.suse.com/show_bug.cgi?id=1206846
