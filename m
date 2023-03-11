Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B35C6B58BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCKFsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKFsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:48:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB1193C3;
        Fri, 10 Mar 2023 21:47:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ix20so1297683plb.3;
        Fri, 10 Mar 2023 21:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678513679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VxGy4Glt2OF0QcpI3muqQxjIyFPMSXr0lZgr8KZ/Ro=;
        b=qs4M8oUz5kFNHDWGNy/BGsWt4U31ZoSE620q21saLBWCyVrZ5Y+Q4MozGsX4BJmoXd
         dWWj9uowCd/ywPYT1UFDcLsW/680mCFMv1qFZTsDqV9mf2ILcxkJPTGfP/cxk/qeJBQM
         GQ32HqwtPOj4RksKHjvdHlrNUEB3QBKcSAvpZ+B4dXoUYa5RADNTS5/PA4SmlGfwq6bp
         CQQdjGtL8GIBmD1wmOVekjLeC9IA29AzSOY0yCzLyls2v5xnKgMcYSHbashA+bxcLbwr
         M8MPHgZq4tsZ7OL13FeLql0xIETgVBqtkn9D5UPPxi6OxR7jYQ2St+x5rFuZ0C7Q1qLq
         bdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678513679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VxGy4Glt2OF0QcpI3muqQxjIyFPMSXr0lZgr8KZ/Ro=;
        b=qeTjhNBtuMch/3bPNzyH2mr5dtemSx/tsi+y0LrpxipR+DaArykuuaGn0PMEWh8TkU
         2t2DFoDfijpq93D4fMk6iriZ92XgG/Y7t/8k+cmsjhtYU6cQ9v3rq5tVH/3JKc7GLlzS
         Vi3x1PBaa4lxRd3q7SSmBMr1seFa8aldzhfHHEQab53x2cF/kLcSeECD0syY3le0f2T0
         FQZ+K6fpsUFmS84iCvNRwXiicLwHem3FC0jHsF2/YT/ioTRZ80zoKOsk1gMRJyL4CUvD
         AiDYE5NDNjoKtzXxor6M9IPTA89zisEQSZ6939aPt8blZf0FuyVXpHDk/6krm0pO17Wi
         5Ytw==
X-Gm-Message-State: AO0yUKWx3lHUBL5x3GclmH8VuhxNNc7hceuLK45jJk0fed44YkYejHCy
        sH2ONl4PNL1sdy4Ijq16Ef+OM7lRmJxSmD9hHxCO1WkW6tvmRw==
X-Google-Smtp-Source: AK7set91eKztEbHw235fJwsfpaZOTiapoa2WTLhMBSufJ7hiRdDTdOAVWb0fQw2n4H5se1LkeXRqCgkQdYqnpi7ighE=
X-Received: by 2002:a17:90a:4109:b0:234:889e:d88d with SMTP id
 u9-20020a17090a410900b00234889ed88dmr10377045pjf.5.1678513679139; Fri, 10 Mar
 2023 21:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20230207043318.23842-1-mmyangfl@gmail.com> <nycvar.YFH.7.76.2303101506030.1142@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2303101506030.1142@cbobk.fhfr.pm>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Sat, 11 Mar 2023 13:47:22 +0800
Message-ID: <CAAXyoMPMbYCV7br9DJn_KCq68RLnimockqU0uvsO8maT3ROxTA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] HID: kye: Add support for all kye tablets
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jikos@kernel.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8810=E6=97=A5=
=E5=91=A8=E4=BA=94 22:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 7 Feb 2023, David Yang wrote:
>
> > This series refactor kye tablet descriptor fixup routine, by using a
> > template and filling parameters on the fly, and add support for all
> > possible kye tablets.
> > ---
> > v2: fix missing rsize assignment
> > v3: fix geometry
> > v4: split patches
> >
> > David Yang (4):
> >   HID: kye: Rewrite tablet descriptor fixup routine
> >   HID: kye: Generate tablet fixup descriptors on the fly
> >   HID: kye: Sort kye devices
> >   HID: kye: Add support for all kye tablets
> >
> >  drivers/hid/hid-ids.h    |   9 +-
> >  drivers/hid/hid-kye.c    | 917 +++++++++++++++++----------------------
> >  drivers/hid/hid-quirks.c |  14 +-
> >  3 files changed, 414 insertions(+), 526 deletions(-)
>
> Now queued in hid.git#for-6.4/kye, thanks David.
>
> --
> Jiri Kosina
> SUSE Labs
>

Thanks. But seems you missed the last patch.
