Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030995F49EA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJDTw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJDTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:52:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1A765255;
        Tue,  4 Oct 2022 12:52:52 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o5so9600744wms.1;
        Tue, 04 Oct 2022 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Lf/FF/9SYo3o08dhujm/+mRrD5yIfHmp24VtbgWfiQg=;
        b=JTNqoucW88MzuWpMd8jGLVmbLlrQflfsQPSZY3xPlLZRf467EDEbKym7aqC/352q3N
         7csvxiGvkksL22I9qDHVMqVx5zDETp34UOItMDJ8+UcNWhjZxgfODniCZqKzpKOtW6rZ
         EIkG9BlK8EGb/L8RWTR/6z6ZDn1YEhiZQKxs503c0u7LN1zQBbTrmQw8Rv32EqBHXO/x
         +WJRIPzYQCqSkfe/pnUb68IXvHX5jyV90ka2LgPwNDMc2wwS7ryxusogLQtYKCKiu2TB
         0IfzgfutreVTCvv4y/GVVfQ5XjrJhmPt/AmYTq1W70K6b9Dr7xxiDJcFYyyAG15zdYTN
         +Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Lf/FF/9SYo3o08dhujm/+mRrD5yIfHmp24VtbgWfiQg=;
        b=CR+l6Msw5EN8NgIO3JY8dmnbXR3FWT79EMpsD4V7iirLEA+b+r1RyradYnD6Lfj9Wf
         ynUrwoiJky7sWjPd6U4F5BvA6pwuRTrTqgnqYsf3K42u+2+CB6q97cVTQ3DFZPZ7vpuJ
         Lue5/DKHNKpqi2HKhG6/+SZJJpXjVPZwKkp4xr3TbZdoVjtw/6fbVloWb0zJifQjGBOR
         ND9X9N9rtGwOhnmUjeMixBXz3+RS54RJabmwJdFtfg/C6WbC5aBOrF9SuzLys1/ib684
         BGeJhakoxHjShR+MaZfgXibvti5Onzyp1Q3/A7pvhVIlrXCmV7Q8uAip0v5cT+cF1lU+
         O9Ig==
X-Gm-Message-State: ACrzQf26ftcKGHBQUFoNaL+w65RV+nfMxfwsa4Wita/yz6DZLTPN9z/n
        BpPE2uJvbQGVwLvnJCGQrCKmfSIUVdv7QnZ9AMw=
X-Google-Smtp-Source: AMsMyM5KAxvPsCr915qNm4tjN1FikabH8pJ6QcbZUzjDv/SeQZ3uRiIkxPKdpS91YdpI3Ql6sayY9PXhDMclIOa3Lxk=
X-Received: by 2002:a05:600c:2191:b0:3b4:868a:aad3 with SMTP id
 e17-20020a05600c219100b003b4868aaad3mr963035wme.112.1664913170920; Tue, 04
 Oct 2022 12:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221004144304.536023-1-megi@xff.cz>
In-Reply-To: <20221004144304.536023-1-megi@xff.cz>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 4 Oct 2022 15:52:39 -0400
Message-ID: <CAMdYzYou74UoPFeLx-5Od6rXe+8Fr9AjRv6fuiaqDMXhiufmYA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rk356x: Fix PCIe register map and ranges
To:     Ondrej Jirman <megi@xff.cz>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 10:43 AM Ondrej Jirman <megi@xff.cz> wrote:

Good Afternoon,


>
> I have two Realtek PCIe wifi cards connected over the 4 port
> PCIe bridge to Quartz64-A. The cards fail to work, when nvme
> SSD is connected at the same time to the bridge. Without nvme
> connected, cards work fine. The issue seems to be related
> to mixed use of devices which make use of I/O ranges and memory
> ranges.
>
> This mapping is designed to be more straightforward, inspired by
> dt-bindings docs for sample pcie3x2 node:
>
>       reg = <0x3 0xc0800000 0x0 0x390000>,
>             <0x0 0xfe280000 0x0 0x10000>,
>             <0x3 0x80000000 0x0 0x100000>;
>       ranges = <0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000>,
>                <0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
>
> I noticed that this is crafted so that there doesn't need to be
> any translation other than dropping the high dword bits, and I
> modified the ranges for pcie2x1 to follow the same principle.
>
> This change to the regs/ranges makes the issue go away and both
> nvme and wifi cards work when connected at the same time to the
> bridge.
>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 319981c3e9f7..e88e8c4fe25b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -855,7 +855,8 @@ pcie2x1: pcie@fe260000 {
>                 compatible = "rockchip,rk3568-pcie";
>                 reg = <0x3 0xc0000000 0x0 0x00400000>,
>                       <0x0 0xfe260000 0x0 0x00010000>,
> -                     <0x3 0x3f000000 0x0 0x01000000>;
> +                     <0x3 0x00000000 0x0 0x01000000>;
> +
>                 reg-names = "dbi", "apb", "config";
>                 interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> @@ -884,8 +885,8 @@ pcie2x1: pcie@fe260000 {
>                 phys = <&combphy2 PHY_TYPE_PCIE>;
>                 phy-names = "pcie-phy";
>                 power-domains = <&power RK3568_PD_PIPE>;
> -               ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
> -                         0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
> +               ranges =  <0x01000000 0x0 0x01000000 0x3 0x01000000 0x0 0x00100000
> +                          0x02000000 0x0 0x02000000 0x3 0x02000000 0x0 0x3e000000>;

Have you verified these ranges do not regress the NVMe drive when it
is connected directly to the controller? The reason we went with the
configuration space we did was because the original space from
downstream caused errors on NVMe drives when reading large amounts
(>1GB) of data at a time.

Very Respectfully,
Peter Geis

>                 resets = <&cru SRST_PCIE20_POWERUP>;
>                 reset-names = "pipe";
>                 #address-cells = <3>;
> --
> 2.37.3
>
