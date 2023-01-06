Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE75E6602DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjAFPPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjAFPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:14:53 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2083.outbound.protection.outlook.com [40.92.98.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C107A8B747
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXjIVyeYTeaklJUI9FGZbPSJY6UI5Oi4ZJv70lOQ0dTLnw+ovKibiLpEXMqI5JyM3TbOvDrWcxYee5fScgModKMmIfw8Hpx+ZAzWN8nk3yP7ZhTcMEvn8oB0m6pMVtKU1U/9xGrNP9ksEKnn/QmZkQCcwRcH9sT5tXv62wXjvXpGJRqYbF8Od++PUtuEQLj5mE2BQbU+Ii+6cm6RRhDRaRyCXoXGZ1IBZ08Lhct5b96sEPvyuAuQou/dsExa1T5JrIFmlc016n4Udf5d2eSSgOHJjJPT0Kctv+ecf9wIKrPB3qtsqia1E8+mOKB0ymUFv8IJ7TKVpw1ps5evUIIZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZyinIY6P3e7c7+/GT7rnKK06YMeQErfch6qNK8tu8Q=;
 b=EmhGVtPon8jLMU3kdvrz//qe67FOKm6dbSanNnVldLo/w5OUaMkHZnTOzinJdhWLNgTfpMuqU9Clq5ckotUARmYBkO0IJK0vLl60Yle7Gp3HfoVS3ijqzMRrcRlVg30Qqk0KufR9b/K8ftyIoLZ4Kfc4ifu6/N0/YJKP02vBpfxxoMMActZ3lOeNjwbb+GWDK9YFlG8M88rCZUUBGTaZDCHwRmLBh7/zLOHb8AO2VweNGbdmmhvypomIIwwRj4osEz4o96ijRTJy2ynnY1LYPnykMpFGWTCs5ysrZS++hY92/U6r2/19xml4pH9yA30igrLXwP/vyjuFz+wp4fHoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZyinIY6P3e7c7+/GT7rnKK06YMeQErfch6qNK8tu8Q=;
 b=qI/l1XLtFPJrpbh4MnwnC3cMI7UsUQwS6m89MDOhiKZaCZgh3PvB7huquSj5XjpVblziM2AOnE9I3nxn30g1DjGOAFB2Qx2ctdhnkkNYsTvBdtas9LAs369HJ2nk2xGSgfrs0Sh86g3xQU2tsIJiVHrZHmwm8JLxfJKwSp2xDxTSfGM0Z+luuPYkp0m6jWaj0Q+GrED7jmsy99+bLw5s8OM6VpTUNys2yLiO89sLbA99I97htkkcInMmNu0mt4Dq2CAG47FFCcSEg6beWa0e9b2lxvm4TzeqyRSZ9kFzH9kJVnRN8SCjWIFYGrHjXDbaYWvNmst1cMQtBC/zMb+Nxw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB2411.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 15:14:49 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 15:14:49 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v2] ALSA: ac97: make remove callback of ac97 driver void returned
Date:   Fri,  6 Jan 2023 23:13:49 +0800
Message-ID: <TYCP286MB2323A5AB1B2578EF4FA15DA7CAFB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XHa1wxZfbOIGG+aMij2sS61NNMVt0io+]
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230106151349.27702-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB2411:EE_
X-MS-Office365-Filtering-Correlation-Id: f239cf0d-2a06-45db-360b-08daeff8c095
X-MS-Exchange-SLBlob-MailProps: ymJijV9pwJnUONNRvQZ2/TrCTdctBj73VVlaYy1TRJ0J4JrwBWfHpVv01sRojAH1CmBSWp/OLMGhISjA5W5f+BBxKMlZQkkLTKLmvCREfXzAEqc55fnz8pfm1RPYridcY7dTsxdbKqkITF9n0lkussyLH6rX1m5NvZdZJYArKUUTVso4zIq+Mio2MFGW5volxe070GYltVA5GK2d/TRCbg1E2F9GPOCzdVl4gUo5CEfEbi3b0GBdxynT/7zTl0NabjvPqi2/qw7EwmBWmTM297R/1Jmqo9+OFghLnD/G3kMyZHMFmRmggSZyZPp+jMYurzuoFPpWdiC371/q9/G3kZ4t93aGDenwty+euvylwRat/heuWAVkUW6XhWWr/80JDEfr08Il110SyMoUKSSwdZ/NMfwnc/JhQ65Z7uZWPwFR2aAgRfdfT6JoYl1Ck6sBympJ7yhC0j1bcdwFgCrhnn0Ev23gKN72S9o7kuxfQQ2HrHb4LCo/I6F+QYvCM9dotWtLFtHHS1MlxuDrWTzVWaZFikcBJlEE91MI2p/tTE96FASd2tvLXP/7ZcyG006dQ2uV87Xa3UfZR6wNNNqjdk3R8t8gkXtKTyeimudIAgTylVfx2EXEWiUV6jmZT2a/u2SoUVA2D3q0kW1ivY5TEv74Axmvd1LSRKbIX7dKfeM/SWFeS/8iSIa8Io0eTQVbQzhTPNtQ/sJw4z83DW9kQ+phFXHIOdqWKbLgxmt7hzovV7ChItytH7W/yFHs8RC/dSNZDKbWhpKeNaqIrCZt5KI9e/vm84KFiCjuXM3B+d4bKdam8sdW6cZtXRIud9+y
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MWo6scNi8warzM5nCk5DqTTFdPRjfPhMbcQ4xSFf4gtKDHJ4CzM9+l/3QH6OiMyvATDBvwR2Fpww56VV9lcfGqBnUD9TNv4/CM78wH1nQjb5T6L1JlAjH61GaU7nursytzL3M0ycMZr493JHUpUULGmjapCAoyNYGK69wa51U7SxRLy78mrDxijPcs/EZvMTobDXxXoIvlROH69r6SZhns0HFF6PzqGmp42JGpsUHQxTl1OfNiHvD8P6TcQBix3FCQTZx4kPHO8bkFNHXwnn+Hy3ksBS+i+NON42jukWxP8ZeepXrGWVts+wJkdz3fc0cBWuagoxf97V1Ht4xGza+8x3PbaY7m1XkpuoiFkZb0fsrqPtJHgXxCU6GGX2nfYhxCkjB8jRc+UR9GYscyeT4b48q0nd+z2wmaEmsBTKNsE6703/olEnsuA+Pet/eqFox3CPiBYFeq9+AC2S4Kmg013jADthCAV6areXvXRKBe8ijG5XdU2cD3xjE21KjxDn8pScSPlm05xoArt9mi6KsbadQUwhrgEVeCwAZV7GsYMXqvO9NSSDK3VdXNq23aOUcWZcqTi+fhdAb6xkk5CKDL1RvVsF6MnEqq1zrZpq10pj8NMyOA3mZAfL1UsZkX34OxWv4YWvVOXckttCX3NCA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XEHr4cxtjpHnJW4Z/M3yfNhPtDK1w2WtkHWWSfW8nDD7X814qNXpWgUuSsLS?=
 =?us-ascii?Q?KmuwpANn/SwnQFuo4pHghfVwAVkITL5dFwJEjOVsvQ46rmhLRzAufTCjFfjg?=
 =?us-ascii?Q?vdIVjgGS1dMynPxPvTxmhebiH4Ztm/qOUdCqtJBqknk7eU8r0rnJPKhuSl9K?=
 =?us-ascii?Q?zW1nuCa+ISfWRfUA2HN+hq+9/vPSbu+FuxwncBqc14253DuWljKFTMmRjXEO?=
 =?us-ascii?Q?Ko5GmIi9ajqxY71+WJFGonlnGxBwJP1LgAP6tHmU6HDuC2MmS8s5fm8uIAc8?=
 =?us-ascii?Q?4h39ugauz/b4DguYH+WaE7ae3nEmznQ/ILTNMWqnD3NZ3oVRzmuMdc9PsFSc?=
 =?us-ascii?Q?noxYFh9OY8USqwPVAuYv0XCv5FnuCtWn1EialMvcNeG063rcm/Kp1fByhGp/?=
 =?us-ascii?Q?DK0TCHadCyKN7tNtxrsEfs8q4HL2zu6rZmVQRQDzHAVXoNwfZ10/IUn70d2z?=
 =?us-ascii?Q?Yj+4gr4Kq6ql/phuRA27CasHJtS3v1LYnCWtsCRXcX2s7LkLlOIc4GYiif+J?=
 =?us-ascii?Q?cLzfM+ikCqmCY+tLxCGoK9zp4WNlxRJ57uWKs01p5Ol7MKDu5+G4IHUy6qjO?=
 =?us-ascii?Q?XfBc5njrj81ZJ4KNe0+YMkdA4yuT9xBNRO98nTS+azlOs5giUMDkTAEynLxB?=
 =?us-ascii?Q?YP+1ryVAnqE0pcXycYyvOPEVGwudR5GyUeUi5pAzVLrzMDmOFTDWg+qBf7ce?=
 =?us-ascii?Q?q6Msymx8GcBJgj8GxDrg9yvBfa0EfyTYvtFUyx1FPhQ+kU5vf5lPTiL14v+X?=
 =?us-ascii?Q?oGii7khekt8dlXURPnyE1WMnnpaGf04NTwWm9XN3cIMxyJeyOUqVpgUWn8Ib?=
 =?us-ascii?Q?Lx02DcTHC2HpGziThsqUf0WR+C7pkVqdMKXUaee8EvT7L9k9WjJ8XwHPDOhh?=
 =?us-ascii?Q?RHltnyGZN+ybYi1+vgC1tNspZ9b2au9kXJQZKPUei0hUb7Wz2cYNL8k2yn1V?=
 =?us-ascii?Q?h+Mff81eAvWfQgswusFT1QvDnzFhmCKbA9JAAo0F78Tqk7FtTBEcraBGXRd+?=
 =?us-ascii?Q?6pQqWT2pob7jblkklsETI8x1Mn53TefiGWBwYiyvYAOqHQtYLS1ivkDjxmsU?=
 =?us-ascii?Q?85WSXeydi8desJHDoYZ2JTJ0dRu9oTRSwsz97JueyMvwpmv9Y1qrfQIpY4kK?=
 =?us-ascii?Q?N4LRQRrYDlDwbZpdfm6sb5oPE/DasyImONQbZJEaTBNV/daBevAjfx7LAeVl?=
 =?us-ascii?Q?KWuVpUFxplZxiJi4kY/WZ6PEde1d8kC6EAvqbcp/UsNzzk1nPwTxeCEN4Il3?=
 =?us-ascii?Q?SEWD/l5McqHjVPQOfZr7TYt1TJbsALZ0qc6ixH7MNw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f239cf0d-2a06-45db-360b-08daeff8c095
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 15:14:49.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fc7a6209d571 ("bus: Make remove callback return void")
forces bus_type::remove be void-returned, it doesn't make much sense
for any bus based driver implementing remove callbalk to return
non-void to its caller.

As such, change the remove function for ac97 based drivers to return
void.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
v1 -> v2
- Update commit message.
- Rebased to latest sound/for-next.

v1
- https://lore.kernel.org/all/TYCP286MB2323207367F2D39D0D725828CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
---
 drivers/mfd/wm97xx-core.c  | 4 +---
 include/sound/ac97/codec.h | 2 +-
 sound/ac97/bus.c           | 5 ++---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
index 9a2331eb1bfa..663acbb1854c 100644
--- a/drivers/mfd/wm97xx-core.c
+++ b/drivers/mfd/wm97xx-core.c
@@ -319,13 +319,11 @@ static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
 	return ret;
 }
 
-static int wm97xx_ac97_remove(struct ac97_codec_device *adev)
+static void wm97xx_ac97_remove(struct ac97_codec_device *adev)
 {
 	struct wm97xx_priv *wm97xx = ac97_get_drvdata(adev);
 
 	snd_ac97_compat_release(wm97xx->ac97);
-
-	return 0;
 }
 
 static const struct ac97_id wm97xx_ac97_ids[] = {
diff --git a/include/sound/ac97/codec.h b/include/sound/ac97/codec.h
index 9792d25fa369..2fc641cb1982 100644
--- a/include/sound/ac97/codec.h
+++ b/include/sound/ac97/codec.h
@@ -63,7 +63,7 @@ struct ac97_codec_device {
 struct ac97_codec_driver {
 	struct device_driver	driver;
 	int			(*probe)(struct ac97_codec_device *);
-	int			(*remove)(struct ac97_codec_device *);
+	void			(*remove)(struct ac97_codec_device *dev);
 	void			(*shutdown)(struct ac97_codec_device *);
 	const struct ac97_id	*id_table;
 };
diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 045330883a96..6067c04ce4c0 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -524,10 +524,9 @@ static void ac97_bus_remove(struct device *dev)
 	if (ret < 0)
 		return;
 
-	ret = adrv->remove(adev);
+	adrv->remove(adev);
 	pm_runtime_put_noidle(dev);
-	if (ret == 0)
-		ac97_put_disable_clk(adev);
+	ac97_put_disable_clk(adev);
 
 	pm_runtime_disable(dev);
 }
-- 
2.25.1

