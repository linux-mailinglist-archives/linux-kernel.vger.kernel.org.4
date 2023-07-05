Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370F7748536
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjGENlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGENlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:41:19 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5439F;
        Wed,  5 Jul 2023 06:41:18 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5703d12ab9aso82123897b3.2;
        Wed, 05 Jul 2023 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688564477; x=1691156477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLq8DTcDk4CKexj0TWcSdnBEWdMB2TY0/NlFdshVB0U=;
        b=OFrHjgg7tLcB2HzfJaZMfT12TH3YQEf3I1Ry0sn5/D/IzPfGhP2E9ECVQo/6sta5kq
         zyYDiCaO+ekwhHUDuVIV2OFijUPuOb1T5SoJYo/DJFjKM7fV6s+9X5FxJPxT4UMHB79q
         w7T7QUqAsi8ynbGD37jDGYATjFg6XKyUFKHIJHQNwDDbCLnGPKNdibld/vbCI+FG/npy
         mTERib+mBqgY6xyOZnyuqOr7UfBlORxCa/OPZwQJm+b39O7KRwp00vaSdBjnpeJtSCIr
         JOF+/6YpZsTPt/hsRKKpEXhLsESacSS94t7HJQojchblg0Fz3LqoOFSyDo24xq914QnA
         h3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564477; x=1691156477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLq8DTcDk4CKexj0TWcSdnBEWdMB2TY0/NlFdshVB0U=;
        b=U4yQfbDFxrgLZMfkEMyT7+z3u+e5+IlwcJ6WxiJxPr4034Lu5jLeXonIcYE47UBn2a
         5orG1ROyF+vSeBJ0R25cLnbr6KnGTjii1m8cfOaw6yt/nIkPkalTvPszxLSpoW5ItP41
         o8PAtH6sHCp7qQdU6/P3MbXuMKmL2T12iAbQhEJ2s1i7YhJ3drL5XCIxbBTY3z/i4i7G
         22DDibAaCkXW52Wv1FzlDKcM2tZub2lBYkC0T5CuUaxYsfnB57br3K7d3VFm9ynRzE0L
         JdWUUFG23LLL+HxWL+ClFDhFQo9tUiV24SNCKK2u4zJmaNOEa7D98Kah1RET6+Gu8g8D
         rZDQ==
X-Gm-Message-State: ABy/qLZYqseNKCRmpdbjKHyQlZfQKXkG49+GxITt8wem3qHpO8M8pHAi
        hKmw9EDiJvyllDlPpNqhygPM24yTJ5rmZkJN9CHlvQmGeo4hK8rlCcY=
X-Google-Smtp-Source: APBJJlFnAaqBZr9QUj1wiHcfBt+OU6EzMUbau6TvRYcksbylTyeyO/L1BOWmPBoAH5ANWWOliZe5g1A7JaejZ9+8F44=
X-Received: by 2002:a25:ad06:0:b0:bc6:91e5:7b4e with SMTP id
 y6-20020a25ad06000000b00bc691e57b4emr15559089ybi.13.1688564477164; Wed, 05
 Jul 2023 06:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230704163848.169853-2-davidwronek@gmail.com>
 <20230704163848.169853-6-davidwronek@gmail.com> <9f06d400-be7b-6806-b055-8cc7f11db6ca@quicinc.com>
In-Reply-To: <9f06d400-be7b-6806-b055-8cc7f11db6ca@quicinc.com>
From:   ungeskriptet <davidwronek@gmail.com>
Date:   Wed, 5 Jul 2023 15:41:06 +0200
Message-ID: <CAEoe_eW-0V6uSVhJGaxJc7V=qujkkpn=chBNc5kjpP9XViFPOg@mail.gmail.com>
Subject: Re: [PATCH 4/7] clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
To:     Taniya Das <quic_tdas@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, map220v <map220v300@gmail.com>
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

On Wed, Jul 5, 2023 at 6:27=E2=80=AFAM Taniya Das <quic_tdas@quicinc.com> w=
rote:
>
>
>
> On 7/4/2023 10:01 PM, David Wronek wrote:
> > From: map220v <map220v300@gmail.com>
> >
> > Add the PARENT_ENABLE flag to prevent the clock from getting stuck at
> > boot.
> >
> > Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driv=
er for SC7180")
> > Signed-off-by: map220v <map220v300@gmail.com>
> > Signed-off-by: David Wronek <davidwronek@gmail.com>
> > ---
> >   drivers/clk/qcom/gcc-sc7180.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc718=
0.c
> > index cef3c77564cf..49f36e1df4fa 100644
> > --- a/drivers/clk/qcom/gcc-sc7180.c
> > +++ b/drivers/clk/qcom/gcc-sc7180.c
> > @@ -651,6 +651,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src =3D {
> >               .name =3D "gcc_sdcc2_apps_clk_src",
> >               .parent_data =3D gcc_parent_data_5,
> >               .num_parents =3D ARRAY_SIZE(gcc_parent_data_5),
> > +             .flags =3D CLK_OPS_PARENT_ENABLE,
>
> Could you please share what Stuck warnings are you observing?
>
> >               .ops =3D &clk_rcg2_floor_ops,
> >       },
> >   };
>
> --
> Thanks & Regards,
> Taniya Das.

Without this patch I get the following warning:
[    0.316057] gcc_sdcc2_apps_clk_src: rcg didn't update its configuration.
[    0.316081] WARNING: CPU: 4 PID: 75 at
drivers/clk/qcom/clk-rcg2.c:133 update_config+0xcc/0xdc
[    0.316226] Modules linked in:
[    0.316265] CPU: 4 PID: 75 Comm: kworker/u16:2 Not tainted
6.4.0-next-20230704-sm7125 #51
[    0.316337] Hardware name: Xiaomi Redmi Note 9 Pro (Global) (DT)
[    0.316394] Workqueue: events_unbound async_run_entry_fn
[    0.316453] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    0.316517] pc : update_config+0xcc/0xdc
[    0.316560] lr : update_config+0xcc/0xdc
[    0.316602] sp : ffff80008088b8e0
[    0.316636] x29: ffff80008088b8e0 x28: 0000000000000000 x27: ffffa9c34c5=
71d00
[    0.316708] x26: ffffa9c34c333db0 x25: ffff60d440b5ec10 x24: ffff8000808=
8bb18
[    0.316778] x23: ffff60d441704900 x22: 0000000005f5e100 x21: ffffa9c34c5=
dc548
[    0.316849] x20: ffffa9c34cc739b8 x19: 0000000000000000 x18: fffffffffff=
e5f18
[    0.316918] x17: 0000000000000014 x16: 0000000000000020 x15: 00000000000=
00048
[    0.316988] x14: fffffffffffe5f60 x13: ffffa9c34cb5e928 x12: 00000000000=
003f9
[    0.317058] x11: 0000000000000153 x10: ffffa9c34cbb88f0 x9 : ffffa9c34cb=
5e928
[    0.317128] x8 : 00000000ffffefff x7 : ffffa9c34cbb6928 x6 : 00000000000=
00153
[    0.317197] x5 : 0000000000000000 x4 : 40000000fffff153 x3 : 00000000000=
00000
[    0.317266] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff60d4402=
84880
[    0.317336] Call trace:
[    0.317365]  update_config+0xcc/0xdc
[    0.317407]  clk_rcg2_configure+0xb0/0xb8
[    0.317451]  clk_rcg2_set_floor_rate_and_parent+0x2c/0x44
[    0.317506]  clk_change_rate+0x7c/0x294
[    0.317551]  clk_core_set_rate_nolock+0x168/0x274
[    0.317601]  clk_set_rate+0x38/0x14c
[    0.317641]  _opp_config_clk_single+0x30/0xa8
[    0.317687]  _set_opp+0x258/0x468
[    0.317726]  dev_pm_opp_set_rate+0x180/0x268
[    0.317770]  sdhci_msm_probe+0x360/0xb4c
[    0.317815]  platform_probe+0x68/0xc4
[    0.317859]  really_probe+0x148/0x2b0
[    0.317900]  __driver_probe_device+0x78/0x12c
[    0.317947]  driver_probe_device+0x3c/0x15c
[    0.317994]  __device_attach_driver+0xb8/0x134
[    0.318040]  bus_for_each_drv+0x84/0xe0
[    0.318082]  __device_attach_async_helper+0xac/0xd0
[    0.318132]  async_run_entry_fn+0x34/0xe0
[    0.318177]  process_one_work+0x1c0/0x334
[    0.318221]  worker_thread+0x68/0x428
[    0.318260]  kthread+0x110/0x114
[    0.318300]  ret_from_fork+0x10/0x20

Sincerely,
David
