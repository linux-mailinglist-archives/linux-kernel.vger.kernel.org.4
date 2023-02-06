Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD61968C026
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBFOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjBFOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:33:31 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B62364B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:33:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m2so34726547ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHaeRZqGHYAtIxM6Dz50lpu040N8lRz141Rm2pL5rVo=;
        b=jF1s45DfufJwWZ57OB4BhZN/fdCEcCANg5872Lpc2HV2Ir2Mncxbo/xAhZJfUnR3L+
         zj/iqQibSO2essYu11V5ZoaCOO1G8tKqVEw+x1gL3ETrubdC6B68mNHS4+lJGYXSzrXu
         orW5CjFvL/UrHYWJjZ8cV+5pZ+/s8jq4GoMsOmhkPKIWkNXm0D6Gnilexls3a7htxx6D
         /25skRRaDV+Gz0xrN/fO6uxRvlSPOWnSXL06w/EXUgmzB9QU+iA7gSZAByL4V9Z/WFL3
         g4urT34lwmdyWPzF1tFaoARTuuhrRNCW3FK5ZrJQXnjAxjvMTBeUgl7MN1sDOzeoiag9
         IQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHaeRZqGHYAtIxM6Dz50lpu040N8lRz141Rm2pL5rVo=;
        b=r16HPIV9NHUab3JjqcIjxrsYJ5GtmhfY8VKlGjZlMivyuZ9a2PYfYfXW9mvB2WwbV4
         sVKoTzN3VBHpY3p4JKHt2Mn8xlBU3uMThovrzrjpD2agOKqZ6cnodLokdgR+E676/45g
         sgKYOMOWpuHEMiYJLyYsYc3pseRX5aY13DK18UYmh42GIcIPLu1164GylSk2NB7Wx/VK
         U7e2r5Sm95MGDNU1OIhVaPYwNUX5X0ByYsaQhFCanDjODMoUGZZAnXVTh1ly1SRBopTc
         ZLB6deHAkmpc4sMXoTo1ZzRuA/7eLxHR1ymsW+y7XixjWwqtThwSXGrpZpZF/rqdM5DK
         trCQ==
X-Gm-Message-State: AO0yUKWjQijFhIb6f4VYUFdCHMxNYLSoJS/r+bRaAW74M3fRjFOcZECs
        mPNnKXw0wCggK9ob9IBUM6OJ6rjZSR655IbcC/f0fg==
X-Google-Smtp-Source: AK7set9F4u722OkpXBvTbwVo7eCQ7QLvmQTwkMqIg2LACU7M2aYX2ATRDdPXXoHFDCXc6U7xCq0cgsgND0rwHzgdHtY=
X-Received: by 2002:a17:906:1803:b0:7c0:f45e:22ff with SMTP id
 v3-20020a170906180300b007c0f45e22ffmr6633853eje.104.1675694007671; Mon, 06
 Feb 2023 06:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-5-bchihi@baylibre.com> <20230131153816.21709-1-bchihi@baylibre.com>
 <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org> <20230206140713.GB15176@linaro.org>
In-Reply-To: <20230206140713.GB15176@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Mon, 6 Feb 2023 15:32:51 +0100
Message-ID: <CAGuA+oo2Zzb2=v6DDwy5R2Y_u_jvpbbAUZDeKssKe9Af14fo8w@mail.gmail.com>
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Feb 6, 2023 at 3:07 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On Wed, Feb 01, 2023 at 08:55:07AM +0100, Krzysztof Kozlowski wrote:
> > On 31/01/2023 16:38, bchihi@baylibre.com wrote:
> > > From: Balsam CHIHI <bchihi@baylibre.com>
> > >
> > > The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
> > > controllers contained in a thermal domain.
> > >
> > > A thermal domains can be the MCU or the AP.
> > >
> > > Each thermal domains contain up to seven controllers, each thermal
> > > controller handle up to four thermal sensors.
> > >
> > > The LVTS has two Finite State Machines (FSM), one to handle the
> > > functionin temperatures range like hot or cold temperature and another
> > > one to handle monitoring trip point. The FSM notifies via interrupts
> > > when a trip point is crossed.
> > >
> >
> > (...)
> >
> > > +
> > > +struct lvts_domain {
> > > +   struct lvts_ctrl *lvts_ctrl;
> > > +   struct reset_control *reset;
> > > +   struct clk *clk;
> > > +   int num_lvts_ctrl;
> > > +   void __iomem *base;
> > > +   size_t calib_len;
> > > +   u8 *calib;
> > > +};
> > > +
> > > +#ifdef CONFIG_MTK_LVTS_THERMAL_DEBUGFS
> > > +
> > > +static struct dentry *root;
> >
> > How do you handle two instances of driver?
>
> For now, we can put the entry in /sys/kernel/debug/<dev_name>

Yes, sure.
I will do the necessary changes.

>
> I'm preparing a debugfs series for the thermal framework and that will provide
> an entry to hook in for the sensors debugfs if available

It would be a good feature!
good luck!


Best regards,
Balsam.
