Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EAD631E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKUKdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiKUKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:33:42 -0500
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E85227CC3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1669026820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4p0/tD9nmKeKYFF9dxbiWoNZZF40bde8hOcTGuaiPP4=;
  b=So/+NxFFBu8FiLtTGl3jM0vKEcsOA2utY1hg5cWf5Ugh7kiTcZyoR3rx
   hhMOJ0UjSoG+1uqSb3euU3v9GNk4D7fu1Bv/oLH4JoKBglYJyRaWfyqUV
   44EQz99fGLf2PBowofaC0POvMOctLL836LRMAaXCTBPGis/fs0NRbBClH
   E=;
X-IronPort-RemoteIP: 104.47.55.171
X-IronPort-MID: 87779431
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:yCsLaKweCgdYjLlgNDt6t+dHxirEfRIJ4+MujC+fZmUNrF6WrkVVz
 mtNWDiOa/yPZGbwL49wbIy+9x8B6seDmIVnGQBsriAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTbaeYUidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+U0HUMja4mtC5AVnP6kT5TcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KV9o+
 OUnLzMpUlPdn8WHnpO0dO5Qpdt2eaEHPKtH0p1h5RfwKK98BLrlE+DN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvjWVlVMouFTuGIO9ltiiX8Jak1zev
 mvb12/4HgsbJJqUzj/tHneE1rCQwnKnA9t6+LuQ6L1xu3iT6jUpOCYIDXjqh+O4kEGmRIcKQ
 6AT0m90xUQoz2SvT9/gT1i7rWSCsxo0RdVdCas55RuLx66S5ByWbkAUQzgEZNE4ucseQT0xy
 kTPj97vHSZosrCeVTSa7Lj8hTG9Iy8ONkcZeDQJCwAC5rHLqoYpjwmJSc1/Cqmrld7kMTbqy
 juOoW41gLB7pdIE07WT+VHBni62oZ7IXkg5623/W2Oj4QRRfoOpZ4W0r1Pc6J5oJp6xR12As
 X5U3cSThMgCBI+A0iyERv4AGpmt5vCYIHvdh0JiG98q8DHF027zI6hT7St4KUMvNdwLERfpe
 Eb7qxJN44UVN3yvBYdseJ64AckuyanmFPzmW+rSY94IZYJ+HCeA+CxtfkeW03rajFk3kao/N
 JGYdu6hFX8fT69gyVKLq/w11LYqwmU0wzPVTJWilRC/i+PBPTiSVKsPN0aIYqYh9qSYrQ7J8
 tFZccyX1xFYV+64aS7SmWIOEW03wbEALcieg6RqmiSre2KKxElJ5yft/I4c
IronPort-HdrOrdr: A9a23:ddTW96zTSUlfct4YXSXYKrPxTOgkLtp133Aq2lEZdPULSKGlfp
 GV9sjziyWetN9wYh4dcB67Scu9qBTnhORICOgqTMyftWzd1FdAQ7sSibcKrweBJ8S6zJ8l6U
 4CSdkANDSPNykcsS+S2mDRfbcdKZu8gdiVbI/lvgtQpGpRGsRdBmlCe2Wm+hocfng6OXN1Lu
 vr2uN34x6bPVgHZMWyAXcIG8DFut3wjZrjJTIWGhI97wGKrDWwrJr3CQKR0BsyWy5Ghe5Kyx
 mOryXJooGY992rwB7V0GHeq7xQhdva09NGQOCcl8QPLT3oqwCwIKBsQaeLsjwZqPymrHwqjN
 7PiRE9ONkb0QKbQkiF5T/WnyXw2jcn7HHvjXeenHvYuMT8ABY3EdBIi451egbQrxNIhqA17I
 t7m0ai87ZHBxLJmyrwo/DOShFRj0Kx5V4vi/QagXBzWZYXLJVRsYsc1kVIF4poJlOy1KkXVM
 1VSO3M7vdfdl2XK1jfo2lU2dSpGk8+Gx+XK3Jyz/C94nxzpjRU3kEYzMsQkjMr75QmUaRJ4O
 zCL+BBiKxOZtV+V9MyOM4xBe+MTkDdSxPFN2yfZX79ErscBn7Lo5nrpJ0o+eCRfoASxpdaou
 WPbLphjx9zR6vSM7zM4HUSmSq9AllVHA6dhv223qIJ+4EVH9HQQGi+oFNHqbrTnxxQOLyeZx
 +JAuMnPxbSFxqRJW935XyOZ3ArEwh5bCQ0gKdOZ7vcmLO9FqTa8srmTd30GJ3BVR4ZZ0KXOA
 pxYNG0HrQM0nyW
X-IronPort-AV: E=Sophos;i="5.96,181,1665460800"; 
   d="scan'208";a="87779431"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 05:33:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfMIqcuWdpLfMQRAAJ0ptLB/TEY+azYR7NbmuoX4NlbyKWzvGRST88tR6rNQebex0ROMS1llOigF5ojuIyUFNnhf6101FPpM0V9HcoDy39NJnUvSJfbLzPfXckeB2cYVioN9VYtXSwSzErnk0QrjhESs43UvLj4zRBE8bxIYnM+9rDgAJHGQ9Agepr69JBL+CBEO+8yqAPsQ2nlqlt1gD0+LzsCdpYgxnx+zjFWOeP2qe9+8io0CdciMRaEt5nFKOtvnejvQoKMsk1jNSP7uYZuiDIay7ZCiAzMhmF16FH8U34C0RQkg6lF0AZJGntwutgAKdavrqaSmB82LmMxgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z49Tu1Ypmjei/9l5AHd8zeioUpwinUkwsOpJU7h/0Lo=;
 b=E39mtrVFOK3jj4DcwYxCysmTucj+7wzgSPcyqjqvsrrRP4tFobQOAo2ICYf27WsCXr3HeGP2FRaDwc/IHjegd56//DNQfE/FINkbhPAJQFhwRo9YxMnGuQXU3bavViNamNqykmEHuIjUoHCPBv8BtdSwjClJHi+jD7qJQ6qHfUX4c3CJ7nCKJPZe21vxe2N4fgsgDNGuUQYRxOIAAxEZjJfbJICbCwHAQUp/Xst7YEhZwfo8X3bfJZ8ws7BFQMn/NPQjNtTtWvRXU04KN9TWfBY0KAU+wiNtYriaB8tQX1S9vEbOleaIE6+NCePZQiHOROBfJQHrq7xbswh3afbVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z49Tu1Ypmjei/9l5AHd8zeioUpwinUkwsOpJU7h/0Lo=;
 b=nNwZLtkZ0BWg8TmOLyqJmlvcVxsJCRq8MRKF9ORweR4QIOlhcF7WyXBhTCRS3Q5M+D8j7r+j31POxrZxhJAw4/FKCCWLsqhwhD3k+sbL/zf3IujFLtMS1re7YAvXnSDiJtI20/zD4HBucxT/UYGDWbPPDGRNYoka6rlbhQd428I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by BL1PR03MB6102.namprd03.prod.outlook.com (2603:10b6:208:31c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 10:33:35 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::740b:4e0a:7de4:5ab1%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 10:33:35 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH 3/3] xen/acpi: upload power and performance related data from a PVH dom0
Date:   Mon, 21 Nov 2022 11:21:12 +0100
Message-Id: <20221121102113.41893-4-roger.pau@citrix.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121102113.41893-1-roger.pau@citrix.com>
References: <20221121102113.41893-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0620.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::16) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|BL1PR03MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: f52a8980-9f7b-42ce-36c5-08dacbabd6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRDCH1YOIuHSOcCwvQrsm1XnPDPZS7doelFmQeTvhuvelNoHhlW2HHDKdaoytEMkRCTaG88RaQA5eqQsldhaMYnEHkknLvV8P3PbqNcvABi+KdedVWQLy+S/sLnAqcYIN6GD2ZJs5+55Y8yhzkeBHk+NuxQK5eY3bdndUJ4X4azAYbstAxFRtVvCCZNEUitElQ84IllbMTy817sELMJTm9AWIuebtM6vtF2offbGM82po5/YNZs4K2TARSmrwukArSWN7TR/WB4iyWj4A9LoycjuB05OfGfJmZJ+YCqFPfFw3vyOHXhHYiHtjBaCnD2Umhnq8+tlySAYXce5msVdwN/d6tC3v95aOqaSELAAvSstsgVWTWFwdYou+9CyHvktvvfGBu/sQCBzDLset++NxOG/uBEx2PskJC/Tz7qD96XFNUQsvp5qWq73a41XjGphbdUE7TqIY+GT8QyNxmRibaIQqgJkp30v40s8i8FLad6YGeJTjeZngzUulp0tC4zq33vf9fGNCQfLS/co7dOwmMziwjpUOM1gHfaGiZrighULF70rm085GGlCP1QlaUhF31iSwKmlfFPx27pGJn7sKBQCU6x1jg9IQF6Vw3+v7NgExFJcfGOPwtfKCNyjCG2NidLmjut6x+RBnJ0jBPxkRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199015)(478600001)(6666004)(6506007)(6486002)(54906003)(38100700002)(66946007)(66476007)(26005)(316002)(8676002)(86362001)(30864003)(6512007)(83380400001)(6916009)(66556008)(4326008)(82960400001)(7416002)(5660300002)(186003)(41300700001)(8936002)(2906002)(1076003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCtwdnRjYk9sa1lkK0g5bTV1Y1RrbVo0NUJrdGozMGljOExDVzR5N0xNQnhu?=
 =?utf-8?B?enVpTjExN042dzdpb0lpRzNMWHdDSDF2elVrTXdHbnRrNTNLdXRjMnVOcHFj?=
 =?utf-8?B?bHdSSXhXN0M5VG5qUjJrRkpLTGlMRlNpeDJ2djZVVzVmYWUvbU9UeUo2aklw?=
 =?utf-8?B?d29mRm9oL3Y1WVJiNzJlcnA1Z2NzTVNIcmtXM3drRDNOeHUvckNBanZFY0c1?=
 =?utf-8?B?ZnMrbm9mMHI2b0FzRmVZVkpOdXZYNFdiVWNIbEkrQ0NXdDJYRHJ4bkk1eldM?=
 =?utf-8?B?SkdEL24xQ0NMcWE1dXBIcm5KUzcyWUxGc3JkS3ZHZkd5Ym94M2RjSm1LL0ZI?=
 =?utf-8?B?czh1YXJhWFFsRkFSMEZlYndscGtGakVhNlJ4UEhvTlVqRE1JNmJad0FzODhN?=
 =?utf-8?B?a0R0VzQyelVxWVAwNkZ0bDYxQytmY3BWNi9ITENhQXdCbENaaDhWelBKR1ox?=
 =?utf-8?B?M3VVL1cyTExyRGI1b2UrRzFQVE14YTBWdVJocGhHTVVERHpVSGtKMWtsVXdw?=
 =?utf-8?B?a3ludGdZbUJKb2hSZkQ4VFNwWW1kZElwU2tRMkZaWFIrMm1SVGVOOHZnNDB1?=
 =?utf-8?B?cWFpbnZTNTluL0h0MVBrOW5sWE54MW91QytQSk55b2xVNThUd0hKTHo3ZVdi?=
 =?utf-8?B?TXRyemxDQ1dVSHpON1FjSGpOLzdERkg1cEltakI3cGt4UG15bUxWbDZkSEYv?=
 =?utf-8?B?NnhRQWFHT2d5dVNydGNUL3hZWjBIZ2FhNzk3d0p6d0pPUVd0Zis1T2lBSmlr?=
 =?utf-8?B?bDJrMk42OExQMDhpZ0l0VTNERkNldzBSMjhTaFIrTzVvVStvam1BZDdvaGg2?=
 =?utf-8?B?TDlxcFRQZi9yN1l4WkZLdkNWK1oyT0pVaVRjRStscTllT1AvbzlobDIxa1ZO?=
 =?utf-8?B?elV2dVhiZjNvZFdTcE1NMlFIaGU2RlZycjI5ZmlndDl1RUV2eVZZQlFFdWla?=
 =?utf-8?B?bGJqZUtKMGIyUlVINFlpOGNvODI4ZnY3cytQckFZQ3hqTWRVVmR3WllLN2xR?=
 =?utf-8?B?aGJZVEtEWFkrL21OYlBkRTJGOUZ6V2ZxVTJ4U1JPTDhlOG5DTHBpcXlLUE81?=
 =?utf-8?B?d1JDUUNZMGMzSGJrcVQ4Z1lpbCt6U3l6ZG45dmlUMDliZldzaUxwb0QyZUtr?=
 =?utf-8?B?eWM1VkdjZ2Y2TVBhMTA5c0VGZElvOEJueWtsYlUxNlQxMjA5RWZyM0tzV3VW?=
 =?utf-8?B?T3JqVUZseXZIa3dWckJLWEYzMHBnY3E1dUt0Vm56ckxjNmVWNWF5STVOSTBF?=
 =?utf-8?B?L0J3VXl5ZEhLREJIc0xXMEVyZjFZbjE3NlVSallNY3NNNnJGbjhVaFlYbzha?=
 =?utf-8?B?aUpEbGk1M2RXM0JsT1d2U3BNNEgxcndYeXpWaExGQ2FBVTdNMURmZlpacVZi?=
 =?utf-8?B?cExPRS85ak05SHRIR0d5UGpUNkxTdHNwQzU2cEVoeTBpTXcvOE5kZ21uY3c1?=
 =?utf-8?B?Nmt2cWlpWmxQTjdTRXo1czBrMmVJZ1ZhMlhjYm1FTEJmNjRyamhUcVJsUGt4?=
 =?utf-8?B?ay9DYXhYNnlYZkJPbFhXU2Rlam9wd2JKUy8xQ2FMWlVSR3d4dEloTU5keVNz?=
 =?utf-8?B?dlp1Vm9pdEI5T29COEhBK3RoR2dRR2YyY2N3Q2owbGU0QzVQWVRzWFNqeGhS?=
 =?utf-8?B?UFkvSU84OEFOcFpIc0VpK3J3QVJQckk5M3FkKzE5N1Axem5oVHJQQXVhVFJ2?=
 =?utf-8?B?VVNZamJzNmc4eWlVVDkxL0IzNVE5NlB1SGtUSHBEZHJIMENIdjdQTktVQzVl?=
 =?utf-8?B?bVpYUWN2MExGZ2VkUnpQTzhWZTl1bzE0Mk5DbkpQYjgrMkY3UDBhaWptcVNL?=
 =?utf-8?B?YlVOU3h2WVY2NENGV0wxejVpdUIyL0YrQ1V4Snptc25uZzNOaGQ2YjVEQzYv?=
 =?utf-8?B?alFramRqQW91a05Cc2hVS0dGYW90NGtGQVMyeFZSNVRYeW93Vjk5QkhHYU1r?=
 =?utf-8?B?dlJOb3NMSUxFNkxpMkM5b1lOOUFQcnN4bU0vUmloLy9DOGRRbVFZTjUvcEg0?=
 =?utf-8?B?Ny9JUWlWMERzOStjUVBRcGNSRVBUVmpZMjd0OWZ6bENlQjFGU1VBWThaZnBs?=
 =?utf-8?B?VG9HeHNnaXpGZFFzMlA1OHpzM3lmOW0rN0FlalBBSmRMSEg2WUwrU3d4dDRo?=
 =?utf-8?Q?ai2xx4MYkD61xLpRV9xxae4DM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UXkrdVlhVFZLb3IrK1U2Vlljd0VjNy9qbWRFdUtKUGczL2VnYmNnQmxRN1Nl?=
 =?utf-8?B?V2E3Z3BxVkVIWHREMHQ3LzBZbHQ5M0VUL3BHc1dNaWVaMnBjY09ZSmhuSFRq?=
 =?utf-8?B?MEpIN0NWSndKWUp1eE9EVXdJczVJRzVuTHJab2NPdkt4YjV3NlVTS1NSSWQ3?=
 =?utf-8?B?WlJOdllUZCtwajYza2dZeDdwaTZCN2JTcjdLNzF3enRGWEZsRXRoaUQ1NmpX?=
 =?utf-8?B?SmVQQ3NSR3lTb1dvclViamVjemJxMDR6T0RlTnpXbWV3OFlmMXhYS05lNy9i?=
 =?utf-8?B?Q2FQc1lvRXFSZlRDM3hjbGt6WHNIYThYNlptL0VOanhhem45RWtUQnIreEM1?=
 =?utf-8?B?bWFRTm0vWURaUWRPK0I3VzZrLzBQeDQxWkNzQXB0a0F0R3pQMzBrMkcxekxa?=
 =?utf-8?B?RU5VeGc4ZTRPSE5aZGRDN3NzSHhmY2QzWFpBcDV3dXByR3JWdjhkckRBYVRa?=
 =?utf-8?B?V0NycDBCaWVPbDZOWC9DeFNRSkJDdm4rUkZMdjVzOWZNRUV0TmNYODB4K292?=
 =?utf-8?B?cHF6YjU0ZXZJWU9ZMHdBRFdGSzRtUnZFbUd4YVFBMDRWQ01OYkl5ejd3a1JX?=
 =?utf-8?B?NEhVNnpRbUlUVDludGVQSThiTGxTbXMyRENWTE5neWppUTdGZHFoOUI3UDlv?=
 =?utf-8?B?Tnc3R0VKOEkzTVZJVkFXU09pV0ptcDFFUkVzUDFzaHU3d0ZhUzNPd043RUY4?=
 =?utf-8?B?QmNNekJRZzRrSGdsa2QvR0RGU0xIRk96ZmdjRlJnc3BhNGxBK005Vkh1OXZv?=
 =?utf-8?B?TG14QnhVV1pPalBvTlcraDZKRXh6QTRlbC9SbFl5VE1aZjRQT1lVUktEdjZ5?=
 =?utf-8?B?OHNBOE5oVXUzVDJZb1daQTZDTmxJci95K3JKYU1WQUJxUW9Ycm1wakdUdUhx?=
 =?utf-8?B?ZDdVd01VV3h4ZmdIcyt4QjByamxHMUEwclJzTCtuWWl5ckJBRk1NZDVxY0gw?=
 =?utf-8?B?SHdxTmsvQjNwRkl5V2w1WFJxaE15Z25DNEtGQVFVV0hKUWhvY2JVdG5lMXVv?=
 =?utf-8?B?TzR4UEc5TXllUlJRZUYrdHNqL3h5RER6cnhjYWZkOEhlQ2xHdGo4UmdaVzRP?=
 =?utf-8?B?azF0dTRpY3Q4Q0thR05wYmlRNFJ2eEdKODhvRC92cGlqMk1rQ2ZzRWEzT2dV?=
 =?utf-8?B?aDloNzVJM21TODNaTTBtOFJUeHpxWHJrKzlKOGZEc2N4ejNYQkNDNVVOMVBZ?=
 =?utf-8?B?UzZSbWhqck9jZ1hpNDZRellYaS9zWmdkWUhoVkp3RU5DUzZDc2dGV1hWcnR2?=
 =?utf-8?B?eTEzNkxMYy93QitnbmVGRjBhZHN6V1d1bi8rVWg4ZW5aZFZBUzJDSVJGbkNn?=
 =?utf-8?B?aG01eGZDSjNqa3JsTFNaUnV3akhYMzVvZXN0NmZsbStndXdqUXJlWEhLRjNG?=
 =?utf-8?B?Ykp4Q1RabjdUY1FHUmg2ZndqUzhXdVI3RDZIdkpyeTFWOW81eGxubS9mZ2wz?=
 =?utf-8?B?cDRIekFHYTJOQVpSVEFuQ3orT0dJZ1Bma0pwaFB1N3k3aTJ2REFucXlkbjhy?=
 =?utf-8?Q?WxsN4+uxj6vDjotUv4HVJovMAVa?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52a8980-9f7b-42ce-36c5-08dacbabd6d6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 10:33:35.3402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiNvpLKeXFZVMe+yZgJqgi5Cw+9ORRg4KdRxKLVqfxVrY7Z271NSXb8rsyxm6IfO5DCxa2zzK9hFoilN0K2jOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a PVH dom0 the ACPI MADT is crafted by Xen in order to
report the correct numbers of vCPUs that dom0 has, so the host MADT is
not provided to dom0.  This creates issues when parsing the power and
performance related data from ACPI dynamic tables, as the ACPI
Processor UIDs found on the dynamic code are likely to not match the
ones crafted by Xen in the dom0 MADT.

Xen would rely on Linux having filled at least the power and
performance related data of the vCPUs on the system, and would clone
that information in order to setup the remaining pCPUs on the system
if dom0 vCPUs < pCPUs.  However when running as PVH dom0 it's likely
that none of dom0 CPUs will have the power and performance data
filled, and hence the Xen ACPI Processor driver needs to fetch that
information by itself.

In order to do so correctly, introduce a new helper to fetch the _CST
data without taking into account the system capabilities from the
CPUID output, as the capabilities reported to dom0 in CPUID might be
different from the ones on the host.

Note that the newly introduced code will only fetch the _CST, _PSS,
_PPC and _PCT from a single CPU, and clone that information for all the
other Processors.  This won't work on an heterogeneous system with
Processors having different power and performance related data between
them.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
 arch/x86/include/asm/xen/hypervisor.h |   2 +-
 arch/x86/xen/enlighten.c              |   2 +-
 drivers/xen/xen-acpi-processor.c      | 225 ++++++++++++++++++++++++--
 3 files changed, 211 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index b4ed90ef5e68..1ead5253bc6c 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -62,7 +62,7 @@ void __init mem_map_via_hcall(struct boot_params *boot_params_p);
 #endif
 
 #ifdef CONFIG_XEN_DOM0
-bool __init xen_processor_present(uint32_t acpi_id);
+bool xen_processor_present(uint32_t acpi_id);
 void xen_sanitize_pdc(uint32_t *buf);
 #else
 static inline bool xen_processor_present(uint32_t acpi_id)
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 394dd6675113..a7b41103d3e5 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -348,7 +348,7 @@ EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
 
 #ifdef CONFIG_XEN_DOM0
-bool __init xen_processor_present(uint32_t acpi_id)
+bool xen_processor_present(uint32_t acpi_id)
 {
 	unsigned int i, maxid;
 	struct xen_platform_op op = {
diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index 9cb61db67efd..b189ea69d557 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -48,6 +48,8 @@ static unsigned long *acpi_id_cst_present;
 /* Which ACPI P-State dependencies for a enumerated processor */
 static struct acpi_psd_package *acpi_psd;
 
+static bool pr_initialized;
+
 static int push_cxx_to_hypervisor(struct acpi_processor *_pr)
 {
 	struct xen_platform_op op = {
@@ -172,8 +174,13 @@ static int xen_copy_psd_data(struct acpi_processor *_pr,
 
 	/* 'acpi_processor_preregister_performance' does not parse if the
 	 * num_processors <= 1, but Xen still requires it. Do it manually here.
+	 *
+	 * Also init the field if not set, as that's possible if the physical
+	 * CPUs on the system doesn't match the data provided in the MADT when
+	 * running as a PVH dom0.
 	 */
-	if (pdomain->num_processors <= 1) {
+	if (pdomain->num_processors <= 1 ||
+	    dst->shared_type == CPUFREQ_SHARED_TYPE_NONE) {
 		if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
 			dst->shared_type = CPUFREQ_SHARED_TYPE_ALL;
 		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
@@ -313,6 +320,155 @@ static unsigned int __init get_max_acpi_id(void)
 	pr_debug("Max ACPI ID: %u\n", max_acpi_id);
 	return max_acpi_id;
 }
+
+/*
+ * Custom version of the native acpi_processor_evaluate_cst() function, to
+ * avoid some sanity checks done based on the CPUID data.  When running as a
+ * Xen domain the CPUID data provided to dom0 is not the native one, so C
+ * states cannot be sanity checked.  Leave it to the hypervisor which is also
+ * the entity running the driver.
+ */
+static int xen_acpi_processor_evaluate_cst(acpi_handle handle,
+					   struct acpi_processor_power *info)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *cst;
+	acpi_status status;
+	u64 count;
+	int last_index = 0;
+	int i, ret = 0;
+
+	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(handle, "No _CST\n");
+		return -ENODEV;
+	}
+
+	cst = buffer.pointer;
+
+	/* There must be at least 2 elements. */
+	if (!cst || cst->type != ACPI_TYPE_PACKAGE || cst->package.count < 2) {
+		acpi_handle_warn(handle, "Invalid _CST output\n");
+		ret = -EFAULT;
+		goto end;
+	}
+
+	count = cst->package.elements[0].integer.value;
+
+	/* Validate the number of C-states. */
+	if (count < 1 || count != cst->package.count - 1) {
+		acpi_handle_warn(handle, "Inconsistent _CST data\n");
+		ret = -EFAULT;
+		goto end;
+	}
+
+	for (i = 1; i <= count; i++) {
+		union acpi_object *element;
+		union acpi_object *obj;
+		struct acpi_power_register *reg;
+		struct acpi_processor_cx cx;
+
+		/*
+		 * If there is not enough space for all C-states, skip the
+		 * excess ones and log a warning.
+		 */
+		if (last_index >= ACPI_PROCESSOR_MAX_POWER - 1) {
+			acpi_handle_warn(handle, "No room for more idle states (limit: %d)\n",
+					 ACPI_PROCESSOR_MAX_POWER - 1);
+			break;
+		}
+
+		memset(&cx, 0, sizeof(cx));
+
+		element = &cst->package.elements[i];
+		if (element->type != ACPI_TYPE_PACKAGE) {
+			acpi_handle_info(handle, "_CST C%d type(%x) is not package, skip...\n",
+					 i, element->type);
+			continue;
+		}
+
+		if (element->package.count != 4) {
+			acpi_handle_info(handle, "_CST C%d package count(%d) is not 4, skip...\n",
+				i, element->package.count);
+			continue;
+		}
+
+		obj = &element->package.elements[0];
+
+		if (obj->type != ACPI_TYPE_BUFFER) {
+			acpi_handle_info(handle, "_CST C%d package element[0] type(%x) is not buffer, skip...\n",
+					 i, obj->type);
+			continue;
+		}
+
+		reg = (struct acpi_power_register *)obj->buffer.pointer;
+
+		obj = &element->package.elements[1];
+		if (obj->type != ACPI_TYPE_INTEGER) {
+			acpi_handle_info(handle, "_CST C[%d] package element[1] type(%x) is not integer, skip...\n",
+					 i, obj->type);
+			continue;
+		}
+
+		cx.type = obj->integer.value;
+		/*
+		 * There are known cases in which the _CST output does not
+		 * contain C1, so if the type of the first state found is not
+		 * C1, leave an empty slot for C1 to be filled in later.
+		 */
+		if (i == 1 && cx.type != ACPI_STATE_C1)
+			last_index = 1;
+
+		cx.address = reg->address;
+		cx.index = last_index + 1;
+
+		switch (reg->space_id) {
+		case ACPI_ADR_SPACE_FIXED_HARDWARE:
+			cx.entry_method = ACPI_CSTATE_FFH;
+			break;
+
+		case ACPI_ADR_SPACE_SYSTEM_IO:
+			cx.entry_method = ACPI_CSTATE_SYSTEMIO;
+			break;
+
+		default:
+			acpi_handle_info(handle, "_CST C%d space_id(%x) neither FIXED_HARDWARE nor SYSTEM_IO, skip...\n",
+					 i, reg->space_id);
+			continue;
+		}
+
+		if (cx.type == ACPI_STATE_C1)
+			cx.valid = 1;
+
+		obj = &element->package.elements[2];
+		if (obj->type != ACPI_TYPE_INTEGER) {
+			acpi_handle_info(handle, "_CST C%d package element[2] type(%x) not integer, skip...\n",
+					 i, obj->type);
+			continue;
+		}
+
+		cx.latency = obj->integer.value;
+
+		obj = &element->package.elements[3];
+		if (obj->type != ACPI_TYPE_INTEGER) {
+			acpi_handle_info(handle, "_CST C%d package element[3] type(%x) not integer, skip...\n",
+					 i, obj->type);
+			continue;
+		}
+
+		memcpy(&info->states[++last_index], &cx, sizeof(cx));
+	}
+
+	acpi_handle_info(handle, "Found %d idle states\n", last_index);
+
+	info->count = last_index;
+
+end:
+	kfree(buffer.pointer);
+
+	return ret;
+}
+
 /*
  * The read_acpi_id and check_acpi_ids are there to support the Xen
  * oddity of virtual CPUs != physical CPUs in the initial domain.
@@ -354,24 +510,44 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
 	default:
 		return AE_OK;
 	}
-	if (invalid_phys_cpuid(acpi_get_phys_id(handle,
-						acpi_type == ACPI_TYPE_DEVICE,
-						acpi_id))) {
+
+	if (!xen_processor_present(acpi_id)) {
 		pr_debug("CPU with ACPI ID %u is unavailable\n", acpi_id);
 		return AE_OK;
 	}
-	/* There are more ACPI Processor objects than in x2APIC or MADT.
-	 * This can happen with incorrect ACPI SSDT declerations. */
-	if (acpi_id >= nr_acpi_bits) {
-		pr_debug("max acpi id %u, trying to set %u\n",
-			 nr_acpi_bits - 1, acpi_id);
-		return AE_OK;
-	}
+
 	/* OK, There is a ACPI Processor object */
 	__set_bit(acpi_id, acpi_id_present);
 
 	pr_debug("ACPI CPU%u w/ PBLK:0x%lx\n", acpi_id, (unsigned long)pblk);
 
+	if (!pr_initialized) {
+		struct acpi_processor *pr = context;
+		int rc;
+
+		/*
+		 * There's no CPU on the system that has any performance or
+		 * power related data, initialize all the required fields by
+		 * fetching that info here.
+		 *
+		 * Note such information is only fetched once, and then reused
+		 * for all pCPUs.  This won't work on heterogeneous systems
+		 * with different Cx anb/or Px states between CPUs.
+		 */
+
+		pr->handle = handle;
+
+		rc = acpi_processor_get_performance_info(pr);
+		if (rc)
+			pr_debug("ACPI CPU%u failed to get performance data\n",
+				 acpi_id);
+		rc = xen_acpi_processor_evaluate_cst(handle, &pr->power);
+		if (rc)
+			pr_debug("ACPI CPU%u failed to get _CST data\n", acpi_id);
+
+		pr_initialized = true;
+	}
+
 	/* It has P-state dependencies */
 	if (!acpi_processor_get_psd(handle, &acpi_psd[acpi_id])) {
 		pr_debug("ACPI CPU%u w/ PST:coord_type = %llu domain = %llu\n",
@@ -392,8 +568,7 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
 static int check_acpi_ids(struct acpi_processor *pr_backup)
 {
 
-	if (!pr_backup)
-		return -ENODEV;
+	BUG_ON(!pr_backup);
 
 	if (acpi_id_present && acpi_id_cst_present)
 		/* OK, done this once .. skip to uploading */
@@ -422,8 +597,8 @@ static int check_acpi_ids(struct acpi_processor *pr_backup)
 
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
-			    read_acpi_id, NULL, NULL, NULL);
-	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, read_acpi_id, NULL, NULL);
+			    read_acpi_id, NULL, pr_backup, NULL);
+	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, read_acpi_id, pr_backup, NULL);
 
 upload:
 	if (!bitmap_equal(acpi_id_present, acpi_ids_done, nr_acpi_bits)) {
@@ -464,6 +639,7 @@ static int xen_upload_processor_pm_data(void)
 	struct acpi_processor *pr_backup = NULL;
 	int i;
 	int rc = 0;
+	bool free_perf = false;
 
 	pr_info("Uploading Xen processor PM info\n");
 
@@ -475,13 +651,30 @@ static int xen_upload_processor_pm_data(void)
 
 		if (!pr_backup) {
 			pr_backup = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
-			if (pr_backup)
+			if (pr_backup) {
 				memcpy(pr_backup, _pr, sizeof(struct acpi_processor));
+				pr_initialized = true;
+			}
 		}
 		(void)upload_pm_data(_pr);
 	}
 
+	if (!pr_backup) {
+		pr_backup = kzalloc(sizeof(struct acpi_processor), GFP_KERNEL);
+		if (!pr_backup)
+			return -ENOMEM;
+		pr_backup->performance = kzalloc(sizeof(struct acpi_processor_performance),
+						 GFP_KERNEL);
+		if (!pr_backup->performance) {
+			kfree(pr_backup);
+			return -ENOMEM;
+		}
+		free_perf = true;
+	}
+
 	rc = check_acpi_ids(pr_backup);
+	if (free_perf)
+		kfree(pr_backup->performance);
 	kfree(pr_backup);
 
 	return rc;
-- 
2.37.3

