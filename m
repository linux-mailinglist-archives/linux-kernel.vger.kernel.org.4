Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D19C6194BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKDKoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKDKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:44:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E02A710;
        Fri,  4 Nov 2022 03:44:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z18so6974333edb.9;
        Fri, 04 Nov 2022 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=984IZej2mpdfs/fIVIJrApYfJ2ble3SFoZ3qX9WWZUI=;
        b=OyPUd67uCOVH7YrzM/9zBOMG+WKJZ+EfvUfZU3bkm73J8oCFzRIv23+SDpStY2AqsG
         3mj3qni8KM/Zc8JXJ8HW6B4lgOkhb6MVakT/Xjo6UFlJb0m+UANTI1nS5AbAUexswzBK
         fUSq7RwprE0RwmoUbZHYzVksK4ku0z1PkYEKQ2bZuNup5G5ykjr5go1eaOUhFB8I6P1W
         oN6A966G45t934QMxLXeD2XCbBpBWVFEgdwve5bge8gAlyLv6MJy8fPNOyhfAWYKpsMJ
         zhCP1CKs2lh75KPLRqTSuL9FWSzD564kf0wEvoX1OXhvUt3l2Jykn3zHw5KN3iJcSwyb
         i2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=984IZej2mpdfs/fIVIJrApYfJ2ble3SFoZ3qX9WWZUI=;
        b=S9tSaP1dV/yL+mrblsfVAsGEzzYUVlCMlIm52vjhmpxihVzQcLoALbjBs31mthcO/n
         tyNTlK1+PErQGHS/PBSf0CCcHE6+CnxWIF2CQ6LhQWyHLpM6CS4X8bIk1BbXINHrEpez
         fXVebd7PxzAUlLyKjrQCX+h9dUe+zkqkA0ArFr2FcQYjeD+8ec0c3WowFjXg9JVR4E2w
         0fvWznN3GvaMNhOXF1aDl7UMEw4mlKti/0vJMwRNfN7bplKcCi1rDHNt62fJXspnf3fJ
         lYbxKBTsA1sKsgi/27xVO7oy06aglBU1TdYf0BtWaUCBuMpZTv2+Q1UVoLJBVMn4fJiO
         q63w==
X-Gm-Message-State: ACrzQf1dLMD6LmjpD8VLxoFwLNPLshZnH2TTeM4hnMzYnd3yJqaBuJiU
        dF7K0nQ5QB5Y8ydTDIktu73qeDUknmizWxJHA8A=
X-Google-Smtp-Source: AMsMyM7yA9RwnPl1pTphZCD/GOgwhmwFfbH8fVNcTNQcUEE3usKkVdf1LVd5wXAfen5Qw2q0BsqO5IVGFnqQ2MwA1KE=
X-Received: by 2002:a05:6402:26cc:b0:462:2426:4953 with SMTP id
 x12-20020a05640226cc00b0046224264953mr35367648edd.13.1667558644616; Fri, 04
 Nov 2022 03:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw> <ebc45ad9-9c26-9598-9e54-62d93be8de31@intel.com>
In-Reply-To: <ebc45ad9-9c26-9598-9e54-62d93be8de31@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Fri, 4 Nov 2022 18:43:49 +0800
Message-ID: <CAK00qKBvqZ_N3YceRhQq8cbWRzkc0uc2qNbdSmrBZ3toRZ5Piw@mail.gmail.com>
Subject: Re: [PATCH V5 00/26] Add support UHS-II for GL9755
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
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

Hi, Adrian

Adrian Hunter <adrian.hunter@intel.com> =E6=96=BC 2022=E5=B9=B411=E6=9C=882=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E5=87=8C=E6=99=A81:28=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 19/10/22 14:06, Victor Shih wrote:
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] support UHS-II and fix GL9755 UHS-II compatibility.
> >
> > About UHS-II, roughly deal with the following three parts:
> > 1) A UHS-II detection and initialization:
> > - Host setup to support UHS-II (Section 3.13.1 Host Controller Setup Se=
quence
> >   [2]).
> > - Detect a UHS-II I/F (Section 3.13.2 Card Interface Detection Sequence=
[2]).
> > - In step(9) of Section 3.13.2 in [2], UHS-II initialization is include=
 Section
> >   3.13.3 UHS-II Card Initialization and Section 3.13.4 UHS-II Setting R=
egister
> >   Setup Sequence.
> >
> > 2) Send Legacy SD command through SD-TRAN
> > - Encapsulated SD packets are defined in SD-TRAN in order to ensure Leg=
acy SD
> >   compatibility and preserve Legacy SD infrastructures (Section 7.1.1 P=
acket
> >   Types and Format Overview[3]).
> > - Host issue a UHS-II CCMD packet or a UHS-II DCMD (Section 3.13.5 UHS-=
II
> >   CCMD Packet issuing and Section 3.13.6 UHS-II DCMD Packet issuing[2])=
.
> >
> > 3) UHS-II Interrupt
> > - Except for UHS-II error interrupts, most interrupts share the origina=
l
> >   interrupt registers.
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1-#6:  for core
> > patch#7-#25: for sdhci
> > patch#26:    for GL9755
>
> Thanks for putting this together.
>
> I haven't looked at all the patches, but have requested quite
> a lot of small changes, so there should be enough to be going
> on with for now.

Thanks for your help. I will confirm your advice in each patch and
follow your advice to change.

Thanks, Victor Shih
