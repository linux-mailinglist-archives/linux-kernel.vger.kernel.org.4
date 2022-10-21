Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7652B607E74
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJUS4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJUS4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:56:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEDB28DC3B;
        Fri, 21 Oct 2022 11:56:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso2661150wmb.5;
        Fri, 21 Oct 2022 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ST5S4NRKJlo7+7q0tIycVPYZ9ok2v0CvCXW/kXSFp4Q=;
        b=PcmlCLBWVyv3tkJJnYNquYLNyrZZQQnFfAOd90MJAW1EZAnwtpGSzgKX3tREjWvYsZ
         RjDfpZghE2jLaWsY/mqXMvUBr+AA75mEDQj69X/W+I6vc+TFM4PIMXNg7EjHiMKCMucV
         z+zYSevSt4edpnGLspXXYhxO1zYqgYcv510CqLDgu+HlU7gyFXxahd5b7t4qAqC/cK3T
         S+VM1ebZJbXrZD5PAKWHbNGW0xTxLfGqWf8Ej/963/KlhaWS8ok4SDRtbCPWFD/USwOu
         Y43qqtPyGsycPpVOuRjVxFxuVPDb648fjGFRL/zgyicp2QKsze6ALGnoqVNNP/DzIdBd
         XvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ST5S4NRKJlo7+7q0tIycVPYZ9ok2v0CvCXW/kXSFp4Q=;
        b=zC00OkHD9V8EJPJ/r4zAQWsF5P9X1kAPzmjnXJgQz3LdmeBlzp5s1NVMHQ2MepAZEb
         lcjt+Lhnfcu/WrEk2Hc9AWu0LKMTOxdK8ISxQetJ2I9OEP3wFBHcZ6zGtwj5Ye2uNk0/
         6173Wwf1I+UnoZ8w5cxcJaP1bDs7D/uTEieLmsZeNk5jH1CW56/Bb8jWsIV+PG+ggoDF
         ogVLRRsG3GiwA41DQORxb8nzovR1nTB1NGSODEzxU7zOg2LjGCdMMdh/ydabsWjmupvc
         uZgWDoOVdekJRkO68xVHqMHNkTHlC++fkqhXqgkv8CO/nh1Fc1nkRBh5HvAM87G1hMfl
         dg/w==
X-Gm-Message-State: ACrzQf3wpnqLxX69aNeHdvF4tmPQ09Eq4KqnZNXjCGtizlc8R2130Y09
        o4qDYnWs/La1slNpf+K3fCY=
X-Google-Smtp-Source: AMsMyM6Y0qgqO6iPAiSYcOZ8b1Bi++pFHwANQHdvYihea8Oing69m7e/mnTTAS8SfgEtVNz5LWNpFQ==
X-Received: by 2002:a05:600c:654f:b0:3c4:271b:6b35 with SMTP id dn15-20020a05600c654f00b003c4271b6b35mr13711847wmb.182.1666378597481;
        Fri, 21 Oct 2022 11:56:37 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b003c6b9749505sm419399wmq.30.2022.10.21.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:56:37 -0700 (PDT)
Message-ID: <6352eb65.050a0220.3eb5e.14c7@mx.google.com>
X-Google-Original-Message-ID: <Y1LrXlNw71KGPfUB@Ansuel-xps.>
Date:   Fri, 21 Oct 2022 20:56:30 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: Re: [RESEND PATCH 2/2] thermal: qcom: tsens: simplify debugfs init
 function
References: <20221021181906.16647-1-ansuelsmth@gmail.com>
 <20221021181906.16647-2-ansuelsmth@gmail.com>
 <f1e9b309-ba98-bba2-8d12-9f13ac34587d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1e9b309-ba98-bba2-8d12-9f13ac34587d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 08:33:41PM +0200, Daniel Lezcano wrote:
> On 21/10/2022 20:19, Christian Marangi wrote:
> > Simplify debugfs init function.
> > - Add check for existing dev directory.
> > - Fix wrong version in dbg_version_show (with version 0.0.0, 0.1.0 was
> >    incorrectly reported)
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
> > ---
> >   drivers/thermal/qcom/tsens.c | 14 +++++---------
> >   1 file changed, 5 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index cc2965b8d409..ff82626cecef 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -692,7 +692,7 @@ static int dbg_version_show(struct seq_file *s, void *data)
> >   			return ret;
> >   		seq_printf(s, "%d.%d.%d\n", maj_ver, min_ver, step_ver);
> >   	} else {
> > -		seq_puts(s, "0.1.0\n");
> > +		seq_printf(s, "0.%d.0\n", priv->feat->ver_major);
> >   	}
> >   	return 0;
> > @@ -704,21 +704,17 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
> >   static void tsens_debug_init(struct platform_device *pdev)
> >   {
> >   	struct tsens_priv *priv = platform_get_drvdata(pdev);
> > -	struct dentry *root, *file;
> > -	root = debugfs_lookup("tsens", NULL);
> > -	if (!root)
> > +	priv->debug_root = debugfs_lookup("tsens", NULL);
> > +	if (!priv->debug_root)
> >   		priv->debug_root = debugfs_create_dir("tsens", NULL);
> > -	else
> > -		priv->debug_root = root;
> > -	file = debugfs_lookup("version", priv->debug_root);
> > -	if (!file)
> > +	if (!debugfs_lookup("version", priv->debug_root))
> >   		debugfs_create_file("version", 0444, priv->debug_root,
> >   				    pdev, &dbg_version_fops);
> >   	/* A directory for each instance of the TSENS IP */
> > -	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> > +	priv->debug = debugfs_lookup(dev_name(&pdev->dev), priv->debug_root);
> 
> Why the directory creation is replaced by the lookup ?
>

Hi,
thanks for the review! I have to be honest and do not create some fake
excuse for this. This patch is a bit old and was pending from a long
time so out of despair i just tried to RESEND this hoping someone would
pick it up. And it seems it have worked... Sooo sorry for making you
asking this.

On rechecking the change here, the entire debug_init logic seems
wrong... I don't know if it's possible but what if in the system there
are multiple version of tsens istance? Looks wrong to overwrite the
version with the last one...

I think the original idea of this was to create a directory for each
istance and put in there version and sensors debugfs.

I will propose this in the next version if it's ok for you and you agree
with this logic. Also I think I will split this in 2 different patch one
for the version fixup and one for this new logic.

Waiting for your feedback and again sorry for the noise.

> >   	debugfs_create_file("sensors", 0444, priv->debug, pdev, &dbg_sensors_fops);
> >   }
> >   #else
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

-- 
	Ansuel
