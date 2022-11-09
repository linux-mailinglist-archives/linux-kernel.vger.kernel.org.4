Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10566622EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiKIPSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKIPSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:18:16 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 07:18:14 PST
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E62F1DF07;
        Wed,  9 Nov 2022 07:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1668007094;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=uz5t6HGfEyFYcYdCb28/S4oGfiexXPDBed1xAB7I6aI=;
  b=VaB1fBSm/ApGrCjdcCX42pQe0r17JGvDGi7ZC1VQGd4a0S52+PMB9rMp
   mDzaC39r3D1kR47CcaafGnOI1vb0MV+Z5/FWUFFhz/rni2IiSCCclnJeK
   uKJDuK+DMbAwp2waoPoNjoSMrZrL0IUl6HrC/s2tYoHDDk7scit4nmTts
   s=;
X-IronPort-RemoteIP: 104.47.66.43
X-IronPort-MID: 84911233
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:+5sV8aA6lvtpDBVW/2bjw5YqxClBgxIJ4kV8jS/XYbTApGwm1jMBn
 2IfUDqFaPbZMzanftgjOom1pkwD65Pdm9RiQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48T8nk/nNHuCnYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFtcpvlDs15K6o4WpA7wRkDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw9MkqBGpr6
 uAhCz09TR/TxL+R27OVc7w57igjBJGD0II3nFhFlGucKMl8BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTL++xruAA/zyQouFTpGMDSddGQA91cg26Tp
 37c/nS/CRYfXDCa4WrZoyv13LSU9c/9cJI7Ee2oqO96u32W9zQfIUcbCXech8Ds3yZSXPoac
 ST44BEGqak06VzuTdTnWRC8iGCLswRaWNdKFeA+rgaXxcL84hyUAGkPCCRIatorudQ2bTMv3
 16N2djuAFRHvLSLSH7b+/GeqiOaOC4JIGtEbigBJSMF79Tsp4w/gzrVQ9pjGbLzhdrwcRn1y
 iqJozI5nK47jsMR0ai/u1fdjFqEr57FVA8koB7XU3yu7g5/Z4mNY42u9Eid7PBcIYLfRV6E1
 FAfgcmY7f4HFteVnSqBWvgTFb2gz/KENiDMx19pA5QlsT+q/haLZYRZ/D95PkIsPtwFZzLzJ
 V+D5ytP65JJenind6l6Z8S2EctC8ET7PdHsV/SRa8UUZJF0LVWD5Hs2ORXW2H3xmk8xl615I
 Y2cbcunEXcdD+Jg0SayQOAel7Qsw0jS2F/ueHwy9Dz/uZL2WZJfYe5t3IemBgzh0J65nQ==
IronPort-HdrOrdr: A9a23:HJlb8qig3E1gKAP2dSd0XY/sD3BQXzV13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03I+eruBEBPewK/yXcT2/hoAV7CZniehILMFu1fBOTZslnd8kHFltK1tp
 0QDpSWdueAamSS5PySiGfYLz9J+qj8zEnCv5a6854Cd3AIV0k2hD0JcTpzX3cGMDVuNN4cLt
 6x98BHrz2vdTA+adm6PGAMW6zmq8fQnJzrTBYaD1p/gTP++w+A2frfKVy1zx0eWzRAzfML9n
 XEqRXw4uGGv+ugwhHR+mfP59B9mcfnyPFEGMuQ4/JlXQnEu0KNXsBMSreCtDc6rKWG70srqs
 DFp1MaM8F6+xrqDxKIiCqo/zOl/Ccl6nfkx1Pdq2Dku9bFSDUzDNcErZ5FczPCgnBQ9u1U4e
 Zu5Sa0ppBXBRTPkGDW/N7TTSxnkUKyvD4LjfMTtXpCSoETAYUh5rD3xHklXKvoIRiKp7zOSI
 JVfY/hDbdtABunhknizyRSKIfGZAVzIv+EKnJyyvB9nQIm3EyR9HFouvD3rk1wiK7VdKM0mN
 gsSp4Y8o2mbvVmH56VV91xNPefOyjqfS/mFl60DBDOKJwnUki92qIfpo9Frd2XRA==
X-IronPort-AV: E=Sophos;i="5.96,150,1665460800"; 
   d="scan'208";a="84911233"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2022 10:17:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asOsgzKF0v+3Ls6nHxbkq1FEeErJLBfLCOtbgd7xC708lBKZxGOXxXx4RNgLLCP0Cw/d5cAGEMcpvo3P+rpEkp18cJyMVhONs5UGqSxNSztLPS9F7Ehhy2gYqDF/etZ76CYDShvUhw8Gv7EzSvBE6vMBaitLlMb3HGZHv5Y3mE7nvdxPUkO+3KsYhNpWasHFrcF+qIE4eh43wH1aBiKf/TdoqgkZ3ZKIKGn4Xeb6GW0gfKxg2EQPfojk0UB/Tf/+Jx31jCccbaRzCZufK08YJa7DuvZ5Cz6iqYRIHlWEWylAtQX88ju1PWQenMtj0jSKNN9PtmG4O9Joux6I7cei7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ivNN315xw9CLzEYp1XZdo0O3Fg3ZEXWy8aX1iojuXw=;
 b=MC8Ah7L9vOq0L8A1N8Y3JsgIi+gOdVd56bByT6Qt99vVO3pJ43MPyedMrf2cdVz7e+xkb+RGE8Ik2wgDVJfs8AzKHPHRmmGlJ6BZcaHejnV2o4D5YPiwO//OGaeJc/ZWi9+DeaiNv4OwJtaGNa0+gy6JViOJ0JZ4SUuQBxEuaIGqIhFgZ8I/+0MSvf3TS1qMmNFTwLCZHdzT+7AgCmmVGDVyatxrgXozhCUc6Z5hO45RxoteTGB7aaiYIc3mlD1SiOfBvCNmeecYI0M41I8CAOoZitChIADWSHx4i9lRe4K0ORHJF2iH4LGSemEkrYADb7R2AuvrzqIMd34TGFbTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ivNN315xw9CLzEYp1XZdo0O3Fg3ZEXWy8aX1iojuXw=;
 b=hPrRK54GpiqdPP0FMxU6kbPf4vUqrk9sRS35TFN9E/qRH2fqC7AGuTso2OWVZEKRDd/goLn7QlkwibmY09fqJz4irp9AOYt7uK/RhGkWEh81NRU8G2WZ8eMGqvOQfSKjNrY5RCyIPmr1TH0vcJpvA0NAf+Y/8n65/txONeb+KYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com (2603:10b6:a03:395::11)
 by SN4PR03MB6704.namprd03.prod.outlook.com (2603:10b6:806:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 15:17:04 +0000
Received: from SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::d197:992c:4dca:3c4c]) by SJ0PR03MB6360.namprd03.prod.outlook.com
 ([fe80::d197:992c:4dca:3c4c%6]) with mapi id 15.20.5791.025; Wed, 9 Nov 2022
 15:17:03 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     Roger Pau Monne <roger.pau@citrix.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: don't unconditionally attach Intel PMC when virtualized
Date:   Wed,  9 Nov 2022 16:16:32 +0100
Message-Id: <20221109151632.71495-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0582.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::17) To SJ0PR03MB6360.namprd03.prod.outlook.com
 (2603:10b6:a03:395::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6360:EE_|SN4PR03MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a52b16c-ee61-406b-a41f-08dac26574dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xHz2iRMJWOGnYBvZySEza9WuftLHJ5ZlNWlVlzqGcShlRXsX3olambnuA5a2Ugm8jzs2X8RG6xUGVGpHAUhIKmml83iPSLiNeSrjtYfKbxQNhX07Nz+x1pq86bRAd9UCwja/iH4ef5K2qM9nwHWN9QWltzK1w+iCpoeFf6+HRA6uBRfLSqaZaKACzfSaq7Z2OVjHcSkJLWwR6YeYlHJveS7iOsNjRf9qVObLeneq13o7P+kPbppc3w3CO3s61mXy+XbwYNAF2vJNswGMo2809T/Ar+e1H68N03t6pSE7lG2NFIZNBdBH3fTmDG555jV0nDRMMjVzaeAv/x9oxECMjznPkNOPCpmcKWCvSJ7anIRjfEJ4xEC1MeFXcoDs3p7Ij8Tf03gXMdwuK2ZahvTkc9ESNn86Zovk3p1cc5SQW5WIOemrIrWRETDWsjLEAL2m0tMbiXncErtHATJXvjyzjSpfXYFYE+IPvo/vDOWozNouiC/7IhpLQ9f97pQc2cW4isH5DOkiaCjAX+aYCLSZ93FzPPN/7ijOWohp2gM6xcqgcelr7CKZZGOT2NFJxpdK+rOiquYa/VfggjZusKF9moVachBzhIDw5zdUaO+UramCqP2r0E8787mWWZZyc/esSEFoTslGP9+mOh/gWbeUNKR8sw0AkCl9sMD+WjcDwwP65YjhwwyfzgQmNLPk0tUOXpZLHLlwLF7Q0sTEHqwRpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6360.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(83380400001)(6666004)(86362001)(6486002)(82960400001)(478600001)(8676002)(5660300002)(38100700002)(2616005)(66476007)(8936002)(66946007)(41300700001)(4326008)(6916009)(54906003)(316002)(66556008)(26005)(2906002)(1076003)(6512007)(186003)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2U2NUhVYWZYRTd5eWdOQlQzL200cVVTRlltbWYwY3I2bnNoTytxZzJ0eWcy?=
 =?utf-8?B?N3djcDFMeHBWZ2swTE5zNm1RUUNmTWd0MU1wUXZONUFONkpBME0zN25yRjQ4?=
 =?utf-8?B?eVIyZVgva245cDE1SVdiNVRlT1VLOWQ0SHhQSDB0NHRDdXFsSDRtaEkvbkgv?=
 =?utf-8?B?ZmZ5eUZ6QStnNyt0R0NnMUNvb3BGd25maC9lN0dLeGRweGVXVVl1MzR5b25j?=
 =?utf-8?B?WGMvdTVuVjhoYjM4QjVTUVdMUDBIeEh1YWZsUGJEZ0NTNEdlSXFhSXJJT0hB?=
 =?utf-8?B?WXA3RFArR0w3ODl4akZOdWdzMUZOd2UyVDliRG5xekZLODFOamVsOU01WXVs?=
 =?utf-8?B?UlR0ZDRwZC9QdWlqUHN2dHp6c1ZVNnlMMkxreTQzSjhuN2M2S0szRDNYeGRU?=
 =?utf-8?B?WDRFMVNpMlJhczhjOFlmTDJtNHljeG9IK3FSTGEzZ2NLa0d2NjJNdmNIbEJo?=
 =?utf-8?B?czViK0djaXRoVkVTNzFJTDVjNTNra21MOTFac0FzVFdEYlZJdDlYRU9zQVQz?=
 =?utf-8?B?L0NhZmw5WHlUNllsdGRLOUlOT21UZnhsR1JzOXdPTjdZWEE4eXFEbkVkcVFI?=
 =?utf-8?B?SHNzdElsclNZM2laYWU5N2VTaTV3OFFZcWFQZVlvMlc1VW5WZ2xsUDVidUtL?=
 =?utf-8?B?UkRWUjNmYUc1bUREUVh5eEhFTi85VDZmdEdDVlJSMWhRSllTZVpxRlpiNmRr?=
 =?utf-8?B?UWpwTzhXM2x1VjBLS3F0ajAySEF5R2drbnpLVVYxMXkvTndpTWdoaTNzMkU3?=
 =?utf-8?B?Vk93czliTFAxbGZ3NDdTdVlYMGtha3NHN0pabXRQNEVuQnpNYnlCM0h3T3NF?=
 =?utf-8?B?VytrVndkZk9ReUNVRTRGTTlwSzhSRUZxVkVNN1ErS0p5SVN5WTlKVkYvK2hp?=
 =?utf-8?B?OXpBSFlqNTRQWXU0aUc3eHBVcGdydyttVHFmaDdKM1EvQ29mQVl3YzJpSzRm?=
 =?utf-8?B?L3ZZRzcvTFNtSkh4eVQxZmpjVm1xdU9CNW1HcVM4TS9uN3pyOHFhT3RsdjZK?=
 =?utf-8?B?Q3NxaCtKeWtsL0xKcDBxbmJPOWxzNHh1a2FML3VkL1hrZmVGN2hjS2ZpUzV0?=
 =?utf-8?B?dEdyd0FTRE1FTmVJekhnaStaTzM0S2dLNmpKRDhWNTBjUklUVHZvdiszL25K?=
 =?utf-8?B?MkpSU3dQZlJYTktBem5HUVp3MzNQdkZHelppU29tU2lteW1Wdk01N0ZFK3VP?=
 =?utf-8?B?V1ZrUGxZVkJTbHhMQ1psVE5vYnZpMHRsdFhzMGlWWW80S0JRSExMK29aaUp3?=
 =?utf-8?B?L3l2SjFUbmpYNk8rUWhQMWkzWDc3ZEtxdHlvaDNjQzB6N25QajlPdGdSY29N?=
 =?utf-8?B?SjU5Y0VQZU03S2QzWXFoSzk4ajM3aVhHeVBjWTBjQlRIWDNXK3gwbDlVdVRP?=
 =?utf-8?B?NUZlUWFXRmVEKzJQNE1LZWZIYVRpOHUvM2EyOTR3QmhRSEdXRGNJS0VETVBz?=
 =?utf-8?B?SGVwWmh4RDROampVbkZTbFozTVhzMDJqZStLclRNY0R2YXUyQjFEcmFXQjRR?=
 =?utf-8?B?RXhZVmp1bXRGNk5jb2h4M3NTZ3ZCTzZ6NE1aZGpiNHRSTlBjWXNHZGE4WG9U?=
 =?utf-8?B?S1pDWGNPeE5LWldFK0VpNTBVcm1MY2ZlUnhRZlViZ0dFb0lkMnZwMFlLcGhK?=
 =?utf-8?B?RWd6MGJiK1FMNWxob0p5d1JRWWpMb24yZUdIQU0reW9ERWZMeDd5R0lOMENp?=
 =?utf-8?B?U0lRV1REam84MlU3bmFzNDJZS0gwZDc0RWhQRkE2SlpZTzFvVTN5bWZUOEdI?=
 =?utf-8?B?MnlZWGV4NVFENVhjY0puYldKczllL2VyYk1UOUhqblJmb2RGeGlpVG40Z3VT?=
 =?utf-8?B?bHdXb2loNDdmVjNreFRwbmZOL3FncDdpMnliNDJUWmVNaXdzOWRvcWF4blBY?=
 =?utf-8?B?WC9SQU03OWc4YjAxclJDWVpqdXkvWUJ1Z3VtOFpTdEVDbksxdk1qRUNiaUhZ?=
 =?utf-8?B?dW03S0NYNG5DdExwcDVPdlh2SmhOaUN2ZHVMVmJzdVo3a3lpekJhVHlzNEh4?=
 =?utf-8?B?Q245WnVLZFFPK2FseDlIdDh2ZHVBT1MwaExYL3FNWU5HZC9iTGFEN0RCZ3dz?=
 =?utf-8?B?Z3VvOXQraWJyYktyUFN2ZGpzRFk5clFwbkFUYU5qSFplRS9CMlJVVE5HWHZZ?=
 =?utf-8?Q?buajSHgxRB/zBA3u2Yp6dnyPH?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a52b16c-ee61-406b-a41f-08dac26574dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6360.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 15:17:03.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNAu7CZvEqjL/Tr7JEJFQwMslKcRT658dhGV+Lmx5hr52owxONACjJWzgr0k7LpFrSGmgbVlWSkCuQg4ixfkhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB6704
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic in the Intel PMC driver will forcefully attach it
when detecting any CPU on the intel_pmc_core_platform_ids array,
even if the matching ACPI device is not present.

There's no checking in pmc_core_probe() to assert that the PMC device
is present, and hence on virtualized environments the PMC device
probes successfully, even if the underlying registers are not present.
Previous to 21ae43570940 the driver would check for the presence of a
specific PCI device, and that prevented the driver from attaching when
running virtualized.

Fix by only forcefully attaching the PMC device when not running
virtualized.  Note that virtualized platforms can still get the device
to load if the appropriate ACPI device is present on the tables
provided to the VM.

Make an exception for the Xen initial domain, which does have full
hardware access, and hence can attach to the PMC if present.

Fixes: 21ae43570940 ('platform/x86: intel_pmc_core: Substitute PCI with CPUID enumeration')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Cc: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc: David E Box <david.e.box@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/intel/pmc/pltdrv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
index 15ca8afdd973..e284fd34ffdf 100644
--- a/drivers/platform/x86/intel/pmc/pltdrv.c
+++ b/drivers/platform/x86/intel/pmc/pltdrv.c
@@ -18,6 +18,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 
+#include <xen/xen.h>
+
 static void intel_pmc_core_release(struct device *dev)
 {
 	kfree(dev);
@@ -53,6 +55,14 @@ static int __init pmc_core_platform_init(void)
 	if (acpi_dev_present("INT33A1", NULL, -1))
 		return -ENODEV;
 
+	/*
+	 * Skip forcefully attaching the device for VMs. Make an exception for
+	 * Xen dom0, which does have full hardware access.
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR) &&
+	    !xen_initial_domain())
+		return -ENODEV;
+
 	if (!x86_match_cpu(intel_pmc_core_platform_ids))
 		return -ENODEV;
 
-- 
2.37.3

