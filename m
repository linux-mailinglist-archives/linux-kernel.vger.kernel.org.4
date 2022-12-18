Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AB86504D3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 22:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiLRViI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 16:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 16:38:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2165B0;
        Sun, 18 Dec 2022 13:38:04 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BIK5wAH015422;
        Sun, 18 Dec 2022 21:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=YNnDIbBo4AmbULKutUwqN9zkvUzfEfxXiAOsvFbYLL8=;
 b=k60NMJFd5fard6b2tZgfeYf0n+2mYrf5Ae4YaKV46jixwLNBkHGWcLhNAePoN2w6xqzu
 078RQRInrFcjIm6UVVrnexZfaxyQcrsvTqHdfaq4yld4iKZcHf0Oi30CGIQW2YpD8Tei
 vSPu/cUqO0gnH0fhmUKkcGSVHlWiiN4Q51J8/GD+QJ8/atB/uwuLu2sHW3HtxlbFfIVu
 3VcRlK6rIiCeaJNM/XFzy/zClKiTNdGj/1auHxR1TzRS/uVDmfihmfJzmbL7HrXEoGrj
 ZMOO/FxSPMSkqr9abz1za75PIVuPbiLzzY33hWvef/ZhpKOeTLElhErnMcedGC/MJIwq 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tp1qbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Dec 2022 21:37:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BIKa8IV006906;
        Sun, 18 Dec 2022 21:37:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh4791hk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Dec 2022 21:37:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHkfldZvwSQA8fkEzXM6GtEUZHiFP/NpN011n/+w+vPfz/1XcCqxuUGHli1Eha5baPn9B0gTXwLgCSZUEWYhYgnvePDgzu7GaMz1fPV4w6UDrXjKtMkPih1ul2YOTfh2s/Xv23qz8jQNJXYUUbprIWbx3c0NHN9g8MmSEvStBVTaftRSCir4T7RSCu45Wfwz/jTDebfAEvegRwR/CjPnuhScMGQ/lfu7gszhwjC+lIjp0bFQD6JIkJaITnkCeIkPShk2/Y7fCeC0KleuRI+YX7Wdy7TCgh4YMandI9kZ7wi2Y+B0SQnCYHMnVrD19B382Bb28hvNfD5RRTqKfzAfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNnDIbBo4AmbULKutUwqN9zkvUzfEfxXiAOsvFbYLL8=;
 b=RlElkvXgYAlin69GmQyQ+0OGYanvvJXzs6yQzNRauIuDvFyOXMHsEkyYqwoBk7ig+MPAAqnMdu5ySJkEYzLSYiMeLKU91AHCiMAiKmOQHE3rUVlI3t4caVfdg1pIL+QCeU5XvrMsVjtEMwMDsEdAal4vbRgPOJQZ2OW9uMbDG//jmHLG51/fCGlVyTej0FH6yA0qIGXOn/tl1ukYWFnIashUaJYzm8ZOHxXb/v6pf6c4MnlW+ueshnnpwceR7gPJK+CPlOtM9dBHbMlytRMl0dtzrwNDhSLPXzQ56o7HYSTG6R25Ois5Kkp47UFW+awhFhdq5dwJZqsvKXbhySLPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNnDIbBo4AmbULKutUwqN9zkvUzfEfxXiAOsvFbYLL8=;
 b=RsKszpV1iNB2H/Ne/JrtKVxpncuSn2C1issBk4QqN3KfbIduF8dLoVa5Gm0CKGnRFViicTiI5YrmXpKMhx4KIRbYuKeGqj8nAIR8NogsbdVeTmzLxhrKYM19QuXh4RedvQJ4LikNk72bxGya2SOkgH4mMDKy7Fxikf1gVLWHoK4=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Sun, 18 Dec 2022 21:37:42 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.5924.016; Sun, 18 Dec 2022
 21:37:42 +0000
Message-ID: <536981a8-76a3-54b9-a70c-a86994c027dd@oracle.com>
Date:   Sun, 18 Dec 2022 15:37:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] scsi:core:Add sysfs interface to control if skip lun
 with PQ=1
To:     Wenchao Hao <haowenchao@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
References: <20221214070846.1808300-1-haowenchao@huawei.com>
 <20221214070846.1808300-2-haowenchao@huawei.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221214070846.1808300-2-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:610:38::20) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe90122-1e19-4fc6-0f9b-08dae14017c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GdAMERNRgqT8dKGgIhufX/Tf6x/8h0O1gCd3ELmrSwswo9YRLnF3ndomd4ixS4g7JDKQasyS6L4kRaRHWb08hv05t6ejcagIJyjFJgQ8s7DfY7UbOOPeGJErBVcQiPEkFBpWklGpmBFs1FO1kjQIJ4vch1f2t4Vvagez/Cfc9tZXBxGYQDASIYy82p1e1H46X1fzw9oeCHVIdKizOqKE8t2kqfMk/Dy1IhMO34wmnZrHnnRlYH3SQu1OkS7/rDZXwCRMN2YvmA/nQIyAhVFcO7jlJ1asbx8vp6KR24FPzHM2NimFS56TDStIQ3Sx8k6a2Jkp8KC7l/Z7BhRTEEVSruY1+4YQ1TYrEigWPshfYTjUu+a2NtRV+elGf0DHkT56yGVhRk/rsfnyylyPibitz8sDCG8oGC0q7fz/rO+OcMzgB/I40gl/yXaNdbkr3tMs69/Uf4CflMmM5wtf+wpd8YrqNklEwynGH0GU12DkFBdcni3zxRc6jMrfZHO9hkU1YdQqxTxrr6xR4KZ3dQvRplBxOd5nvgCxz2nWbDYPaWuIefz9l7nIvyUCddOH3x2xs4Sg7xmqk1JolzoJeNOdnbQWYQQZGSyjrG+bO6RRVsq7prDkR3bWreb1EGlXNuc1E4xwb5b0ezmnjey2SYP0R/8tqKJJdM8fB8mbVLh0lSf4K/X3pgeUXBvQlhdPIulx82PCW9MTbmGacT1SHCnKjoYkxs46H6QZ2M1Qqxnx0QU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199015)(31686004)(478600001)(316002)(110136005)(31696002)(86362001)(36756003)(26005)(53546011)(6512007)(186003)(5660300002)(66556008)(6506007)(41300700001)(38100700002)(2616005)(66476007)(8676002)(83380400001)(4326008)(66946007)(2906002)(8936002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0grc3B6dmRIZGFQck83QnlVeGlVQkl0ZHc1cHkyc2RxZjZlS2psRExsWTRi?=
 =?utf-8?B?VkxkdndnMnRkSWV3c1ROWW8ydHlMUDVmZEZ2YmtOaCs4UkZFYjJQYnJCTVgy?=
 =?utf-8?B?TWlvNytlVTFWZ0hHLzJIY1M3MnI0RmVteWZLNGphV3VJbkFUYTNFUTEyMXBu?=
 =?utf-8?B?QmlUclZTMlUzN20xOHlkU3NCTkhDbnVranBqZ1F4VzdSaUwrcnFUQmphbVNB?=
 =?utf-8?B?a3dqaU83cVNaRmhZVmwvd2twYUg4akFQY0NNZGdRTTN3d0lHUmp3K05zaUpT?=
 =?utf-8?B?dEJwQ0pIWDlYNXdUYk5LWkxKWlQ5QXp6K0lsaVh1S3k5QmJoWUQ5WGlwczdU?=
 =?utf-8?B?NktGbmhuV0Jhb1g2ZmJnYVpPK0w4b3BkWFhjY20rVHZkd2NIcmxFSVlRZDZY?=
 =?utf-8?B?eHh5R2R5OEFpWXpTaTJkSDRpbHFPS3kxeG04QVNRa1hrNDN3UVdVaW5IN0NV?=
 =?utf-8?B?NFAwaFUxckZCN1I5SnVmZEdRMmdHelk4dUZCUnY3NDFubmNSZmNhZEFGZ0VS?=
 =?utf-8?B?YSswalhGQ3pPTWhFY0dnU01oWStRdmx2TWFSTkxhQVpDNnlRZjhXVTVkcUpR?=
 =?utf-8?B?TVFHVHdUVG1RUGVydlVtWFp5RUwwMzlYTk1iZWc1N2ZiNlJVNENlbGQwMmFC?=
 =?utf-8?B?L3BYOEd2VkNDOXY2T3Vpc0tsbXA3TTdib2x2MHR5Y0RCa2ViYjh4WmVVd2NH?=
 =?utf-8?B?TDZRV0Q2VkdvNS96c09NMmZwekgwMm8vTU9VbmVSNmRmMk1WVVF1a0JUSlhs?=
 =?utf-8?B?WFhWY1cycU1HTGNMeWk2ZFBFdk53eHRBU1FQLzhVYmZzbTBnaHBIRjJuaVIx?=
 =?utf-8?B?b0FEQ09WblU4N01wVHE3K1VYZ0hDMHZZSkhBekwwQlo4QTRnTnNWQnQvVCsz?=
 =?utf-8?B?MGg2MnhLNjlJcVdFUDM4Q2c3YXMrUS9Bb1RHUHRNUEV0NVJUWEJGU2VMQ3JC?=
 =?utf-8?B?b0F3bmpMRHFwUTF0NzAxRThMSXZuSHNVNUdGUHVJY1FMUmhhbEJ1RmRzdGJE?=
 =?utf-8?B?YVpvNnlEQ21ha3pUSnpCMW11VXJoZWJKSkcrZDVDWnYrKzNTc2w2bzRQL0Vs?=
 =?utf-8?B?SXFoRGJhTk5BUXNzS2krUUVzSnl3UHAydG9RYTloVjNjQ0lJU1dmL2MwbXE1?=
 =?utf-8?B?SjhmeGJvSG9DVytucHZ3cXg2ZVQrOGRNZTZLNG5YTnB0SzN1dkJPUy81TkNo?=
 =?utf-8?B?cjM2dzhOSzhmOTQ2TWlndkx6dFFYbjI1ZzVYVzRjMFFBU0RIbC9EY2FmMENB?=
 =?utf-8?B?bWVBcXI0OS9RUlUwaHBzc3ZaSVFYOEhzYWRNck8rK1dqUmEwWEdjMklmMEhO?=
 =?utf-8?B?YXNJMC85UWtqVjFpUHVRckN4Nnh6OC9HTytzcFl4ZXpDQ1N5NGdpeEIwN0gr?=
 =?utf-8?B?Zm5tblNBd3BZUE9abHlwVDIwRkEzbzVsL0E1WEYzeHFSemh0RXBzNlkvMS95?=
 =?utf-8?B?ZW5hVFNOd25sRzFGdWs4cDQrRHhiUncxUEpFZ21EYkhoK3pvQ09Bc2pJUDZu?=
 =?utf-8?B?ZG9YY0ZaTnYrNnVMVmcxNGpjblVZODBYdmN3cVRIQ2UyNVJZR1hycWRMeENK?=
 =?utf-8?B?V0l6MDRsY01sK1pNWHpLZ3Qwc1F6UHJOcU1KTTU4UGlvb29jSG9zd0NCQ1kv?=
 =?utf-8?B?RUc0SUlCTG9PZFUyK0h6K2k3dEp2R3lqejdRc00yckdSRmtZUzc1NDUrREVa?=
 =?utf-8?B?N2c4YjJGRVRWMW9WRzNGdzhFYXQ0ZEJFaldLTjJtNUtMVWxJblp5cnZ1WXRP?=
 =?utf-8?B?Vm4zVS9GNmhmUEVFcXNYMHVMWjhHdVU0azRkMHlNclpNWE1SLzIwNk1FUkpC?=
 =?utf-8?B?MWk4ZncyOEd2Z0hqc3FhcjJLaG9GVnoyYmZNM043b1hBSXdjMERjWXFvU1Vx?=
 =?utf-8?B?ajlKMWhRQWhpeFBCaWFWaDcvbE1FZUlSNVRzRmFreFBBUktQQTQ1ZWZpVEF1?=
 =?utf-8?B?N2R6aEx1OFB4UFVwQzVoRElkOGdhTlFvc2pSUXdHNGc4M0lZVE14S3BjRXFm?=
 =?utf-8?B?WlN5QWZ1Q2QvTkJpU2hHMHFpa042TXBDMlhQZXdCV1UwODVyeVhYNTgydTJw?=
 =?utf-8?B?UHVKZkdiRkxVZVowS2ZMc0wwT0VvMGVxU1YyVDl5Rm4vRzhhWm5QOHZ6dTA2?=
 =?utf-8?B?cmFkNmtkZHE1M3lGWXJ4NmQyb3NETW14SEV5bXl4RHA0azFFUCtDdzBOTlFh?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe90122-1e19-4fc6-0f9b-08dae14017c5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2022 21:37:42.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4icT8FBhBI2xJsPtAHTIm+vKmJ5EvoMoI+7HHbgJ1On24kuulj8qok/1xQYNS5+g50Aq+cvja48hjXQvbiIt24IwQjlOP/rgwXBHqW2YHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-18_02,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212180205
X-Proofpoint-GUID: plFx1AHA6Rfi1IaED0LGAG6Oo8DYzmNx
X-Proofpoint-ORIG-GUID: plFx1AHA6Rfi1IaED0LGAG6Oo8DYzmNx
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 1:08 AM, Wenchao Hao wrote:
> 
> When iSCSI initiator logged in target, the target attached none valid
> lun but lun0. lun0 is not an valid disk, while it would response
> inquiry command with PQ=1 and other general scsi commands like probe lun.
> The others luns of target is added/removed dynamicly.
> 
> We want the lun0 to be mapped to an sg device in initiator, so we can
> probe luns of target based on lun0.

What do you want to do exactly? Is the idea with your patch we would create
an sg device, then in userpsace you would do some scan related commands. If
you find devices then you use sysfs to have scsi-ml scan/add a specific device
like

echo 5 0 0 8 > host5/scan

?

It's not really clear to me why you need the sg device, and can't just do?

echo - - - > .../hostN/scan

? Do you only want to add specific devices like you are doing some sort of
LUN masking on the initiator side?

Is the issue that you need the sg device there, so you can detect when a device
is no longer present on the target and then you will have userspace remove the
device via the sysfs delete file?
