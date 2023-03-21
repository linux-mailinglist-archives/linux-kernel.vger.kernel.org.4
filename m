Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F796C32C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCUNXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjCUNXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:23:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19193864B;
        Tue, 21 Mar 2023 06:23:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so59546160edb.11;
        Tue, 21 Mar 2023 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679404973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95jB37W+Wt7W/+ldLKpORAVr9HfgXS4BPAALdeLbJdg=;
        b=fzYEIl6fRiC0BWjmJNgLzHfeuD+QCTuUv8RltsdJwTFQWTKKWO1QHUp/kASlyWpXUo
         7peTnvoe/ouMjNlFPOwGNgY1bzgO1z/4lD9dBXlw1aF0U0zJr+zc7Oa/K1GeblUqarnN
         HIN/XBo1hEHtE8PdJuN45q9HzoT1/OEPNnE/ee5LioNIrwnt/Hj3Bm+8wzKWOtk0nv5b
         L12dUN8nMSe9lomY/BCxT/bQQzdGZNvfUmsCXKCe2vHgs/BL3vfCfBwaSfZ+CvM/IcNx
         Z11gqU3OcJcmJw2Jf4PBSq0vq3GZ48b5wN96HgwqYAG2w5oWM4kDNPVUM4xtYWC5wu5g
         1DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95jB37W+Wt7W/+ldLKpORAVr9HfgXS4BPAALdeLbJdg=;
        b=bnwk0hxS+qB9arCr/EABWoDnnjDfIJSe0uLj44VRRVNSkCa4g8nGCzGh/Li0B85ZbK
         H+BvfJt4T1t6eeuGfX8N1lXf3hl3zzDgLo0M+HzOPbPJPnSakegEfM1lGgPDIe6XGiF3
         RCqkKEw2wNn+nH0STrc3zQHFDriL+j9oDc7Yzdp0AVE23elg0xpupCKuypgjYlIEw6mW
         yHsrHDUJZ1wZR3++QWLuKpoSk1lwigZRTYTAr5hOr04iCHfUgi8mBIU3Q6sYobHijkG8
         ne3EbLEfaeFgQwaopa8dkYmfOM1UndjfonngH+n+KtZHr5FJNzh8I3gJDOb8RniLHRXL
         Ez5Q==
X-Gm-Message-State: AO0yUKU0x/8j+ZqwHl8SA6hWqnvURUSTZbgGqUsjVBg9FYFfgYWswFQC
        lITlJSd4iN2g47SriblEGW4=
X-Google-Smtp-Source: AK7set/yBMFiJZcYGsdXXkw3Ov2pa5amRx41c5TZ7yO23RqWdCeWLmQnq8Q9dj8T8OpnH9v/s0Q37A==
X-Received: by 2002:aa7:cfce:0:b0:4be:b39b:ea8f with SMTP id r14-20020aa7cfce000000b004beb39bea8fmr3207404edy.2.1679404973570;
        Tue, 21 Mar 2023 06:22:53 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::a9c0])
        by smtp.gmail.com with ESMTPSA id a27-20020a509b5b000000b00501dd53dbfbsm813718edj.75.2023.03.21.06.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 06:22:53 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:22:51 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: Add KX132 accelerometer
Message-ID: <ZBmvqytRamzmf908@carbian>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <d677b957164930c3d2fee900117795b25b85c3fa.1679009443.git.mehdi.djait.k@gmail.com>
 <20230319155451.0207118a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319155451.0207118a@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On Sun, Mar 19, 2023 at 03:54:51PM +0000, Jonathan Cameron wrote:
> On Fri, 17 Mar 2023 00:48:35 +0100
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
> > Extend the kionix,kx022a.yaml file to support the
> > kx132 device
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> 
> Pins and power supplies etc all look the same to me so indeed seems that
> you have covered all that is needed.  One small comment inline
> and I think Matti's point about more specific compatibles probably
> needs to be taken into account if there are known variants.
> 
> Kionix has done this for a long time. I remember that fun with the
> kxsd9 lots of years back - that had lots of subtle variants.
> 
> > ---
> >  .../bindings/iio/accel/kionix,kx022a.yaml           | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> > index 986df1a6ff0a..ac1e27402d5e 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> > @@ -4,19 +4,22 @@
> >  $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: ROHM/Kionix KX022A Accelerometer
> > +title: ROHM/Kionix KX022A and KX132 Accelerometers
> >  
> >  maintainers:
> >    - Matti Vaittinen <mazziesaccount@gmail.com>
> >  
> >  description: |
> > -  KX022A is a 3-axis accelerometer supporting +/- 2G, 4G, 8G and 16G ranges,
> > -  output data-rates from 0.78Hz to 1600Hz and a hardware-fifo buffering.
> > -  KX022A can be accessed either via I2C or SPI.
> > +  KX022A and KX132 are 3-axis accelerometers supporting +/- 2G, 4G, 8G and
> > +  16G ranges, output data-rates from 0.78Hz to 1600Hz and a hardware-fifo
> 
> This may be one of those 'there are many versions' of the chip issues, but
> the random datasheet I got via digikey (kionix website was slow and I'm
> impatient) has max as 25600Hz for the KX132-1211.
> 
> No particular reason the sampling rates need to be in this description so
> if they are different I'd just remove the mention or just say
> "variable output data-rates"

Yes indeed, the max frequency is different and the max frequency
supported in the driver is 200Hz anyway.

Removing the values of samling rates is best here. I will change it in v2.

--
Kind Regards
Mehdi Djait
