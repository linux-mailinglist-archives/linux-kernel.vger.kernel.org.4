Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0424747A41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjGDXA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDXA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:00:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805CCE54;
        Tue,  4 Jul 2023 16:00:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66872dbc2efso1545907b3a.0;
        Tue, 04 Jul 2023 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688511625; x=1691103625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3GIXZAL55jvxfyPH9CnEkGXqdXbHSVv7grC7W9k0FU=;
        b=lywf5eF6Jlzj1WJcnZ9s3Iu5RCNnRfc+ozbpg3ZBuNiCCkp994iakAwdKfaedcSV2m
         Vor4ZZcLmxVhW/DeFVzf2n/agIsQ/hyWPOGMixHDTlQjm1iUSHYoAXzNKxDlasU6j8F9
         ath3XXa4MeHP+nO6MNVocij3233xjkuNZnvYAqcHA2kuaZJvkb20N3ji0ndfTvI7p7dJ
         5iRMfOpaw63YqRaLAspqHFG1W5ENthaFJCR9F6oty5pT/8Nfpci/XOQPL2F1S88Uqu47
         gO7u8f737/AXPsxKeCRWHX/ybNNR9+1oRkIwcYyHTQJtTaElsn7beMx+qUiJFqNSq0Em
         hZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688511625; x=1691103625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3GIXZAL55jvxfyPH9CnEkGXqdXbHSVv7grC7W9k0FU=;
        b=TUfxYYSjM2WOdVTjmhG1uHIpdbf3FEive4Ifj77gGw0TrQf37GBqs9iNB9/shj7auR
         Ru7EPnEbSqlO06K5Lk68maSOEeEy+B3C+rjVj7O3Sinm2P5VgsNuTUD6M5QXXq1zA9Km
         D3K9d9I6ZqBhdMv8UoHEqMpusX7fm8rBuswWwx0RlHcfS7Rufkxs7AH4QxiM9No9te3r
         SQFBlNXidnmhcgHZPR08/81iBOjPz4B0y/6IHIQ3jnjip92+2pG8b7CalNAx8uSIX+zt
         CPDEdFuipMz3RsoUBklbqh4vsd9blbpNYg1tllb9oCLrx5hH3SRv8cuZHO1daJkWyb7o
         70mQ==
X-Gm-Message-State: ABy/qLaYSVsrzfyd1OV0qxytKSZs2lNUf0eYBOwBliLurNrIDZNPp+wS
        Hl1GERkZ/gnYZipaAs70v8vteziykRa6d1XIriUQKPjVCpOTaQ==
X-Google-Smtp-Source: APBJJlE59DFolFuYV01BXk/etc630/ymSEmWO7IZhtXA+rNbhnveNTb2MkA+yA9G/yd1OrD5mO3TtU4HIz+YrO7+g3g=
X-Received: by 2002:a05:6a00:399a:b0:681:9fe0:b543 with SMTP id
 fi26-20020a056a00399a00b006819fe0b543mr16877234pfb.2.1688511624974; Tue, 04
 Jul 2023 16:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230704150240.2022020-1-hugo@hugovil.com> <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
 <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com> <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
 <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
 <20230704125541.f361cab8de3faacd830418ab@hugovil.com> <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
 <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
 <20230704164140.824f6890dae5c87fc92531b4@hugovil.com> <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
 <20230704172801.f11422b3f947c625f53af871@hugovil.com> <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
In-Reply-To: <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 20:00:13 -0300
Message-ID: <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Nate Drude <nate.d@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 6:50=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> On Tue, Jul 4, 2023 at 6:28=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> > Hi Fabio,
> > it is important to remember that on this board, like I explained
> > before, the INTB pin is not connected to anything.
> >
> > It is only the ID pin (9) that is connected to the GPIO1_11 pin.
>
> Now I looked at the schematics and you are right.
>
> In this case, GPIO1_11 should not be represented as irq then.

Variscite added an "irq-is-id-quirk"  property on their tree to handle this=
:

https://github.com/varigit/linux-imx/commit/fbe6aa2a9c014fdb10b29a715a1be69=
5dac60828
