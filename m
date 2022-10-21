Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA866073B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJUJQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiJUJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:16:43 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0B61EA563
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:14:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f8so1640416qkg.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stK0AWcx/AZ01b7n2KWQ9iHqc49fEITiVHxzybb+U1o=;
        b=cskSjnwyJ6vHbgNG9yaijetiCA+RXGT7xI8Cp94+Rslp78do1CSrEKBFvkE7yzTaEb
         g9OQhPw15/9gQWBB+7QkpcnVSKo+ogPdChR0uxC19MJsRS9BlcLuWLOf2FFc6QbzA/DE
         Tf/tDKM0DuLzZgkKLqPu2fr1Y7kBpha/kjmbnU3ORoji7WNwkFVahWUSgpFApHfnIUSS
         Dircv1QvpkYHxk6BplB+GbekZVzQmtmucBwbPf46V72kMfFKa2lTwHyY+EcEViPVc0pO
         kEb0aec3tRZj4rZqKzklgGc+CSwohgpN5HsLEF0IH2ymj04Tl5HfqAv8pjCp4B69tHYG
         l5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stK0AWcx/AZ01b7n2KWQ9iHqc49fEITiVHxzybb+U1o=;
        b=rmgmcLCXOUAzTQghGw/pPARxZfeXTEwzym3v9SfhtxdtKyBFtKvXNjihSfubu/k8Kk
         zsZeLcO9TDkGMC3Czzu03BlI/uk1qSiktMmDkwgYAH2tmBNkXE7ECLKDmkLBwA6Pes/k
         9MqxLFEr96MsY3L26X5AfzrUXOwdPO4vW5inaeHuo+XZ+Uwg10Vv3ATY6Kav2Lwh1f2v
         RujhW6/StUfj2vXdR9YzbKYVxxpaUK8tCr5sHwrMChbs9/ls1Q5a1gTi0YBa9pn4Vw+r
         27kgH++uLEBOi3ICdjznDy1UP8o/0dFYoOMW2puypYHJAxosszv59U7EJJxJzQcK4zVF
         vxwA==
X-Gm-Message-State: ACrzQf01dKj2s81rumTRGuUBeQmjLHrVvpKX3iPcbsJZVRJsOxVIbhmI
        Ntvh3JVuWdpt+H/L8mWQcTMIGn0M1ZxqfRn0GDpyr9fYQVI=
X-Google-Smtp-Source: AMsMyM7cGoFHzxKL8B63R5Hkzf07vJCOm2dyRiGss62iQSTcyCB58ibn0DTDEeGKOMo1Ul7D3LAJn8NQ4gg753pYHdM=
X-Received: by 2002:ae9:e848:0:b0:6ee:92d5:94e4 with SMTP id
 a69-20020ae9e848000000b006ee92d594e4mr12931849qkg.404.1666343668326; Fri, 21
 Oct 2022 02:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <1666318661-11777-1-git-send-email-u0084500@gmail.com>
 <CAHp75VeMvWycVsNPHb1cvMbtVSCiX3m9wUsZk7HkPU+e=VTb3A@mail.gmail.com> <CADiBU3_m1gDgZxyo53UNvDP8P5LpFgpV+mBbw9+_epYuXimqWA@mail.gmail.com>
In-Reply-To: <CADiBU3_m1gDgZxyo53UNvDP8P5LpFgpV+mBbw9+_epYuXimqWA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Oct 2022 12:13:52 +0300
Message-ID: <CAHp75VeWMSeZiq6vUo25hRdueMbeEEQuzPqR=-ROsOufK+27LQ@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: mt6370: Add the out-of-bound check to prevent the
 null pointer
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lee@kernel.org, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        cy_huang@richtek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 21, 2022 at 12:02 PM ChiYuan Huang <u0084500@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B410=E6=
=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:34=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Fri, Oct 21, 2022 at 5:17 AM cy_huang <u0084500@gmail.com> wrote:

> > It looks like you randomly cut the trace.
> > It's not what I meant and documentation suggests.
> >
> I checked the submitting-patch.rst.
> To satisfy the requirement for 70-75 chars per line, I only keep the
> important log.
>
> May I ask what you mean for the 'trim'?
> Is it 'Still keep 70-75 per line and cut the characters that's over
> the limit to the next line"?

> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
backtraces-in-commit-messages

Have you had a chance to read this section of the document?

--=20
With Best Regards,
Andy Shevchenko
