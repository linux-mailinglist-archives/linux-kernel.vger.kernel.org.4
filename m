Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79816A90AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCCGCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCCGCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:02:15 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FA91A953;
        Thu,  2 Mar 2023 22:02:14 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1763e201bb4so1947094fac.1;
        Thu, 02 Mar 2023 22:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677823333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsVS/7R0dxzsikXc/PdT/FfkUVNz6uPz9eBYzTzhU4M=;
        b=Kb/spSKSajU9LBD2Ef/KRzX5WzVnomBcbGnoMYe2t6dMNweIXJA6cdzDlxTB55DnlZ
         5FtUgkydpOajt1u77sQNJTIqcVNFDV7PdyfJzFiHCQFURS4vHRmtPsZCpQ1nP7QUo1Ve
         wi7qIGgaf20rY1FRouBjp00ML98nA/nZGyNnP2Ugl4WXf2yeLU46Xy4f4dIkvaK2dd4R
         fx9U0bADjnpT/LUlzk5GJTLf4yE8nSchRi1tEWIDyxVhHBra96P91j5dzlpiKk/3qRmJ
         vrgDcxFrty7EHKNOoFHiyTDCreNyD6eiWhB/MwYo+mnviHBjqAfUndJLyQgenUtjMdnn
         jIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677823333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsVS/7R0dxzsikXc/PdT/FfkUVNz6uPz9eBYzTzhU4M=;
        b=slwzVFCZyuPDfxjp+axD+YixiE5j3ZWopBeRY7yybEb8UTZk6bHTX7HvNLW+sE6QTU
         txs1GvFXTY4pMinczvMhHaL+6q5IvABTWVhLjQ66Y13ux6ijcQx8ouLefYqZe3eW245k
         4ZmRy3Z8QL51ecCqYI0SjZouXtEKYj5awaDZ+17eujE0vYmKWSFEFJY2BaPeCg/miUcl
         ZxjleUXZ8mh9TW9wAydpYXdpJzaPfJ4U0zOKChavgyKouZgvDoia1I5GhLEHTNVC5L0+
         ascr9M8/ltNbPp7glN0b+5fp7iuHpdDctY6U8GKAyPsq+C8J4gFL3uMK9xk+rpYQ8iVd
         2VLA==
X-Gm-Message-State: AO0yUKVklBG5GJhXMUY8rgczGtleQUVT7q3kMfK+fqei9jDbwNdxr6ep
        mCpmdcBLoBedUe4H1UUm/lFRdtNjGxAvUTl5rX3m/GDmaIu/yQ==
X-Google-Smtp-Source: AK7set9S4QcSuJePzBJR5ErJRF54NuH/O2am1XDgcwU4k6vq5NkLeE2IzBTbjz7WViCx2z73kcpZsnIxYHwbU2s6yeY=
X-Received: by 2002:a05:6870:a2c2:b0:16e:84ea:f1e9 with SMTP id
 w2-20020a056870a2c200b0016e84eaf1e9mr238613oak.2.1677823333736; Thu, 02 Mar
 2023 22:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-3-arinc.unal@arinc9.com>
In-Reply-To: <20230303002850.51858-3-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 07:02:01 +0100
Message-ID: <CAMhs-H80LrYJ4avuRFxKaM1Lj54FQM05k8omLJUjfYnpz1GPZw@mail.gmail.com>
Subject: Re: [PATCH 02/20] pinctrl: ralink: {mt7620,mt7621}: add new mediatek
 compatible strings
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
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

On Fri, Mar 3, 2023 at 1:29 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> This platform from Ralink was acquired by MediaTek in 2011. Then, MediaTe=
k
> introduced these SoCs which utilise this platform. Add new compatible
> strings to address the incorrect naming.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  drivers/pinctrl/ralink/pinctrl-mt7620.c | 1 +
>  drivers/pinctrl/ralink/pinctrl-mt7621.c | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
