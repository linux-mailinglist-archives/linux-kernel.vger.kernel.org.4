Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED7972A515
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjFIVEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFIVEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:04:21 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2064.outbound.protection.outlook.com [40.107.241.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5FC358E;
        Fri,  9 Jun 2023 14:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqpBynF0JNtS3v/KconJ6zXao/hyfjPoi6+bx3YgzZ9lYSw1U6pk82c9/5IIriWYYxFXuLJTjwmdjuO5Acc4TAE3I08iqanIfJoZnhAV/Fu/rR8xnGAp+IAnYVSo7Gd7EivyVO2QycqsiXu+pJm0Stn0HxkuIfap6Am9S+f3XCq7uI32qPW2UtcKcIMtyzdTswRIR4Bf1XvmzBjTBmFdUshWbrIyTkIDondcluED/2Q8QRPzy+9taKnf0NnJeuEEsnbxU1dUeLvnSxcD3T+Nq3VO8eRxQDjUWqM2LEMjavlJueMPqzikkaipl+1m5mErBjxTW9ReJxiOJLsi1C8QFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2jdjcuNyFUKWFm4EMWdqKR6ASTe7qlr2IBFsbHVWNA=;
 b=jsD01sSYE5hp5CJYGV4vnIeA3txFM0V1Wx6/0d30b4pKD1vhNKmQkb4o6/TrObolq/McOV4tosY/0KRhF7gYgGlRrCHnikpeCYvYZ0FXbzhSzvUNXa2RBgIiWdAXaTPwIBxikY4TUaEA+aMvFMc0fVx690PQDbbduLOkGPKISCgZLRYrrWKbl8rhgg+LefIWS9/V/hKOihzwCN+JBuP5ePRT2P4ZPBzDxco1xUGmUXZBuzgrQVn0HLtHJQ7AcDiZ/bTfM++qWIRI47+iUgrzn9OxdLVaDluop5TcQSPJkTQNZatzPqqe8sKOQCRASx9gF2kHINRW0JGMDpuOSGV6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2jdjcuNyFUKWFm4EMWdqKR6ASTe7qlr2IBFsbHVWNA=;
 b=Ehe+RFt5baxR7VejwxWu3D6dHVpaDcjqBMGK1tJc5czr6PnG18S1C8fnVsgChj+OBrkNyIXsQFUVLY82HmKybdj8mQTlperFG6ZmZJPbVBmOq8z8DsoDw6JG3uKrNBLGDTdjKT03UZKCyzE3MwC3tAC0HPQpC2qe8t2n0dQu/QHJ7NA50tg8UEkFD/QPIW9q8YgEcahXj4su5JStjr+94csAoO3+epSN+4iskuzTsiAJwcXDaexHevOI0OdQ6zBiGGO05aeIH/r+cE5bU2oGX7RI1k//ZvHclKzTcqMbm1AhOoLU59kmFbjmcrnxxj1UXrxdEAAN0j5hhi+2riuW1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Fri, 9 Jun
 2023 21:04:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 21:04:16 +0000
Message-ID: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
Date:   Fri, 9 Jun 2023 23:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtc: pcf-8563: Report previously detected low-voltage via
 RTC_VL_BACKUP_LOW
Content-Language: en-US
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 615d9b18-8006-4f68-34d6-08db692d15db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVJMD+guSdgVHVNSrowqlUfxZ9gaYHSbrF/Py/Tr5zCqHxnPRWGzLT3lp5LJMsOLh5NTJA5tCJg5ocRNZCoheEUIJvH+B7Of64oV19efHkkMSobxo00BtXdbLYRG+QAX4HrZu5SXM6t+euQo7Hyzr47ZdxahrRl6ejP10igRH0STdlaMKxCnX+14iHePcXkkut1lPH2j3Mi/zoeiT9+McBFn1oF33k9PhwXronT+uwtnhRIlCtH84SFIFmu4JV3WvOuKhRn/Nr6QMziA+0jkQQkmBHzESmTqAkmLfEYM+kwf2EeZqxPpgqTkz14OYOi9G2BLNZlru7Svk0Eyz1XMClZxE/UZf+V20dzftNeu/rd8eD6JgRah42Z9/QujTDY1+o7TBjmwAKoGbocIF3yoIhhyPoZcOUWOoYjWEVT9bnIBHAM15PqOV+ixMcEZ5aQXWZOxy+r1b/AJrD3ixvNakK6qSNVFlljiPB/4D+lnBNMasLfwzZ2WTZ/EcfgytFQQb9BkC1qiGqQalytihpc9ApCTDOwB675qE8EqFEzWA8O3XkzDpOrS6iy/SoMx26x6q7DM4VuYIrAXwM0oy3QSGM1REXKbqrTm/gGMuuKzqYkK6+gE3awc096wXke4fNqcY6T9fjMs+8sLZBvRVJPr2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(44832011)(5660300002)(38100700002)(82960400001)(186003)(26005)(83380400001)(6506007)(2616005)(6512007)(478600001)(110136005)(2906002)(86362001)(6486002)(31696002)(36756003)(66946007)(66556008)(8676002)(4326008)(31686004)(66476007)(8936002)(6666004)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTNZRWZEeWtKbUNpUlRvKzhLekpKcHNpeEpGVUNnd2xWRzhSd2wrZHN5Ukc0?=
 =?utf-8?B?OFFTWit2anBkbmN0RDR1bnM3L2NrVjZWaWtNYUZGMEI0QXo5N1JQY09FdlRI?=
 =?utf-8?B?c2Urcm1VNU5YYXZObEV2Q1R5NS9aeWs1Z3MrSnJkQzhGZGtqWHZQdUVpSlZO?=
 =?utf-8?B?Z1o3WHA1Y1lua3Y4c3RuNUtaSGxTbzNiVDBiSWFYb2x2Zm5mRk81dUt0alla?=
 =?utf-8?B?RmV4Q1RJeFN4b1Z4dHdwYkpGUUZnUk9nUWdZUDJCRmE5d3huZFRpQ0tBelRL?=
 =?utf-8?B?QWhLa0tsM2FJdlNmVG5KNFhWVWxXZWpBV3JMZitqb0QxOUltRGh6Ny8zd3hP?=
 =?utf-8?B?NkRJdGprY3BaTEt2QlBCVU5aQk9yV1BBclRxK1lhQzZPMkd5T2ZET3hieE1B?=
 =?utf-8?B?ZFczMWFtak5DcW10b3ZMN2FOcC9hZ3MxY2JGQVM4QU9qTlUzaGdNdk02ZCtn?=
 =?utf-8?B?a3hNTm5LRFUxR0RUMWZreCtXMmpaNE1TYzZCM2g3WExIc1lSTVFjVEtTakJD?=
 =?utf-8?B?VGQvZTNjaXEzcFdIbWtKSUdIdFdobHFubGZVUVNOeVlUejBFcGxzUVN4dkd3?=
 =?utf-8?B?cUVDREJhSjNXK1ozK0lOUERWYTgwdlZzM0d1eXdob2VrT3NrMG95RGdFZUY3?=
 =?utf-8?B?MlJVdnZLbGQ3NlRGTUdpbVlJWW9QTXM0WWhtazZhc3pzNGVBcU0xZGNGVTR4?=
 =?utf-8?B?SlZoSTRIRmtEUHFSV1ZESVhiL2hKN0ZaSG5HTkxiRURhZlhjZk5JTmpnMmtr?=
 =?utf-8?B?dDU1ZFlCTm41WFBESC9GN0Fwd2d6dW5DRGRhMzBXbmViNWgrRC80clhtbUhB?=
 =?utf-8?B?VXgzYWpXY0pEaUpDWXhDU0VjaGpYVW94S1cvUmg4T0d3OW9Hc2IzeHFHbS9Y?=
 =?utf-8?B?dGZTSnpZMFo0Q2ZPNlljS3p5RWdMZzc3OUdROW5OOVVGblFVYlZtTnV0OWpS?=
 =?utf-8?B?ZjJKQjkvZlh5UjlQR0JsblhuTjNlRWF0dlJCdEhlRCtxMU1uYWR6MlhlK2kv?=
 =?utf-8?B?a28zeCtFTlpGOW9ieVI1Z2xMWWI3VTNSdzYyTkRlYUFBZm9CWHVyTEV3ZXp2?=
 =?utf-8?B?NXdINUYzUHJmNE9JdzR1SWFDUzVmUGlIZUhoQmtucmFXUldJeUhyRGk3dG9S?=
 =?utf-8?B?UTZnYkFSemZmaEsxUzRQem1xYVFpaVRoZk9CelRoZVBjU0ZPQ0lUb1NKNHBJ?=
 =?utf-8?B?dmlPK29UY0xaMktTRmhyMVlheG1lSVNUNlV0VDBwZ01zTTZyVDRYZmt2MndW?=
 =?utf-8?B?V3ZXNkJEbytkcE5JbG1PMHR2UE5XQXdBTEFYbTRONWpXTkozVjZ5SU9ERWdG?=
 =?utf-8?B?ajFkRXJpMFhNeGYvbnVjN1BtZnNGY3dHbG5iOWo3R2NHZ0Nya05IZks5Ykdl?=
 =?utf-8?B?Yk1XWTJhcXpmZjArd0liZ3Q0S1puSkVPNlNZc2hpTXlFRkpxeEI2RUpxb2hL?=
 =?utf-8?B?U2k5QzFETUVKcEkwZFQ4RUZOOGh2SVlZd0tSNVlZbDVzRG56ak9xT0RlMkdl?=
 =?utf-8?B?ZXMzRnVjK3VuZ3NOd21VY0tXMVVNL0pzbk5MdXBSK0RybXk0eWQ2aXRZVUl0?=
 =?utf-8?B?aVBpcTUwckVLdmVGTks1a3g3dHRiSUJsNDZCM25XTjVrTHhMeWNCcDZGUEhI?=
 =?utf-8?B?bDkwVkxZL0thWEtTd2t4VjkrdGthMldrOGZvM0dTZGtlQVd5Q3NBWEhybHlN?=
 =?utf-8?B?YXZiWFdabXM2eWNNZVNCemZpdEY0Sjk3NmZ6cnplcjIzZE1EN2pZbkhUSEt2?=
 =?utf-8?B?SzZTa1d3Ukd5M1NXSDR4UU5manIrMlBCZlh2THNIMDVSZUFuMkFzTjFuS1V6?=
 =?utf-8?B?M1JDNzhCdmhqQUs0dTYydUZrTjhaWTlEMkZnNk9RSjEvUmtmcDRJeVlxbm5y?=
 =?utf-8?B?OHp1alFtcWtVV1FoQ3hOaEc3UmNrVVJaMEZtekVldVRLclFvdG5iaE1ONWdv?=
 =?utf-8?B?Z2lFZEZpL0Y3L0luWDkxRVphVzZHandUdjFZOTA2S1RtWDAzZWJ0VjlCaitH?=
 =?utf-8?B?L2Rab2tzS05aaEI2SUZTSW9PNGJDZUR3OU1tR3JHT1hGeFhzZDh3dzhyeXlB?=
 =?utf-8?B?dnN2NHNzQnp3YXlpSEd4b1FDV095b3RxMTNyTFE5Ty94OUFxQS9hRkNacE1k?=
 =?utf-8?B?THlobzl4ZHBuOVZYcUtRckJBSUljenpEN29EaElnYXEvQUI2b3RsVStNUmxR?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615d9b18-8006-4f68-34d6-08db692d15db
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 21:04:16.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkg4RELARfWSW2V/vvynImkJOQP8noe9zxoouFJA+2ZLclEDibtIRsgHUKyxaiDNkvCF5m3uFz0l+6x7uNJ+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The VL bit in the seconds register remains set only until seconds are
written under main power. As this often happens during boot-up after
picking up a network time, make sure to preserve the low battery state
across this, caching it and returning it via the RTC_VL_BACKUP_LOW bit.

To permit userspace clearing this state during runtime, also implement
RTC_VL_CLR that works against the cached state.

This is emulating RTCs which have a battery voltage check that works
under main power as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/rtc/rtc-pcf8563.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 7e720472213c..f8c6cdb9a39d 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -81,6 +81,7 @@ struct pcf8563 {
 #ifdef CONFIG_COMMON_CLK
 	struct clk_hw		clkout_hw;
 #endif
+	bool low_bat;
 };
 
 static int pcf8563_read_block_data(struct i2c_client *client, unsigned char reg,
@@ -207,6 +208,7 @@ static int pcf8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
 		return err;
 
 	if (buf[PCF8563_REG_SC] & PCF8563_SC_LV) {
+		pcf8563->low_bat = true;
 		dev_err(&client->dev,
 			"low voltage detected, date/time is not reliable.\n");
 		return -EINVAL;
@@ -277,6 +279,8 @@ static int pcf8563_rtc_set_time(struct device *dev, struct rtc_time *tm)
 static int pcf8563_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8563 *pcf8563 = i2c_get_clientdata(client);
+	unsigned int state = 0;
 	int ret;
 
 	switch (cmd) {
@@ -284,9 +288,16 @@ static int pcf8563_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long
 		ret = i2c_smbus_read_byte_data(client, PCF8563_REG_SC);
 		if (ret < 0)
 			return ret;
-
-		return put_user(ret & PCF8563_SC_LV ? RTC_VL_DATA_INVALID : 0,
-				(unsigned int __user *)arg);
+		if (ret & PCF8563_SC_LV) {
+			state |= RTC_VL_DATA_INVALID;
+			pcf8563->low_bat = true;
+		}
+		if (pcf8563->low_bat)
+			state |= RTC_VL_BACKUP_LOW;
+		return put_user(state, (unsigned int __user *)arg);
+	case RTC_VL_CLR:
+		pcf8563->low_bat = false;
+		return 0;
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.35.3
