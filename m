Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4116C6F24C8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjD2NKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjD2NKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:10:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549CB10C1;
        Sat, 29 Apr 2023 06:10:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f6c285d92so165895466b.3;
        Sat, 29 Apr 2023 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682773843; x=1685365843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRsBsXyIDpjMATYsXdDVMUyJefvlYASMrXew3CqePuA=;
        b=YNmX+kBvattD/bCWlnCO1rRyYrXJ5VekW+mWKrY+fs6oE2P00n3mgb748ihjTq1g70
         lTfuButNU9s9GHCoseaU6FuKd9OAS2MP35L+kurRolPchsNnGo1znmdH+UM031aMtGDH
         4+OU5VPAR2x2RqHNfDrR3fvP4kX3jSI/duicnCoUBB/i2s1kB5+kxYc1R7XFv2LpVYOu
         CCD1zJmZMIgTag3YEJ+HFYlbRuus7S4ZdYTyH1cYFym3F9xXhHh2v7emDq3nEHvY4izS
         5OENrtlRGv1WrG4XLcWeAajlOQY8YwOu9zqRZrVn0IQeiuZrgcRQYOaC1aAx7Rn9Q9k9
         yEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682773843; x=1685365843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRsBsXyIDpjMATYsXdDVMUyJefvlYASMrXew3CqePuA=;
        b=QK6jWCEIsWnbpgE8G0nnUaLN5WOzmoVTim0JmmF301nyRz9Yg3oUW0gJrmkJoZC3Ov
         dnTJzM/y0oygzQqy1/m8JO2C2EgCUKvPuD8Z6DxNXJM9jrAV9BWT/2lGlb5tsfGarcUy
         Agg4r4POpRaLwIhaEhfJ5wIHoSPN9w+/7OhEeeb4ZwtAsDZvLSXw5lhIJWqFn+LwJ+E5
         hqlZxVYGhs1Fhu6g154hEHhGIRuqewtUApk+pZDzjPkwn/FnHNJM8/ig7Yb1v5YSohai
         Fmh1UBuTrGrU4/SXINOeqFvdlXErmY03b1SUMY+Wp9z1W6tDC2H+X+BG8Ceq8/aF69yq
         WIqg==
X-Gm-Message-State: AC+VfDyqiGpzxnKOqylRkYHj9XQDb1FFCozD6815uYk4tY5smm2hhN/n
        UXVUmmflLevsUoa961LbSAc=
X-Google-Smtp-Source: ACHHUZ6a4QCkHqTGc4Elq4h+mtbOr2gwOSLUu0LFKcS9pb45ss9MJn8FZ1m/VdX05LyhUeE9jFR3yQ==
X-Received: by 2002:a17:906:5d0b:b0:94e:4523:b0d8 with SMTP id g11-20020a1709065d0b00b0094e4523b0d8mr7555267ejt.73.1682773842624;
        Sat, 29 Apr 2023 06:10:42 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::2d16])
        by smtp.gmail.com with ESMTPSA id u8-20020aa7db88000000b00504d04c939fsm10311852edt.59.2023.04.29.06.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 06:10:42 -0700 (PDT)
Date:   Sat, 29 Apr 2023 15:10:40 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id
 table
Message-ID: <ZE0XUJMnnUPeYGve@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <a232fe7a8104f8d1cddfc5950aa48748ea90bffa.1682373451.git.mehdi.djait.k@gmail.com>
 <ZEfYOO9TQSbEyCu2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEfYOO9TQSbEyCu2@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Tue, Apr 25, 2023 at 04:40:08PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 25, 2023 at 12:22:24AM +0200, Mehdi Djait wrote:
> > Add the missing i2c device id 
> 
> Seems like unfinished commit message (also note missing period, that's why
> I paid attention to this).
> 

While the period is indeed missing. I did not find anything else to
write in the commit message other than 'Add the missing i2c device id'

> ...
> 
> > +static const struct i2c_device_id kx022a_i2c_id[] = {
> > +	{ .name = "kx022a", 0 },
> 
> ', 0' is redundant.

I will remove it

--
Kind Regards
Mehdi Djait
