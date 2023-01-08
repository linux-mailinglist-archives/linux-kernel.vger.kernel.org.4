Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E4D661896
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjAHTje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjAHTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:39:32 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9B0AE7B;
        Sun,  8 Jan 2023 11:39:31 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id u9so15338733ejo.0;
        Sun, 08 Jan 2023 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJiTYEPUGswRyYpBjspRiUoP3U43isLne3ofLdoy89s=;
        b=VU5Hm1Lq0aHvT7J9pdHV4ctyxUeVvUX1lDUngZBuKlhEFhmS3r3pPFEvhgSe9GbAus
         WVg7Ca10CpTmXYRb4Y8RsHtEpaBYnDHH2z04qSFG5+EZx+2H8yJ9KnTJHq+3txPkBYz2
         WCjNBQl0B8ML42dzqx1RAdNPka/pfRin4f0P8RQfscvdLFZu4HNbjFQSH5ISn87nNadC
         n2bMbSf+5TmQK9JamEuqueD2tlyM2Yeh6gL1l7Ckl4/ETZcAeb8U6nvaxZMOWQGAxYcp
         7SJ9nAogbDjBlV8YDqQjJ+6iIOA7XRnOrzK13gMjBz6MCD5oB/8lIs1t3YvW2kdos4NT
         MRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJiTYEPUGswRyYpBjspRiUoP3U43isLne3ofLdoy89s=;
        b=UrhwHlYTR7JfYLp3z7lZZaRnwM+I89ua3quzJ7GXRoOJmmpk/LqLA8fD97fhPbf9I6
         HGnB9OziOyFVxZ2LoORlEPXCmugv2x97JS1qK8Q9a9o0viZp+lVajsrCdXVvbYe9Yh0F
         o7X+en+ZmmPf8Xm7O5YFBL7960QXTAUF8eitG3t1y1mUWTE1PMScy85lySjehEvs//Qk
         gMcCE5cMHwR5v65BsIrV4Si8Z3N58HL2CmiaAkyYt+lHPGMBSRLAL2BVMYlg14Rb8lVF
         l6NmZYA0m8DqwhjrZidl0c6DuJOEUjA3F1ajjuAKByZw5ZihOEohAVjP/1LVR4ayBru2
         z96Q==
X-Gm-Message-State: AFqh2kpAHjRPgK9mXtM559J674iuD3PumjzNJwoMLHzO5f22DbSBV3KC
        xghTXOVLaveVT5R0dQGHG2VcMef838K9Ng==
X-Google-Smtp-Source: AMrXdXv6Jx2XUMzyPA0I1YklgDSX6ZuJ1xXXUIpDNIv03Ig3MOrYDUA2N+g7yb9WLbpMNKwaSClvMQ==
X-Received: by 2002:a17:906:57c4:b0:844:436f:8f01 with SMTP id u4-20020a17090657c400b00844436f8f01mr46425105ejr.17.1673206769560;
        Sun, 08 Jan 2023 11:39:29 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906329200b007c0c679ca2fsm2817648ejw.26.2023.01.08.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 11:39:29 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] rtc: sun6i: Prevent an out-of-bounds read
Date:   Sun, 08 Jan 2023 20:39:27 +0100
Message-ID: <4834080.31r3eYUQgx@jernej-laptop>
In-Reply-To: <5c20af59-5fb5-8f7d-f6af-2b3984d79595@sholland.org>
References: <20221229184011.62925-1-samuel@sholland.org>
 <8201852.NyiUUSuA9g@jernej-laptop>
 <5c20af59-5fb5-8f7d-f6af-2b3984d79595@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 07. januar 2023 ob 18:15:47 CET je Samuel Holland napisal(a):
> Hi Jernej,
>=20
> On 1/5/23 11:26, Jernej =C5=A0krabec wrote:
> > Dne =C4=8Detrtek, 29. december 2022 ob 19:40:10 CET je Samuel Holland=20
napisal(a):
> >> If there is more than one parent clock in the devicetree, the
> >> driver sets .num_parents to a larger value than the number of array
> >> elements, which causes an out-of-bounds read in the clock framework.
> >=20
> > Is there any DT with more than one parent? I think more fixes are needed
> > if
> > this is the case.
>=20
> H616 and newer expect more than one parent, to accurately represent the
> RTC clock tree, but they use the CCU driver instead of this code.

If I understand that correctly, second clock would be 24 MHz crystal? In an=
y=20
case, if multiple parents are possible, check needs to be added to see if=20
parent clocks include 32 kHz clock or not.

>=20
> This bug is preventing us from relaxing `maxItems` in the binding for H6
> and older SoCs, even if Linux does not use the additional parent clocks.
> I want to fix this bug now, to give us the option (if beneficial) of
> relaxing the binding in the long-term future.

I wouldn't call it a bug, since it works just fine for currently defined=20
binding. Do you have DT binding change in pipeline?

Best regards,
Jernej

>=20
> Regards,
> Samuel
>=20
> >> Fix this by coercing the parent count to a Boolean value, like the
> >> driver expects.
> >>=20
> >> Fixes: 3855c2c3e546 ("rtc: sun6i: Expose the 32kHz oscillator")
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>=20
> >>  drivers/rtc/rtc-sun6i.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> >> index ed5516089e9a..a22358a44e32 100644
> >> --- a/drivers/rtc/rtc-sun6i.c
> >> +++ b/drivers/rtc/rtc-sun6i.c
> >> @@ -294,7 +294,7 @@ static void __init sun6i_rtc_clk_init(struct
> >> device_node *node,
> >>=20
> >>  	init.parent_names =3D parents;
> >>  	/* ... number of clock parents will be 1. */
> >>=20
> >> -	init.num_parents =3D of_clk_get_parent_count(node) + 1;
> >> +	init.num_parents =3D !!of_clk_get_parent_count(node) + 1;
> >>=20
> >>  	of_property_read_string_index(node, "clock-output-names", 0,
> >>  =09
> >>  				      &init.name);




