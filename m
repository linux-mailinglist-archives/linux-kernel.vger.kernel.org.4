Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606B2657548
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiL1K2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL1K2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:28:51 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94760DDC;
        Wed, 28 Dec 2022 02:28:50 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z7so10501713ljq.12;
        Wed, 28 Dec 2022 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obzcIZrPBcMi7ShQb13ZL0q1RQ4T0u55kQZ0VFg/JY4=;
        b=KbQDQw/BWXuLZmZFqsC8OtgWM8mzQptLBUvsH/0GVGoOm8NnWnAt2IlrfID0pDBNag
         Go1V/6/H/qNeqGmhfpQWyTHZzIIikwDLGOGudcDnQKZUmYNTAONudKu1vU59i4xwKXTT
         XUwEIG5fVpVudwEvH+Y8jZfpr6HO6Va0BKc1OubFIsnZT/MU6KTMKgkxGrgTWwN8OdoL
         Bp/fT4BAXy4aHt1BlNDOu+LgMfoefMZzetJX92heaMbRWiQB5Lh6ABC9o74bu06lCgRS
         Jg0DHfDng2yKWkJzBpYa1/GQugv5pxMBwrt+RsupWIKIQW3h92fgheZC9rU71Cr9OQaR
         sEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obzcIZrPBcMi7ShQb13ZL0q1RQ4T0u55kQZ0VFg/JY4=;
        b=h6h6f5cQm0g26TOgmADRgmpqN/B9V0LSmD8XLSocw1FmLaHpX6Tyc+U+5Wrc1ht+rW
         rD93/1+9OA/UDpD0Y++d2+6DHpXuNPicYwugM+2rqdIqM/rubXehU+rHbkRQzOQqmn1b
         6zvFgsnF0KB7v8yllrf88iHOF4kronPTcqJwhH9SC03gv8N2S04iBu4FB9ak5rDQ6VcF
         O/V7/gxYE44RpFS3oXX5wRKEedC0xptmaUhV1Z2hHbBc0tYYvQVjztvZJvvIo6EbO90t
         1czml9UumI704ixYBd2ox3hSkySr8iNhdnoZbk/eDHFIc9MADRVpl1aiqC4eCppRr+Kc
         JpOw==
X-Gm-Message-State: AFqh2kruxx7mJ2h9p9dFFP8Pq/I7qSsngj8VsvfarK13bYjHIo4cKTIL
        +ZNWyfYLVF9b8hG5HyPgVvYJJBeeK5D94ynAHLo=
X-Google-Smtp-Source: AMrXdXvGEyE83sio/SHXCyn7DrvvnVmZ24trWORXVtB7P5tU/OiUh0KoumdJvsdD6FjF4GkSLqSSqg==
X-Received: by 2002:a05:651c:b0c:b0:27f:7190:5ae3 with SMTP id b12-20020a05651c0b0c00b0027f71905ae3mr7890670ljr.11.1672223328635;
        Wed, 28 Dec 2022 02:28:48 -0800 (PST)
Received: from tp440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id w27-20020a05651c119b00b0027fc849e1cbsm537844ljo.94.2022.12.28.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:28:48 -0800 (PST)
Date:   Wed, 28 Dec 2022 12:28:38 +0200
From:   Sicelo <absicsz@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony@atomide.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: n900: switch accelerometer to iio driver
Message-ID: <Y6waVkobLCGqRHm7@tp440p.steeds.sam>
References: <20221227223841.2990847-1-absicsz@gmail.com>
 <20221227223841.2990847-2-absicsz@gmail.com>
 <73599d25-cd2c-e89a-20b4-d34471583a6b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73599d25-cd2c-e89a-20b4-d34471583a6b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the review.

> > +	lis302dl: lis302dl@1d {
> 
> That's not really explained in commit msg and does not look related to
> your goal. If changing - in separate patch - make the node name generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
 
Now I understand that it should just be `accelerometer@1d`. To be clear,
are you saying this change should have a separate patch, i.e. not part
of the switch to iio driver?

> > -		Vdd-supply = <&vaux1>;
> > -		Vdd_IO-supply = <&vio>;
> > +		vdd-supply = <&vaux1>;
> > +		vddio-supply = <&vio>;
> 
> Does not look related/explained in commit msg.

This is from Documentation/devicetree/bindings/iio/st,st-sensors.yaml,
i.e. lowercase. I will look for a way to explain it in v2.

Sincerely
Sicelo
