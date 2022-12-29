Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243B2658AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiL2J3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiL2J3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:29:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00F13D70;
        Thu, 29 Dec 2022 01:29:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t15so8069330wro.9;
        Thu, 29 Dec 2022 01:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQjUzt0TYzPClWLYVG06i7EaST8h2wDOVIpEzBnJCKM=;
        b=IqTbHq4xT4HYduozrFDpiDA7xJ9I+5OnwguxGsOfY3/321zoGjQt8+6WV4s/5EG1Ao
         VVPVp6PPpUyzgnG1R5QXST2wikq1yDOK/Qx3/CUd2u5+f6abRfL+Vygdxi3h2OIsR1ZF
         cWGPdbDZJ5lrSLGF+tgXTMYY9hteZOYzcwx0qoIN/EYJtAet2+xmjRw4pazNK0aXL4Hs
         JKRFPHCkir35PSkPzwjWdurWmqdhKfLW8nZPy2nlXVs5wdjw0SeLirjyMjagC2cf9iUU
         m6wrUlN7hEwtsNR12bZ8n4qSV5y4N4QSnmdtnqnq55t952J0IK+Bflia6v1E0uCQgM61
         7cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQjUzt0TYzPClWLYVG06i7EaST8h2wDOVIpEzBnJCKM=;
        b=ZOkkU2p0dbuxf/k0PLa9slimdu5dpV+rhM3ecZp0x5T00FXr1z28fWtVHxpWqCMMrk
         5XU0ZGoHg6QDCE6wADNlHp1zkRnZAMEiKBJCwsQTDo0oIdDd/CpPBpAgSmWXASARTOQV
         b5ZgFKn6AhAGshprGktxr9O3aaQJ0OzPpJG32U2RgRjwvN0lqqH+6ftusdCB9OfQ6aBJ
         0zwSpf0mU6eXR2K2j3WzlqWQWC/PqPZUbCNcqpya1PHcOmlvMeh4pM9WrU+4B0s17v4H
         W7q+RuxNgqwM0UkjnibsVee4X4xOdH7PkVYR0HGs2m4w7Hsw6CbB8YFr2/6DXIFheGB4
         BMxw==
X-Gm-Message-State: AFqh2kpEmH+9Sg/yn+RGec2cosLAWtm0WklYu2tdkLXs+6IDXZYVV2/p
        s7/SPohnYzJ1VCu4oJPKA1U=
X-Google-Smtp-Source: AMrXdXvpWbDjkYnrUfS5uRT4UDoc3xE2G3Tlimu2DTpvAxWp+BIGeZObuZyRRKFe3+Mwk7ax6JNEHA==
X-Received: by 2002:a05:6000:10e:b0:272:4d0b:366b with SMTP id o14-20020a056000010e00b002724d0b366bmr14027014wrx.38.1672306168168;
        Thu, 29 Dec 2022 01:29:28 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d414a000000b0024242111a27sm17819412wrq.75.2022.12.29.01.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 01:29:27 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:29:24 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Joshua Goins <josh@redstrate.com>,
        linux-input@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, jikos@kernel.org,
        benjamin.tissoires@redhat.com, kurikaesu@users.noreply.github.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Message-ID: <202212261746.hBtGGDW4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2068502.VLH7GnMWUR@adrastea>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Goins/HID-uclogic-Add-support-for-XP-PEN-Artist-22R-Pro/20221226-112302
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/2068502.VLH7GnMWUR%40adrastea
patch subject: [PATCH] HID: uclogic: Add support for XP-PEN Artist 22R Pro
config: i386-randconfig-m021-20221226
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/hid/hid-uclogic-params.c:1453 uclogic_params_init_ugee_xppen_pro() warn: variable dereferenced before check 'hdev' (see line 1447)
drivers/hid/hid-uclogic-params.c:1454 uclogic_params_init_ugee_xppen_pro() warn: possible memory leak of 'buf'
drivers/hid/hid-uclogic-params.c:1492 uclogic_params_init_ugee_xppen_pro() error: double free of 'buf'

Old smatch warnings:
drivers/hid/hid-uclogic-params.c:1502 uclogic_params_init_ugee_xppen_pro() error: double free of 'buf'

vim +/hdev +1453 drivers/hid/hid-uclogic-params.c

51d8c9b14fc55dc Aren Villanueva 2022-12-25  1436  static int uclogic_params_init_ugee_xppen_pro(struct hid_device *hdev,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1437  					      struct uclogic_params *p,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1438  					      const u8 probe_endpoint,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1439  					      const u8 rdesc_init_packet[],
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1440  					      const size_t rdesc_init_size,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1441  					      const u8 rdesc_tablet_arr[],
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1442  					      const size_t rdesc_tablet_size,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1443  					      const u8 rdesc_frame_arr[],
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1444  					      const size_t rdesc_frame_size)
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1445  {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1446  	const size_t str_desc_len = 12;
51d8c9b14fc55dc Aren Villanueva 2022-12-25 @1447  	struct usb_device *udev = hid_to_usb_dev(hdev);
                                                                                                 ^^^^
Dereference.

51d8c9b14fc55dc Aren Villanueva 2022-12-25  1448  	u8 *buf = kmemdup(rdesc_init_packet, rdesc_init_size, GFP_KERNEL);

Never put functions which can fail in the declaration block.  This
allocation has no check for NULL (common problem when done in
declaration block).

51d8c9b14fc55dc Aren Villanueva 2022-12-25  1449  	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1450  	int actual_len, rc;
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1451  	u16 resolution;
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1452  
51d8c9b14fc55dc Aren Villanueva 2022-12-25 @1453  	if (hdev == NULL || p == NULL)
                                                            ^^^^^^^^^^^^
Checked to late.

51d8c9b14fc55dc Aren Villanueva 2022-12-25 @1454  		return -EINVAL;

Needs a kfree(buf);

51d8c9b14fc55dc Aren Villanueva 2022-12-25  1455  
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1456  	rc = usb_interrupt_msg(
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1457  		udev,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1458  		usb_sndintpipe(udev, probe_endpoint),
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1459  		buf,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1460  		rdesc_init_size,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1461  		&actual_len,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1462  		USB_CTRL_SET_TIMEOUT);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1463  	kfree(buf);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1464  	if (rc == -EPIPE) {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1465  		hid_err(hdev, "broken pipe sending init packet\n");
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1466  		return rc;
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1467  	} else if (rc < 0) {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1468  		hid_err(hdev, "failed sending init packet: %d\n", rc);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1469  		return rc;
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1470  	} else if (actual_len != rdesc_init_size) {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1471  		hid_err(hdev,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1472  			"failed to transfer complete init packet, only %d bytes sent\n",
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1473  			actual_len);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1474  		return -1;
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1475  	}
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1476  
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1477  	rc = uclogic_params_get_str_desc(&buf, hdev, 100, str_desc_len);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1478  	if (rc != str_desc_len) {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1479  		if (rc == -EPIPE) {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1480  			hid_err(hdev,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1481  				"string descriptor with pen parameters not found\n");
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1482  		} else if (rc < 0) {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1483  			hid_err(hdev,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1484  				"failed retrieving pen parameters: %d\n", rc);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1485  		} else {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1486  			hid_err(hdev,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1487  				"string descriptor with pen parameters has invalid length (got %d, expected %lu)\n",
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1488  				rc,
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1489  				str_desc_len);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1490  			rc = -1;
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1491  		}
51d8c9b14fc55dc Aren Villanueva 2022-12-25 @1492  		kfree(buf);

If uclogic_params_get_str_desc() fails then this is a double free.

51d8c9b14fc55dc Aren Villanueva 2022-12-25  1493  		return rc;
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1494  	}
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1495  
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1496  	desc_params[UCLOGIC_RDESC_PEN_PH_ID_X_LM] = get_unaligned_le16(buf + 2);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1497  	desc_params[UCLOGIC_RDESC_PEN_PH_ID_Y_LM] = get_unaligned_le16(buf + 4);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1498  	/* buf + 6 is the number of pad buttons? Its 0x0008 */
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1499  	desc_params[UCLOGIC_RDESC_PEN_PH_ID_PRESSURE_LM] =
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1500  		get_unaligned_le16(buf + 8);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1501  	resolution = get_unaligned_le16(buf + 10);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1502  	kfree(buf);
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1503  	if (resolution == 0) {
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1504  		hid_err(hdev, "resolution of 0 in descriptor string\n");
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1505  		return -1;
51d8c9b14fc55dc Aren Villanueva 2022-12-25  1506  	}

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

