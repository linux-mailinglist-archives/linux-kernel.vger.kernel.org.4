Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69485FF952
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJOJBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJOJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:01:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9729825;
        Sat, 15 Oct 2022 02:01:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n9so4740647wms.1;
        Sat, 15 Oct 2022 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TFROrVMGPFNNPeXSl/tKGYs2af7MfOZ0qRaQb7OpB8=;
        b=XyE9j8z7jdGGanTw5/w5ulHHIO5uRhHCRHkSo2maLnQj+JzsXEu0ixF0TBDpAtXcBk
         uvgmxS4g8axso/8CJr0wO0dgTGh0S0bsfnIWIBf8j/DoqrHkuG1F68OZ9rjHKCYd5LyC
         ieRtdwvKaZaLZgLn0+hjsdcDyIGuNEZJ4k0qIECNU8jIRo4APnEE/6bgAJFNB9yCS+EZ
         ybpbaTFELM0ZxO/8mP9nQcgtem5GSzPIH0dh+/lSs0Zec9hGGcktVWw/o0eaOLKSJ6lk
         wuvLYaJU86jdNWaflKNpfe7CDB9e6KPfbUiFhMkihEQzp4EtmusrcBb8bc/hdvR4RFRb
         enRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TFROrVMGPFNNPeXSl/tKGYs2af7MfOZ0qRaQb7OpB8=;
        b=mFjS/HQIe9pH1pU1nVgJPeoiML5WhQ/+atPctWo9S4HxUIJEH6gBnehtItCXnJ1L+W
         5jMBej0TTd/TkHwdaQrEdfIH7EnFgbeXptK0B2V5//wMfwKvp4BvrU/H7APnfpR8tIt7
         kHr6vlyjlapZK6GQ24dWEEImHyJ2aC1b85YoquYTRHhk1OuIWymobUbvFQ8il9LHeCJa
         9JedSqYmIC4emKnSX6y937eChxX0PcYn7gqaOfr05KI310adZlIUupmlADmldW4eyfbc
         u5zbPZQVhcfQjL7kr7TSrIkYmo/AOh7F0/u2Z2q3IWHxlAMZSJ24GOAMcmiQjRIr53ZP
         052A==
X-Gm-Message-State: ACrzQf1WuCvvu/n5l09q1s5LYpBu6Emxc1pMzFNBMv4bj1838pITqVfg
        3CL6MNaMvK7SkgdlIg/g7NM=
X-Google-Smtp-Source: AMsMyM6riRFJlHh+XA4hw5jdjzJeDweW04SoLbGSdMN4uxLiQDXYYtFp51ghd2AEn1MpJHS+mYoMcw==
X-Received: by 2002:a05:600c:1990:b0:3b4:c326:d099 with SMTP id t16-20020a05600c199000b003b4c326d099mr1068488wmq.19.1665824468112;
        Sat, 15 Oct 2022 02:01:08 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id i11-20020adfefcb000000b0022cc895cc11sm3484135wrp.104.2022.10.15.02.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 02:01:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     ezequiel@vanguardiasur.com.ar, benjamin.gaignard@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] media: Fix P010 tiled format description
Date:   Sat, 15 Oct 2022 11:01:06 +0200
Message-ID: <5610120.DvuYhMxLoT@kista>
In-Reply-To: <f7200ae5-cefd-af98-d607-272915971f53@xs4all.nl>
References: <20221015085651.2471818-1-jernej.skrabec@gmail.com> <f7200ae5-cefd-af98-d607-272915971f53@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 15. oktober 2022 ob 10:59:28 CEST je Hans Verkuil napisal(a):
> Hi Jernej,
> 
> On 10/15/22 10:56, Jernej Skrabec wrote:
> > There is only 31 bytes of space (without null character) for format
> > description. P010 tiled format description overflows that for 1
> > character and warning is generated when used. Fix that by changing Cb to
> > U and Cr to V, which is also consistent with some other descriptions.
> > 
> > Fixes: 3c8e19d3d3f9 ("media: Add P010 tiled format")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >  drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c
> > b/drivers/media/v4l2-core/v4l2-ioctl.c index e6fd355a2e92..5e5616d5915a
> > 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1357,7 +1357,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc
> > *fmt)> 
> >  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 
Linear)"; break;
> >  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 
Linear)";
> >  	break;
> >  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 
Linear)";
> >  	break;> 
> > -	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/CbCr 4:2:0 
(4x4 Linear)";
> > break; +	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/UV 4:2:0 
(4x4
> > Linear)"; break;> 
> >  	case V4L2_PIX_FMT_NV12M:	descr = "Y/CbCr 4:2:0 (N-C)"; 
break;
> >  	case V4L2_PIX_FMT_NV21M:	descr = "Y/CrCb 4:2:0 (N-C)"; 
break;
> >  	case V4L2_PIX_FMT_NV16M:	descr = "Y/CbCr 4:2:2 (N-C)"; 
break;
> 
> Sorry, I wasn't clear on irc: you should replace Cb and Cr with UV for ALL
> these descriptions.
> 
> That way all the pixelformat descriptions use the same terminology and it
> fixes your issue as well.

Ok, will do.

Best regards,
Jernej


