Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F76EC2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 00:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjDWWHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 18:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDWWHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 18:07:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E733018C;
        Sun, 23 Apr 2023 15:06:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94ef0a8546fso556236666b.1;
        Sun, 23 Apr 2023 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682287616; x=1684879616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUJ1fJGBU2IJPhbqoqQA2c5DXLqAeTDm4a1mjfjt65c=;
        b=KpFKyh6GYPpkaAdJ1c1t2I9KsrMOZV2fFKSKLNlX3HQBAl2BCVPrRlh55Fw48d38HK
         DonSWgVsRe8UxXkFrUss1sRsf/JDsDYACPwm4xtOLm7XYCug7cnE5qoO9JCfuNBxLhix
         XpJyPZoSDTmP0nOKwUPM6oEyFi6A5a9N/Zn/OBlKMXCVDmaiEjtpydq7NpWp4I1itDQB
         wGpZCtn4UTlUCNnAXnHeWdfAadQvHM5QwzJCi7FJbOBAolbzfH6Y1z1OwvD1TbPEhTUk
         QOdr0tJE9uJqA3fb9/I2u9+41NHsBvq1Tk6PoPqzxZ5VSmInrTcsxFafYv03iQ34k3GB
         EDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682287616; x=1684879616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUJ1fJGBU2IJPhbqoqQA2c5DXLqAeTDm4a1mjfjt65c=;
        b=WBlk0+73fW8kMep4clWsoFHEpxGoyGfvQ2BzmK3lQoA5ZFkvPhHaepoJWciqKjiJ5g
         +BJ46aVcVZpSXdac4ONq4QokYC1xT7uTvM3PplkRxHADtu8xYUbQxDhgzXXDVN5bsqLn
         tmcAvRRZFJOhLNFZE/VFl9Z8G+6PjxJPsns9MSzHSZlhcHFRfbWzeHCkVWtCwWi1G2A/
         18DwMTQxqsrZ2Bkr8FSyL82xFq7aTRrCCCZEho23qswlQgAxMTDF+nPVX02/gBy2MRIw
         7HelT1XTV/GYqqXxBWbFFdwg/dlWHrJbtt5w4lfgNu2sy7kF7DjUx2vI9d3CoPxNGIZ7
         et8g==
X-Gm-Message-State: AAQBX9eaWeEwhegDAHphcln+1VXlb0FEiHue41jOF75D242QiBaK2HHG
        7AAs2MOiR7YaWaqorgXJU1I=
X-Google-Smtp-Source: AKy350a47sLVwQvfE1ika2RGybl2JXe9LboVhIafyVxiuttQFMoScHR0M+iJTsg0m48mCdUQv8Oe6w==
X-Received: by 2002:a17:906:cb86:b0:94a:ac4b:e11b with SMTP id mf6-20020a170906cb8600b0094aac4be11bmr7245080ejb.39.1682287616118;
        Sun, 23 Apr 2023 15:06:56 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id cf2-20020a170906b2c200b0094f56d993a8sm4820767ejb.5.2023.04.23.15.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 15:06:55 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:06:53 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZEWr/RHDJZZXknSJ@carbian>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <2c5d71e37fc7e000091189b3c5d66ede1a6015d2.1682019544.git.mehdi.djait.k@gmail.com>
 <93b19237-3afd-461f-bdb3-f2cd09cadd9a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b19237-3afd-461f-bdb3-f2cd09cadd9a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Fri, Apr 21, 2023 at 09:14:10AM +0300, Matti Vaittinen wrote:
> Hi Mehdi,
> 
> Thanks for the v2!
> 
> On 4/20/23 23:22, Mehdi Djait wrote:
> > Since Kionix accelerometers use various numbers of bits to report data, a
> > device-specific function is required.
> 
> I think this is the right approach. Thanks for adding this device-specific
> function.
> 
> > Move the driver's private data to the header file to support the new function.
> 
> Hmm. Why this move is necessary? I didn't immediately spot this struct being
> used outside this C-file. I'd rather saw the struct in C-file if possible.

My bad, I will move it back

--
Kind Regards
Mehdi Djait
