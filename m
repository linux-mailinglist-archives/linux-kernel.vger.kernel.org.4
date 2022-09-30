Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D405F15E7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiI3WM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiI3WMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:12:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39101806D0;
        Fri, 30 Sep 2022 15:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C54E2B82A4D;
        Fri, 30 Sep 2022 22:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74725C433C1;
        Fri, 30 Sep 2022 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664575928;
        bh=Jo/Vgfba9De5xy/v6raQyqYE0lJYMx5B8RCbTNv97jY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bpwc+/EhGxFQzXBU6jftrABmxHnosUtKVU6MmlJ0n8UeqaiP29iqthhd9wUd7wLjJ
         I2+AfP59xvbdCvG2Dm/BcBGxm3J82KQrVO05I79uQRCVJ4/Q+u1Cn+VZnAQHx3OqvX
         dCoi7tmEIdV72rDz70kCyFzgrQ7tpbe3yf2UnhLsF3tmucIhXXqhVbQHfJPNKLmkCY
         Kz5S58GL/yep3UGdeAl7v7/cueFcaIKU2vyCyj69jX1jclE7ekIChsdPDnZzHKmPCG
         kND6wxv+6fR5/HP3ZFsOvD3Nerg3oyNuR6VoGpAb/64igxdFqKs9Q2TZ3oH7yxjopm
         rVZd2X8Bfu9MA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220822152652.3499972-5-msp@baylibre.com>
References: <20220822152652.3499972-1-msp@baylibre.com> <20220822152652.3499972-5-msp@baylibre.com>
Subject: Re: [PATCH v4 4/4] clk: mediatek: add driver for MT8365 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Sep 2022 15:12:06 -0700
User-Agent: alot/0.10
Message-Id: <20220930221208.74725C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Markus Schneider-Pargmann (2022-08-22 08:26:52)
> From: Fabien Parent <fparent@baylibre.com>
>=20
> Add clock drivers for MT8365 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Applied to clk-next
