Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223D66EC927
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjDXJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDXJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:40:24 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB571FE0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:40:22 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-42c38a6daf3so2597353137.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682329221; x=1684921221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaXLftvxjCBeC906n/at9r2xXYG41ZOrYJY1BY3wajs=;
        b=N+qMDfTgvmyDHwiwdSgAKqD/8b+FZZIt/1CN9rv43TUa/sFm80RtpPh1TR7QmdzQo4
         /cjKZbr/HE89ruu0up/r+ccgBVet7v+8dafpPnnobAJH3x548T57//lSSc/UQQssAaXk
         NzSZbL0n1/slaXx5AXAF8O7UcwjIWvN2sRbF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329221; x=1684921221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaXLftvxjCBeC906n/at9r2xXYG41ZOrYJY1BY3wajs=;
        b=RyqhawPMZWQrI/67ndJ6Wx4bOL4YuCkPFJ0jLuYsGuaza4QcRBEhy1zYWonfhdAaWw
         N4jK6cSnyd3IzAs/YXPVNLemnWpkHrvs7I2xGRTuRFwyoELHvCs5sdI56RKuYWF8DAxB
         CSB9C2gUQoGRxm8BAu0vUqAG7at1q/jkRt2swgfKJnFCDyTrloJRNAuaMHAA8QRfdIqm
         Q2B6qtYv8xg59V7uuow3ODFxCzsjv9b6qZJR8iB4X/r9LQmvVAOU4qDUYus5wx3PeMBZ
         8LtbAwYS+DiMRgaZ3MUHRIkDOnH7b5hUL5EYZCG1mW25BfeEUxtkIMCO8uMWSq3PsybF
         PWZw==
X-Gm-Message-State: AAQBX9eiJ7nklYMTNw9jfKto+WrQM5H3TFOTFPKU1gLF9fULGgEm0d/I
        9hXCaO/Y8L9EC7kvCo5tjILJIJ9YH1NEt6YuyBcgDA==
X-Google-Smtp-Source: AKy350YxdbDyEjTzriRuO2TWblbu0fAwk4xyw2DQQkDDUJffTyUmd9G/ij8d63XVVHL46wq3+f/VaG6UpDJg+FmEYF4=
X-Received: by 2002:a67:eb4d:0:b0:42c:9732:d17f with SMTP id
 x13-20020a67eb4d000000b0042c9732d17fmr5911119vso.1.1682329221452; Mon, 24 Apr
 2023 02:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
 <20230420094433.42794-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GJroyKkj8oZw+BQxiUkiGCb-RBOxnKRkURQz5T6=EvNQ@mail.gmail.com> <eb78450a-1eed-f914-58be-ee18d85a2d62@collabora.com>
In-Reply-To: <eb78450a-1eed-f914-58be-ee18d85a2d62@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Apr 2023 17:40:10 +0800
Message-ID: <CAGXv+5E5Ei9YffWQednLcmWBr2eXfsfjXBFRzxKJd+=O290xdQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: mediatek: cherry-tomato-r1: Enable NVMe
 PCI-Express port
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 4:13=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 21/04/23 09:59, Chen-Yu Tsai ha scritto:
> > On Thu, Apr 20, 2023 at 5:45=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> On Tomato rev1 the PCIe0 controller is used for NVMe storage.
> >
> > This was slightly confusing for me. AFAIK rev1 is not an actual Tomato
> > device. It should be the prototype board, which is the original Cherry
> > reference design by Google [1].
> >
> > There is an actual Cherry derived device that has NVMe, though it's und=
er
> > another brand and another name.
> >
>
> If revision 1 is not an actual Tomato device, and you can confirm that it=
 is
> the prototype board... I can send a commit to entirely drop R1 as having =
it
> upstream would be of no use at all.

From what I gathered from my colleagues, revision 1 was a Tomato prototype,
and also the second Cherry prototype board. There shouldn't be any of these
out in the wild.

FTR, the production version of Tomato is revision 4. Rev 2 and rev 3
engineering samples are available to partners, but otherwise limited.

ChenYu

> Cheers,
> Angelo
>
> > ChenYu
> >
> > [1] Much like Kukui & Jacuzzi (MT8183), and Asurada (MT8192) are the
> >      reference designs.  I don't think we ever upstream the reference
> >      boards because they don't really end up in the hands of people
> >      outside of the project, and the ones we do have tend to be quite
> >      beaten up or no longer working due to extensive testing.
> >
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts =
b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> >> index 2d5e8f371b6d..11fc83ddf236 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> >> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> >> @@ -20,6 +20,13 @@ &sound {
> >>          model =3D "mt8195_r1019_5682";
> >>   };
> >>
> >> +&pcie0 {
> >> +       status =3D "okay";
> >> +
> >> +       pinctrl-names =3D "default";
> >> +       pinctrl-0 =3D <&pcie0_pins_default>;
> >> +};
> >> +
> >>   &ts_10 {
> >>          status =3D "okay";
> >>   };
> >> --
> >> 2.40.0
> >>
> >>
>
