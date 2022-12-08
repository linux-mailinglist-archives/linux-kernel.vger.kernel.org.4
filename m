Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBFB64680C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiLHDzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLHDzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 22:55:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817988C461;
        Wed,  7 Dec 2022 19:55:51 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7NNiuN001431;
        Thu, 8 Dec 2022 03:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/cl3loVxRxhmeohQBPQIHn/095uNVZNUWs9lG1aE56w=;
 b=wn1Pu82FDL7/t3iDn2nTNzIJUfFGF+vYUtnA7XOw8hyVe/+kNLOMeKZCt5d5Xiz2ZPXu
 U8njC2VgA/DyS4ww61tJ+QmZSUj9J5rasUHDRvZ1T5RwPI94dLO4SUbZRCoN+xJBVYNr
 z2OoJSyeenVz6KM3ed6QAi8lGrXFH6wf+O4gXPK8OUN76WOu14GAqf4TwO+6FQwRDj9y
 jFPwRVUOdTcJoW9C/MKM8Dj33X6PRVYtM+bG2IJtO5IgskelMEsk6RwAUdEh4D5GQQ1B
 GMsv3Au5EqL2ah3gwhz5prpQnrO45NHUZ0ZrF7RBqs2pKFT0n0qPQRAASXgzqsxM2kb/ iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mauf8hvmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 03:55:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B82244m033806;
        Thu, 8 Dec 2022 03:55:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7xp0dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Dec 2022 03:55:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+gBqVaYV6kv7c4UjCcRZoCoorf0CpzJ5SI/suHKLom8pmSqQuoZa+HzboLWu16loOABGLrz4YczxZsfjQQUV9S5fncNRefRvIkLGvJzJkpYu/v+7q656EohMScKqjoN2ZLBLhOqQOQQq4ta5gt4lZybbFdNI4lRRz9DoMAjNZJjarZtKdn7ZRoHwbC72+VQtqBMEo9flIU5DZVYKZOF8uLdCtcPAoxP0LWJHXzn3+6HP/9pkfZoRgLefRrupI7uLZKzORS+jtqrp8q5Xc9BvYH5MKXwwlJL/llhKeAHXWGv8q1cO3AwA4cfAVCJ/5OIaVsOiA58HRLv8UYo9bKqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cl3loVxRxhmeohQBPQIHn/095uNVZNUWs9lG1aE56w=;
 b=L9l9rYlR73xWa2SL8n9T/c9V60vqUy8MT6PIJ+CrodPj8Y4/5FdtRNKdVm8lW9NUOXw9XvOKOD4xdayIAvwArS8zUBrZscraXAPAQE3e2Jc9bedMSMFYOntczQBXAOITx8pPTfFKtr5ucdvfqy9zMYxw8fEEo5gMATMTJ+1RTxipgzrVcBp/GYHxAVPpbKDHS4pFmbdciKnuXpAGIhuIvWFnXvdB6v3b+gImCp7XqJvV/Wh6uGlI3lvsrue7CncJMZBgV7M9evZ7UkoNEPY//f5q9Lb4gZp3fVfsEg4TqVtKr08289xgU7yp15+BVAqSuz0ff3dkK8YIF8FBbODXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cl3loVxRxhmeohQBPQIHn/095uNVZNUWs9lG1aE56w=;
 b=BIThIFDfItcmGCyEztT7BCy8zj1kMplfEBXFHCvj1AIm1hoPWMRJOebDiF3b18bPPz49bY9FqBKNWCIcinfKj5I6SE6e7c/z8ypREsHmEbwPTHxy6QJA7Cd/5EaEGH4/gfYWaIESpK2LHoj+sZ3VBCkpXmb3g+ow8L7yDjsB+CU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 03:55:32 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::2dbb:4791:5a67:4372]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::2dbb:4791:5a67:4372%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 03:55:32 +0000
Message-ID: <050e7458-c952-1b1f-a98e-6c12c5b30cdb@oracle.com>
Date:   Wed, 7 Dec 2022 21:55:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7] scsi:iscsi: Fix multiple iscsi session unbind event
 sent to userspace
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221126010752.231917-1-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221126010752.231917-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:610:74::8) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 84199ec4-a99f-48c4-3854-08dad8d00dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZTATfyec9qjCAAQ5GrO0VGI6yBUPYvUAS1ATyJ2LtWtJHjYGJjtjwGesrlVAkwbcKKczfpWDsKcGEFkFZaU/530JTymW/SU23/PbMCZszc5AMzrrgedwUyiuyuZvosO59shrMO7azCDjMJVjLl9Smcz3rdEVt+f0kZpiVLaG08EozzJPn0h6D/5cr1uw/OT2p5YIw81nUBTPFDbpt/cJYRr61g1ZaSGZwssSEPcndyis6HNZVuJVnqqZIiiTd7BHcIdD/xhatkTD2c5FHbdD/hxrYTZJ9IJzO+HXegDnH7C+kXB1B7Fm6NPkW/yc73dabBakl2QUqA9Qbif33+iyM9nT0Zc4vVfMIhKl8WDS3ZT8Vpe/jiNEtoMLGnaJP1mY7cpBrQlgC5oHaergJeS/CC1CJ87PjKMUgLTk/xU4w7igB9VqeTUC12jP8RZqikqOTWxdnn/slPFtwpYqO9r6VWyWs0YfBezc3Vs7Ev9q97Uyiytfj+crS2oFWazPDWkj9RTaijuRMqvD18ZBF9KayRQN7OwdpLFR7UhyhTYaaW7CM+9Z9cOz1JE13n2sPYTi+Sp2sSZ7eSbD0Z1LTUTPM0l0YZ9tDtHXMZssdHKBA1Z6QeauxdL4NcTed6DjTokPVW61IXeO1lW5nQE+3edJzArBX6XRAyZSaVT+XJFrcJQ4XN/g5QlGkYUYaQB4ovuW1vzLxgodSfPFy3v/vCXGJK4Fe5ytAb6P2iWj7JdeEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(5660300002)(8936002)(31686004)(316002)(38100700002)(83380400001)(66476007)(478600001)(2906002)(110136005)(66556008)(66946007)(6486002)(6512007)(31696002)(26005)(4326008)(8676002)(41300700001)(36756003)(53546011)(2616005)(186003)(6506007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R21hVUtiUmJaRFJYdFJENlM5R2R5QUJVN21EVElNeFNWWjkwdnF6RzBSOHpH?=
 =?utf-8?B?UzN6b1czdjRzemVEaTN1OHRlWHJMZzIxZUJQV1FNZ3J2STRrOGxESDZ5MXNN?=
 =?utf-8?B?RElNYTYyeTFxa3MwNThiS2h4OWo5dWlXMUFWMm14eFBUc3BKMzljWnBGZ2hH?=
 =?utf-8?B?V1RXUEVKZ3NXUmRobXlNb253TURWdVlLT1NORG9RQWRraEJ2bmQzUG5nVm5v?=
 =?utf-8?B?V1hXUnIxY09CSDJIaHk4VEVrdHI4alJuSklWN3prQnFROWkxZEd6M0YrZzFF?=
 =?utf-8?B?RktQYXdPTDFnR2tHd2tyaUUvWnprMXdKWUlwYnplOVg5by9PaktLSEZHdis0?=
 =?utf-8?B?WUtPYWd4MVI3Y1pMd1I3RWI1WnRlMWhoUUdBOVNBc2RuZUllNHZiVWdYYUh1?=
 =?utf-8?B?ZXpsTkNibmxyUXpPRWJ3a1QvdGtvaHdQR041YW42OVczUlJRMTR4ajQxVytR?=
 =?utf-8?B?aXN6dUQzNG1FQm9DYjFWeHplS2VKbFlnTlRiT1hqVlNlWVNQOEMzaUFHQ2dE?=
 =?utf-8?B?S3VRdnFmbWl6Mmh1Yi9DVjRQUUR0S3JZMEtUNGE2aDRhVGtPUWUyUnE5NEtS?=
 =?utf-8?B?SFFSbm11dW5RNUtZOXU4RUEwT1JqY0NKaGFaR1kyMHhCWUZGOGRJOFFpS2J2?=
 =?utf-8?B?TkYvWVpzeTRYVXJZSVVMbG5ReHFPWUVjRzFySFpYMUpGaXNETm5UeVdEdVlX?=
 =?utf-8?B?YjY1RUpabHFnMlJiQnRXLzRFMTBpRzBGNk1iOGI3RkdLODZHbHRJYlRxS0VG?=
 =?utf-8?B?SmNWU3dlSE81d0tVUVp5RTNOVGc4RFBBOG5NdHZIOVVjZGtjc24xV1d1TFRT?=
 =?utf-8?B?R1ZUdUxxb3dUemZYY1MzNjg4VEtEbzZ5eDFjTkNoYWZ2dXV0bndJcDlXc1I2?=
 =?utf-8?B?RkVQYXhwTjNkb1VBNE1CcFFLZlBxY09MdHZ1anp3NTBpVkNrdm5jZk02bXE0?=
 =?utf-8?B?MEhKcllrd3BiczdDU0tNT0dLSjFEdXNhRy9EN3BrQzJUakVZb2RxSHl3N21n?=
 =?utf-8?B?SHdiM01PQnltYVkxY1VCelZ0N2Irc3B6VEk3UXVTa1FtOCtySkZ5aUF3NUlY?=
 =?utf-8?B?R094bnp3LzduRzVlbTlWRUpSK0VrUzF5RytsaGJZWStibTMxZkVtVjQxTStG?=
 =?utf-8?B?S1dCV2xDM24zeVRqK2ExNE00Y2dSYTVRYkU4Z25IbWtaQWRodHRkRFkvWTJV?=
 =?utf-8?B?VktFTnpGMDBSVTB0elNWazNuelgzYTZuWWdZSDByMURCTzY3d3lDTFhIczFQ?=
 =?utf-8?B?UDFIaEljZ1dyVGVETTFoV0MwWVNCc09uY05kTFlvUTB3YnJidXJpMVRmZjc4?=
 =?utf-8?B?MzE1S2FrRDEzWDE3Z0NHRWN4YktzdnhFTXlHazVyaEJid09JSDI1aGhhRkRQ?=
 =?utf-8?B?WU0vVGhOY1dsK1JlN3k5MEo5ZUprdzhSQ3dIV1JhVENkcmQyd0puMU54UWxk?=
 =?utf-8?B?c09yUk1GRkN2QndZTEhhUXo3OGhENVFMVytidnlmK1UrZXJwZS9iUG5yNlM3?=
 =?utf-8?B?NTNHNWVhY0RIMkNNOStiRnFxWDEwbzNtTkErY2FBMnpKSlRnRm90WG5nVHQ4?=
 =?utf-8?B?Mm14MnFLZDUxT3AxdlpsUmVuajYwVGRnK0c5T3lNRTFDT05iUnpFSkJEVEU4?=
 =?utf-8?B?ak14b1R5TXpRQ2dDNTg1eXFibFRxT290NzlCbkplUzJYbDh2cTVvMmlWbGY0?=
 =?utf-8?B?dVVIS1lYMmJITTFvcUZTeVFuWU1Vb3hDMVRBaVAzaThMVTRxb3F3YTdKNWU2?=
 =?utf-8?B?NmV2cGprSmNnK0VXTFNBSHNrWnBrTS9CQW10OGJUdVlwK1BpbTFja1M4UzlG?=
 =?utf-8?B?bHNCbnVsVEZMWmNDeEJRb29wRTRxWEFEaEVyc2ZXbzRpVktHWWJLalU3MklF?=
 =?utf-8?B?OXRQZ2J2cUJXT2tvSUFURXUrVDZITTFWTWdoTW5JNnJmc3J5K1JEM29aOU15?=
 =?utf-8?B?eG9KcEMyT2I5aS96Z040R1pRVEJUMGliOVpKeXBUVXAvVjY4SGlKZExkSDdO?=
 =?utf-8?B?Nkk0ckhuQjlGbVNzTE9EZ1AvdVJoQU1lNGhNWDdObjdoM05pZEV6Q0k4Y2ph?=
 =?utf-8?B?aHlFeGFOenFkRjQ4WnNKaVdCM2JucDdzenRJalBlZDMxeUcyemVuQktVNDhx?=
 =?utf-8?B?aU4vcndLaG5TNGVReTArNC9rZTdLeWt3Nm1IcGx3azJvdlJhS0FQQnlpNVVK?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84199ec4-a99f-48c4-3854-08dad8d00dd3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 03:55:32.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFvhN3Y51MeC1AFSBTX3YZDZr+LAu+gionIMghPC1fY84/Y4yeK5Uf1OPYi9VzTJ/iO6K/XmZZzr+rNoLawH15nHRO3+v9rHevD/enpNycM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_01,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212080031
X-Proofpoint-ORIG-GUID: ZQjf0cLNkHA7qthGqc66tosRC01srCrI
X-Proofpoint-GUID: ZQjf0cLNkHA7qthGqc66tosRC01srCrI
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/22 7:07 PM, Wenchao Hao wrote:
> I found an issue that kernel would send ISCSI_KEVENT_UNBIND_SESSION
> for multiple times which should be fixed.
> 
> This patch introduce target_state in iscsi_cls_session to make
> sure session would send only one ISCSI_KEVENT_UNBIND_SESSION.
> 
> But this would break issue fixed in commit 13e60d3ba287 ("scsi: iscsi:
> Report unbind session event when the target has been removed"). The issue
> is iscsid died for any reason after it send unbind session to kernel, once
> iscsid restart again, it loss kernel's ISCSI_KEVENT_UNBIND_SESSION event.
> 
> Now kernel think iscsi_cls_session has already sent an
> ISCSI_KEVENT_UNBIND_SESSION event and would not send it any more. Which
> would cause userspace unable to logout. Actually the session is in
> invalid state(it's target_id is INVALID), iscsid should not sync this
> session in it's restart.
> 
> So we need to check session's target state during iscsid restart,
> if session is in unbound state, do not sync this session and perform
> session teardown. It's reasonable because once a session is unbound, we
> can not recover it any more(mainly because it's target id is INVALID)
> 
> V7:
> - Define target state to string map and refer this map directly
> - Cleanup __iscsi_unbind_session, drop check for session's
>   target_id == ISCSI_MAX_TARGET since it can be handled by target_state
> 
> V6:
> - Set target state to ALLOCATED in iscsi_add_session
> - Rename state BOUND to SCANNED
> - Make iscsi_session_target_state_name() more efficient
> 
> V5:
> - Add ISCSI_SESSION_TARGET_ALLOCATED to indicate the session's
>   target has been allocated but not scanned yet. We should
>   sync this session and scan this session when iscsid restarted.
> 
> V4:
> - Move debug print out of spinlock critical section
> 
> V3:
> - Make target bind state to a state kind rather than a bool.
> 
> V2:
> - Using target_unbound rather than state to indicate session has been
>   unbound
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>

Reviewed-by: Mike Christie <michael.christie@oracle.com>

