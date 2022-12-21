Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B5652EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiLUJhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiLUJhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:37:24 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1B92189F;
        Wed, 21 Dec 2022 01:37:23 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h21so563824qta.12;
        Wed, 21 Dec 2022 01:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XASlYx7O9B9S8ryihKVMGI8Jj8VcSqnxG28gXEDkV2Y=;
        b=ILhE7A8AHKhhtMDA+yTmaOUxLSO12P7UBqkfjq9HBifr3sWkvcu40HaXym2zpEuLnj
         h5Mf4+WrOINgkffy49D07gxxwpzJXRouJuZPNhe6PddtTNQ3GnNIYyBfwqjuoqWrE06U
         rja7QwFcMmxaox7o6aFhhXLU/XjydDD3XrsFZTfnjE0R+v/5XYF2A7ePy+roaMjYxYzp
         CLJkERnHENxhfTBe5TE5/PljpbUZIOW1qEFEvr4OpsyPpRyaAd8TwII5MkzRyQuht9DS
         s0+kr0lNaoWN4oZ4mwAJYtl7OHlQYP2/s9x+jnl6HCGx2CeTkoeevF8T2UcxzD8kubyK
         oDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XASlYx7O9B9S8ryihKVMGI8Jj8VcSqnxG28gXEDkV2Y=;
        b=hC8Vk6uhqzhGnGUbbIud+OEsR0sRSv8zI29P4UgkRLnCRpcHAadawEjQsgUJHuiLd3
         1i+1RvbBfQGS2q0T8XxLe3G69juFLluNxFFFwfMCoAjPB8X2JHnOFYsV/SPYwZIVbXJ9
         yqjcx1Mvby5ah9sYiQ/D9qljId40zLpQTSdCn5fJIc8K3VnpD8shlvCUlIN7Bt9SR0km
         3dHHn0ub76tTZ0+HCvblc6X45CCZ2/MGZyGxYusGCFqvQtOlAymzUmcOIcgAqIcMdkYO
         VBrHE8GZohZvuv20HkXdNhn7tnBfwq3plspU0oejSsGkpHcNRimWS7svxcZGhcFKTlLI
         Rb2Q==
X-Gm-Message-State: AFqh2kqr4UQ6d6uJKILWx22+v+kLTFI0IHMdjDRx6+kzMucEf19uQch8
        Ng/h6KwJVLKq+y1XKhyJ7l8iYarDRgEm0BgFyDA=
X-Google-Smtp-Source: AMrXdXvFxbd/oQRYag7eCk4bBpmPD09EaCTo/iafvuW2CU4WNAj3RZ7t88RKgdrwaPo66KNUlItFdZoOsnwG2p/uDQo=
X-Received: by 2002:ac8:6a13:0:b0:3a8:e8b:2204 with SMTP id
 t19-20020ac86a13000000b003a80e8b2204mr39563qtr.235.1671615442560; Wed, 21 Dec
 2022 01:37:22 -0800 (PST)
MIME-Version: 1.0
References: <Y6GMnq3AC7Kbnag8@VM-66-53-centos> <a113d20c-dc6c-2e44-009f-d4b17beb8820@linaro.org>
 <CAMmci2XuiwZje53L6Nv9+EG+W6pvXSbwyR2Ko5h8n9LEppS5pg@mail.gmail.com>
 <9474ae59-babb-0cfc-d838-447ff90c40f9@linaro.org> <CAMmci2USuDf2C4hTG=_kRC08uLyiZ8cUnuZwxXHkQkifWUekiQ@mail.gmail.com>
In-Reply-To: <CAMmci2USuDf2C4hTG=_kRC08uLyiZ8cUnuZwxXHkQkifWUekiQ@mail.gmail.com>
From:   ty <zonyitoo@gmail.com>
Date:   Wed, 21 Dec 2022 17:37:11 +0800
Message-ID: <CAMmci2W9zZkw9ymJfBx4Zs8UX23qAHHA+9_df8VPqBsqBKjyDA@mail.gmail.com>
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

Dear Kozlowski,

We just got where we did wrong by reading twice about the
generic-name-recommendation document and comparing our PATCHes with
others. We will make a new PATCH v5 addressing all the comments.

Thanks for your patient. We felt sincerely sorry.

Recards.

Yuteng Zhong, DHDAXCW.

ty <zonyitoo@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8821=E6=97=A5=E5=91=
=A8=E4=B8=89 17:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=
=B412=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=89 17:05=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On 21/12/2022 10:01, ty wrote:
> > > thanks. I am really sorry.
> > >
> > > I fixed this based on your feedback in the PATCH V2 content. Regardin=
g
> > > the dts issue, I used the kernel-5.15 kernel adaptation before, which
> > > may not be perfect at that time.
> >
> > Do not send patches based on v5.15. This is some very old kernel. We do
> > not work on such stuff.
>
> Thank you for your kindly reminder. We have modified the whole .dts
> file based on v6.2 kernel and follow the generic-name-regulation[0] in
> [PATCH v4]. Because it was basically a whole rewrite, so I decided to
> send a new PATCH v4.
>
> [0] https://devicetree-specification.readthedocs.io/en/latest/chapter2-de=
vicetree-basics.html#generic-names-recommendation
>
> >
> > The comment was:
> > "Node names should be generic, so at least with regulator prefix or suf=
fix."
>
> Yes. Node names are all changed in [PATCH v4].
