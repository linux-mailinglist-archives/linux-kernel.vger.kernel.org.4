Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDE6B98E3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjCNPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjCNPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:22:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8387112BD8;
        Tue, 14 Mar 2023 08:22:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4371CB81909;
        Tue, 14 Mar 2023 15:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BABC4339B;
        Tue, 14 Mar 2023 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678807373;
        bh=XBJhJbTIAyYpbcqJf/xqmWNoVmO5mLxIuDa0qf9bsLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sXb/77bl7Gc8uYZvPb3Lbg5B7SdomSIWd+CAMKw3+jUhb2LBxZ5BdnQaT48wV6hzj
         IhT0KU4nzW713e6ncpsoEQ1zXcBZCvKEVqAKYQq9jt8g2l1bKGYcTNpT2nzJaac6oI
         yU+zeEw9uzCycZzJs6ZHdAnDCfDBUreorp7BASi0V3HCq0g7Mn2pT8CDFAYsXqhHS3
         h12LqAiSbTcHZ4Z+1Fu7oWqFfFU7LCBDk9jAypMHz3u+4TcseE0B1u9ukqZK1iFZmL
         JaughubHbe9ZYAVhfxQ3Mi/u9ncjPV/xnNjE0Kr5tAZB0IjDsCLoF/au8TiqFDhKSy
         gY05k5eoTLgkQ==
Received: by mail-ua1-f45.google.com with SMTP id s23so10804866uae.5;
        Tue, 14 Mar 2023 08:22:53 -0700 (PDT)
X-Gm-Message-State: AO0yUKUdUn9P7Q/3mtYYsanyrRFIVQqVcpt48JlQ3NXeGPxSjB4JvDb1
        7zOvytS4JAUlGCvhSUJGCEoa6xEiVTzz0mfVaQ==
X-Google-Smtp-Source: AK7set+W4y6KHsNtY2KoSvNmtSYBizOPlBePIhYNnYnVb1y4XR1sahNAYveLvJlFASCix6MkFnAgckOZ0UiKEAxZeCc=
X-Received: by 2002:ab0:4714:0:b0:68e:2ed3:92eb with SMTP id
 h20-20020ab04714000000b0068e2ed392ebmr19673689uac.1.1678807371986; Tue, 14
 Mar 2023 08:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230207234735.201812-1-robh@kernel.org>
In-Reply-To: <20230207234735.201812-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Mar 2023 10:22:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLitc8rX4aXomgXKSPcW8ejEYe1wB_ecyAg7pgJgR=zyA@mail.gmail.com>
Message-ID: <CAL_JsqLitc8rX4aXomgXKSPcW8ejEYe1wB_ecyAg7pgJgR=zyA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 5:47=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> The GICv3 ITS is an MSI controller, therefore its node name should be
> 'msi-controller'.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ping!

If not maintained, should I send a patch removing this platform instead?

>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi b/arch/arm=
64/boot/dts/marvell/armada-ap810-ap0.dtsi
> index 8107d120a8a7..2f9ab6b4a2c9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
> @@ -54,7 +54,7 @@ gic: interrupt-controller@3000000 {
>                                       <0x00d0000 0x1000>,       /* GICH *=
/
>                                       <0x00e0000 0x2000>;       /* GICV *=
/
>
> -                               gic_its_ap0: interrupt-controller@3040000=
 {
> +                               gic_its_ap0: msi-controller@3040000 {
>                                         compatible =3D "arm,gic-v3-its";
>                                         msi-controller;
>                                         #msi-cells =3D <1>;
> --
> 2.39.1
>
