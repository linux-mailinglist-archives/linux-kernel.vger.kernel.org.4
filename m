Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A136A7608
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCAVQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:15:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608348E1B;
        Wed,  1 Mar 2023 13:15:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321Fwldv017213;
        Wed, 1 Mar 2023 21:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Mt0ifIFLbnWxcRsu0L/NHTIlcF8/8ZMnrICab92TrfA=;
 b=efSEBkS7hHkTZ2V5Msyn0E5QD5ZTpbvubkx++f0fbPJcBkMGrIhnGD3Gh1rUIQ4qi3WF
 ypIRS0s73WQYGbc5TI0C5Jsd3+pN4ePt+Rue7hsarSKJGxjV9heDLmNqoW/EbJQgxhmL
 81FSvIjQjOfIEVlCRvrWOcBy8V1HZ9hhqewfD4lwlhTELrChmmVXkbYqrW7hVWClJRNL
 ceI3lsCw2ULS2vrnlbC7K/6fT1oJQZOpP5/HqS4rGo6Y4RJhiEZHNQ1urcBG363e898T
 baUgnTkaD4fClxIZY/TXTWuZcCPr2+WHX8i1cULUfCR4YUec7ODwYNF65ogsc7KRdWHb rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakt5ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 21:15:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321K7l2S015895;
        Wed, 1 Mar 2023 21:15:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s9dxem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 21:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+v9qQWcTRw2tdcBZldB+9NYp58m5U16+q1F6BVS9viur5qqDeFwL46ZV2Juax96Ez0z+TK39u6/cNolodZ2NOQ++M410k6MopZnX9yllWshva+kxi9HJXaflLmWN67osyAx7/ZFvHIAmP4tzwMM0N8LZm7a0CqzH/5v+yivCUPIv/0MH0E8/aaUyWxoLHvEMOkepWu+Iyowkyo2Y0l5EyvnFYHGghFeRsa168/v/un5xUCLcLy0W5rDV1ZAJFOg5Hg58Aywxo2/8iWa9L16WTvsHDDd0vD38MUKWjfzInz9idcxivba55aVUWV8xx5ciSooOM3GezL33y5LEXwDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt0ifIFLbnWxcRsu0L/NHTIlcF8/8ZMnrICab92TrfA=;
 b=QNXYY8B8THFOsT206Z0ionqnwMHGwDLfEFKXcA9T+s/O1GkTjNxsT+/21lBNJHPJssSDaUfRMMAo9tNYtLb26R25fHglFoBfWJb3Xv6PWIWOcdQuqGfPNPyt8gLh97e4vAxH9wwMVePrG2z34hISdiquWWYvb5LPdGKOVry2eTuyr3NqMBrILjbuvKV3/fJlvtCUU5ov3sERbZruqex04/uPzkuLkf6RFFhwUFfXPags9DArDWu7d/BPdiVjAkOuseFTUwMP7XGWUdcB1xteoubK3pDaEBpOdrCOcr2/ww9T8tjEZejp/acrPtxo2DtbTVBFcpgdG0a2TZ96WQbo/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt0ifIFLbnWxcRsu0L/NHTIlcF8/8ZMnrICab92TrfA=;
 b=r8sKtmDgbY3hXUz0Ew4XlbBo2AYGi+mWvTLmrW7EmRlVxEvM/KRRCbLZPGDqkqSzqe3kgclX/Teqjkp3RAWlmFLdEXp9B/xnCfNwcw+qPU452jxeb90urw/26wD3EKu0zUnbsB1L8xZG5hql6J7V9ZuJfIkJjvDioeXy9ToapJQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 21:15:04 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 21:15:04 +0000
Message-ID: <c6106113-7050-4099-8c6b-ec79b6b83d5f@oracle.com>
Date:   Wed, 1 Mar 2023 15:15:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH-next] scsi: fix use-after-free problem in
 scsi_remove_target
To:     zhongjinghua <zhongjinghua@huaweicloud.com>,
        zhongjinghua <zhongjinghua@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
References: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
 <4585779e-f919-0439-2062-b1f30b04f176@huawei.com>
 <a71be678-7f40-811b-4612-81a4eeb910dd@huaweicloud.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <a71be678-7f40-811b-4612-81a4eeb910dd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0132.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::34) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|BLAPR10MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbdc7e2-2eca-446f-57ed-08db1a9a06d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9n63ki+ZvitQJlhtYIUquxbiWs/OoYmK4h36r1rwPWwWj7gAuBuwgCzd9nM9M9YfUAsYwJXeH5Tja4Y7VhWd7TvsbyJfxBhZ5Tb5orBW9kbBoHfp279r8yxnWKSORZ2Nm4ui3AuMkWAg7vlgX0UpdK01qHtyjuh+3cEbNTr+eEG1VhRbAnAsKee1iwH27jc7Decv5afyeiKrFWFnsUNxKy1dYTqMsDJHwkp4HQJjxki8EqwwMn1I75y/m4B6z8ZGeZ1gsAfYBHo2yHp+M++ypHkl41wUnxe7KhwyDXcv4HyFxvYxZYHW1CGpXQyC95nvNv4rgQGAX4lPWrVh77n10eCuM/bmm6CmNDKZaSznOe3HyPbn0ZVrO1hykE+H7YVVJnLGEPxoTuYXrGRlz3NZ9jGe7Smdmc8BHwrd6zZf79X6vPUDthN3X8WUl4jGIqagJ3WNmXydINUuZkkOEGUU7Zz9YuP52qFvKIOXcEY+FvLhalilDk9svb0LH4hzhB8aujrwsKCOYiD9iK7h4sLaifsmNa0ChB+cp5i3e9Mcz6PCeabbWS2vDuzrd8Fm7K/f981T8G2dXaHc5yu5PJ4pa5b11q5bZu7i9OlbkzJISLR0wMbyF/jINfZrTxkalBKiERHc4qjP2ssMSstgpq7n4VuHfYZEeRL2B8DdjPZsMg/NRxMTcy4vaRQYQjKDEmaEY1mbWDbJ8ysNrJVc+r905OHZrSwpcybpQr9RqOvCVJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(8936002)(31686004)(5660300002)(8676002)(38100700002)(4326008)(41300700001)(66556008)(66946007)(66476007)(2906002)(110136005)(36756003)(478600001)(2616005)(6486002)(6506007)(6636002)(86362001)(31696002)(26005)(53546011)(6512007)(83380400001)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXV1OWZaR01yYUMrMTNSSG5BdHNXOGlTTm5JNUp3OXU1UzI0bmtOT0hIYjll?=
 =?utf-8?B?alJ3VnVTTE9WemJKNklHdUVNQThSVXZCL0Q0ZVFUT1U2Q1hQaUdub2gwSkdp?=
 =?utf-8?B?bUNtL3ZRdmpyR00xVTJCREpsallhSmZuV255akdWbGhWZ3ZsOXgxNHFTbkRm?=
 =?utf-8?B?aHcvU0Njc29adWR2Q0lqN2xIbXJDSlJyQm1KbWt6UkVlMnBtWm05OHpobTU3?=
 =?utf-8?B?Mkl4T1Z6VXUyeHdOMFZlTTlnSjRQUVlsZ3pPTE1Wa0lTOU1jaENOUVhONzhI?=
 =?utf-8?B?cjQ1cU9ZWmpkRm44WHBMSkVUbmdwdmQ1ZnBNSEZyY3dmdzlVNVk2R1MrUStY?=
 =?utf-8?B?OGhCK1BlVWJ1MVd6c05vamtaVjBHNmNXNEdyUStOZ05QK2svWmV2aFRkOGp1?=
 =?utf-8?B?TkRvblJqc0pzL2E2RzNGUzhCWGRmQnlqWW1MVFNsK0VtZG0wNjFFeTNrWTdv?=
 =?utf-8?B?U0pmdWFJYWNxbG44RW5jZlRzaEhBb1Z0SjROdDhoTzlDN2s0NjNLcU5tYmFy?=
 =?utf-8?B?OFYrT2MzdXZ4UnFOOHhCaGFFbWd2LzVhMUpibE1IN1RLQW1LOFRDRzdXQ0k0?=
 =?utf-8?B?ZjI3dGlyVEhjVnExVjRlTlRRRUVmMU9CR0haUnRwalZpVEhpV2dWZFNlMVZx?=
 =?utf-8?B?S01tdVE0YTU4cGJ5Nk9lc1d2WDBzVW5tSm5hK0R6NHlEWVZlYlI4NEZ5Wi9m?=
 =?utf-8?B?dE5OYjUwcERVdnVBS3RxQUVVNlRIc0hOWTBGYjF5c29BbGZRZ2tNSFk4UDVI?=
 =?utf-8?B?UjhTc1JwVlh2d05lK1Z5dTVYQytYVDNiQXlCVDhhOUJ2QVFKTDdHU3liS2xF?=
 =?utf-8?B?YlVCaUxvdmJzM2RudE15RjRRTmU1dW96bzMzMTJLNlFoQ0I1bzV3RWZ4Y292?=
 =?utf-8?B?VUI5WTVLNUhCMUI0T2RZS2FtNEpQV0Q5VEx2S3VWWFFEWEdlVTRsRVQ4aTZt?=
 =?utf-8?B?N3V3SkxCWTRmVWMva215S2l1bFJzUFJIdWpRZjlLVU52T2lCT0U4QzJRRnZt?=
 =?utf-8?B?eWxTK2hiS29wYS9yWURiSVM3OUJ1OHNZcDE5c1hZcnA2WGlWL3FsT3kvUDRM?=
 =?utf-8?B?aEtlTnptdEJsYnk3MGZuWTJ1aklTMUJuK3ltemtjYzdicVFGb2xzTFFCKzNH?=
 =?utf-8?B?NE5VV1VPNFRIeXdCRmxaeEZVay91dnlqZE1JSVN6YkVLOExzV3poYk1UZ3Bq?=
 =?utf-8?B?RUI3RGF0RkJTMDBnQ05qbCtpVjlIc29JYjdBd1ZROXl4dTlFNVhGb01lR3lm?=
 =?utf-8?B?MnVtTFNWaEtzVmtMNlZtR0tRdnNySWc0NGJ4MGViWVB2RSt4bTNoZkhqbWU0?=
 =?utf-8?B?R0s4MXo1Yk5OK2VaQXBFdHpTMGo5UTJBTFlKK0p3YXpDQ0FOdWpXRnQ5MWhD?=
 =?utf-8?B?SyttTGV0Z2lCUWJQb2YzVElQenFpY095N2NtbWJPUEsvMmdKOWpkMFRHTmNq?=
 =?utf-8?B?ekJtZGJXQ0l0dU4vRVZONHZXRlJPUTQ0QkxGK2wxd2k1elJJZFZzekFFc3cr?=
 =?utf-8?B?OFMrNWx4eHBob2JTRlpYL0VBSjlDWlJkK2FlQ1hBenl6MjlTdGsrUHQzeC9Z?=
 =?utf-8?B?dkM1MW9yanpYT0tNb1c5Z1NUVGlxZ1FNM1RNb0RvOWhvWHJHL1k0TjY5UCtk?=
 =?utf-8?B?WWsxT3VZSkFuS3E4Mm9qWit3RW84WWlVUDJva0I5ZlBFcXNraUYrTldIaENu?=
 =?utf-8?B?bmRtcG92L1l3QUtOVFU5NG5DUnRBbkVnQnhDYU5sU0oxbDd2V3ptcFRkb0RX?=
 =?utf-8?B?VUtTRHl6YTRod1hXL1cyVjhXaEcwNDZrRWZiM1VnYkZUejdxTHNJZVJBZVlS?=
 =?utf-8?B?eEg5c2VQQ2Q2L0VGM3ZYMXVCaVY2YW9SdVFBclo4UjNHS2lxZFpCbjNWWllz?=
 =?utf-8?B?VWZQTEEwQkRXTzJBRWhTVUtPMzZPV0xOK0xqUmw1REMwME5TWU44MURGSzFj?=
 =?utf-8?B?Zk1nM2l5VXdHN2JTQkpZaDBJRUJNNEZMNWdUbTRRdVR5V0s4YkdVbklZbmU3?=
 =?utf-8?B?L0VmcC9tNWRIMFdSOHIxZEdiajM5eG9CS1hyYWpTa3BOeU1kV29aNHh5aWo2?=
 =?utf-8?B?bFA5NG9XMmx3ZWlvN2lCZkRYd1hJZjVkdkZqbklIZ2M5UGJPMEljKzluemVZ?=
 =?utf-8?B?T01mQnNnUTR5NjIzZ3RBWjRFMjZ3Z2NNU1RLbEtzdm5lVVpXY0hNbVlmY3M1?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vzPA3WaK5TR3MCQJiZ0frqEvmEIZ1q/yxMcbw+Yct+Ue0neP+DU4jnADIUkWTNZ4OOyz1Y1jQwok3AcZgzQ04Y4BZZx9vTU9FAgHsDh1P/9233MtH3owV44SABY3/HAH5bLZE6ZZItWB813bKbN1gKq7vaeQM1rsvJAIqj0v4IruEz+ZRPNdMQWwRc+wfsYLRNYZ3s8jnZJUALAeiU/CcnCXOSu97CMWXwc4XPej1GoMVkZamnrrLWZrC12MUzzpCq/w4JOBaI9TL6mcwbHeAI456O0HH094szetftsi/QrFWa8MkL4NkA+FbkrSzAc2dJ2IgOrBajVrhdhfqi85xVK8pN8HTiq3B4lQC4FJ4QIiPum2uh8jfoLZYRNa0ySwWPKkOqyOK+GyVIafp1HbUcJYketRjPo1hj9bq9leb76F13mkmLWmVbD4V+ym4FAdKsYLuuNgDCa4bC3YbKgeW6K9uBYlHwvAexEgYwcpCAe9LZdyZaWVpN+0oZtr6bnXZX+IQ0iVHOep8TxWCzkCJz+49/4XmlJ9XMRMScWi0OjegjAqZY7RGss9zSi7WWg0OwShtBRyaW4xogeaxXlH5ArICT1fC3k3EirXWGjVnk2y+OZiwpVMP4pKONIl7YNcnf+L1nNMMB18mO8nxrI8GBbpmip0dcLcBeG5trMSmrNxidodSs/PJj2Sq322cAbxaJVMsUUEMWwU5zMepx8SK7jiPAYNihcQHHG7PfcFppgXGXYbfJ1LLbW4EGy8Zd+M1iwMvOc5DTGq7izTNw936+LXkbENVmO35OD0sSXPH3UfQfePwz6lNhJn1zj7ZrK05HJSPNL5RMf3D+V5/h+U9bmeyKTqGNlTUBpOrTM12Aitug8Km3G/JeoYpNAhKbEe
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbdc7e2-2eca-446f-57ed-08db1a9a06d0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 21:15:04.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/uwk0ibl5+6c7r176bXN27GymLYK4SDFbSEVQEAULpLkggkOExA6HMTgo5+iC+4X180cLqBNPrib7EagZGuNOcEqQ2G3UPxzVO/qxicft8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010168
X-Proofpoint-GUID: -NZx8-otEISGun4oVB1N2Ls3644EYr5M
X-Proofpoint-ORIG-GUID: -NZx8-otEISGun4oVB1N2Ls3644EYr5M
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 9:40 PM, zhongjinghua wrote:
>> 在 2023/2/13 11:43, Zhong Jinghua 写道:
>>> From: Zhong Jinghua <zhongjinghua@huawei.com>
>>>
>>> A use-after-free problem like below:
>>>
>>> BUG: KASAN: use-after-free in scsi_target_reap+0x6c/0x70
>>>
>>> Workqueue: scsi_wq_1 __iscsi_unbind_session [scsi_transport_iscsi]
>>> Call trace:
>>>   dump_backtrace+0x0/0x320
>>>   show_stack+0x24/0x30
>>>   dump_stack+0xdc/0x128
>>>   print_address_description+0x68/0x278
>>>   kasan_report+0x1e4/0x308
>>>   __asan_report_load4_noabort+0x30/0x40
>>>   scsi_target_reap+0x6c/0x70
>>>   scsi_remove_target+0x430/0x640
>>>   __iscsi_unbind_session+0x164/0x268 [scsi_transport_iscsi]
>>>   process_one_work+0x67c/0x1350
>>>   worker_thread+0x370/0xf90
>>>   kthread+0x2a4/0x320
>>>   ret_from_fork+0x10/0x18
>>>
>>> The problem is caused by a concurrency scenario:
>>>
>>> T0: delete target
>>> // echo 1 > /sys/devices/platform/host1/session1/target1:0:0/1:0:0:1/delete
>>> T1: logout
>>> // iscsiadm -m node --logout
>>>
>>> T0                            T1
>>>   sdev_store_delete
>>>    scsi_remove_device
>>>     device_remove_file
>>>      __scsi_remove_device
>>>                              __iscsi_unbind_session
>>>                               scsi_remove_target
>>>                           spin_lock_irqsave
>>>                                list_for_each_entry
>>>       scsi_target_reap // starget->reaf 1 -> 0
>>> kref_get(&starget->reap_ref);
>>>                           // warn use-after-free.
>>>                           spin_unlock_irqrestore
>>>        scsi_target_reap_ref_release
>>>     scsi_target_destroy
>>>     ... // delete starget
>>>                           scsi_target_reap
>>>                           // UAF
>>>
>>> When T0 reduces the reference count to 0, but has not been released,
>>> T1 can still enter list_for_each_entry, and then kref_get reports UAF.
>>>
>>> Fix it by using kref_get_unless_zero() to check for a reference count of
>>> 0.
>>>
>>> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
>>> ---
>>>   drivers/scsi/scsi_sysfs.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>>> index e7893835b99a..0ad357ff4c59 100644
>>> --- a/drivers/scsi/scsi_sysfs.c
>>> +++ b/drivers/scsi/scsi_sysfs.c
>>> @@ -1561,7 +1561,17 @@ void scsi_remove_target(struct device *dev)
>>>               starget->state == STARGET_CREATED_REMOVE)
>>>               continue;
>>>           if (starget->dev.parent == dev || &starget->dev == dev) {
>>> -            kref_get(&starget->reap_ref);
>>> +
>>> +            /*
>>> +             * If starget->reap_ref is reduced to 0, it means
>>> +             * that other processes are releasing it and
>>> +             * there is no need to delete it again
>>> +             */
>>> +            if (!kref_get_unless_zero(&starget->reap_ref)) {
>>> +                spin_unlock_irqrestore(shost->host_lock, flags);
>>> +                goto restart;
>>> +            }
>>> +

Patch looks ok.

Is there another bug in the existing kref_get_unless_zero(&starget->reap_ref)
call in scsi_alloc_target?

I think scsi_alloc_target can find the target on the __targets list, and
it's call to kref_get_unless_zero will succeed if we are only above getting
our own ref (we have not done __scsi_remove_target and have not done the
scsi_target_reap call at the end of the function).

But if scsi_remove_target has set the target state to STARGET_REMOVE, the thread
that did scsi_alloc_target wouldn't be able to put the target into the correct state
(the scsi_target_add call will see the target state and return). So later if the
driver/transport class did scsi_remove_target again to remove the target that
the scsi_alloc_target call re-added, we see the target->state still in STARGET_REMOVE
and it won't get deleted.

Can we solve both issues at the same time?
