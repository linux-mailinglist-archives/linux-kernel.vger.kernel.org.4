Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117356B78AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCMNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCMNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:17:20 -0400
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 06:17:18 PDT
Received: from ofcsgdbm.dwd.de (ofcsgdbm.dwd.de [141.38.3.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB848E2D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:17:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTP id 4PZxpv6lZmz2wML
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
        content-type:content-type:mime-version:message-id:subject
        :subject:from:from:date:date:received:received:received:received
        :received:received:received:received; s=dwd-csg20210107; t=
        1678713031; x=1679922632; bh=a6zq0ZHbn8Ul6+P0t6VHiaGX0lfQuULZXFp
        9OAVqJ5w=; b=Y3NbGRNy3AUCDGrvrPpi/LjNcdbIGqB8z0fY2DxR6D+ov30hh/8
        jIFw5fzvdLfe2RgVHAR5OT21O2UoUlqJDJaafvwP8BaJjiBJNAja4GyEnVyE7mWE
        vcfEAsZX1li11DdNKTBoQ2jB/dgNr+JK/kQgJDxi7gtdRZhTsISgPRcNJyZd4fTV
        4ekLaWrK9NCQ4dtjiNHKPO1a85w0R+JT+IqVGEoZtSJdf3YVUwz9mgl7jlmM9kpL
        NDLVuxdz1lvihV6a9YdtBWdZEz5x/8e0NccUExjOXIXlEYDG0VlSDggwlzTHfP9S
        G/1yxvL1JMIm7ImqD+ZRVVuQMuH7QKlVh3Q==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2cteh1.dwd.de ([172.30.232.65])
 by localhost (ofcsg2dn3.dwd.de [172.30.232.26]) (amavisd-new, port 10024)
 with ESMTP id yVzQgfpOd5qk for <linux-kernel@vger.kernel.org>;
 Mon, 13 Mar 2023 13:10:31 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id B5101C902C7B
        for <root@ofcsg2dn3.dwd.de>; Mon, 13 Mar 2023 13:10:31 +0000 (UTC)
Received: from ofcsg2cteh1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id A8B3CC902C34
        for <root@ofcsg2dn3.dwd.de>; Mon, 13 Mar 2023 13:10:31 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.26])
        by ofcsg2cteh1.dwd.de (Postfix) with ESMTP
        for <root@ofcsg2dn3.dwd.de>; Mon, 13 Mar 2023 13:10:31 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Mon, 13 Mar 2023 13:10:31 -0000
Received: from ofcsg2dvf2.dwd.de (ofcsg2dvf2.dwd.de [172.30.232.11])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTPS id 4PZxpv4Shrz2wML;
        Mon, 13 Mar 2023 13:10:31 +0000 (UTC)
Received: from ofmailhub.dwd.de (ofmailhub.dwd.de [141.38.39.196])
        by ofcsg2dvf2.dwd.de  with ESMTP id 32DDAVE4021349-32DDAVE5021349;
        Mon, 13 Mar 2023 13:10:31 GMT
Received: from praktifix.dwd.de (praktifix.dwd.de [141.38.44.46])
        by ofmailhub.dwd.de (Postfix) with ESMTP id 730E3E26D2;
        Mon, 13 Mar 2023 13:10:31 +0000 (UTC)
Date:   Mon, 13 Mar 2023 13:10:31 +0000 (GMT)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon: (nct6775) add Asus Pro A520M-C II/CSM
Message-ID: <868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="646786604-2096725857-1678713031=:1647830"
X-FEAS-Client-IP: 141.38.39.196
X-FE-Last-Public-Client-IP: 141.38.39.196
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-9.0.1002-27500.007
X-TMASE-Result: 10--0.544100-10.000000
X-TMASE-MatchedRID: 54gb2yeIOXQKcsqwFvHPpZGzIhDiMWXrm+DHlE+ssdDbwrIdcV7mW9mw
        Qde3CIwayPWKi2J7rbTlgULyZ+0QfaZTCp7W/He3ASoGV8JrJg31+9bO3CCbk8C5DTEMxpeQ38b
        Hk6Pl8X1/XjpbSJS7a0NziVKCujClwG9P01lFxWXi8zVgXoAltnS4vQrt84k3wrbXMGDYqV+8bR
        Ued1HGApLRodsDsRTAAcTRAXiI1anWW2YoKwhdnUUjywkdcMMgQbQop27i6wwZGC3E/epWpm49R
        pMKzOm5ottZkIYeDOGDhTuQFwWOoYUozDgi4nhXekI2ow+xm4Ub2xdIiL0Uv161uUBD8bm1
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646786604-2096725857-1678713031=:1647830
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

An NCT6798D chip is now detected:

   dmesg|grep nct6775
   [   23.765392] nct6775: Found NCT6798D or compatible chip at 0x2e:0x290

And sensors now shows:

   nct6798-isa-0290
   Adapter: ISA adapter
   in0:                      312.00 mV (min =  +0.00 V, max =  +1.74 V)
   in1:                        1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in2:                        3.42 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in3:                        3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in4:                        1.03 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in5:                        1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in6:                      200.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
   in7:                        3.42 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in8:                        3.28 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in9:                      920.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
   in10:                     512.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
   in11:                     504.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
   in12:                       1.03 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in13:                     256.00 mV (min =  +0.00 V, max =  +0.00 V)  ALARM
   in14:                       1.47 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   fan1:                        0 RPM  (min =    0 RPM)
   fan2:                        0 RPM  (min =    0 RPM)
   fan3:                      355 RPM  (min =    0 RPM)
   fan7:                        0 RPM  (min =    0 RPM)
   SYSTIN:                    +25.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
   CPUTIN:                    +26.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
   AUXTIN0:                   +97.0°C    sensor = thermistor
   AUXTIN1:                   +25.0°C    sensor = thermistor
   AUXTIN2:                   +25.0°C    sensor = thermistor
   AUXTIN3:                    +1.0°C    sensor = thermistor
   PECI Agent 0 Calibration:  +26.0°C
   PCH_CHIP_CPU_MAX_TEMP:      +0.0°C
   PCH_CHIP_TEMP:              +0.0°C
   PCH_CPU_TEMP:               +0.0°C
   TSI0_TEMP:                 +27.9°C
   intrusion0:               ALARM
   intrusion1:               OK
   beep_enable:              disabled

Signed-off-by: Holger Kiehl <holger.kiehl@dwd.de>
Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
---

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 76c6b564d7fc..1e6abfc7974d 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1052,6 +1052,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
 static struct platform_device *pdev[2];
 
 static const char * const asus_wmi_boards[] = {
+	"Pro A520M-C II",
 	"PRO H410T",
 	"ProArt B550-CREATOR",
 	"ProArt X570-CREATOR WIFI",
--646786604-2096725857-1678713031=:1647830--

