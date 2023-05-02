Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E109C6F49AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjEBSal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 14:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjEBSaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 14:30:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90B1727
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 11:30:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24e01ba9e03so1900787a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1683052237; x=1685644237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAQhEZIUqoIg0WnQQGu+sRHru4VeOPDcrcJOWO8mzYM=;
        b=QjM/2sf2VRIXbJlIzRfspouLF6OuZM13jytkJSo3lm29qCdTX3iy9oFho8ke4D04d6
         +fvfL7eI22XqKz84cG+LDpkPDr9sOlvKINQQLOdwgTfEkbG/w1xgS1i7TagtJipDNBIJ
         cntbWwggh4Gt23pMnbxqAxN0HmsNc+SUBdKZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683052237; x=1685644237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAQhEZIUqoIg0WnQQGu+sRHru4VeOPDcrcJOWO8mzYM=;
        b=K0JunTXcMB6mAHmejMTuVF/JLdumV5EI5ZHa3eESBCqWTfKo9KTyzON04n3i/V/b7M
         +zU6Lg1SbsziUH1YMDfWAGoPWwvp3LeaX3DK0byC9Z+BCPpptO8PMyC7QDe/6wl15b1U
         EAthL1dXlMIpxwMbIDg9eu22wFngjouQNdSbBtsSyOKeblROHJLeHaRRRmL9MR0aES14
         Pf0crFA5TKzbUNTrK5DRn7iiuvwxRCh8SXUkXnPDeqNa9F/O8E0BewDTG0G1P9tyPisw
         0d/i5CvrfgG7wLVvbrwxsrGtuj05FcAHXAW/OHQmq5+5uBra4UhbC802sJh+p53Ix4gh
         0GCA==
X-Gm-Message-State: AC+VfDwTRLaZoihajlrxMI3+g39lL/d4goEykW7KMLrfEdrQC4LKAVBC
        aa1gzjojdYtO9mSNsTbwRwv+DyS/Qkvp/gAV/+Oy
X-Google-Smtp-Source: ACHHUZ44v9vV7G6qU3mFhTW1gmFkmFApbCz7Px2x6Eyp75qSLo/vyu2HGH0wO8TM3A3QDhzJO/gbUVlzC/Dwiaqo1rs=
X-Received: by 2002:a17:90a:195b:b0:23d:3549:82b7 with SMTP id
 27-20020a17090a195b00b0023d354982b7mr19010390pjh.46.1683052237457; Tue, 02
 May 2023 11:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-f3c5429e-4361-4068-b88c-fb528681881a@palmer-ri-x1c9a>
In-Reply-To: <mhng-f3c5429e-4361-4068-b88c-fb528681881a@palmer-ri-x1c9a>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 3 May 2023 00:00:26 +0530
Message-ID: <CAOnJCULybsPrygGe6easQUgFTXOSUFQ+nOPEYp57F-vkvhuHLQ@mail.gmail.com>
Subject: Re: Atish is looking at the excessive bouncing
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Cc:     linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 11:17=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> We're not sure what happened, but it looks like a lot of people are
> getting dropped from the list due to excessive bounces.  Seems to have
> started recently, possibly today or over the weekend.  We've always had
> some issues with the bounces, but they're a lot worse.
>

All the bounces are related to the gmail server which treats genuine
patches as bounce messages.
mailman server disables the membership if it gets too many bounce
backs from the recipient.
It seems the mailman server can't do much about it until the issue is
fixed in the gmail server.
We have increased the bounce threshold significantly in order to avoid
disabling subscriptions.
If you still get one, please reenable it manually. You should receive
one reminder email for that as well.
There is no other solution at this time. Sorry for the inconvenience.

I have included the broader kernel mailing list in the hope to see if
anybody else is also facing similar problems.
It would be great if anybody working for the Google/gmail team can
raise this issue internally.

> Sorry for the headaches.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
