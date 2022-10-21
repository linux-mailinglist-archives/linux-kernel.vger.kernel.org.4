Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB69607D76
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJURYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJURYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:24:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EEA1400A;
        Fri, 21 Oct 2022 10:24:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LHOG9j025912;
        Fri, 21 Oct 2022 17:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=t8WX/aaSHI03R/7z1fz6EEGKaRmR4bjyY7YVSzl5QrM=;
 b=g0oHbfTRy4cMsvqsIrl7QssERdkXvabzSncUgTGksincjNr4VUKUsKe28A5Ka8tKnmSr
 Cdfe6n7pcC7c92egGZWWW6atpOE0dCZTVOCzcpfMT9gL906Yj9qavwNmd5q/CqJpsbH8
 kBC03IkT+ACe3896Hxc3pXOwBOhF5nhlSmd6mJzkKO1dgNyl8hjvunaRkX+Xht6mZoEN
 8avv7IorPTLZshvgFLa74fQ/nsdp2xlO/pxGB1NI59/kvhQBMy2C/N/+79eKy0Vb1kfc
 PJe7iXcVW4bPt+p2TEf1HCodghBO7ve4L/hOIHh52Tsj+rSX3DZulu6Gm8WRnIZ+3CmC LA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mu09brf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 17:24:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29LF7NHU027653;
        Fri, 21 Oct 2022 17:24:09 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htks66t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 17:24:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6tbBbArabKrKkmoC8t6tvNjzDbncxS6RoLrhknWe8XnVmc45eJ/9gwOa7Zkmc7T9pJotthlVUgwGzGoYJq3ZeetQ8LCwrblDTz1xfND7zWJbP4EqtASy7j54Gl4aEmqS9JFdgZo3ukxzrek+hesHG5dTU5Y1YRTos9+yP/bvNr8wIlGAa+sx1i1cz8wxe4yt2iLFozkPrbhjdIIUCrCuP5fOXYH0jUSZHadHx26PUe9iN5A8dWS1D6s4yg2IxN2f1IBa9TWkqD6LrhtZDNGKNcsZpxT0UyB+cM8yZoZ33rv4RBYItMUeGbMEKYnjIR/sevIOYRVYcBbWjISgphtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8WX/aaSHI03R/7z1fz6EEGKaRmR4bjyY7YVSzl5QrM=;
 b=gWH9p1mXuwmH7RzFGImebpZtjOSUWdHV98lg+6gYDtRZ2MxvONDTsTqrj5gWoKDyo/E7un7h8dwG5q2QDZ58p/k4RYVmvhQ1Nyj+WIxjskIb8h2CHyOYRmWgqUuEKmXWeNW+fuVN4h2KLTSgqJ+/ydzTwBK0xK2J6lk9r5K+akp+BUjADS0aEJ7Lz7oKAaEzypv7wqPwvszkgJA8rph3BGmkrPIuK9fRGKnIhWuFZCXeuOP7wejWG5zt6KVF7L07ARPrjKdZJRCJSPHFWySmA5DhXKIn2trB8qOZIGQXq67VhRw8RL0gL3SfDyYZE7Ysomi9Oi+tKVhhw5h2UdzAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8WX/aaSHI03R/7z1fz6EEGKaRmR4bjyY7YVSzl5QrM=;
 b=TzLLNWITpB3UO+SOS6+JZQNGT6EUOzhdZ9xMOGNXLABgWSxskuQwoQpCI9fh95wGkbh9AlsdWxOCOAo595F30HqVmPOs2oKNLGBfIb1fBIQ8PbxKxEWJeOsI1C6AL6bvoabPTX7LUKvbUGWBLNgXRBqw9EkI4bAkJaBehn7KPwY=
Received: from CY4PR10MB1463.namprd10.prod.outlook.com (2603:10b6:903:2b::12)
 by BN0PR10MB4887.namprd10.prod.outlook.com (2603:10b6:408:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 17:24:07 +0000
Received: from CY4PR10MB1463.namprd10.prod.outlook.com
 ([fe80::4461:1868:14a:fb2d]) by CY4PR10MB1463.namprd10.prod.outlook.com
 ([fe80::4461:1868:14a:fb2d%12]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 17:24:07 +0000
Message-ID: <daa60cf0-0dde-ea2d-211a-70a9e0efc1b8@oracle.com>
Date:   Fri, 21 Oct 2022 12:24:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Maier <maier@linux.ibm.com>, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221021235754.1968981-1-haowenchao@huawei.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221021235754.1968981-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:610:118::31) To CY4PR10MB1463.namprd10.prod.outlook.com
 (2603:10b6:903:2b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR10MB1463:EE_|BN0PR10MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: cae3d5ee-bead-47e7-e1ce-08dab3890ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jh3kiQ4yk73D3g/uo5ZlnYYjA/ZYbGtqKOElCVPp5Az3J1iB0aeUi4HWqndHL9ikED6dNb2yy3xFU1bYJjNQmhuu2w13A1668GEIcJHfVFyIMXKkW3Gh300DlzCNnvhPnHx3PdKh8CfeduvpmciSgordDAAtx/S8G7bxisRQxSkRDPtFhMH1Y9B45zSFqFOAc5O8eTiqGLGl/VbART6dO8Vg2k4+UWL0L4oh8Hf3A/4HBvqH9cauwYnCgw4PZHvFiAb0X1Gmg/BZgRvbA+fvVJlDJi2hdB+ohCHqGj7HbNrB/4BX8Ozc5ff3Oejom4ikZDeor8X/lr2h3BWT6kg2VCEz8i7hzqf+Y6ZVrVAQHy+oMQQ8UHz9MH4jox6hK7VBFElGSfqovu3I6uSDCZa4USgFPehPHAJCsB+KA68Yll86izbyctcC+bto8NFz5+Kp1QB9VmQEKAmQp6z+WjKcehkoGlJbKKKbwItnMTNzRPTAW979UACbPu95WuXn0JyjVzNkrYQlVvexc+cDP25ZriAQtR1piZbsflOINbRElIW/kZR7XrWP6CFp88xEueRAQ37jHAcgKLrR44cKMj7KoW+GyqQREm5DLtny3CDVb5gyHE2++AnFNCfXswJo+qqYVNUdDHS+ldigh7I4k5pTrzGNzCe95OUrjO8iGsWVAIferGUWSrLi3h/ZkLrtJr51iq/mdIwEo1N/RKo5ySKKRUJTKjmmn5WiLfPyzUh4g069gyXTiR7vJVlvSN0Rh850iEViALYevlqBTq6soeF1C8DpqVJ/za+3S0uAelIcDtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1463.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(6486002)(86362001)(6666004)(478600001)(110136005)(316002)(31686004)(5660300002)(6512007)(38100700002)(8676002)(4326008)(66476007)(66556008)(66946007)(26005)(83380400001)(2906002)(31696002)(36756003)(186003)(8936002)(41300700001)(53546011)(6506007)(2616005)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjliZi8xOFBDSGlPREFsR1hRTnd2ZVFxSm80dUlsN2psYms5VnVhSmtIbHQv?=
 =?utf-8?B?VUJkR2cvM1paaEVzRU1VYjBldlBiY0Q2QU80YlQ2UTFjZ2pPTlc5VEZoQTB2?=
 =?utf-8?B?UWJ3amtxNnpPajhNR3JWaksrbklid2ZRUDJneEJDWDcrTk9sTlNXd2grNnBK?=
 =?utf-8?B?NVQ5RTRlRWg4b3dldmljRExBVFVLaXAzdWxuU0ZVdU54Z2RhbGs5K1lMbnJx?=
 =?utf-8?B?aU9SbkdVYThiY0JqOHFTSWdXcXZSdzhBS2YxNmkvN2M0RkpyT3dsTStwUDNF?=
 =?utf-8?B?SkpaenVCNitIU0lwNWxlYTN0VUVKelJKQUR4S05jMG5MRm50YzZLVnNoa3J1?=
 =?utf-8?B?R2NlTE5wOTZMYlZPT0ZFdVFpTE1hYkZET0tiRVNYOXpIN3BxZXVjbzRYVVNZ?=
 =?utf-8?B?aHJzK012NFZNbkJRMUJDYkRkbi9ZWlFFeXVpVWVycHJxTEhuaXVNV0k3QUFx?=
 =?utf-8?B?dm9oWi9mNlVrNktzSzRnSFBpUkNPeEFvUU0wMzJSVlpWVzJWbzNQSitJc0JR?=
 =?utf-8?B?dlVTUUdsYUtSdGwrVTF1SGFTcUx2SDd1RVBhVGx3OGx3Q0V4eFF5UVRSeVVZ?=
 =?utf-8?B?SDZkTGJGSDU3dEJKN0NCNzNxNENwRnFvL2lEczM1SjlXQ08zWVRsVWdkbFhJ?=
 =?utf-8?B?eU50cUxTTHI3QmRqQ1hQRCtQbjhvMjdpdjdKbWhpTlBWU3ZGWnN6RGpKWUtW?=
 =?utf-8?B?d3lBZGRDcVU0WlZhZlRhK2szTXU5Z1pmYTNHT1hycktRMEp4UUU1WUh6TkhP?=
 =?utf-8?B?Umdpbnc5cU0rRzhhaUdhejlrcEZUZ2ViRHNnUGN1VHNhTXJKZXlUZGVMbGtD?=
 =?utf-8?B?bDVYa3J2bmlaUzRyTlRZY2xzM1gyYkIyYXNJOHZuT3gwK1lKd2V6T00wemdM?=
 =?utf-8?B?SEtYRXd2MmtVbWs3bnFjSm9neUQ0cEh5QXladzdSZXVFTytQSmZtdlpiMUp6?=
 =?utf-8?B?d3dtYUNUbEFma1cvSEdWR01OVmdZTXN6L1JGWmFPUjVWOFhESTZTekpkQ3FZ?=
 =?utf-8?B?M2FnclZyYVluVjdPRGRiQTRUZ3NSUjlQUTU5QXRzKzExMHByb1Y2NGZWRlZs?=
 =?utf-8?B?UW1zbkpzNnFmU1BiMzhoRGZXMVZMZEErS2Z3dzZhYmVHR0s0NzNVWURwNkZk?=
 =?utf-8?B?ZDV4c2xBWXd5QytPbTRDN2EyZW5ka2FMSk9lbko3U2Izdnc0NFJaWEhxWDB5?=
 =?utf-8?B?Vk93Ni93VDU3MkZWWjNwZjBieEtyaURqSW9uN2VZNjRiaEpZTHlpQnEyb2tk?=
 =?utf-8?B?ZWdNUUVSN3N4NE41cXF0dkxRQWl3bkFqNzdvbUFNNDRjZGxCRm1xOXJJZ21Q?=
 =?utf-8?B?Q1RvcE02c0tobjBDV2pWc3Ywc1hzNjlCaWJvbDl6Nk5KSzZCYXAvcVpsZ29H?=
 =?utf-8?B?cEhmOG51b1pEWStqekxGN24wWUNlMTR6dmVKN21EQ3QwbklmUXM2azZzUkZn?=
 =?utf-8?B?WjFyZ3ZPNGdpeE1aK0V2UmlKS3VnVDlLeUFqc2hDaHo2eGFtMTZEaFF1WWFM?=
 =?utf-8?B?Tnp2YlRBZzN1cWhvSHp0bkd1ek1VNy84SzQ2ZGlORnh3ZXdHMEVBUkJEd3E4?=
 =?utf-8?B?VEptRGNScS9xWlpoSmNaWCtrSDA2TGZpUEFqWTFJdDhOTjFqZ1h1a3gvc1cr?=
 =?utf-8?B?YW5NZWdMRWNiUUhMdUZ4aVpvQTRVemNGVnVpb3ROWnhsYU4xYWMySnNOZTQ0?=
 =?utf-8?B?cEUrcytoT2tocFFtL1N5RWpVRnh6L1NNMVpZbDBaNWdFbXdEb0R1VlBlNDlK?=
 =?utf-8?B?Snhydk9yMkdWNjVaTzhySjBzMUo5R01VWEh5ZlF0b242N09SWU9UcDZkZ3Zy?=
 =?utf-8?B?L2R5Z0FpMmRpbVJKUTJ5Tnc2eWFWdFEwTGswMWdZeHNLdmVRQUllU0VsZ3Jy?=
 =?utf-8?B?UEIyVk9HcUVqczB1TDJpS1psZk5EVFE4QUtsS2lKbG56MlBlRWJDZWhCckF6?=
 =?utf-8?B?QW13bGwzb0liazlKTTNEd012T0hEaVlLaDFseC92ZWRvV2t0eHhBbmZYOEQw?=
 =?utf-8?B?alRGQnpISmg1cm5aK0Zjb3l6RE9kTFd5Q1FzMUZXNlRKUDUxelBEUTQ0c041?=
 =?utf-8?B?dnZkWThndSt5dmFyWTNIU1VKT2I0aEdPRXBGMHlKK2huUUdOZ3BmV3puVEI0?=
 =?utf-8?B?dTc3Nml6SmFGdVBhMG5iOFJYWUdFSS9aQWhWWURWSDFOWWRiWVRIQy81QTFB?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae3d5ee-bead-47e7-e1ce-08dab3890ed3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1463.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 17:24:06.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SK+JxeIfrPwBiUtZlXBLHp2pZqYC4DWrggcpC7WSBeeCuFbsxwdzWGvnoSRmhUk+PhzeRzPg3TnMqr7eLMLPQZWlmzlIfEqcyRqNQ8N7ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210104
X-Proofpoint-ORIG-GUID: q49RswqqX8zN4nByB5r4Y1MjDmtf1IpD
X-Proofpoint-GUID: q49RswqqX8zN4nByB5r4Y1MjDmtf1IpD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 6:57 PM, Wenchao Hao wrote:
> +
>  int iscsi_session_chkready(struct iscsi_cls_session *session)
>  {
>  	int err;
> @@ -1899,6 +1922,7 @@ static void __iscsi_unblock_session(struct work_struct *work)
>  	cancel_delayed_work_sync(&session->recovery_work);
>  	spin_lock_irqsave(&session->lock, flags);
>  	session->state = ISCSI_SESSION_LOGGED_IN;
> +	session->target_state = ISCSI_SESSION_TARGET_BOUND;
>  	spin_unlock_irqrestore(&session->lock, flags);
>  	/* start IO */

Hey,

Sorry for the late reply.

For the initial login we have not scanned the session above, so there
is no target yet. If iscsid is restarted at this time, then iscsid wants
to sync the session and also do the initial scan.

To handle that case and also better match the state names with the
session's target state we can:

1. Move the above line to iscsi_user_scan_session after we have scanned
the target.
2. Add a new state ISCSI_SESSION_TARGET_ALLOCATED to reflect we have
allocated the target_id, but not yet scanned.
