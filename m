Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF269D43B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjBTTkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjBTTjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:39:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5F22DFA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:39:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1763E60EE1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFEFC433B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676921942;
        bh=qsXy0JQ67Y92KZK+XPllHUteLS7kWdcSy3nqA7gxtpM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T1qfkPUswnn2Yk38HPR0kW7nZpGwhTgXjoyXeMPd2OQRLSOxBDtAw6RbLdGGrOA/s
         nAyX4CQ+9+00CSOhG2XmgBXsxWbNoaCwvCVt1ztXgZRBM2TeHKJ/AIzcDiwpSrt2X2
         MU51ynKbd9n93GWxrg8acF9ivj4SsPgCuv5vlGlWB8VoPgaAfm/Vp7ap1N17rMgmYE
         8aqul3x7W6RxepvQGXP7txiepX8qEAZICFUjW4ldN9CFqn105seN23FMgHuc20rU3B
         UfAjcFJ0PtI3xLKPSqkmHG4yf5ENoVuv0QsHGYOS9UQksHsBFnw9M1efY86O5r0YIh
         QJeX+5fKOd4Qg==
Received: by mail-ed1-f43.google.com with SMTP id h16so8886763edz.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 11:39:02 -0800 (PST)
X-Gm-Message-State: AO0yUKXef17ZIXokU7OAUHAQQAEMT6lBW5HdqC59Dyidm4O4U3rUK96b
        iuz2fFtGxd064sc9IpeaPUjmNNGA6SOL01/6WsWwTw==
X-Google-Smtp-Source: AK7set9cweeeJAmqYciiJcfwdouyHLKEnEZ6diAIxSNvVmxlKz3rMfg3pPOzgruTmpzYxzm/65MTNTjrhk4r0ghHW3Q=
X-Received: by 2002:a17:906:bce7:b0:8b1:28f6:8ab3 with SMTP id
 op7-20020a170906bce700b008b128f68ab3mr4828708ejb.15.1676921940594; Mon, 20
 Feb 2023 11:39:00 -0800 (PST)
MIME-Version: 1.0
References: <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble> <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble> <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble> <Y/O9U4KFtXE8Yoyt@zn.tnic>
 <20230220190908.gfd2c4tuzeb7cft6@treble> <CACYkzJ58HoDz+hpLzWf0PZQX7ykWqB6-uQR9HVb5YqaF-rdScA@mail.gmail.com>
 <20230220193526.if5zfd6j7sbjpf7g@treble>
In-Reply-To: <20230220193526.if5zfd6j7sbjpf7g@treble>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 20 Feb 2023 11:38:49 -0800
X-Gmail-Original-Message-ID: <CACYkzJ5hoSa7moeRfqVvz=XDegpLN63iWp4rXpXNxjMXvwAxtQ@mail.gmail.com>
Message-ID: <CACYkzJ5hoSa7moeRfqVvz=XDegpLN63iWp4rXpXNxjMXvwAxtQ@mail.gmail.com>
Subject: Re: [PATCH] x86/bugs: Allow STIBP with IBRS
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?UTF-8?Q?Jos=C3=A9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:35 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Mon, Feb 20, 2023 at 11:16:45AM -0800, KP Singh wrote:
> > > As far as I can tell, that document was never updated to describe
> > > spectre_v2=ibrs in the first place.  That would be a whole 'nother patch
> > > which I'm not volunteering for.  Nice try ;-)
> >
> > This should at least be documented in the code.
> >
> > Now it seems like it is not okay to work with people on the list and
> > just send revisions bypassing them. This is not something we do in the
> > kernel area I come from (an x86 favorite ;)).  Please feel free to go
> > with Josh's version (or its future revisions). If you want me to
> > re-spin with some comments, happy to. If not, please do at least give
> > me Reported-by here.
>
> It's a common practice even outside of x86.  I'd recommend not taking it
> personally.  In the end it's all about what produces better code.
>
> And please don't take this the wrong way, but sometimes it takes a bad
> patch to inspire a better one.  I mean that with no disrespect, I myself
> have sent many bad patches.

Appreciate the clarification! Thank you so much.

>
> And if you don't like my patch, fine, send a v2...

I can also take a stab at the Documentation piece, this will make
Boris happy too. Will send a v2 later today.

>
> --
> Josh
