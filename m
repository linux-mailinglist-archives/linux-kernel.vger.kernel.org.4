Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559E268943A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjBCJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjBCJmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:42:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B0A9AFE5;
        Fri,  3 Feb 2023 01:41:52 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n13so3392653wmr.4;
        Fri, 03 Feb 2023 01:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crbyXV9rJDLhOIxykEpeHix+ylezqebesRDtMGOWb/c=;
        b=lTZmpcHURZEcgmKzOlkW9YsQUWbnIcBzamnewJh15IkOXk5wD8r9A5v5QTwVkyDEqD
         JlZPsBneRSeJ0Vfr3WxcMfNPLPPp8VmS4YHzjZV9UcfhHp+nQ5WLVQpgSPeWKt2zU6BS
         YFNYd9dIahmMKdS2LYgvTxv3JfPnOkTJrnL9L82JRn1kkurX8KVyn9ny+Si0SpmbhmuM
         VxgjFywBMYkgZOvVaA1bDyIjDLa+g4ubSR5ZFW0H9REL9wIxQlW/K3Lft+GXph5tvf9f
         pqNn1VlzEt/dgU89aLtAX09RZlXaa4DIWo/2LqzjMn3xFPa9p1Uz6OzOPT2Jn/v9+Rwv
         UsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crbyXV9rJDLhOIxykEpeHix+ylezqebesRDtMGOWb/c=;
        b=sbsRo3PaatRaOJDHaHpVSkTthXOD52yBIY4m5bXppjBISKFHSI/NHITrdNS/t3fEW0
         4Re+MMOMvB2y9t8WIyg76VeevCG1CeLc5YiCTwblMRt1MoqZyJgMMuKtUU+mBFxXxUy2
         /nmP/h+epXJgAmoAN7e6NY3/xYvErCsVXZfuCa/ci///IYpTfNsy3yjgpw9VGAcxWE8O
         lZMcsNGTjQ53/XBGXaITny9/k7B0h4Mrsc42JrVtLM/lgo3CwgB/U7zUCnkwS3/5J0n4
         KHwZpg+s14Vx6ipI28EyPtA19gi9ONcE0gZC4dcnJjI3rUiIuQKdrs/QUv4yqbK8ATiT
         evcg==
X-Gm-Message-State: AO0yUKUVlhtPRdXFbVtJ14ztZeN9b9nubGtM+lLpXPX0wU3E6OHiDX3A
        TML6pK2tHPR9d6SNVggLlbo=
X-Google-Smtp-Source: AK7set+FiqychMqMH8YVnKncj8oXDS5X6SEIx0j+kI8BJxXCCIlcSO0WDbwwVdbcwc89YjSqRaOWtQ==
X-Received: by 2002:a05:600c:a48:b0:3dc:5d34:dbe5 with SMTP id c8-20020a05600c0a4800b003dc5d34dbe5mr9246755wmq.28.1675417310637;
        Fri, 03 Feb 2023 01:41:50 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c315000b003dd1aa227afsm2242015wmo.31.2023.02.03.01.41.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:41:50 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 0/2] media: rc: add keymap and bindings for Dreambox
 remotes
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230203093405.1616564-1-christianshewitt@gmail.com>
Date:   Fri, 3 Feb 2023 13:41:46 +0400
Cc:     Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org,
        Emanuel Strobel <emanuel.strobel@yahoo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA8F3DCB-793D-41BC-AD02-51677D86FEF8@gmail.com>
References: <20230203093405.1616564-1-christianshewitt@gmail.com>
To:     Christian Hewitt <christianshewitt@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 3 Feb 2023, at 1:34 pm, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
> This series adds bindings and common keymap for the Dreambox RC10/RC0
> and RC20/RC-BT remote devices.
>=20
> Changes since v1:
> - Split bindings and keymap into separate patches
> - Revise keymap description to clarify non-IR keys and mappings
> - Revise tagging and key ordering in the keymap
>=20
> In v1 the RC10/RC0 keymap is incorrectly tagged as RC20/RC-BT and vice
> versa, resulting in some missing //RADIO and //TV keys. Correcting the
> tagging then reordering the keys to match physical layouts [0] and [1]
> results in no missing keys. The keymaps worked, but I've gotten things
> confused when translating from Emanuel's original keymap. So apologies
> for the confusion.

[0] =
https://www.satking.de/receiver--sat-technik/receiver-zubehoer/fernbedienu=
ngen/fernbedienung-dreambox-original-rc10-500hd-525hd-7020hd-dm900-dm920

[1] =
https://www.satking.de/receiver--sat-technik/receiver-zubehoer/fernbedienu=
ngen/dreambox-original-ir-fernbedienung-rc20-fuer-alle-dreamboxen

^ missed these references

> Christian Hewitt (1):
>  dt-bindings: media: rc: add rc-dreambox binding
>=20
> Emanuel Strobel (1):
>  media: rc: add common keymap for Dreambox RC10/RC0 and RC20/RC-BT
>    remotes
>=20
> .../devicetree/bindings/media/rc.yaml         |   1 +
> drivers/media/rc/keymaps/Makefile             |   1 +
> drivers/media/rc/keymaps/rc-dreambox.c        | 151 ++++++++++++++++++
> include/media/rc-map.h                        |   1 +
> 4 files changed, 154 insertions(+)
> create mode 100644 drivers/media/rc/keymaps/rc-dreambox.c
>=20
> --=20
> 2.34.1
>=20

