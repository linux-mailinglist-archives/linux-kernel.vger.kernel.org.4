Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661FF608D5A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJVNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJVNKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:10:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A4253ED4;
        Sat, 22 Oct 2022 06:10:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e18so15430062edj.3;
        Sat, 22 Oct 2022 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DWxqQb3pJCcHfHLbrY0SnKRqWah2jt07DVxlX1RC15Q=;
        b=LU544rhD/8aW9X28J01TZtgJMQFfls6teFuuyKVhO7/g/eg8rKuG0gdUuqAO0N3LG6
         K3HG/iAegJG13Y8EvqI5K5UNlwFFGBToRsJaqq+65UYxeLXMrFMWCg5VYyyrNIFFtMtV
         e/M0ZBfUR5YO+tITz4qpnTzk2HJorrqSi0Q35gao59J5kPpej9AZHkTULjiWqoWp7LY0
         AOQfcBA+DG18x/st63v8rhwsOE1e1sAZXe43qbV1QCB+jUqLIBj3nToyRYniQjrEOdNZ
         9NhxEoPbXhfKgy/b7wlp8T2gFDDtHy0jNrJcUNmdNU8wHTPtKhnMdExGUynTNfid13LS
         a71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWxqQb3pJCcHfHLbrY0SnKRqWah2jt07DVxlX1RC15Q=;
        b=rEGv8GLhZrSkuCVEnCpayQlXpg0fkB2I1phzAi14VFU7fFkTpLvHjLe8aSA5let6hC
         zZHJZske7V/eRfPo3aO77hPhvzsObOKM538HNFkLIXJ3gb6tYFG5oTi5dPTWSDL6X3J9
         9HiIhPqp3vJtmbr89q5WjIDlphHNBTE/S1vWzy9iyJdm/6yn6rMvoKAJRJQlrMOkareF
         XvP4cfReovldpQn+YQBQCwXbtx8OFaXnHNto6Ic5aGBNQSRJnLdvsetnval5qUzSUOSW
         N15N1BbSIjixr/tue4xFXdVFNbG5JglTEVF5fHqrICHsRTfIHLlg77vAs50QfeC+ToJD
         aBDQ==
X-Gm-Message-State: ACrzQf2jiHZxfNuZqKKbJyPkImZWzKRYhJB/JM0zbMVurIu/qpNPFNko
        b9S3br+DKATzAxU0vwX3Bug=
X-Google-Smtp-Source: AMsMyM6dCpj3wjpMtwzjGOP46+DRGb2A5PRc4PNj927PdfRV6G+pDmrePX26iL7ahW5qL58/pJkgXw==
X-Received: by 2002:a17:907:80b:b0:77a:86a1:db52 with SMTP id wv11-20020a170907080b00b0077a86a1db52mr20599778ejb.294.1666444242121;
        Sat, 22 Oct 2022 06:10:42 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id r9-20020a170906280900b0077b523d309asm12840797ejc.185.2022.10.22.06.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 06:10:41 -0700 (PDT)
Message-ID: <6353ebd1.170a0220.e607e.711a@mx.google.com>
X-Google-Original-Message-ID: <Y1Pryo4btyRLfKGP@Ansuel-xps.>
Date:   Sat, 22 Oct 2022 15:10:34 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] thermal: qcom: tsens: rework debugfs file
 structure
References: <20221022125657.22530-1-ansuelsmth@gmail.com>
 <20221022125657.22530-4-ansuelsmth@gmail.com>
 <591f7038-81ed-1850-b525-d02a4e082903@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <591f7038-81ed-1850-b525-d02a4e082903@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 03:08:46PM +0200, Daniel Lezcano wrote:
> On 22/10/2022 14:56, Christian Marangi wrote:
> > The current tsens debugfs structure is composed by:
> > - a tsens dir in debugfs with a version file
> > - a directory for each tsens istance with sensors file to dump all the
> >    sensors value.
> 
> s/istance/instance/
> 
> The patch looks good to me, no need to resend, I'll fix the typos
>

Thanks for picking this, np for fixing typos.

> > This works on the assumption that we have the same version for each
> > istance but this assumption seems fragile and with more than one tsens
> > istance results in the version file not tracking each of them.
> > 
> > A better approach is to just create a subdirectory for each tsens
> > istance and put there version and sensors debugfs file.
> > 
> > Using this new implementation results in less code since debugfs entry
> > are created only on successful tsens probe.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   drivers/thermal/qcom/tsens.c | 13 +++----------
> >   1 file changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 467585c45d34..fc12d7c07de4 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -704,21 +704,14 @@ DEFINE_SHOW_ATTRIBUTE(dbg_sensors);
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
> > -
> > -	file = debugfs_lookup("version", priv->debug_root);
> > -	if (!file)
> > -		debugfs_create_file("version", 0444, priv->debug_root,
> > -				    pdev, &dbg_version_fops);
> >   	/* A directory for each instance of the TSENS IP */
> >   	priv->debug = debugfs_create_dir(dev_name(&pdev->dev), priv->debug_root);
> > +	debugfs_create_file("version", 0444, priv->debug, pdev, &dbg_version_fops);
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
