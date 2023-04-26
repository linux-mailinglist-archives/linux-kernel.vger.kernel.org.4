Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E766EFDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDZXQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbjDZXQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:16:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79EA30DA;
        Wed, 26 Apr 2023 16:16:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115eef620so865411b3a.1;
        Wed, 26 Apr 2023 16:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682550965; x=1685142965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmZe4XQJ0YjP7cw54uBUO68nCbJ9qNgc+ctEcUOTuDs=;
        b=RHERRUh1+lK0ociFRpJqgqwyeNOtTDg9+ksYO4pn+050hYcMe9qMLFxAMUavAyTG3j
         KTG++bzIwXJeEg5vksXpcOspRhvqhS4zkgL+8GzrpYw7lL1ZRywrOiJI2Eyhf5Ahmy3d
         ckvcPiMPkXaJs+6hbSiKLVuAK0W3gf3391IgTNNxKdOGiKfn1iBf5ZdOVR8N8DvTG5Mf
         vwX0nsQS5VlFezaFPEcGpyq47ye7DrwStNVVz/BMjpaIxSfAs9eC90PG0XNkhJM4eG/y
         JHRRBgyzsYUruP57UEMe9sc8Vf9Wa+R/enDK9DsHJgsMc8bg3ln471M+qlosVawtc/ka
         0QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682550965; x=1685142965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmZe4XQJ0YjP7cw54uBUO68nCbJ9qNgc+ctEcUOTuDs=;
        b=GkFUl4j7PUnz/o6IqSnTLrKtc/sBjmEM+hqnQAu9rCil684y7VZRtUVGmPw+j4HO/a
         P4bxHxctbx/+EsIJPzL1SJTqRAo7my1nTZlgpj4NaQi6+PoyRoRz6yeVdgF6+u/c5N+o
         Qd5opHvRAAxlECVnGL8VrqpjiFJfuWo38EddgkEoDVpMqd1ES5X+MQ3LbVSAqM/9Sj/O
         Husrg8BL5t4RFRNgITKiRVAsA1kl1HKcxCWU2TVDUmLrrQOD+U60XklNoc2cirlI38aF
         AHOXZv0rR7dh0YYwJcfLs5uyp3Jkpo83LrRMv9kYkiqdWa9dwpoS4s7UDdAZpGuyubsw
         xE7Q==
X-Gm-Message-State: AC+VfDwPae2QNYs9J+xvLknqqHmTlHPTf9G0GoRkXVJ5UI0wCMnXZkRI
        gZmBcRF8dTNIvqmaZqOtEl69MqybfUY=
X-Google-Smtp-Source: ACHHUZ7PG7OCVBC8tva2mrwPsZE1pPlfMOdjpYZkTBapPTz3o9o9TTEBt9g8DRlwTx66VrM056By8w==
X-Received: by 2002:a17:902:f688:b0:1a6:4c2b:9e7f with SMTP id l8-20020a170902f68800b001a64c2b9e7fmr4792217plg.1.1682550965206;
        Wed, 26 Apr 2023 16:16:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f84b:79ee:8ff:d568])
        by smtp.gmail.com with ESMTPSA id bv21-20020a17090af19500b002465e66256asm10300282pjb.11.2023.04.26.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 16:16:04 -0700 (PDT)
Date:   Wed, 26 Apr 2023 16:16:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZEmwsViIjUVPZ4Cd@google.com>
References: <20230425130054.591007-1-tomas.mudrunka@gmail.com>
 <ZEf0RYdD5jhE9JEk@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEf0RYdD5jhE9JEk@nixie71>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff, Tomas,

On Tue, Apr 25, 2023 at 10:39:49AM -0500, Jeff LaBundy wrote:
> Hi Tomas,
> 
> On Tue, Apr 25, 2023 at 03:00:53PM +0200, Tomas Mudrunka wrote:
> > LM8333 uses gpio interrupt line which is active-low.
> > When interrupt is set to FALLING edge and button is pressed
> > before driver loads, driver will miss the edge and never respond.
> > To fix this we handle ONESHOT LOW interrupt rather than edge.
> > 
> > Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> > ---
> >  drivers/input/keyboard/lm8333.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> > index 7457c3220..c5770ebb2 100644
> > --- a/drivers/input/keyboard/lm8333.c
> > +++ b/drivers/input/keyboard/lm8333.c
> > @@ -179,7 +179,7 @@ static int lm8333_probe(struct i2c_client *client)
> >  	}
> >  
> >  	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
> > -				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >  				   "lm8333", lm8333);
> >  	if (err)
> >  		goto free_mem;
> 
> Thanks for the patch, but this is a NAK in my opinion.
> 
> First of all, we should not be hard-coding interrupt polarity in the
> first place; that is an existing piece of technical debt in this driver.

Yes, I wonder if the original hardware was limited to the edge
interrupts.

> 
> Second, changing from edge-triggered to level-triggered interrupts runs
> the risk of creating an interrupt storm depending on the time it takes
> the device to deassert the irq following the I2C read and the point at
> which the threaded handler returns. Have you measured this?

IRQF_ONESHOT ensures that the level interrupt is unmasked only when the
threaded handler returns.

> 
> Can we not simply read the interrupt status registers once at start-up
> to clear any pending status? This is essentially what your change does
> anyway, albeit indirectly.
> 

Thanks.

-- 
Dmitry
