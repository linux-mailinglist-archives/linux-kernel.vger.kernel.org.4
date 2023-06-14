Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6511C72F4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjFNGaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243179AbjFNG33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:29:29 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2097.outbound.protection.outlook.com [40.92.59.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD02102;
        Tue, 13 Jun 2023 23:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGrhvYFsUAJQM0PHPCBy3c9uwl7KoZhnjvnW03q++r2Gj9YhufJRkgj0C97+6OsNl6oXXRIFJjYo65Z1q2hUlycthykFiDOtel060RJcn76gSRa/31RnDADc0CBcfHSRFKB/zIkzBznGKaOijtTuMK22FEEauYqgnxmY5qqvxayvZq+OAx10pV6VBQvZ/SIvwnPEAuCx3z/RwtG3pgrtlvwLHzCUAyPRX/MSPUtHGhJAyNLKQhNu6wMKDEcU/yd7gJs1D7YoUdHe71N75j1BG0N2e2MgFf4fOr6ICC4CJXyhYGCgI3QnpEf4ncGYHpAbTU5wkzDq1RgkfdpwIFvHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4ztIYSyuNhSxWFttmUJQdXlXz3wECbts3tnhkCTfT4=;
 b=M3SHuAcoTGvap5+Z+fbCj5Gn+aiX5NeK0PNdK47gTqY+Y9PDlrfNp5eisdUeYfye2ODbMoy/gf0g8pxgsXAsd5sdQ+dWIObyPUQLBty8rPE89pRa1l2pbbURJozU/Bvz5Q/RFcLKLz5kqTtWv1WTzA7CSDWVI5Gt/JUBZ7lK0+pgVM19oGIZR+LNQjCqduoabACjbVF5OJqWRb2xZN9F/BDaGE83+VCwE6soDV31x4hqg3m2JysmWLt6648+BbF0SjhsqG8cOvdKvtheXwR72LaJfwIgyVBqOX7PhjUqX1Y9xZB6Zao8HNVfcMCuOYMe/rZC3IbTa3sd6Ybw1pPJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4ztIYSyuNhSxWFttmUJQdXlXz3wECbts3tnhkCTfT4=;
 b=bXlZ2MqurA5H3BwrE96tnoY5OsvzTNxoZoaTmFY21PMTEGzTzIDLMKiA5R1Kl0BA07M1116nou2pIb1YisI5SQz/4JwmRLhVa4k8PTTfxwFQNHIcsYYv2TWjpPqrWRFbSHFKlaCdFD5r20yDp99ltzmX+NwXV9WqjRZrFyhpyRKjCUmc+EvmiVF7St/6+pm3IsOJiXmkX/JT1tQCv1u7Rsocd/4eC9nQsMaGNH65DAK1lZc2Q0oNNwCcH+G9XocikpkoGdY+RHf2AvaDxSJdcgmiMvP7ts44A7Yld/NFB4JM/kR34jJKQQagZyrwQ+QYExyWYTIppFiVoNTa3+46gg==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by AS1PR10MB5601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:478::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 14 Jun
 2023 06:29:18 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 06:29:18 +0000
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        JuenKit Yip <JuenKit_Yip@hotmail.com>
Subject: [PATCH 3/3] hwmon: (sht3x)add new non-stardard sysfs interface
Date:   Wed, 14 Jun 2023 14:28:43 +0800
Message-ID: <DB4PR10MB6261C3FAA8B183F94B007163925AA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [34bP/Isi1jIGgTIKxsGpxRwWq5jDMX7O]
X-ClientProxiedBy: TYCP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::11) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <20230614062843.888225-1-JuenKit_Yip@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|AS1PR10MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea40210-c86b-4529-8d03-08db6ca0ae7c
X-MS-Exchange-SLBlob-MailProps: 5fu/r660v9PvfFeBhIdXTOajjuRTH3Fbkt9oQBP2HWLQSHV22AkrgfAHkhLa77SuidZ+rcKFzpXiL4iRTFmoJ+5StkLwF2TRDIkon1tGEuyfOTRL4Mco74VW/VYYUXt/hbh9n7TMjCBGCPhd+/G518RH8+uTIoeLppXnvyh21h0/Uzm+2lngWhGvZicDEJ6etZ6kJGgQHjuehKA9FI+N8vHwWSP+TemM6OVYYMUwzW7UoTdSU4LAt9cf7k+gcg92IlDpZn6JE30tO3Lgu/DclVre3IpxR9l9PaFpvZSiNBhRAD5VljWn7TRctm/1aIorfxO+TnwJt2vb3L0vGqAy4N+U857+VQQ4PZ07SrcPlV3pzcLwy5Cnd6Aca0HE5uKdPd+oDS8lrGiMEisPmMIi+fKiVjLUYeNpeVdX30AsAX6wfaDmR9QXNVBKZzYa4y9ooFk+oAAuWY9/MIyeMvVvMoRV1v5wk6TDbYefGZGr+rGJl1jNXGTCcmb8SFi+7sd04BbSYSt/VuAcDb6dpGYyLXsGTw618gyQYSCHpN8QTreZgb14rYst+w4U/8q2BfxbjTnQ3uhW5cBIWOcCuR7A2qD+TRmyba2W+Mh1zj68zgfZ1YqZmOddEyUCg3lWWnV3vkbWPCQ2D55FQRRgNXg9CECN+I0AkH1wtCN5u0qtAmpSLQSg6y0rJyHmPD+JuO1RwzxcUaNAMgQkNFIRyE9oSUKvIheeFAzlxAXWA6HMKRw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ngS9rIOS6Xh6A6g3HHzRWNkYG7iZzQwdpXCzFYY31uBGeNJLykmrZ2kSzEpQ8Zs0ER9ch8IfwKcSDSEwXZOt6Q2DZEQfXFngbYOwEaXjQBFyAe+MsQNVJoTfMe9wbm7JOZ1IZgKH7Jwjv3RyQ0kQ0qFF+X3TA3jMDeX7dEuvE++vn+llzItoMhx2D7cE4YO4Ehghz7sRCrdHWLdxaxV/BzYsO8J5G8apXQeEfsOqMW/j6JOpwFGDCCjBb/fDin/7ehKoWDA3JtUtp73CatJNuk43RAzgQJ2lc7+0UQc+erWeLmOM+ivCDy7DgO9/GYtdYkiroBK8zLkQRzuftoCy9dhtBqI5UMqGeftkICgye+95x3jvotGGdzGePR2zRnt8Zpn3Smf+ba6ePIyN5uiJf/3mNZ8LU/L4wMxAEDn5yWv9exj1xc8qSOqKSLxRyIy+fstvTq7+bFsctOD5vPHUeCZCs2dkyUHxGCGvGFMnYssFG2CGSvnpyk0sQh62N557+Ev9OAd4Za6r+SUl5BgUJQImOdBFdNBxi/RY3opxaLACfYZYYJcDpcy46l9Y1EBRVB6lg+jdlohBLFrtliHaatOGsk4T0Z7tKOXVZsh0fAPouTFyDIa6ovBE1iT2vB7
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q4x+bev22q+0aJrddFidqo66u7jrVkI5yMcflV+vj+suJGibtbeXsg9GG8zz?=
 =?us-ascii?Q?gNCiIPYEcn0krN220Pzdub9OhiZHG6xtAGCiS8OyzJKjXCQw6qi3c+k6dDro?=
 =?us-ascii?Q?n4/s40AEZWoAwjOV+2V8CcI8xxcB0WNrbW1IK5Ocu/jOfO5tE5RjhKsv1MEQ?=
 =?us-ascii?Q?Yb3TWundxjmnxn4m5Ak2C7E+TrYggOJsEJDBoFHAn1NNdxzg8T6zAPy31o0x?=
 =?us-ascii?Q?q3IfqV0+wsWrzwm1lxauuFuH7G1R2rpU8hNhHBrxl/RowpktjowVPdEwgvPZ?=
 =?us-ascii?Q?gSAVz494WAgVgAKCfXfzZ9jwTtJ+lMuEm/m7p/o4rwYUxAqzASggEeXtZLsN?=
 =?us-ascii?Q?ur80ZhAM6DLebHTyhWCVJIoU5G63tmJQU3IazN1VKxwopNnkE+2+kxHRGjjy?=
 =?us-ascii?Q?YYto8ObTg+gSZJrxnBp154msa1+y+nPHt8d9Rc94Yv6xzkXMguxvsi76oKQ8?=
 =?us-ascii?Q?OPqExN2YrH0gl1pVp2eqk6bSAakpWLYQLWkFWzhgyTlMNMmRtt3ANCljPt7R?=
 =?us-ascii?Q?u/AB0UbcfBM367vFfyt3UnY6z/UCZrNWRb1xgzYai8BJXNMzktrXkrHmghGA?=
 =?us-ascii?Q?DTu/6Ahf+Bimph1ZDn0knr3krUdUjt2eeNPHPR6FaUDhrHXlbk8XqZ3fZv2m?=
 =?us-ascii?Q?uR/K1rSz7xpF2ys6yNTIH9AQeJycaNmMLFbY0V95DD7qNuUjL7cf9Xbe4szu?=
 =?us-ascii?Q?HGirBDAwlGvKvBQwUmmHcp602FJ+1+CX2VHWfdvDJCPunPrmi1dpEctFBfy2?=
 =?us-ascii?Q?Cq2TqStJyWJJQPTiSggv1KnuPVHQeQcjmP2xTUBDJE4LGNNrBwbhKUs0k9WJ?=
 =?us-ascii?Q?FcXMLifjban5INuD8vhgS5i1EWQrFqE6FrWiIk4Dy4BAFa6JrOyWBF3e5IDA?=
 =?us-ascii?Q?5pdS7xNAIKpKO++h5lkUsleyKvo1UQ5W4xxvsxH2RL2jTt5UCP4d43cBHQmC?=
 =?us-ascii?Q?bO5CzmSGi8Y2IUDSG9i7nhbNBBRGC1Y8hk5qHO7PC4Vpek6IZmiLud5OlVE8?=
 =?us-ascii?Q?LJDJl7S1uq4UFU4IvW/MHuaiiCwmAvzCVJ794VQBTYLfPqmftkU1i59Z/duT?=
 =?us-ascii?Q?WNGyMc86Pb1a2tejOZy74vmAXHsMptdWlX7+DSG3jMP8d6ueMEr8jw3aQ2c4?=
 =?us-ascii?Q?9UgP82EdI5rcTD/YKu7WCTo4/0C+LovHwuXowisQI+rJ7WtEGYVlUM2Y92G3?=
 =?us-ascii?Q?hnAIzbw8XAf2trkWt0EY/uCT86kDD+B/w6f+3vp9RFSetvoAAo8GlF9mb6M?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea40210-c86b-4529-8d03-08db6ca0ae7c
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 06:29:18.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5601
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add "repeatability" interface to sysfs, it could be
read or written to control the sensor.

Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
---
 Documentation/hwmon/sht3x.rst |  7 +++++++
 drivers/hwmon/sht3x.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/hwmon/sht3x.rst b/Documentation/hwmon/sht3x.rst
index 2c87c8f58..3dc4b9c14 100644
--- a/Documentation/hwmon/sht3x.rst
+++ b/Documentation/hwmon/sht3x.rst
@@ -83,4 +83,11 @@ heater_enable:      heater enable, heating element removes excess humidity from
 update_interval:    update interval, 0 for single shot, interval in msec
 		    for periodic measurement. If the interval is not supported
 		    by the sensor, the next faster interval is chosen
+repeatability:      write or read repeatability, the higher repeatability means
+                    the longer measurement duration, the lower noise level and
+                    the larger energy consumption:
+
+                        - 0: low repeatability
+                        - 1: medium repeatability
+                        - 2: high repeatability
 =================== ============================================================
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index eb968b9d3..209090a48 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -642,6 +642,33 @@ static ssize_t update_interval_store(struct device *dev,
 	return count;
 }
 
+static ssize_t repeatability_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct sht3x_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", data->repeatability);
+}
+
+static ssize_t repeatability_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t count)
+{
+	u8 val;
+	struct sht3x_data *data = dev_get_drvdata(dev);
+
+	val = kstrtou8(buf, 0, &val);
+	if (val)
+		return val;
+
+	val = clamp_val(val, low_repeatability, high_repeatability);
+	data->repeatability = val;
+
+	return count;
+}
+
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
 static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
 static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
@@ -658,6 +685,7 @@ static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
 static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
 static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
 static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
+static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
 
 static struct attribute *sht3x_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
@@ -674,6 +702,7 @@ static struct attribute *sht3x_attrs[] = {
 	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
 	&sensor_dev_attr_heater_enable.dev_attr.attr,
 	&sensor_dev_attr_update_interval.dev_attr.attr,
+	&sensor_dev_attr_repeatability.dev_attr.attr,
 	NULL
 };
 
-- 
2.30.2

