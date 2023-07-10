Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC11D74DDFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGJTMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGJTLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:11:55 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE0FB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:11:25 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7948540a736so1597037241.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689016280; x=1691608280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTiSrPJ68bBh1WF8NAqk+/Z9aNvMpi0XqeGrN/eMmzs=;
        b=oSWlgOPKcLAvfEg/kmJX0zjE1F2BawjR4panXxZ5ek5rLFWZ4uHbTeuLWZ6QPxeL1H
         bJ3W6efBET8CoR/zBeiW29tw5sXGqgcs8LO5P/qzWC+6uuTXKEEy6pDbW29jUwKsZekr
         HolbQdX5Dn7i9Me9RPm7vfl4b7diH7qrFt4PtV4r8Gk2NtFElUOI2+94SAVfmvzEexI3
         xFMRtQwMlZbSi7V7bAfVNmjayRvTA/DL74Aww21b08e0ZFOu2Mc6TS02lKDXR205x4xO
         naRZSfiZwX2zI9b5zlUhK8zHSxweeZzWWQ8SGXzhndbiqapdbZUfxvImOK+P2bdGNkN4
         TgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689016280; x=1691608280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTiSrPJ68bBh1WF8NAqk+/Z9aNvMpi0XqeGrN/eMmzs=;
        b=Jb8Q1s0MwYIL+BgrkoFcfd6/bUwbLHYspszbbmEQuPlO6d53NBeOHC9mjMZukfA8A5
         ZEYl+2303kNndftxBWQG+faDpSmS7S4KNM6Yyazl/zY/dej1vYboPhJKUezw09EtSoPK
         wwWS8gS3TT0tvcgOI91Tym3ReJnABAfT9rbO80wE8yOMKTfMBezssNfhBoPlNEs6rsjG
         +airaqzdxscg/kX8cUwJCxxNNL21qvJmGEmqNFeKJmGKoWB/U3pJd20Md6H6IMMfbZJa
         NbmD459B+9Oej/pK2UyxGM9qYgXonku4ERidum9bDP4sskYKg9N+H5olX60UxSIlBQeh
         ul3Q==
X-Gm-Message-State: ABy/qLZ8kDGNa7CQzcTl0jR8vTRCRO21TvbGKzdHu6CcySf1vaW8iI9T
        c6MIFIdvK7aubrRgZIgAtV/DQtlVQbSwPqb0zqqguw==
X-Google-Smtp-Source: APBJJlGY9MDuNdXLb0NkP0Z+ZlIV2XpXYshiGSQl6L2QoJSkw34aI0JVRs6XVAoQYM4fEzcTuKIqz2WTi/xPaSjA9BI=
X-Received: by 2002:a67:f24f:0:b0:443:7e49:c023 with SMTP id
 y15-20020a67f24f000000b004437e49c023mr6989264vsm.6.1689016280782; Mon, 10 Jul
 2023 12:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230323205733.20763-1-asmaa@nvidia.com> <CAHp75Vd4m79RhG-_KLRNzr0SPzphG07fOiTWwmGCfx8Lz=+6Vg@mail.gmail.com>
 <CH2PR12MB38951D4AC0D3C373E17FDDBFD730A@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38951D4AC0D3C373E17FDDBFD730A@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 10 Jul 2023 21:11:09 +0200
Message-ID: <CAMRc=Mcv+dZsJB1yO8Y3Kh+7UJDAQXZMietA2KkGYE_+Xe+c7Q@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: mmio: fix calculation of bgpio_bits
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 7:26=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> Hi Bart,
>
> Could you please add this patch to the tree?
>
> Thanks.
> Asmaa

You still haven't sent it to my address and it's not rebased on top of v6.5=
-rc1.

Bart
