Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790AE6AF1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjCGSr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjCGSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:47:04 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2FBAD2E;
        Tue,  7 Mar 2023 10:36:14 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d7so15395339qtr.12;
        Tue, 07 Mar 2023 10:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678214149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h2mBcr4WZsvt4Bcr6dnxp9ONM85phZYpVsfFFx8PJFU=;
        b=D9awXMSZ79lX1tu4O1dyMkljVSVaz23XvDIiTiUkWiJZEmOYhW5lvok5a84H7/qlpO
         5GEqXV8KgriaDJVdbHoM5UYTuAtxfD6a4QPins52SWoOeHJfhQdM+qxWnou+kNoaI90M
         iz6Vr5RwC8a1dMDFNyFej81PPRycb6KJvL3K6we5CN/RoVvdBUeQk1iI5MBuM16uPicj
         rXFeo1vEMcViI1nuikuFT2cB+d6vGIVWOtSqoVzLZDUfMmSfbeTk5R1YytQUJnqkhuW5
         APi1jGs9ifUhuP5jz+UDr2BcD8JNc/9aFGzk9MPCQXZCKCvnEn17+y2ZWvDWWl9n40Hp
         SIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678214149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2mBcr4WZsvt4Bcr6dnxp9ONM85phZYpVsfFFx8PJFU=;
        b=7/meirdC8MbVAEd6ez6/pl2Bb6R0XNmfkGeeH/PAGPNj3RTD8DWAhKKuHqwNS9oxse
         Ack7WB3PgtRzBAzRHSS9lLSkfRoktgVqIMdRt57NyChw7bGQLYtzlSKpEFSrC6DFSScS
         VNUvQohM7mki8S3AWp83wZveJSRFcrONKTyv+xDwztaMj2OXH7GDr2Xwn++1kEnEKW0I
         RsuEipqxHNeMOX3Lt7sx4PzthHe6zAWE5GrFNA5kpxNI/u+TE9Vew9k+c5BeF+k603UN
         t3P54dp60NfFnaGFSuGyUBGV5wOPcYCRHZ6Gq9MbMnDXsxVbuh4NaXIvoX5asl7QGcX6
         Y0Cw==
X-Gm-Message-State: AO0yUKUZ/Eg8KoSe/4+bEWPx33ocqWgmqLWEemrglwKXFBcqKPKWFknJ
        9PWOx2f2fH4Ri7CF6pj1dhWPtkSw6rt3YiK+46A=
X-Google-Smtp-Source: AK7set9ztZHKUEAImfMt7M4fDI3qHFJrQpse/I5SIZkdyfjvUp6ZuvUdIe/AWzhOocCHEY+n8DuJ82mo1ui40I6GscE=
X-Received: by 2002:ac8:40cb:0:b0:3bf:c33e:93a9 with SMTP id
 f11-20020ac840cb000000b003bfc33e93a9mr4443310qtm.1.1678214149330; Tue, 07 Mar
 2023 10:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20230220023320.3499-1-clin@suse.com> <CACRpkdYknZo3Q7_CeSkOL2XwwAmKERskx24o-toaVy=rs0Yf5Q@mail.gmail.com>
 <ZAZ3JZQ4Tuz5vyH1@surfacebook> <CACRpkdbksZ59ndrRAQpTGa01GTq4c_2EcOQ2mtz1PLjqU8_nug@mail.gmail.com>
 <CAHp75Vf3ve-NdMG6iti-KSs=tGGgGf9tNj=aK7Jofk9233WocQ@mail.gmail.com>
 <CACRpkdaCZSoem31GmDC97LPYcZqRjkyf=6VGtXdXK0iwrV74qA@mail.gmail.com>
 <ZAc3nKEiYbUEX2xv@linux-8mug> <ZAdP1Z+LcgOQWvtK@linux-8mug>
In-Reply-To: <ZAdP1Z+LcgOQWvtK@linux-8mug>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Mar 2023 20:35:13 +0200
Message-ID: <CAHp75VfkmJnk_HqFjpfw1q+D+JgTDNe62OryEgwW4CyDbwQwrg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add pinctrl support for S32 SoC family
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 4:53 PM Chester Lin <clin@suse.com> wrote:

...

> Sorry that I just found that my mailbox didn't receive Andy's mail [comments on
> v5 2/3]. I will try answering it and come up with a patch ASAP.

The thread is available here:
https://lore.kernel.org/all/20230220023320.3499-1-clin@suse.com/

You can even download it using the `b4` tool (available in your distro
quite likely).

-- 
With Best Regards,
Andy Shevchenko
