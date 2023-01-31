Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59984683397
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjAaRRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAaRRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:17:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1F4A239;
        Tue, 31 Jan 2023 09:16:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED28CB81E20;
        Tue, 31 Jan 2023 17:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99733C4339B;
        Tue, 31 Jan 2023 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675185372;
        bh=Htn9YhYSlgRXffy3rT6sfQrDIlpLGqBXlf/agXBrdjw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jd3P9INjEYDlOAf/nypZj15Bfx3IQXs0A/Bm7oulj21GQqkSV9CmHDaLE/uqqC8+Q
         A34cwv3ogGiy4SyxiQOaOoF+URg3kNK7J1QkMv+J1MjUCPNb7pAwhv3jLsfg78gS6D
         aeLJMPFBKnV4ntAA2+4VrIZ/n6PRCfblE7w/jeQP8R1/Il7dKHbxROF4S5Ak/NInK9
         laX9Voh6RZP4wGrYaveQqR6XZl4xKQQ52OVktiUGv0QYqEHVA3tVH800AIE0VyjsKu
         mk7EILMP9Y8VE0s2df5yAbsOFzEvneWmFBcN99XQbjn/7uPkUe598H25cPZCaeGg5c
         c44wE13S3Yr7Q==
Received: by mail-ua1-f50.google.com with SMTP id h9so1205544uag.9;
        Tue, 31 Jan 2023 09:16:12 -0800 (PST)
X-Gm-Message-State: AO0yUKUvL1XP9WZebacf7rBzG3rHGPU5PG3KgKsdWemHFtHqh2Po0CHx
        1MUC/x7eZPprRBXsl4KXnjQjq+HKLc2OPn7QCg==
X-Google-Smtp-Source: AK7set+iQsvrBKzhLDAGubPW+WjufNqDgwcRXrUNOCRmNJyXpbrbxPa1dClHjP0DYEs+SdSGeyjnL1grO5hWlrX1kjY=
X-Received: by 2002:ab0:1603:0:b0:656:239b:8a1e with SMTP id
 k3-20020ab01603000000b00656239b8a1emr3410737uae.58.1675185371547; Tue, 31 Jan
 2023 09:16:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674693008.git.daniel@makrotopia.org> <3f0fd0becc338eef66caeb7244c3c432b8d1ef7a.1674693008.git.daniel@makrotopia.org>
In-Reply-To: <3f0fd0becc338eef66caeb7244c3c432b8d1ef7a.1674693008.git.daniel@makrotopia.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Jan 2023 11:16:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLuMrZs-ggmT_c7Bwa6ERKAU4vDi2_QH5OzyjYbvMsREw@mail.gmail.com>
Message-ID: <CAL_JsqLuMrZs-ggmT_c7Bwa6ERKAU4vDi2_QH5OzyjYbvMsREw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: add bindings for MT7981 SoC
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 6:34 PM Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add bindings for the MT7981 pinctrl driver. As MT7981 has most features
> in common with MT7986 (but has a different layout in terms on pinctrl
> and clocks), the existing mediatek,mt7986-pinctrl.yaml was used as an
> example to create a similar document covering MT7981.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../pinctrl/mediatek,mt7981-pinctrl.yaml      | 475 ++++++++++++++++++
>  1 file changed, 475 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt7981-pinctrl.yaml

Resending due to some header corruption:

Reviewed-by: Rob Herring <robh@kernel.org>
