Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B073B2BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjFWI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjFWI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:29:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBF32107
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:29:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b4769a2ee5so6289761fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687508942; x=1690100942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2qUpj8yKbysFhO4bnXlgIHrtaxdQPNhbEyv05xDcP4=;
        b=cfvo9uHn77Ekx/CS61uXo0whMu3wP1K2SIlBfy8FYGr6t7g7NZX8HtGkK9TVxvRxNx
         T0jDJxHDpSUaBa+JGqOmb7Htfs6i/330ZKZ4H1eq0ya5BSkd5BYTMexkPewGjhjeq3Jr
         TxiUX5AEMqVNInCE4FdX2T8PI1czEvhFf+DLRHbH1e+5MGrSErc2xgn92tR/6umcpvvv
         3k03oQ7qBVwTd8B/6G7rqMTX/bhAUySOQCgKVAOj4fHa7XLUDqL96Te6+jO3awqvPCgU
         uJak6Q5KUclI7DcPaebbC44BdwbEMP941BbRyPN2oU5qrybEVF6gmjxVIEAfrHxDCy8o
         Aqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687508942; x=1690100942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2qUpj8yKbysFhO4bnXlgIHrtaxdQPNhbEyv05xDcP4=;
        b=dgoiXUI7MK9zQGJutNq0SURGQfmjNp1YyClk8OXhx2a1rtH50G8x59C6hojT+3Q5Wi
         P22X6FJk/v2sfmSkoYZiF2oz4CdtF4VGrcI2cZSpmNSdMXWX551QG4JjRnSOd9vubNbT
         4N0elr3n2FZNR3uxDylka9ZtuQte8oCxrM890urfir3IEtjyfxuYfNa3ti7FX50rUIce
         P9PDh/TgSh4+fC8vvcbbNKdLvSZ39hfHPbQ0yRd/OXR0omO+S246pTVxGjlvVI55vUPd
         kcH+iek79WxoWFWXF+axB50aHyuovcgJ3paIE1tH1dxzZtvQAwjDp/bNK3QteSVtIuN1
         Jg6Q==
X-Gm-Message-State: AC+VfDx6cNSuv5tEZasdGUk1UTLcxZFDEk32gHTHRUV0d6UYqk4a3dAS
        GqrzrD1fn++dMsTK4oRGrU0mmjUK9CLnQjvQHDLqjg==
X-Google-Smtp-Source: ACHHUZ4BUf6QLe/480ZnADtDZ3BsgW3Dx80XUi22/n3hNVBpPJNAvvf6XSo9CghqQ6ErRL1v+G5cvDWrcfa4/KbxM2E=
X-Received: by 2002:a2e:2e0a:0:b0:2b4:5978:c13 with SMTP id
 u10-20020a2e2e0a000000b002b459780c13mr14878649lju.21.1687508942384; Fri, 23
 Jun 2023 01:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-2-eric.lin@sifive.com>
 <28f511f2-ffbb-2ef7-c47c-caf9f5164512@wanadoo.fr>
In-Reply-To: <28f511f2-ffbb-2ef7-c47c-caf9f5164512@wanadoo.fr>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Fri, 23 Jun 2023 16:28:50 +0800
Message-ID: <CAPqJEFqV6O4he14R1=_appLnFVPWKG1k3bdKDuPKhX0EjxwBtQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: sifive: Add SiFive private L2 cache support
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, huangguangbin2@huawei.com, jgross@suse.com,
        chao.gao@intel.com, maobibo@loongson.cn,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Sat, Jun 17, 2023 at 3:02=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 16/06/2023 =C3=A0 08:32, Eric Lin a =C3=A9crit :
> > This adds SiFive private L2 cache driver which will show
> > cache config information when booting and add cpu hotplug
> > callback functions.
> >
> > Signed-off-by: Eric Lin <eric.lin-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.o=
rg>
> > Signed-off-by: Nick Hu <nick.hu-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org=
>
> > Reviewed-by: Zong Li <zong.li-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
>
> [...]
>
> > +static int __init sifive_pl2_cache_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D cpuhp_setup_state(CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE,
> > +                             "soc/sifive/pl2:online",
> > +                                   sifive_pl2_online_cpu,
> > +                                   sifive_pl2_offline_cpu);
> > +     if (ret < 0) {
> > +             pr_err("Failed to register CPU hotplug notifier %d\n", re=
t);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D platform_driver_register(&sifive_pl2_cache_driver);
> > +     if (ret) {
> > +             pr_err("Failed to register sifive_pl2_cache_driver: %d\n"=
, ret);
>
> Blind guess: does cpuhp_remove_state() needs to be called?
>

Yes, I'll fix this in v2. Thanks.

> > +             return ret;
> > +     }
> > +
> > +     sifive_pl2_pm_init();
> > +
> > +     return ret;
>
> If you send a v2, return 0; would be slighly nicer here.
>

OK, I'll fix it in v2.
Thanks for the review.

Best regards,
Eric Lin

> CJ
>
> > +}
>
> [...]
>
