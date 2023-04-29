Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A796F24C5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 15:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjD2NHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjD2NHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 09:07:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9AD1FD5;
        Sat, 29 Apr 2023 06:07:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f109b1808so167224266b.1;
        Sat, 29 Apr 2023 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682773669; x=1685365669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy6Rvq9bqkrVluCQhbYqXIojqy7upXVbuz0T3nnyYcg=;
        b=dz7Tz2biN/oixLALLMmxbDY3SPRv9OGTTTiwFtW0lFyoWjnSwBgBwjpg9QKToW6II4
         f2Ai0KZ6agm9DhilEJVoSI+M1A/p54YCr3f2vfxng8SJbhfiZrq9pEzxe91ID0KBv4wa
         1vefHuP28XIFRPrhoAsJrHGsPm9WN68eultJiSm73ysGo1HdFOIjnH4yoykevd1/gkLM
         er6UXnYMNxwZX2aUvIe/AyBpHlDi55EPN0gz3phC3hjMJ0U4f/of3YEO3Y4bSarcrgVu
         kqZg7+wibJ6apHqryGmR4OsCyh0CsAqWRPfn/YYRlhSWSI1CurSC89hqrvrOcVQRJlV7
         LK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682773669; x=1685365669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy6Rvq9bqkrVluCQhbYqXIojqy7upXVbuz0T3nnyYcg=;
        b=D6M0vkeYAb+HpxX6BOPKN+0Xll3mjwn3ICpZ7wNXTTy6MQiSUi/Qx7BhR9tTgBwEE5
         Vg2sNTR/ygB8LWMjvC1ZR+KMqlHasbPe8UCEvldwSXdCCPaI15nUmxvl1qX5tbkWETC0
         d4X0FVeHb2s2IaDizqaZhTaal6iLu1kZUHqZXWqrzPQmIEjrerhj01Oxl4ItAI3Kx2JK
         mdT5GtlYq+cZ96ruvRrGgM6C51s5Z4KKDMbJFgE5Ozn/DSqa/3CIFtOIpKUUgGCYpOTz
         QNeOE5uhX8IhhVbr7ikMdJt33U2WLdqenhTiqRc6yPane2su9ex8cH8Y/5XrOKoL+3Lb
         8SDA==
X-Gm-Message-State: AC+VfDygR98gZXplx9cSWVHnz5232EV+t2tlVZS/HZanZPER1FAxZ4rW
        pBY9+drr7JutCbmNqhbHVUs5hpGxqho=
X-Google-Smtp-Source: ACHHUZ4AqK8C1ohuTT2SZsrfd1YjDm74JB4R2P6CrYcinZR0+TCSNyXL8XIsomXkPz1DhNm4eMf6XA==
X-Received: by 2002:a17:907:6e8d:b0:93b:5f2:36c with SMTP id sh13-20020a1709076e8d00b0093b05f2036cmr8848904ejc.61.1682773669089;
        Sat, 29 Apr 2023 06:07:49 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::2d16])
        by smtp.gmail.com with ESMTPSA id y21-20020a17090614d500b0094b87711c9fsm12501293ejc.99.2023.04.29.06.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 06:07:48 -0700 (PDT)
Date:   Sat, 29 Apr 2023 15:07:46 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZE0WopTBS8S08tjX@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <20230425155734.ywdle4pv6y2wjk2s@intel.intel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425155734.ywdle4pv6y2wjk2s@intel.intel>
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

Thank you for the review.

On Tue, Apr 25, 2023 at 05:57:34PM +0200, Andi Shyti wrote:
> Hi Mehdi,
> 
> On Tue, Apr 25, 2023 at 12:22:25AM +0200, Mehdi Djait wrote:
> > Add the chip_info structure to the driver's private data to hold all
> > the device specific infos.
> > Refactor the kx022a driver implementation to make it more generic and
> > extensible.
> 
> Could you please split this in different patches? Add id in one
> patch and refactor in a different patch. Please, also the
> refactorings need to be split.
> 
> I see here that this is a general code cleanup, plus some other
> stuff.

Looking at the diff and considering the comments from Jonathan in the
previous versions, the only thing that can separated from this patch
would be the changes related to:
-#define KX022A_ACCEL_CHAN(axis, index)				\
+#define KX022A_ACCEL_CHAN(axis, reg, index)			\

> 
> [...]
> 
> > @@ -22,22 +23,28 @@ static int kx022a_spi_probe(struct spi_device *spi)
> >  		return -EINVAL;
> >  	}
> >  
> > -	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
> > +	chip_info = device_get_match_data(&spi->dev);
> > +	if (!chip_info) {
> > +		const struct spi_device_id *id = spi_get_device_id(spi);
> > +		chip_info = (const struct kx022a_chip_info *)id->driver_data;
> 
> you don't need the cast here... if you don't find it messy, I
> wouldn't mind this form... some hate it, I find it easier to
> read:
> 
> 	chip_info = spi_get_device_id(spi)->driver_data;
> 
> your choice.

I don't really have any strong opinion about this other than keeping the
same style used in iio drivers

Again thank you for the review

--
Kind Regards
Mehdi Djait

