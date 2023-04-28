Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1D6F0F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjD1AAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD1AAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:00:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F902694;
        Thu, 27 Apr 2023 17:00:39 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b990eb5dc6bso13194252276.3;
        Thu, 27 Apr 2023 17:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682640038; x=1685232038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUcDpEJHAussWXp/YYiDDsR1eHJl9Fmj5B8fxAP8T6s=;
        b=TOwSJQl6LC+n21H5SUqZBuWXjhVPzXPbY07Hx6FNxo07cVUIUHbdAiHUTiowIREZHy
         jsDhhL2vor6uiwKNDOpf9t9LxxDbKZ6htNeSzXfw9qc8ByyPQInYZ+nSlFcj4G7HilRn
         LayVHguzoPmaH7e1UJEuDVWF3G1JtD2CPlNz71uqeZQ7Hh86SmUjFCVF1xA8S36hJRMq
         Kc3tyAjI7Cu6QQCppoIAnzI6U66dmilG5cqr6sODdImeBzcCldwFvBz7tgkEHWnOnSSy
         JaiMJ9K8T0wi3GHTKRXibyaQBpYnud52grL4dHnD6cIWUHmdczA03oVMyHaOAHZcFNVA
         thfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682640038; x=1685232038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUcDpEJHAussWXp/YYiDDsR1eHJl9Fmj5B8fxAP8T6s=;
        b=I5x7/MfiPzHm7KSv1B+ZMfwT0k/Q3+dLLkTCJvtuvurw2q1ExmqmMDES1qpxxBAVP7
         7BJkGaiaX8x6qyeVGJFwfwicbCHp2MPieh780eLCcLcik8Me+y9WbeV1ZeD6DAtOGash
         Yr11XQd0hcT7ma0epAh0x6+HRtCCWG/DpXd0UixLP0fJSjm7/BOdqp4DV51OUz+6u6FV
         YqU1UV84QpmtfjwNRbhI974LSzbbsCHuCQ/gsXJ5TGuIQjwprf8doUN5Qv7xI0hWRTxy
         ori8eR+Ps87+46IqWYI/LlyDdChgis5rhi/1gKbhSTvg90GlOGCsNGTmTKnvkzhQlVDn
         SIhQ==
X-Gm-Message-State: AC+VfDzW39MxT1Oq80i0Ilhfwyei89xZ/LBkvJHigGHOHgo5Gilfe4L3
        HdGPS91uVzi8qY+aL6MDGOmmsOLzX71NslZztJ4=
X-Google-Smtp-Source: ACHHUZ43oj1OhQg+lpZx1wswXGxfrl392bP770xpXxVSbV22QuwlM1tk7UnpNBALpRwVy/+SwL9AeMXnv5XvoeLVQto=
X-Received: by 2002:a25:73cf:0:b0:b99:71dd:869 with SMTP id
 o198-20020a2573cf000000b00b9971dd0869mr2836162ybc.53.1682640038607; Thu, 27
 Apr 2023 17:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230419111443.231151-1-raghuhack78@gmail.com>
 <20230419111443.231151-4-raghuhack78@gmail.com> <644ac94ad6977_182a92946e@iweiny-mobl.notmuch>
 <ZErR1J/PqEvfxHCi@aschofie-mobl2>
In-Reply-To: <ZErR1J/PqEvfxHCi@aschofie-mobl2>
From:   RAGHU H <raghuhack78@gmail.com>
Date:   Fri, 28 Apr 2023 05:30:27 +0530
Message-ID: <CAGWUp4ps_gkXpNerCNGSrsoZrJoL5PJu5yB4k9dGuOY8_mnWZQ@mail.gmail.com>
Subject: Re: [STYLE v1 3/3] cxl/core/region:Remove else after return statement
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alison & Ira for comments

I missed your messages due to personal reasons.

Will clean and follow it up with v2 very soon.

On Fri, Apr 28, 2023 at 1:19=E2=80=AFAM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Thu, Apr 27, 2023 at 12:13:14PM -0700, Ira Weiny wrote:
> > Raghu H wrote:
> > > The else section here is redundant after return statement, removing i=
t.
> > > Sanity and correctness is not affected due to this fix.
> > >
> > > Signed-off-by: Raghu H <raghuhack78@gmail.com>
> >
> > Ok, per my eyes I would have liked an extra space before the dev_err()
> > but...
>
> Well, I asked Rahgu to give us a v2 with mostly patch formatting fixups,
> so let's get that extra space too :)
>
> >
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> > > ---
> > >  drivers/cxl/core/region.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index f29028148806..1d695107b4a7 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -2666,11 +2666,10 @@ static int cxl_region_invalidate_memregion(st=
ruct cxl_region *cxlr)
> > >                             "Bypassing cpu_cache_invalidate_memregion=
() for testing!\n");
> > >                     clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
> > >                     return 0;
> > > -           } else {
> > > -                   dev_err(&cxlr->dev,
> > > -                           "Failed to synchronize CPU cache state\n"=
);
> > > -                   return -ENXIO;
> > >             }
> > > +           dev_err(&cxlr->dev,
> > > +                   "Failed to synchronize CPU cache state\n");
> > > +           return -ENXIO;
> > >     }
> > >
> > >     cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> > > --
> > > 2.39.2
> > >
