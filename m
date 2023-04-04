Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3156D5B06
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjDDIjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjDDIjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:39:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019321BE3;
        Tue,  4 Apr 2023 01:38:57 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x20so32957075ljq.9;
        Tue, 04 Apr 2023 01:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680597536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrdlODl0H5+PHsF6BIcaDQCeLLNaLHz3VtBPnGOz2PM=;
        b=P0REh2WHl1EKDfiroTLCUjD8DYaPTCETRF2VE6q/v0KXm1MRsyL2PPEr8IZ1EyjEsJ
         f3pvaaiZqU37OTrWSWjfughTHizj1fTrSP4rmWk3/HSpEpuUnuqR7ZWT84NFeh++RL8G
         RYsROggoSa/r34SF2Zo+u5Fc2dZZc2OS5ap1g9ttg7gvSaZzrjzmYD+jc4dSkiWVvp43
         28CTxNr2658fyb1Qzitz8a8VFRCQoD+jt5sQAhzYINMPMZH+i8zh/bk2dRp2diRjTeXQ
         ZkwA5kOx7WGdVgf6lQJqMWTdRt6eNuDp+VqtLWpXmaS9vtKJFSqcNvUV5YqWxzk5JOm4
         bvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680597536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrdlODl0H5+PHsF6BIcaDQCeLLNaLHz3VtBPnGOz2PM=;
        b=RgDw9dv5jU/jf78Iaet+k7KwlhtuBZUc95TmOfOKd/IqihOG8+IguXHB3LeGJTJey4
         750jKFMBhoGRMRwAEPNQJoSgo5L75jSsr34n62VPKh1AfYj03YF+3rJ7lwPRgFai0NQf
         cZF3LqLTy7f6ZZP52qDl+DHVq71XUuxnIJRA6kBBW9FDH6inhjqJha2YbUr08VKVJic0
         mrWeDi8v7nKEtsWprnOzl2Q/X81mKLmRx9Pk7GmmiMNCaldHYMfCIP2rOkpRLeuV8bgv
         3Dho+i6urjPHHFpUTE2jc/cgjHEh5QxOG/R5x6JkiT5TV5SMPhAVgQOn8XVsCvZL6SX3
         JqBw==
X-Gm-Message-State: AAQBX9f46gc0TnuCEXpXLcgD7k/2sDQ3EnReKdDKeHTATN00trVxzKL1
        XDtj4pNgmDsAz2JT1LLu/VqaTXTB4o2TmtPeUZk=
X-Google-Smtp-Source: AKy350YRWO8o83HonQhxyVR1qlxipGouFXslbqo/1KCmYgWBSiIBPGp83XNapgz6XMi3g+DZj0t5McHHLhoEyS/hIwA=
X-Received: by 2002:a2e:a307:0:b0:295:93eb:bab1 with SMTP id
 l7-20020a2ea307000000b0029593ebbab1mr743896lje.1.1680597536075; Tue, 04 Apr
 2023 01:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230403175937.2842085-1-javierm@redhat.com> <3738011.44csPzL39Z@diego>
 <d7efebcc-5b5b-185e-bec8-b6b9d5d27d93@undef.tools> <87h6twdpi7.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <87h6twdpi7.fsf@minerva.mail-host-address-is-not-set>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Tue, 4 Apr 2023 09:38:44 +0100
Message-ID: <CALeDE9M4eNq1sfQ-UcNZr8naYThmLFxDpt=zj8WkCSzHPUY8ug@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Jarrah <kernel@undef.tools>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, Caleb Connolly <kc@postmarketos.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 9:24=E2=80=AFAM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Jarrah <kernel@undef.tools> writes:
>
> > Hi,
> >
> > On 4/4/23 17:51, Heiko St=C3=BCbner wrote:
> >> The interesting question is always if this will break someone else's s=
etup.
> >> I've never really understood the strange setting of 1.5MBps, but on th=
e
> >> other hand it _is_ a reality on most boards.
> >>
> >> Personally I don't care that much either way, but would like a comment
> >> from the other people working on that device - if possible.
> >
> >
> > I don't have a strong opinion either way, but I would note that
> > Tow-Boot[0] which later models of this device ship with uses 115200,
> > meaning that this would put the device out of sync with the default
> > u-boot implementation from the factory.
> >
>
> Probably we can't change then because it would break the setup of people
> using Tow-Boot as a bootloader.
>
> > At least for me it's been convenient to have both the PP and PPP use th=
e
> > same settings while debugging.
> >
>
> Agreed, all my other boards use 115200 as well, the only exceptions are
> the Rockpro64 and PinePhone Pro for me.

All Rockchips devices use 1.5m except a chromebook and the Puma, and
this device.
