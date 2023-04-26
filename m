Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6E86EFB76
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjDZUCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjDZUCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:02:22 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5AD2;
        Wed, 26 Apr 2023 13:02:20 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Q68sj3rvkz49Q1R;
        Wed, 26 Apr 2023 23:02:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1682539338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rfI7yW5iAyvACe+eNHb7XIJwwBJSYOM1MVr/do/rQk=;
        b=fWyoknReNi32uex96QxCkPJQFwK1GACks0ieD7bBRtLPTG2FbplSNzFmZfM+xxIeAYcL6p
        EJJHE4dqLcS7O33dDK2+E5UHcKlAN9mXQ0G73n0W5f/j+3GiaBfBSkR1mVuQyn/oXqhk0c
        1D+nofwqyKOUShyhO5lklSQOlx09jsiFGZdjlkP7jHyBdY778O60300BnKYr/68ExFekYZ
        NHI1h01zoRn4A9Wt4VEjEY0krCQIEuZ0IvPaz+iRW0WIJyBkGx1cIVEGiBPpUL2meOahSf
        LDLjE4Om+QHwIsy+prxMP8fYdNjsFXycmqlQ4/D5RUX/JzfUqI60RYhTgb3nGg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1682539338; a=rsa-sha256;
        cv=none;
        b=den9DyFyBDEnYfDypgfErIdfmvFRKgfu1cnm/+KtP0XKpNih/NEWc9Hfp75rlCm9KoSzX3
        Yx7cr11Ic3+Ww7uTpv6BS8sx5za17uDHyvYTSfZJaLWxi+JOIwD4PW140hJ0toztl1tI++
        eYDkypoOgyjOURWDT/uzxUXaPi0x31Z+htKvNlrQW39yCFat06Dmhn/OWqXhCLNJVnYL9+
        0iAfKGQW1MFp6LuduvZg3Ot2BqKTvsXz76WoQvF4cjrObgv8xuOLzAi54MO8Zy18mM376K
        SkXcFdwCRjFqKTQyNKhpqtQVcBFPAbyWmW2dsvoRVq0Du0eL+N5pr7adqezNUQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1682539338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rfI7yW5iAyvACe+eNHb7XIJwwBJSYOM1MVr/do/rQk=;
        b=uiNuOz7yndn4oPHV0oCF2jATvQeuWQtipJLPJlz9Tmwfq3VtXG6a+vKdVLIpS0w2bOMQBs
        SWZN4HjkbYwF40lKgYJPLvAqaA3LPP14tWJYVYEppIWcs/EqN8GAKDyZ6zFhFHmhOn5vhF
        5aH8xeb873KBdErxIUgOf11Si4nWy3/1rr11/YVtbCe5pGRqD5g2IltiA1XYD2A/XQlkRU
        znJyG/98bDJc14nuUMG5dcgl/0uLb3ulFv5v5BnMZcMxOMJqUm/+EnSk6R92lVXgA/IW3o
        3sgc2ALTD0n+7a0yLUNNQ7B5pXKZArk8UBVpYkCjScHBtxy473hBD/jhpdMXtA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 39DE8634C91;
        Wed, 26 Apr 2023 22:58:07 +0300 (EEST)
Date:   Wed, 26 Apr 2023 22:58:06 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
Message-ID: <ZEmCTm3MAD+Is82V@valkosipuli.retiisi.eu>
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl>
 <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com>
 <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
 <20230426163512.GE18120@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230426163512.GE18120@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent, Miguel,

On Wed, Apr 26, 2023 at 07:35:12PM +0300, Laurent Pinchart wrote:
> Hi Miguel,
> 
> (CC'ing Sakari Ailus)

Thanks for cc'ing me.

> 
> On Wed, Apr 26, 2023 at 06:18:35PM +0200, Miguel Ojeda wrote:
> > On Wed, Apr 26, 2023 at 2:32 AM Laurent Pinchart wrote:
> > >
> > > Now, I hope that mentioning "lifetime management problems" will be
> > > enough to nerd-snipe a rust enthusiast or two to help fix the C code in
> > > order to implement proper rust bindings on top ;-)
> > 
> > Good idea ;)
> > 
> > I think it is definitely a good opportunity to consider how Rust could
> > fit the new design, and perhaps borrow some ideas from Rust for the
> > new design, even. If you feel like a quick meeting could help on that,
> > please let us know.
> 
> I think we have a fairly good view of what needs to be done, the rules
> are the same regardless of the programming language and whether the
> compiler or reviewers enforce them (Hans, Sakari, please feel free to
> disagree). Thanks for your offer though, it's appreciated.

I guess on many you don't need to care about lifetime management if you can
assume that certain things never go away. Sometimes these assumptions prove
incorrect, and that's what's happened here.

> 
> > > That would certainly be a required step, but I don't think it would be
> > > enough. On good days I see the media subsystem as barely able to cope
> > > with the current load, on bad days it feels it's completely collapsing.
> > >
> > > We have homework to do when it comes to maintenance for the media
> > > subsystem, we're doing *really* badly at the moment regarding community
> > > management and attracting (and retaining) new core contributors. This is
> > > a topic I really want to discuss face to face during the media workshop
> > > in Prague (and I know that many people are looking forward to that
> > > discussion).
> > 
> > I am sorry to hear that. One idea would be offsetting the extra work
> > by having the Rust person also take care of some of the C parts too.
> > That way you can also potentially get them to be a full maintainer at
> > some point, even if the Rust experiment does not pan out.
> 
> That's certainly something I would consider very positive. If anyone is
> interested in having a look at (part of) the problem and possible
> solutions, [1] is the most recent patch series posted to handle some of
> the lifetime issues, and [2] is a more generic version of part of [1].
> 
> [1] https://lore.kernel.org/linux-media/20230201214535.347075-1-sakari.ailus@linux.intel.com/
> [2] https://lore.kernel.org/linux-kernel/161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com/

Thanks for the pointer, this would be nice indeed.

I haven't had time to work on the media device referencing series, overall
it should be good for merging but Hans found an issue I haven't had time to
debug yet. I do intend to continue that in the near future though.

-- 
Regards,

Sakari Ailus
