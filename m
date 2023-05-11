Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A266FFD71
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbjEKXoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbjEKXoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:44:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF30618E;
        Thu, 11 May 2023 16:44:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so1873640b3a.0;
        Thu, 11 May 2023 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683848653; x=1686440653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18inJAfZaaCjkmT/TfMQ+71j6QtEo1Rk/unRTNBLoVE=;
        b=cUqc8UGQ8fqvCcOZic5D+5ntXzn3rmbpJzEJZ6a3JRpJ3gHxZbGT5tCIABwA/FRThK
         BfMcxlTtkj1PdwHtWu63/+wtLcuToXDQujcrjeF8yV+Pd9hePKU5tpwq0Ew6rpLRBiCT
         LJuJ8HF1UYu+y8wgQVArw0PojhNfaz+r2A/lVvfS24gtiSipEJNQoGQYTcoIR6eCkJEZ
         bQRSJEY39maorYO2RyEtDhWT/nL2I6TMRypFR9K7Na0rsK9/HpFJzg0FHgati2nHFlIL
         fJYmoA3kmKws7zVd2cMRqq4Jo8Pe/bao5HlZUh370dKHQsyRZTdgWwjVXDzdgDwB55YJ
         U7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683848653; x=1686440653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18inJAfZaaCjkmT/TfMQ+71j6QtEo1Rk/unRTNBLoVE=;
        b=G2zlT/T2bIIh20L4bmEUGKWqQAbZ8t7tV2vkoH8/jUDgD2fmWxh/6SVU6yY+cO/QUR
         AB9lLvwBx8BKqHgUDsV+lj6pjw5KUAmUI4brMgUNKQ/mKFNI0RuGavRtBvPRnfTP29X0
         LI1t7+j/0y9Kf5jJEqMuCXDaE31juis9t5wGI2g5N8D3fSDNH44awrFhJ3ru6aoqh7kb
         0xyFUlsT2qZegzT85OiWoCSUMR8VV3y7fYdFbgJo3JXgzK1GJtBBWqYLRAkTpWgIcVMV
         QXYpanLd0QXbOFwPzLWMVlPQ+FecXqOihp/SNlQvm+sVzPRvnB/nscXGzbxoy6XMqo6A
         xXDQ==
X-Gm-Message-State: AC+VfDyq1cIkbnaqmqc/OtgJQE9h4wgs3LADVLiO/Uoa19/6mZPBCUHO
        /vTkA17ge8FjPWr9UqY1n5d/5ma6fj4=
X-Google-Smtp-Source: ACHHUZ455lyPD+IZanZEzNs7bCf1nFg1YHHnWTcIjNzqTlLuR0VFcr5T8rPNTyDs25381YWhT9l7nw==
X-Received: by 2002:a17:902:d2c9:b0:1ac:7245:ba55 with SMTP id n9-20020a170902d2c900b001ac7245ba55mr18012957plc.6.1683848652443;
        Thu, 11 May 2023 16:44:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:53f7:c9da:338e:6206])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709027fc400b001a95c743ca2sm6571696plb.94.2023.05.11.16.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:44:11 -0700 (PDT)
Date:   Thu, 11 May 2023 16:44:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Tomas Mudrunka <tomas.mudrunka@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZF19yOojiaSbo3vS@google.com>
References: <CAH2-hcJYVpBNwnMS6qUp4=MW8kSryDAz7G5cNA8R00QabC9bjg@mail.gmail.com>
 <20230503153231.1136114-1-tomas.mudrunka@gmail.com>
 <ZFMN5nmqLAX170SE@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFMN5nmqLAX170SE@nixie71>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 08:44:06PM -0500, Jeff LaBundy wrote:
> Hi Tomas,
> 
> On Wed, May 03, 2023 at 05:32:31PM +0200, Tomas Mudrunka wrote:
> > LM8333 uses gpio interrupt line which is triggered by falling edge.
> > When button is pressed before driver is loaded,
> > driver will miss the edge and never respond again.
> > To fix this we run the interrupt handler before registering IRQ
> > to clear the interrupt via i2c command.
> > 
> > Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> > ---
> 
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> 
> >  drivers/input/keyboard/lm8333.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
> > index 7457c3220..52108c370 100644
> > --- a/drivers/input/keyboard/lm8333.c
> > +++ b/drivers/input/keyboard/lm8333.c
> > @@ -178,6 +178,8 @@ static int lm8333_probe(struct i2c_client *client)
> >  			dev_warn(&client->dev, "Unable to set active time\n");
> >  	}
> >  
> > +	lm8333_irq_thread(client->irq, lm8333);

So this is still racy, isn't it? The interrupt may come after read is
done, but before we register the handler.

> > +
> >  	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
> >  				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >  				   "lm8333", lm8333);
> > -- 
> > 2.40.1
> 

Thanks.

-- 
Dmitry
