Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE606EC25F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 23:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDWVCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWVCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 17:02:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97811C;
        Sun, 23 Apr 2023 14:02:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94eee951c70so549525466b.3;
        Sun, 23 Apr 2023 14:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682283722; x=1684875722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQGZByzNwTNHNZDulx2ynpAjg2TN652dzcztwDEhLDY=;
        b=N6vcVe5JMgZk+mcR9rGRaoW8sBPGvj/go9Gq+j6xvO/lb8KPQQA0DOmRCBmdLtTOzM
         cb0y4b9cnJ3p6+Sa7JgMTJpu+tUrKzIv7kbqDiE93kxi9FwGGgR/kwKKoFAfYrIHL986
         1K4YmYJs2WWw8HEftklX8+PfCm6NqUe26NTbPZRmPiG9PWkTxN7yVWJ+TE8sDYsobOMP
         DF4AeUKaOnNY2gkPVPTbE6lY0hDqeHuFFz6dJiPGQ9lSgeeZLyCVMu+qGAiH0WKQC5E8
         P5rWQgJNiFAlhK0FYkLYWoElaDA2v/mslOZ+KY+zjNQMsX44PQbEttK/LjOhOFQDN0WI
         Q3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682283722; x=1684875722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQGZByzNwTNHNZDulx2ynpAjg2TN652dzcztwDEhLDY=;
        b=h71m+jnpvYlGvtbO4F+bYhXW1LIFAK+CuYBqX+6J8XlPsw1dNkk94nHBR6Zmy6ohDk
         KiaU6/50QxecypW6pkUvTRUc2th5zkhwNGprMz/Hu6SUCAfRTJsRXP2pwh2yDshfBFqn
         YDQhXSHarjCISyKOquKpGqxxy/BUCjtoZvhDaLHaeQmx8xZOm6EvqISNhzShRkxTA3CO
         tOW4TwJFls1XG7Eg/96IP6nsoBTfUOaGdKlUV8aURixqNz4GuxYYpOH0h1CTi930llNa
         RPa+DDONX+d3WFv4fUWSsyndsDOChnzYHoSeXUnsSNt8I4AW4dS+oyh1PxilW0cG8Q7u
         llIA==
X-Gm-Message-State: AAQBX9dZXhOCtOpGeD1NQmQOCqHneUSsDaddj8ixm/Fa3Ncv/lwMSueb
        PCn4IwmR7DCXoLkRSdaiSY4=
X-Google-Smtp-Source: AKy350ZyyvX18X7jpfRoCdltMyhN9uSRt6N8acooo90hc7tw+DE/QBtp6aBAKadmqw8MVDMdriET2A==
X-Received: by 2002:a17:906:111:b0:947:ebd5:c798 with SMTP id 17-20020a170906011100b00947ebd5c798mr10169688eje.54.1682283721554;
        Sun, 23 Apr 2023 14:02:01 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id ec17-20020a170906b6d100b0094f6bf5ac9asm4754583ejb.22.2023.04.23.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 14:02:00 -0700 (PDT)
Date:   Sun, 23 Apr 2023 23:01:59 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZEWcx9lQXFY/CkNp@carbian>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <e0b599e3f1d1fe0c68e4e0083c8d51fbf0834059.1682019544.git.mehdi.djait.k@gmail.com>
 <ffae181f-f235-2767-b8fe-e8c4f2e69ccd@gmail.com>
 <20230422183246.3b18be8f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422183246.3b18be8f@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matti and Jonathan,

On Sat, Apr 22, 2023 at 06:32:46PM +0100, Jonathan Cameron wrote:
> On Fri, 21 Apr 2023 09:19:32 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > Hi Mehdi,
> > 
> > Thanks for working on this driver :) Much appreciated!
> > 
> > On 4/20/23 23:22, Mehdi Djait wrote:
> > > Refactor the kx022a driver implementation to make it more generic and
> > > extensible.
> > > Introduce an i2c_device_id table.
> > > Add the chip_info structure to the driver's private data to hold all
> > > the device specific infos.
> > > 
> > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > > ---
> > > v2:
> > > - mentioned the introduction of the i2c_device_id table in the commit  
> > 
> > Maybe adding the i2c_device_id table could be done in a separate patch 
> > with a Fixes tag? That would help backporting (and I think changes like 
> > this are worth it).
> 
> Is it technically a fix?  I thought it was but turned out my reasoning only
> applied to spi.   Agreed it would be nice as a separate patch though.
> It's not directly related to the rest of what is happening here.

I will make it a separate patch in the v3

--
Kind Regard
Mehdi Djait
