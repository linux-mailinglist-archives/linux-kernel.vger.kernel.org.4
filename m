Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57764C53C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiLNIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbiLNIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:44:10 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB7B1E1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:44:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so18487211wrr.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFbiU7VEwAw0bA97Uq2Eiqhf3WWFOU3J0380cp459hg=;
        b=lfGHZhQ3hfx7k8wIy9FYwrgy2Xs8M7H3RHCSFlTzebBD5xSDCPK32JKezaXTWU9q49
         ARds31+oznKiWKfFZiFRKqdiabzBxCjHIcpnOpCDw7MW/K1WnMr28r++vtZQfbAn2ZP7
         HB2ERrnP8EaA1PkspkpwEp3F4PY40f2miU8pOAcuU36cu1xijB4Ge0X47BEgeRsFvieJ
         unB8qyqGd79LvKvsQTkV692EQS4cKH6OycMAoAjJesrhIHWPjKRcQBpUclpOrNWlEJr6
         sfFkTmbGcL5tOwjQQoZMBH/KvMzxH4PFaPlSOAoUb6mw35GNgEB9Hsk/JFepWXL4l9Wd
         m25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFbiU7VEwAw0bA97Uq2Eiqhf3WWFOU3J0380cp459hg=;
        b=zgnPGPpciF04mB/dlqsgUtXe+tKbYfF2yAXuQbf5nknjjhhFd099Y1ee/N3Yyv6fDn
         WSUYy+tWS3wKbv8hVHArYnhzA+J7Vb/Ur2YxTIc9QohyD/dvDG1aELFoJ/0S1Ovon4yD
         mAc51Lcp7yij5l8v1LuE7W/UvWheWHFDUIDNa7/eSA+/zbsS5SnNBUhgTKkIV2Ynpavh
         NNfJeLJULJGBZM+i+aQ7YIpsO6QkeXjy/Nm9BZwMcJAu3eutMJHat6NePc02t/LqL76w
         aygh9BVCtBPsjhjuf6YVbG0Q1i9Vxtfv1HRVMX2F5+zhHnzYfN2Ft7nchqzfO5GX3RGY
         2/1Q==
X-Gm-Message-State: ANoB5pnn/h0ZSbxIQFpFm0gkjiKBgyHZLYsfsskzI/wpNRTzHM56eM9f
        xgJOu34RcCROTrM79AHot3b+bAeLzY9H/NpMuZWa2+A=
X-Google-Smtp-Source: AA0mqf4BCt14a+/WtrCU3hEYw5NPcRe59P69N3siRY7b2peYffk2B4g511J5yRJ1geeMDkU11swg6O6vkgg64WKINfk=
X-Received: by 2002:adf:d0cc:0:b0:24f:21fa:c436 with SMTP id
 z12-20020adfd0cc000000b0024f21fac436mr292939wrh.569.1671007448149; Wed, 14
 Dec 2022 00:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20221018120056.1321426-1-sunliming@kylinos.cn>
 <20221018120056.1321426-5-sunliming@kylinos.cn> <20221018092641.0cdfd3be@gandalf.local.home>
In-Reply-To: <20221018092641.0cdfd3be@gandalf.local.home>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Wed, 14 Dec 2022 16:43:55 +0800
Message-ID: <CAJncD7S74FPuPvDw=vfmB8zb1LcWhr=evhCNzvHLz+pALu34Cw@mail.gmail.com>
Subject: Re: [PATCH 4/5] tracing: Delete timestamp_mode trace file
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
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

Got it.

Steven Rostedt <rostedt@goodmis.org> =E4=BA=8E2022=E5=B9=B410=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=BA=8C 21:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 18 Oct 2022 20:00:55 +0800
> sunliming <sunliming@kylinos.cn> wrote:
>
> > The timestamp_mode trace file is not necessary duo to the removing of
> > the absolute timestamp.
>
> This is user space exposed API. Which means we do not just simply "remove
> it". This file is the reason I kept the absolute timestamps around in the
> first place. Because user space may want them.
>
> How do you know that user space isn't using this? Is there something else
> you are planning on adding that makes taking the risk we might break user
> space worth while?
>
> -- Steve
