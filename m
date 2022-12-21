Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9429652E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiLUJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiLUJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:18:54 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B9B1AF0E;
        Wed, 21 Dec 2022 01:18:38 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x11so13157764qtv.13;
        Wed, 21 Dec 2022 01:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ctf2ZSJojXMz8Wx/sBhIZ3U22vX8qUoHD6iPYv6j+BM=;
        b=VmNGpAbEaNirlpNkoRK5gBI0O0NprWyziC2lzPXY1oI3aHe0DSRTPyS6i6mxwUC1kO
         FVT/PleY/1bd9A3TMmwHt0kDpNN2pMlue+2MjiO2xER/mIO1qUhJ1SnPc8XwZ65qwEWv
         bO71i1ImAwruqx6u6sqaKlbP2swzA6BdgmU5FY2vSZZ9V+zOgLmoq/Ct4DbNda+N1M4c
         8NmCgFKIohJwhJZIrQ4zKLSrDg3nsoMgREGWfnsabXpgPp3iP4L0Ub0b6Qc9D9kJVxWC
         i21TcIfvq3dauQTgqzx1Ao/3wmfd6RZMZgNLUsNYkXO2vTo/xAZ/CKPa7J1QVkBHtBlY
         Js5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ctf2ZSJojXMz8Wx/sBhIZ3U22vX8qUoHD6iPYv6j+BM=;
        b=MrX1lHt3KpJaMNvjXBcKJzd5wN7rF8VCbFyeSEAJ29dmp1d6GojrN+Z0ABN8lSHwr8
         RxLrBPatgCR8Ixrc08t2cYIEch21wcuEu0XzG/7sfM4U83RymHG1LPsq4BMDJCm9uLuE
         HdxsZk0ZMHB3idvuO5SsThnHs8F6OD7WabeLe1CAx43ontz+TSPrAgsVe6mfJRaNRJXO
         o7Fy69DNIXSqF3VlxryVDJD6i70HgUjiUChkCjQ17bKZKwjXy4Ph/5ygDyvBG9/G1Ler
         zDSFQhozYC33blNFB7AqDuGtA8svtz/CCoauinX2IVXRQluCa46yp9jKbp8zgDxfquyo
         5FRg==
X-Gm-Message-State: AFqh2koNBK+62FUSfEI0azRnRxpdq11XwQnpzqlt9Xj+NPFiF68gTPU/
        /aI5UF21W3plCa6qn3XZhhwHKpZVDiwM/wozg30=
X-Google-Smtp-Source: AMrXdXuog/QSrj5KFqPlgCSqp63MHruzMbUCYym11Q5yf5n/TncKTi+v3wtDgl+mk7xq5whdaWAdlOfXMtdUIL8OFU8=
X-Received: by 2002:a05:622a:1a06:b0:3a5:6822:1a42 with SMTP id
 f6-20020a05622a1a0600b003a568221a42mr36016qtb.174.1671614317413; Wed, 21 Dec
 2022 01:18:37 -0800 (PST)
MIME-Version: 1.0
References: <Y6GMnq3AC7Kbnag8@VM-66-53-centos> <a113d20c-dc6c-2e44-009f-d4b17beb8820@linaro.org>
 <CAMmci2XuiwZje53L6Nv9+EG+W6pvXSbwyR2Ko5h8n9LEppS5pg@mail.gmail.com> <9474ae59-babb-0cfc-d838-447ff90c40f9@linaro.org>
In-Reply-To: <9474ae59-babb-0cfc-d838-447ff90c40f9@linaro.org>
From:   ty <zonyitoo@gmail.com>
Date:   Wed, 21 Dec 2022 17:18:26 +0800
Message-ID: <CAMmci2USuDf2C4hTG=_kRC08uLyiZ8cUnuZwxXHkQkifWUekiQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add RK3566 LubanCat 1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
12=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=89 17:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On 21/12/2022 10:01, ty wrote:
> > thanks. I am really sorry.
> >
> > I fixed this based on your feedback in the PATCH V2 content. Regarding
> > the dts issue, I used the kernel-5.15 kernel adaptation before, which
> > may not be perfect at that time.
>
> Do not send patches based on v5.15. This is some very old kernel. We do
> not work on such stuff.

Thank you for your kindly reminder. We have modified the whole .dts
file based on v6.2 kernel and follow the generic-name-regulation[0] in
[PATCH v4]. Because it was basically a whole rewrite, so I decided to
send a new PATCH v4.

[0] https://devicetree-specification.readthedocs.io/en/latest/chapter2-devi=
cetree-basics.html#generic-names-recommendation

>
> The comment was:
> "Node names should be generic, so at least with regulator prefix or suffi=
x."

Yes. Node names are all changed in [PATCH v4].


--=20
Y. T. Zhong
Student of The University of Hong Kong, major in Computer Science.
E-mail: zonyitoo@gmail.com
