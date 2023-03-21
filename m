Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097926C2A51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCUGTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCUGTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:19:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2097.outbound.protection.outlook.com [40.92.98.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB7135273
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndOOu36Y8YnaKbOv0gz6gfy4BF6Rrnp0aNwglINTQOBXcTlaFdSzVQmc7axELE9VBU5UnQGLAXPJJylgrcZIe/dT9OiF2G5uX8L5qMXs3AV6MrowmoP8UUh6wZZadSC2HtTPbzNSTbYkl67zACpsv/RZmYiUKbQ8jWX7D/7msssquo0YB4SW17Y6RHpCw09m6dCNuIRguLV6xNRRvHJ8UYDgIT9Lm4V5BS7d3sOAMoIF3QfMW6h+06CDjxvrrKEnh2kNF5Wmuzlp+D8Reur3LfZOT9w29q1EE5qydPpt4AFYdiYuD4zKSAitjjRG3vIBzyBEmmr0Y+G38aDt+8PQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bHJMSSXU1/gAlpLI6wqZp8Y1uUyH7Vt4W5iIEfKaC4=;
 b=OgFiUST8c8U6nK7lQxcnAvzc1BX1Y5cRsLRSSXjT3G3whpdxXuf+4/Km799DYhyBhSwewXKZ3S0OqYlvYBwyP/N6LBaKG6xfQCtdxJ1IlJuqpVZanbTwg16gGX1UTH6kTYzTmqghIch+bzVKWXcFq98CIFPoiS3dCyBWHrJoKcl28xfWmRZhAIMmVriC+V/g3VVwk++GXx6u4dL8PDynykGSL1vR3cOfqz3QdxXWE0qIUfytqzHhVxamQpJeaedtpccsWtZH6nl8+f8Iyz88oD7Spii+QINru2uDXvOsiwDjAxv3XyT5dbsVU98BE+9tREikjOjs1RtIB46MGA9Wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bHJMSSXU1/gAlpLI6wqZp8Y1uUyH7Vt4W5iIEfKaC4=;
 b=aoTu94lO/AIDIyht1762cOfc5vIcx67DirrC3BV+280Tjef+TybvWcr46St71Kq0dNU6OnOy3S1X5gKD2oEYoaN6ajG26F2vP4M0Qu/53TD8duYdL5/5DqNzaHZFualVUgLmiTfmMMQrtOju2cQwz+LFLBsbAi4w1ImUYREk9LXCSm9OYcZKtLvVv3zNPMXoLDZAMU2oGR/V78F1bPYYL6iSzeAHWt5pplhO1ZSKTupw5F4D8hY8gXEf9oAA3x6ohfvZbZ/oRYwDY8PipoYSq3Pue9cFHtOKeL+YJr+Fb8QzMC/Q1osupc1wLRBFmkD273rTQxkiywV4jeqAWawvjw==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TYCP286MB3341.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 06:19:03 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3682:6425:a009:405f]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3682:6425:a009:405f%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 06:19:03 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com
Subject: [PATCH 1/3] scripts/gdb: fix lx-timerlist for struct timequeue_head change
Date:   Tue, 21 Mar 2023 14:18:43 +0800
Message-ID: <TYCP286MB21463BD277330B26DDC18903C6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [LFno2DkCyljTBMCn8BNqry7FC8u2qRAV]
X-ClientProxiedBy: SGAP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::21)
 To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20230321061843.4441-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TYCP286MB3341:EE_
X-MS-Office365-Filtering-Correlation-Id: a24094ef-49f0-463e-1659-08db29d42acf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQL/JxI2MiFI7KTxC7UFwx8k86FOv/xm+pOl2Xpgot+vW2UFXaxXkspS2DXqiMgX1ubCcXZIMfrRg2o7bvj5jlnTahILOpI6G+APuA7rXFwpw8GT0GllgSgu2Qc+LbMeI5nTIrXMCMx8cL5OmVZXuA03v9ng4aejxr03i/ZpmmdtA2oq+zvKzA6J8k/mZLA36nYrXuVHCfT7XFdDTKObeJQbU/NFAOUDYHg/OEqyl6VxkQ1Qls2CeG1JkGkciYUGW2OJ9VFY4uBA5ZRNL64s4n2S6BScKo3k+37m8ODE8spfl+kE+byg/rgO2nGxzGkgcqf1GFfRKuKUixXIzPMRTC/WnWPQeenJscjJiF30HiamewzJFOzjevypRxTeIsZHHQkROtHVdYbDZ6coNvPdK1aiu3ZPf0yn8msayqwRO3mNnxJxX+LHfFu4zFHQ//NR+IiO8kMESZhZh24oK0SjCByHmfX5oblQeJMUXvTRj3+YgPdbRrH8bic1acFUp7L5r/q1iYGXMVtfE3bVu4sxi3dRtpdl15w+7Q1QN4SwFDSmkLSvwJzBipQOD04N0mDDCDjGBH2dkZa5flyvqzVD+7/IYkt5aiYKbloSMwvDJD4=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9/dypto4AC+FzAiplh3KZeSBaRyhR2P5Oi49zPpz3PRA3wal4Rp1vwSVtLH?=
 =?us-ascii?Q?lDfoQ1fbG7gW8hZn1C42Fqt80gY0vOaYRPB8X1TQo5l6B5pcQu4XOGFW8K0p?=
 =?us-ascii?Q?8wxQESN5MtZ06Djp6YyksQXUX9YJlUrf+logNjq6Y5aXPoR6EigXjKxeG7/W?=
 =?us-ascii?Q?FT34Sxz9flw+nJ4+T3e7zkDwBEoavYnC2BFaozt4Fr9hnQHCeJklxT5mMSAE?=
 =?us-ascii?Q?rYNbWeFHwNH8kBBMiLiKxzRIL/VBEfci8ScaLd6wEoPeBvUWOjpxH6VI4Pho?=
 =?us-ascii?Q?qcA7Z1XXMHjf2xOUa7iousXV+XusIhkKhLoRE/ObGrPX+ejLedDrz3ySa+ir?=
 =?us-ascii?Q?JRzLJe5jZHOdOxd+YmLtCtPEmYlAlYc7wwa6GmVnO7n6PmRIqxhSBwFUtxCi?=
 =?us-ascii?Q?vqmKUcpw0J5lZyajr7TFiEiYoIe7xhfFDg2zm7oHiYpQDCca4+PtJhN75JeY?=
 =?us-ascii?Q?L5C1mHGw/kBzUYD2FGH780TOqEoc8P5YyBzMbizXWHg5uXonCoGhgU9Eu6VT?=
 =?us-ascii?Q?Sngk1rLFFMy/8iMWbSnm9YEbt6kTQcBra5JyzEX/xbGJ8My8y/rdW5k/Ch5b?=
 =?us-ascii?Q?6BHr0iZjqAYK6a7TvwrvGy5XBb0Q6pRQxR6CEeSkfw4BoH1G49AGSY5jUmeB?=
 =?us-ascii?Q?CISfhA9A9Dz6/O9ysN5z8ARWwXo/KFPSF6HshVGi2u6l5SUwS7Z4XSSqIthr?=
 =?us-ascii?Q?MHdsrsXzLC1XrwXxfZVqCdJo+b/VAG2jq/pSsb2+K/D9d7PV8ZX8HZHuxOmT?=
 =?us-ascii?Q?TmJ5ZXkQ8UKFv9JzAEdO8+mTNgfqZ/2yJRTVrUQ5HZ8DPtkxowUrmIqyG0Na?=
 =?us-ascii?Q?ap1P5EPvVx4CM90FEdqEPuRDGYFHOtrdIZD55U72maNpc8JtETlXg0VKGMIt?=
 =?us-ascii?Q?nG8/dafKHhRDL7KpJFBao0VWOVZ73uCxbpjtTe3nkv36az0y19rkYvnJYoM+?=
 =?us-ascii?Q?Bf21pfna6krR+mQ22fcuEAsbasym+BMbO4je1s/12qaSo7WCRuSsBwbx04xx?=
 =?us-ascii?Q?KhC88rAeQVykWnianWinto2Tp0bnSsU0/W8bXyBWP2kCcvjN+lYGfOYP4vkW?=
 =?us-ascii?Q?XZqJ3wsIsROHnKuuCv3iKZ5dzmI+6HlS2vcCq9ABZ7/7w67A6IYHCjUoVvWV?=
 =?us-ascii?Q?wjjyYJDBeg8IsFEsub84wYbR4asomIUhcUNSGrEGQL0FuAXg3lx9uzv68NcR?=
 =?us-ascii?Q?eobyYZ07NmOoORtNBFxMsaA1SMZBqgU64PLOLWdPu20Bkk28K5YnRzHodMPD?=
 =?us-ascii?Q?1kjBc4sYp5twQGsGrm4M?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a24094ef-49f0-463e-1659-08db29d42acf
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 06:19:03.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3341
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

commit 511885d7061e ("lib/timerqueue: Rely on rbtree semantics for next
timer") changed struct timerqueue_head, and so print_active_timers()
should be changed accordingly with its way to interpret the structure.

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/timerlist.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 071d0dd5a634..44e39dc3eb64 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -43,8 +43,7 @@ def print_timer(rb_node, idx):
 
 
 def print_active_timers(base):
-    curr = base['active']['next']['node']
-    curr = curr.address.cast(rbtree.rb_node_type.get_type().pointer())
+    curr = base['active']['rb_root']['rb_leftmost']
     idx = 0
     while curr:
         yield print_timer(curr, idx)
-- 
2.34.1

