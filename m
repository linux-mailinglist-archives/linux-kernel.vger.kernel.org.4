Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C65B592B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiILLTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiILLTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:19:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507CB3AB24
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:19:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28C8nO7H001345;
        Mon, 12 Sep 2022 11:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=kh1hGnZU2bw/Ynwqjmie3bTRkp8mXgF/lXYo36O5Kes=;
 b=3Lm5T8KjEMZA6tW05FlwfvVN3rhrF0v/ADvCgAC/Vr8C1XADj2FznExTQXLnymAmUUac
 gtYrI6iV+LDxqiSRJ06lMrjjVjoo7iuRqCyz3QMt1WEPn/ruiF/RCrfkWLlAIXKZx9QB
 uTuCosQ6lU2ffKbRIRKOP2AvjDbHKgDuAlnTNHH2ev3JhfCU3Pd1aek8uMT+EHGQx7jL
 U4mV6Hw/3eLp29oNi5DZfLhQfSb3AQf6K8oYht2mlE1QlcZVKA06rhfqxXqnEd5/E4rW
 2hu6axmbY6ooZxqjq7rL80pjDaIDFIAhM+NWs0mBhgXZxfx3s+xSzfoQKbS9QKy6xub0 KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgjf9u4ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 11:18:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28C9rFdB021739;
        Mon, 12 Sep 2022 11:18:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgk8n46v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 11:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMeM5tWPmDj9dvmquStaOeJXuE/BdMypcX08yBX7myr4Oub3AUzCQ2umtteF6I5Xw2VL3UAwwYVAflUOrEywdU/7enu3YX2fq97UEV1UK9D3uS2R87DfIK17JA9hkegLIlZvG3JtgRIa5fpVua+FDqZqORnvLMuNtwoGmagbStFjCCloY0oa6zUc6uiupiCIikKoIar0pGDsh1j3vw4VNuK1iukuE7AZP9saV/JV78fswSJ1qIPYgQVvh2dE6fXLAf4P9HrePir2McgDzf38sHA7J68DRaEapqyIZ2mEgEqVUYHN5A2WnNm4DcGEcATzAajR4au1rlMV2lQZxp4Z2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kh1hGnZU2bw/Ynwqjmie3bTRkp8mXgF/lXYo36O5Kes=;
 b=URasjq3SYkAHNWtzVey8jpxvtmSgTOkyKnkf10v/rcgk4BFKrvD3mJU/OdN4lGgi1oTOK0kH83YZ9PfoJedWRvmRpC8c6jrpyTK6EBt/RtpgiyKSM/fQ6Uo3c5NQJDRLTKGJd3sWrZCIQsCjk1F8Iz0a82Uu7Qq7V51A2BJ6uh664DcgCD1+UqJYJ9avUZr0HhQ8btgY408h6OvQosbE8zmehKQSDY2KSxxJ5+AEob737sR1CAsWmODuY0rtw3bYa3E+DLq8x8E21q56H/XxQDCZ72O0ntl+gmrFUAUhXAv5+OesUiCEgq2cq9BIld+VHReC/YaN2czwKApaFcwDyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kh1hGnZU2bw/Ynwqjmie3bTRkp8mXgF/lXYo36O5Kes=;
 b=MQKb2+zKOz2yLSHA46wh1/bsB35Ze1wP5Lri/vmdkFLij1XGWK6Kx10dII6UFOuhPskYjiFyEzlAJroJjGkjF8POdIvjbbAuoUWdGoQkyKJ4pGItYpT5IvwsOzw+M/sORt7fj8OLUF77T71b4sg/EG84mOO+nQMca0tX1o1wbUw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4159.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 11:18:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 11:18:46 +0000
Date:   Mon, 12 Sep 2022 14:18:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        changlianzhi@uniontech.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: add a bounds checking in vt_do_kdgkb_ioctl()
Message-ID: <Yx8Vj2GfGxehRAtR@kili>
References: <20220908075403.27930-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220908075403.27930-1-hbh25y@gmail.com>
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MN2PR10MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: b76c2baf-7a41-4b28-28d4-08da94b08e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jjh70KF2QenBeVmpu5UHsenCqqBkli80jeyyx9UkIyOr1D+7zuvhkRHX4AlsuH3t5SFb71tF2+9oWAyGMmK84VqkqB7/ImVRgZq/b1G6j6PkVdTqf++EOtzS0xX5PRHTmwmBA0qlbkN+zbBt5vVZdkaT0QYO+uEzh4s5nnuOmonetIzMRfc7YSQufjJIspiOIwhSGlgLwOBRUpZdcyBicRfip9OcU49quUZ8glj/oQf3UYAOOE0oHp5dZo2zCK/6YlRvdj5pcGcH2y3FnJKffpfmenIIZNSh0bBSzpbK3viAQFWImofLUXTJqHFd2pe8Kn3fQGlssynXvdo/vRvpvvDRt3aUp5NzjQ1PXM3NQJXIfelFMZ6JsIEJkaz4T/l4H7uNdOdTHS4nVsVmiZZLGUZaMiKywsL+2EZl2UxvDBpXXvv0aeI86NZy6k0HRgCG85t2YaEGUaTptlc2q/OlPm4804uiPS1B8FBz+LOpayR4DxDhuJyBaYFH5Y53Olkru8M1Lyl5Bi3xJINfFFhunMI0QKCUqMj7ieegn46js5QDXpuy7iVg3WRlruG87uiucvnI4oBdQ4csOcr5rqsS74vNBfIS0l+6k8zaX0HSyJH3sbaSOPGYg2qXoHPvK478bzkIXHJpg3VACEiSr6L2hzocUTzNOfN6hwIuJ2xhO6hhjlp8L6twNTc4rG64rqDTBWQiICQGxA1pVFeCmdEvzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(39860400002)(136003)(346002)(366004)(396003)(84040400005)(26005)(6512007)(9686003)(33716001)(38100700002)(5660300002)(4744005)(66476007)(66946007)(8676002)(66556008)(4326008)(86362001)(44832011)(8936002)(83380400001)(6486002)(316002)(6506007)(6916009)(2906002)(186003)(478600001)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtFQlpCN2FNSFNjOFpGcWY0Nkh1MHF1eE4wcXV5dkhyMVpsa05pOUxmWjFP?=
 =?utf-8?B?cE9JUnBML00xUFpjTjlXNDJmTkxkWTZtU0JaalZXbGJNU0tJNFp3bFhxbk5X?=
 =?utf-8?B?WmdvZlBMYnowM2R4ejJHbTAwa1lvRDBiOVI3T0FVajgrV0Q2eElHNXJtUk1J?=
 =?utf-8?B?d1hoSlB0NlFEa2tBelBPR0hOOHdQWnp5QkJOZmRUNGpteko3WFlCeVovTmI2?=
 =?utf-8?B?MUJNTnQ1Z3VLczFnSXVhWXAzUWoyV1Iyd3hUdzl6UWk1YlVIUW9BY2YwUUtx?=
 =?utf-8?B?aTBuZTNRdmxOQ2Nnc0tpcWl3SmxGYkdHeS9JQ2lEL25qbEt1OHZ6ZnJXOXNP?=
 =?utf-8?B?VENPanhsN2lobzBKZExBZFZCSS9jUzhaOVVDWjR1b3VNK0ZjQXpsSW9Jdkdo?=
 =?utf-8?B?ejF4ZzhjQzd2dzRORXJ4aG9QTEVOSHg4aWlseGdjcWE5dDZpRm8zNGo2dnBv?=
 =?utf-8?B?Mm1Kc0RBY0M3QVZjakwvTG5hb3YrT3BQN0dQV0x0QjkwVTlEc2Q3VjFiMEtV?=
 =?utf-8?B?dDlkbWVrOXY0Y3FoRUhOUGVreHhqb21Dd2tDMWpIcEl3OURlVTdhbEN0TjVQ?=
 =?utf-8?B?RXJqbXlsVWdpYVllcmNwYXNGMFhSU3NBMUFDckxZRU5qMWpteElaTkoxM3dq?=
 =?utf-8?B?UjdBWDN6S1M1c0lObjBHMUVlcUlsK2NwbnFLOFVGUTdEa0NVWnRKdERLbzZY?=
 =?utf-8?B?ZDl1RFlhOWI2Mk5TbFJEVE9Bdjl5Y3liUUxlSHBzSUNpY014SDZCQnJZaGY4?=
 =?utf-8?B?ZFJkQ3A2SDU3eEdLNFRKd29teUlYalBvck5kL2lPMXJlVFBHVzFqbDdxMzYw?=
 =?utf-8?B?cTlMa1Y2dksyNWUyTnZINjF4VFpqYzQvM1hkdE0zSVdGeHpKaDBNVUR1VVFs?=
 =?utf-8?B?Ymg0c2FOdkNIMzJXYjdpVmNWSldwVEsxMjUvSmYwaXFDR1NRdGxQdXJ6NWtC?=
 =?utf-8?B?cll0S0NBck5EZDJ4eGdGWDlUQ1RnQ0Q5cXlSNHNmVGRJZi9WcEV1MC8vZmsz?=
 =?utf-8?B?TVlJRHdYU2RCL2FDMUVVV1dHZzNtUVhTM2t4a2ltTGVuTDZkTXdjSzhJMWJs?=
 =?utf-8?B?cW5xU1lKelY3c25lWEpFZHYweFE0eDNtWlNZcWJZQkZPWC9Xd0FNa2YwSTZj?=
 =?utf-8?B?U29BMy91TmhmdVNRVWI0Zk54cHZiYW5ZVmhqSWlhMnM4OHFxR2FrZHRYYzl1?=
 =?utf-8?B?cVdGa3lLTHdKNmJhUGRnamlVZnpQWCttK2lkczJQRmdFZUJibGZRdHdwNTUx?=
 =?utf-8?B?R01OM3ZXQnN1eGVsU2QrUms4WkNEMUQ4d2N0YzM5eWJpcTBZemJSRmpIMWF6?=
 =?utf-8?B?eVpHa1pNNUp4VlNSVGhTaHUwOEZyQUNMdnppQnJjUVZOc3d6b2lHK0NOeHhv?=
 =?utf-8?B?V2FkQzl2VkR3V0ZDUmpEVW02OUdZOWV5eWN2MjVJZDJ0V0JqLzNCQVhNYTYz?=
 =?utf-8?B?UDFNSlRtNXhYYzlGQ0RXTUpZS2FHVkI5RE5DcXB5UUIzUWQvdDcvUkUwVk5p?=
 =?utf-8?B?TXozZGhEcTJWTFBRT2dydXpQWXIwMGQrWXVwRzN0YmZpNzdkV0M1MHprUlQ0?=
 =?utf-8?B?L0xnZ1J3bjFZK1YwRVJkdVpIS1RTelFKWHdoMFVzU3VkdlVWbVl3dE5RK2FP?=
 =?utf-8?B?ak04MCs1TjQ5b2RVUm1zZThYSVh0TkUxSmovRGp4cXllK21ZdnVUNTl3bi9R?=
 =?utf-8?B?NU9WdnVaU3V1S3VCZDUxSzg3a1IrVHh6MFZHTUkxVEZjWkkxSll6cUJmNlV2?=
 =?utf-8?B?Ri9MQkJUelBhU1owbHFOTncxUURkTXBZOEpTVHkvZHNrcnFJWjV3WDRQTkRM?=
 =?utf-8?B?MDVUcjlCUzRWcERTdmFndW5iRXJtTnd3ZU83ZVpLQ0d1Y1FmRmdrZjgvQnRu?=
 =?utf-8?B?VjM1aEVJWkpKMG5VeWM3TFJ6WGROUHRLMEJRSmlET1dTU2cvbEZIbTkwYWFP?=
 =?utf-8?B?eXUvM0JVOHpNYVB1MmE3OW9UUjJlaHdpT3dEb1lKbWh0N3FKbVhuQS8vaWJD?=
 =?utf-8?B?NzJqdGhDWnBXTUsxRm1GVnRoUS9rNWJyaFB4TDFncmNZTmkrODRpeXRibzhl?=
 =?utf-8?B?ZDZldkgvOTFTSm13aGxRbno2OWRic2t2Q3hST1VDUFQzMXovbmZGaitBTjJp?=
 =?utf-8?Q?33TKzjW9PVsXU9epEy+XhVUyh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76c2baf-7a41-4b28-28d4-08da94b08e80
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 11:18:46.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TylPAwZhZYYZzd7HXwM7MyvKcy7S7+UGzQvu72+KNkaCkc/PXh5JIlFGjtn8YjAFIiFxwJaFjHA3BF/nCKz3Fzi4Q9aeCkJr64n7KvNDS/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_07,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=623 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209120038
X-Proofpoint-GUID: 5kiZ1f9hVfOYUPtrBqNS9qXyDDn4sN-7
X-Proofpoint-ORIG-GUID: 5kiZ1f9hVfOYUPtrBqNS9qXyDDn4sN-7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:54:03PM +0800, Hangyu Hua wrote:
> As array_index_nospec's comments indicate，a bounds checking need to add
> before calling array_index_nospec.
> 

This commit message doesn't explain the impact to the user so the patch
was going to be rejected based on just the commit message regardless of
the actual code.

regards,
dan carpenter

