Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34467654AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiLWCC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLWCCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:02:23 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B659205D6;
        Thu, 22 Dec 2022 18:02:22 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v14so34074qtq.3;
        Thu, 22 Dec 2022 18:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRsG7CUx+87J7Pu6OLcyLz9sGZD18C5xpw5JeWDMppU=;
        b=NWETL1fFKFE3+ojt7+70iA/Nvi3AaW8xgGrrNit6XW4IHkhisvH3W5uB/QDHeHXg25
         d3Zj/hU2pfIU6XEwsLAmJyYe5ZDemKMXcJdyXIFn2S9T3fL6hCEc+QtYriQMCr+VGFwO
         xf33e98T+99P3dZ4L4jFsf1ngO5ecRStii971iY5HLSnHAvnGwUkLBoVUcvTqZbvRk/f
         S3auB8EtZBCbQ2gosPTcLAVGufyJHQerrtZFObRuvV+o4SQVbu66cECKFP0VCjFpSB85
         OuesCyKXkgovqmBHRqzRXisZvce0ZR/APFJOqGXCPaFeh+Bk+jyBRP+3O18GSfL0tvEr
         +FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRsG7CUx+87J7Pu6OLcyLz9sGZD18C5xpw5JeWDMppU=;
        b=Hs0KjJwoXo97xvSzuOlzxtU+oVw8AqGNChaK0KEwyQDdK4Kk9o+5XyR1fqAHcf0uy3
         wqsIuXAOOgUJNl8mhz8IIp1KqQYb84eAw9cdS19H7FSReJUakbyzIyHnTTYdLiE0mN6N
         RVLPeXbtEZ3Q73GKHECo/KW+ohKAgovbg+6r0V5HVTGWUHu7zt8Ioic12HvI8ew5K8h7
         hU340Y9/CzUbwqnd/y+5jPsJYDeY0CefDOmTmI2Llrpujuqu2rkpKVb3uZzYPbH1DR/p
         HiUl+jgumI0PpOKNGWr7BZLYmjPOw3S4UeFlnDtW/ERgoNKHcB2EWIrl15ozRYrgPL/L
         CmYA==
X-Gm-Message-State: AFqh2krSUf17hvYqlIsahiYCP1cdjXNRFaJEf7uwQmABnjKT6DQA4a/V
        DdRreHLlx9ix3Yl+IdjpntoX/sVmsvT61qis3ObEwsxCdWxzmeKv9k4=
X-Google-Smtp-Source: AMrXdXuWSqU9d0Naa73zgKXG+2bkUBzdDeP5cYxNUvvg/+0hbFt+UqGRN8bc84H09RnD47HVcWQGoACYey3s3j/RNXk=
X-Received: by 2002:ac8:5147:0:b0:3a5:6047:c75c with SMTP id
 h7-20020ac85147000000b003a56047c75cmr171489qtn.434.1671760941496; Thu, 22 Dec
 2022 18:02:21 -0800 (PST)
MIME-Version: 1.0
References: <Y6Kc650FuvHFWxP0@VM-66-53-centos> <20221222172504.GA1741501-robh@kernel.org>
 <2863440.ElGaqSPkdT@diego>
In-Reply-To: <2863440.ElGaqSPkdT@diego>
From:   ty <zonyitoo@gmail.com>
Date:   Fri, 23 Dec 2022 10:02:10 +0800
Message-ID: <CAMmci2VfvMoY9qZ5fjM7VkxBjTimx_Wps_5eMxS9GJsiTM9rkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add RK3566 LubanCat 1
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
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

Acknowledged. Fix will be in v8.

Heiko St=C3=BCbner <heiko@sntech.de> =E4=BA=8E2022=E5=B9=B412=E6=9C=8823=E6=
=97=A5=E5=91=A8=E4=BA=94 03:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Rob,
>
> Am Donnerstag, 22. Dezember 2022, 18:25:04 CET schrieb Rob Herring:
> > On Wed, Dec 21, 2022 at 01:43:07PM +0800, Yuteng Zhong wrote:
> > > LubanCat 1 is a Rockchip RK3566 SBC based
> > > is developed by EmbedFire Electronics Co., Ltd.
> > > Mini Linux Card Type Cheap Computer Development Board
> > > It has the following characteristics:
> > > - MicroSD card slot, onboard eMMC flash memory
> > > - 1GbE Realtek RTL8211F Ethernet Transceiver
> > > - 1 USB Type-C port (power and USB2.0 OTG)
> > > - 1 USB 3.0 Host port
> > > - 3 USB 2.0 Host ports
> > > - 1 HDMI
> > > - 1 infrared receiver
> > > - 1 MIPI DSI
> > > - 1 MIPI CSI
> > > - 1 x 4-section headphone jack
> > > - Mini PCIe socket (USB or PCIe)
> > > - 1 SIM Card slot
> > > - 1 SYS LED and 1 PWR LED
> > > - 40-pin GPIO expansion header
> > >
> > > Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> > > Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> >
> > DHDAXCW is a legal name?
> >
> > The person sending the patch email should be last.
>
> We're on v7 already [0] and at least the Authorship + separate binding
> issue got fixed meanwhile - haven't looked at the whitespace issue there =
yet.
>
>
> Heiko
>
>
> [0] https://lore.kernel.org/all/Y6MlrbGKiIVc6tXt@VM-66-53-centos/
>
> > > ---
> > >
> > > Changed in V2:
> > >   - Remove RNG node
> > > Changed in V3:
> > >   - Modify all node names
> > >
> > > ---
> > >  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
> >
> > Bindings should be separate patch.
> >
> > >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> > >  .../boot/dts/rockchip/rk3566-lubancat-1.dts   | 600 ++++++++++++++++=
++
> >
> > Fix all the whitespace errors checkpatch.pl complains about.
> >
>
>
>
>
