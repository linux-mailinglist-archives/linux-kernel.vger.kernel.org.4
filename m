Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8D616AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKBRgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKBRgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:36:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD362DABB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:36:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g62so17025650pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLhN9RFu9lLBh91C0UtWEhSEpP5/7mxewMk7n2SRYqo=;
        b=TCPbdfHFK8PufvJtOF7JykF9ukR2D408gd66jGiNn7p4qAkkkKLDADOOUXIwGXmVwn
         Eo1Z9Sfu69Uu0+K1t3oHEZUyCgEMDP4pxlvkgA4EIEkI1vuF3GyWEbaBcpaz6I0N7hhG
         pdf9LKahB2wCMaoek5BAVBwLx8Rgq/H1a4WgDfY31ckTddSIkIKcwKBnYSAVKYq0KkfB
         2/uSCcOai2Cuol0HCJGBKhDaGRaBuPfcUSCRZQfW5JFoPwkTdi7sg8Y7dsgyERgTPjtt
         YEj/IvnwpuWu3ejhh3ijITDJXz0J/4eGbWQn2Rmnwu3JzJUrO1Pogc9RRAzTh3l9nxIe
         kwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLhN9RFu9lLBh91C0UtWEhSEpP5/7mxewMk7n2SRYqo=;
        b=go9iJeKSS+78Ve/pdGmLRDm1cF/B5htp+Grzh9sZjB2BoquhfqwYpdXLPVANy9+vVS
         wvPF+rvS/3Xt6vJaECBp1nivL8qiwKYbk37tVtWPwUwkT22/bCAIW/y0grzSV0lyDNWp
         XIP9aAWV4LmC5fxGuPesD4PbjcCtk2uc26Ua8I7vPRDKkmTBQQoQ62JbIgey8gGni5jo
         6MARVA0wPGGiSlyoCe1Zvm7mxbu4O2WeUoX3tUtr8cDQkUpbrKC9N02LJCcFTmqNC/21
         kNNZCmZQHCSpJs2OJ04y2jHjxEH1gjXIS8AOM9tBFBlOuMWH7l8GGSe2/wXPNd03B1OS
         xgfg==
X-Gm-Message-State: ACrzQf1uyUJ6/F0FU/IcDko+QoX1kMTJjhCGcAUJmMSv4yEZxoK2rHFw
        nNzjjM3t6bz2NoQlQq23jZaRSx4SpTIbxGRkaB3gZNPn
X-Google-Smtp-Source: AMsMyM7kXpSfh5vYrWgCKxtJUf3iqZZNbn7U3YVDwuL+qIEaCcfisIgbHInB/2477lIEWKsQIMP/KomrJDAMTRNLKz0=
X-Received: by 2002:a63:d757:0:b0:46f:9446:273d with SMTP id
 w23-20020a63d757000000b0046f9446273dmr19336230pgi.436.1667410579598; Wed, 02
 Nov 2022 10:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz> <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz>
In-Reply-To: <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Nov 2022 10:36:07 -0700
Message-ID: <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Zach O'Keefe" <zokeefe@google.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022 at 9:15 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 02-11-22 09:03:57, Yang Shi wrote:
> > On Wed, Nov 2, 2022 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> > > [...]
> > > > This is slightly tangential - but I don't want to send a new mail
> > > > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > > > explicit node vs having hpage_collapse_find_target_node() set a
> > > > nodemask. We could then provide fallback nodes for ties, or if some
> > > > node contained > some threshold number of pages.
> > >
> > > I would simply go with something like this (not even compile tested):
> >
> > Thanks, Michal. It is definitely an option. As I talked with Zach, I'm
> > not sure whether it is worth making the code more complicated for such
> > micro optimization or not. Removing __GFP_THISNODE or even removing
> > the node balance code should be fine too IMHO. TBH I doubt there would
> > be any noticeable difference.
>
> I do agree that an explicit nodes (quasi)round robin sounds over
> engineered. It makes some sense to try to target the prevalent node
> though because this code can be executed from khugepaged and therefore
> allocating with a completely different affinity than the original fault.

Yeah, the corner case comes from the node balance code, it just tries
to balance between multiple prevalent nodes, so you agree to remove it
IIRC?

> --
> Michal Hocko
> SUSE Labs
