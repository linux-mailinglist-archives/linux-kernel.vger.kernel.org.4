Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1597F6ED0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjDXO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDXO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:57:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55ED30E5;
        Mon, 24 Apr 2023 07:56:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-504eac2f0b2so7833984a12.3;
        Mon, 24 Apr 2023 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682348218; x=1684940218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyC3Am9x5MDVCnozv7oRC741HUNVYU534Al0Yoe0eTc=;
        b=IIPTUf5IBUBU+Edya4d4mMv5fiLcs2rvu6zqLp9FGrq7ekNjKOLsialN5g5YCi7iaW
         GnBXBGOXMXv9ltzpNUfXrp1uII7kbw/K79oIQHHvv8swu5gQRo7ZtbIt658QY1doi6iH
         AzWU2/3ltjC/lZgMN+KplAU2Kg+IMos8XGzfNx2oNyacC+orYuJ24VXEa+U+T3KAiVp0
         inkAZyS1niNOmGKFY1ccfqDu8ALNIrGx9Ba6lK0QrlBF6WUm5pQP1vu791nGg7WONFgI
         bK0lpYgaE9Va73Pn7JfQcjGjjuCtAn9LgCBXpQAy0pk+/GnK6/JDSKtDAll17IX1lgQG
         eO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682348218; x=1684940218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyC3Am9x5MDVCnozv7oRC741HUNVYU534Al0Yoe0eTc=;
        b=ioLbKia7b4sL1QI5qbu0pTQvb0vgBjpn7vgRhGXjJp5feCYK0DXLNaGd45y/GURMzj
         ZcDCvPED6qSplmr21wAIRN+/MlyHJjeCtuS7A9LBTpQd9giW7BB7j5/a1MsomFrFXpQk
         Ws6vHq2nPoYIFLxfbeOXR/0xT40wnPYPu12YLCNuG+Zm+BvX7eNae6JzS6LcQchp1EdL
         OcNhw2e8FWHvEjvTzv84eBzytw5iqbHhxKmNRIMW/V5dzQG55RUyUuO9WR88XNEQnqK0
         na/J8knkXYjmcd/z7O3mABcUgMdphH49aVk3L9sVjZKtVdke+tSiTVd+IKrjFs/xVx+f
         aRxQ==
X-Gm-Message-State: AAQBX9eqU0tZ/jr8Kzs1kjLwChCGgujXlvodBVnNZcz2CYLSwAK1aCp7
        55YtBO2l8q6fLn5N5ZOahh4=
X-Google-Smtp-Source: AKy350a/LImqzZ6R1/1wrYIpJ7JiPYKyuWkBcDJnveIXXJw7GmdTiya9frX0wCcxKxk1BCOyxIdfmw==
X-Received: by 2002:aa7:c902:0:b0:506:c20c:6de8 with SMTP id b2-20020aa7c902000000b00506c20c6de8mr11983389edt.17.1682348218038;
        Mon, 24 Apr 2023 07:56:58 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::5908])
        by smtp.gmail.com with ESMTPSA id p19-20020a05640210d300b005067d089aafsm4698705edu.11.2023.04.24.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:56:57 -0700 (PDT)
Date:   Mon, 24 Apr 2023 16:56:55 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, jic23@kernel.org,
        mazziesaccount@gmail.com, oe-kbuild-all@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZEaYt3XTzuXrmFxd@carbian>
References: <cef09595632a40eff8a0864fea2e0eb6653930a5.1682019544.git.mehdi.djait.k@gmail.com>
 <202304220729.FCofPRvH-lkp@intel.com>
 <ZEQGqFLIyxm5XENQ@smile.fi.intel.com>
 <ZEWbmSuJqWJWf0aD@carbian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEWbmSuJqWJWf0aD@carbian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On Sun, Apr 23, 2023 at 10:57:00PM +0200, Mehdi Djait wrote:
> Hello Andy,
> 
> thank you for the review.
> 
> On Sat, Apr 22, 2023 at 07:09:12PM +0300, Andy Shevchenko wrote:
> > On Sat, Apr 22, 2023 at 07:19:44AM +0800, kernel test robot wrote:
> > > Hi Mehdi,
> > > 
> > > kernel test robot noticed the following build warnings:
> > 
> > I believe it's not just a warning, it's a full functional error in the code.
> > 
> > >    686	{
> > >    687		struct device *dev = regmap_get_device(data->regmap);
> > >    688		__le16 buf_status;
> > >    689		int ret, fifo_bytes;
> > >    690	
> > >    691		ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> > >    692				       &buf_status, sizeof(buf_status));
> > >    693		if (ret) {
> > >    694			dev_err(dev, "Error reading buffer status\n");
> > >    695			return ret;
> > >    696		}
> > >    697	
> > >  > 698		buf_status &= data->chip_info->buf_smp_lvl_mask;
> > >    699		fifo_bytes = le16_to_cpu(buf_status);
> > 
> > You need to mask in the same endianess space, i.o.w. either on CPU or device side.
> > 
> > I believe you wanted to have fifo_bytes to be masked, but I'm not sure.
> 
> I wanted to read the registers buf_status_1 and buf_status_2 --> 16 bits
> and mask the result of the read to get the bits 0..9 which is the
> buf_status: the number of bytes in the buffer
> 
> This is due to my lack of experience, but I have a question:
> If I don't get any warnings when testing, how should I go about this ? I
> will obviously fix this, but this is for the future.

just ignore this question. I installed sparse and I am using it now when
building. 
 
--
Kind Regards
Mehdi Djait
