Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B445B5542
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiILHUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiILHTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:19:00 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BCD2E9ED
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662967035;
  x=1694503035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GL/r0e3Bljjih6Nhnen38jSQxiap0mNwoK1npXft9aY=;
  b=eCg9++X3L2x9fR/Rbu3rdTMFwXdc3NH6RCGePhJ2JvzTt7lj/eSJSjjW
   FGEXK6xFQmerodOUrLnw+UObuLn0io0mFkGjSPokuMBfTNVgtxOZr3HUN
   oIpycaj8pjoX/PQ4pb1Vd3F4qVIY8SuPrVq23U4o8GFg3D4P5VtfhcXo1
   j3x2opOzQynkiUQQPcg2N2MieeqkyjeGiLDH5C1C/NSc6JewkFNNpZYzy
   MxCAOks9TRbbImLjtC4HGN0kmCrl55mUjzejaZWctI6g9K1JtUsKGSNVH
   r7Z2U1HocaJbDK4SPplRCSR8qo0a8Uxgrv/j+NYcZf+focLlvCsCur65d
   g==;
Message-ID: <ae04a891-a626-0259-d39e-fc8045a7ca94@axis.com>
Date:   Mon, 12 Sep 2022 09:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ASoC: ts3a227e: allow enabling the jack detect in driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Astrid Rost <astrid.rost@axis.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <kernel@axis.com>,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20220909093001.13110-1-astrid.rost@axis.com>
 <Yxt7tfm6MRMaDthO@sirena.org.uk>
From:   Astrid Rost <astridr@axis.com>
In-Reply-To: <Yxt7tfm6MRMaDthO@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail05w.axis.com
 (10.20.40.11)
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


 > New properties need to be documented, I'm happy for that to be in the
 > existing document though obviously a conversion to YAML would be very
 > much appreciated.  However...

Yes, I am doing the yaml conversion for the other patch.
I guess this one - I will try to do differently.

On 9/9/22 19:45, Mark Brown wrote:
> ...this is something that should be done in the machine driver rather
> than the CODEC, the way the device is wired up in an individual system
> may be surprising or the system may have some more specific labelling
> that can be usefully applied so this is all deferred to the card.
> 
> It would sense to convert ts3a277e_enable_jack_detect() to be a
> component set_jack() operation, that'd enable it to be used more easily
> with generic cards (though I see that it's not yet wired up for
> audio-graph-card unfortunately).

Thank you! Yes, set_jack I did not see.
I actually thinking of putting this into simple_card.c. But than it 
needs to be really generic.

I will have a look.

Astrid


