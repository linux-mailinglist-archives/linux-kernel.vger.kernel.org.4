Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52572623B01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiKJElR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKJElN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:41:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28469252B4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:41:11 -0800 (PST)
Received: from letrec.thunk.org ([12.139.153.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AA4eDSA015823
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 23:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1668055221; bh=qahc/OEJv9l/mG+aZHuyYNKbJOQinUkMTYXdNij93nY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=H3rKGqs0uCOsyfC9KYcBFj5CT1PnOFkol1Da9cLF93kcK4GjWwIb4VNfWJdesVNEg
         Cdr9oSbhuRVO8ki8qwPUuKnBpCxQJsfpFkddNmkJJ+9d+C1uC/z2KZlpFGAe8ek/sS
         kZ3npSqLafM+NPI4uSE2a5ppEmJuC0I7Hpo5Ov8C5WTOFXTpBpvT5OHsepFbSe3VVW
         IiPKzfvHAVUhHpZX0J833tJat9qVPGbbHQ4s4IEHM85S9VYCUuNRCQ6oE5o2SZbSm2
         F58yi2GCow4Dq7RALHQ7lJ3aOoxRkYTHqz9N25O+TJ/F0ft0CiTT+/V6Zc/hML1stF
         tjRfXross+zlw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 38BDE8C01E8; Wed,  9 Nov 2022 23:40:13 -0500 (EST)
Date:   Wed, 9 Nov 2022 23:40:13 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Cercueil <paul@crapouillou.net>, vbabka@suse.cz,
        42.hyeyoo@gmail.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, rkovhaev@gmail.com,
        roman.gushchin@linux.dev, willy@infradead.org
Subject: Re: Deprecating and removing SLOB
Message-ID: <Y2yArTbOpKd6ASkd@mit.edu>
References: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
 <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
 <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 01:48:32AM +0200, Aaro Koskinen wrote:
> 
> Some of the reported SLOB issues have been actually real driver bugs,
> that go unnoticed when SLUB/SLAB are used (unless perhaps debug stuff
> is enabled). I'm not saying kernel should keep SLOB, but it's good at
> failing early when there is a bug. See e.g. commit 120ee599b5bf ("staging:
> octeon-usb: prevent memory corruption")

Out of curiosity, are these bugs that would have been found using
KASAN or some of the other kernel sanitizers and/or other debugging
tools we have at our disposal?

       		      	    	      	    	 - Ted

						 
