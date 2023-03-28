Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D0A6CCBBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjC1VAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC1VAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:00:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3EF210C;
        Tue, 28 Mar 2023 14:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C580B81E6F;
        Tue, 28 Mar 2023 21:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC535C4339E;
        Tue, 28 Mar 2023 20:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680037199;
        bh=mRemOyJlSTZydfDBnQsoKur6tteDiG2aVonewiAjXVI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=swM6k5nqSkNiyrl4H4kssVblNKfyIFXJ9KrOJJSpwjJp8ScywQy9pb9ahSetzfJFh
         doWNdUOT3fiz6UDtldkyG6rIB9/KEZ/xLDYQ4T6Fkly8Eu+rN+OvjuwB9YWjq8HIit
         q4GowmFkqVbBNqeleLzs6V+JdcCK4iTnfSEpaMnefrc9Olo1UPWjhYoH3CPIGsBZ5l
         IjtrfN+wiLPrV8bC9UypXpQcrlQRb1G4PX3Xm7EfNa+o2qPplrDuMypHk6Nt6z/glm
         wq+6D0AEUi3Ua3sd6ccuDmgNNtdXwjp4ojB39asRAOfwdFTGzn7+mp9FDb4yVfCZm6
         aAlWP3Ble4rfQ==
Received: by mail-yb1-f177.google.com with SMTP id k17so16827977ybm.11;
        Tue, 28 Mar 2023 13:59:58 -0700 (PDT)
X-Gm-Message-State: AAQBX9e6eY0dKJ2MgiZRpu5jPZIdukCxDxr1GDskOMU83dqb4KaDjsB/
        slwGFHd2TZpPnUJCLCF71pXbT848E2V66DutJQ==
X-Google-Smtp-Source: AKy350bQAd0umwwy6Pjq2ODxSsyWWuHx17bAz8m65QTtqP6ENEeIBTfpnERA9jESA9S9Pekc0uTdzGhvUFYUQE2xogs=
X-Received: by 2002:a05:6902:1586:b0:b33:531b:3dd4 with SMTP id
 k6-20020a056902158600b00b33531b3dd4mr8527630ybu.1.1680037197898; Tue, 28 Mar
 2023 13:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230317213011.13656-1-arinc.unal@arinc9.com> <20230317213011.13656-2-arinc.unal@arinc9.com>
In-Reply-To: <20230317213011.13656-2-arinc.unal@arinc9.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Mar 2023 15:59:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLDRHs=TfcLsc0RJzF6rj84eXZooejmhx4hBDnpvCTk5A@mail.gmail.com>
Message-ID: <CAL_JsqLDRHs=TfcLsc0RJzF6rj84eXZooejmhx4hBDnpvCTk5A@mail.gmail.com>
Subject: Re: [PATCH v3 01/21] pinctrl: ralink: reintroduce ralink,rt2880-pinmux
 compatible string
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 4:30=E2=80=AFPM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> There have been stable releases with the ralink,rt2880-pinmux compatible
> string included. Having it removed breaks the ABI. Reintroduce it.

ralink,rt2880-pinmux now shows up as an undocumented compatible string
in linux-next. Where's the binding for it?

Rob
