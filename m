Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4425060551B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJTBkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJTBj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:39:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D931CC09A1;
        Wed, 19 Oct 2022 18:39:56 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 29K1da8v032650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 21:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1666229979; bh=SVMJ5L1m0MB2xHZj2sVzKk9l0nqg8YoodXfNHrUhDyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Vsk5KEItNWI6o8IQVZZAY2JLMhCH0r3jsO3UPfPasuwDTmSzewqxm8wpmx0Yj5+1U
         hu+B9HSEYVZFSmqNTY7DTgE0x5KG9wc9xPKc976d/fqq4aav/LTiEW2KSaFCxluvTQ
         JQyiNwURe0++3JK4TuM+ilHAZD5e+ElN4f/SMo1VuIkOlPgxpj9w9QDnnBIDLForuL
         vpLfX8ERpOOBj1VcJdv17RUyhGTQ+w+ZlbVNI1b83WGPt6H+0wkhnUTGbQuIX4HE5h
         SbQzeFAPbAx9dy/HJ6czzNSmcvhC/PG5mbEVrVv4BlYtspGeRW4fTmDIML3BHWHu1m
         Kcj/1TKuia+ag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7D60415C3AD1; Wed, 19 Oct 2022 21:39:36 -0400 (EDT)
Date:   Wed, 19 Oct 2022 21:39:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: fix repeated words in comments
Message-ID: <Y1Cm2Hvf7W7NxVzk@mit.edu>
References: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
 <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:53:54AM -0700, Randy Dunlap wrote:
> 
> On 10/19/22 06:02, Jilin Yuan wrote:
> > Delete the redundant word 'of'.
> > 
> > Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> > ---
> >  drivers/of/device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index 8cefe5a7d04e..16c7e5a2a868 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -19,7 +19,7 @@
> >  
> >  /**
> >   * of_match_device - Tell if a struct device matches an of_device_id list
> > - * @matches: array of of device match structures to search in
> > + * @matches: array of device match structures to search in
> 
> Hi,
> Rob has already explained this at least 2 times.
> 
> The second "of" is "open firmware".
> I would write it
>               array of OF device match structures to search in
> :)

Actually, I'd probably do something like

    	     array of Open Firmware (OF) device match structures...

This is the first place in that file (at least in a comment) where OF
gets used, and I've always been a big fan of using the fully expanded
acronym before using the acronym form.  Remember, PCMCIA stands for
People Can't Memorize Computer Industry Acronyms.  :-)

(Actually, it's Personal Computer Memory Chip Industry Association,
but most people don't know that, because using acronyms without
defining them first makes you feel like you're an "insider".  :-)

	     	      	   	    - Ted
