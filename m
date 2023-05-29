Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2C714CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjE2PTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjE2PTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:19:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF8C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:19:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149bdb59daso2012446a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685373578; x=1687965578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZgZXnMg9wXTS/r3Sukm/rWLj7wcaCc/WoDq00rLz4xE=;
        b=g2oqnCbd00ALjaav75ggRYNppDcSESN8qv1U5VHeLHd9BpkxE7mbd98g1X929rSI8N
         Gbk9NJDls+tF85Iygw5XYg6Z31O2dRgiKTFa+CVBPGc5xiGTYYhyqHzPYyzY6U6wzMQv
         PC6/qc911i0AnOl+hSKlph+EVkVE6yzvr85S71BXdO6TNlGK1/jyUQBqc/l/xVhrrqE3
         T497xMb4PJCLd5ce58u/e4IkJdOOQ+VS9QfF3wBci1FEAOLS2GIPUQBSXCoYsHpw4PKw
         +8ErWtAx2bOCayJ58+Amqoprsj1xDCIFixgPA1wiXx5G7NN1u/pkcYwBzfSBFvS94JA6
         B02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685373578; x=1687965578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgZXnMg9wXTS/r3Sukm/rWLj7wcaCc/WoDq00rLz4xE=;
        b=AzOEts21fbRYJNZPJC4ykeCXXwgSkgo/zML5BrZZJZ+P+PEWZ4K8pyxzOzUkpjuIGc
         s/XP1e6/2kPlnvWxNX2U3p1wkvjyeoShOU1UW7V6+MgN1hGWefiP2LZNtCARVcZ3N0ip
         UVo703/Q17/xIp1KHNsMAbcMdKsKOE+LV1sGcqSlVKuSTx3kM6gOavQbUYYqKgvrl/Wg
         S3RGIlGbh/wizdWQY8Uy2v/CBYDsiMve15tfUkT4xnhceXbvEMJveBMr9iz6fwcxA0Q5
         PF4Z0UkQrJg+5RLj+r4QF3X/e1eev5IJa1BGO+S7JrVwHO3DlmIpie/fVw0BZ2ZrKx4o
         ZwBg==
X-Gm-Message-State: AC+VfDzPv1zBPdaVk4aZBwra9ajfWw6tLK/8Uw072bv1M6CFvYC7x7jn
        /B3csGO1JiryogdD0CFmibQ=
X-Google-Smtp-Source: ACHHUZ6I8iJk5KKp529l7Yr1BpVUMVfn5LrarK4ad64tdKPuVvCb7quUrqOCQ1IqVLtPAnKpzajbSA==
X-Received: by 2002:a17:907:2d13:b0:973:ea41:3ef8 with SMTP id gs19-20020a1709072d1300b00973ea413ef8mr7277562ejc.35.1685373577795;
        Mon, 29 May 2023 08:19:37 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id dy26-20020a05640231fa00b0050bd2f16ef5sm3171406edb.84.2023.05.29.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 08:19:37 -0700 (PDT)
Message-ID: <873fc37f5fc9ed04698c99feafca156699b2b1ee.camel@gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: Fix whitespace issues
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     hsweeten@visionengravers.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Date:   Mon, 29 May 2023 17:19:36 +0200
In-Reply-To: <20230529143333.19278-1-franziska.naepelt@gmail.com>
References: <20230529143333.19278-1-franziska.naepelt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Franziska,

On Mon, 2023-05-29 at 16:33 +0200, Franziska Naepelt wrote:
> This removes the following checkpatch issues:
> - ERROR: code indent should use tabs where possible
> - WARNING: please, no spaces at the start of a line
>=20
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>

thanks for the patch!
However the file is going away at some point anyway:
https://lore.kernel.org/lkml/20230424123522.18302-40-nikita.shubin@maquefel=
.me/

> ---
> =C2=A0arch/arm/mach-ep93xx/timer-ep93xx.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/t=
imer-ep93xx.c
> index dd4b164d1831..5bfabbdde463 100644
> --- a/arch/arm/mach-ep93xx/timer-ep93xx.c
> +++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
> @@ -82,8 +82,8 @@ static int ep93xx_clkevt_set_next_event(unsigned long n=
ext,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Set next event */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writel(next, EP93XX_TIMER=
3_LOAD);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writel(tmode | EP93XX_TIM=
ER123_CONTROL_ENABLE,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 EP93XX_TIMER3_CONTROL);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EP93XX_TIMER3_CONTROL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0

--=20
Alexander Sverdlin.

