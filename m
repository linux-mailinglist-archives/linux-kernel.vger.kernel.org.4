Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2319A6561B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiLZJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiLZJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:52:28 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3024A267F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 01:52:28 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3cbdd6c00adso144938477b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pWR+JUq2o54AwQ6BNKo0a70xKICVf0zlgFYzCKYUAOo=;
        b=TUHkEMzI3Wy4MLlTkNJX+3OEd6QSPQdePraNM80YuZEXokTfMTzDVKEozBRheYrj4t
         IpQyhHNCY/3lw3BY/4WEEsfccP6F/fTMik/mzIQUOiV+dXxCuiwpu78RATZfxSGxj7RM
         VGdi/3kVo5p0MJdUGki5mCrGgpb9ihyuHihy1mW361eTBVEKBax3Br4yDNmi7G0gQH83
         VSzMZO0L0iTB0C+IAceJ8xv1tTsUtXt9Kc4UPZ3kgDKAtOYhPev6+NVtyMYN+ewUqGp0
         I3OJ435+cygdtXdyOHKyPCalgjegid2ZWu8xWyNMmwHXBjAGkjb2CSPVWherGbeJvM1C
         AEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWR+JUq2o54AwQ6BNKo0a70xKICVf0zlgFYzCKYUAOo=;
        b=dt8Hm5TTfhpQK+KmYfDiswUga3+ffuUMfRPPNpgl97lW8vzWCS30R3ddXUs+h8iT8u
         NHQdG+J3vs4S9S3Q1Okt1cxJv7hC2eUyw8qp9t88OaLnajid9rbG1DmYuTNMKEz7ot5V
         nbZwdd6NVwRP5fO3TwOtHwanu+m4H6egLTC6H6k2tLBS/A8v+g9Kq8Of5VkPDGFw9DcG
         P4WhQzFazl5DOGSwGuyxju0iK6eSdhbjQ027oritXSmZHIJ5BngXbkmiTQpWFp8V8xf3
         WFh54rh5N0rvC5Hb9mrHDZZ5pabwkqKjPoX+l8nHT1tRQdsseIe88xYqFeJHLWFhhdOv
         w8Aw==
X-Gm-Message-State: AFqh2kpdbBtxn6XE+EjmFaDfoUsEDhJQK+oa5oqwpCDHbZRUtsJtSeNQ
        VO0cUzI0LhRQtEb6gy19ClXJDvo/wm95Eq9/1iEbIw==
X-Google-Smtp-Source: AMrXdXtRB3VvIx7J4rn3WevIT08YlZ4foe9Ony+g6JZFUVO05YJlfKaQdwx0TxNNs0/V0i32acgO6sRgIXzMtChb/G0=
X-Received: by 2002:a0d:f1c1:0:b0:358:36cc:b6cf with SMTP id
 a184-20020a0df1c1000000b0035836ccb6cfmr2088607ywf.505.1672048347366; Mon, 26
 Dec 2022 01:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20221226063625.1913-1-anand@edgeble.ai> <20221226063625.1913-4-anand@edgeble.ai>
In-Reply-To: <20221226063625.1913-4-anand@edgeble.ai>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Mon, 26 Dec 2022 15:22:16 +0530
Message-ID: <CA+VMnFz3JTJt7pYsMcKgt+cqbHNg=f0Tofrp-wgcj-51wkdxUQ@mail.gmail.com>
Subject: Re: [PATCHv2 linux-next 4/4] ARM: dts: rockchip: rv1126: Enable
 Ethernet for Neu2-IO
To:     Anand Moon <anand@edgeble.ai>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022 at 12:08, Anand Moon <anand@edgeble.ai> wrote:
>
> Rockchip RV1126 has GMAC 10/100/1000M ethernet controller.
> Enable ethernet node on Neu2-IO board.
>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> ---
> drop SoB of Jagan Teki
> ---
>  arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts | 37 ++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> index dded0a12f0cd..bd592026eae6 100644
> --- a/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> +++ b/arch/arm/boot/dts/rv1126-edgeble-neu2-io.dts
> @@ -22,6 +22,43 @@ chosen {
>         };
>  };
>
> +&gmac {
> +       clock_in_out = "input";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&rgmiim1_pins &clk_out_ethernetm1_pins>;
> +       phy-mode = "rgmii";
> +       phy-handle = <&phy>;

arch/arm/boot/dts/rv1126-edgeble-neu2-io.dtb: phy@0: '#phy-cells' is a
required property     From schema:
/home/j/.local/lib/python3.8/site-packages/dtschema/schemas/phy/phy-provider.yaml

> +       assigned-clocks = <&cru CLK_GMAC_SRC>, <&cru CLK_GMAC_TX_RX>,
> +                       <&cru CLK_GMAC_ETHERNET_OUT>;
> +       assigned-clock-parents = <&cru CLK_GMAC_SRC_M1>, <&cru RGMII_MODE_CLK>;
> +       assigned-clock-rates = <125000000>, <0>, <25000000>;

Keep them in sorting order.

Jagan.
