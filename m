Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C6D6FE549
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjEJUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEJUkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:40:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D85FE7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:40:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so72737686a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683751248; x=1686343248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV4V5oKk2KsrJeuxF19Yb1hq3jeecgjI+b5qCvolrQg=;
        b=ibc2BwYghym+fn/vCk9SHDumCZgRCop/7OvgQFQIIvscYFsJxOWzeMw2oQbPEK1pdO
         N4opBD1qp63+VYxYQAa3wN2Q3gzSA35+0vIANyJxqJnqRM5av5f7ZGkugQXciz/bLrbt
         q1NTC5e0D986bEkWKzfTmp4N8JDmw6I3UZMiWJyudJZYtKvaCQr1DOdMfvc55IFdu/nW
         4IFc+xdtUWIW+XNI3efAVtklDCVWnWnA6rpfy2tncXm16rqeohfK0mEOwbusT2FALebh
         oNYcY6vbD6oaNIk5gxmR4701A3MRoDH2Zi8BE6uXaUtqiMlLpOPtH4NZJzNm4odhY/4x
         GcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751248; x=1686343248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV4V5oKk2KsrJeuxF19Yb1hq3jeecgjI+b5qCvolrQg=;
        b=T+fMwdx7FsUFVJX7c2GhkDbDWPd7+zyPCs4STY5GzAYKDoBn9AD0D9ddSMS5fCnfS+
         iNBKdO4FGPnQRXq/MRajKebeEhUl+KLoWi920GY8JaPf02vIspe8f81ro3KGfVgwCvaL
         bydlVwk9Hv0zJQnwhUgx+xqxjpQLyaouXcZK3x0dlyhZxvUC4KeCE07Mu5k7K31/vQ7h
         PC7JvCSRkzCVbuJKxM7w7GHdcuS8At7Afw1uILpb3uTM40io/40Cdoll8nnnMLdvh9Cu
         Jyzihbnklaqww2pwpI9jOk/d5HkwOXjUGX/+Kn9lEyJBP3sjDWOWA35g17LGs09ASzJY
         1lGg==
X-Gm-Message-State: AC+VfDxa5B5pF/ah0HTLFgRuQ4G6ZiHWhEn3FB4ZjyNK1h9k2607r3Lu
        lXx3iIYUkMSwa1IfgmlwXZATCc5QqVf3un8FDeozgVl30aI=
X-Google-Smtp-Source: ACHHUZ7udSj49jfFEMe1doYGyFqE8X2Co61Hu2FHlmXrOHpm/14E6PuXOuzdlOqct8rX7xnSIW+FfGWCAGm2AnSjEP4=
X-Received: by 2002:a17:907:701:b0:94f:236b:9e3a with SMTP id
 xb1-20020a170907070100b0094f236b9e3amr14655639ejb.3.1683751248438; Wed, 10
 May 2023 13:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230510110835.26115-1-AVKrasnov@sberdevices.ru> <20230510110835.26115-7-AVKrasnov@sberdevices.ru>
In-Reply-To: <20230510110835.26115-7-AVKrasnov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 10 May 2023 22:40:37 +0200
Message-ID: <CAFBinCAbTuNGEG13f71F8vhN3yGce+kkYJ7PHMpZbh8DzSapJg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mtd: rawnand: meson: rename node for chip select
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, oxffffaa@gmail.com,
        kernel@sberdevices.ru, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arseniy,

On Wed, May 10, 2023 at 1:13=E2=80=AFPM Arseniy Krasnov
<AVKrasnov@sberdevices.ru> wrote:
>
> This renames node with values for chip select from "reg" to "cs". It is
> needed because when OTP access is enabled on the attached storage, MTD
> subsystem registers this storage in the NVMEM subsystem. NVMEM in turn
> tries to use "reg" node in its own manner, supposes that it has another
> layout. All of this leads to device initialization failure.
In general: if we change the device-tree interface (in this case:
replacing a "reg" with a "cs" property) the dt-bindings have to be
updated as well.
Documentation/devicetree/bindings/mtd/nand-controller.yaml and
Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml show
that the chip select of a NAND chip is specified with a "reg"
property.
Also the code has to be backwards compatible with old .dtbs.

> Example:
>
> [...] nvmem mtd0-user-otp: nvmem: invalid reg on /soc/bus@ffe00000/...
> [...] mtd mtd0: Failed to register OTP NVMEM device
> [...] meson-nand ffe07800.nfc: failed to register MTD device: -22
> [...] meson-nand ffe07800.nfc: failed to init NAND chips
> [...] meson-nand: probe of ffe07800.nfc failed with error -22
This is odd - can you please share your definition of the &nfc node?

&nfc {
      nand_chip0: nand@0 {
        reg =3D <0>;
      };
};

This should result in nand_set_flash_node() being called with
&nand_chip0 (if it's called with &nfc then something is buggy in our
driver).
If there's no child nodes within &nand_chip0 then why would the
MTD-to-NVMEM code think that it has to parse something?
If you do have child nodes and those are partitions, then make sure
that the structure is correct (see the extra "partitions" node inside
which all partitions are nested):
&nand_chip0 {
    partitions {
        compatible =3D "fixed-partitions";
        #address-cells =3D <1>;
        #size-cells =3D <1>;

        partition@0 {
            label =3D "u-boot";
            reg =3D <0x0000000 0x4000>;
            read-only;
        };
    };
};


Best regards,,
Martin
