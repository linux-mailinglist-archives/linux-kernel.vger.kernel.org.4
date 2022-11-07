Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4679D61F474
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiKGNgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiKGNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:36:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A99A65F5;
        Mon,  7 Nov 2022 05:36:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l14so16272400wrw.2;
        Mon, 07 Nov 2022 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2KT5748vrQwNv05axgctLrrojQ2dZkiY8TujtK+A0ew=;
        b=CaoRQ7UHdn1ni+0XAt5gnQl4npWFFl4sJVVqHr2c7z1kmqqaJJE3/B1/BtIzannMG6
         WFKDkmGqPdMvRHjgF6S+3Mv242mDKbrADpIPu+BraDgUWfQs7vdTe1uM+V4tg5t6LhS6
         H9kw1aZpydumLvfDQe50q9+uc/isiC7OXPnls2DKGvyjjwCAXB+xZYU2uAhO/+fTNMsh
         kbG9oeAA6bl0sJhEFPFf6+noZb8/FebAbTT4GY6IC8atpjtMs86AyVPm9Zr72uzZFQyY
         qpLQQyHF6XsVrVihns04E2eKhso0x//KP+BtI9LaLxb9nKPSbx0ucml6SSIftZK8fUAU
         2Oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KT5748vrQwNv05axgctLrrojQ2dZkiY8TujtK+A0ew=;
        b=Wslcv6ToQ3l7Bb6nYlun5COyM3nczEMO9QbAV7iVzGuhZAhzgjhCxYCTpSklfcOPf6
         k2xo5VuF80piNHMSoyeZ73m5d4NLOuTzR4Lw5aYHOSWhJwVqPl1CEih3W/2ZC5VfFoF2
         oz+Qcv3HMHkD8AoB6QrlGwq1hg7vqR90PXCFmcwyUDqcrPMQTXMGRNH7vOg7uVY0wgpJ
         VzE+4oiwQ93SFoLLZxdJp6u0y5T1E34PUrw/gcifkLbciCg6J9Z1jfC7OCiGaDiRXTg5
         dZTrt9MliDF3Odbf2t+WWlBCWWMZDn2dYZ5lCz9oaUmefbpi7X7qsAQv9nuclPV5FaGn
         Y86Q==
X-Gm-Message-State: ACrzQf2sU6PNW/TJ+ioSRe0tULLRy39apKT4TiXaP0yg/1YdoKKXcgok
        aiwgO/YfaqQMjsV2FD5g/NM=
X-Google-Smtp-Source: AMsMyM6Fax2tTJ9I6ZRMxoVmQZkE1ZXKsw6rCkveL4gfy81TDEtwqxJyQLxmjgo6ge2WSRQocSprCA==
X-Received: by 2002:a05:6000:408a:b0:236:cdf8:1e3f with SMTP id da10-20020a056000408a00b00236cdf81e3fmr566389wrb.80.1667828165661;
        Mon, 07 Nov 2022 05:36:05 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003c6b7f5567csm28304890wms.0.2022.11.07.05.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 05:36:05 -0800 (PST)
Message-ID: <636909c5.050a0220.b7180.f787@mx.google.com>
X-Google-Original-Message-ID: <Y2kJw3VMucF6LasC@Ansuel-xps.>
Date:   Mon, 7 Nov 2022 14:36:03 +0100
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

By checking linux-next it looks like the wrong revision was applied [0].
I think this was done by mistake while fixing the typo. Can this be
fixed? The applied revision conflicts with what we agreed was a good
solution.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/drivers/thermal/qcom/tsens.c

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
