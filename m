Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F247257E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbjFGIf2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 04:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbjFGIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:35:12 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1CC10F2;
        Wed,  7 Jun 2023 01:34:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B08AD608110F;
        Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sXaARXfzj_XF; Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 46A9F61A7038;
        Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id REw2yvknD0Qh; Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2CD10608110F;
        Wed,  7 Jun 2023 10:34:55 +0200 (CEST)
Date:   Wed, 7 Jun 2023 10:34:55 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Message-ID: <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
In-Reply-To: <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com> <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at> <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com> <20230607042340.GA941@sol.localdomain> <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH v2] uml: Replace strlcpy with strscpy)
Thread-Index: htCR070T9Bo9GMJdBdeq8ENX7eWHXA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Johannes Berg" <johannes@sipsolutions.net>
> On Tue, 2023-06-06 at 21:23 -0700, Eric Biggers wrote:
>> 
>> > > > Reported-by: kernel test robot <lkp@intel.com>
>> > > > Closes:
>> > > > https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/
>> > > 
>> > > Are you sure Reported-by and Closes make sense?
>> > > AFAIK the report was only on your first patch and nothing against upstream.
>> > > So stating this in the updated patch is in vain.
>> > 
>> > I left the metadata in only for the sake of posterity. If it's not
>> > helpful, I'm ok with removing it.
>> > 
>> 
>> IMO using Reported-by in cases like this is harmful, as it makes commits seem
>> like bug fixes when they are not.
> 
> I've yet to see anyone disagree with that, and yet, the robot actively
> asks for such tags to be included in patch resubmissions.
> 
> On the one hand, I can understand their desire to be recognised for
> their efforts. At this point then we might suggest that we introduce a
> different tag, say "Improved-by:" or "Issues-found-by:" or something.

Robots don't have feelings. No need to worry. ;-)
 
> On the other hand, I don't feel like we should give a robot more
> recognition than we give _people_ reviewing, and we currently really
> only recognise them by a Reviewed-by tag. Then again, that doesn't work
> with the robot - it is pretty much looking at each patch and only
> comments on a small fraction. We also really don't want it to comment on
> each and every patch ...
> 
> 
> So it seems we should ask the robot maintainers to just stop suggesting
> those tags?

Agreed.

Thanks,
//richard
