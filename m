Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FD710A93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbjEYLKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjEYLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC4195;
        Thu, 25 May 2023 04:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FF160B70;
        Thu, 25 May 2023 11:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D759BC433D2;
        Thu, 25 May 2023 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685013004;
        bh=k4r63m/Lzik54AT7G/zi6fUsz03lRD6D3jdSLwaE5vY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=TXG6EJnqdWhnpqnbyGNl9//DYbVzicXxZHKXFDQNsyCg2EF2r3Dokx5BObEOAM1Cu
         wpBq7c2rIsCLoL2TFctDcAoe+Tc21wt/u/KGfLmIoJpG/dOQ+8+PuYVdVSF7ft9KGP
         9Zbjc2KPBIWiJaLvmXbhX6v9r2xGy2E6mcrLa6VMBq/r39QSwi4FNqRbr7XgzYeAIa
         uL3pdw40Lak/q42KB9d9hr4PAbIVb1oGxlJRxR4rGM9O5M0f+Ms6p36QPzsfJwiwMS
         LLLshkjQynzjMnrAvs9g1zdA1k/IZUNJfOSUdYLTbMFlo/S/ihzChSkGXYtup9fqdl
         ja6mXpWSIK5LA==
Date:   Thu, 25 May 2023 13:10:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, guy.b@bluewin.ch
Subject: Re: [regression] Since kernel 6.3.1 logitech unify receiver not
 working properly
In-Reply-To: <CAO-hwJ+MTRu9KxqwQc7UYFBsa0kkrnYfwVB30KsLZnw=wfcOMg@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2305251308471.29760@cbobk.fhfr.pm>
References: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info> <bec024d5-4088-00ae-f7b5-7188868b1707@leemhuis.info> <b7717c43-74bf-b91d-d3ce-874493df602c@gmail.com> <CAO-hwJ+At1J_yUpX2q_dJekzZ-PoTDAvxmkTk_e4Yu0Z338bEA@mail.gmail.com>
 <55dda0bb-fe42-6dee-28ea-00121554d092@leemhuis.info> <CAHk-=whvhkSk6m8_AidhofgR9nq0Md+HbNad5r1RE69tZgbv6Q@mail.gmail.com> <nycvar.YFH.7.76.2305231422180.29760@cbobk.fhfr.pm> <CAO-hwJ+MTRu9KxqwQc7UYFBsa0kkrnYfwVB30KsLZnw=wfcOMg@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023, Benjamin Tissoires wrote:

> > > That bug is pre-existing (ie the problem was not introduced by that
> > > commit), but who knows if the retry makes things worse (ie if it then
> > > triggers on a retry, the response data will be the *previous* response).
> > >
> > > The whole "goto exit" games should be removed too, because we're in a
> > > for-loop, and instead of "goto exit" it should just do "break".
> > >
> > > IOW, something like this might be worth testing.
> > >
> > > That said, while I think the code is buggy, I doubt this is the actual
> > > cause of the problem people are reporting. But it would be lovely to
> > > hear if the attached patch makes any difference, and I think this is
> > > fixing a real - but unlikely - problem anyway.
> 
> FWIW, Linus, your patch is
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Feel free to submit it to us or to apply it directly if you prefer as
> this is clearly a fix for a code path issue.

It would be nice to hear from the people who were able to reproduce the 
issue whether this makes any observable difference in behavior though. I 
don't currently think it would, as it fixes a potential NULL pointer 
dereference, which is not what has been reported.

Has anyone of the affected people tried to bisect the issue?

Thanks,

-- 
Jiri Kosina
SUSE Labs

