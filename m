Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89269654F69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 12:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiLWLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 06:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWLEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 06:04:37 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECDE5F7C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:04:35 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay40so3397948wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 03:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpe3HlmVRLRgDd/xCeWwgEVPyjK0l2OWmZIW1iIX3RE=;
        b=TpqOTx6Xr0gDJ0p03QNkTSbSaOCdDxuzhnjLVO1iE+CElG+SPM8/7ijxIZzpRFuyCW
         /+rFnLrelHzFF0Hjvhm+CeIuOTJ7TbrXzc3mh6XWx/kvV+PWalycNZ2qQOOqV2YHpDqM
         n3ol7g7ljNVrJqeOy9ba5uU4nP7rL8ibidfeElTUz0TUwDXBCdDWQF2gRRCb7N0vaSRK
         JCw9VxYk9wCuzUvPIGdHx5+6fAuVaiqTkCMCmwtR9FdBnjFkYS64ZaUyhCvBxDP3gpPC
         Bechc1usOvGYDDKD/Km42fd9TU6Rr/G4TG01zN+X4YZUjAJdM6tVyRzBQTfDnybMUEIE
         /S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpe3HlmVRLRgDd/xCeWwgEVPyjK0l2OWmZIW1iIX3RE=;
        b=C6n2WKKwoMrL9amyBEldWMvtDfS2LxcNuhWVw9pZiE8krK5ou0VwomgJZo1X+oRzLG
         +O3tv8k3r3+PdEVitjcFnBLp8xTr1PEU0II2bWMvwqqABFI50/mufbQ7kZT4GBFl+Lcz
         auiY2agyFCFLUrEjw9ow69Ri+nBXZ9CoMSZYsRgnSX7RzhzyCnv/enWqx3H565NjvkJi
         a2cUoQg2sFTalLtspyMFlgb+Sf161BugRC0/Klts2loTL9RhlP0xqfNGXswIxBbeV87s
         znw+hP+i4lSNV7SzDrUdUlagw4UF5XDvTwFjCHesRWcy23ieNx+MC2Sj7rWpuEx+uDNo
         Rvrg==
X-Gm-Message-State: AFqh2ko2wE+O6eTkJIxFGSLjrli72lCEn0zCsKxGdKNExAcPg42x7+v+
        qa4wPzDJ2xINkLfAIIA2W6s=
X-Google-Smtp-Source: AMrXdXsYcG6q1Gu7rzI6imjg516eZsZdAChWRly1cr6hu8sssL//gqqcyvsLmkG9UNDStaBHFObz1Q==
X-Received: by 2002:a05:600c:250:b0:3d2:2043:9cbf with SMTP id 16-20020a05600c025000b003d220439cbfmr6712223wmj.10.1671793474131;
        Fri, 23 Dec 2022 03:04:34 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf57329221sm6755294wmo.14.2022.12.23.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 03:04:33 -0800 (PST)
Date:   Fri, 23 Dec 2022 14:04:30 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Roderick Colenbrander <roderick@gaikai.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/hid-playstation.c:1766 dualshock4_get_calibration_data()
 warn: ignoring unreachable code.
Message-ID: <202212231433.9ZzQA475-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8395ae05cb5a2e31d36106e8c85efa11cda849be
commit: c64ed0cd9324f9e5f44deb6834ad9fb5bfa436bc HID: playstation: add DualShock4 dongle support.
config: parisc-randconfig-m041-20221219
compiler: hppa-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/hid/hid-playstation.c:1766 dualshock4_get_calibration_data() warn: ignoring unreachable code.

Old smatch warnings:
drivers/hid/hid-playstation.c:1923 dualshock4_get_mac_address() error: uninitialized symbol 'buf'.

vim +1766 drivers/hid/hid-playstation.c

12882ed83c5833 Roderick Colenbrander 2022-10-29  1727  static int dualshock4_get_calibration_data(struct dualshock4 *ds4)
12882ed83c5833 Roderick Colenbrander 2022-10-29  1728  {
12882ed83c5833 Roderick Colenbrander 2022-10-29  1729  	struct hid_device *hdev = ds4->base.hdev;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1730  	short gyro_pitch_bias, gyro_pitch_plus, gyro_pitch_minus;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1731  	short gyro_yaw_bias, gyro_yaw_plus, gyro_yaw_minus;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1732  	short gyro_roll_bias, gyro_roll_plus, gyro_roll_minus;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1733  	short gyro_speed_plus, gyro_speed_minus;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1734  	short acc_x_plus, acc_x_minus;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1735  	short acc_y_plus, acc_y_minus;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1736  	short acc_z_plus, acc_z_minus;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1737  	int speed_2x;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1738  	int range_2g;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1739  	int ret = 0;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1740  	uint8_t *buf;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1741  
2d77474a239294 Roderick Colenbrander 2022-10-29  1742  	if (ds4->base.hdev->bus == BUS_USB) {
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1743  		int retries;
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1744  
12882ed83c5833 Roderick Colenbrander 2022-10-29  1745  		buf = kzalloc(DS4_FEATURE_REPORT_CALIBRATION_SIZE, GFP_KERNEL);
12882ed83c5833 Roderick Colenbrander 2022-10-29  1746  		if (!buf)
12882ed83c5833 Roderick Colenbrander 2022-10-29  1747  			return -ENOMEM;
12882ed83c5833 Roderick Colenbrander 2022-10-29  1748  
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1749  		/* We should normally receive the feature report data we asked
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1750  		 * for, but hidraw applications such as Steam can issue feature
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1751  		 * reports as well. In particular for Dongle reconnects, Steam
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1752  		 * and this function are competing resulting in often receiving
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1753  		 * data for a different HID report, so retry a few times.
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1754  		 */
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1755  		for (retries = 0; retries < 3; retries++) {
12882ed83c5833 Roderick Colenbrander 2022-10-29  1756  			ret = ps_get_report(hdev, DS4_FEATURE_REPORT_CALIBRATION, buf,
a23b063b84d0d5 Roderick Colenbrander 2022-10-29  1757  					DS4_FEATURE_REPORT_CALIBRATION_SIZE, true);
12882ed83c5833 Roderick Colenbrander 2022-10-29  1758  			if (ret) {
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1759  				if (retries < 2) {
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1760  					hid_warn(hdev, "Retrying DualShock 4 get calibration report (0x02) request\n");
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1761  					continue;
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1762  				} else {
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1763  					ret = -EILSEQ;
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1764  					goto err_free;
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1765  				}
12882ed83c5833 Roderick Colenbrander 2022-10-29 @1766  				hid_err(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);

This is dead code.

12882ed83c5833 Roderick Colenbrander 2022-10-29  1767  				goto err_free;
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1768  			} else {
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1769  				break;
c64ed0cd9324f9 Roderick Colenbrander 2022-10-29  1770  			}
12882ed83c5833 Roderick Colenbrander 2022-10-29  1771  		}
2d77474a239294 Roderick Colenbrander 2022-10-29  1772  	} else { /* Bluetooth */
2d77474a239294 Roderick Colenbrander 2022-10-29  1773  		buf = kzalloc(DS4_FEATURE_REPORT_CALIBRATION_BT_SIZE, GFP_KERNEL);
2d77474a239294 Roderick Colenbrander 2022-10-29  1774  		if (!buf)
2d77474a239294 Roderick Colenbrander 2022-10-29  1775  			return -ENOMEM;
2d77474a239294 Roderick Colenbrander 2022-10-29  1776  
2d77474a239294 Roderick Colenbrander 2022-10-29  1777  		ret = ps_get_report(hdev, DS4_FEATURE_REPORT_CALIBRATION_BT, buf,
2d77474a239294 Roderick Colenbrander 2022-10-29  1778  				DS4_FEATURE_REPORT_CALIBRATION_BT_SIZE, true);
2d77474a239294 Roderick Colenbrander 2022-10-29  1779  		if (ret) {
2d77474a239294 Roderick Colenbrander 2022-10-29  1780  			hid_err(hdev, "Failed to retrieve DualShock4 calibration info: %d\n", ret);
2d77474a239294 Roderick Colenbrander 2022-10-29  1781  			goto err_free;
2d77474a239294 Roderick Colenbrander 2022-10-29  1782  		}
2d77474a239294 Roderick Colenbrander 2022-10-29  1783  	}
12882ed83c5833 Roderick Colenbrander 2022-10-29  1784  
12882ed83c5833 Roderick Colenbrander 2022-10-29  1785  	gyro_pitch_bias  = get_unaligned_le16(&buf[1]);
12882ed83c5833 Roderick Colenbrander 2022-10-29  1786  	gyro_yaw_bias    = get_unaligned_le16(&buf[3]);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp


