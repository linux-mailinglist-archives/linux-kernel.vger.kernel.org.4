Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD57F6A9F69
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjCCSpY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 13:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjCCSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:44:45 -0500
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F386231C;
        Fri,  3 Mar 2023 10:44:26 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id o3so2407689qvr.1;
        Fri, 03 Mar 2023 10:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677869042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw8bIUTiU2vbtsNFYG94UCO2h+hK2xlIDXReYCSiwSw=;
        b=kj48Wo4eT2LlgViafl4pKaQ6t2SES4II/RW6N4arGh0fXUtA2fVDjrF+irHA3jfZby
         NbBNMAGN6/iXNc7LcXdNNO741YALv1fZmW6yaKeoskLWCVhQ8y84In8H6tJGLc5DiH24
         HnDATehEM2SxuBIdtLbfvMg2Lxg73XQR0257a7GDNAXsG0yVRVW+Tf/orH7DSd7Sy5KX
         aM5lfJm5TVHfTR6ONbjpvniUsRBbFx1lmAjnv95QQsk13uK+FIstaDr+QMAz/+AokSRx
         Jm8b9hF2PIaI8zvDSwEddhWI51ck4G7gQqOKUPtl3U8M+86RqcuWj3ve8Ur6wXFINP1r
         Vr3g==
X-Gm-Message-State: AO0yUKWRTd2GkKWz3A27kpFZoUsgyUTP4KPTmy1hsmt8sC2M38TRHHq3
        4tgymGpf7Mx4LXCALlQ1InVOdpzzWdkiaA==
X-Google-Smtp-Source: AK7set9y/NnHd3yWFAgZYaMf8mkNTLiQwjllCxR0rE4o971YoU5Hr2R5VhbweISQQYQ6DTqyqkEt9g==
X-Received: by 2002:ad4:5749:0:b0:56e:9551:196b with SMTP id q9-20020ad45749000000b0056e9551196bmr4760807qvx.3.1677869041813;
        Fri, 03 Mar 2023 10:44:01 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id t197-20020a3746ce000000b007417e60f621sm2223982qka.126.2023.03.03.10.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 10:44:01 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-536bbef1c5eso58683307b3.9;
        Fri, 03 Mar 2023 10:44:01 -0800 (PST)
X-Received: by 2002:a81:b61d:0:b0:52e:f66d:b70f with SMTP id
 u29-20020a81b61d000000b0052ef66db70fmr1536593ywh.5.1677869041290; Fri, 03 Mar
 2023 10:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-6-nick.alcock@oracle.com> <CAMuHMdU2pCbOngWpeQOFYOmyLgSyMD-GCzsU4fQoafAvZchX1w@mail.gmail.com>
 <87bkl9bs9n.fsf@esperi.org.uk>
In-Reply-To: <87bkl9bs9n.fsf@esperi.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Mar 2023 19:43:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4rUMtuJr=2FTcipEyq_mo9PnKrd8rJtG-g83F5HA_Rw@mail.gmail.com>
Message-ID: <CAMuHMdU4rUMtuJr=2FTcipEyq_mo9PnKrd8rJtG-g83F5HA_Rw@mail.gmail.com>
Subject: Re: [PATCH 05/17] drivers: bus: simple-pm-bus: remove MODULE_LICENSE
 in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, Mar 3, 2023 at 7:32 PM Nick Alcock <nick.alcock@oracle.com> wrote:
> On 3 Mar 2023, Geert Uytterhoeven told this:
> > On Thu, Mar 2, 2023 at 11:25 PM Nick Alcock <nick.alcock@oracle.com> wrote:
> >> --- a/drivers/bus/simple-pm-bus.c
> >> +++ b/drivers/bus/simple-pm-bus.c
> >> @@ -92,4 +92,3 @@ module_platform_driver(simple_pm_bus_driver);
> >>
> >>  MODULE_DESCRIPTION("Simple Power-Managed Bus Driver");
> >>  MODULE_AUTHOR("Geert Uytterhoeven <geert+renesas@glider.be>");
> >> -MODULE_LICENSE("GPL v2");
> >
> > Please do not remove this line as long as the file has no SPDX-License
> > tag.
>
> I'll augment this patch with an SPDX addition, if you think that's OK,
> which it sounds like you do. (MODULE_LICENSE has side effects these days
> which a SPDX header does not, and those side effects are wrong for
> things that cannot be modules.)

Yeah, simple-pm-bus should not be a module.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
