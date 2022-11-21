Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201BF632581
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKUOV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiKUOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:21:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82607F4E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:21:22 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v1so20043736wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S7hedYyJck7S40GQNVuxUMsekgFy29NM0N0jYTBt/lM=;
        b=zVbmQbnSPh5H16h9TA+WCKAe67FLRAfwB9SbjuJQLmRhMZaY40M8NXjD+ynDdOD8uk
         V5PW8gdBQ8Q1hd9uS4z93YsdifIGHkCi0omA1OXvJVXWubhplJ/fLlAbmBYuxYPvO8pz
         Ngm8bcTs6xSz0J6d/Z5xF/EV+aorG92Di1O/s8NZo0OdtfHVN3CIrFODdxjLQybQjPr7
         hRiTamLmvlurx6D9VCjOQT5gQK90widvYMt19a+54pAn++DIFAF+wLysL3nx62VeRXO+
         Nx1fAT0J1ThVr2OuJfetqWr308CkfQH9lJVQefPLbgWAA1QS6JMhHfMGk6tglZ1YVR/2
         wapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7hedYyJck7S40GQNVuxUMsekgFy29NM0N0jYTBt/lM=;
        b=EKQMvE4qkq7vYjh9eNhEPcQDAc5s3xGeGCZ3fk8sk+eaEkwyTfi1mCQygaHjwB8VDG
         9l7DpeMbvowH4SyDde2N/6kEAvXsQehrystXF1PG9AznEhss3Cx8mu663l7fiHPSB1dQ
         6an3zv6PViHuO40hpAbUg5RtwM5vv3lmaKMegB7S8SSNvZX/5IHDzvEa3XoOru/QfcC2
         tZJ1//HA+t5bMaQGjr9gpYr29gAPAYZIpyaHimWPD8Z2vOSx/9BUz4kDoPW0DF2hiy1o
         J44yPvMoEZf37Cy6uoXkGjYJCZfXyNF9SC4wE0LPsVzZPrfF/kfqRGzZblHrID45y1a2
         GHmA==
X-Gm-Message-State: ANoB5pkgwn+V+mDYL73kB2Oks/KRIsL06ywjLSutJIOlGCHROs7uJ2Pv
        KizpoKPzeZIp4n9Kqvs8L1IJgg==
X-Google-Smtp-Source: AA0mqf7HNcjZmmNjuyl+rVD7pAZOe6rCi3/Rl+yaLwB8vV0U4AYPVEHQAjEy9ewuMpTgoErqo0YOCg==
X-Received: by 2002:a5d:538b:0:b0:241:c3c2:24cf with SMTP id d11-20020a5d538b000000b00241c3c224cfmr2708312wrv.587.1669040481041;
        Mon, 21 Nov 2022 06:21:21 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id c20-20020a7bc854000000b003b476cabf1csm13880142wml.26.2022.11.21.06.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:21:19 -0800 (PST)
Date:   Mon, 21 Nov 2022 16:21:18 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] usb: Add USB repeater generic framework
Message-ID: <Y3uJXlz0EOSyBzts@linaro.org>
References: <20221116123019.2753230-1-abel.vesa@linaro.org>
 <20221116123019.2753230-2-abel.vesa@linaro.org>
 <71ced60f-d43b-003a-843d-c2a8364dbf79@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71ced60f-d43b-003a-843d-c2a8364dbf79@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-18 09:59:43, Andrzej Pietrasiewicz wrote:
> Hi Abel,
> 
> W dniu 16.11.2022 o 13:30, Abel Vesa pisze:
> > With more SoCs moving towards eUSB2,
> 
> Can you name a few?

Right now, for SoCs, I can only name the SM8550 from Qualcomm. But I
would think there will be more from now on, not just from Qualcomm.

But I found a couple of more repeaters already existent. Like TUSB2E11
or TUSB2E22 from TI or PTN3222 from NXP. I'm not sure if they are used
already alongside any specific SoC though (yet).

Anyway, I can rephrase that.

> 
> such platforms will have to use
> > a USB 2.0 compliance repeater. This repeater HW-wise usually deals with
> > level shifting, but depending on the implementation it can do much more.
> > So add a ganeric USB framework that would allow either a generic PHY or
> > some USB host controller to control and get a repeater from a devicetree
> > phandle. This framework will further be used by platform specific
> > drivers to register the repeater and implement platform specific ops.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/usb/Kconfig             |   2 +
> >   drivers/usb/Makefile            |   2 +
> >   drivers/usb/repeater/Kconfig    |   9 ++
> >   drivers/usb/repeater/Makefile   |   6 +
> >   drivers/usb/repeater/repeater.c | 198 ++++++++++++++++++++++++++++++++
> >   include/linux/usb/repeater.h    |  78 +++++++++++++
> >   6 files changed, 295 insertions(+)
> >   create mode 100644 drivers/usb/repeater/Kconfig
> >   create mode 100644 drivers/usb/repeater/Makefile
> >   create mode 100644 drivers/usb/repeater/repeater.c
> >   create mode 100644 include/linux/usb/repeater.h
> > 
> 
> <snip>
> 
> > diff --git a/include/linux/usb/repeater.h b/include/linux/usb/repeater.h
> > new file mode 100644
> > index 000000000000..e68e0936f1e5
> > --- /dev/null
> > +++ b/include/linux/usb/repeater.h
> > @@ -0,0 +1,78 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * USB Repeater defines
> > + */
> > +
> > +#ifndef __LINUX_USB_REPEATER_H
> > +#define __LINUX_USB_REPEATER_H
> > +
> > +struct usb_repeater {
> > +	struct device		*dev;
> > +	const char		*label;
> > +	unsigned int		 flags;
> > +
> > +	struct list_head	head;
> 
> This member serves the purpose of a list _entry_, no?
> The _head_ is static LIST_HEAD(usb_repeater_list);
> Maybe call it "entry"?

Sure thing. Will do.

> 
> > +	int	(*reset)(struct usb_repeater *rptr, bool assert);
> > +	int	(*init)(struct usb_repeater *rptr);
> > +	int	(*power_on)(struct usb_repeater *rptr);
> > +	int	(*power_off)(struct usb_repeater *rptr);
> 
> Would you document these ops somehow? Potential driver writers need to
> understand when they are called and what they are supposed to do.
> In particular, how do these relate to what's in "Embedded USB2 (eUSB2)
> Physical Layer Supplement to the USB Revision 2.0 Specification"?

Yes. Will document them appropriately.

> 
> Regards,
> 
> Andrzej

Thanks,
Abel

