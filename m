Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FCF5B3498
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIIJv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIIJvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:51:36 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181048A6C6;
        Fri,  9 Sep 2022 02:50:58 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id k2so537888ilu.9;
        Fri, 09 Sep 2022 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=iXpi4U8D0jaH4ywTCd7jtJqMOxZPuO4ixqMMM3v8Cm0=;
        b=gy+X09X/RNQ4H6tibwvG0tzOvReyZtjiSFRUJ2CzxhUdURHeBxxU/OkH8yT922mRQT
         +gjpFUKX/OKuV1IWkLN1WpBSYhRbJqpdELwywSpGTlTJ9n5sow7627EtQFbivc2t6Uvy
         dLdhuxk8pQ4iIgzrA8QVKlkXH0eA5WoYVDTPunLwfAsdfaOjq8S+PLRsar9WlLY8xmPV
         O3ok4OAE+mVzLIGSK4GeS3rROGIiZafCCdgoU8WWvaMcSp/0S8XmSyt/FZF19SIsAgzi
         c8t3tkpJmeSgTBmG9Xzzfs/m+RA+iVz0iZlSWVwEsxoJGgBGUoyhEM70FoBK8Y4EfdfS
         1Dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iXpi4U8D0jaH4ywTCd7jtJqMOxZPuO4ixqMMM3v8Cm0=;
        b=taX0Ztsy8aucfiqSBaRHOIl0naBK/wgSynsKQUM3TSKDO0uPIpoW/aMe2k2G68StPI
         eS5iYZrXa9jTNuMLfc5YHMSEotuqGjEDCer6PENNTSFl32GyeIoRmaEaxVi+DPBU9XsT
         8TUM1uPbRGKiwHlVnKXc/KYUI6NPzQgvDlGXu161FwJHr4N+lfggsvwwXVioUuksxIP9
         ObcMplew6d4mcJ9e7PfoDOO+RgtJAUWg9fv4blZlMWYfT9CCNtc1Bs0fC0IMbM/biy7R
         RA8cenAFA7nBuyjXuDewjkwocbNXmWJPWqx50bFhLMoDaQSdJKsXYUtgV8SmqUgXhl9m
         sgsA==
X-Gm-Message-State: ACgBeo30XSHpaT7XAB1fd9rKeBWNT9dCf55NuQRlbGXIvOfLG2Mx//Lx
        Hw5FslRIlz9abzMx8fnsgKlrMtpeg12K+9yNh2Y=
X-Google-Smtp-Source: AA6agR7KW/O26IuwfE8+w6n2uh6iQn/xc37vHGc2t5D1if8njYyXjIDt+1pCy8VRdbo8CwxIzKeTAV0l9jKnXIPH5bc=
X-Received: by 2002:a05:6e02:198d:b0:2ec:d6c5:49e8 with SMTP id
 g13-20020a056e02198d00b002ecd6c549e8mr4044219ilf.187.1662717057366; Fri, 09
 Sep 2022 02:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220909073456.239668-1-gengcixi@gmail.com> <20220909073456.239668-2-gengcixi@gmail.com>
 <Yxr0+LJWWsF53dr2@google.com>
In-Reply-To: <Yxr0+LJWWsF53dr2@google.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Fri, 9 Sep 2022 17:50:21 +0800
Message-ID: <CAF12kFteDZLk-2PBufnuar43bgPzoxWsOjR0-zQ01ZqLyTCxQw@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        baolin.wang@linux.alibaba.com,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
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

Lee Jones <lee@kernel.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=889=E6=97=A5=E5=91=
=A8=E4=BA=94 16:10=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 09 Sep 2022, Cixi Geng wrote:
>
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add bindings for Unisoc system global register which provide register m=
ap
> > for clocks.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-g=
lbreg.yaml
>
> I'll take this when the clk driver changes are merged.
this patch is depends on the clk dt-bingdings, which is already merged [1]
so the patch can be applied without wating the clk driver
and the clk driver need merge this first

commitID =EF=BC=886a3a6c7ae0ef235faebf66bac56384dbd5f944dc=EF=BC=89
[1]. https://lore.kernel.org/all/20220711202740.198F4C34115@smtp.kernel.org=
/


>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
