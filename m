Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125B96BDE97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 03:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCQC0f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Mar 2023 22:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQC0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 22:26:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48836782A;
        Thu, 16 Mar 2023 19:26:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32H2Psz26013272, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32H2Psz26013272
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 17 Mar 2023 10:25:54 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Mar 2023 10:25:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 17 Mar 2023 10:25:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Fri, 17 Mar 2023 10:25:12 +0800
From:   Phinex Hung <phinex@realtek.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
Thread-Topic: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Thread-Index: AQHZVzfsuBPt1OfUHEer519nIXIgnK77czOAgAE6SgD//4V8AIAAjaUA//+VWgCAAK9BgIAAA6MA///XXIAAEq5YAP//vO8A//71L9A=
Date:   Fri, 17 Mar 2023 02:25:12 +0000
Message-ID: <32659f71a1784b5484e63152eec29234@realtek.com>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
 <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
 <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
 <5c805125-4cb5-cdf8-6b50-5a6ce7e97149@roeck-us.net>
 <2686E7B8-BD3F-4C86-97B6-447343BFCF22@realtek.com>
 <A6DF8FB3-6318-40CD-A364-603A3E581511@realtek.com>
 <8c835412-f78f-570d-30a5-24f4c02a8438@roeck-us.net>
 <4BC6E9A7-13A6-429F-A586-AC60DC505838@realtek.com>
 <2b1e7e29-daa6-4f24-9fad-7ebe8b87a5fe@roeck-us.net>
In-Reply-To: <2b1e7e29-daa6-4f24-9fad-7ebe8b87a5fe@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.177.136]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday, March 17 at 2023 2:18 AM , Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck wrote:


>Yes, except of course for the bugs (see below). That is much less than perfect, of course, since we'd really want the device node for the drive, not the controller, but it might be the best we can do.

See, thanks for the review, looks better and bug-less than my draft version.

Should I submit this patch again using the code snippet that we discussed? Or any suggestions ?

>> Or is it reasonable that we just match a specific compatible string and assign the device node to the original dev->parent used in drivetemp_add function ?
>>

>We can't add anything to the parent device node since we don't own it.
>Also, I don't know if devicetree maintainers would accept the concept of "virtual" device nodes (and I don't know how device nodes for drives would or should look like either).

What I am thinking about is "virtual" device nodes as well, such as..

@@ -99,6 +99,7 @@
                status = "okay";

                sata_port0: sata-port@0 {
+                       compatible = "drivetemp,hdd-sensors";
                        reg = <0>;
                        phys = <&sata_phy 0>;
                        resets = <&clkc RTD1295_RSTN_SATA_0>,
@@ -110,6 +110,7 @@
                };

                sata_port1: sata-port@1 {
+                       compatible = "drivetemp,hdd-sensors";
                        reg = <1>;
                        phys = <&sata_phy 1>;
                        resets = <&clkc (RTD1295_RSTN_SATA_1 | RTD1295_RSTN_REG_BANK_4)>,

And patches in the drivetemp.c itself..

--- a/drivers/hwmon/drivetemp.c
+++ b/drivers/hwmon/drivetemp.c
@@ -107,6 +107,7 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_driver.h>
 #include <scsi/scsi_proto.h>
+#include <linux/of.h>

 struct drivetemp_data {
        struct list_head list;          /* list of instantiated devices */
@@ -525,6 +526,7 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
 {
        struct scsi_device *sdev = to_scsi_device(dev->parent);
        struct drivetemp_data *st;
+       static struct device_node *node = NULL;
        int err;

        st = kzalloc(sizeof(*st), GFP_KERNEL);
@@ -540,6 +542,11 @@ static int drivetemp_add(struct device *dev, struct class_interface *intf)
                goto abort;
        }

+       node = of_find_compatible_node(node, NULL, "drivetemp,hdd-sensors");
+
+       if(node)
+               dev->parent->of_node = node;
+
        st->hwdev = hwmon_device_register_with_info(dev->parent, "drivetemp",
                                                    st, &drivetemp_chip_info,
                                                    NULL);

Doing this can get my two HDD works for two thermal zones.

If "virtual" device node can be used, then we don't need to patch the hwmon.c core ?

>> -       hdev->of_node = dev ? dev->of_node : NULL;
>> +       while(!tdev->of_node)

>          while (tdev && !tdev->of_node)

Thanks for this review, checking tdev can avoid endless loop. My fault for this.


> >-       if (dev && dev->of_node && chip && chip->ops->read &&
> >+       if (tdev && tdev->of_node && chip && chip->ops->read &&

>This could probably be simplified to
>          if (hdev->of_node && chip && ..

Looks better and simpiler.

Thanks

Regards,
Phinex

