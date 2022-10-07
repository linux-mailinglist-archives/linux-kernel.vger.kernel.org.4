Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832335F7288
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 03:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiJGB25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 21:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiJGB2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 21:28:54 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EDFABF30;
        Thu,  6 Oct 2022 18:28:53 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id h6so2137630qkl.11;
        Thu, 06 Oct 2022 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/GnsvYzCny+dmNEkGgCTHzZXDk1Ni5cyCk/C+scny4=;
        b=IvwFqG6QTISSBPWrff3K0Yby7ayx52bqFJHGFO//qR4HBeOA1JXm4BWw+7SmmPlDo3
         b34Dpjuq1Q5wy10h6jHJZRpcPCJqvsQAmmRHgZ7BiFJcf7F8KWCYPtowKste1uSmcKrJ
         upUcDf3MhctPe9CQie5bXHVfFsCJFeVGNNQ/ztZMg2ImXo/+PxmU79m+hTNsvrSr8Hsz
         QPt7D4Cq6Qfo73/vthAyqsDvqtfX0XWUwzZS89OXGOwLuuzTz9EqHhnhYkEX3RDMLxaL
         7z2/voo8CugkZXPLKdyNMRIDzoIFoUjHysv9jlrZXUWEybuyQtbtekjc9VKCtnAo1ZLB
         MDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/GnsvYzCny+dmNEkGgCTHzZXDk1Ni5cyCk/C+scny4=;
        b=jYnIDdRiCOVI+wZqk3vVj6tTc2HB/4e+/cmXF6jrMrxlZot9L8YyCcoGIOJNMrdHM7
         pj4ZAsp39ryJz+0bRZOS6mJ3FjKadLR/Pd1tkE/3me+cQub6TQAV70EpJdx88fugkSkl
         x8HsgUw5QlznUKxOvIlZyXrsB9IOpJ46KMQtN1WT0thDawyI1NMDPfcUykdIaCVNoDQ6
         NcKFShgvoBbJj/JvWUFyemnS4JyVb1h75L4G8P5prmG45XWpCE7hEt6ORIzdKHSLzDul
         DwOibSobZGRHwaYowwqrVlWSZhJL1OhysycGnkcE8diSu9+bp5u5LBezzQshLGchIkOH
         1aJQ==
X-Gm-Message-State: ACrzQf1caoQXL2SE7cvfKVWaPuNt75zq4mhkVP88lGnRY6igFQo/xI4S
        ravYLMTiMSeV/oeb0tqvrVjdQ7JKEX6ZK/lo8GGgHZfYhUN0KA==
X-Google-Smtp-Source: AMsMyM5+Qt0mAKsm6JZ0FNZOg7WcADIEReJ8PsguLHKw330lri9d1l77gvVWvXsGj3Sle/+oqHSPJhUiyjkUSjttX0Q=
X-Received: by 2002:a05:620a:3720:b0:6dd:beba:b3a1 with SMTP id
 de32-20020a05620a372000b006ddbebab3a1mr2262149qkb.138.1665106133111; Thu, 06
 Oct 2022 18:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1664991040.git.chiaen_wu@richtek.com> <1bcd19dbd09650ddac7b96b0fe2932698be2731e.1664991040.git.chiaen_wu@richtek.com>
 <Yz11bkxz9lK4wOHE@smile.fi.intel.com>
In-Reply-To: <Yz11bkxz9lK4wOHE@smile.fi.intel.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 7 Oct 2022 09:28:17 +0800
Message-ID: <CABtFH5J2r=Qq1kNb=yp6Hf7=oKJH9qeiwsO+4ejy5m9N+ZODXg@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, szunichen@gmail.com
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

On Wed, Oct 5, 2022 at 8:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

...

> > +config LEDS_MT6370_FLASH
> > +     tristate "Flash LED Support for MediaTek MT6370 PMIC"
>
> > +     depends on LEDS_CLASS && OF
>
> Why do you have OF dependency?
>

Hi Andy,
The original idea is to use the "fwnode_property_*" related function.
But this side may only consider just "Build Pass" (?)
I will remove "OF" in the v14 patch.
Thanks for your review.

-- 
Best Regards,
ChiaEn Wu
