Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2066602EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjAFPSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjAFPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:18:17 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2090.outbound.protection.outlook.com [40.92.98.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D2115
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:18:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAXbd0f4Zpw6mHfUjwdfUci87Wmo0EgcBDEMHjORlCvALvDwItX5UydjzzK2nGKzL2plJLMLssBwq2z5hoyMcKP4LYHO1izODF+CnQOpVjdVLfIlD9g5qE0VQjfqZJvrdQP0BlO8M5cvgBajkD85pvhB/gwPNnp+Gry46LrrbtKPQvxs67MlRb5fmZ03DEbm4KBPMwk8E5B3uBoguaMKACoXIuxuoEpKZoJTUgeljxwHmRUkw9j3PzG2MG6k3JhvUM1d+IIPe4+uu15HC5VUKDZtjj9Y1U1D0ElUGE+2U0W87SM4GmcsSZ8pxbYuTE6eFiF8rAOdZzoiXUv6Rg5Mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KEQysnq0uTLidp7TfZYWY1ywhfEnBTczqE5/YTsVP4=;
 b=AAsuW4KS/+mpX3ZEhMQrLqNI39NjbmqeqgHwdR0ThNjJwKE8EaziHdarGa9meUaMznykmj0hj8uxFzXklgWOBMMHM9hNpKLXIZlYSkWNsUfU5FRNXMJIOzxvUR5pxbbiwasKbB6FFxvJ8khVv89VlbbSGpFi0ueff5eM73kMkYc/pkjE9/+tbpFyXG+Z6yzpt/Ht8gnzEtlVVAnTl3iZelVyVSvOcUnVR1+1cM3Vk2sbUlGvkexTS6GzuBoe+Mvuc9fzeWVSEHtI3S5zlR5UUDHo4f8qbFYp5dViCNAK1y7AaYjrcseujBwuSqlkezYReNO8PNVfZ8cblKDnvbXi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KEQysnq0uTLidp7TfZYWY1ywhfEnBTczqE5/YTsVP4=;
 b=e2+neEcdFbwTRmqc1UKP0yjZQRtMiI1FZEUYjpE1RqiWE6VWBNauYJpuJ/MaM0fbzAtWGsvmCB2Hr6Tkg28OIMzbK1WRY0oKfqVhvL3snXpUudm3Wki5N+bj68MJWxsfIeHpGWhRzD8qg+Fbe/n6FTrOAxCFbksDInEOI3QzR8LSKfvfi8cbT8AamV8Khp5j2lTP8SGLRzMf4kLFP5XDtEqHbtmrGPbMNKCnqGRz4F2L611xxdOhl+rEeB1gDmoP0OZwrtf8wvoaYqrNmK6mBeQaL2HavSZAuBXk3RMiM26KQBlbgsHZ+s6xLRf3GLua5Iz/cpiU+weYQvf9t+/4rw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB2411.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 15:18:14 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 15:18:14 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     johannes@sipsolutions.net, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v2] ALSA: aoa: make remove callback of soundbus driver void returned
Date:   Fri,  6 Jan 2023 23:17:46 +0800
Message-ID: <TYCP286MB23234FED40A3AE6797DEBAB7CAFB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [/SP0AfysDfQwD8rmeq/7D7EGIWsXSl6R]
X-ClientProxiedBy: TYAPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:404:28::30) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230106151746.27784-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB2411:EE_
X-MS-Office365-Filtering-Correlation-Id: f897424b-2cad-4929-aaf2-08daeff93aba
X-MS-Exchange-SLBlob-MailProps: ZLYX9kf+sFZMrcLbERgi90tWqdokkUc1N8Q4Xs7rtgSnpqYtH8DnePs41/cftVZeHDv0mz33bJQo2RVctKHSBozP6MqpW6odCiWhSaut0uTQS4tJK0MuPxKC3isHmubQ/W38hCv2x4WZHchspjYyVUrhtQ7KRM7uXH/O5UD17/qBIfUVH31iNgU4lY+ffDOiz8nm8aEtEmLGYsDpzjQhTw0bX5n/gnII+WoNoGMHrelt8Yvi/++xkWRURRII/7LkBLrNRb/vnlfkissQwihqdib41+Booe+LnuzS4QO5DlzrOVi+j7CoGjfBuovJFGXiee3vSz7yIIgFK0mgYFdDKIuz4o+3bg3v+KfopS4Gvrr/+YzJ5CHLiTGyroVcS4A9IHUwfmIdMfQGTk1xoqjkUuGy05in0mb39vKDWexQx6Y5pZt6I68G+NE+oFi8gihgL35chcG6yyl/GZGGOPJd6u43wV+qwCCAipfFqwlj5pp7GZTXpnO8xV1Sq+uMrCHt08cP9O5Gwt3YtSW12wnKajUMx2MoxM97/DU7D37z1N6Ve2QJbcNIvsWCnF1WXaFKBA1BcgK+jx0y9O7oM08HIYgcGiPItt1/10REkXnR3LT4crCI8/akb3C8ENgFNgQ8cQqqvs75lw9vNBvGk1iOuLpM88LVYuucHiUT0rUP2szOL2+DFjV9z/8g9ReO+C77B/Z7+bp8Qb6dUbSwN2ooYZYfTMaqQ9YddUJmV6nqwtu4dThJ0Mz1xqN2hBe1+RlHbfzh5c3uflVqdtGnSyRHo7vb+9UH1ljqYDuB5a7XQ/xD2jtJX4LBmA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLKDfgVoM2S9K9fLWTImaqTcT17dKsrCJxZGUWgQxFVP4U0L4LSjFRb90XvjauwuodAEm7omKYk2/oj3P3SDjxo2kKEIMqbBEaMir9dly+LXpt6aWAefG32XOQGFUCWaxY5r6n2HaLWgJUz/HC7aHf9Am76Yf3WMTQ//h/VHLLZ9FCrZMMu9ZfMJCmxqUOElpAX0/3c5+ms5D6dl0aqBISWTJo35qpbH7aNOvC6yVXpJh8PtajR4HKuS+zr747Uwnpu7rZImLjAuTIdveZA6ylk96yHkkAd4DL11ll2PRdMIepSDE+zXpAPUPvXgMObYeB5hhpPwlKAJZnLmOE/g+137Xo6AuM+vdlcUekUGJ9FFcb9WC5/xBr2wAnUS28XcoozIknp0uYmbTjVHv4ZRnijFX8Bazi0Y6DYSX6Dr8QutUS34o7ybfdqjTtJRfdWWvE0lOYUY8tsYIvgvpesaJkQLFfr1eOVhZq860s96q04GBGLW+ryTWjLZSNS1+g4rCaR7pT6hPrqm+XzyShaTQVWYywAPQLeiET8fLxaCMUGaRON+Nr7z206QXXuk2RgDReFID3z0iu2JRJaoGctgC5L6V1r8CoZRJ3HoI1PpcKyLW9gE9YmjYUDScm343OdqUGlwsLkZsSN5ghuZWyIAWA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?++Ng21k5mfZL5oboe3p9qx43fhNNccH3U+p7hF9gDOqcTO++ItbbqVp+ubEC?=
 =?us-ascii?Q?rLYTlANSIvw10lrKjV6FnjppogNDwT6H2hAgDCWl7N8yj06dFiqyChJMgxda?=
 =?us-ascii?Q?DX2iBKJL0Y/F+1SdTeOFxhY7p0yXWbZeK44OflNh49D65zzuYV7m+rtA7/ov?=
 =?us-ascii?Q?i87HVUhEbGpjyM2xb0Jsc6+dpIM8+Wdw26UyR4wy8JddaIGOGTiZw5HXRBcH?=
 =?us-ascii?Q?/YmCKFq4s9tYG8bWETs/zzdQbr6qFQwb/9wRDg0rabWX4EKyEmnJJJ4j8L5n?=
 =?us-ascii?Q?nW/+WwItKcVGTDYJH+x986GCJyrBjAzdVHir04ej9248Cpa8ooJqaxYpy6J8?=
 =?us-ascii?Q?CoO7S3pLkqwMNMCpQJIVmvnLHXQQnJ190oig9ikrTytO59bA56VLqkzadint?=
 =?us-ascii?Q?wPODPIFqWp0eMTlhrkokklX5QV4yzwEDEYiBCp91cF3uBlkys5r2ConN4+r7?=
 =?us-ascii?Q?X3UbGCeY1EIQx6ZzApEhAiFSw1rAAVb4ML1C9rTNlCYUIDHc9KFAlqN2KuYG?=
 =?us-ascii?Q?vx9mTYeE14faOxwFiSQP4k9a0Ej9Vw8gRcFD4A8TurRMd0K9lLVS35JyJZCL?=
 =?us-ascii?Q?eK3fAOSgd5lHkvTsz3Cnnwsu8GEZKOd3n/WLIcWq9nEdK7V2aVD0q+vkMuRe?=
 =?us-ascii?Q?bC2D8NUADrT5vMEz1z6yt9XuKJperu9iC2s8xeYZFc9YTZl4vEP9LCyCji95?=
 =?us-ascii?Q?DIt5ZfAN6PKW1GaSoXg2RYy7iw+8Lzu5ir1R/tPqor72L7cZvbLq6XXDv/9j?=
 =?us-ascii?Q?mEZspMZ+gPjKIpJHDjZefkx4fBYZ9P9U5/eckEI/Kr2OZKykee9krboQP0tu?=
 =?us-ascii?Q?j+UEckzUhc7MZFuWe7NHTuzirdzMa8MvWhxyncBNW1ijoc7tZXSH08lNOqDU?=
 =?us-ascii?Q?/P8Pr5Zk250IbyDna+fcoW7xXYi/hkeze+sWxVuOG/2iq2TJSF3lN7KzbZru?=
 =?us-ascii?Q?ZJ35yHESyKm2+rFbpntR+hLMxjZzsHJfYMOM2d8GKOOnxNpzl45l3sCfJyIa?=
 =?us-ascii?Q?/nuRCctMJYHBP9RuGofEz/c8IqIw6kHKoJfclK9ypfr3u4wTPwn1sSvUzG5O?=
 =?us-ascii?Q?aboRCJWPSxDcfsvyEnpUU+o4ZwpYBveXQrJ2e5H5eGJo6m5SyEN2CiLHUFlM?=
 =?us-ascii?Q?D2641NlNP328dXyzfUhrlcUteAjzZ0DbT1Bzb11Lf4dOvEX2FmtZ1hI+x8t/?=
 =?us-ascii?Q?MDW4KQCbzoSmSuySQKLFc0xJJpbxNxH4Q65JWzN4WVRACmakxdweEqITikkC?=
 =?us-ascii?Q?IZs9XWHi0DjFbWdkbeT9vQwuzu+aEAhGeTxJEjVz/g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f897424b-2cad-4929-aaf2-08daeff93aba
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 15:18:14.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2411
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fc7a6209d571 ("bus: Make remove callback return void")
forces bus_type::remove be void-returned, it doesn't make much sense
for any bus based driver implementing remove callbalk to return
non-void to its caller.

As such, change the remove function for soundbus based drivers to
return void.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
v1 -> v2
- Update commit message.
- Rebased to latest sound/for-next.

v1
- https://lore.kernel.org/all/TYCP286MB2323BBFCE929111043E60D3BCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/
---
 sound/aoa/fabrics/layout.c    | 3 +--
 sound/aoa/soundbus/soundbus.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index ec4ef18555bc..850dc8c53e9b 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1094,7 +1094,7 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 	return -ENODEV;
 }
 
-static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
+static void aoa_fabric_layout_remove(struct soundbus_dev *sdev)
 {
 	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
 	int i;
@@ -1123,7 +1123,6 @@ static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
 	kfree(ldev);
 	sdev->pcmid = -1;
 	sdev->pcmname = NULL;
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/sound/aoa/soundbus/soundbus.h b/sound/aoa/soundbus/soundbus.h
index 3a99c1f1a3ca..db40f9d042b4 100644
--- a/sound/aoa/soundbus/soundbus.h
+++ b/sound/aoa/soundbus/soundbus.h
@@ -185,7 +185,7 @@ struct soundbus_driver {
 	/* we don't implement any matching at all */
 
 	int	(*probe)(struct soundbus_dev* dev);
-	int	(*remove)(struct soundbus_dev* dev);
+	void	(*remove)(struct soundbus_dev *dev);
 
 	int	(*shutdown)(struct soundbus_dev* dev);
 
-- 
2.25.1

