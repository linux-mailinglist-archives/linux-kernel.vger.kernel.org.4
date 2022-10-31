Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038D86141FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJaXwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJaXwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:52:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C71B6359;
        Mon, 31 Oct 2022 16:52:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c2so12097246plz.11;
        Mon, 31 Oct 2022 16:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=42AbG1h8Q807JEzTQryQyQ9tPqe9/mahuEB1baBD2AY=;
        b=PQ9VmZCEeFS001ML/ftJM2a+ZGORsh/gT/DeyU6McJhioai5BxxsVsB/p26iJJxm+F
         67buR21uq9P3TJlfD4H588hXJknwW9hNE+OwXwqcM7tfI3q2ZDFHpJYgKHqV55aXTKh9
         T9U21zMrcD9D+h8QZDmhWJ6XmLW1XcsYA9eGjiJUkhwx8zftukokB7vPsXPIN6hWGf2/
         BhNMoUA6XQugDvJTin/AwbDyPquZArmJEQViCzdjtk5ukNCcUYdiK5lSB/dOMFIePYw/
         BCrq/XlOsNsA4bxMec13/2vv/lg1Z+ZBxU9COBE83CM7xvk3nJaZFZb5/qDVZtdIDJCR
         5GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42AbG1h8Q807JEzTQryQyQ9tPqe9/mahuEB1baBD2AY=;
        b=qJ1wYvSYcXWYgPrKOCF1DP+vW3WTmf21U63XTYovwYZKXD5q+/nHZJnQnBkPwxiepx
         D+QhaOreSSO9+YxVDpf+PcPl9xvivBk1HnXQpT7cXUU19si/LseVRcCGKiokOS3Z64Jh
         qWxjK07NNk6LSz665cMJdm99Cy+Qeg+cpXI5oRKBPdxx4HP0MJH0KUNYBHAK8Z/q4wo4
         YpE84yBPXVG/203PHpn1+eaptVW+siRd898ZwmIJE0alY/x+0FufSz/Cmqvp4SwejUmG
         Pv5rtHmSUhJOvnNfcfDjdgxlaGe99bq5Qo8S9YDy5BpH26cVR+Whe0u0W9xVtcGXn09o
         UZzg==
X-Gm-Message-State: ACrzQf1KsTCrZNywdkAhNga7mRXLaxo0P1wphkD5Y0HTCxLQ8Vbx3JOg
        2QKW2hdni20UMYgxCMWmt/jC0gALqkM=
X-Google-Smtp-Source: AMsMyM6buq6tm3rfrpcHR9T3a0NkKhTf4Px/kWe+0WsvqcQdbJtE2i21xJKGvrcigAoEm/pE6RPayg==
X-Received: by 2002:a17:90a:ac03:b0:213:9515:c41f with SMTP id o3-20020a17090aac0300b002139515c41fmr20696394pjq.171.1667260337649;
        Mon, 31 Oct 2022 16:52:17 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902f38100b00176ab6a0d5fsm4987864ple.54.2022.10.31.16.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:52:17 -0700 (PDT)
Date:   Mon, 31 Oct 2022 16:52:13 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, shawnguo@kernel.org, rydberg@bitmath.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@bootlin.com>, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v10 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <Y2BfrUx9gzaNhb4I@google.com>
References: <20221026114908.191472-1-alistair@alistair23.me>
 <20221026114908.191472-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221026114908.191472-2-alistair@alistair23.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:49:05PM +1000, Alistair Francis wrote:
> This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> controllers. This driver supports only the I2C bus but it uses regmap
> so SPI support could be added later.
> The touchscreen can retrieve some defined zone that are handled as
> buttons (according to the hardware). That is why it handles
> button and multitouch events.
> 
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> Tested-by: Andreas Kemnade <andreas@kemnade.info> # Kobo Clara HD
> Tested-by: Peter Geis <pgwipeout@gmail.com>

While I wish we did not have to parse what is essentially HID data
ourselves and basically repeated what i2c-hid does, I understand that
the firmware is not exactly i2c-hid compatible...

Applied, thank you.

-- 
Dmitry
