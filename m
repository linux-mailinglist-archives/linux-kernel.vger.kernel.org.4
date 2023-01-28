Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC80267F34C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjA1AtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjA1As7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:48:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0744F7D2B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:48:40 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RNE0WR030832;
        Sat, 28 Jan 2023 00:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=irLdHqD0Zl+I5HC7IEcNRnmpx8ok4blN9fKHGZggGDk=;
 b=0sCOPKAZjNpRYfAdJXj6LClIamQwDjKTGpYPnSxr/j9dzpMk+y6blvQQIS6p4nXn9CCH
 0gIFH5XPhw6oEMG2pHx82ZMBs/S9rKKTEX9TRh1m5MA6oD1Ub91F5dL9QJKuKJPYTyok
 j2gJkOkxd/6x3xw6gUC8dajADq2A3GO8FGi/8O3bYGP4nYsaKG0w+7xeIUVTiosCZIS5
 Ls0eHKFZJGt8HyU5vUp+HrGsAOhqDPVGgmILojBsbHY4YGp08ielCMc2PCM5MrZKPOMm
 b3dq6u66xd6TnSIyVodWr2HiSvg3njnu6/R7z1QWIEhCFdGnAEgG/1Ycy99wCpGz/e36 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86n1662n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:48:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30RMarmn005123;
        Sat, 28 Jan 2023 00:48:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n86ggsb0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hImkgx6eCh+f7WDcw3EdfUUx4lcCc2qHqF1xFnG1mVZFmGWpaWJwyS737JTn1HOhhjoElUN0BajOVEo4bpqdEzISQIIhRnqvu5i1bMlzoz3XtRtj11o5tD4AlpKiWq8We6etAyR6bPU0JLFQxmv27BUEfpY0QjjOiDw+6r5SQARud6VTQwmh7eAn2Z2G4nnxS0DEFiubVI9yeq4j9MYrldCMzUcLr9wcjrPz9jfHfmA1fUYRLLuUTzYITkJ1nc5FCz7CZw5XDNEXiFwY99ZaFkPNjUDtX/C64/2mpHYChQdK7GH6SdQSlaahlw97OChc0HeEvEBUmKKDJAxxsJJFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irLdHqD0Zl+I5HC7IEcNRnmpx8ok4blN9fKHGZggGDk=;
 b=lXMvwA2h7C/qkNV6Hzb9w82tLv5sNRagRJkjZ8RIHN0cOUOcq1loS7+AeZPZEpqu+6Bu4frK1Ppcv1NqlC0huj3joA3mOX5XXXBLy4UZEsHBx+7Ym8AXuIc2DoY/5vuhnBs31Albo11wr0jEos99blTq7jIQKi18xPB3Ntfa3ott3reVq8B3fIwXp7iE5abxuDblKmzVkbfwBDjOFxrNK1mpp5uSopwl7/J1YzkDghJy5f2I4O6Os6/Je6KgJrzUkInHipijKV20BRerJRWG2oIzRe/t524M/dRHWyf/f14QDPziaJAfWPasQRxGKN/SyTjHpO1Yv+ArnT8VD+l6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irLdHqD0Zl+I5HC7IEcNRnmpx8ok4blN9fKHGZggGDk=;
 b=Xn/vtZftIjTGunenLY/fOokGl4n4rs0SXxc11lZ6cS70m6/4OQwc7N0Tdg7pKKbRVT4r3TD0UYoeB7IuqGsvvFUlx5SlwY4yfwCk9WPpnmKxhtGlSgcK0O9ezY+/u4Kk/BpRdUDPtShzNrZLDiZMSF3NaRIRPoZPInsKzJEjd2Q=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CO1PR10MB4691.namprd10.prod.outlook.com (2603:10b6:303:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.13; Sat, 28 Jan
 2023 00:48:27 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::7e96:4b2f:a589:eaa9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::7e96:4b2f:a589:eaa9%5]) with mapi id 15.20.6043.022; Sat, 28 Jan 2023
 00:48:27 +0000
Message-ID: <3a6af06a-729d-7659-50b0-8b242b555134@oracle.com>
Date:   Fri, 27 Jan 2023 16:48:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Vishal Moola <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230124012210.13963-1-vishal.moola@gmail.com>
 <20230124012210.13963-2-vishal.moola@gmail.com>
 <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
 <526e5156-6c4b-9f2c-1637-2f83c1dfea1e@redhat.com>
 <53d86764-d155-8d97-1a4d-7e701848c950@redhat.com>
 <CAOzc2pyV9-wq04NRKVE1vRj7PnRF7g+jSFFj-oKYuZk-t9smBA@mail.gmail.com>
 <52af321f-175b-9fa9-10f0-ac2bba04c677@redhat.com>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <52af321f-175b-9fa9-10f0-ac2bba04c677@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0002.namprd05.prod.outlook.com
 (2603:10b6:803:40::15) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CO1PR10MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 8046deb7-827c-4870-c22f-08db00c95df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ayt6eSEulq4mtWAwComme2IL3rhL3lvJWCnOQjiZQnrlrVlA/Gxnke9lShTMDeIzNDkDQeIq4r69Sew0PlfjHl7pI6aqXqP6iL1mY4b6EtS/O3eb35bSV/PXdeEwTRhTNT1C0sA9YJ23CKvK7EN1T+BEEDav+doXXzy52br9uCQMsZ5ntnJ2NtKeJwWCabY2zlK+p0EH7BB15wcZ/hrngUdzn+Q48Agt2ck85LjOgJVL4HW3NAWMCnymMEwLy+Mu8myWa14v3OD1TpHLROUsb4mB/SxK5AiyvkocH+9SpSzdGwnDtnGJQt18hgxX+uH8kXlU2iP/ZDqQmf4oNdZQsu1b2HLqAv13R3Y0vjRDs3DXxa+j2Bwv+yFoWHph6ICpjnpAUct97PqZG9wiLXYPy49Yg7FY0bwu8eqmAcIjFlhj99Gbxb2EBp3cOL1Eam6b6mhJwLYHESVBNghtEQhjQ57/psHwEMLvwaHGymCJ5eIRg4QyfRxLaGplf6ghjkB0CW3cpOX3fffGaBkoNSF+U0TPdyTHQjAl0dtMmm6jau9fVOKCS6AXq1trM78je/UbuzvIqDTWF/N1NHs4m58XY44PGdZmnqKxRboW2UIzoS8IZx/05PR9RmAZdR+grr6aW/50TWpNcS6DBrBkC9VThV+DfYEn+V5tKcaowasmTVRpbHV0yNBSVbYuh+ql90fqIvYVeRcR2h17LcluyHVRWJ9OWoWSxNtHxIwdpwGrnRkQzRErFtj/r4fh8EEQRF3C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199018)(41300700001)(38100700002)(478600001)(966005)(6486002)(86362001)(6666004)(83380400001)(36756003)(2616005)(53546011)(6506007)(31696002)(6512007)(26005)(186003)(66946007)(4326008)(66476007)(66556008)(8676002)(110136005)(316002)(44832011)(2906002)(31686004)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJSUjZBTkMwU1JkOHV3QWJBU21nc21wcGxkMXUzempMcDR6RDA1NmxESmRJ?=
 =?utf-8?B?S0VtdWhYTWQ2V1pjaENuT3dCcVlReTNFTndZVzVLUDdpc1EvVHlXR1IvcTJt?=
 =?utf-8?B?RGZmV0NtRFUvSWNHTUo4L2pETDJ5L3E4QnN5NjVtaG9qNktQNjV6M0VpQ0x0?=
 =?utf-8?B?VWJ0bnRCWVRhUlFpYUZmTnRTSzh6bjVQditCMURRdUs2QVh4dkFLazBrZWJL?=
 =?utf-8?B?NWRZRWJGbHRGTEY2WXIybnRnc2VWWlp2aFpGcytraERETitHT0t3S3kzemJZ?=
 =?utf-8?B?S2tjYnZHbXRXTmFiWXF5NFhGL0FwYTZsV1NPMW52ZE9RRGc5RGZXejR4NkJl?=
 =?utf-8?B?UkJGRXF3dEM4TitVajNwaDQrR3hrTHppREdZa1o2Nms3eEZVaHA4VjFwRHFy?=
 =?utf-8?B?emZMV1FJSjA3Wk5wRkhXQlRkd0kxMTV6b2xRVnVud0JadWtUNDJJWmY2K29R?=
 =?utf-8?B?b1hQSEVoMURtYzNFSFNLL0xXalIvSUwwSFpaeUJXNXRCeUhPNTZ0eGxvTU85?=
 =?utf-8?B?ZVZHajdXZjNwRkJwMUVubXk3NG1vWmNpcFZ3K1hiWGpEaWpOSGRzV0ZuUWJQ?=
 =?utf-8?B?V3E5TWdkNWYzNGhkOTNSNGFJQTJ0NXp3aWs3MjhqQm1Tck1mdU02QWJsK2ti?=
 =?utf-8?B?akZhQ002VXpIV000VXNTaFZTaldUYlJXWGp6Y2Fsd0hOVEt6RE5QNU9OeW1D?=
 =?utf-8?B?NDR6SzNQenhVZzBBcXlzZmJvSzBjNjBVTWIzYXVuNE0xWlJPVE15YmJWRUY2?=
 =?utf-8?B?L2Q3S0lqc2ZMUmpjVTh5Y2t4QTRGRlNIWWh4a0dic1FacFdhdTJOM1VwclZ6?=
 =?utf-8?B?SG5PcituMUI4cXJBMDY2d2Rjd25BcHQwb3VXOG0yVVVvV3JGSjc0RnR2ekNn?=
 =?utf-8?B?MkdZV0k0SG02TzZvdDh4R3JocE52WTVHbUNiN05FQ3FQQU1iUkcxZXZyOVN5?=
 =?utf-8?B?NG8xa2RscitLSzkva0VkV3ZJRmJRVWFMbDl3blBjbkNHT0NKM0RvWDFPZnR6?=
 =?utf-8?B?RDRhTWVrTXExdWlnSjNxSDdFVlhUNldwOEFzZzFHc05NVEVuMnQ4bGdra0Nh?=
 =?utf-8?B?SVJCRllQWVB5TVlxRTJHM04vcGVFbzVJN2lFeUsraG5XWC9SOHNXOTV5YUVE?=
 =?utf-8?B?b1g5THVqMlpBR3pEL0NqVjZGOGcwT2FxcUdYQTdhTXh0NlZWanY0UVhWVUZJ?=
 =?utf-8?B?OUNPZ3ZXWW9wYmJibUpsQ0FBWjhLRDRGbUc3SVhpalBGbGJXNGtBeXY0dU43?=
 =?utf-8?B?Z2JlYjl6aHY0SXBPeTgybk9XL3d5SHFQVjBmcUNhOGpIdlluTjdncGpXTTdL?=
 =?utf-8?B?YWJSVnBXN0wrRng4VUNuT3RoeVhtZWxpbi9pMnlTa3g1LzZMNVo4OXlPYWNG?=
 =?utf-8?B?bjBwVWVlQW1kaG1TaVBCeDFoeVUzRGdzWTlwRHpDakhtaUQxdzFPY3VCbElQ?=
 =?utf-8?B?eTM4Z2lsZHQzZm5FTXZRNWhuTXZoc3FKWW0remtpQmd5QjYzamR5YU1lWERh?=
 =?utf-8?B?R1dNYkRYaHpJaldHalVZRS9QUGlkREIweS9YbTRqSEd4M00zeVJNZHhxYXhB?=
 =?utf-8?B?aGczaGQ0ZGFxNUlhQm82bG5Nczh2cHRJOFpLeXphbDNQTE9BOTcwVWZkaVFq?=
 =?utf-8?B?T3gxajNCYkhUcThWcFJRNGQzMWVtTCtlOGJpS0F0d0I2U054b25rTnlTOHBQ?=
 =?utf-8?B?d3lCTVA2Z01WTTYzdGNJRURtMVNFSnRkVHp2MkZZMGNhYkJ5OFVZd0U5MTYx?=
 =?utf-8?B?cnAxbjFGbFNNSzYwVERpdTVpUk1LTWM2OW01Y05EajVrVjFucXdmMm9mVUds?=
 =?utf-8?B?WXhnR2lYTGgvbGRwS0kxTEIxbUVFbWVlQnFuWUNNZXNjbXVDNzk5b0Y2cHZQ?=
 =?utf-8?B?dm44L3ZHL2dUUnJIQkhsejB2UDN4YWxDNk10cTl5d3JaczlsWUhIOU92V2Rj?=
 =?utf-8?B?Nmtvc1RPa1p0ZEs2SWVOTXRjbEM0d2xnMkVwa2tjRi9HUDFkYVA1YXF0cVhs?=
 =?utf-8?B?ZVZub3d1a3poeXhuYjVPeVZZeUdNVWhwNTZ2MmlqK0FxOTVnNllPWlBXMTFU?=
 =?utf-8?B?dHp1bVJtaE9pWkVaaFIxZWppYnFWRUZWV25sbU5BRUlDbkJHRGhxdER1YzRR?=
 =?utf-8?Q?44ztUU1gCrqahvrPQk56DXq1G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aCC8kW0blYV2mz/NFvlxOWoT5vvTeBNYIC1TXCltRhEu/Jn9q3bdNeiocxIASUrE1cYGqFPXkNIPx5TA5U6rK2m/ZiMAvPLwhbgHYNr8TOb1Uizo9qtF0Tn3PZoGLWArNhzQOs/GnmQ/cyCpslxkgydg4cxjAJgBnssPnB1hUzgweHkMeSgD/+9oas11KsHCq2CfxiQ67XKBr4EPgi6A6BusrJFLF4GIqpX5sOjLd6mO37Ka7HIYu1A/I+Iz/Kk+ZfeqeMH0E44JWhVnxzfy3Rbl6eqKjwutokrMgjdcUl2SsC3UVgp6IpzPAoEJIiuFo58GR0pjFMiFLzBUIrunJyTDanEx2yJWhHlNAoEwC1anpoR4jGu9UTA3lqYeowGWpxmlt5aOMPa3HfkCMuZ07Q/6ZJnAI2/rEhaNeyuwMxbHimx21+EycZLL/J16KR61JX5KgGcDggtupQSdHoG/v2835aQ5R1kXSZ4IOrBhjK+7yZcsSaV/y1pQCXWaPmfSSq17twh4ksU1pciREjznQE39vApY/LNrOtgg9pCpUO0sPeR978EY/EP0Vd8Zh2a2tzw6eDHdI9JtN2eh6FxW2+Dn8HNfpWdhkktT/he9PNjl5EXy/IJdy7PvHsPpLd/zZh/rlaSpOsq5uGlc3T2gqLLya+uQFRPzhMAN7+itSgndslfZ/0boGuzhI+nDyX8NFSmnYRh8+3QYZuTlHfXdseM6Vu9k7FtcLGUavhnHTsaDpF515gvTz6LUlypzrzoZ7m2QKNjPzDCwKkb/qb/RBn9IqwpfHU9wzVvLqSDlVsZB6JYaJQdb/5OScNkhrQxBLNy1+E+ajTWUjH79gDSckqyC9tPJMBO22SWkadWBuDwzFUj2h2AbzBRBbD7G0h0a43k+X2CGM/lN4mLUsrfAXQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8046deb7-827c-4870-c22f-08db00c95df6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 00:48:27.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8HP1XoagTK0M74NntCG3D2vShjdiJ6STGvM5VeiR1j5tp9th+ebQUTgHWvVcbiee+LPNJgBC1QRii8MKHEvwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_15,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301280006
X-Proofpoint-GUID: ApWRJlmlOjdkmPeI6bXJ0QaljUv4QHtT
X-Proofpoint-ORIG-GUID: ApWRJlmlOjdkmPeI6bXJ0QaljUv4QHtT
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/2023 12:37 AM, David Hildenbrand wrote:
> On 25.01.23 23:09, Vishal Moola wrote:
[..]
> 
> The issue is that we're not estimating the mapcount of the folio, so the 
> name is very misleading ... I think you really want to avoid the term 
> mapcount completely in that context. We're just using the #mappings of 
> the first subpage to determine something differently.
> 
> Thinking about it, I guess "folio_estimated_sharers()" might be what we 
> actually want to name it. Then you can comment how we estimate sharers 
> by looking at into how many page tables the first subpage is currently 
> mapped, and assume the same holds true for the other subpages.
> 
> It's unreliable because other subpages might behave differently, we 
> might not be holding the pagelock to stabilize, and we're not looking at 
> indirect mappings via the swapcache. But it's a comapratively good 
> estimate for most scenarios I guess.
> 

Hmm, how about simply call it folio_hpage_mapcount(), 
folio_firstpage_mapcount(), or, folio_cover_mapcount() ?

It is used to replace page_mapcount() in that sense -
https://lore.kernel.org/linux-mm/Y9MDJuPWsk9820xD@x1n/T/#me0531cfb9e82ad5ca88804c727d69cc6b9b33ffa

	if (flags & (MPOL_MF_MOVE_ALL) ||
	    (flags & MPOL_MF_MOVE && folio_estimated_mapcount(folio) == 1 &&
	     !hugetlb_pmd_shared(pte))) {
		if (isolate_hugetlb(folio, qp->pagelist) &&

thanks,
-jane
