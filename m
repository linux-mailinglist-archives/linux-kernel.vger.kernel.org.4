Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB85E69639E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjBNMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBNMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:36:47 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEC844AD;
        Tue, 14 Feb 2023 04:36:47 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-16df32f2ffdso8110469fac.1;
        Tue, 14 Feb 2023 04:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJL5K69YJwMyRvtOMJi4GxbKjX0eSbFmhEkg7WKURnU=;
        b=HiWiW+1FNLvngvHXGPGTTyQReRlpi5+VmnxdX2fOjA7JhT+goe4q94ikaxLYW3Wxlp
         oA6/PHSvCxL27z2GcbTzWv0yu4pvpBjws2slq0c1qSZ5ASJwGmoMuxj3qiYZS2hV0a/B
         +amExfxMxtiSQtDPjEg31NlCpeMoPBJMzsl6ResWSONUIDrcjY6iR9HoAnoqn1C0/dSe
         w9Mazep/7nEI2zNAwZ9a2CZ2hCdjW1IpvdQXj4RwUhXyiF+xtJi8tPIHHshVaRwR/U5k
         Kgti70Pke7DYzYndmGMz7tx2a2T9wydYM9gHBZcgSA2TOF9fIU3YEHVAMzOcRKskE+t2
         yvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJL5K69YJwMyRvtOMJi4GxbKjX0eSbFmhEkg7WKURnU=;
        b=XRkA0JpVftGxiHJ8JFW1/Eaw5G1Pcx51UP89X5v6vsX+hNcOpqh1RGkELol2LVKZrR
         jtzN0ETMOgNze4xEn/j6y3ZxfG/Sd2DgNd9E6pg8J0i3LRLVi+AC4sk+4nxuVLq3vPOS
         KR3Js0yeanfkcrn6T4tjJdrk8tV1ZQ/zfkKHgTzQbsr7fy2omut6TwtvflXYjORoyh6e
         pjqfEQf5xtTXvdGWCfRawu7KPygnucamXWzzVjuGFrLnP3ObW6BXuuDTF7q7QeuulxlR
         ylweHGwPJI/nxqdh9PQruiwpgx4EZvbIPd/OBRI+aVoWKi39I4NckLoK53sFbwY9bUkL
         5uIQ==
X-Gm-Message-State: AO0yUKWBXL1icwl7+czzFdsrw6rP6lyHBk1tMAc64Xh0lDzhj3JllefD
        B2JePAkOvlSWXLSxJlvakC8Yu+VsgPNizuH/eHI=
X-Google-Smtp-Source: AK7set/ui73MqjM/LBXHbhjS7LdN5n7I/PH1AsVMONXqx0J/1osuqMLm0+lpnlM6co4pizPFkKG2dwdvt3PaxYfeDNg=
X-Received: by 2002:a05:6870:9615:b0:169:fabf:b222 with SMTP id
 d21-20020a056870961500b00169fabfb222mr3883945oaq.83.1676378206354; Tue, 14
 Feb 2023 04:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20230211104915.116253-1-arinc.unal@arinc9.com>
In-Reply-To: <20230211104915.116253-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 14 Feb 2023 13:36:35 +0100
Message-ID: <CAMhs-H9YCVe9AKQDv0DrdceFmV1SSOdM-twq65uNdj3+gE677A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mips: dts: align LED node names with dtschema
To:     arinc9.unal@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
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

On Sat, Feb 11, 2023 at 11:50 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> The node names should be generic and DT schema expects certain pattern:
>
>   mt7621-gnubee-gb-pc1.dtb: gpio-leds: 'power', 'system' do not match any=
 of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  .../dts/cavium-octeon/dlink_dsr-1000n.dts     | 10 ++++-----
>  .../boot/dts/cavium-octeon/dlink_dsr-500n.dts |  6 ++---
>  arch/mips/boot/dts/ingenic/ci20.dts           |  8 +++----
>  arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  6 ++---
>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  8 +++----
>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  8 +++----
>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  2 +-
>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 +++----
>  .../ralink/gardena_smart_gateway_mt7688.dts   | 22 +++++++++----------
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc1.dts  |  4 ++--
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc2.dts  | 12 +++++-----
>  11 files changed, 47 insertions(+), 47 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
