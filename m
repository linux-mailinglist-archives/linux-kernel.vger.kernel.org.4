Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A06AF03B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjCGS3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjCGS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:29:12 -0500
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66D0ADC33
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1678213332;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SFEx4dJdRIc/tsPzUsmuh+Mcbv/LmgdYjfH+nVT/7qk=;
  b=flg4P7ci78HC9PzT0BuEms1sW0K6mZhDKTOHpL+Q1VQiXIrfBQhggdcQ
   v05DnV5StlKxZrrBaT7ETrvXLW2kbkRAh1nBLMS2yGmpWRIt4ihLy/Yni
   OppoobKvjFB/5rfkIEtnwcMDbWY2+i279uQYvSxRGrs181QwEr9CLyqus
   I=;
X-IronPort-RemoteIP: 104.47.58.169
X-IronPort-MID: 100287627
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:CdC8u6j5TY3oCm43JD6XDKQ1X161+BEKZh0ujC45NGQN5FlHY01je
 htvCzyDPvuCNjGme9l1Oo6yoBxVuZHdydc1GQFlrHtgHi8b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsy+qWi0N8klgZmP6sT5weBzyN94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQpJBRUfxzarN670YKdQ/Fy2c0uHpnkadZ3VnFIlVk1DN4AaLWaGuDgw48d2z09wMdTAfzZe
 swVLyJ1awjNaAFOPVFRD48imOCvhT/0dDgwRFC9/PJrpTSMilEhluGzYbI5efTTLSlRtm+eq
 njL4CLSBRYCOcbE4TGE7mitlqnEmiaTtIc6TeXgrK413gfMroAVIBkfCwO6nOaBtg2VQsJxJ
 nYz+yEU/KdnoSRHSfG4BXVUukWstAY0Ut5RHutqrg2AooLQ4gCEFi0HQyRHZdgOqsA7X3op2
 0WPktevAiZg2JWJQGyc7bC8oja7OCxTJmgHDQcYQg8Vy93ippwvlBXJT8YlHKPdptj0Hz736
 yqHoCg3m/MYistj/6my412BgzuqvZXPZgo04BjHGGOj8g59IoWiYuSA+QiFxfVNNoCUSh+Gp
 ndss8iG5cgcHI2KjmqGR+BlNLis4PCMMzrCqV90B4Mo7HK35haekZt45Th/IAJjNJYCcDqwO
 UvL41oPtdlUIWegarJxb8SpEcM2wKP8FNPjEPfJct5JZZs3fwiClM1zWXOtM6nWuBBEuckC1
 V2zKK5A0V5y5Xxb8QeL
IronPort-HdrOrdr: A9a23:b2PCJqo3VkTD1k2dySNon9gaV5tNLNV00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssREb9uxo9pPwOE80hqQFhrX5Wo3SITUO2VHYVr2KiLGP/9SOIVycygcw79
 YET0E6MqyKMbEYt7eF3ODbKbYdKbC8mcjH5Ns2jU0dNT2CA5sQkDuRYTzrdnGeKjM2Y6bRWK
 DshPau8FGbCAgqh4mAdzA4dtmGg+eOuIPtYBYACRJiwA6SjQmw4Lq/PwmE0gwYWzZvx65n1W
 TeiQT26oiqrvn+k3bnpiLuxqUTvOGk5spIBcSKhMRQAjLwijywbIAkd6yesCszqOSP7k9vtN
 XXuR8vM+l69nuUVGCophnG3RXmzV8VmjXf4G7dpUGmjd3yRTo8BcYErYVFciHB405lmN1nyq
 pE00+QqpISVHr77W/AzumNcysvulu/oHIkn+JWp3tDUbEGYLsUiYAE5ktaHLoJASq/woE6F+
 tFCt3a+Z9tABunRkGcmlMq7M2nX3w1EBvDak8euvaN2zwTp3x9x1tw/r1qol4wsLYGD7VU7e
 XNNapl0JtUSNUNUK57DOAdBeOqF23kW3v3QSOvCGWiMJtCF2PGqpbx7rlwzvqtYoY0wJw7n4
 mEeE9EtFQ1Z1nlBaS1rdN2Gyj2MSaAtAnWu4NjD8ATgMy4eFOrC1zNdLkWqbrhnx1FaferH8
 paO/ptcorexCXVaMF0NjbFKupvwEklIbwoU+kAKiKzS+LwW/rXX7/gAYDuDYuoNwoYcUXCJV
 ZGdATPBax7nzKWsznD8VTsZ08=
X-IronPort-AV: E=Sophos;i="5.98,241,1673931600"; 
   d="scan'208";a="100287627"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Mar 2023 13:22:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuaPqKygzZEELpKvYNth/68q1LZ/C3J41d9KwvWIF/kThXoxWlyHyva+nH9mVyYN+AVeU9sIJ8f6ZMidretyvpZTdRy0Btf8qTPB1Eqy5eusRvQN9hyYFCIaBN5NcS+gycO9Uojgi6vngTQ+lhxCwoKUA94qAovEETNPBUdMHznbeoTfEfaUgcfnY0TyHZJrLTM8Q/g+gPI0hGeWrq7xQh02NkCroaxYXd0p4PrEN8ynGZwZlryadlgfURaok7ubnYCP3SK+w+2fITMkLsL4UgXyFfRiOmHN+6K3mdKl7d7v+uBtHPkWDSmF1cL5buqYKoycVuledKyxsQ2XtFmDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1FoQVAsqUp6nbLCvJrR2RrMhPeLq9YK0tUiBYB2qZI=;
 b=bvi/REdDy7WTJdied10k9wR+kIwHiSLjDjDRAuzAC8CNGsWoEg6O5PyR7U9PxSHzur5yI04iF3sm93CknCxoYfvpd8gk6xBYtWlCbTvPXn9j1LljJm7nWbN2lOcnb0lQFyE17DMzXKEIBvyUFW+eYN63V4ULfi9YhcK4Z0P+TztQIICbZkls/toXsG6yIvKwZ9SnCxwxv3begaJHmpPWXhewEMam0A4ybHWUIc9wD2+dCXs9GuNl5KrpDsU4oo+uxtS1KmSWLf3DeO50KETb4ydm61KiKaiN8kPRfpsIUPnhQ5CArdH/2UTSQmEO8tzqVqfRr90HcVSt+c3zo9yOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1FoQVAsqUp6nbLCvJrR2RrMhPeLq9YK0tUiBYB2qZI=;
 b=NHiLR6IiUbYCULTkTRz+liDss9L2/yuJwnaVnH8BlzxLkj0WIMzTjpUHE/aNa4vFAvZ5JrcAYsCOT8st8UD/qIT3DcVtvoVD2GPuDYuYLQgrRa64+kuimTJLs5x1xHuquOl2y8v0jJYMrOrCK7VyYpNijNiSMSOaHLUTUywrqlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SA0PR03MB5435.namprd03.prod.outlook.com (2603:10b6:806:b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 18:22:09 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::8299:f95f:934b:29e8%7]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 18:22:08 +0000
Message-ID: <940596cc-a440-181a-a72a-36282a26dd0a@citrix.com>
Date:   Tue, 7 Mar 2023 18:22:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/amd: Work around Erratum 1386 - XSAVES malfunction on
 context switch
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tavis Ormandy <taviso@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Monakov <amonakov@ispras.ru>
References: <Y/W4x7/KFqmDmmR7@thinkstation.cmpxchg8b.net>
 <20230307174643.1240184-1-andrew.cooper3@citrix.com>
 <20230307175050.GCZAd5eu0/Mk2fdLz5@fat_crate.local>
In-Reply-To: <20230307175050.GCZAd5eu0/Mk2fdLz5@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0647.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::22) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|SA0PR03MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bf2790-fae9-4bf7-ebae-08db1f38dc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ex3zL4+1equn1JaJHhMJM3cBwCGUw0XzroP7zxhy+jtE2UsUghYDL72ezc0x+J3RGC/qvYBC2F8tzO/g74kDU8ZrsO7rEJTGOMnDct8uW8eFS9Ym8PJFqsBD5iZ/O93p11BZ/kv/9MazxvoFoXL+mherApXngCJ54LXxNxb6gd7tT2uu2NA0WUJfuA04rwZT4XR5Ka5qLU0MJ0+gUoIEIuPp0OxyclNcjHt0exS6Id2O1cnpsAn987EmuhPLVDokHT0183vsT/BJ/4Pv/Z6h0F3KUqRcmIVdVlehecPvqjRw/1Hsvj8cRlF36MyXNygoGXzZZr9bfSxFIx+1w0is5+d/xg4z6x/qHQXFHLzjakvNMgcSS9FYSa1+Ra0gP+6uG0kTAd2t3AKyZTSxPBQJkPwhsby4u+rEBNZrqEnW50P7AZjvf9rg1zx4iZ2o6FOy23g1aV8HrmxzljM/cTd11PIO+NKNdXRpd0YTnz//P1iMs46MS0bLFD/XZOVC7N8QZZQnxu4b7GYwLDcnspk+d5ooMbjLSLtFyrmKlXMNcoztuM3tzEGYofOiOx8bETjhmLCNoIJ8yOpL2er0SStFSBCqr/tPo2gSRy3aZpKXlR2vPB+SEo1ivb83+E4+UpRUST327ZxjV8uvMrJ+cMd7yrvdCHiIvztiK61ut1/cAI3za/7LJNa9XfXACdLaARtFlxoFZRPVgnQmu8QXXWm0hVxcHhc9DVX4vJ48afnaho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199018)(2906002)(186003)(4326008)(5660300002)(38100700002)(6666004)(8936002)(66946007)(6916009)(8676002)(41300700001)(66476007)(4744005)(82960400001)(66556008)(6512007)(26005)(53546011)(478600001)(2616005)(36756003)(54906003)(316002)(83380400001)(86362001)(31696002)(6486002)(31686004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2lMWXZBOHdIaDd4WHpqZFVnOWs2S2NnaVQ4SmNsWGhUQndoNE5IdDl3bGxz?=
 =?utf-8?B?ay94c2ZvaHBBQnYyZVNuZTFtNG5ObDNxanF6dmViNU5BaFg4TzFJR1g0MVdw?=
 =?utf-8?B?bFZEdTF4RlFUYWZwTUpXNHBjOWcxYzZzRmR2U3NJSXBZZXRDRjIrWkY4dGUy?=
 =?utf-8?B?VU1yTmZsNHZHeHc2T1dRaDRyVTBoK05DMUhEM3A2MjBmaEpNYld3ZWhobTg2?=
 =?utf-8?B?bU1SWm9vUGhtU0pnTGtnc216RHhRS1BVVUpId2pTd2ZkVEY0RWwzbWxhVmJi?=
 =?utf-8?B?bGp1b1dZSDc2aldiM1hCTVJVVUJGa2RYWEVsN1ZNS3R6UjJNSnBFQXJtYzhG?=
 =?utf-8?B?dmVza3ppV21hc3JvTHhPaW9hZ1dUQ2xzRGRuZFFOei93K2VWTE5xWHJoZlRi?=
 =?utf-8?B?Q1pidzE5dTJOVFl6RUl3ZDgyWDhDWWtWLzBOamptZnVib2kwdnpvWUd2cHU1?=
 =?utf-8?B?dGVSNXd3MkI5WmluRFlkOHNRTFhycTZ5U1YydlpIeXpTdVhTMUt6a243ZHFn?=
 =?utf-8?B?VUliMmpydWllSDlwSlpjY1EyYlVPM1puUG91RDhuTDgvVmFkaDZ1ZENlVE5Q?=
 =?utf-8?B?SktsNmZGQTFMTFRlYzlRdTFqZXlXTGVHaDBlMkNqb2VoS0JKMDRmZll3bFlq?=
 =?utf-8?B?aXVKNEtlUS9OMnpHYWlBS09IZVdvczBRMlVLdzVTNytFVTR4TmVmMDNEZmhB?=
 =?utf-8?B?RE04aHdXNm5adU1mV2Rhd1hqQndYaUZhYlZNY1VCOFFES3dqUkdyenZSSFAv?=
 =?utf-8?B?eTU0SGprV3A0aXIxTndabi9UMGpZNWl4cVlJNjdvNFYwK2tyVDVaeXYvbDlM?=
 =?utf-8?B?U3d3bnFhRFdaQkZ2SENkYitvRWhRRU5Pa0c2N2FCRndmTVZoQ3BoRHJBVE9M?=
 =?utf-8?B?QUpMcDJ5MGl5dGFaVEJsWUlYK09JMnJDUllQeENMSndHTkp3M0t5T1pTZlF5?=
 =?utf-8?B?anBndHV5eElkdzBqQ3hmekJYdUQ2aE51aUZnL3MyOGJQZ0syeFhPaUVVSWRq?=
 =?utf-8?B?UDZScjlQVVhNWitYeUhBaEw2bEIwRXplVURwQzhHMjhDSTRJM2oxaWE4cFo5?=
 =?utf-8?B?OGxjZ0N1NkNUbER0aDBwV0xCS3RvUTRGRzY5ZVlOSk5iS215WHFlR3BoRE9p?=
 =?utf-8?B?NmY0MElzNExVVVFmSHZVNkJvVkdBZ3hVbzFZRE5hV1JUS05KbnpXUDFCUmhU?=
 =?utf-8?B?QTFMVUdMYU5GdjJIdXMxVW5uSDFVWXVKcGdacTVnR3hhQkZJNnVicG9laHJG?=
 =?utf-8?B?U3VlUk1HSzYyd0d3cUVvUm9RdzhDRG16bWZBT1JxM2tpcGJMYjhrTW9hbkZO?=
 =?utf-8?B?a0U0TWpQMXNqMVl6cE9SRFZUTVlHcm5NR2s3NVR3V21ORXBxM0FGcitRWm9l?=
 =?utf-8?B?bUN1cHRqbjNwaEVsSWpHVS9XcUdBdGZJVE5IclAyeHdNN0dONmZ1Q0Jwd1lW?=
 =?utf-8?B?N0FUQmdXYSsrWHlzVE1jVWE3MHBBazNJVVJNZXR6eVBZaVdSZDlnWHFvKzc0?=
 =?utf-8?B?L05LUlB0WTdmMmowWmN3c1hNNDNvUzNFRmNFOEhsem9qUG00WEgyTDd5NzFl?=
 =?utf-8?B?WjkxL1dpbklGOHpxcUpCSTNaMkpJNGR1RW9jU3NUZUtQaHFRZ2RHS0NDbHY1?=
 =?utf-8?B?VnVpbjNlTC9pNlBCNUU3ZkFpamxhNU1TNkdDR2lzVjVNdlg0S3BwM0NZSDZM?=
 =?utf-8?B?VktQa2Fqb2NtVTdGbmI3L25BYnR3ZkVmZ3hXRXJyQmcyUEFEMVlqLzdhZlMw?=
 =?utf-8?B?T3dwQnIxRU1ReERyVHM3QzhtQWd1eld6MjMvcjc2a2pzWjg0djRTMHFhQ3dw?=
 =?utf-8?B?N3hyQkJhQ1ArcWFmSDZUWlpsell2bW9wajdnMnpiOFI4YkVyQ1d0Z2pkVm5Z?=
 =?utf-8?B?eUN1Rzh6Z2pKdmllZGRYU1cwSjB3VG5XYWNyZisrWnZBY3hxME9DTUJZMk9i?=
 =?utf-8?B?WElGaFI5QzFNRlhWaThNV0lVQUhMTWYralFDZSszM2VCUVd4YnRVeHZSZGc0?=
 =?utf-8?B?YWVWZ3Q1RzRDUDZ0eC9kWWRFUlA5Y1JPekREbmhnVEpFeDlFWnEvTFRoM0Nj?=
 =?utf-8?B?amk0d0FhZG42OVdoTEtLWHhjVzFRK2prYnFVbTJZdituRlk4bTI3aEFKbldR?=
 =?utf-8?B?S1IrNXZ0eHluenM4TlNZVkZDL0lLMXlwL09ySWNYNm15bUNzVk4rQWo4ekxC?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZTAwVmowNjA3Z3U4RG5TYkYrSnpIUVJUMmp0aGduVnFXK0JpVEJhVGp2bzBL?=
 =?utf-8?B?ZGFMSHJqNmdORTdsQkhtVE4zaWNNV3VjajI3Q1o5VGVublNFZjB0R3ZXMTJx?=
 =?utf-8?B?a1c5elpaQWZoaktKZldWTm5SZzBFNUpSNklKR0h1c3lkSXFhK25rc2FXSFVh?=
 =?utf-8?B?bHJJT1lxaldVQWptWjZhc2JVeWxHQ2N4NFpKaDZ1SGsvY2dxNnhXZExsVnpW?=
 =?utf-8?B?aFJiZTlMcm0wa0RCdUoweGpKaC9BakhrRjJIMXlCTFZacU1KanBzbFBad2NO?=
 =?utf-8?B?SFlDTXpUbFRWYzdhTnJlYkR5cXVXQ3AxVHIxeVVYSkxKWFc1MzRTWVByTHU2?=
 =?utf-8?B?OVJheVFabGpCVEZXZzJBSHJPZ2IrcVJ3WmdrSmtscDYyaS9Ja3dydGF1bURG?=
 =?utf-8?B?enVLVHJsT0tsQjVBdW1FZ3c3YkNHclRDT2JmZjFTKzZ5SHprakFMTDRpcFYr?=
 =?utf-8?B?ZW9UZFRiUlQwODFNN3orVFJYZmU4dlZiNjViVDhoenFZSkFudm9JalVvZm1W?=
 =?utf-8?B?TVZuWkhWT1ZaTWhqaktaNzgwTUw3LzVxU3JOTzJkUDNYUGthc0Q0bU9NTzVu?=
 =?utf-8?B?RUZua0J2Tjd5YTlLS3kyK3NwS1QrRlhrcHVCVTUvaW1QSmxYTmxBaHBzUXdE?=
 =?utf-8?B?c2Y4bEFjRnVNcEJZWjZjcUQ0Y1M2T2ozR0Q0Z1VLRG44V0l3Yk9kck9mOXNy?=
 =?utf-8?B?SDN0RXFlOGl0UVRlNXlwUkRsOVk5UXozY2hiQkxub0JPaDJQZVB2dnlrRW4y?=
 =?utf-8?B?MDdSRC81cE15OFhQSmFCYXdqNHRRZk5hb28zN0FJNHBteU4rcmtDaStNVnhw?=
 =?utf-8?B?QWd2YXpocnpJNldTdVVreGFKR1dHeTNPakRrbzhqWlVNV1MxSTlmVmFCR0U0?=
 =?utf-8?B?TG5OT3MwM0UzQ3JZSk9XS3NqT0N5THlWcGcwcW9xT0lpQ2swcWxyYXo5TGVE?=
 =?utf-8?B?aUJYNitmRGtETzhNRUJzS0ozam9mRXRLemVyS2R5dGlic25JcWgzdmRLMjBX?=
 =?utf-8?B?VUFhQ0MxbmJtbWlYWWR6dDc5UUZQVnlJSU44N3p2Rko5Sitwd3NVS2JONnBO?=
 =?utf-8?B?OWpIWFVTRjdSclFwdkJIQ1o3RFZDS21BZ0ZoaHV4NmJjSCtrOG8rUHBudEd2?=
 =?utf-8?B?SXpqUDZwTWt4L1NRVERxdVZaQTBJOGcyZERVb2Y1b2h4ZVFVRzZBa2QxOGpR?=
 =?utf-8?B?YnRSMUUvUTNvQmZPWGhQNkllRXlmMnZndzhJd00ydlJxVGNlZTlsK2x4SW5M?=
 =?utf-8?B?Z3NwUVVUR3pXbWh2ZHNzV0ltemVGSEdaWVFabC9pRExqS1VZazFOUk5zajJq?=
 =?utf-8?Q?hl8SOMyiiz97GubUsVHqEi0tMuc9AJ6xB2?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bf2790-fae9-4bf7-ebae-08db1f38dc90
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 18:22:08.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZrciVgsy6L2Gt053++I70bJOwNs7Em6/hMqkvltgLSjd7/V2QD++cntj+3pMAolfeV5eag93hGxOIUP4sfaDa/Es+N0oi2mtre3ylZwzw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5435
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 5:50 pm, Borislav Petkov wrote:
> On Tue, Mar 07, 2023 at 05:46:43PM +0000, Andrew Cooper wrote:
>> +	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
>> +	 * certain circumstances on Zen1/2 uarch, and not all parts have had
>> +	 * updated microcode at the time of writing (March 2023).
> Any reason for rushing this and not waiting for me to clarify affected
> models first?

Well yes - more and more reports of impacted systems.

Having the full list of affected models is great and all, but how is it
going to change this patch as a workaround ?

~Andrew
