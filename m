Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE466F9B99
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjEGUp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjEGUp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:45:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BCE2717;
        Sun,  7 May 2023 13:45:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so5809949a12.2;
        Sun, 07 May 2023 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683492323; x=1686084323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuy2z4Dft0GSgy8+sD4LMQQuOcR+sqxTgE7CAkMSATk=;
        b=Wp4ZIH1lgNQTbaCd9KuNSzvMA6DHDLCrcvTIlWCIHSi9s91FtIh1e57JM0o/dREjiI
         JTKVzjQMfBj/mrDfcaWWGfnvY0E56HcJFkPNTO7uzDcGXwUDxNpq8mp2RUopfJ2OEM5i
         /PGp/CUaWxN64eR42hRsl3SGX3g0JwP2fSHpGrN+SdgFQMsaYn2Yv35Qn3SJeLhlpWT5
         kdYImUMxiUyL4r1+Ou6q7zMymrUYwQVRiAVRJv+kKA19yznwSQTi7SdnGiUb5cH/ep5F
         phdodg7McH5v7PK4FU9BgUfee1oevLZWKHE+RLJkDC6c8Wgoj31Htwo/8UkzPtHaUSn9
         6s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683492323; x=1686084323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuy2z4Dft0GSgy8+sD4LMQQuOcR+sqxTgE7CAkMSATk=;
        b=NEaujN2HqcGdKPzuPzzuQMW/wG+Mdm6wdC/DVU+Li4rIFyt3YfMwk8AwQr96nde4B0
         SK3+zErW8oxZQP2GD6WcLGKB4g/+ObzEtTjE2GCvZ9P+ZYO4RuhY8goFZdOK6ZoC8wuP
         J6ND0A7nPVcUHcAtHNF4RFEY4TCoZJA9t5Hhrtk6E6tUfeapKctPBN5ySVqstIa+jrAD
         2nbnnnnnAle62gTWXkYZqxze9FIdWZeEHfayO+e/2aHHnnJlWM+41SR6LtPPBEUxE4IJ
         0uLH/ZiC7Wnq54rXdmap+/0oiYAoiBeHowPsMzuc1TPbBxmUaVdxYRiey/IpIWkh2djP
         RYvg==
X-Gm-Message-State: AC+VfDyVztWjDkaXhx6z3rmPcCgjvvWeeLPUkPQGbpqhS85IOP8qY6qn
        M2sjwyayNNj/zS5PLKZDBcI=
X-Google-Smtp-Source: ACHHUZ6ZbnXAWhJWciL0Fg+ARcApk1N/a7t7/xNIsGHgEZEJETOpZYjZovejAe56QeyusHWXVGzdgw==
X-Received: by 2002:a17:907:26c2:b0:94f:788:6bc with SMTP id bp2-20020a17090726c200b0094f078806bcmr7513662ejc.37.1683492323380;
        Sun, 07 May 2023 13:45:23 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::5908])
        by smtp.gmail.com with ESMTPSA id de38-20020a1709069be600b0094e1344ddfdsm4026297ejc.34.2023.05.07.13.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:45:23 -0700 (PDT)
Date:   Sun, 7 May 2023 22:45:20 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZFgN4MGXpfbcaXTG@carbian>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
 <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com>
 <ZEeAGN3TBcao3CNA@carbian>
 <c0958e31-b477-34e0-d824-b017efadd0df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0958e31-b477-34e0-d824-b017efadd0df@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matti,

On Tue, Apr 25, 2023 at 11:12:11AM +0300, Matti Vaittinen wrote:
> > > > +const struct kx022a_chip_info kx022a_chip_info = {
> > > > +	.name		  = "kx022-accel",
> > > > +	.regmap_config	  = &kx022a_regmap_config,
> > > > +	.channels	  = kx022a_channels,
> > > > +	.num_channels	  = ARRAY_SIZE(kx022a_channels),
> > > > +	.fifo_length	  = KX022A_FIFO_LENGTH,
> > > > +	.who		  = KX022A_REG_WHO,
> > > > +	.id		  = KX022A_ID,
> > > > +	.cntl		  = KX022A_REG_CNTL,
> > > > +	.cntl2		  = KX022A_REG_CNTL2,
> > > > +	.odcntl		  = KX022A_REG_ODCNTL,
> > > > +	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
> > > > +	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
> > > > +	.buf_clear	  = KX022A_REG_BUF_CLEAR,
> > > > +	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
> > > > +	.buf_read	  = KX022A_REG_BUF_READ,
> > > > +	.inc1		  = KX022A_REG_INC1,
> > > > +	.inc4		  = KX022A_REG_INC4,
> > > > +	.inc5		  = KX022A_REG_INC5,
> > > > +	.inc6		  = KX022A_REG_INC6,
> > > > +	.xout_l		  = KX022A_REG_XOUT_L,
> > > > +};
> > > > +EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
> > > 
> > > Do you think the fields (or at least some of them) in this struct could be
> > > named based on the (main) functionality being used, not based on the
> > > register name? Something like "watermark_reg", "buf_en_reg", "reset_reg",
> > > "output_rate_reg", "int1_pinconf_reg", "int1_src_reg", "int2_pinconf_reg",
> > > "int1_src_reg" ...
> > > 
> > > I would not be at all surprized to see for example some IRQ control to be
> > > shifted from INC<X> to INC<Y> or cntl<X> / buf_cntl<X> stuff to be moved to
> > > cntl<Y> or to buf_cntl<Y> for next sensor we want to support. Especially
> > > when new cool feature is added to next sensor, resulting also adding a new
> > > cntl<Z> or buf_cntl<Z> or INC<Z>.
> > > 
> > > I, however, believe the _functionality_ will be there (in some register) -
> > > at least for the ICs for which we can re-use this driver. Hence, it might be
> > > nice - and if you can think of better names for these fields - to rename
> > > them based on the _functionality_ we use.
> > > 
> > > Another benefit would be added clarity to the code. Writing a value to
> > > "buf_en_reg", "watermark_reg" or to "int1_src_reg" is much clearer (to me)
> > > than writing a value to "buf_cntl1", "buf_cntl2" or "INC4". Especially if
> > > you don't have a datasheet at your hands.
> > > 
> > > I am not "demanding" this (at least not for now :]) because it seems these
> > > two Kionix sensors have been pretty consistent what comes to maintaining the
> > > same functionality in the registers with same naming - but I believe this is
> > > something that may in any case be lurking around the corner.
> > 
> > I agree, this seems to be the better solution. I will look into this.
> > 
> 
> Thanks for going the extra mile :)

I am reconsidering the renaming of the fields 

1. inc{1,4,5,6} get assigned once to data->{ien_reg,inc_reg} in the probe 
function and then never used again

2. buf_cntl2 is used for enabling the buffer and changing the resolution
to 16bits, so which name is better than buf_cntl ? 

3. cntl seems the most appropriate name, again different functions and the same 
reg

4. who, id, xout_l, odcntl, buf_{clear, status, read} are quite straightforward

Anyway this is my opinion, what do you think ? 

--
Kind Regards,
Mehdi Djait
