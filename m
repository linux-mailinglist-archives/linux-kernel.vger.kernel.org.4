Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F32672C48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjARXHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjARXHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:07:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88486539A9;
        Wed, 18 Jan 2023 15:07:44 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmkJt021437;
        Wed, 18 Jan 2023 23:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F+L6ussDGC+AnqyfHTjB+nk0FGUphDeCAg0WYZrbyTA=;
 b=oiXyBrjQvFQIOerQ/5CO67PXrOWoyg654RqvDmV7vmrKG/FIFaWPtfAcDR3LZ7gZ4Ljg
 KoBDAAVyIBf4T1M14yJKYk2HyWdB4SANh7Aoni18Savhx4kCo0tKbFn1j1cWFTuOBtUJ
 nMqGLKlI0HVSENKyVREe5rP5BbjQvFEDfhMFVzly0FK1iqn7YIXJfy73RZaJVDolwXyN
 /cfLcLsq0RGiEF6PTLCllSVx2cj9Pit3ofXy6y6P48zioazEbdAuyGKjzLss35xq1TOh
 5c1IrJL1Jy5ww+VEGoHvzik/SK1+ZV7ANGwFbSU1PRXjwfe3XcgSwIJsvBA7tXUhObpR cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3m0trva1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:07:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMMCxr028846;
        Wed, 18 Jan 2023 23:07:28 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6qufw7af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9tfNqh9SXY+JxSzx8Br00J1ueDAWRjqQKE1LOJYGM9L/NL8NOmBjISezuDc7/Oy/s7HcOt6+ddL4vGswk0rTqGGRyJO/5hTOPuQGPSd079O/5xfiUnlZyaDPEkryNjmZ3bZ8o2YnYH4v0RRz/Vh+ADTRHVjbMJeije7bnovci3fEeZ+FBXG0MzEDREhwH3X9UedwR5T9IIf5W+9fD9coWX+ovTk0pfMNDlcTYq0vEuN673PpHugVUhhqdf0ETg0oiPZMA19MvMRuUJ2P34BFNmSMD/MYaS6L6xGuOp+Ri5FF9153brYdXMF2cFo13zn+V3G/ASomgHaAerGpx6AYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+L6ussDGC+AnqyfHTjB+nk0FGUphDeCAg0WYZrbyTA=;
 b=eMTFEl0Ui6XP692i6uy86pAlQ/o+UjbxNuVyOPDzH7xpqbkYaC5gfx5wJWsDImtdxfnN9KDk+mqJ157xwTUf+LoSkJQwK//7mB8IbRrR9d8CTzgAjd1D38nG9JVAGjlGISFv/xmdVMJKsuQQ0wnuZE1MUFqwj3MvgiHO2QJS3J+gq6+8UL7tNOHjjmqdWXe/f2m3WepEaPIawq33ZaTbbft6LQSUliLgDTWl2hap9xf2Cod8KOcJGvSfUPynobbHQCsZJ7o6zrC38dsH/RryGUt3aw5asq6aqfM0BaitmPl+kP31JeAdZ/i6QSSxUPKI60YvpJO3COnxDnITzezBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+L6ussDGC+AnqyfHTjB+nk0FGUphDeCAg0WYZrbyTA=;
 b=0CysUQ0KCdNMT5rn2GX3gryjuZcBqEQDqgFG9ZonKr2L6dW4AJ6c8GNHtqoytgbK2XmALTSvECAKU2j8P0vmCoBR+ccIVn6Kr4tckkYu9qoZfls6yePChhGDdYHMCREed631bu83bGG5myofxfGy6CW9B0wVNGgK3csnBO0r4K0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY5PR10MB6011.namprd10.prod.outlook.com (2603:10b6:930:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11; Wed, 18 Jan 2023 23:07:27 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 23:07:27 +0000
Message-ID: <c3bd2bf7-e174-3afd-43d2-7010d9809815@oracle.com>
Date:   Wed, 18 Jan 2023 17:07:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: fix iscsi rescan fails to create block
Content-Language: en-US
To:     Zhong Jinghua <zhongjinghua@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, bvanassche@acm.org, emilne@redhat.com,
        hare@suse.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com, houtao1@huawei.com
References: <20230117030114.2131734-1-zhongjinghua@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230117030114.2131734-1-zhongjinghua@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:610:b2::23) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY5PR10MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a106e1-0dcb-4b7b-1889-08daf9a8c43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qijfxW/7XAFxY03zLC+sLQXmLdVMP6R6TXyduLFlx5aLpc4xi82Fhl+QIE8BkdJSNSlTJD+joft9NIt/dReItLdpEPTYKR+devAhbDWs6bkNqYo0h76Kob8wkUl4t2p77Kxqi2A3tcxVMyRzvycXPmyZLhdzpuCTaX7LE2mv/UWiUBTOk245omzDcPsAwRKtnNuYzoqgd03hEuDc7wzZ8ZGfof7tgKPhRNoWSNC/6LG4Y0WMXqPS8QncoGn+JtbykFHtBg8PIjdhjRc2tXxE60bCgENGKRZJPsdSHyWCSU/GUpeXEukeUIBToEGeFU82IAvl4I4dre6zf54pS7CRfrikhZA1aufQTaBhUnMFRH8GuNk23ItIWskySBwOqPf1jXSwVeYBdk+0BhR0diS5QN0gIZub2uTEN1x/++NZgASghapvHRja2XqtjaTHXTDpg3A3/9FdYByJYg2jv9eU4fvbVc4bUexp35o8YoY4kxxiaYxHYLZPqsxa9Gv/R+Poanb9Bk3f6CQe7o6kpYBldl6kX9bnzLm9QHZ9kQCmxsffjLsbA2heD0X/b9rbz/MMK2S9esogrhtLDcbnfsDKJ3TPzY53mNJEL/3wkZfKhU/i5QlMclj5qIJA+c8tXKNEctLp/9jKYFqbbzZs1nI4RXp9mnDHQ3bTYjQGk0yvfrmip1SOdsnhwkpBVr06Uewmf2bhU4kQlmVFn6QMcXOX5422awfFyV6TAi7Sdq90v7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(83380400001)(5660300002)(38100700002)(66476007)(86362001)(8936002)(8676002)(7416002)(31696002)(66946007)(2906002)(66556008)(4326008)(41300700001)(6506007)(2616005)(6512007)(186003)(53546011)(26005)(316002)(6486002)(478600001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVErdVptTlhkQmRhcHcrWldZb1l5dVl6UVNhWXZqbGxpZEZ0bTh6djFOK3dG?=
 =?utf-8?B?cXp2amtQVm96QTJCQXFvVEtGM0s3eThBOXlGd3JLSE8wRk5lUWFXdXpxbVRJ?=
 =?utf-8?B?Z0ZuNVMwZWowblN5cFF1WjErVWF6Q3BVVVk5QVpKQk9zUkg4YU9nRmtLUUU4?=
 =?utf-8?B?SzU1VW96VGNCMTNrbWNENlQ1QURLV3NFTU9HMW1RUTQxTTVFVnh4SkhOTU56?=
 =?utf-8?B?OVhueFB0K3k1K3RBb05vSVM3UVhIZURTODVMdnZhb2I1aVR1Qng4blNFbllL?=
 =?utf-8?B?YUJoNVp2WGd3eXF0TnNvWk9icmhRSnkyVW1BdW5kTTFWSmkzNGp4SU16VFBO?=
 =?utf-8?B?aXRHaUtaSHVWc0RYdkEvSkFjQ1hrY2xtVE5TYWpIQm80Q2kzZDQ2TkVyeWpJ?=
 =?utf-8?B?VXFpV0tKTm1Ecm9BVUF2WlQzdHRMejJqdUVZNTdYYWh3RE9GenVrSFNpbkp3?=
 =?utf-8?B?NXlQNVllUDYvSmE4eGx6RWt4d2FRTlM3eno4VHZlYWFoRW1zRDRrWWUvamtv?=
 =?utf-8?B?WkhNRWRoYmtrbFl4Q3luS1ZFeXZMcGNMb1BLdXBHOGJ2Y2x4c3BTbkVSdmNI?=
 =?utf-8?B?cmFFK09VQTFpa2JIYXAvNkc1TzJ0OHB0VXVLT3RFUCtab0s2MCs1S0VOeUFk?=
 =?utf-8?B?eURYT0Q3QmYraE1ZQWhyMUwyS2hJNHIxRG1DZVB0ZUpDdXgzTFVaRGV5VTVx?=
 =?utf-8?B?bUFJeGh0ZW1jVElHM0h2b3BjSzFRTEVNL2t2VE1wZ1laUUFhZk8zSjFob2dS?=
 =?utf-8?B?Y0xZQXZmdEhXVEFpc0R0cDVReHlGVDhxQjBTSC9ReldkajU0OCtpd3Q4dU94?=
 =?utf-8?B?enpzdmExZzBzNnZnZkxJblRDZm1JYmE1Q2pEanFSYmtocHJJb1FPTHJVTUdT?=
 =?utf-8?B?MjM0Q1RtaWdmTTFXd0U5ZlljV1NpTTJRM3o2RUFmNFNYTitJZVpUMElDV0dO?=
 =?utf-8?B?QlpBUk81ZUlrQWk1MDBob1NIYUlQVkdLQzZiNS9oTEVFQm5LdFF3OVRrTVIx?=
 =?utf-8?B?OUNGb0krUkVDOE9uakg0eXVFS0ovMWJCdjFGcENzQm1wZng4K3FuTklveXZm?=
 =?utf-8?B?OUk0aFhNTyttUklwLzgxNTAvRTRER3NTZDh3V1pIQzlhWTYxTHZPRCtaVmNS?=
 =?utf-8?B?WmMwUzhNTTRyMXcrTXo0a0d1WE1GRHBsbkwrSTlUSTFVT1ZPWkxLNnVRZ3g4?=
 =?utf-8?B?clpzQ2Z2anhPSHppbHpXSEVJQkxwK2pwRytKQldiT1YwYW9abDF1V2grMWd6?=
 =?utf-8?B?Q2ZvYVRjK3RCbms3T29XYjZCYU9TUDFvTlJ5UjVxTHZUUjJYcWZvVDVBZnYv?=
 =?utf-8?B?ZHBhOHloRy9pSjF5MHhBWmhRbjJtVmZHVm93L3NDT2FZZVlZWGx4ZS8wYnFP?=
 =?utf-8?B?N3E0WjRtTWNFMnVZTkhPK3ZRYkVhTUJMOUJPNU9XN09QMzZFV3FQQTZrWWZM?=
 =?utf-8?B?cnFMSHVlcHdrZVlpM1Q0YUNhZm9mWTcxcVlPN250UlV6Tk1EZEc4U0Yzdk91?=
 =?utf-8?B?eG5mSnhsZGFMNjA1UGoydVJxWWtlUm4wNmZCNUtPaExwVXo1RVI3eFUyZTdG?=
 =?utf-8?B?eHB0VWhOUjhvbEc2SmdTVFV5d011bHF5N3JaVnMyckZuQTcvNjVEUDlZS1l4?=
 =?utf-8?B?cHJEMERSZHJlc21qODBzUmhQVFpPcmEzUU5OT0hLQXlYR2F5eUJwNGl1enAv?=
 =?utf-8?B?VUxWYjR6QXZaNXV1MmIzUEVpQytXaTBUYjZaNURPVGdzeFo0OGx5QXkxcjlU?=
 =?utf-8?B?Rm1kVkw0WGIyR1NvRkx3QkpLeXFBdEcvQVlRUW5zb3F0ZXJkN3o1a0Irc1VY?=
 =?utf-8?B?Y0tUN2VkbDF4d2VqNnExa0thcFRwQTVpWklhZXNBMGV2OTZhQ3RWazdWZ1JB?=
 =?utf-8?B?QnFmdFkzMFlYTnVJWG5XK3VuUU11N0xTSkNCWjUzdEVBRjdjT29BRUZkQW9R?=
 =?utf-8?B?MzJGazVZQW16a3ZBdHdtN0pJV2NjeXBacmYxekdlaFp5TExycjJLUGZqWnY4?=
 =?utf-8?B?QmVVakFQVEpPa3pxV3R6Rjc3TXNWWnJlUXdZVExvNml3SFd6a1JBaitLRGJF?=
 =?utf-8?B?YVF1NUN6emdQQzQ0SjRwMHVETkc5QTY0NWFxZ2p3NnZxc08weXU5YzZpZjB4?=
 =?utf-8?B?RVV0UW9hK2NyV05ld0QrYjVOb1dJZmU5NlJLQzI2U1k2QldXVUI2YzZ4bzh4?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FuZV8fZi4s24Dh0IHu5gXDyZI2lDTrwEZ/BXgFxc9rBlIrabX8gxo7m1GAahZAuRyRavfBP5qTapN60htm05/cYY73QiePjRz5uqzdSpQh/ALDaSPeJz5mIe+aeSToZQNKl2YeVQRDiIOk+2DGXw+29UvMRHeREQRWPjFT686K9cBl1EqPbY7NN4YpT0Q+6j75/upHAwHj5B+EG9C2zBRjFgXe4Izi6DCyvvaLsQqNjdMxcul54Yo/lwudSTRLc5AZFtdFcd6HTQTaQbCReqH/qRzI2649v/Iy6oOwjApH1yIR/NS4EiE2NBU9ngH9j12R/4rT7Cb1Oud7SVG7zPMkbFSTyoBCRXxUfJf/H8d4niszwGXUxtI5zWh47b56EKNot3laDju4qF4RP7/uo4TJGyuqSNkEj5BMCB6b9rleYHFiSrUdYltpI1gnfcU2g8X/WrSUGAkByVGzSkZTWrx2THObgucqX/NfMi94YiLsbjdgVBw3JzX5ELLTsoEzb6hltaeAM9KLjzow/I4/xZWl+Q2wYt50JzZTljYZMBELpc4v0DLVSk5K4ZPg6e8VMJARX0ydBLcptQxDy+GO29thOaMNYr0KL97kHXJ5NobO7lOVv7gNFIPErRAqv2/0EtrO9tqUPkPJHFdjjCXN11e86GGiLzvOia69Dv77caOyiMO2YIGNa4+/OLmUPbrFbh5nO3vo8KzgKw5CTfwD4LF0f9z8R+Dr4Lgb2SwCRzDqMpXARDiQqaH+5Kz6gr7RHCML4tgRq7xD7kORqo7ZKR5UvNbcHh+CijbgTtXfMng2/jF3P0vri0P2ckezURbJYzOG1HMkyRMVGho7BLm5JGAflb0d5R/AN6Qdg+aqF2jHLCscVnRUfDUZe+gIMln4SYzeP82dVIb20jxuqlPlkW8A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a106e1-0dcb-4b7b-1889-08daf9a8c43f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:07:27.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1M6FIQqEeX/g37mV/XWVt3/sfmn7TCK9FSW64Qwp/ETA69p5WversMKnR5SeCbpCSEgGuCZnevVBo25eFKzt01QkbCY6X+90MnqawuwKj3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180192
X-Proofpoint-GUID: XmV-Y00tipLSuLGhlxoNr0Xn56nOAbvZ
X-Proofpoint-ORIG-GUID: XmV-Y00tipLSuLGhlxoNr0Xn56nOAbvZ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/23 21:01, Zhong Jinghua wrote:
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> index 42db9c52208e..e7893835b99a 100644
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -1503,6 +1503,13 @@ void scsi_remove_device(struct scsi_device *sdev)
>  }
>  EXPORT_SYMBOL(scsi_remove_device);
>  
> +static int scsi_device_try_get(struct scsi_device *sdev)
> +{
> +	if (!kobject_get_unless_zero(&sdev->sdev_gendev.kobj))
> +		return -ENXIO;
> +	return 0;
> +}
> +
>  static void __scsi_remove_target(struct scsi_target *starget)
>  {
>  	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
> @@ -1521,9 +1528,7 @@ static void __scsi_remove_target(struct scsi_target *starget)
>  		if (sdev->channel != starget->channel ||
>  		    sdev->id != starget->id)
>  			continue;
> -		if (sdev->sdev_state == SDEV_DEL ||
> -		    sdev->sdev_state == SDEV_CANCEL ||
> -		    !get_device(&sdev->sdev_gendev))
> +		if (scsi_device_try_get(sdev))
>  			continue;
>  		spin_unlock_irqrestore(shost->host_lock, flags);
>  		scsi_remove_device(sdev);

I think the patch will work ok. I don't think we want to mix
in our own reference getting function that works on kobjects
directly with the put_device use a little below that line above.

Since this is the second time (looks like Hannes was wanting one
when he originally fixed this) we've wanted a get_unless_zero type
function did you send Greg a get_device_unless_zero type of patch
already and was that rejected?

Why doesn't scsi_forget_host have the same issue with other drivers and
similar scan/delete/host-removal type of tests? Is there something that
flushes those async scans? I'm just wondering if we can do something
similar for the target removal or if the host removal needs a similar
fix.
