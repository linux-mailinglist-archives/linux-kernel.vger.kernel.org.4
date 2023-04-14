Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396EC6E2698
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDNPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjDNPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:13:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B441998;
        Fri, 14 Apr 2023 08:13:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q26so11603814lfe.9;
        Fri, 14 Apr 2023 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681485230; x=1684077230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1i9POxXL2777GsR/j6INE2dl4zVKrOsk8Lf5CQ9YEg=;
        b=H7IxpeBTfKCBd023oZLfPoA3qrnC7QnoznZHwxU3HNrafJZr+FWpYQg0u15SuiFThe
         TjC2v/OrxLgT6CxRkRX6EefPmzQBoNKJpPgvHOMP/DnxPhZw/oWRMZzw4APivQ0EoP/0
         NAoU4OgetX3g+EyqtNG1tWcS3ZMZPlcS/RDPFNggnAifyUUR6n3V3v2n/xA/chaeo3rD
         SYklJjiI6hsqMCtjKU1XzypeZqXB57L/Kj4Iy6WyJu/WIfPZZRbSLzZuVAWAYZtAf88D
         ukh4X5xSkCtzHUZ+Y3O+SelbwGuItURTe4cmodhVNfluz7UAiKc9Cczn7VEHVQlnEIdA
         OMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681485230; x=1684077230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1i9POxXL2777GsR/j6INE2dl4zVKrOsk8Lf5CQ9YEg=;
        b=G6WGVumeIi1k5AYNbCwv/pgP+IjXhlgWeJhTEIT8elaR/C3oDWzcnOKWvpsFshUWeJ
         EF6IivkRI1yFmrHrm5ZCMqz83M+hKwJnwUujO4vsAm8h4FU8OpLTtDSr6ln0IgN37o4w
         /YrO6UqdYerZ3Ey6ZCoGUCBc6fOTAqgc2IWo5H5hX6vjEEX6VfKRG34wuF9kGh4oXIpM
         kTPy0833aynXD/dXkAACqjNQy4n/NLSaoXu11hHkcPEguUzwVO26vIjKVRaLDrRfla2i
         YUvd1YKckvh8DNunriYdnhQkF74czA9awTwcNFOprgrOq7/rAZnldut45+FYkFXrqLrW
         YMfA==
X-Gm-Message-State: AAQBX9fKiickdzzUCyhlWMokh6qzIuu7FJuw3aj7L2ZGmuqKmGoztRDf
        EX6SJailuBMms+vQ0jWLJdxmjJDf1xzFafndgYdHFTztQWr2Xg==
X-Google-Smtp-Source: AKy350buEZ+jHD3FTo9kQO15nElpW2d75hlaGxdWtyuHa8fl7wxFZlvOq71mZFNNZVS9ySKKYCyu1ccOgdHBSQ0ubjU=
X-Received: by 2002:ac2:5a0c:0:b0:4ec:4f38:10d6 with SMTP id
 q12-20020ac25a0c000000b004ec4f3810d6mr1951001lfn.2.1681485229598; Fri, 14 Apr
 2023 08:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230403211548.6253-1-jorge.lopez2@hp.com> <ZCuMkdb6jeL4S8hz@debian.me>
 <CAOOmCE-5NHkYcmBP1GGpr=sEoxF9jkjj1LevekEm8R0wbrM4xQ@mail.gmail.com> <565e6575-91f7-9ca2-1505-17527b95a816@redhat.com>
In-Reply-To: <565e6575-91f7-9ca2-1505-17527b95a816@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 14 Apr 2023 10:13:28 -0500
Message-ID: <CAOOmCE9HurxZf57CjUSxAF5TXvMGukyfP6RbaTbkEeWyeRqcsQ@mail.gmail.com>
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Version 9 review for the sysfs-class-firmware-attributes document was
submitted and I look forward  to getting your comments.   I understand
you have other things happening, but as soon as the document is
finalized, I can move to submit the rest of the files.

While the document review is ongoing,  I proceeded to address all
comments made by Thomas, Hans, Bagas, and Mark regarding both
documentation and source code changes.  The code compiles with W=3D1
flag without any issues and the  refactoring proposed by Thomas was
incorporated.  Testing on multiple platforms continues to validate the
driver proper operation between reviews.

Regards,

Jorge



On Thu, Apr 6, 2023 at 9:08=E2=80=AFAM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi All,
>
> FWIW I have been reading along with both the v6 and
> this v7 posting.
>
> Thomas, Mark, thank you for your review / feedback
> on this series.
>
> On 4/4/23 15:37, Jorge Lopez wrote:
> > Hi Bagas,
> >
> >>
> >> Where is the rest of patches if this is a series? Had they been merged=
?
> >>
> >
> > There is only one change as requested by  Thomas Wei=C3=9Fschuh
> >
> >> Feel free to ONLY submit the patch with the documentation for the next
> >> revision. Then we can nail down the interface and initial functionalit=
y
> >> and you don't always have to adapt the code to the changing interface.
> >
> > Perhaps, I misunderstood Thomas request.   I will address a few other
> > comments and will submit all files again.
>
> I think that Thomas' suggestion to first focus on getting
> the userspace API right and then implement the agreed
> upon API is a good idea.
>
> So for the next version just post only the documentation
> patch again please.
>
> Note it is not the intention to merge just the documentation
> patch without merging the code first.
>
> The idea is to first nail the API down and then modify
> the code once to implement the agreed upon API.
>
> Then once the API has been agreed upon post newer
> versions which also include the code again.
>
> And then once people are also happy with the code
> we can merge both the code + documentation in one go.
>
> Regards,
>
> Hans
>
>
>
>
>
>
>
> >
> > Regards,
> >
> > Jorge
> >
>
