Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF9D72CB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjFLQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjFLQcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:32:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1718F;
        Mon, 12 Jun 2023 09:31:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso6778604a12.0;
        Mon, 12 Jun 2023 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686587517; x=1689179517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhmD5YwHxcEzbrarg+BlgtNX0+eZdXCjCqyHtO3yuL4=;
        b=Lp/32xgr0XLUxF3Heo8VEC0VjWCP/dRPI34zungHMPjVD4g14M8pJv+h7u2xwCVIpG
         tp4j+ZMU7SeJ9lf5m3gyri+2eJkkdYdrxoZI+9xsgwPvB5HNHXWJ7H/DoYGyG0/buP4a
         B0QmuilxyIpv3hf8YVi+SRAlG81yJ1Fd7f7yDRFuj+CpNT3gGkHsjvuYk55Uv0DVYNZs
         A8CsaYwQZ7VdXliIIbyER3Kc+wS0VpzO/wbJIeWT7YwaF3otlbCxl+emRhReDKip6Qdm
         2CtrgbGiL4ZNVs71aUJk2rwyI9A3RFkBb8rHhJ910l2R/2MZ4qphEzj9vwozVNfFtwXL
         gIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587517; x=1689179517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhmD5YwHxcEzbrarg+BlgtNX0+eZdXCjCqyHtO3yuL4=;
        b=E+HYMttflBsOvwPFl+jKWH2yhB44ryLsuoi8N/VhK1VA5vwE9GTBVmWxUxCbrHb1xz
         jWbI2dP+lhkNvwOOYIwwBB6H5ITcW7DCB62RnZbjPu2lCkM82Ywx1152ZR8ouX/0sB80
         HAUTJwTH1mMf0Cmx1y1iOYhCbiAvdfot0DFlEDmnZAmKC9oouqLIntN+KTO5indqiQz+
         vA5zW2fDNZuO9n1NUfqfVQqOGIjBlqngbRCtJ2uIi3wBjxkUwTKt76FYjFJfucyP0qgT
         dMwsv4J6bW5UJCFdV2sf2np9U5Z+eIgnKGHr8how32WgOZyPH7x3z45GtRAGXM2asouR
         3Suw==
X-Gm-Message-State: AC+VfDwXzJAk+HK0f4R7+c8m7kv7FF27i0vQ7iv+M/NeJYq1BRWk0S+2
        Rk/xWeUqXo4r4WocXvCJIIY=
X-Google-Smtp-Source: ACHHUZ639o5vn7Q3Iy5CYmOka4i5yQpyen8o0DYCwRh7NXiOIIHmhRTT2AXEarwHmvaBxG8VoN6YPQ==
X-Received: by 2002:a05:6402:6d3:b0:50d:88f3:2e30 with SMTP id n19-20020a05640206d300b0050d88f32e30mr5741150edy.13.1686587517145;
        Mon, 12 Jun 2023 09:31:57 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090627d700b009787b13d1ddsm5449756ejc.51.2023.06.12.09.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:31:56 -0700 (PDT)
Date:   Mon, 12 Jun 2023 18:31:54 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZIdIev+evQUvX5Rg@carbian>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
 <3a41a5ae9857cacdb062c398715a5938ccd47014.1686578554.git.mehdi.djait.k@gmail.com>
 <ZIc/uvB1zxNRnuRS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIc/uvB1zxNRnuRS@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Mon, Jun 12, 2023 at 06:54:34PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 12, 2023 at 04:22:08PM +0200, Mehdi Djait wrote:
> > Add the chip_info structure to the driver's private data to hold all
> > the device specific infos.
> > Refactor the kx022a driver implementation to make it more generic and
> > extensible.
> 
> ...
> 
> > +	chip_info = spi_get_device_match_data(spi);
> 
> Missing check. You addressed only I²C case. Is there any explanation?

I will add the check for the SPI case

> 
> ...
> 
> >  struct kx022a_data {
> > +	const struct kx022a_chip_info *chip_info;
> >  	struct regmap *regmap;
> 
> I would suggest to run bloat-o-meter with this version and if you place
> chip_info after regmap. Does it gain us some memory?

I used the bloat-o-meter on the two .ko files (this version and the the
one where chip_info after regamp) Is this what you asked for ?  

add/remove: 0/0 grow/shrink: 0/5 up/down: 0/-20 (-20)
Function                                     old     new   delta
kx132_get_fifo_bytes                         148     144      -4
kx022a_trigger_set_state                     352     348      -4
kx022a_read_raw                              380     376      -4
kx022a_buffer_predisable                     248     244      -4
kx022a_buffer_postenable                     296     292      -4
Total: Before=11244, After=11224, chg -0.18%

--
Kind Regards
Mehdi Djait
