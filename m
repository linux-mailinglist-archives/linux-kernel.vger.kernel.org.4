Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C502651C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiLTIoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiLTIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:44:19 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E112766;
        Tue, 20 Dec 2022 00:44:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK7o6bl020978;
        Tue, 20 Dec 2022 08:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AsTyioKZ/DXfZULPevqzm23slVb35LjtRIpFwVNnlPw=;
 b=dIgVOmRJLaHBRetFP0Rxf3e5BZcY1Vgy4pwenS7hJBvo0apPWp7xafmYCtxAQV5BtRSb
 dkcJfxdisyJw53Yagnz6u+MPvnTxGdZYhb5tt7iVNIop5b4u8RkrLW1PXz4O02/DOA7X
 LophcyjhKufXkJ9SCi0rvNK12Io02qzNxcMd/e6AL9q4FU2SbjL2j5So+RqNF1aZJsD4
 DxpIlCJDL+olvo3RdlL3WKqnbpqUqtJYmpUds9c4Y/kETL0sD8Lb8lzvSxtpuzNYkP8A
 p9gxx5bo3Lc5ICkZUlaCwNsKc7vSfs4DppqE1cOXJTtmYDc1Fh5BWPZJtQI2xX0ekhc+ sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tmw53k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 08:43:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BK81vUf009681;
        Tue, 20 Dec 2022 08:43:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47b35wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 08:43:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KY6UxfMrUWoLZbxc5yF3ONN+qAFYIu1r3hzhhJ2uvBE/8ySrQp605USLkrvibO9aS9eRyR1bcW+hL0q7G3P43IPHJtslTTOVuaqmWhugv9Lze1wI0IW14SYDH/AnFrTHc4KDJ1qIzDqFVrJUjeK7YGvRRWlx2tBIYdPaIy40yJcQ2El/QnraKGhyX5dPDfzmrL7dS9l6O+lkQ5aH52Wg/uwyFTqRZrqA6NIO/Hm0YHIVMcs+oGVyHNp9kPGg6JTOBMz0/dn3W1Tkl7BGtPrdO+sMkORgj0fo+sTOD6e4ic7/3p3YwNC2xOdEgD55WqujoMjO3qH1D/Mn0EicA4YsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsTyioKZ/DXfZULPevqzm23slVb35LjtRIpFwVNnlPw=;
 b=ayIk5lxaeNJY6JasnbiEOA9gzbqWYBr553cztdDi1jUYa5BlguUYNLELon6H/K4PXRa/yuZNQ+okKxo99GrLGn/QwKAyn9BcnXC1F+XnVDQ2Ehswhg3DglkaRDIjlfZIvjh5KAQ82SRElSTrmXGmFyAjYu8fTWW8AGFvhr3XB5yY8B5UudwD5CHd+/ysbUC6ORDPfN4c7k76L4UU5gg3hxqktq+lro1VN/v0YBuSLzyckHM132WBOc4hy/z8BiiU8/qz1utsCiHXmIi5mKqruZdGSDbIH6k117FlORTDHc7Is0O45y8l7yH/ClSprw/IWgtOoywWb7l7YQhLs7K+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsTyioKZ/DXfZULPevqzm23slVb35LjtRIpFwVNnlPw=;
 b=aVM7hQuJ1G39jaErFBzVxuaORLsnshWjjoGe0QRO85zgMMDvSea24i82D1uLIiht2sZI48G1rvTVuwSHo6AIU8UrwXAMnhkHrw4bSm9qUtLtQ+8U2FaYXy16hfRamaFt3+4nmsmF9aExeZLi/M+RJi6GIpgEjymi8zo1Uu+Vyqc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN6PR10MB7542.namprd10.prod.outlook.com (2603:10b6:208:46d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 08:43:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::1040:f0e3:c129:cff%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 08:43:35 +0000
Message-ID: <12cf34d6-8267-ac81-02c4-190bb9afc50b@oracle.com>
Date:   Tue, 20 Dec 2022 08:43:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V2] scsi: libsas: Directly kick-off EH when ATA device
 fell off
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-ide@vger.kernel.org,
        hare@suse.com, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221216100327.7386-1-yangxingui@huawei.com>
 <565fcf28-ec53-8d74-00a3-94be8e5b60e4@oracle.com>
 <60ace19e-d029-f14d-9aac-d5cef83b5b64@huawei.com>
 <257dcd6c-2ffd-f518-9b13-c309348088d9@oracle.com>
 <4489f80f-9f39-8f3f-5d10-6b113131e65c@opensource.wdc.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4489f80f-9f39-8f3f-5d10-6b113131e65c@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0506.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN6PR10MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 52baf503-e775-47fc-e82d-08dae26647ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2V0hkAbnvgwSIRQUTkTLrWVFybvJ4N0jChFl9sStnrAO43ehQR25FaVgt/CddC5oGgmUv37Qv+diGeC3D+eBTAppJdZLr+AkO/MluHrCXE3fZEI5paVy5nK/nUEdqNWctT1mLnt/yinMBgIEFnoGrxE+l3ALpQAOSg1APfJRuQco7EQJxV0xR/zLO37+06+0YbC/GJxQgl68CipM0mm7AhKAQqG7uScBsX3ZqZK90X1jbD7jivHr7J67YGtzCMiTUs+142EbcYv96RmrEjLzqTN1b+wW3hESDrqjDYAld0A7o98BY4dwL0k0yfVfKr8xPVLQGfDZe71MPjhhAs+XhNjcqe+/KjqUim6BdUg3kiyKI1VGHgTLiuj8jUPp0KCMzj3RJP9B8B7LWbrfPJmdQwLMofrgF+f0xkpymld6sJubhTHv5qrPmsIbqG7SeMYQCCALyGH3DraECKblkUpUfbuvfw2TKX0W3Lm/withyYXm1w7hUHyVU3CVo94qyRfdfJo34HYtJpZGNz/mVzXJTJaoCFZ+jQIVSuUumgoee9xxAwfGOBkd2onc+m6Fh5tzEICWk9p9S15ZhVa5bpiQDxGbc8taFQikrNLo7Y6b/OXO+LbbvPc+8X5GTujjchFMmbkTgKU7ML3Fnwa7TZnp5WdYXD2kHIBpVpOP4OCBuTd3DKYtvKqc4iUJuNBaw3zqr5OP8z1IDlCjN8IyUJhoTH/C+rpzyzGjUMB3MWdVB/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(8936002)(38100700002)(36916002)(5660300002)(7416002)(6486002)(86362001)(186003)(8676002)(4326008)(66946007)(6512007)(26005)(36756003)(66556008)(66476007)(83380400001)(41300700001)(2616005)(2906002)(6666004)(53546011)(31686004)(316002)(478600001)(31696002)(6506007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG1lSjcxRDNRcUZXazlFMGJSZW1uOTBNTWVkUTRpbmROSDRuSWc4Q1hieG1V?=
 =?utf-8?B?UkZrcHhpZi9iNVA0aGs0L0Y2RE5LKzFKaVo1dzZ4dmFsc2VrczRlL2dqanRj?=
 =?utf-8?B?SjA2TFpDa3J4THNva29MNnk3Y3NkdFBBT3A4RGZ1cDd6QXlHT1c2TmNPVElH?=
 =?utf-8?B?TnNsUXJoaVhSdFkvcWtSalZOWW5kSFdqODJoaFBCYkxta0dybUlPYjlXMDBv?=
 =?utf-8?B?MXhJR3NoUHFVcW5PaFMxWE5xOE5sdFZoZS9WTHNDaXZPVFpLQU51clZMTG1i?=
 =?utf-8?B?UTJIL29XTk4wQngrLyttQmVLbkxmd3lFMVBIQTl1NVUxRHV2dDdtdzJKVUkv?=
 =?utf-8?B?cDhFcjVTYmovQmgxNW1neUtFdGZqQzkwWUptL3gwcVA3Uzl2Ti9Tc3VzL2or?=
 =?utf-8?B?UkJnSytCNVVZWUsybEVGWnFiTm9OUU4zcW4wbTN4MElFMzNCbFBOdUQ4cnRy?=
 =?utf-8?B?b1B2bDNQL3prN3NwR2FXajRTNlQ4NFlzUkNRb0dBU21xR1BmMEFhWS9qQ015?=
 =?utf-8?B?Y1ZoNy9Oekx2WEFCKzYzUjhyUWlBd2g0REMwNTFlZUlRVGNONDRUTjhROFVP?=
 =?utf-8?B?NVM0WWt4TzBSc1BrenRNeXRuNnVMUEZlSE9kREJBandsd015YUd6bEJmdGl4?=
 =?utf-8?B?ak9kclc4T1dkdnAvWVFGYUpBMHFKUC9RcFlNdlVib29oMytHSUpNaFBVSFUz?=
 =?utf-8?B?YjU0NjJRY1RheTRRS3VtZ3BETU5JRGxybnFHdkduZVdHNlBXQlcybDZzT1g2?=
 =?utf-8?B?VjU2MTdzWEJ4VGd1d255N1d2NWJmMWFTV21ibzQzWGxONUhNRTN2dTg5Wm5V?=
 =?utf-8?B?VDFmc083VVNjRFVGc2t0cktBTnR2ZGVmeXduQVJ2Ui9uaDFmc3BORjlzTHQ5?=
 =?utf-8?B?WDY1dU1TU3J0bWZuSHlBNTRLOFVzK0xKcllpc0RwNGh1TU1xUzR2ZHZ6dmNi?=
 =?utf-8?B?a2wra0kvMTBka3FpdktzUHh0Nlg3VHB6dzdzbDVLc3JVblh2UTRUVnE3cW9h?=
 =?utf-8?B?ZkYxM3paM1IwM0xVYTZzUjBRM1F4NjVKSDVlV3pTbE9EWTBqZGdPOWRJWStN?=
 =?utf-8?B?QmN1S2F4RnloOVlHRkJtalUvVE9aTC9DN3dYSW9nMGc4SWYzRHY1Z0xnMWhK?=
 =?utf-8?B?MXNHempQMFZpL3JkSkVjN0FBVWZKSTZwYjMrZ2tpNWF0UDVwMVRhTG9keUsx?=
 =?utf-8?B?alpTWUovNnBXekwyUmVwblhjaUpkMVJpWE11bUVZRXZ1WjVENG80ZUp6WUFz?=
 =?utf-8?B?K0h4TnU4Q3NWaDRlbDVSQkVlalhIaVVlQ0RLMmNSZEZmdmVMMUFxNXlaVW9q?=
 =?utf-8?B?TEhNaVBjNHFyNmE1MUdGUTRZMWhWQjRwWE85MkJMRHRta1BwUmVYTGRHU2dC?=
 =?utf-8?B?c3pmQU1sK2xoYzA4aExTOVlqVVpqMHJaSm1pUFZRUVhRQnIwY3dub0dhcmJQ?=
 =?utf-8?B?c3EwZWNqQnBjRWdwV0JzUDJKV2c0T0dIdzlCU0I2MHp4SEFiQ0xPMHFoVmJa?=
 =?utf-8?B?OGlzQ3Bic3BGYm5DV1lhbWhIRDRjRFM2VHhOMXVPTEFIT2QyWjNwb3E4L0x5?=
 =?utf-8?B?TGZ3WjhnZFN4RUFXQXFNZWpHL1p6aFBvM3pHWWpyb2hrbVZDdkVURzN0Unp1?=
 =?utf-8?B?Nk9RL3VBN3JZSGE4dStQUTJJZHBoMG81cXhBYVFCdGZxN1NlL0psNUdZUFNj?=
 =?utf-8?B?NWVnUjFkRW1qMFhQVGJHOUVKSGZQWXNFYXY4Z3NXZDJwMHBjb095Qk1jNzdP?=
 =?utf-8?B?aGZaYW42ajhxRldKNmpoN3UraXBiM3dqVEtma1Era2NzR0hhSEd0KzdtNG1D?=
 =?utf-8?B?cURBNTlJSUZDTENiYmliMThLSi9KYnlONENwYnhtaVhRd2JmUUVlTmZvWVJF?=
 =?utf-8?B?Sndncmg3QklZU0I5UlJ5bDYrNWVhaHRxUnQ2STZNZUJtb2hmTmVlaFNZeURt?=
 =?utf-8?B?dTlDaWxLNGk2SUZWQUp0U0JNN2UrREFGeWg0MWdLblRwNzl6VmoxWlQ5d3gy?=
 =?utf-8?B?dzlGVVdNMDFnYVllSEpROWVhdWdqYzZaUDkwYXhFUDNiOWdGUHVScGZOUzFz?=
 =?utf-8?B?NGJIRTVkRU9NbG1qQkk5dTk5UGZTakhITVY2c3Nkc2FzcWs1ekt6TE5wUzNv?=
 =?utf-8?B?L2tZQkd6UGhFS0pncXFaNVZxYjFqaXBrSGI5WHFTcmtjOWs1WE1Fam9yRnJy?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52baf503-e775-47fc-e82d-08dae26647ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 08:43:34.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0BZFHqTSlVyxpBLPkWSEwXkkOftJo30Vit0Psi20du3mn+Rginw4Om8NllVn/qr606GS+MNJVlq6mMLI303Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_02,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212200071
X-Proofpoint-ORIG-GUID: aCAz3QWqSyXZqGoc_zZCJ4pCdMAfiHrQ
X-Proofpoint-GUID: aCAz3QWqSyXZqGoc_zZCJ4pCdMAfiHrQ
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 23:00, Damien Le Moal wrote:
>> But it is expected that ata_qc_issue() should be called with that the
>> host lock grabbed (and keep it).
>>
>> I think that the reason libsas drops the lock is because some LLDD
>> queuecommand CBs calls task_done() in some error paths. If we kept the
>> lock held, then we could have a deadlock, for example:
>>
>> sas_ata_qc_issue (has lock) -> lldd_execute_task() =
>> pm8001_queue_command() -> task_done() = sas_ata_task_done() -> grab host
>> lock => deadlock.
> That should be easily solvable using a workqueue for doing task_done(), no ?
> 

I don't see why we cannot just return an error code directly from the 
lldd_execute_task CB always - we end up calling scsi_done() directly 
then. But I am suspicious why it is not already done this way.

Looking at the code history, this fiddling with the ap->lock actually 
looks related to commit 312d3e56119a4bc5c36a96818f87f650c069ddc2 
("[SCSI] libsas: remove ata_port.lock management duties from lldds"). I 
will check that further.

Thanks,
John




