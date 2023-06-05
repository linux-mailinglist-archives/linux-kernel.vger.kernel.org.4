Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0862B722C50
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjFEQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjFEQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:16:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911DCD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:16:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d44b198baso3594248b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685981779; x=1688573779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35sMshWyVXfdoADM+yQmB9I/X5BPYaBf8EWUc6Z+vY4=;
        b=p+Eo+7IJKaYPIpSaNIQ7++voM4Zs3LJNSK0/DAx9PhSJHxKywUAajzgDcGyPNdu6xz
         e2GSLx1DNqBYHQZ2tKoZEgAdjP6QqhY4IY5MdLMA5zRhwlCnuUrvHxa24ZuUgQfDy3Kz
         /d5cTbAkP2En6CPvMRCbmSRNv3xYg48yLuyAxUox7D4I14Em+XGpZ922SCzQgMqvOdh2
         PWkHSORfIyYk3uH27uEwpqkpuMIHx2rzo4ibRG/6bhCwkhL2mjJG4oV8fjbKH5u0HwWy
         QrP1VFqQaA7YpbYYiyRKkzJszxYDc8aGk9c4W535Gd/IE9ShtkgZ2NFBbxpXzTNwJt/U
         tQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685981779; x=1688573779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35sMshWyVXfdoADM+yQmB9I/X5BPYaBf8EWUc6Z+vY4=;
        b=XoDJlU6IOk6gRtcxJfbzVid/2Sq2r0LOHtadwnw4rsMG9wT+eKkBmXAqfNfgAhnUor
         4Fqlrr/tRiUUUeN/pwzxCt2z6MWple5uP+tSrHn+FcASqKNQnK37Lv4MlpdmLv0r0mOm
         jXjede4Y5vy/DoO74JRcJZezGzP3RPAZHWWiN2uFQ+iTB3cZJp/bZOjA5f0A9W4DIrj1
         LeHkqluN6KwkaRB/irxbYdIdQIEUCRvqHv2k0Dn2GRg0QORjwgfohBc72Mx03VNBu6Xu
         h6zAAkQwWCUZ8yCIvM/WbAhKHL8KHQrJAYUoAHzgvTzDuQPgiSobY+1N8uFMtCDyTbQD
         fLkw==
X-Gm-Message-State: AC+VfDxpyZvn7quSHMBvUiOay+TCtPqtrro1oMaB5oxsAmRSIsLGthJu
        F1JVuLX+3jsZH5oJ0lliIocKOJZqhRM=
X-Google-Smtp-Source: ACHHUZ4KkMbIOztvPo0Dq0fq1vH6QIYQaClNUgTaoOXaK6RxEFgOSMLwZyXZqcL8aQlSRGb/ZA6BZQ==
X-Received: by 2002:a05:6a00:15c2:b0:656:5182:5e61 with SMTP id o2-20020a056a0015c200b0065651825e61mr305558pfu.2.1685981778839;
        Mon, 05 Jun 2023 09:16:18 -0700 (PDT)
Received: from pc ([2405:201:2003:b135:89cf:b185:51e1:ed4b])
        by smtp.gmail.com with ESMTPSA id v8-20020aa78508000000b0064f71d8adf8sm5389152pfn.208.2023.06.05.09.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 09:16:18 -0700 (PDT)
Date:   Mon, 5 Jun 2023 21:46:14 +0530
From:   Raag Jadav <raagjadav@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: act8945a: rely on hardware for operating
 mode
Message-ID: <20230605161614.GA6548@pc>
References: <20230605104830.68552-1-raagjadav@gmail.com>
 <04b8fa24-e5a8-4871-a397-f1c0c886449a@sirena.org.uk>
 <20230605143103.GA3068@pc>
 <545d3463-ce56-41d5-9d95-55764c448c09@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545d3463-ce56-41d5-9d95-55764c448c09@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 03:44:37PM +0100, Mark Brown wrote:
> On Mon, Jun 05, 2023 at 08:01:03PM +0530, Raag Jadav wrote:
> > On Mon, Jun 05, 2023 at 01:16:33PM +0100, Mark Brown wrote:
> > > On Mon, Jun 05, 2023 at 04:18:29PM +0530, Raag Jadav wrote:
> 
> > > > Convert ->get_mode() and ->set_mode() hooks to read/write operating mode
> > > > from/to hardware instead of relying on driver memory.
> 
> > > Why is this change being made - what is the benefit here?
> 
> > Original implementation uses drvdata to load/store
> > operating mode for the regulator.
> 
> > This change doesn't really add anything new.
> > It is just to make sure that the driver is in sync
> > with the current state of affairs in the hardware
> > instead of relying on locally stored status in the memory.
> 
> It's also removing a cache so we need to talk to the hardware more often
> which doesn't seem like a win.  If there's a bootstapping problem then
> shouldn't we just read once at startup?  If there's no problem what's
> the advantage?

Well, there could be cases of access which are done
outside of driver context or hardware failure,
which are not really ideal but I've faced such problems
a while back, so just decided to share it.

You have the final call on this.

Cheers,
Raag
