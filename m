Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120376A90D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCCGTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCGTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:19:07 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC586113DC;
        Thu,  2 Mar 2023 22:19:05 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bj30so1043866oib.6;
        Thu, 02 Mar 2023 22:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677824345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27Rub21gSh1XV2+0EkPwBcTe3XiiNWsAL6GxLuOsDgM=;
        b=WFBYt3L8DntAMPfj6wX4uDprAl5N5HINLj7Bf3RwcmiN3lbIvi8oMORSjWSbWxfxsw
         Wlslp48ES248GNt9LfrlqHo5jxS/EmPFKIz9rWZ1KB49AxxP1qXKz/JoYPjiCYYQX2ZP
         EhCwMybz29eI4Eewl/xw989srlioqGomgGzPmaf1ysUtVe01QJol2v/3rzeRL5yXKq7h
         pgBkky1uf+mQ70H0KloAB0bp5OVNmPH7v+mztsjSY8digjflIiDdzsZqONn+74Jf7Vg3
         c9Esp8v0Xq0xejAUiyNs9WyVBsqXxGcKhPlm7TNp3y89ZSfLVsjMpBjPR9cykcNHskFO
         foWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677824345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27Rub21gSh1XV2+0EkPwBcTe3XiiNWsAL6GxLuOsDgM=;
        b=OPzHOQdFCbpWcmskjlKpEj3Uk5l0OxU6WD6iVr26/BN6vNbhXeOAdMNyfxLRvTMFEX
         FYrLoCl3f+5H1dqfj8ynKbHSLdRvU5/pMp/EATJQndU0ZyURuy/LG0DK0eR9wJnq54mU
         KQasccKwD/9iSSQK7hz4CaXltPpC1MQGwyYsHOguBrpFDFjLM4grpg8MRFdDQ2Lx6htq
         boxoJyneniP/Wt4GCqNMx5epMw/jIJDS0aAf2046vx1KQmpzbbBgK2vVmMWibQiAo4VQ
         VngwTFnEvI5Cxzlt46L25G7iuZMYIq+8egjVhN+9bVCYonX3lc2OhCCbvKoTfki5+Pxw
         mqPA==
X-Gm-Message-State: AO0yUKVHW9s/ganwNiXSDJlKzSj/RMCvrE8a5QzY/qF1/x4puNlAYDAS
        zIvRC+51/jUhR6NMNEcWWR4TzCer3oriZLxGqIA=
X-Google-Smtp-Source: AK7set8U22fTtAiAvoGmZia+tj+JgvsCoAxu6D9wTuc0d8JsGWv7/y/fhzl2ksI+jPG2VBrmtV6+JbMjrcDtyMs8iqY=
X-Received: by 2002:a05:6808:aa1:b0:384:2022:f9b1 with SMTP id
 r1-20020a0568080aa100b003842022f9b1mr193623oij.2.1677824345277; Thu, 02 Mar
 2023 22:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-7-arinc.unal@arinc9.com>
In-Reply-To: <20230303002850.51858-7-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 07:18:53 +0100
Message-ID: <CAMhs-H-N6KYUXA9kJPrbbZdLhNqFpPafkLWz=2nCzua=zzjHfA@mail.gmail.com>
Subject: Re: [PATCH 06/20] pinctrl: mediatek: remove OF_GPIO as reverse dependency
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

On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> The OF_GPIO option is enabled by default when GPIOLIB is enabled, and
> cannot be disabled. Remove it as a reverse dependency where GPIOLIB is al=
so
> set as a reverse dependency.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
