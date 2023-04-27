Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587B56F034A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbjD0JWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243308AbjD0JWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:22:32 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2038.outbound.protection.outlook.com [40.92.99.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78BE5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpGnyLKMmnOov7b5fr41hjumHbJlHRIXXmoICH+c+/Bnw5FkD4YvEfunnmiNFzdNXg0es2BEFySgDfo8AhwbgAfDcd8oIhqvB2nklEAOwUpmxFQ0t47D7HGdim0K5stNt32ma7vGBBmZ942+XMQg9QjeMtqj1AARV11Mo2O1vK3VBBwGvSExXtPgYf1taZENpO0417AY6LSBKPIiQqxR5FlrWG4NZtcnmzsu6ti4JpofTmHyWPw6HloRSy0fZfuO84xoUsh7+XotpvNf/Qb2VKklf+IsaKSQBXbiP4UWfhHzzFT5n95PcVbda7ysIjo/GP6jFar75corKiV+HjsO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOUlGNIRY/lMlfx861Ci4/NJkuFU1tcY2zzX3tMNaJU=;
 b=E2vcp6GjCdznMtN3/58cu7nf6J5psOVTaZfEBapZ0uQpOtyn2lvXahp1Wopvsy6IBVW+uTWRB4F8tzAqYhSqyzi/Qu0i+eh9Njmop5n/9jZuZovqzZOgtNqFBmjuJFNilzOq8kSUoeSHt2qeKSbALlB1V9kAC9CnKYaUGzhaetTUtbwUbf92Z/wCUzYc2yfPDVqsR7BtncEvBoLd6HEo+1JGuqekHZnkEfoXYYg6uw3m5/zro/Pq/VHr6heJFoEcWEXIJlDHThVWKy0lPIxB8y9jwft3r+mq/Awyqweo17TzKUTiIrG6CGSw8KUC0/rtR34b1LzLZ28kUbFvWmZ9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOUlGNIRY/lMlfx861Ci4/NJkuFU1tcY2zzX3tMNaJU=;
 b=bvY8+aHQcEY6QWX/vp7fL/v6bwRDLdFpHZNrHlG1h0zfHwdkqIX5IwoQuRr/vOMEvOzzeMczFNZ4NzTM0WkW7WR4ba077zcxsTZqc1/CETlAAY4K6NunpzkJdjoj+sGbMxqeSqR6fX/3XQYNVFtPjLVI7stCYNTvW9YqNGQuz5zrKa3JjEmhhXJAQRJF++FHvMvmKV6/ZbSjRSrlLMLBbCNQ93KkclTb2uY+Mrdm9YxZrLv+cH03NtXqqF93KqFar41bdQKGPsW+9VKGvHfIhVxXRZBLO0CQ+qrGBuMLxc9ZW6te0kCpqZwwN9vWpRFhx+2AbUlEtqEtuc3zwBR/XA==
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d9::7) by
 TYWP286MB2636.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21; Thu, 27 Apr 2023 09:22:23 +0000
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ac1:a1e6:7a7:f317]) by OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ac1:a1e6:7a7:f317%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 09:22:23 +0000
From:   Yahu Gao <yahu.gao@outlook.com>
To:     bp@alien8.de
Cc:     Andrew.Cooper3@citrix.com, dverkamp@chromium.org,
        jirislaby@kernel.org, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, peterz@infradead.org, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH TEST] x86/lib/memmove: Decouple ERMS from FSRM
Date:   Thu, 27 Apr 2023 17:22:05 +0800
Message-ID: <OS3P286MB063237B67277817B953278639E6A9@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <Y/yK0dyzI0MMdTie@zn.tnic>
References: <Y/yK0dyzI0MMdTie@zn.tnic>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [lS77InITbCTEoa3cLuRswc7Z6NVsK0wt]
X-ClientProxiedBy: SG2PR02CA0118.apcprd02.prod.outlook.com
 (2603:1096:4:92::34) To OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d9::7)
X-Microsoft-Original-Message-ID: <20230427092205.2936-1-yahu.gao@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0632:EE_|TYWP286MB2636:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6b872f-8aec-454e-82e7-08db4700e89d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZu1ad6IRC8pDZFayu8a259BqxS659+pEz0SxMFjElxTII9nB+V6dtoti1iuta+GsfWvNs3gZ6fkG98LbIOHAnPvQbcQvDreyEVwinjBzh+HJZJ1gBUGB2wXErsUtaRd/PHBuPrj/JZ1uu5Ydh9U5UGx9eDisX4x0l5JX0J8IFQNO0Sq2zS6AaVhZroBOPoN8/DInZCqJVjPsI2ZCJs+JCm45Ih6aEk5+AHS+LVs79ECkuD3/A/9cZmCUQmw+FbVoUaZWDWLH71/eVVfpJTjqNdIQ/uExgWVUTguc2kFg+WzpRW51cuNi7YE40JGcl7kKcBIKnG5Dj+A8YCq22+q5T0RQECUrEHVBNTt0MdiU2tbqz4lc/WMjrbwBiTDER3vK7nE0BMnjpgrKRXNkLXL74bIk/RCxBY5QKEuwwBe+oOhH0kAJLvp+EwHXHLaSV6/cknDtFsYm/JH4LJdvE3Am5FzRBd8wv45GbQWIbPSqmqJ+ja1qZ5hYjT/RX+FgUin9zAHoO//sF0KAl//Qph8t6BIBXgNATivUFtF4NbIpdQnDTZJGSF6537xzoBG+Pnf
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AxQ70PYaNvvFa3CpmvLKmNU6iO0OlhWMU2aDQUvo1t7Gek9kugf8sEiS9TnR?=
 =?us-ascii?Q?2s8M7Vtfder5XcA+V1WLYo/1IM/1RG+8ymQ4lhTa0W2qmVeKG1MHRhqz7FIn?=
 =?us-ascii?Q?Ux+nHL5Xornd27QFJr2D3AGCBcK8ZUegXautKyu6oR9AB4JB8InFfftUFP+Z?=
 =?us-ascii?Q?dZcqQrEYgwoQ+LINEhtSzObP2zylHFtZqlsStqVBBqq+DKs4yJqC9zd3JhGh?=
 =?us-ascii?Q?xWRY9ixSYyRX6VLvXBkRnK05XiRyg0n/G6+FEJh/WelXrWe0FPEVMokwqTtO?=
 =?us-ascii?Q?U296y1Tc8NZZ2cOnW8tBBb6Zme1R0QrVRo3rysr7wU0rCrea2tmOLPlWRjYW?=
 =?us-ascii?Q?+4qZoYWdvaI2XfkHngv/K26i86V6O8szQ4oMalMWl959oOXw5EzhQGdoJKGH?=
 =?us-ascii?Q?rZf0s6Pils65Nimzrp4YHMsGa1q7qjIXr9DFkmb9YKWmQc4+JOAgrH2AwZDi?=
 =?us-ascii?Q?ZZ01e57rnDTHw+5jASM4hZkzJFBXsc/PZPE9j2ChfdEIs8+Vpof+gzViGTaj?=
 =?us-ascii?Q?1MFHcN63/eFNE5nzaLjdcfV2mRvJ9qMXdyB770hN8WSNT65/qmDg3ufcA592?=
 =?us-ascii?Q?NT/JCHhIUD3SqIHr9NAziMG0T5xOCJj35REBWxt0YodpdobMjn9KbjP7ta4r?=
 =?us-ascii?Q?VDlbEqhu57KvrEec3EOjNcNGhwy364Z5ENlgipGebiHmrJuURs3kGBR43Oco?=
 =?us-ascii?Q?XX4QUt0uwG0IG+La92/AcUwSXF8l6O3rypV1VBzkhe+6WCZGoMzIWdfWV9q1?=
 =?us-ascii?Q?8RzmETL19KERrUtqws1rnIIlj4GpS0KZwMk1feSrehygTGyVUK50fWuRxNYx?=
 =?us-ascii?Q?0AL7BGB7YeeJAJtiq+LObeQON1UOkAUqM03HAp9gaOPg8nZxBT0Yba5kSIfY?=
 =?us-ascii?Q?oswXEeVcOoRqRHdfUg88vV6nRNis90DtqTn5Y7aXLZ5ZcY3CXfIPG8Qq2S+l?=
 =?us-ascii?Q?tOXGTW7LxLi1TnSoisgi6s4+NOMU9MHPPIN7R5E+fFR78WvvnqVGAnJLdc+f?=
 =?us-ascii?Q?XTRHlXxwkcQzLerb5v/5VVoHPbvI0veeFh6baeYSSP32xxZ/qWoNxHLhCybl?=
 =?us-ascii?Q?YomjbeDL6kTWgHqfoAIN86khuVdfpnWOqZD/02GzG1pxOqo7Tu70/PZVzep6?=
 =?us-ascii?Q?G5mSCovd/xGNRfM8ZXTjwEe836mrx2aNHfRffb4aCKrvATf1Yz7RAHIzXdTL?=
 =?us-ascii?Q?jhfnm9YA+qtiHFrDjcE7h2xxOsyBAjh8QOxZUQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6b872f-8aec-454e-82e7-08db4700e89d
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 09:22:23.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Yahu Gao gaoyh12@lenove.com

Now [PATCH V3 2/4] has a conflict with commit
5d1dd961e74334a2178264193ea813d44ce5e725

Except the conflict it fixed the issue disabling ERMS in AMD BIOSes.

