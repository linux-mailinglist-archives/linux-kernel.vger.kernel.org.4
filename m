Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0215C616242
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKBL4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBL4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:56:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF8E201A3;
        Wed,  2 Nov 2022 04:56:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A29wvth013761;
        Wed, 2 Nov 2022 11:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2V3sfaH82JIqHKaxsPx027aVW9fgLMpoHPfetr86GMI=;
 b=rqj94sDZUKr8LQlfR++oTCcQb+9xxLDPcXrbknfENPUF3nfAmJxBsJtAamL0Ysw6KMuT
 +clpmG/POZDxwWt9nAD5UX4uXhgP54DGw3KRjCeIHiHmHv5/CFWzuJ4fCgIkmAFsGuzv
 mfdPGliGr46cBk/WW/w/5U2+XExzpmVfvNRZBizvkLzoxNRRvx+1SjdAFisfUceuumRh
 L/cHHulqhFNFReUtxL9xhVbFAwgFTH31m6doKcb7/dQgPesmsWlBTlE8DaxOAh8CAMVw
 1E0DdLuqOy8Bu9efFVuo7xPoFS8enl4mVR8Cqy2YgNPKRcziUuBbuTc9oIZ+qBNDhmbP Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkd91vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 11:55:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2BQT0o029721;
        Wed, 2 Nov 2022 11:55:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm5e078-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 11:55:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb4C9ZLfOPAZGT1vqeZITA9wF8kN5k0RbaSZjbYinMWSwHRUgJesF+3epiVfpyj/s6JaLDKkTUcYvgDyDzjpsydDGT4+PJA6wE+2h/zsWrZnmNdx3DzEObG1lC9KVVD/H8CVq3Of0N+vKGm9LsC6fagTP0C2zYG5HVgUm6OuxMOpO4ApvGixXiuUGLLgnDuuO8ymzmHifxg//IUxcFGPZeq4PkmgkAvFLABr6AK+LAhZQRgJrgqjce82SXhYwlqMvv5J7sCBBUHvpof8zsMTVKUx7aM3Dl9GJsR8bjTL9MbSw27msPqtFXxdYgLBsLxmvN3l/SwonJPXVMLe1PJKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2V3sfaH82JIqHKaxsPx027aVW9fgLMpoHPfetr86GMI=;
 b=LmJMSCW3n6oCyfMz3l4BxNqGW6x/RT8lGPVgH01TLEnqaQvPoorUGz8Ww6Ie8vHGtIV7j69/5eCzFWh0pkJex8elTnGcvY2Bm+PIjA+H83lGrRua99nrn3p6MTWV+XiRyAzauUOnlL/wQDeviR+IkncWv/w1+AtEbomNzFsZ55+Db5ZDDipXkYszr1diedwjH26yonQGwmpdBOFRRmhdl0I4qMWu0NNTeX5/X848O3PSzDGE4WMdowMpKGWPZMUcD/bY8eD/KbslFSBRyGAhyuVAtgL1ke0VjVCGKUa6MkiJgBReGyL0zQZ6F1GquS/DPPCxP9nAYm1xp9lCirTH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V3sfaH82JIqHKaxsPx027aVW9fgLMpoHPfetr86GMI=;
 b=liRaMAIPwv9a0Nix7xAiUexCX1+d3irMMxDmEvdL2XpU3Zh6wpY17zXHjPcmolmJ5hdyKSDnemcYP1zsFvTqSFhKdpiZOnJenXk/Tjion5ErPWhcPJCTlP8uKhQk0poGhqHpj1ITtI1QNzjrvAwBdcAojpm4ycGnIhKhdp8W9BU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5279.namprd10.prod.outlook.com (2603:10b6:5:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 11:55:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%4]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 11:55:37 +0000
Message-ID: <90217102-8767-b077-2615-1a5e41b58660@oracle.com>
Date:   Wed, 2 Nov 2022 11:55:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] scsi: libsas: Check and update the link rate during
 discovery
Content-Language: en-US
To:     Yihang Li <liyihang9@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     bvanassche@acm.org, chenxiang66@hisilicon.com,
        daejun7.park@samsung.com, damien.lemoal@opensource.wdc.com,
        yanaijie@huawei.com, duoming@zju.edu.cn,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com, yangxingui@huawei.com,
        linuxarm@huawei.com
References: <20221102100555.3537275-1-liyihang9@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20221102100555.3537275-1-liyihang9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 661f8b9f-fb9b-4f9b-a476-08dabcc92837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TsiEfPzeWsoaTJPzi2eOzqBwXa15a1sPcHolfN8X+iTkceijJrgD/nev0wJuUw6jbt2yHC9ifFQNcTSA7sCXAgYN9qGEej2bL1y1094e+YG6Kr1Q8Rt/r6U2kHSh5rs7gTcWxyEzdhe6/z3KuUJZkeGGWREB9jHVfAn3UvENBon+wtgSgjV0gFqIJBjeZh2JhCfif9qGC8/jHxvF2dhEqRFgCdDazNO/ffl1MIhJ6jGp/dGyeHAfTdWz0FKPpE7sspVU7hJRcuNW+JUIVKJsgd9cylDVayWEpEu/OdE/Gm+p7qhXDSy+wW+ywWVeHMlnz2myz0VxdDZMtoxwKhlwhLO8LdHskF5eRmVBY6C9LR9VgVG2VsL4+RPLLabT+10MinetCb9KS4ilhBxa+bWP106J/VFhum5cHzdVvZ6FxYabwuloJ/8sO6fWV6vYrq8Peyq4uFixHhyPzhlxqWhEqdYuN576qFa0eBTIQ+PPG83HSxqZ+lhs7x8yXFDjLuysXLFDgr5ROgYs2boR0XesQ9SvqC+NWbjjWobypdQbqsmYusy8Isjy3ShWTz6lqNIigv2jbQy54CyWp2Su5nswILtGifZaxw7koyH4TaTun7gn6i+DjUgey3kHiNyM/Vf72q7pd1cp+PO54bH96a0JSHo7SBhY7IJsh1lpcexKg/u4Apn5Ca+3vlIGVeBtEPlhPDEQIczxlthfOm5+Snx4xFzxRGhFoW7rr2fF3D8tUTat72994a8evdTemPsqF8GiTqd6wPu2pO2H3QDDJeqTh62XSSGAYwY6taqSIsWiAd0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(7416002)(6486002)(41300700001)(26005)(2906002)(2616005)(31686004)(15650500001)(5660300002)(186003)(6512007)(83380400001)(31696002)(316002)(66556008)(38100700002)(86362001)(478600001)(8936002)(8676002)(66946007)(6636002)(66476007)(6666004)(36756003)(4326008)(36916002)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhzRmtxOGhXblc0S0pmcE5hMmNubGZtN3ZIc2o0MDNZWFg3M3pBR2oydlh6?=
 =?utf-8?B?R240UzNyRjBzQlRXME1Mc2d4dDZhTmx2ZEo0azRISXVMbkZmRkxHakl6UC8y?=
 =?utf-8?B?UkRFZCtaV2ZhTGFzbjFVM0ExTW9HS2phQloxRDBrNlF5OU5nUENrSG4yOXBS?=
 =?utf-8?B?NGg1ZWNYR21HdTc3c1ZRWDNlaS9DRWlNZUo2MGRqenFscitvQjkyby9rcGJL?=
 =?utf-8?B?blB6SHArbUZsaU9jWW1TN3pZaGNlT08raU5oV3BQWTJtVVNES0E4Y3h0ZUo1?=
 =?utf-8?B?TFJ4OTJZbk8xWXJmSkxlYThnM05UeFFhcmtkREdUWklJR1B3Zlh3MGFQWTN6?=
 =?utf-8?B?M2RBYmZObE1ZR25DV1RHSThhaG1Gb05HWng0cXRDMU5GS1B3OEl2c3lmL04z?=
 =?utf-8?B?MURUN2NIMlZ5N2dHWE45OXpuRDgyS0lDdjJrMkxkZ2FpckVVdUhmYTlFY1RT?=
 =?utf-8?B?UzM2L0pISmRDaVk2aGZWQjZ5RUdvWkUwOXVZWHNIQUhwVFFreHoxSGJPMVJN?=
 =?utf-8?B?Tkh1S24wcW5iQTFxUDYyREI5N1BESHFYR2JWL0dEQzRDaGNlY0pZY2hHcnJQ?=
 =?utf-8?B?cEgranZ0VG16UjNEdVBIQmpTWlhvaEYzM1IvWDExOGZ1VEhZeDdKeG03YTJF?=
 =?utf-8?B?MGhoQ0hDR2VPeERORVNWRUQ0MDY1bGNTb3hGWE01RDR5QWJnb01tOS9XUHFS?=
 =?utf-8?B?NE5Eak9pYUgvR09qNnZIT0NhcW1XcmFDNkt5VUQvZVdNYmJUdVZrdXJod1V1?=
 =?utf-8?B?SUhkR2lGY09zdk5ZYURWMU5pNzZNOExYZ1gweEdGRWxYZjBIRWdEc3c2QW5K?=
 =?utf-8?B?TkU2UTNrVlFrT2xBYUxpNXlBcFhoVDFabHRYVUZjci9IMGxDSGRkdlFYWGpK?=
 =?utf-8?B?ZUQ3Ly85ZnBoYWR3TU16QTl3OWkxMGhqelpUTkJXZ3dMLzZjcUJ4QzAxUG5C?=
 =?utf-8?B?WWhTUjRpaGZkbm4yYXV5ZEdXT09QZHY4S1Q5djZmaUxaQWIyOGxLV0RuY25B?=
 =?utf-8?B?SjVqMzZNNmZrNjlYWnR1eG84U2FBUUd1ZnpxVllXOHhwM3RnWWJDYmZsalVh?=
 =?utf-8?B?Qk1lSERlWHVIdFZ0TE5nZGZoQ3h2OWxaVnVmTVZoRkg0Um5yMXlUTFY4V25C?=
 =?utf-8?B?b0RDZXFjVWFTWFJINDlaMjFicS9sbkg0YjVIRXRTaEVPMDljeG4rSkdrNmJW?=
 =?utf-8?B?djFoZ0xGcHNVNHdEbUc2Y2JvVjh1RERidXYxdWJrRlNBdHhxRmJQOHZsd3Fl?=
 =?utf-8?B?MDNQcG1iQm1aRlBSOFJmRWdUTE1LMEZxV3NLQm1ZREZ0WWRSdDU2K0lTSzNU?=
 =?utf-8?B?Y3BMbVJrS3NsVmdCZUlSalZDbFU4M3I5NjIwQnpXU0dZT2Z4RWduMklGblVn?=
 =?utf-8?B?OWIxcGsyZzNQem1lSXFtR21rMXI1RW1OZ3BLWnJjMDh1SkMyMDlmeGZvcWlY?=
 =?utf-8?B?WGxHdi9iM1BUVS9YalhrZHRGN0ZFSGVUenZVbkM0ZVdyN0Vjb1ZZQmgzSXAv?=
 =?utf-8?B?SFh0WVNuTm1mdDF4b294OTFLL2FKdXJHN1o2OU9Ga2Y2SEx0aU8wWFYzbkV3?=
 =?utf-8?B?UVRUakNEb1d1WWlTNFN0YUhEejhmaExVdU5KbGpsWEZWT1JETHg3WWtwWEY4?=
 =?utf-8?B?NGttajlndFdJdXpUaFMzV1pXbTJmRjQ3YjIwaWlFaWlqQmpPM1UyR2ZXQTFj?=
 =?utf-8?B?Nmdlb3lJVzBUcGhZbHdFRm55WWxJdDRiYkIvZWd2NlovRUZHV0dQaXVkNy9m?=
 =?utf-8?B?VFlYMklvU2ZFYWdVek9QZ29oM0VKM1FGSzZ0NlNraHdFNlFaQkNzT3VjZWVD?=
 =?utf-8?B?UFhtdERVU21rQ0FuMHpmU3NOVGsraGJCV1lBb1JhWnBYcU10cjlmdnBwc3oy?=
 =?utf-8?B?b1RldDY0a0FYM1ZXbkF3M2pDcDBJcDgyalVvZG9RTlBENkUzVFlDZVo2b0Js?=
 =?utf-8?B?ZVFmUk5aakw0OUk3cUt0by96UEs4REVFTWl3bTRUZ29WZnJpWGh5Nm1mK253?=
 =?utf-8?B?SVlZcWdVMVNKV1d0UjlMSTdJUlg5eG5zUkRVY1hzMnNGZTlMa0lTMS85Q3M1?=
 =?utf-8?B?c0NWbjF5bU1IT0R4bWZSN2pyalhFZExjTzg4c2VmM1NoSEorbmpXTnVmZ21l?=
 =?utf-8?B?TklRNHExcEZDWVhBbDRDVGo0UWREZ28xa1RFTzUzcXdlWG1QbFg0dkRKUytV?=
 =?utf-8?B?dFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661f8b9f-fb9b-4f9b-a476-08dabcc92837
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 11:55:37.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5LuqRQ72QvT4wbN2PUqAfvFOMp4kiwPnfJPMU7k2IJHE/+D75B6V964ThuwMkXDA/zBHFCVqvDP+GtWB98PRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_08,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020073
X-Proofpoint-ORIG-GUID: pAiawGbnd7aPKQz70IwsUGfTNwCRVion
X-Proofpoint-GUID: pAiawGbnd7aPKQz70IwsUGfTNwCRVion
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 10:05, Yihang Li wrote:

note: This is not discovery in which this erroneous condition occurs. 
Discovery is the phase in which the device is found initially.

>     +----------+              +----------+
>     |          |              |          |
>     |          |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
>     |initiator |              | Expander |
>     | device   |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
>     |          |              |          |
>     |          |--- 12.0 G ---|          |--- 6.0 G --- SATA disk
>     |          |              |          |
>     |      phy0|--- 12.0 G ---|          |--- 6.0 G --- SATA disk
>     |          |              |          |
>     +----------+              +----------+
> 
> In the scenario where the expander device is connected to a wide port,
> the preceding figure shows the link topology after initialization.
> All physical PHYs negotiate connections at the rate of 12 Gbit, and
> the expander SATA PHY negotiates connections at the rate of 6 Gbit.
> 
> We found that when the FIO was running, if phy0 was link down due to link
> instability, and the link connection was reestablished after a period of
> time. During the physical link disconnection, the physical PHY gradually
> decreases the link rate, attempts to renegotiate the link rate and
> establish the connection. This is an HW behavior. When the physical PHY
> try to re-establish the link at a link rate of 3 Gbit and the physical
> link is successfully established, the negotiated link rate is 3 Gbit.
> Like this:
> 
>     +----------+              +----------+
>     |          |              |          |
>     |          |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
>     |initiator |              | Expander |
>     | device   |--- 12.0 G ---|          |--- 12.0 G --- SAS  disk
>     |          |              |          |
>     |          |--- 12.0 G ---|          |--- 6.0 G --- SATA disk
>     |          |              |          |
>     |      phy0|--- 3.0 G ----|          |--- 6.0 G --- SATA disk
>     |          |              |          |
>     +----------+              +----------+
> 
> SATA disk which connected to expander PHY maybe reject IO request due to
> the connection setup error (OPEN_REJECT-CONNECTION RATE NOT SUPPORTED).
> The log as follows:
> 
> [175712.419423] hisi_sas_v3_hw 0000:74:02.0: erroneous completion iptt=2985 task=00000000268357f1 dev id=10 exp 0x500e004aaaaaaa1f phy9 addr=500e004aaaaaaa09 CQ hdr: 0x102b 0xa0ba9 0x1000 0x20000 Error info: 0x200 0x0 0x0 0x0
> 
> After analysis, it is concluded that: when one of the physical links
> connected on the wide port is re-established, the link rate of the port
> and expander device and the expander SATA PHY are not updated. As a
> result, the expander PHY attached to a SATA PHY is using link rate
> (6.0 Gbit) greater than the physical PHY link rate (3.0 Gbit).

Please mention the SAS spec section in which min pathway is described.

> 
> Therefore, add function sas_check_port_linkrate() to check whether the
> link rate of physical PHY which is connected to the wide port changes
> after the phy up occur, if the link rate of the newly established
> physical phy is lower than the link rate of the port, a smaller link rate
> value is transmitted to port->linkrate.
> 
> Use the sas_update_linkrate_root_expander() function to update the root
> expander link rate. Traverse all expanders connected to the port, check
> and update expander PHYs that need to be updated and triggers revalidation.

So are you saying that you want to lower the linkrate on all pathways to 
the SATA disk? In your example, that would be 3Gbps. If so, won't that 
affect the end-to-end linkrate of all other devices attached (and lower 
throughput drastically)?



