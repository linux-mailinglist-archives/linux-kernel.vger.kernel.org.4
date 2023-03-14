Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55616B9E38
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCNSX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCNSXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:23:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB0D8C53E;
        Tue, 14 Mar 2023 11:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81BD9B81AE2;
        Tue, 14 Mar 2023 18:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E402C4339C;
        Tue, 14 Mar 2023 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678818231;
        bh=j01ms7fQ8/WV8ubqSC9MEojfQXw9ejsapB/+MdCiCyI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jwzFueE5mIaxM82APaZiRVKMMcHgn1bKOb9Q63AuNqAlsibX/Tv0qI8TRzxfHeT52
         cwa46v9lig1HWBeZBcEeUID2cZNYIZWly0bBQLv9Awxw0y5o6K4uo86OUw301HeIf4
         r/aR1P/fcPDmgz6VbY7b6+F4zRTxSRWibqeQ9wVb51BMrABXK49ssBkXKYL58kMf2/
         WdxugL13EEjQsKJlpwD6h4Ptmc48O3MDLUUf8sUmNFd7rzEwEZwae5rZ8ct8Xt2Au3
         mGr9CCwLG1DPT/14Sj4d875XLEOeIl9I1uGEh32ApFzsiEri+0R7JNc6BF4PsDGBhW
         LU8N7b/gVFL1Q==
Received: by mail-vs1-f46.google.com with SMTP id k11so6104873vsq.13;
        Tue, 14 Mar 2023 11:23:51 -0700 (PDT)
X-Gm-Message-State: AO0yUKUVrQDhmVRnofdhZ8a7dEeD6RsXyoGWKw/5uz7C9OPKw6zPl/SV
        Xs8hj1LA6+JeuNWkqNl2R3HHwTvvidmOHWtllw==
X-Google-Smtp-Source: AK7set/3ndAJft4VM1NU2S/PyG7HbW6nCCeH4Zi1Tbt435zS0Q/Zy3ycvUndNjGIweBnoGWbJimT3sPfBdfRqFUGCCw=
X-Received: by 2002:a05:6102:913:b0:421:eabb:cd6a with SMTP id
 x19-20020a056102091300b00421eabbcd6amr17959167vsh.7.1678818230166; Tue, 14
 Mar 2023 11:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230207234735.201812-1-robh@kernel.org> <CAL_JsqLitc8rX4aXomgXKSPcW8ejEYe1wB_ecyAg7pgJgR=zyA@mail.gmail.com>
 <c02f83c4-3796-40ad-8087-d297ba84e5da@lunn.ch>
In-Reply-To: <c02f83c4-3796-40ad-8087-d297ba84e5da@lunn.ch>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Mar 2023 13:23:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLz3jMLGi=waCArD4vafBBNybqhD=uch-m3wtPHhA5O=Q@mail.gmail.com>
Message-ID: <CAL_JsqLz3jMLGi=waCArD4vafBBNybqhD=uch-m3wtPHhA5O=Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Tue, Mar 14, 2023 at 10:22:40AM -0500, Rob Herring wrote:
> > On Tue, Feb 7, 2023 at 5:47=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > The GICv3 ITS is an MSI controller, therefore its node name should be
> > > 'msi-controller'.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Ping!
> >
> > If not maintained, should I send a patch removing this platform instead=
?
>
> Gregory usually picks these up around -rc6.

Ignoring patches for up to 2 months is not a great experience for submitter=
s.

Rob
