Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82014607CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJUQst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiJUQsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:48:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5A4100BE6;
        Fri, 21 Oct 2022 09:48:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso5509653wma.1;
        Fri, 21 Oct 2022 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbPvSXhOFP986gsXwgJkoWhk6VMKEDH9VysMFA4exvU=;
        b=I3PLxPuc2tV4wZKG9QH1dxt6KVSHYn4tUeqoMo7D1YkEwEWRqEqj30vZIfAaWSSq5C
         gsgA/KjAeXIVc47AAOdFcimD0GwGpL15rAMwbY5utUNOf1aTfVHri9HYZCxF5c+choLo
         ua/Y2AhmzXrIq1vDLskNd6C8d6MYQbw0uyBg7Ou5Pmb5lWMkn1VnzE0MkReOBJED8O0I
         Khwz/aGMUrJyQyFQnA/xdcs5dEIlpT47mJu1oQShXjI1ruwjrsNsOExGp3OMSbSeZrqq
         zzsRaGYow5CXpG1EUOUNNs9pUV7VVZ7/QQacIfexqVvw0Zm+TFtKaUFbqrsfooS3o+u9
         9Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbPvSXhOFP986gsXwgJkoWhk6VMKEDH9VysMFA4exvU=;
        b=0HMpGtPCJuzStiQKmr6Dnj8/0mU+0twy6GoPedIy+sTbkk6Hu7lH4YxlhZ1qNmkHNJ
         pV0PXdSW/YyxBE4Am+QFL/K8Wjs73b5z6JI24f0/UBVlSYltNILR0vb7DuUUctKQ7wcK
         m4bi55uS++NE2j//NmXqRFZz7a78M+keRonVTi9NqE2ErmiUWfX3hjD/eHQroPG9jjSm
         ahzHUR3m5ylUE40Tn/MD/x5SL/3GGHu96BsAoy8RR+goQ/GFW9Xmf8zYbR5TR6gM2ZHq
         HXaCiJT/4Q9OSi+F5NGmNeAZxuQYKUURslzkIrbzOH83VwZZc0g0t37uLSeHTs42mvYB
         vcJA==
X-Gm-Message-State: ACrzQf1K+y/DiYWUNiq/WQoKtlZzHB81IBAs87SuF15E/PYWysI2GKN1
        fyS0gGzPJkMf4UA3dPiFoZnPolnM7UUIbVp6XR4=
X-Google-Smtp-Source: AMsMyM6kdlYPtik0hBPcElvkVtBLOUl4VQ2V+hrKmnXSe6JHzGq2jHZKtAJrwAW+3HP4dw+SR+MGiRqRn85wdeVCmIE=
X-Received: by 2002:a05:600c:6885:b0:3bd:d782:623c with SMTP id
 fn5-20020a05600c688500b003bdd782623cmr13697576wmb.102.1666370906852; Fri, 21
 Oct 2022 09:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221005085439.740992-1-megi@xff.cz> <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core> <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com> <20221021153913.l5ry6v4mcnzcmj2v@core>
In-Reply-To: <20221021153913.l5ry6v4mcnzcmj2v@core>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 21 Oct 2022 12:48:15 -0400
Message-ID: <CAMdYzYpYC6ME_ZYE65UWq__i+rit6_os-+do+JLmEL7y-jKr9g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, Oct 21, 2022 at 11:39 AM Ond=C5=99ej Jirman <megi@xff.cz> wrote:
>
> On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
> > Good Morning Heiko,
> >
> > Apologies for just getting to this, I'm still in the middle of moving
> > and just got my lab set back up.
> >
> > I've tested this patch series and it leads to the same regression with
> > NVMe drives. A loop of md5sum on two identical 4GB random files
> > produces the following results:
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > fad97e91da8d4fd554c895cafa89809b  test-rand2.img
> > 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
> > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
> > 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> > b9637505bf88ed725f6d03deb7065dab  test-rand.img
> > f7437e88d524ea92e097db51dce1c60d  test-rand2.img
> >
> > Before this patch series:
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> > d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> >
> > Though I do love where this patch is going and would like to see if it
> > can be made to work, in its current form it does not.
>
> Thanks for the test. Can you please also test v1? Also please share lspci=
 -vvv
> of your nvme drive, so that we can see allocated address ranges, etc.

Good catch, with your patch as is, the following issue crops up:
Region 0: Memory at 300000000 (64-bit, non-prefetchable) [size=3D16K]
Region 2: I/O ports at 1000 [disabled] [size=3D256]

However, with a simple fix, we can get this:
Region 0: Memory at 300000000 (64-bit, non-prefetchable) [virtual] [size=3D=
16K]
Region 2: I/O ports at 1000 [virtual] [size=3D256]

and with it a working NVMe drive.

Change the following range:
0x02000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
to
0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x40000000>;

I still haven't tested this with other cards yet, and another patch
that does similar work I've tested successfully as well with NVMe
drives. I'll have to get back to you on the results of greater
testing.

Very Respectfully,
Peter Geis

>
> kind regards,
>         o.
>
> > Very Respectfully,
> > Peter Geis
