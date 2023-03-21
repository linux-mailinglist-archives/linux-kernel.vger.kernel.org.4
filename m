Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F96C2A09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCUFuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUFuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:50:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7718A5C;
        Mon, 20 Mar 2023 22:50:02 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso7948362oti.8;
        Mon, 20 Mar 2023 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679377801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQRYTyJUcXjGIlb32K69CN7N/CfuacDHmOLvuVVkIeU=;
        b=F5so8U9eSPDfKwLwdhjWe1tE8PfeVDHKjkiyKaVpWQqKRuyuavEeTzXd4hk6L3z6zp
         VHPO8QjxcIT4MYzTcNnHQK4kCkDGjZgPowyHLuCLV9GljdqpK9u99uNfqkBMK5RA93gv
         FGjbjWg9KVC+SGloN3ekhh+2k6L7EF7wthr0pjQIqJLNck01caZneaWdLgqxokr/RLrO
         1sgViMnoTTZxc9T5zi936whRCWGOMENT2d8QDQSNUknsMhStPJdQFhKuw7YCDQdWuHuY
         XA7Htk2YAl4jH1GHMq/ggeJA09GTqzjWLySHNgMO09vanozHHeos4pEKMn6CfOVlZGDt
         TxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679377801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQRYTyJUcXjGIlb32K69CN7N/CfuacDHmOLvuVVkIeU=;
        b=F+s8zjzIrEGYsx6hUIpY4AypQRSgaI1J7euQkQ42p6TNiWR74+Ud4W3WVMAditLJQr
         CaowjZJsj4VOVBiY73DILXuj3n8dIFKKlDOzRQycXhzqak3mJzisw0X7W0rwfuLLvRVa
         z9eC4RuXcuND7FSIotBqml8LvChmRxDlfbzak3IIEgZykkxXvnR98fmKAE/gY0B6iJWI
         3K6BFRwIxhGk/uEJd1rgoZrcWFqAWmntoK5dVXJ3X9PqM0Xo6MUHeEVOY7DngFtGfSQB
         ukGxegKWRtQPXMBRWWZRJ6bN8VxyHS5OmJ16tKzw9wIOZilgG8lIG8cJCCN7Gokc3AHu
         v7Sg==
X-Gm-Message-State: AO0yUKWmHcErfDaWY4rFJTxA2dExzj9FWKjUTnOPCZDHm/k8X/cLEk4a
        PK3HM0Z9jYhzC7DHIEy1kM5zp9CPH1PMihlxGU0=
X-Google-Smtp-Source: AK7set9hGdm8jb3Zms52xIkHW02ezlDplA4s1W/5C+8w1fxRVUiCGMOX1ghjWbWe1rulG24xEDF5Rs78eQG2Vsd6oW8=
X-Received: by 2002:a05:6830:13d3:b0:69e:24a7:e042 with SMTP id
 e19-20020a05683013d300b0069e24a7e042mr409968otq.3.1679377801763; Mon, 20 Mar
 2023 22:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230320233955.2921179-1-robh@kernel.org>
In-Reply-To: <20230320233955.2921179-1-robh@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Mar 2023 06:49:49 +0100
Message-ID: <CAMhs-H829e-QSwMXAVN6b4pYTB+_d-PLJxbEqdhd9oOrYnY-aQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-can@vger.kernel.org
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

On Tue, Mar 21, 2023 at 12:40=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

>  .../devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml    | 4 ++--

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
