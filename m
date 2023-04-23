Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9466EC25B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDWU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 16:59:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69113F7;
        Sun, 23 Apr 2023 13:59:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so6488907a12.2;
        Sun, 23 Apr 2023 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682283584; x=1684875584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vTeaFUMPzt83wxw5ZIyQFWx3FUsV665nSPOBgniATUI=;
        b=kIP31mG0ih0F62/A0CEv78gRcICVKmeP1LaexXbntP364uK/kzVy1+lmAST/JPZh4D
         uWhZJ+Ls2q7kVaJqQPZ6SFs3a6+pHuSzBE7vfaZPapQ1V3tn7JbVpEgHPnykjLhmUllH
         jmojYInhQ3NLIxFJK2FXnNtbpIl3wG6KO0Ft2BCya1OZpF17yqfxLUb4hPWh45u8qIU7
         lrVCSkyi3Fr33XGcNFd2ndRVtWgOH4sae63kEsMgIHiHCL6u/qFahs5jL1/peikwZSSB
         Lber1L+eo6TMk2uITrt3AzrwLnc6SWa8sLaX/A2hOQXk6SDDSHAtOuZp8BvJYJf4Fe/k
         o6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682283584; x=1684875584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTeaFUMPzt83wxw5ZIyQFWx3FUsV665nSPOBgniATUI=;
        b=U8s/AsHpyFYG+znMdL6HCFBTzp0MYfoDkPQWFvEhd2LRhfqRr2H1q1kvQojncIAYfG
         9z4gdDol4RNE147Y74cX3RmkFc8FkMH0FpDnUAnE/ea31A5WAOE8MMAr8oZsM3Rb68TR
         75btWQVC3iZAhUKWkedHARH+gTyQDZSVZH0icmqi2nmDaYvRlA+JhT82An37bOMkZRjj
         AhCr/PlCFKUaNzeKn1bPJzUzO+jiF60NQ19TzbrCMXZLFDbM9GdbUMiGzZLthhCJ0Oij
         x38ylURng8fuxY7NziehprRYLRdO7lrjeaIhN4+Tw6u9wJy6YfLXn+c7XMLSsXqPPlVy
         ubqw==
X-Gm-Message-State: AAQBX9c5BxfFCzYG/malKtAGoYk9zHScSGDKF4yriePJ5DqirlTx/mms
        K4lTZK+niX36D2Sic5ZQ464=
X-Google-Smtp-Source: AKy350ZLva5XbFvzjazIS59Msv3QLlHrXXGQt9Xm0N5bHyyyHkxs4fxmCMrekbD0SJPmqgy/q4Iy4Q==
X-Received: by 2002:aa7:c902:0:b0:506:a561:b0a9 with SMTP id b2-20020aa7c902000000b00506a561b0a9mr10505241edt.14.1682283583630;
        Sun, 23 Apr 2023 13:59:43 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fb0c000000b004bf999f8e57sm3938834edq.19.2023.04.23.13.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 13:59:42 -0700 (PDT)
Date:   Sun, 23 Apr 2023 22:59:40 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: accel: kionix-kx022a: Warn on failed matches
 and assume compatibility
Message-ID: <ZEWcPJYfOK7LNq1S@carbian>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <b6cb3d48ab9e4177b924b18e27487f8ef763dfd6.1682019544.git.mehdi.djait.k@gmail.com>
 <20230422182833.7fbf6aae@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422182833.7fbf6aae@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan,

On Sat, Apr 22, 2023 at 06:28:33PM +0100, Jonathan Cameron wrote:
> On Thu, 20 Apr 2023 22:22:02 +0200
> Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> 
> > Avoid error returns on a failure to match and instead just warn with
> > assumption that we have a correct dt-binding telling us that
> > some new device with a different ID is backwards compatible.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > ---
> > v2:
> > - no changes, this patch is introduced in the v2
> > 
> >  drivers/iio/accel/kionix-kx022a.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > index f98393d74666..70530005cad3 100644
> > --- a/drivers/iio/accel/kionix-kx022a.c
> > +++ b/drivers/iio/accel/kionix-kx022a.c
> > @@ -1038,9 +1038,7 @@ int kx022a_probe_internal(struct device *dev)
> >  		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> >  
> >  	if (chip_id != KX022A_ID) {
> > -		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> > -		return -EINVAL;
> > -	}
> > +		dev_warn(dev, "unsupported device 0x%x\n", chip_id);
> 
> Try building this ;)  You have remove the closing bracket but kept the opening
> one.

Oops! I will fix this :)

--
Kind Regards
Mehdi Djait
