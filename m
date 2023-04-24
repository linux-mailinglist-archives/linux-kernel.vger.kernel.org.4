Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9911D6EC6D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjDXHRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDXHRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:17:43 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEB6C4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:17:41 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-44307db5d24so1276787e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682320661; x=1684912661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge7dQFFEMhRd1pxTKgcmbYY3WTN/xziTD121Ud2oaVQ=;
        b=cSkBgzqvPTydLZcyBhk4Id8IebsD++8p0XWv0CRPMhhvjM8e6GJDGrZUU/CQ2PhGdt
         iyzvVz3O38Us70736sYxoO/kRdFx8DTtWeNFe+7Fv19Dt/fISvOaSlGTZ5z7sHc+CJRa
         5ucxvGoEsTZ4/BYa/Go421GPw0g/z/tP1aLs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320661; x=1684912661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge7dQFFEMhRd1pxTKgcmbYY3WTN/xziTD121Ud2oaVQ=;
        b=kyI05Y25S73P4t+1kkSM0iigqf8u3RSM5RiDesAs7pS+gXlMx86F1HiyWKkpyAZxD0
         uFpBctf165kVWd6o1wCdeXE+oNxoxnNiS0U+q5h1nZWjO7iAYqdYgZZcOp5Sby4MpRRU
         eyaWgqi9+hyvSkQKVhSvuUeEYfTh0/LhgcPmKD7dY2+5B+zdHJ35Chc83skC6tUI+Sxl
         9RY8YhZCq2E8ZNWMAWc86A8GvKJYickHDHBSMzk/7rNxj34L8DWG7hu/6tYR5waZX6ez
         uTSFQ9kY5V4pNS6b8suN73SYAAx8xBcxFEU0Y4Obzs6rKX0EklC4q2RQ6SaXzAP0juwa
         ZJkQ==
X-Gm-Message-State: AAQBX9cg5lmGEeAnfePH6gW8fe5IVb91l81v/YdinP7o32/2WfN0HMaw
        1zixCPCLHfVreKSW6B3Nr7wreXOUcrtRZ54o3Txj5QowZ/FbdZ/T
X-Google-Smtp-Source: AKy350ak24vjEnQyf0VlLd50kDFe/R+sOZneUhtLyU8sTqVPCOaSD1kQ2pVXtC6jt8v1o67tkU1EoehcilxF9yiwqdM=
X-Received: by 2002:a1f:c546:0:b0:43f:b28e:d481 with SMTP id
 v67-20020a1fc546000000b0043fb28ed481mr2607614vkf.11.1682320661059; Mon, 24
 Apr 2023 00:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
 <20230420094433.42794-3-angelogioacchino.delregno@collabora.com>
 <CAGXv+5EtCdpXtq6q2Cv+QAZPUE6yJiSZhngSc0sftz-_uDrZXw@mail.gmail.com> <0a0917f9-756f-6926-8ede-2b087cb0b716@collabora.com>
In-Reply-To: <0a0917f9-756f-6926-8ede-2b087cb0b716@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Apr 2023 15:17:29 +0800
Message-ID: <CAGXv+5FMEphksTSLAy8=hDPGjC364dxD4_9qmw6aV4en-2d3ig@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: mediatek: cherry: Assign dp-intf aliases
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

On Mon, Apr 24, 2023 at 3:03=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 21/04/23 08:46, Chen-Yu Tsai ha scritto:
> > On Thu, Apr 20, 2023 at 5:45=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> On Cherry boards, the IP at 0x1c015000 (dp_intf0) is used as primary
> >> dp-intf, while the other at 0x1c113000 (dp_intf1) is used as secondary=
:
> >> assign them to dp-intf{0,1} aliases respectively.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 ++
> >
> > This should be applied at the SoC level. The display pipeline is fixed =
in
> > MMSYS, so it applies to all MT8195 devices.
> >
>
> It's fixed in the MMSYS configuration/driver but - as far as I remember (=
I can
> recheck on the datasheets) - the dp_intfX function can be inverted meanin=
g that
> the MMSYS paths can be configured such that DP_INTF0 becomes secondary an=
d the
> other becomes primary: this is why I am putting that into mt8195-cherry a=
nd not
> mt8195.dtsi.

Maybe that's possible, but the diagram in the datasheet suggests a fixed pa=
th.

Either way, it's not actually the problem. My original reply is probably
inaccurate. AFAIK the aliases are used to identify the individual hardware
blocks, which otherwise have the same compatible string. So the numbering
should be the same regardless of the design and/or routing.

Ideally this should be described with a proper graph though.

ChenYu

>
> Regards,
> Angelo
>
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/ar=
m64/boot/dts/mediatek/mt8195-cherry.dtsi
> >> index 0820e9ba3829..918380697a9a 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> >> @@ -10,6 +10,8 @@
> >>
> >>   / {
> >>          aliases {
> >> +               dp-intf0 =3D &dp_intf0;
> >> +               dp-intf1 =3D &dp_intf1;
> >>                  i2c0 =3D &i2c0;
> >>                  i2c1 =3D &i2c1;
> >>                  i2c2 =3D &i2c2;
> >> --
> >> 2.40.0
> >>
> >>
> >
>
