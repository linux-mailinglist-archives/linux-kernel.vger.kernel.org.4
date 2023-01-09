Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C676632A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjAIVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbjAIU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:58:49 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D23181105
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:38 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id b12so6755409pgj.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI+HK5d2VVHprte9/R4H7nRhtttrT0pgRQ4cGp2gqIE=;
        b=XXSphh6WdemqNlaouq27ZMv9FP/uelVUYlorwcZLgqAYLkGmCZpoIMxcvLw17XqQlk
         Wq/rki201eF9da9X5SZjRnH7GUBOad2hD9nME7ux6bfICDszp0NTAoGgZjST8dPBU9+G
         +ZFmWlA6yHf3FEmbDRIWfg44SBnSMyDQgxkb/tvEfG1srLYwbSJfn9c96o2s+r6TSjT6
         H3adegRyMv9R2Dw43i668JZf5yOZ/EG0BOextW/2Py2wcB1n3OuHz6Z3AGINU8D0Zq6i
         uXuFYaX3t79fxm38YgA2HtmAMj1Jaa9W/62SfvD7oAOWMiuUv1dMC/CfSVan5XD+zdd1
         bAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI+HK5d2VVHprte9/R4H7nRhtttrT0pgRQ4cGp2gqIE=;
        b=xPrcrcEUdr7Z1roaQwCPhVdKsBz3BSFc1Ror1UhZrZHs1sPUqm8dHeMZD0kRJiLNSt
         hNX0c4uS5UE6Ql8e7K0XxSu/4UX2t+x6j4kioU1NumTgjEKCYWs37es+N4as/XXzJudf
         kcvne85taG0zY5B4GsRbPfJhtNiCiYVo1D1YmMPySjZUN+i1Pz8PF4EjVkvMYgaCG2z4
         CfK76TRIN11OX5kNnFlY3WehI5nD/njwK2SPEDhyiMvyEkjHeKdrW4DrpxGJsDzsToDc
         WwJJ5r/VFTcK0Oel6q7ZR/YfVrlHdlPv8mm5iPuNBMRr/BmJihGF1g3o+GfG0LsIXGyY
         eRDw==
X-Gm-Message-State: AFqh2kqT1NGTNl+YpRyND/Ddal6rR8oY0mv/QYn6JAt3j8OxOcN6UYN3
        TeA2+4a9L7GMCXJTwk4BqnBsdjupgeaT8inOmeE=
X-Google-Smtp-Source: AMrXdXtBdjMC2XbkCbg/sKxAYKrMMuQrVmVkCfTKgQdKmZ+HbnKyM9ffUAKFBpYnQwb9R5I/d32LLW0gc4vI7HYioOE=
X-Received: by 2002:a65:6bc5:0:b0:478:31a5:3656 with SMTP id
 e5-20020a656bc5000000b0047831a53656mr3286091pgw.273.1673297736001; Mon, 09
 Jan 2023 12:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20230103075603.12294-1-Kuan-Ying.Lee@mediatek.com>
 <CA+fCnZdk0HoWx6XCbTsiNhyR2Z_7zv5JUdgNs8Q_tV4GRkkmCg@mail.gmail.com> <dbaeb044c547ddb908bffdce4d2dfa0936805ef7.camel@mediatek.com>
In-Reply-To: <dbaeb044c547ddb908bffdce4d2dfa0936805ef7.camel@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 9 Jan 2023 21:55:25 +0100
Message-ID: <CA+fCnZfhH+XRU-Ywvb6WThjmwuSODfNV5fNxDpHY1enibdNYSQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: infer the requested size by scanning shadow memory
To:     =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "glider@google.com" <glider@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
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

On Mon, Jan 9, 2023 at 6:02 AM Kuan-Ying Lee (=E6=9D=8E=E5=86=A0=E7=A9=8E)
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> > Let's leave the first two lines as is, and instead change the second
> > two lines to:
> >
> > The buggy address is located 0 bytes to the right of
> >  requested 184-byte region [ffff888017576600, ffff8880175766c0)
>
> Did you mean region [ffff888017576600, ffff8880175766b8)?

Yes! Forgot to change the range. The idea is to refer to the requested
size in these two lines of the report.
