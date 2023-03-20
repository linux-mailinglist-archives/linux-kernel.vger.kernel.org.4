Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF296C1D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjCTRDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjCTRCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:02:46 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31DC35EEB;
        Mon, 20 Mar 2023 09:56:40 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id cn12so3700072edb.4;
        Mon, 20 Mar 2023 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679331227;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQaiq3c8AErj46+nAd9bRzysZn6Nit9oKxFF/uzA6ZY=;
        b=XLXGznIWTse4g72jBalGTVuO4XVQHWbXpsblQKs5+TIPDlg66QC7IA+FW7z/BsiMUF
         nXkeXODui8DUaAlVk8ZOJWP0AHvcta+yZA0dYhh+6JWP7gicCghZQe7qnppFrZfNz+OA
         CsWNtaK24mf6ksmuXrPI0/V4uzRzNa4Psze6iwqwR38CFv2WPxE+YsLPFhNKUfwMQt70
         F46u7xXqjebCBg92KHY3WpSgWgIiWZVfzJnj0rr1XIimaSPkoLX4v3MTyEKI3FZBun9J
         KtHlAze8/Qf1q3vzFLHI61mxcRcQ7ed99phZ/gUXKvqCdUnUK7cwYRcysw5uT/mVlcYn
         TIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331227;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQaiq3c8AErj46+nAd9bRzysZn6Nit9oKxFF/uzA6ZY=;
        b=K3MitngBE/1AOI45kq4DYGZ2D/xpiO7Hl0nEM/NJnwx3qbomM1xIeEN7csiScO4SjB
         1E3iQBhB0oEiwR0Pw2KZSCog283yCakTf9tyUZc94fKHAxp4mjDPHmV3JUENTW6CSmyq
         HG16K7bc0oMIE30YL5VbBQPDjw5/IFRYVkuDN3W4S+W9/e/T2kMomknXUKCwfZyD08j/
         WOkZIxF/9uBhZ/EXFVhZBQ+bs7EndD6qytbkeFOw+1o6H5aqGDBer0Ma0577wNg1RzI3
         CNQ97n4GWj5OLjUVW2OYMGThVwrJMfn5tD7JRUJ1CjeQ8KpYOXH9PrFkWhyvFfgqP0rb
         ENgA==
X-Gm-Message-State: AO0yUKW+4RVQf+vjyanIBxc9S/Fl9jEZl6ULW16qfMCcLHqwndTxJgMC
        ETwLwbyIA+DQRpuIzKze3kT047m7qYBJh3+f6Zw=
X-Google-Smtp-Source: AK7set/ZrOQcudlVdkbdkFSyZG3bMOhCixbmhOUTO0k0dkNKA+rdjkOjyMHtmLOpNKXmX/lJg/HElQ==
X-Received: by 2002:a17:906:5915:b0:931:99b5:5a23 with SMTP id h21-20020a170906591500b0093199b55a23mr12109184ejq.44.1679331226796;
        Mon, 20 Mar 2023 09:53:46 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.111.78])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906289700b00922547486f9sm4735417ejd.146.2023.03.20.09.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:53:46 -0700 (PDT)
Date:   Mon, 20 Mar 2023 21:53:42 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: remove camel case
Message-ID: <ZBiPlhkqHUegMRAb@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several variables and functions were named Camel Case. This resulted in
checks pointed by checkpatch.pl

Avoid camel case by changing names.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 64 ++++++++++++++---------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 79467f056a05..49702beeac30 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -672,7 +672,7 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,
 		adt7316_store_da_high_resolution,
 		0);

-static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
+static ssize_t adt7316_show_AIN_internal_vref(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -686,7 +686,7 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
 		!!(chip->config3 & ADT7516_AIN_IN_VREF));
 }

-static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
+static ssize_t adt7316_store_AIN_internal_vref(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -713,9 +713,9 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 	return len;
 }

-static IIO_DEVICE_ATTR(AIN_internal_Vref, 0644,
-		adt7316_show_AIN_internal_Vref,
-		adt7316_store_AIN_internal_Vref,
+static IIO_DEVICE_ATTR(AIN_internal_vref, 0644,
+		adt7316_show_AIN_internal_vref,
+		adt7316_store_AIN_internal_vref,
 		0);

 static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
@@ -796,7 +796,7 @@ static IIO_DEVICE_ATTR(enable_proportion_DACB, 0644,
 		       adt7316_store_enable_prop_DACB,
 		       0);

-static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
+static ssize_t adt7316_show_DAC_2vref_ch_mask(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -807,7 +807,7 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
 		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
 }

-static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
+static ssize_t adt7316_store_DAC_2vref_ch_mask(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -834,9 +834,9 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
 	return len;
 }

-static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, 0644,
-		       adt7316_show_DAC_2Vref_ch_mask,
-		       adt7316_store_DAC_2Vref_ch_mask,
+static IIO_DEVICE_ATTR(DAC_2vref_channels_mask, 0644,
+		       adt7316_show_DAC_2vref_ch_mask,
+		       adt7316_store_DAC_2vref_ch_mask,
 		       0);

 static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
@@ -957,7 +957,7 @@ static IIO_DEVICE_ATTR(update_DAC, 0644,
 		       adt7316_store_update_DAC,
 		       0);

-static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
+static ssize_t adt7316_show_DA_AB_vref_bypass(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -968,7 +968,7 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
 }

-static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
+static ssize_t adt7316_store_DA_AB_vref_bypass(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -991,12 +991,12 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 	return len;
 }

-static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, 0644,
-		       adt7316_show_DA_AB_Vref_bypass,
-		       adt7316_store_DA_AB_Vref_bypass,
+static IIO_DEVICE_ATTR(DA_AB_vref_bypass, 0644,
+		       adt7316_show_DA_AB_vref_bypass,
+		       adt7316_store_DA_AB_vref_bypass,
 		       0);

-static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
+static ssize_t adt7316_show_DA_CD_vref_bypass(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -1007,7 +1007,7 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
 }

-static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
+static ssize_t adt7316_store_DA_CD_vref_bypass(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -1030,12 +1030,12 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 	return len;
 }

-static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, 0644,
-		       adt7316_show_DA_CD_Vref_bypass,
-		       adt7316_store_DA_CD_Vref_bypass,
+static IIO_DEVICE_ATTR(DA_CD_vref_bypass, 0644,
+		       adt7316_show_DA_CD_vref_bypass,
+		       adt7316_store_DA_CD_vref_bypass,
 		       0);

-static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
+static ssize_t adt7316_show_DAC_internal_vref(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -1050,7 +1050,7 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 		       !!(chip->ldac_config & ADT7316_DAC_IN_VREF));
 }

-static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
+static ssize_t adt7316_store_DAC_internal_vref(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -1091,9 +1091,9 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 	return len;
 }

-static IIO_DEVICE_ATTR(DAC_internal_Vref, 0644,
-		       adt7316_show_DAC_internal_Vref,
-		       adt7316_store_DAC_internal_Vref,
+static IIO_DEVICE_ATTR(DAC_internal_vref, 0644,
+		       adt7316_show_DAC_internal_vref,
+		       adt7316_store_DAC_internal_vref,
 		       0);

 static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
@@ -1653,13 +1653,13 @@ static struct attribute *adt7316_attributes[] = {
 	&iio_dev_attr_da_high_resolution.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
-	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
+	&iio_dev_attr_DAC_2vref_channels_mask.dev_attr.attr,
 	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
 	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
 	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_DA_AB_vref_bypass.dev_attr.attr,
+	&iio_dev_attr_DA_CD_vref_bypass.dev_attr.attr,
+	&iio_dev_attr_DAC_internal_vref.dev_attr.attr,
 	&iio_dev_attr_VDD.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
 	&iio_dev_attr_ex_temp.dev_attr.attr,
@@ -1693,15 +1693,15 @@ static struct attribute *adt7516_attributes[] = {
 	&iio_dev_attr_enable_smbus_timeout.dev_attr.attr,
 	&iio_dev_attr_powerdown.dev_attr.attr,
 	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
-	&iio_dev_attr_AIN_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_AIN_internal_vref.dev_attr.attr,
 	&iio_dev_attr_da_high_resolution.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
-	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
+	&iio_dev_attr_DAC_2vref_channels_mask.dev_attr.attr,
 	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
 	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
 	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_DAC_internal_vref.dev_attr.attr,
 	&iio_dev_attr_VDD.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
 	&iio_dev_attr_ex_temp_AIN1.dev_attr.attr,
--
2.34.1

