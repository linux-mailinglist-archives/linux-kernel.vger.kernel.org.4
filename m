Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCAF6B2FB6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCIVgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCIVgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:36:33 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18376EE287
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 13:36:26 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1763e201bb4so3829133fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678397785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX0kFryzQ9wNEJRIiuBwJvaQs4qfJWG0KPZfdOauJKg=;
        b=G5iZj9JNMPqz7ESLkgQ0Ik51gdix1jphc7986eKPWwcCafaqhRStPDGbdYMXE3G51T
         XR1J7WXeIA8vBbt413vuaSrLYUvu4eaU1w38bcEBzEikLiKrJToFBxDKgy7x824Iu48g
         qhyFxANYmpm830eQD7eQ72MyhrAeWcZIoq0aM+SDfhRTBvfGtW1FDU4ZCEcXFaTztdlq
         wv4u2dPfjoq8m8R7X/7AvXXtHXDZ3c99lc7MpQRG1F+OdXZfzeoywlUvBQWQuzvpahRx
         YczkrTMcd5+hFojAH3b74fzuI113P/p2LdKb3yu2nOy98nGyaYL9TyBrbEQKyZ/wUjH5
         Sp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678397785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX0kFryzQ9wNEJRIiuBwJvaQs4qfJWG0KPZfdOauJKg=;
        b=HYUj3U3JCxaPqAsw7ibNfkV/ZPNxkOTBPWAkheFtwDnPKAVbVgDXOtujiB8rEO2Lk6
         aHIPzjQmt+gWB73NbXBfQynFcruntEJNNqz6Cm1+z0Hgwojz0UsN+jeupnsPVOzNoHiQ
         yR6uYMTZiUZICGCSM5kvoTGQ8vbpd3vZ23dmZB4D5r9n0AGf3sgUIVOiM5Cmcy+fUFRC
         5EahS2c+HlRB5CoIDJ5QEgOrYpPmrdB3XpHojlf+9vAGif0t+zbF5ms+m29Mv8V4u5RQ
         OwRNyy1S3/DRfIeLJ2PP+x1d4aFKKNthB4wCbbsVAl5uw3xGqJcwi2BLWZqcCT4e6EQk
         o1JQ==
X-Gm-Message-State: AO0yUKUybhN9gFS0g2Sg1iIzYGTIE7D0I+LgQJWALYaGlQYFmXV0VkXg
        aFbxxXhe33+iQnoct6wY66s/swvWbBCa8ia/7qN1gOhpELUU3BVI
X-Google-Smtp-Source: AK7set9yYS54QE4EUO4suqJYspm6F8sMoOdVS6y+H0bCghSilwGBZNJt4ZGxplqpZNHflpN8lQuhq7eaZZGw8eMY9+s=
X-Received: by 2002:a05:6870:5a94:b0:16e:85c7:4f9 with SMTP id
 dt20-20020a0568705a9400b0016e85c704f9mr8212404oab.7.1678397785453; Thu, 09
 Mar 2023 13:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20230309143459.401783-1-bero@baylibre.com> <20230309143459.401783-4-bero@baylibre.com>
 <42e0c0fe-3ee5-91df-302a-20193ec64bd3@collabora.com>
In-Reply-To: <42e0c0fe-3ee5-91df-302a-20193ec64bd3@collabora.com>
From:   =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Date:   Thu, 9 Mar 2023 22:36:14 +0100
Message-ID: <CAP2ifjN23Q6wmRQGW7rPG26Yy+FjwaRsgWEMrc_ytQYLKH5ESA@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] arm64: dts: mediatek: Initial mt8365-evk support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        maz@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 4:21=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:

> > +             compatible =3D "mediatek,mt8365-systimer", "mediatek,mt67=
95-timer";
>
> You mean "mediatek,67 -> 6 <- 5-timer", right? :-P


Yes, of course. Thanks, good catch. I've posted v11, this should fix everyt=
hing.

ttyl
bero
