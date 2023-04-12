Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5786DF16A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjDLKBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDLKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:01:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9672A4;
        Wed, 12 Apr 2023 03:01:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C6UeK5011476;
        Wed, 12 Apr 2023 10:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xS0Wp9rr0ugwKRFxNg6wDKJnBD2CCHs+IIaeWAbW05k=;
 b=g/93qIoPTMHsma6A8G+hn2lxoxmtTUZ1qxgIcjoGDI6yTH1EkWw6B1UVRsSK45wxtJrJ
 GuZ2PsxKerRB7JZVoG1mSm2vDJm3Tb84praxqABjC9gUVrxTEuy+jZDXqUaGU3NfgQ2H
 rcHOUNrdBAkVwNVwBbo0inNLqimGdH4SLuPMWSv6Mkx7eBLLtwhsFLKOQuP5nUxeYTm4
 nmZMWtM7WKfbD9aWyDzCCYoEjDf7/mR6KBBbVlfUrpQQVaEOq15Eg14JxAqX0u3XhIxK
 zdJ0ypdu6xoJoxgFJ4RR6q00P2PpBRc4Cxe35Ku1qPBgOORBrX4ZljcVc99QYSUEHh+T nw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eq7npf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 10:01:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33C8QKLt017494;
        Wed, 12 Apr 2023 10:01:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw88e5jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 10:01:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmL0jIjbxOodaTD+iQidAohrd3Qb/DkMwaYqek31jqwwrVss7+X3Q6e3B0K6abdXuTxL1SxZoZ7Z6RRIVjzoHFsjiaOJnDzxEeZ4nKG1BQsnckdTv4CmYug4kvZur2P3/MUNRTr/l76v+U0YeXAnqO7iqp4j/TBw2+SemKOk6sYEcTjGuIPWksql+55TBAlopOZsPc0oUFPOhZJxaDwDETjoInYzuE3MNmcXpIXLMWasVCFFPybsNHThGEM2aGUnTxv1jxvbhxm43kgElbWjv2rVBfWap2wStP8UW+ZI4nG5+LCpfKdTdKVIY3sLP4awaLBgPJ3iEl4buIL3nMgFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS0Wp9rr0ugwKRFxNg6wDKJnBD2CCHs+IIaeWAbW05k=;
 b=G0Qcof4U7ncQu3waEEJTktNWiPwvGW/HgfhTA5tyzWR9Q1xgZr3836nUVEDTIib59y0AqkJ/xxgM81FY6qM1j760GoIu4g9zuf7HHnStua8dsk32BbGGTqvLBfEcEIBxYubbjR+8e9ZJzM60sG8tkv6ZW4QiVDXg2dRiFCbR/5YmB7fMQZmL7/VnK0GNQ/mIxRh3A5MpvOZ1Hu+MolitSIGUlL6Tn5WCJcdKD+f7ZwSdmyNK+uavnTFQqV3jD3V0qitJ/B49vHuTO9rtXu/OXQzctK/DeFcvCoR/c44A4FQkZkkeOLRoowW0L1EyP1nBcd74kAmx+mgLaYtHwJ5fWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS0Wp9rr0ugwKRFxNg6wDKJnBD2CCHs+IIaeWAbW05k=;
 b=pellYvqBt45BtKnUOWvCyuU3Sp4HTe8f/1rLwfVT0WfKsOzv+NpVkuIe6ZDqjI5mKxF3bxNXA5nyY0cOrfpCUiJ1lLdQL8xACqF1VKeCykqIZO84IWljcO7hDwloPXJjTkkH33LVhurLxQa+6wowvExq0Z8XuGvVfruaC/vKeY0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6420.namprd10.prod.outlook.com (2603:10b6:303:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 10:00:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 10:00:57 +0000
Message-ID: <5bdbfbbc-bac1-84a1-5f50-33a443e3292a@oracle.com>
Date:   Wed, 12 Apr 2023 11:00:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 06/11] scsi: scsi_debug: Dynamically allocate
 sdebug_queued_cmd
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com, linux-kernel@vger.kernel.org,
        bvanassche@acm.org
References: <202304071111.e762fcbd-yujie.liu@intel.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <202304071111.e762fcbd-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b35c2c-98c8-4ff3-9b49-08db3b3ccf99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZ3aUYiPVFgQehT1h7xBL99enpp3nLds6lXwGuAKLqc4ChCkz4f8MCgEuz28JQUXm0J0GT2KtUl93FnRHvbOTeoVkQ9aFqWsdTVhGih+1r65sqkprCE/W5B72W905XHTfV5tA0JilpxLP0YtiRpc5YxHtuEMQVeQyoG2zuBwiQ/8jAshfdeGtw1IW5sInk4bzzBB7ex9AHhQM//fuvU75YBYGZADeowJtM7Omn/ztftjuVnig7PvV7Uku7IU//tVGv+0SfTR4vW/d9vg9CMlWvWXeCsng0bSryoraMrs7w31klf3lEwhGpyPXpFi7stTM+8s8hJFSv4dUDUOXLjcwrURTIsn7SaIJ3ls+eBexa6e4n+0AkertE+xfrOD+WzPCn12re8UcUjkhtFHmncCBuorjtdCehBt8lOuE7VC+KcffN+GlJ46D2zBRC8OV3bFYquUs0xxlHnKuRaKezgwOPfilDoi3h9/effLzQsydj6iK2hADF/IyUryoY2vq3oklzfeuL7Aw2E7vIkBgTMAvS3ZMMZz4Yw/heid2dg8CaUl3uIrhsb/MQLxT7+yCGCske5Ec4+4d63uuXrcQhfbWFfQnWLGF6r3VriFTXvECm2AjacdeeCT+HPaetUdBG3OuXSA13WHGRMMwslIK4DVfs1fyjFmhmAkR3TAEQgrkO3LUdW+xhFpb06X9mYwtMtP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(2906002)(31686004)(8676002)(478600001)(8936002)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(83380400001)(36756003)(4326008)(6916009)(31696002)(186003)(86362001)(36916002)(6666004)(38100700002)(6486002)(26005)(53546011)(6512007)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bStWdVZzelBFNHU3TCtHVXFZditSM2pwZjJySzJCdUNlNTQ1UFRFWWhIQ1pk?=
 =?utf-8?B?TDhIVWc4eG5Ld3JsakZPVllZNVVWazBhWXlCTzdPQzhGT2lZUURKZzZ5eXR2?=
 =?utf-8?B?MWVTeHBTS0xkeGNvQTlxVmpGZndwVGVRZ2FUM2llWGM2Ujh3OFNuYmlyZjJI?=
 =?utf-8?B?V2VOVTRHWlB5NU1Obm05cTh0Tk8walVySGtGa3ZsTHFveVh0aHpMS2pOVVhO?=
 =?utf-8?B?elVVMEdQWTVwdXpHNzlKTFh4RHovc3BPY0h3VmEwZW9Rdm14WWE4RmpzWWRT?=
 =?utf-8?B?QjlYMS91eTNKT1hDZTBFMkpJb3ZETVV6ekhzMi81VDRWOFF6UTV2MkJqR2VF?=
 =?utf-8?B?MUVCTkk3RFIwWkRLZXVKYnlPL0MvUFhwc1E4TEs0Y3M5VFJIeWFYUFBFbHV3?=
 =?utf-8?B?V3VtVjcvcVZHOUFZOTZuYStqTHdTV0VoWmhnQ2QyR0Y1MVhZakZtTGZITWdt?=
 =?utf-8?B?N21TQnU2RHdMSEYwdVZIMVFFWDRSSnBSWnR0NUFhRVV6WXV6NEw1U01yNlhs?=
 =?utf-8?B?QS9IYlVJeEtKT1R4a3lkR3N4QnhkNU1YNm5TcUlnNUZMNC95bnN1U1lMTmM5?=
 =?utf-8?B?RzNya1NZMXd6VittckdTdWFKak9yUVByOGhTbS9MR2h1dmEvWFhuNTZpdmpP?=
 =?utf-8?B?bzFmVUdrb1VuQXVRR0JOM2pTK0xlSDBZYnVDRGthNUx5Mm9KNVo4N1pOQWZX?=
 =?utf-8?B?ZWZZS1RXTDQ0T0oyN1hlRjgxNzBJaTJ2QXBoM2l3Ynh0MndnbGNBMFBhQkhT?=
 =?utf-8?B?YTZKa0l4ZUZMQ0lOMGIwQjdqVFpuQzFqWFZTZENvN2g0L0IzOCtOQm5VaHRh?=
 =?utf-8?B?VWlwTkVoaDRqSFFMRW5mSmtud0NXTGRBamZQN0p2a25UcDM5ZkxMYStEdGpG?=
 =?utf-8?B?eFZRT1dPakVDZTQvSmVzZ2p3Qkw3OVJIMWtleTR6UUExSTA3WDJvYmdjei9n?=
 =?utf-8?B?cElTSGJCWHJOZVlRbFY0bGsyb0MzQWhLYUtEV1dsd2lIYkQ2cDFXZWh0RGI2?=
 =?utf-8?B?YW54OGJuTDlmNVlSRFJjNGtxYTBYaDAxcThQbVVJVmUyQU9xMndnY25SN2ty?=
 =?utf-8?B?Q2g4UlVleExEZk15djVIT1h4QzVIaGJaL1FaTjJKSUhBblZYMzMxTlh6ZjIx?=
 =?utf-8?B?ZWtFQjVOb2poTzJ2cFFvT2lKdUlRTXkxWTV2V2ljbnJRRWVIdW1zM1p2cGRQ?=
 =?utf-8?B?WXhpS2NnVk1iTC9wWUl1UngvVXJhSVM5VjlXSjFXbzVCUHFxTzFCT29aVjB2?=
 =?utf-8?B?RkszdmdwZFBiYU9HOUVuWit1dEtyVWdNKzBOejJ1QThpa2xud0JRVDdzUjVQ?=
 =?utf-8?B?ZktIeFBjUW5lYko2N3NmdmNUaDE4S2xFamxLNGQ3ZVVUSUMxVitPaU83Wngr?=
 =?utf-8?B?TEpXb2VhK1M1alhtVy9ET3VHVnVmSTA2RWh1bGlBbFF2TGYzVS8wbForNUpR?=
 =?utf-8?B?bXhNZWRBR1RNRDg3YnZKVWh2bnlWeko4YWgwT0QzU2JWWEVDb2lDS2xCSFhz?=
 =?utf-8?B?TXFWQlgxb2ZoWjdFOTJ5NHpzZU9WUlE2M3F0UmcrVExHVWYyMUJYYXBJRkw2?=
 =?utf-8?B?WERjeFpmeXNBNG5rNlYvbmlrWEI0amdLbHd5V2xlZ2krWEwwNFlxcDRJZXYw?=
 =?utf-8?B?YkF5ZEVUMG1YMGFabVZIbDJaayt5eklOYXlkSlVGMGFFWnk3b2tZeXJObk1R?=
 =?utf-8?B?Q0FhQVNxUjBlMXhmNDN0dkVPTlI4Wnh6Skk4djlPaEdLZCsvQjBhc3FheWs5?=
 =?utf-8?B?N0l0QXZteHRhYkJMeHdIdm8yejB0ZThoR1pzbStiUjNFRmI2c1I2VEQ5SXNV?=
 =?utf-8?B?cTdiV3BMTHNma2thbzJvVjJaclVBZWRJS05EQkw3OE1rT3MrNklTZXRRT1pO?=
 =?utf-8?B?ekxVUk1BR21ibm1WTlNWak90SFVYTmd3MlRTU2hKZElmSjlHM2RiZ0oxOUF0?=
 =?utf-8?B?czVVV05WZkJOQjlhd1FxdCtRaVllWm43NHhwNHZxMEc2SktieGh5ZDRxTmRp?=
 =?utf-8?B?RUhuSlRORVFIREd5NVhWbjVRb0Ztb2N5dFM4NUczcnJJU0ZCR2pSUThyaFBZ?=
 =?utf-8?B?Vk52Z3hOb1krR2RLTFpUMU5OeW9ZUHI5dE1oYnRaMHNpbzgrRkVYdVdsR0s2?=
 =?utf-8?B?YVIzaVcwaklHNytxSllVeWZSbStkZGI0RDQrd0xZQ0dXeEE2T2xaRVM0VFpw?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gZTxojoLOcnBkOVQsCN2kofemkjR1TaLK3HgaXJgNE62OclmjONlg2JiiXGsBmC9JA37KGLTWD/1bQKqffkQrXbRAu8/pgnVXRKBxgfUVnqgPCfTsn7lOY6i8x/5Lm0UJ/dlRcn8W8Ym+1cZvK2vJqDkj9qMm5p/b0MvRRxWC02H8khtpBBbJpwxF/EmUUZTJF+ZoFmlcI5nE6/a5Iqc3kK9IWTu2uxNq93NNBlRQhgbvwd5C9s+AXEI/kB/PBDA5JPHYBqpK8asyBmkan//Z5ujioR03c3Jja0ttazF92ecLa8+Mr7Wy0bMNAz3yHMZlBtAVXEJ2KDy4ujAhEWH9S3ybEYYKMHkMZVnfajWbkZkOUiVGITAqS1MCzRJ0/qoIaP4JFtfMOx/oFQ5fncrjctab6GzIIj2ynAMkCsGXpM2DbeZ3jB922ENerhpXjHEOr1qE6jxkOq3xXr2DB2qtcH1/Y3R6Shas3eTo9KknXJ+qOhDKR8IRHs+bM1kM+nhGQwJLBctKEK4z021baxwHeBeaKrks4tGP6TYpZCkgZc/PweffLiYTPnU2SuHiUbHrekUTQ92XAdIZSMEnHz9UaEXfw3pgyAhGel4c/iE25sYobtOSriZpSwbxATtl2MX86BxnymPuyDDd9eKtZKCko2RSUEpZ2lbAyZnHlfoa2z0mKS98EcbKkS/BAq+9iPdTbQp+YkCiCQ81Sr/VCCixzf8pigtqlNGGuKu87Hojw/IMMHEC9ZJQnq7ivBf5mts8/qAylVmYEXlTu8Y0cFtNkya6Oktm/DiUp6OsKl+xD2A/UkW8HoLVYa+O1I6nbK1a6wdjW4Pdq4ar6B3jrV6LQNVNkyBRaApB7jdk0faqTblb0eJDXNRJLzq3voov+xOmmHYECIftd54BqNUS7LMF0N9KuqiE8dtdJshBvHPctQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b35c2c-98c8-4ff3-9b49-08db3b3ccf99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 10:00:57.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+j3UqXiJuKVkkhdhmWrK1gBwLJzNIdr96mhZp+HPdzOilqiqep6ovFfT5MMU8uTeXEJS6hztlrGy6lOUUNkKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_02,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120090
X-Proofpoint-GUID: 1QaiDIm6Nzmsa4FFXdEFCr7tinbBgdZM
X-Proofpoint-ORIG-GUID: 1QaiDIm6Nzmsa4FFXdEFCr7tinbBgdZM
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 05:18, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "BUG_sdebug_queued_cmd(Tainted:G_S):Objects_remaining_in_sdebug_queued_cmd_on__kmem_cache_shutdown()" on:
> 
> commit: f28c8a7d0f7a705395439889a52b09e2b61ea422 ("[PATCH v3 06/11] scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd")
> url:https://github.com/intel-lab-lkp/linux/commits/John-Garry/scsi-scsi_debug-Fix-check-for-sdev-queue-full/20230327-154448
> base:https://git.kernel.org/cgit/linux/kernel/git/mkp/scsi.git  for-next
> patch link:https://lore.kernel.org/all/20230327074310.1862889-7-john.g.garry@oracle.com/
> patch subject: [PATCH v3 06/11] scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
> 
> in testcase: blktests
> version: blktests-x86_64-676d42c-1_20230323
> with following parameters:
> 
> 	disk: 1HDD
> 	test: scsi-group-00
> 
> compiler: gcc-11
> test machine: 16 threads 1 sockets Intel(R) Xeon(R) CPU D-1541 @ 2.10GHz (Broadwell-DE) with 48G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 

I don't know how I missed this. Maybe it's because running blktests with 
buildroot initrd is not streamlined.

Anyway, the issue is that we don't properly abort the scsi cmnd in 
scsi_debug_device_reset() after the scsi cmnd timeouts for the 2nd time.

We get away with this in the previous code as all active IOs are 
terminated when the in scsi_debug_exit() -> stop_all_queued(), which was 
not the right thing to do.

I suppose scsi_debug_device_reset() should abort all IO for that sdev 
(which it doesn't do) - I'll look to make that change.

Thanks,
John

> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot<yujie.liu@intel.com>
> | Link:https://lore.kernel.org/oe-lkp/202304071111.e762fcbd-yujie.liu@intel.com
> 
> 
> [  101.910746][ T7924] scsi host6: waking up host to restart
> [  101.910751][ T7924] scsi host6: scsi_eh_6: sleeping
> [  101.976012][  T203] Buffer I/O error on dev sdc, logical block 2032, async page read
> [  102.135530][ T8020] sd 6:0:0:0: [sdc] Synchronizing SCSI cache
> [  102.312331][ T8020] =============================================================================
> [  102.322321][ T8020] BUG sdebug_queued_cmd (Tainted: G S                ): Objects remaining in sdebug_queued_cmd on __kmem_cache_shutdown()
> [  102.336810][ T8020] -----------------------------------------------------------------------------
> [  102.336810][ T8020]
> [  102.349880][ T8020] Slab 0x0000000013ac9b84 objects=32 used=1 fp=0x00000000a6dc3cb1 flags=0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
> [  102.365549][ T8020] CPU: 4 PID: 8020 Comm: modprobe Tainted: G S                 6.3.0-rc1-00188-gf28c8a7d0f7a #1
> [  102.376919][ T8020] Hardware name: Supermicro SYS-5018D-FN4T/X10SDV-8C-TLN4F, BIOS 1.1 03/02/2016
> [  102.386904][ T8020] Call Trace:
> [  102.391151][ T8020]  <TASK>
> [ 102.395042][ T8020] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 102.400503][ T8020] slab_err (mm/slub.c:995)
> [ 102.405432][ T8020] ? _raw_spin_lock_bh (kernel/locking/spinlock.c:169)
> [ 102.411316][ T8020] ? start_poll_synchronize_srcu (kernel/rcu/srcutree.c:1306)
> [ 102.418070][ T8020] __kmem_cache_shutdown (include/linux/spinlock.h:350 mm/slub.c:4555 mm/slub.c:4586 mm/slub.c:4618)
> [ 102.424308][ T8020] kmem_cache_destroy (mm/slab_common.c:457 mm/slab_common.c:497 mm/slab_common.c:480)
> [ 102.430196][ T8020] scsi_debug_exit (drivers/scsi/scsi_debug.c:7807) scsi_debug
> [ 102.436885][ T8020] __do_sys_delete_module+0x2ea/0x530
> [ 102.444259][ T8020] ? module_flags (kernel/module/main.c:694)
> [ 102.449892][ T8020] ? __fget_light (include/linux/atomic/atomic-arch-fallback.h:227 include/linux/atomic/atomic-instrumented.h:35 fs/file.c:1015)
> [ 102.455439][ T8020] ? __blkcg_punt_bio_submit (block/blk-cgroup.c:1840)
> [ 102.462034][ T8020] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:186 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> [ 102.467667][ T8020] ? exit_to_user_mode_loop (include/linux/sched.h:2326 include/linux/resume_user_mode.h:61 kernel/entry/common.c:171)
> [ 102.474080][ T8020] ? exit_to_user_mode_prepare (kernel/entry/common.c:203)
> [ 102.480660][ T8020] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> [ 102.486014][ T8020] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> [  102.492844][ T8020] RIP: 0033:0x7f4dddaaa417
> [ 102.498191][ T8020] Code: 73 01 c3 48 8b 0d 79 1a 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 49 1a 0d 00 f7 d8 64 89 01 48
> All code

