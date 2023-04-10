Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16B16DC4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDJJCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjDJJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:02:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2018.outbound.protection.outlook.com [40.92.19.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3D92D62
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwo16Fz7HMV7I6s1Q3EybFhj7bISxKPJI2rY3trYEhQxMhkJrc525DkZj4LWsJBWzxVeOH/I1bH0wXixrq/jcQNienFJcO43illP6ce3CsdXLQdy6LF0qq5gVe2JJsY14n71eB+mkJMxG46xkAejTnW/rboVoLnLNxOYFUdVL5AThQg/Aa3qO+oHGpmsYF7n5dVLgnZEY6GVKrI1qJcRvbG9pzpXdk611W0943bErixaeL4mXFa3BZlQcTaZm2aH7MnhFuuJd9z+wPPhJ6uMXsnH2XjZpwEU0noXbOuvuDhtjPjQd1plF2qdA0/2eIkOv3wQWfg3lRmTMj1F73Ijsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRbUrKpTEjIuMH1C+Oeim/P/WdMGuZBs4i3UveQOTV0=;
 b=k27RhcSIrmD+lv/TWXELQcWMXmNoWa4z6IAQqwO+l+nyItF+Snr3ncIG/tscFYY6dHq4F/+waqDBeowTjSXrweot08wikCbvmsqbH9HOm7ReYiDQ6+t2EuuHgmHPH+VV3/NY92aMCXr6JK/CNh+9Oibge1M/w8e23Y4hp74tak5e42MUPrtn/p/ekGUW8d6sp+C/WerRPesBGK98pHJn3IDMh8/aW6JRsO83Nd0mxWL7GO0IUoEtrCr59GPJZAHm9hqT35cd0U6YdY/rkqjU5Ltc/45sKu1alwP68MFFT/WSfzIfH8bBMFSXn5b8iaOL70o1TJ0jzjWb2dejceriBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRbUrKpTEjIuMH1C+Oeim/P/WdMGuZBs4i3UveQOTV0=;
 b=gmQmM10McAtQAmUVPoNvQYa0LiJHNpm3ak6nSqraaJHnax2asr2ATk4xocYGfO/hUzDrNFpy3bholg5OtggYIWiMOL4u8XcPJ+TLeqnmYfH81MKzOFXRJv2y4NoWGIn36+4JNCxpGPkkRtpPlpzvh7i5fI+a/7miD/gUpSuKu+SBekWrWtfKnJDJiuP5M2/tSZPJI3IKftMI8szrOs5utPk8qeZk9bqpWZ/gRgWaomdcb2NEJYuOriLz9a5Sk//tTxWJrhJbXmeMvJ1YAOFxysZcaADJChmAE8g+DC1PSyeyyVFcRlYwWK9ygd+ItEgbb1QCj10PqullV9UGEU29zA==
Received: from DM6PR22MB1836.namprd22.prod.outlook.com (2603:10b6:5:25e::21)
 by SJ0PR22MB4380.namprd22.prod.outlook.com (2603:10b6:a03:51a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 09:02:03 +0000
Received: from DM6PR22MB1836.namprd22.prod.outlook.com
 ([fe80::4b7e:925f:eeca:488c]) by DM6PR22MB1836.namprd22.prod.outlook.com
 ([fe80::4b7e:925f:eeca:488c%4]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 09:02:03 +0000
From:   zhaoxinchao <ChrisXinchao@outlook.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     zhaoxinchao <chrisxinchao@outlook.com>
Subject: [PATCH] mm: Fixed incorrect comment for _kmem_cache_create function
Date:   Mon, 10 Apr 2023 17:01:42 +0800
Message-ID: <DM6PR22MB1836D8C5348D28989105DADBC5959@DM6PR22MB1836.namprd22.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [FHMU8DzyWEwkc/BXqB510O+Ys6ytbDoB]
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To DM6PR22MB1836.namprd22.prod.outlook.com
 (2603:10b6:5:25e::21)
X-Microsoft-Original-Message-ID: <20230410090142.12442-1-ChrisXinchao@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR22MB1836:EE_|SJ0PR22MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e91249-5401-44ed-a322-08db39a24096
X-MS-Exchange-SLBlob-MailProps: 02NmSoc12DdnXLGGOuD9rmefhPe+K3xZxO7oA4JCSFWlG+a4c5RJ8YOGX/hEW6T8lBQyg9wVTqgZ//ArmQlyEcdxXPPD56m2NMk8fl4qniUF3EK3dMepxn6tPNnuorArDZGy8Yp+SIV7ZSBv06Hj5N+CLvBUAwd01ceRh7iCFz86OiJxCCqFUBBBkFTfgGfGjKx78fPi6yV4oTRUq3Ei15CIBYINdcQQzYR8mLX9SY72eHVGEYM/mpv+H0mqjyl0LSeNOnFudI0R9JFlNPwzeHseQ+Uc/en7atJpteyvY4XTkkWr47iP5mwoc28w198iCY491f1PEmGUaNhmgfNq/bQtYQTCKu67p8yjNvSzLe+kPBl/gQCFH6q2aLlcKaleAw6RmYXvD/TAq5fhojPA8KkU0i/+/ShzcvnhMht7aqNGLMaYCioXQ3lJIba59st59MGOaC3K1OYlL9xA4lI8boo9VF6INHukd7eXmaISnDdS8iBbbMwUnN7pnaXUc5bFOL5/uClDop+KmSYTefb9bgE+E3qrhepwnk1bE6njUr3mFDf92t9J63baCF7ub/+DRWTBFAnhYlt1Ts3WmRShZ4vC3n9Xza/oFMdwRC8jpT+UFzcyIPXws72WF/HKdcorIVABWcN/gcTF4z3QjwjbPIDV49abe77vZeKiY0o4oBK1Dw0GGX7wxtDIcR0+Vbtxm5F0SvYCo3y5STV0ZJeV3Nn//f2GqGuj8PhmEp7vdCtmsiixgyh2TaVLSCKRu9Fi
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xqO2V4lydQJ/7qk0EheBKpZeCd1F3oRfPYha07wbygfgftUHtiwD9kKYRJ7daIxZt/3v9WXeXpD9V8JCOUYm7Gj92PDs1WV1GfwHBq++TZOAPM64ys6BMTZCn8aR0Mr1W866RdsgrV3poXzo37XAmm9zzyRFusHdFgHsZS5ZPxJ9MsNbHZOOlmjnKIhL2ri69X9eAGP0+eanWvItgRnPqs9xr3VY6cO9qmznFEHoqeA02LCTpSS1pV4qjm8/x6tL6Q1TT4PqfXK8+Njs6k99roOdKz2qhaFzy8AecKEwBoEfxd+1JFpKwFiBI6XHFAiMp7cGCeyr8fsaMcMFy5oZBHCVuPeFP4u5zj0gjlqeJ3aR0qGFsmJH+BPwwFeKNSUcbce5tivMc9VjR5wzB9xu+QSAR/stq4uV8yDKaeE4IzFMOZJ7P5VMzcwGTeQG4a7ys6Ts0lVjki8Jdb8OyDgCyvp2ZVG6WehgGGavllR5v7pjAivlVn+/aMkRT/GUNA7N5HtrOTEJzyZWdR88qlvSQyeAd3nOEfVLLSQkkgdBcztZHDD753fAjuSGQEnBJLYda9R1NkIoM27QYi6Riv/Igsq+mUi9hEFNiaM6mMBvJ5DZh1yFtWjlzbnXY615MpX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OEpapxng7RPh2elB3fN7vlBzOfcRbPpG22jSlZNhuiUV5NsnLzkV3WhPlxIz?=
 =?us-ascii?Q?ZguYwvKWfwAwMU1yY6zHVys5GJQQsIGzZ8mkbdt9wXfVtHefcCD7uEtZlzy1?=
 =?us-ascii?Q?ho6mJJXbUl7YSzs17/ybqS5YwM3eEsS7Vk7dBpuAMZID2UmJ4eJ6T/DTD6vT?=
 =?us-ascii?Q?BBViI2aR6fni0soFuc4pAnQ/g1lTKJxafktdRrbPsfY4xkqFveucbUnsbJRN?=
 =?us-ascii?Q?qyHwk6RTr3/89uBa03p70ntB2VbP8WrXFJOivjHEOSWlAPwzINbHzrThrEjf?=
 =?us-ascii?Q?/tUmappJjBx8inOdKE0SIhTzwbW+QzZ30NOaVH1fKhtskRXRvrodbzWJ7k2s?=
 =?us-ascii?Q?46h8o7zInwtc5BuAbuKXl08sK/LCXwV35U8+SI7t0cJ50kie2U42P4msqaMT?=
 =?us-ascii?Q?dBwN+zD88j0eN1KS1jxsRHlpzo8fwqk3/d63cfy6YT1cXjxx5vyD0KFLYcad?=
 =?us-ascii?Q?QeT9L6eEH9YM+ydJ/VZX/yFndjkLMFofSHXJL2ilK0IwyVSkVNTtd0Z/3H0s?=
 =?us-ascii?Q?e5/uPomYitup06ZFiK4LZNt1hNU9oUsMMn7DR+BJ9/WdJ4yg8zG8pVCJ7GL2?=
 =?us-ascii?Q?4wG0TKdm7JdiBOoPBqxr5bUCrlnF+QDo3b+QFsS7Jel1xAFzvkG73fG8TRL9?=
 =?us-ascii?Q?QxZzQwO/9cZrvt8Zhir5lOzEhB7Mz63mcYmKVa+dgdpPfNUzBQDn0MZpuyp7?=
 =?us-ascii?Q?RAOQi1O1yo5N7oQEAeMBYW50qEPHBVYFzGtCcFtsqJhG0VQqm3MPbfbEBDfm?=
 =?us-ascii?Q?8VlWoTDYj/uM8WIB0tX/+rkppWZ2rEA8IdHjBoh2yQ31ZuytNZemUNXjQG1X?=
 =?us-ascii?Q?K36XC853GvIH7uP7S21qb0VtKvtbPOiWYWjNac8np4Qg84iaq784VJ2iwL8Y?=
 =?us-ascii?Q?t0NaCJRuYtF38OEToPEeW+tDvWrGljOPUIfOVr93OqZghR42FKtcVvkXg+cS?=
 =?us-ascii?Q?jwb+PiX9XC6IrJ4Vi+Y2fZD2Mq5VaVXNAmoj2ZmiQQ30A8KBNxuJOw06YZXY?=
 =?us-ascii?Q?Rn+0uAPpWckni1EiivAzKlw9OqHAaRfH91DlQz3Tw1lP1E8WGRBvBB1UzQZw?=
 =?us-ascii?Q?Ft8Sg+hEp0B/0mYOLulKnRnDGAMivBuzL2lgGnBYm92xtgzSxJkrtnR/4VVb?=
 =?us-ascii?Q?Xdk5CXTxc6P/Z+2Erdu9DyDErcUs5f0LGJORvV2vLjiCKAji3WMiWWdNPm/K?=
 =?us-ascii?Q?1OdfeThZkQhMvQyF4NF42GTPgmuu+4Bo1IKUB1iKZMQVe3X8vRx/u4yWySs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e91249-5401-44ed-a322-08db39a24096
X-MS-Exchange-CrossTenant-AuthSource: DM6PR22MB1836.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 09:02:03.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB4380
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhaoxinchao <chrisxinchao@outlook.com>

Actually __kmem_cache_create() returns a status :
0 is success
others are failed.

Signed-off-by: zhaoxinchao <chrisxinchao@outlook.com>
---
 mm/slab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index ca4822f6b..65985f767 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1901,7 +1901,7 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
  * @cachep: cache management descriptor
  * @flags: SLAB flags
  *
- * Returns a ptr to the cache on success, NULL on failure.
+ * Returns zero on success, others on failure.
  * Cannot be called within a int, but can be interrupted.
  * The @ctor is run when new pages are allocated by the cache.
  *
-- 
2.39.2

