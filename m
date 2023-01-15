Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F866B330
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjAOR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 12:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjAOR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 12:28:46 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0FC647;
        Sun, 15 Jan 2023 09:28:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g13so39825378lfv.7;
        Sun, 15 Jan 2023 09:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/u5b58vi7ukxjgtKxQWSLW7jloOtXQYZaxK1kJZ+6Q=;
        b=Nxjdp7dJf5rB3ybkMD2q9pd0Fxd2XsPAj04CmjMH0E9vnq5YHFYQuZYn+hTmus8GN7
         ZpgXZREScOU3O0NcEc6ALhtbRS4aaXaT7NOSQuacsSs1TvfVOS7Iox/VCVAkOFV4hTCV
         TD39MLh9WosinAqW4j0OzMQr6MOclQHRREKIp3gWn/uECdYv60jwmZk1aYZwHUV1ktOo
         0dooxA1g7Mm/Mlm6O/NZvfoKRzKLwfbuWOVrm1IC1SPk6JPtFygMommkj1RV/edlLnfq
         Y2kWrcI5O35OA/HdQ2PDZlJK6+vN7gJ4cd5AYetFX0Lsqq8SyeZyuK3ohJY/VZOIYQEy
         +OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/u5b58vi7ukxjgtKxQWSLW7jloOtXQYZaxK1kJZ+6Q=;
        b=w09BGzD42GXZeD1DGRCyRpWUgeigTCNKNjtx4oNa6eUelCL2swFmC1D2KsYtX9h5xt
         5E7wP97juzokHqlghSCXwYxI54Mrj6FCSSGWt75Bh21zTV8I04bSYEkOD4/P3frNdZbu
         Da2Z6eoAvZ6WdxUIILMAA6cgJkvqUp70VdvsvmI6brxdptSGvu+v4LqBUjNcHJf49u88
         rnrQAdpq1Mf3LTvjCv0+KK8ORrFBvHEtyp/FFaQXnK48cgN6w5JyrMoANKzGS4jSGW5i
         9Afr+HLfcdmQBH2lF96SeiyHrJPV0upBz5+EvM8+c5K4qy1CmfK4CtgU+2mi/ujs+zwK
         3KLA==
X-Gm-Message-State: AFqh2krXk4damdggyTyjRW92EFPC8Qsg+atLiGBD2tGjK8hEZ8hxcfgw
        N9KFc4/ZtXthxKAuCPTNBP+Gap29ick=
X-Google-Smtp-Source: AMrXdXuQEDMxckq9Q9bU9A/qrNVnGtU+rbFWKBdLIadtxSSci+becmFGQSeA1ax6j0lAmybyI7nP0w==
X-Received: by 2002:a05:6512:3b87:b0:4a4:68b7:d623 with SMTP id g7-20020a0565123b8700b004a468b7d623mr31037548lfv.10.1673803723107;
        Sun, 15 Jan 2023 09:28:43 -0800 (PST)
Received: from localhost ([2a05:3580:f312:6c02:b940:4283:cb3e:a3e8])
        by smtp.gmail.com with ESMTPSA id p7-20020ac24ec7000000b004b587e37265sm4751101lfr.58.2023.01.15.09.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 09:28:42 -0800 (PST)
Date:   Sun, 15 Jan 2023 20:28:41 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov5640: Update last busy timestamp to reset
 autosuspend timer
Message-ID: <Y8Q3yXz3OolX/FW8@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230114112109.982005-1-andrej.skvortzov@gmail.com>
 <Y8KgGhu0e/+xIfDm@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8KgGhu0e/+xIfDm@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-14 14:29, Sakari Ailus wrote:
> Hi Andrey,
> 
> On Sat, Jan 14, 2023 at 02:21:09PM +0300, Andrey Skvortsov wrote:
> > Otherwise autosuspend delay doesn't work and power is cut off
> > immediately as device is freed.
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  drivers/media/i2c/ov5640.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > index ac35350..f71c0f7 100644
> > --- a/drivers/media/i2c/ov5640.c
> > +++ b/drivers/media/i2c/ov5640.c
> > @@ -1238,6 +1238,7 @@ static int ov5640_write_reg(struct ov5640_dev *sensor, u16 reg, u8 val)
> >  		return ret;
> >  	}
> >  
> > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> >  	return 0;
> >  }
> >  
> > @@ -1305,6 +1306,7 @@ static int ov5640_read_reg(struct ov5640_dev *sensor, u16 reg, u8 *val)
> >  	}
> >  
> >  	*val = buf[0];
> > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> 
> I wouldn't add these calls to register accesses. It's generally relevant
> with autosuspend_put().
> 
> The rest seems fine to me.
> 

Thanks, Sakari, for the feedback. I wasn't sure about these calls either,
I'll remove them in the v2.

-- 
Best regards,
Andrey Skvortsov
