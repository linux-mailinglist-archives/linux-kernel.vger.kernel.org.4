Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A22611E11
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ1XYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJ1XYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:24:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C77248C94
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:24:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKxKAX008251;
        Fri, 28 Oct 2022 23:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/tV5QnusK+CJ8bRfST3G/eeowqZuM/c9bBN4DmU7Fwg=;
 b=xoyLwog7Q8JGD5qFgu5mmAekRS4vcqlP5jEU9QQfolY5jGlk/i2BLZM0bNk2IKp46hyS
 vbkavpFNlIpdmieInT4Fc6n4/TH7qLyhGTC9/MDr8t086gOsb1nDkxke4vWhMk9FT3sr
 4D9ebqSZJWYAiMTSl5NHPHjoJNu1UnJuFKUwd4kWIPFDXQsfMOJN9oqTRRIo1RbOmvdN
 vZyS9FdcCLYzd7E0cXx0pHS7a/QJNTG4KgsVmBlT5Udoo/cz3qKDiepBPyQZXhFBYrnG
 W+DI1mc5DPtAWaysrA4NovOSYjoAEr4zjqDFoHFLxu8cf2ZlhTgMVJdngFS+ofN2vUie AA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7x383-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 23:23:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SKjRUL032561;
        Fri, 28 Oct 2022 23:23:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagpjfek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 23:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkkrzoStHLPj/Q9kCVJLpnEWXn+C1VxLc7aF0BY4fz/M/pMrPOjypleKS0Yb9+xeBvC6/4s5SeE+1st899VFJ7YCqh2KsXKzGM/PErkLnkb9VPFgt68Ng+eeTyD2BVjJpWytCYrQ9XiAD/WcfFgEOrrYr29+eUj88H7mpffY+GGD/wSkgyvQYbLClu1xxW0kB8uQD6FRC48k1ImM+vnTlI5zLKEy6OUM/qm5G2LAewoMHXr0VtytZWcEZUBYzjlW49kV0lcN/HJPX2nZUGLKznmUNC4pkaA1v3U+DHpFK3hznPISbFd6hfvhAabGX50j3xBbZyek84CZ+GzrXJKDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tV5QnusK+CJ8bRfST3G/eeowqZuM/c9bBN4DmU7Fwg=;
 b=Zfl9QgePsu7y3DtCE4vDrQup+oPCvFu0AdwCoA8OWDH7W0k9Y/OzL35RmEmU18+3JfBrhweYep2cYMe4WATEBpOapeJ4uM0zG56GrSa7bS5gGDCxoMznqaTXaPxqJuK+NNstDE7VbSxLU7kOK5+dHjXAPjShy9JfcMLo6aUZsQ4hQlupIbf+wosCNXdTmxQxSVJOChQApUbqvaEVDkJEQ8AaTYBOC4zcZ/qhMQcwlxLtKc7Jt0+1Q2caJ0XvQ0yOTZDfnn1kqH0lEAik7IO1jrGeVGdZMff3n4zW/C8QS5m1brU/3iY06jdiBghpG1U9qoYJW4dgVq5YUeX2F7pTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tV5QnusK+CJ8bRfST3G/eeowqZuM/c9bBN4DmU7Fwg=;
 b=fcVUtmv4SH5gRxEjomSYvSQpHi/N49paPNUtwP/+3MhbbV1MWgbAo7bPAVWc9Himx7SgBR+91Q1hG79y0YZh9jcVbhZHMBlcK9FsZOE2n7jfBlw6NGtq1cvz3s39S7Xt3MqoDnHpD6O9flOE1pF2SCkP0LmESbc96OWZslCOxKQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM4PR10MB6159.namprd10.prod.outlook.com (2603:10b6:8:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 23:23:55 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9830:ae4d:f10c:c30a%6]) with mapi id 15.20.5723.032; Fri, 28 Oct 2022
 23:23:55 +0000
Message-ID: <e8cccd09-e0f2-b166-54af-96a17c57855c@oracle.com>
Date:   Fri, 28 Oct 2022 16:23:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/4] vdpa: show dev config as-is in "vdpa dev show"
 output
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
 <1666392237-4042-4-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEti0Z2_sqJbBh_bOVq2ijSUJ96OPS-qd+P4bV490XAA3w@mail.gmail.com>
 <5b9efa3a-8a82-4bd1-a5b4-b9ca5b15b51a@oracle.com>
 <CACGkMEsEN+BMJkAk4YRkatTLnW8nmnZM8d_wzSwgPM0nFfh=Kw@mail.gmail.com>
 <25a18d7a-ebae-3647-32f0-14ad733118be@oracle.com>
 <38b9648b-8795-5b41-b06c-d13a1a6d5d3f@redhat.com>
 <ab5d903e-f78f-d304-24fb-de7ed73f1c55@oracle.com>
 <CACGkMEvJGfYRY5kF1WWKfT9irGLt8jfVK42g1Bp0UJWdMo_RAQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEvJGfYRY5kF1WWKfT9irGLt8jfVK42g1Bp0UJWdMo_RAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM4PR10MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f7266e-47c2-43a0-2b7a-08dab93b7b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 719HPMEGM3715EPJw28zHMhZInWHTWrw9+JNI6l+cgUt0+XxTcy6qIGuo6g45dALcTkcGHNK+ZCAm36tkH+GyDXwABZ3mzVpsO/USt0qt/KOq2RPW+qd0nZk9ECB57AeS/38CM9VqAUh3EJX5o1ogzJZB//T/Jh93i0OrLN0TAlJa9RiZ2S9Gm2ObO4X/Yhh8pN/EBToLPQ5eS0b4BhtZoSBazf9CxKnZ3Dzt06s9EmzoI/ywOF6Cw8klJVjgH2P5EYopnrT055iHL15r2TtUPRg6+N+1a/0g/3rBHcrDRcaAygKIv2mhDZBv3sdROCkPnnRWdAxYIZZhxLbLotsLRcZ4BziTN/7zPIs+FuRHZmmwPcan/75HPfoNxRA5KWFcGdXNxcp/Xf0p8UCLfXNrdzcOHNJIfiYvUB0HBUcVWoM5E8/Sp3MHj6JiBSY7Xw8UssLlUdMed3VTvOrzsS/lpYBGXDscjL5SJGmpHYWHGauP4nIXpEC3yfGZxvxOHs71iUSjIUVIfLh6dxwF5MyjXimDjAoyjwJeOVGacztvKtsuBHQj8R89w0tbVsCTADzB3iuzR78J8FuEoKC/MDawl0ABV81bevTwO8SDZls0a5hBDjdEFtaOjgyCF1oWO5Pdtw+DTr+50GYuAyd5Ri8+fCzL/5Hor1eMv1wFP7vccFznjS5QdY8rTurTJAfzDGr/D0v1DfAM4FAc85n5TaR7LzBKLioX7pNfwR7IkYPDcabr7vM4zc7STxWy0zDuZvivnm/ftcAJ+sqY+WM5Stni5tDpEjx5TOkqcUp6Psrvp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199015)(66899015)(478600001)(31686004)(2906002)(8936002)(5660300002)(36756003)(41300700001)(66946007)(83380400001)(6486002)(110136005)(316002)(66476007)(8676002)(4326008)(66556008)(6666004)(86362001)(6506007)(30864003)(2616005)(186003)(38100700002)(6512007)(26005)(31696002)(53546011)(36916002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDBKWTdjUENBbWQ3M1RFa0p4dEZwNXoxVGswT1FKd0NJcVBjZ1hUTlI0ZnRj?=
 =?utf-8?B?WFJXUDZUVGlnWWd0TWpvYllYMURGNm1wNUZrTjRnUjhQU3ZDcVpyNVNQYit4?=
 =?utf-8?B?YnpESlAzeUZuUTVhdjkranlDa3M3b0piajg4d2Z5QlZqUk83OElJOWVTcHVO?=
 =?utf-8?B?dTMwR1NxSVFjNmtudUxFTTlJWDk5OGZhZ0k5dHZBeVk1K0hXS2o4UXkrUldP?=
 =?utf-8?B?cG1VRW1ZUFNGT25vUnNWMHJraC9aOUhCanBFenJHODJWZ0hhbWl0WnoxaHlo?=
 =?utf-8?B?NUFrVHhtVm4zWlNITlRUWGVxSmxHNjdFbG9SSk5XUk55WHhEQmxTYVVtN0NC?=
 =?utf-8?B?NVJSclcvRUxLY2ZJUzBEQUFSbno2VkZOSmtNRDluUWdocFQxZHgzVkpEUk1O?=
 =?utf-8?B?aG1ibUY1Z1JmV0pSYVZqZ1NIeWQxRytmZ0hFR0FiYmhrM2ViRFlBWUVwaUgr?=
 =?utf-8?B?d1hJWldIY1BrVXVYaUNkeHU3QXhLYUVNamNwVk1NYXk1d0psSEpBbVpKNTNW?=
 =?utf-8?B?UEZKWVRsUjBVamxuVHc3SGk4aWZlNHo0ZUpJTEJuMmpUU1gzTXYrTTB3V3NZ?=
 =?utf-8?B?YVAxT2lhUUUxcFBLZUg0d3NqdU11MFpYc05ieXFpREpWczNFUzdmU3JjbHlC?=
 =?utf-8?B?WktuV1UzTVNUZ2JidnpJR1d3UmFxK2kxVWhEeE1yZFlRcHAvVk5RWVRPb280?=
 =?utf-8?B?TGRqOG5PM3NISjNOQlVFOG41SlQ2Y0pqWmIvMXlFWkRVWitObHVPWisyOTVD?=
 =?utf-8?B?SStIZmMydDVqTWJSbjBJb2k5T0FROWxUYmd6NUQ0U2s4SDZPM2VZY2ZKaGE2?=
 =?utf-8?B?UTYxbWdFbFBDMHlqa2phRG8wYUpUbHRoYnl2eFBVRUJiTUxWUGd3TkdrYVZQ?=
 =?utf-8?B?ZThPUDQ3cGo4Q1A5LzBOZUpXcE5HWG1FdTIxYk95YjU2bHlMVFR4b204ZzZ6?=
 =?utf-8?B?SGlYWEpZUmVjRExDQ1Q1NWpwZDlmV1g3N1pGa0EwNHVzcHJ2WWNjNk5CMWxV?=
 =?utf-8?B?RytJUURaVThDMXFvckpOYUdOLzlyRllUdlYra3hmazg5aHRpbjNmQmsyeFFa?=
 =?utf-8?B?YkJpWEo0NzhwcEVPVzVoZmRPZjFzR0JmL09oWlZDNmxma0hhK2hhQm5mSnMz?=
 =?utf-8?B?eFNKV0ZYbHZSeFllQzlVNlJKcTRoTm1MbDJRTDlHRVJYbENqMGV5SXF3Sk1D?=
 =?utf-8?B?OGVVSlVFaE5HTEQzUnNRc3JYTGFzZHJINWRwOHFXa3ArbnRjVzk3YU12NllW?=
 =?utf-8?B?d0R4ZVlBYXc0ekNoWmNsL1Z6TUYyQzlRSFcxQXJrZ2trcmRRekd4UVc5MXg0?=
 =?utf-8?B?amlDd1dWTnVaRC9sSVZ3QkdvMFQzSDlNTE0yYjEvT0cwQ1J3ZFRmWmgvTlVU?=
 =?utf-8?B?UThhNy90ME1oVmhuK3BjR1pwTVVVb2xwMXRMdEVoeEFDNFBhdzlMZEhYUFdE?=
 =?utf-8?B?aVF6eDdqU1VSSHo5L0Zadmo0cjJnektoNThyd2F2Y2Q1ZXh1b2o1alcrejRT?=
 =?utf-8?B?WWM2TW0wZ1hhb2V3bGpqTmY5dzdwZjVsa2o1bmlVRFBsbzQ3aFREUFJtQnpF?=
 =?utf-8?B?bmZXNzFkOUNGS0lhV1g1Q0pRdTdsNDlFU3d3a0d3RkZadVZqdFZkMmVVaTVQ?=
 =?utf-8?B?SnBZeDQ4OE8wRFR0YjFoYjBtUjBWbGRDd1k2Y2FXODVnYXBydisvSndsbVpI?=
 =?utf-8?B?ZFZ4L0dhNEtNMWNqZFM0UU1QVTNEVVk2eVRsNzVwai9tZEVMV2VOYmRsb2FC?=
 =?utf-8?B?VTg2TmY1dEtUUWNGT3hueHptQ0R1dDYzRDJRakNKTmpxbUpCYm5weEpYc2xY?=
 =?utf-8?B?dGFxUDFEVHk4TnhGU2x0Nmt0ZEdEa3JxY2RpRXFUWStFLzFncDVCSTExdURr?=
 =?utf-8?B?Y2VGcGNBUmlWSCtvMUlHRXdQOG5DZzZoc0ZhTzEvWjBTeTZOS1Q4QTB4NG5G?=
 =?utf-8?B?SCszaDFiM3JIVzZsdXl1aTExRWJxUWgvTmpwMERwaXNiUy8wcGtPWVc4MlVU?=
 =?utf-8?B?OTNvT1lLL2VpbzJqYnhjbVpLQnZrTjBCWTlWYVExdllORVVYUkRCNzFQNng0?=
 =?utf-8?B?a3pyaDUvY2VaQmxzSTkyQk1oUFRoQkFYS25tK0JhVzFWTVZxTnBRT2NrMnZn?=
 =?utf-8?Q?OsWVpCaP34FQQlCsRHk4hZDqM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f7266e-47c2-43a0-2b7a-08dab93b7b40
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 23:23:55.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZARugXh8fRExZLGwyb+0qkp7PI7UcO8n3cArTkTAWDMS0CBckq3U7r3pvyzSK2DAsA3m2on6nP9BZvH89wVjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280148
X-Proofpoint-GUID: DKv4o75fQvOgX9JvyF1k4XfdHwDOmwUO
X-Proofpoint-ORIG-GUID: DKv4o75fQvOgX9JvyF1k4XfdHwDOmwUO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 1:47 AM, Jason Wang wrote:
> On Thu, Oct 27, 2022 at 2:31 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/25/2022 9:44 PM, Jason Wang wrote:
>>> 在 2022/10/26 09:10, Si-Wei Liu 写道:
>>>>
>>>> On 10/24/2022 7:24 PM, Jason Wang wrote:
>>>>> On Tue, Oct 25, 2022 at 3:14 AM Si-Wei Liu<si-wei.liu@oracle.com>
>>>>> wrote:
>>>>>> On 10/24/2022 1:40 AM, Jason Wang wrote:
>>>>>>> On Sat, Oct 22, 2022 at 7:49 AM Si-Wei Liu<si-wei.liu@oracle.com>
>>>>>>> wrote:
>>>>>>>> Live migration of vdpa would typically require re-instate vdpa
>>>>>>>> device with an idential set of configs on the destination node,
>>>>>>>> same way as how source node created the device in the first
>>>>>>>> place. In order to save orchestration software from memorizing
>>>>>>>> and keeping track of vdpa config, it will be helpful if the vdpa
>>>>>>>> tool provides the aids for exporting the initial configs as-is,
>>>>>>>> the way how vdpa device was created. The "vdpa dev show" command
>>>>>>>> seems to be the right vehicle for that. It is unlike the "vdpa dev
>>>>>>>> config show" command output which usually goes with the live value
>>>>>>>> in the device config space, and is not quite reliable subject to
>>>>>>>> the dynamics of feature negotiation or possible change by the
>>>>>>>> driver to the config space.
>>>>>>>>
>>>>>>>> Examples:
>>>>>>>>
>>>>>>>> 1) Create vDPA by default without any config attribute
>>>>>>>>
>>>>>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0
>>>>>>>> $ vdpa dev show vdpa0
>>>>>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555
>>>>>>>> max_vqs 9 max_vq_size 256
>>>>>>>> $ vdpa dev -jp show vdpa0
>>>>>>>> {
>>>>>>>>        "dev": {
>>>>>>>>            "vdpa0": {
>>>>>>>>                "type": "network",
>>>>>>>>                "mgmtdev": "pci/0000:41:04.2",
>>>>>>>>                "vendor_id": 5555,
>>>>>>>>                "max_vqs": 9,
>>>>>>>>                "max_vq_size": 256,
>>>>>>>>            }
>>>>>>>>        }
>>>>>>>> }
>>>>>>>>
>>>>>>>> 2) Create vDPA with config attribute(s) specified
>>>>>>>>
>>>>>>>> $ vdpa dev add mgmtdev pci/0000:41:04.2 name vdpa0 \
>>>>>>>>        mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>>>>>> $ vdpa dev show
>>>>>>>> vdpa0: type network mgmtdev pci/0000:41:04.2 vendor_id 5555
>>>>>>>> max_vqs 9 max_vq_size 256
>>>>>>>>      initial_config: mac e4:11:c6:d3:45:f0 max_vq_pairs 4
>>>>>>>> $ vdpa dev -jp show
>>>>>>>> {
>>>>>>>>        "dev": {
>>>>>>>>            "vdpa0": {
>>>>>>>>                "type": "network",
>>>>>>>>                "mgmtdev": "pci/0000:41:04.2",
>>>>>>>>                "vendor_id": 5555,
>>>>>>>>                "max_vqs": 9,
>>>>>>>>                "max_vq_size": 256,
>>>>>>>>                "initial_config": {
>>>>>>>>                    "mac": "e4:11:c6:d3:45:f0",
>>>>>>>>                    "max_vq_pairs": 4
>>>>>>>>                }
>>>>>>>>            }
>>>>>>>>        }
>>>>>>>> }
>>>>>>>>
>>>>>>>> Signed-off-by: Si-Wei Liu<si-wei.liu@oracle.com>
>>>>>>>> ---
>>>>>>>>     drivers/vdpa/vdpa.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>>>>>>     1 file changed, 39 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>>>>> index bebded6..bfb8f54 100644
>>>>>>>> --- a/drivers/vdpa/vdpa.c
>>>>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>>>>> @@ -677,6 +677,41 @@ static int
>>>>>>>> vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct
>>>>>>>> genl_info *i
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     static int
>>>>>>>> +vdpa_dev_initcfg_fill(struct vdpa_device *vdev, struct sk_buff
>>>>>>>> *msg, u32 device_id)
>>>>>>>> +{
>>>>>>>> +       struct vdpa_dev_set_config *cfg = &vdev->init_cfg;
>>>>>>>> +       int err = -EMSGSIZE;
>>>>>>>> +
>>>>>>>> +       if (!cfg->mask)
>>>>>>>> +               return 0;
>>>>>>>> +
>>>>>>>> +       switch (device_id) {
>>>>>>>> +       case VIRTIO_ID_NET:
>>>>>>>> +               if ((cfg->mask &
>>>>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) != 0 &&
>>>>>>>> +                   nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR,
>>>>>>>> +                           sizeof(cfg->net.mac), cfg->net.mac))
>>>>>>>> +                       return err;
>>>>>>>> +               if ((cfg->mask &
>>>>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) != 0 &&
>>>>>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU,
>>>>>>>> cfg->net.mtu))
>>>>>>>> +                       return err;
>>>>>>>> +               if ((cfg->mask &
>>>>>>>> BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) != 0 &&
>>>>>>>> +                   nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
>>>>>>>> + cfg->net.max_vq_pairs))
>>>>>>>> +                       return err;
>>>>>>>> +               break;
>>>>>>>> +       default:
>>>>>>>> +               break;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       if ((cfg->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) != 0 &&
>>>>>>>> +           nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES,
>>>>>>>> +                             cfg->device_features, VDPA_ATTR_PAD))
>>>>>>>> +               return err;
>>>>>>> A question: If any of those above attributes were not provisioned,
>>>>>>> should we show the ones that are inherited from the parent?
>>>>>> A simple answer would be yes, but the long answer is that I am not
>>>>>> sure
>>>>>> if there's any for the moment - there's no  default value for mtu,
>>>>>> mac,
>>>>>> and max_vqp that can be inherited from the parent (max_vqp by default
>>>>>> being 1 is spec defined, not something inherited from the parent).
>>>>> Note that it is by default from driver level that if _F_MQ is not
>>>>> negotiated. But I think we are talking about something different that
>>>>> is out of the spec here, what if:
>>>>>
>>>>> vDPA inherit _F_MQ but mqx_vqp is not provisioned via netlink.
>>>>>
>>>>> Or is it not allowed?
>>>> My understanding is that this is not allowed any more since the
>>>> introduction of max_vqp attribute. Noted, currently we don't have a
>>>> way for vendor driver to report the default value for mqx_vqp,
>>>
>>> I think it can be reported in this patch?
>> Yes, we can add, but I am not sure whether or not this will be
>> practically useful, for e.g. the same command without max_vqp specified
>> may render different number of queues across different devices, or
>> different revisions of the same vendor's devices. Does it complicate the
>> mgmt software even more, I'm not sure....
> It depends on the use case, e.g if we want to compare the migration
> compatibility, having a single vdpa command query is much easier than
> having two or more.
Yep I agree. I was saying not very attribute would need to be inherited 
from the parent device. Actually attributes like max_vqp could take the 
default from some common place for e.g. some default value can be 
applied by vdpa core. And we can document these attributes ruled by vdpa 
core in vdpa-dev(8) man page. Reduce the extra call of having mgmt 
software issue another query command which actually doesn't need to.

>
>> Could we instead mandate
>> max_vqp to be 1 from vdpa core level if user doesn't explicitly specify
>> the value?
> This seems to be not easy, at least not easy in the vDPA core.
We can load these default values from vdpa_nl_cmd_dev_add_set_doit() 
before ops->dev_add is called. I can post a v3 that shows the code, it 
shouldn't be too hard.

>   We can
> probably document this somewhere but max_vqp is only one example, we
> have other mq devices like block/SCSI/console.
Actually max_vqp is a network device specific config to provision mq 
devices. If the parent mgmtdev supports net vdpa device creation and 
user requests to provision _F_MQ with no supplied max_vqp value, we 
should load some global default value there.

>
>> That way it is more consistent in terms of the resulting
>> number of queue pairs (=1) with the case where parent device does not
>> offer the _F_MQ feature.
> Right, but a corner case is to provision _F_MQ but without max_vqp.
Yes, I will post the patch that supports this.
>
>>>
>>>> if not otherwise specified in the CLI. Without getting the default
>>>> value reported in 'vdpa mgmtdev show' level, it'd just confuse mgmt
>>>> software even more.
>>>
>>> Yes, this is something that we need to fix. And what's more in order
>>> to support dynamic provisioning, we need a way to report the number of
>>> available instances that could be used for vDPA device provisioning.
>> Wouldn't it be possible to achieve that by simply checking how many
>> parent mgmtdev instances don't have vdpa device provisioned yet? e.g.
>>
>> inuse=$(vdpa dev show | grep mgmtdev | wc -l)
>> total=$(vdpa mgmtdev show  | grep "supported_classes" | wc -l )
>> echo $((total - inuse))
> I meant how many available vDPA devices that are available for the
> mgmt to create?
Oh I see.

>
> E.g in the case of sub function or simulator a mgmtdev can create more
> than 1 vdpa devices.
Does the sub function today supports creation of multiple vDPA instance 
per mgmtdev? Something I wasn't aware of before. Is it with different 
device class?

>
>>>
>>>>>     At least some time in the past, mlx5 were
>>>>> enabled with MQ with 8 queue pairs by default.
>>>> That was the situation when there's no max_vqp attribute support from
>>>> vdpa netlink API level. I think now every driver honors the vdpa core
>>>> disposition to get a single queue pair if max_vqp config is missing.
>>> So we have:
>>>
>>> int vdpa_register_device(struct vdpa_device *vdev, int nvqs)
>>>
>>> This means technically, parent can allocate a multiqueue devices with
>>> _F_MQ features if max_vqp and device_features is not provisioned. And
>>> what's more, what happens if _F_MQ is provisioned by max_vqp is not
>>> specified?
>>>
>>> The question is:
>>>
>>> When a attribute is not specificed/provisioned via net link, what's
>>> the default value? The answer should be consistent: if device_features
>>> is determined by the parent, we should do the same for mqx_vqp.
>> OK I got your point.
>>
>>> And it looks to me all of those belongs to the initial config
>>> (self-contained)
>> Right. I wonder if we can have vdpa core define the default value (for
>> e.g. max_vqp=1) for those unspecified attribute (esp. when the
>> corresponding device feature is offered and provisioned) whenever
>> possible. Which I think it'll be more consistent for the same command to
>> get to the same result between different vendor drivers. While we still
>> keep the possibility for future extension to allow driver override the
>> vdpa core disposition if the real use case emerges. What do you think?
> That's possible but we may end up with device specific code in the
> vDPA core which is not elegant, and the code will grow as the number
> of supported types grows.
I guess that's unavoidable as this is already the case today. See 
various VIRTIO_ID_NET case switch in the vdpa.c code. I think type 
specific code just limits itself to the netlink API interfacing layer 
rather than down to the driver API, it might be just okay (as that's 
already the case).

>
> Note that, max_vqp is not the only attribute that may suffer from
> this, basically any config field that depends on a specific feature
> bit may have the same issue.
>
>>>
>>>> And the mlx5_vdpa driver with 8 queue pairs in the wild days is just
>>>> irrelevant to be manageable by mgmt software, regardless of live
>>>> migration.
>>>>>> And
>>>>>> the device_features if inherited is displayed at 'vdpa dev config
>>>>>> show'
>>>>>> output. Can you remind me of a good example for inherited value
>>>>>> that we
>>>>>> may want to show here?
>>>>> Some other cases:
>>>>>
>>>>> 1) MTU: there should be something that the device needs to report if
>>>>> _F_MTU is negotiated even if it is not provisioned from netlink.
>>>> I am not sure I understand the ask here. Noted the QEMU argument has
>>>> to offer host_mtu=X with the maximum MTU value for guest to use (and
>>>> applied as the initial MTU config during virtio-net probing for Linux
>>>> driver),
>>>
>>> Adding Cindy.
>>>
>>> I think it's a known issue that we need to do sanity check to make
>>> sure cli parameters matches what is provisioned from netlink.
>> Right. How's the plan for QEMU to get to the mtu provisioned by netlink,
>> via a new vhost-vdpa ioctl call?
> I think netlink is not designed for qemu to use, the design is to
> expose a vhost device to Qemu.
>
>> If so, will  QEMU be able to read it
>> directly from kernel when it comes to the vhost-vdpa backend, without
>> having user to specify host_mtu from CLI?
> I'm not sure I get the question, but Qemu should get this via config
> space (otherwise it should be a bug).
It's hard for QEMU to work this way with the existing get_config() ops I 
think, as it has assumption around endianness and feature negotiation, 
until the latter is done you can't get any reliable value for 
provisioned property. I think QEMU which need to validate the 
provisioned value way earlier (when QEMU is launched), before 
negotiation kicks in. It would be clearner to use another vhost and a 
new vdpa driver ops to retrieve the provisioned feature config values 
from vendor drivers.

>   And Qemu need to verify the mtu
> got from cli vs the mtu got from vhost and fail the device
> initialization if they don't match.
I mean today there's a problem for double provisioning: for e.g. mtu has 
to be first provided in the 'vdpa dev add' command when to provision 
_F_MTU, in QEMU CLI the same value has to be supplied to host_mtu. The 
same applies to mac address. It would be the best we can allow QEMU load 
the provisioned value from vdpa device directly, without having to 
provide extra duplicated configs in QEMU CLI level.

>
>>>
>>>> and the way to get the parent device MTU and whether that's relevant
>>>> to vdpa device's MTU is very vendor specific.
>>>
>>> So I think the max MTU of parent should be equal to the max MTU of the
>>> vDPA.
>> Noted here the parent might not be necessarily the mgmtdev where vdpa
>> gets created over. It may well end up with the MTU on the PF (uplink
>> port) which the mgmt software has to concern with. My point is the
>> utility and tool chain able to derive the maximal MTU effectively
>> allowed for vDPA device may live out of vDPA's realm. It's a rare or
>> even invalid configuration to have vDPA configured with a bigger value
>> than the MTU on the uplink port or parent device. It's more common when
>> MTU config is involved, it has to be consistently configured across all
>> the network links along, from parent device (uplink port) down to the
>> switchdev representor port, vdpa device, and QEMU virtio-net object.
> Ok, right.
>
>>>
>>>> I think we would need new attribute(s) in the mgmtdev level to
>>>> support what you want here?
>>>
>>> Not sure, but what I want to ask is consider we provision MTU feature
>>> but without max MTU value, do we need to report the initial max MTU here?
>> Yep, maybe. I'm not very sure if this will be very useful to be honest,
>> consider it's kinda a rare case to me were to provision MTU feature
>> without a specific MTU value. If one cares about MTU, mgmt software
>> should configure some mtu through "vdpa dev add ... mtu ...", no?
> Yes, but this only works if all config fields could be provisioned,
> which seems not the case now, vdpa_dev_set_config is currently a
> subset of virtio_net_config. So this goes back to the question I
> raised earlier. Is the time to switch to use virtio_net_config and
> allow all fields to be provisioned?
Don't quite get how it will be useful if switching to virtio_net_config. 
I thought we can add the missing fields to vdpa_dev_set_config even now 
to make it match virtio_net_config. Though the reality is there's few 
vdpa device that supports those features now. If any real device 
supports feature field in virtio_net_config but not in 
vdpa_dev_set_config, it can be gradually added so long as needed.

>
> And even for mtu we're lacking a way to report the maximum MTU allowed
> by mgmt dev (e.g the uplink MTU via netlink):
Since MTU is only implemented in mlx5_vdpa by now except for simulators, 
copy Eli to see if this is feasible to implement in real device. I think 
we also need to validate that the mtu configured on vDPA device instance 
shouldn't exceed the uplink MTU (maximum MTU allowed).

> 1) report the maximum host mtu supported by the mgmtdev via netlink
> (not done, so management needs to guess the maximum value now)
> 2) allow mtu to be provisioned (done)
> 3) show initial mtu (done by this patch)
So I wonder is it fine for vdpa core to come up with a default value for 
MTU when _F_MTU feature is to be provisioned or inherited? If we mandate 
each vDPA vendor to support at least the standard 1500 MTU for _F_MTU 
feature, we can make it default to 1500.

Otherwise the vDPA has to be taken (inherited) from the parent device. 
Unfortunately, right now for mlx5_vdpa, the parent mgmtdev device has 
1500 MTU by default regardless of the MTU on the uplink port, and I'm 
not sure if it's a right model to enforce mgmtdev go with uplink port's 
MTU. I would need to hear what vendors say about this requirement.

>
> We probably need to do the above for all fields to be self-contained.
Agreed on the part of being self-contained.

>
>> On the other hand, no mtu value specified may mean "go with what the
>> uplink port or parent device has". I think this is a pretty useful case
>> if the vendor's NIC supports updating MTU on the fly without having to
>> tear down QEMU and reconfigure vdpa. I'm not sure if we end up with
>> killing this use case by limiting initial max MTU to a fixed value.
>>
>>>
>>>>> 2) device_features: if device_features is not provisioned, we should
>>>>> still report it via netlink here
>>>> Not the way I expected it, but with Lingshan's series to expose
>>>> fields out of FEATURES_OK, the device_features is now reported
>>>> through 'vdpa dev config show' regardless being specified or not, if
>>>> I am not mistaken?
>>>
>>> Yes.
>> Do you want me to relocate to 'vdpa dev show', or it's okay to leave it
>> behind there?
> It's probably too late for the relocation but I feel it's better to
> place all the initial/inherited attributes into a single command even
> if some of them are already somewhere in another command, but we can
> hear from others.
Ok, that'll be fine. I supposed mgmt software should only query through 
"mgmtdev show" or "dev show", avoiding any query via"dev config show". 
It'd be the best to get all of the compatibility related info 
consolidated in one single place. Let me try to include it in "dev show".

>
>>>
>>>> Currently we export the config attributes upon vdpa creation under
>>>> the "initial_config" key. If we want to expose more default values
>>>> inherited from mgmtdev, I think we can wrap up these default values
>>>> under another key "inherited_config" to display in 'vdpa dev show'
>>>> output. Does it fit what you have in mind?
>>>
>>> I wonder if it's better to merge those two, or is there any advantages
>>> of splitting them?
>> I think for the most part "initial_config" will be sufficient for those
>> config attributes with "vdpa dev add" equivalents, be it user specified,
>> vdpa enforced default if missing user input, or default overridden by
>> the parent device. "inherited_config" will be useful for the configs
>> with no "vdpa dev add" equivalent or live out side of vdpa tool, but
>> still important for mgmt software to replicate identical vdpa setup.
>> Like max-supported-mtu (for the uplink port or parent device),
>> effective-link-speed, effective-link-status et al. Let's see if there's
>> more when we get there.
> So one point I can see is that, if there's no difference from the
> userpsace perspective, we'd better merge them. And I don't see any
> difference between the initial versus inherited from the view of user
> space. Do you?
So the major difference is "initial_config" is settable and equivalent 
to the config attribute in "vdpa dev add" command, while 
"inherited_config" is the read-only fields from "mgmtdev show" that does 
not correspond to any "vdpa dev add" vdpa attribute. That way the mgmt 
software can use the "initial_config" directly to recreate vdpa with 
identical device config, while using the "inherited_config" to replicate 
the other configs out of vdpa, for e.g. set uplink port's MTU to 9000. 
Maybe there's no need to fold such info into an "inherited_config" key? 
though I just want to make it relevant to migration compatibility. Any 
suggestion for the name or layout?


Thanks,
-Siwei

>
> Thanks
>
>> Thanks,
>> -Siwei
>>
>>>
>>>>> or do you mean the mgmt can assume it
>>>>> should be the same as mgmtdev. Anyhow if we don't show device_features
>>>>> if it is not provisioned, it will complicate the mgmt software.
>>>> Yes, as I said earlier, since the device_features attr getting added
>>>> to the 'vdpa dev config show' command, this divergence started to
>>>> complicate mgmt software already.
>>>>
>>>> Thanks,
>>>
>>> Thanks
>>>
>>>
>>>> -Siwei
>>>>> Thanks
>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>> +
>>>>>>>> +       return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int
>>>>>>>>     vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg,
>>>>>>>> u32 portid, u32 seq,
>>>>>>>>                  int flags, struct netlink_ext_ack *extack)
>>>>>>>>     {
>>>>>>>> @@ -715,6 +750,10 @@ static int
>>>>>>>> vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct
>>>>>>>> genl_info *i
>>>>>>>>            if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE,
>>>>>>>> min_vq_size))
>>>>>>>>                    goto msg_err;
>>>>>>>>
>>>>>>>> +       err = vdpa_dev_initcfg_fill(vdev, msg, device_id);
>>>>>>>> +       if (err)
>>>>>>>> +               goto msg_err;
>>>>>>>> +
>>>>>>>>            genlmsg_end(msg, hdr);
>>>>>>>>            return 0;
>>>>>>>>
>>>>>>>> --
>>>>>>>> 1.8.3.1
>>>>>>>>

