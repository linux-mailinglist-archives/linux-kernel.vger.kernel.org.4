Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87E16A86E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCBQjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjCBQjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:39:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667CF1589A;
        Thu,  2 Mar 2023 08:38:39 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322FCabm006041;
        Thu, 2 Mar 2023 16:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Im8atGP0xrrWqQIXrExRf1/eJlajnTNYGhKQnlA3FrU=;
 b=lAxg6bWAPaMJ+JCkQ5rGYiQ+5B2xa5nwM70tX53SrXodO/VxYIHWR2Q9ObpeX6HKZcIg
 vP5Sg3sziFNAwlcuWmhvz9U+AVlp+e9vkiV5rj2U2mQncQfv2LLw2Q3H/Oq/SOgdIg1o
 nbZnYlEVmvsZI3F8pCR/rlE+DQ0Fx2s8dw3kUPH3XT27VTvRv5FKGkHVo+8w1HnPF64u
 PYYU8pp8GnYp9fzv2/XLnM7w1GHpKUDd/xW798JIJ/Nb7Kg3j9jAndZ/dDcMa13gvDZW
 aZYk4/vBEyWIGWqpqKE9CvsxRFZZKXIE9A8LD5rSJ/Zk/xS59jxwhNRwUmz3RM4qv4uB eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb9amcdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:38:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322FWlGS002160;
        Thu, 2 Mar 2023 16:38:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sa1j57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:38:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh1JOzSfjF4hh5PqIthwtvE80Ed8AfSIlbDt6uLfRhDGAwqeo32qDV89z4aQKwxSPNAR6KVEg/HV/qcCybiL//UD1vxVyr96scyOemJibTQ6kBfmS6JvnOOM3JRjz5NVHTJ0i22JVxjGXLiC3jnugbkfuiJfl5zoDk5IN086WM1tm4+CJDtucRspnF2qJR115EwI8zB4BAjm4+AK/UjQL/5Myq4Ip1FINNlDndj/pNj9KkPR3s1yfPURFXPOVZFflYUDjKpyR1M6fO1x659VcKYsDtfRgzePmBDbpmDf8hW0XMefc2CHNy7ggWoLmvjd8kSYA50/id3vgXwrTc+4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im8atGP0xrrWqQIXrExRf1/eJlajnTNYGhKQnlA3FrU=;
 b=TC6CWSaDX+sUJmnJuKxgM13aYFpVut1cDbSWRDI3SSFnY14mR6k5wlkm8IiKFSbiXNccuB764suH1BWH/muLPX43ksSIAHj40KmK1qQzSw6U8NatDqP3RIaRgTo84+cDXVUacKY6Q4CaAhcMADDmUtvPWmD5U5pIj1MrKpZaeFSkVgfORlMLHGQSnhRLN0bIX0yp2aWGtBis4EAgqOKteAfg41myuLHT5+ScXg0+BAnsewcErIDlMwSOp5Dv8/XrcBTH7NdYKCPbf2gLRfwCZvyM5qptVdeA9HKEYpzCqjZ4K0gcagkepnLJyF70aenFLc4R7reRU1+gjWe372wdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im8atGP0xrrWqQIXrExRf1/eJlajnTNYGhKQnlA3FrU=;
 b=c0Ua8B0C9XfrxVisxSEYkwqjCCywmVU8EG/E5GnqiNKemhS5CeSxRG9UH2o9b8xFvwG7diijy0plmEKTt7kgQOCpfCmz5zH6bcBTmPMdw7Qu2WkNiSHoC37YUzPvNThb1MTZg79aRx2BLDBe6/nm47DhXMAUzS0OSSYWG/IzbKo=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CH0PR10MB5066.namprd10.prod.outlook.com (2603:10b6:610:c4::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Thu, 2 Mar 2023 16:38:10 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 16:38:10 +0000
Message-ID: <ea695f68-c90a-e471-bc24-1c572d54878d@oracle.com>
Date:   Thu, 2 Mar 2023 10:38:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH-next] scsi: fix use-after-free problem in
 scsi_remove_target
From:   Mike Christie <michael.christie@oracle.com>
To:     zhongjinghua <zhongjinghua@huaweicloud.com>,
        zhongjinghua <zhongjinghua@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com
References: <20230213034321.3261114-1-zhongjinghua@huaweicloud.com>
 <4585779e-f919-0439-2062-b1f30b04f176@huawei.com>
 <a71be678-7f40-811b-4612-81a4eeb910dd@huaweicloud.com>
 <c6106113-7050-4099-8c6b-ec79b6b83d5f@oracle.com>
Content-Language: en-US
In-Reply-To: <c6106113-7050-4099-8c6b-ec79b6b83d5f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::12)
 To DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CH0PR10MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: 18813222-e163-427e-7979-08db1b3c822a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hj//qU1z7EUkEDUNH/Gz4gn4j2nErZcn2T0v2ycLen2JPu75YnoNd1tHF+B1bdEjOtrdR3uq6EzO/PP4PxaxkjAUJ1O+xu6A1tFpTpy47YoHGw2PM9NGpb0V35LwlE5j9tKCU/wYy6nPJKRbpHvk8cpG+JEqGlOTvnYyTFeg6zqnbGkx0schLhPfa8fjnzjaT5hnB/b/Ao8UfVugcxVis9+7FQxYP6zljGCogmO/8cdkw1I02spAA5B89ZDc3dVAi4SyzAFwRBcdDqO9cZ8lj9GLYY2Vz8+jla8UpdJtKF7u+s5Zr/gOSB+ZM3jPg0wGhsjYw/Efb3ZGrD3W64J27w/3v8YdnfBiYz1iU/eH/RnW907+lV+BhQgfhYsT0/ZX1F4L6YgqWjH4ZzGwDb91b0zurykfkomPLHPW0oleHYZ4PekkaSVYobDwDqwWPkAeZPw7hqGoQigneXEHz8Gq54tBH0EHYyY3m5hjQ5c95l3i54eeREDsbmN/nMLQwWk+vhmKV+KX4L+aubwpA22RNSjX0lRtAuOqnziPHUo4oyNTBTukmRiDhLcjnRgYlUYLxDc2yRMXdGsr6iaScBvLXeaATNO5cfdx1blpuyaVVfamji2r3LGz4gLHchwVIiQRvN+fpeuRe/jLbtzKocuZgZqDpZor4VLpwZOoLshN9/O0dOdHbVMdW6S/jMo7zep/5wq67hW3q/oJX+1QNPb0EnMV46ZwBo22LuEU6drN94M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199018)(36756003)(53546011)(6512007)(6486002)(26005)(2616005)(6506007)(186003)(4326008)(110136005)(316002)(6636002)(41300700001)(66476007)(8676002)(66946007)(2906002)(5660300002)(478600001)(38100700002)(8936002)(86362001)(31696002)(66556008)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBhYldNTWxzNGpOeG1TVWdnT00zRXFzUEg3ekhWeVRXN3NGdlpZRkVOdlFI?=
 =?utf-8?B?Mkt6azhhRldkVTVhd09zZ0tndWhqY1ZCaUtESTAzbHdVY1oxSm1hVzMvajJ0?=
 =?utf-8?B?dE94TnlqOFh6c1d5QzBiWUpEcEtkQWRoakxiY2VVQlNkbG14NER5V3VpQ0FU?=
 =?utf-8?B?TTJrdWZROGVTREtTL3RJTDdDMkttc3hDRFZrQUtnUkQ2TGlkQzBJVVVic0dx?=
 =?utf-8?B?MjkzZ3R6MTRSSW0zWUFENTFSUEtrZU9yU0FnaXBzQnpsWkxGWWNnWVc0TjhQ?=
 =?utf-8?B?a0l3amFXaW9yUGtHZVVGaWtYUmlxdlNCNXV3T0JsbnJWTEhKK0R4RTFHS2JJ?=
 =?utf-8?B?WEJUOTJROUJyN01YSjVZeEkzMkFOeWZZR1NsNjNaMnZ6TThTbTNRWUY3ME1T?=
 =?utf-8?B?MVZDS1hLMVYzbEJYYkdlaFZBTFVQeU0xdGZtV3N0TzBMNUQ5M1hOMGR0TXha?=
 =?utf-8?B?dDFSUUlCc2M1Vk53MkpwVXdWcmh5anJnU3JIUVE1K2JYQWkrak56N2dyTm5Z?=
 =?utf-8?B?SENWOWQxNnVjMEVWekR3alNmdFJzc2tjMWt3LzZqcmJnRXZIelR2OGRiTytH?=
 =?utf-8?B?V1lzWGtqN1hLZExzTzJrT2lVMmlaT3c0QTRuVy8zc2xKUjFoSEQ4RktOSktG?=
 =?utf-8?B?TXlGckZmbVB3WjhqUzRsSXM2dFVHYm0ySHJ6TS9xcHpSaGVKRHVKSVUwaHY0?=
 =?utf-8?B?TkNsYWFOVU9SNzlGWndMQXBxVzJmUTZmVEFYc01ycUtHOWFHa09PTmJHMWlB?=
 =?utf-8?B?LzNYaUlOVUpzbzRpVnZoNXpXUFdIWTRTTnhKbFdJbGdyS1p3c0piV24vamgr?=
 =?utf-8?B?WU9MVU5LTGtVTWkzamIzempFUTlOTVVjRWlQMmhaWCt1b1FYRCt3T3dyeDI0?=
 =?utf-8?B?V0Q5SE11cis1T1Q0dFp3bGxJVVlINGNZMFRjUnpnR2l2WjZKUGRVVVFrblN5?=
 =?utf-8?B?NEJEdE1DLytPTmxFZEtSUWJzczlYYnY2bG5ZampEbDNFeTdqN0o4OVo4UEYz?=
 =?utf-8?B?SSt0NXJlVllTYkNoVkR2Y21zNjNNbk1pTjR0VG5jdHRTQlJ4ckxYdS9JZlFD?=
 =?utf-8?B?Tk9lQXA4d1pqRmFjdllWTEdlanNRSG9IZXdxTStZcFBkdFZreGFPRis0dzZa?=
 =?utf-8?B?d0trZTJTckpBZktpMWYrazRIU2g1SGtoaWt6SVY4ZWFGTTAzazIrcXlaWlBK?=
 =?utf-8?B?MFBmaWRDWTZvY09talYraFl3M1ROT3NhUTl0cGptSktXbnBXVm5sem1PS2pV?=
 =?utf-8?B?OVVyOHhYSGxhNGthbjdhODlsNWJmU29sMWttZTcwUFZGbktwa0JpcWlDK0gv?=
 =?utf-8?B?WDUxQytSc0FacjgwdkVySUNLVyttUFMxV2xQWHA4WjNNQzJtN0pDTXd3ZE5W?=
 =?utf-8?B?OWpQaG42TEVsV2FIUm5HTmQvZlFEY2h0S1FLUWw0cmpxTkJiM3J0bWhUMFhs?=
 =?utf-8?B?UDloQkZzVSttRHBxYmFjYUhwMUJwZFFzY1dVZVF1SUJoZGpxTVJVYjdYa2or?=
 =?utf-8?B?aEZxY1g2VWxkL2NrYVc2M1djUFBzZXZIMHExTys0WHJCWWs2K1dibFRCaHZy?=
 =?utf-8?B?OUlTRGdCZVpLb3E1ZWdKdjVCK2tXVmV0Y00xd0FEcEZtK0gvYmtBcG5USjJk?=
 =?utf-8?B?NmgyQm5UVW01bURZQzJQNHRna01ZZnVZenppYVJTSW5Jd2dicWF1aXZ6SkEw?=
 =?utf-8?B?WVdrcmlmQ2UvYTBSYk00SkV4ZEFrNE9XQStwTTR4M2N1d1VqQnFDUlJaa2cw?=
 =?utf-8?B?K2Z5QWRpUm9vWUNJVmtvNzRWZDVyWVRrTzViYys1eE02U05FRlBrRXZ0VG9w?=
 =?utf-8?B?QjZQaTRsTWxkMEFFWjJMZTczMC9obHRsLzN2VVVGY09TOVdwRTN5bFNRWjZh?=
 =?utf-8?B?NGdYVjh1UERlVjc3TXlIMEJYL0o2ai9OMFRwVFRXVDBpWXdFNkhCTFpXY3ll?=
 =?utf-8?B?czBKN2RwZTQyMXF4YTh2TGVGZXdoY3BZWUo2MXl6anF6enBlVlp0aTd3bFcr?=
 =?utf-8?B?ZEFHdkFpZVBNWTVBUkRsb05rVmh6bndqUW5qbGFlelJVUWIxSm05eDA2Rm9z?=
 =?utf-8?B?c3JSbDZCU2l6STVVeW9xa2t0RVpPY0tibmlDTEh1YVN1ektVZTFFZFRRSkgw?=
 =?utf-8?B?aW5UN2g3U0x3azNNU0JGUjVjcjM3aFVIL3BTMWJ1c2ZCeTVJNUFIckV1cmpK?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uDzOsCQ3wYlfT29Yr545gmxv6kEkzyxbgQRk7D6wke8Lm4TkyExHuMtdp+gwoc1p6fU3nX4zMVeMgKWENUD+31PolN5WhhciUE5K8Zixg0asGgdpcKysTCgXTpps5cXDzBUIL898XTqGOneYMIRCAwmjRjD1PmuHNOxOVCixKYdWFaAdvNalbTLngIhdSnKRE2U1Hr3RnLXq22Fy+evgvAzn9dXrvEq9Ok8t2Yo5VSWUJOgKcUEINHEwG9Et+GR8SbJfiglJdfAQ+ZdgPGo+galX1Q0Az0CMtcRGdqoJErv9riTSppqMEzv7P8vsxkFcXieceD/BORPAi68BPeH2wZBYvi0RpPPPJQMcJGP3xQ759oE6w4QLCOBAeYin6jEaGNzwktAUMIwAs22T1Rz3pMhUAjLpE0uRAXWWmjcdNliuLTDRBf4+TS1ZOLUta1gf430OOZR95gEiFkEWixIeJPm011qfYRtTDKoOJvWHUD9rcT9Qef15a5SSqf6fBZYTNExO0oBaqslP5XqxnaBR2QAWwDzKSn8C3ZfzF6w8kqqzzeTap+FpAp4A0K51vm8f4py/VbU5tvkgHvfgy6+KYS55+1sXA64xVw4ysLIUnAlACu4sZqRnR1bq5CDBdaz2enusZh51macDgcwdFDVZ37nkUqyqUF69reLrTnSlN2VpzTGbId6G5bzbAFfpnuKJi06/rpMl02N4kBOBgMoRS2Y/ObtDHxGEwPfx8GyD0dkBPbg3k8RB9VPOKCKrGj0eXzttUQxDmZGS5q9fx+4hJ7uw4k6jv+bIfa4tKt4a/lkWvuCIkK5FKXgViXN9vmSgl7WDYQLm/1p+oFNKr4lMeZXQCycawVmJtbNHRuHvnXmQnCt3V9pe2dAkzxJCO2+N
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18813222-e163-427e-7979-08db1b3c822a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:38:10.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUYJraaWFwj0z75FSv+PVv1z8EN0IzdxTwW8flHKXETJclGQPkV5hafnRTs1W3Vqo/UV78Wink3qVY9gDFsHSIuiYV6IdBTv2uQDY4mxQfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303020144
X-Proofpoint-GUID: GJYQ1oqDo5QvGPJ_ZHYv9RYsx6pEoQsb
X-Proofpoint-ORIG-GUID: GJYQ1oqDo5QvGPJ_ZHYv9RYsx6pEoQsb
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 3:15 PM, Mike Christie wrote:
> On 2/28/23 9:40 PM, zhongjinghua wrote:
>>> 在 2023/2/13 11:43, Zhong Jinghua 写道:
>>>> From: Zhong Jinghua <zhongjinghua@huawei.com>
>>>>
>>>> A use-after-free problem like below:
>>>>
>>>> BUG: KASAN: use-after-free in scsi_target_reap+0x6c/0x70
>>>>
>>>> Workqueue: scsi_wq_1 __iscsi_unbind_session [scsi_transport_iscsi]
>>>> Call trace:
>>>>   dump_backtrace+0x0/0x320
>>>>   show_stack+0x24/0x30
>>>>   dump_stack+0xdc/0x128
>>>>   print_address_description+0x68/0x278
>>>>   kasan_report+0x1e4/0x308
>>>>   __asan_report_load4_noabort+0x30/0x40
>>>>   scsi_target_reap+0x6c/0x70
>>>>   scsi_remove_target+0x430/0x640
>>>>   __iscsi_unbind_session+0x164/0x268 [scsi_transport_iscsi]
>>>>   process_one_work+0x67c/0x1350
>>>>   worker_thread+0x370/0xf90
>>>>   kthread+0x2a4/0x320
>>>>   ret_from_fork+0x10/0x18
>>>>
>>>> The problem is caused by a concurrency scenario:
>>>>
>>>> T0: delete target
>>>> // echo 1 > /sys/devices/platform/host1/session1/target1:0:0/1:0:0:1/delete
>>>> T1: logout
>>>> // iscsiadm -m node --logout
>>>>
>>>> T0                            T1
>>>>   sdev_store_delete
>>>>    scsi_remove_device
>>>>     device_remove_file
>>>>      __scsi_remove_device
>>>>                              __iscsi_unbind_session
>>>>                               scsi_remove_target
>>>>                           spin_lock_irqsave
>>>>                                list_for_each_entry
>>>>       scsi_target_reap // starget->reaf 1 -> 0
>>>> kref_get(&starget->reap_ref);
>>>>                           // warn use-after-free.
>>>>                           spin_unlock_irqrestore
>>>>        scsi_target_reap_ref_release
>>>>     scsi_target_destroy
>>>>     ... // delete starget
>>>>                           scsi_target_reap
>>>>                           // UAF
>>>>
>>>> When T0 reduces the reference count to 0, but has not been released,
>>>> T1 can still enter list_for_each_entry, and then kref_get reports UAF.
>>>>
>>>> Fix it by using kref_get_unless_zero() to check for a reference count of
>>>> 0.
>>>>
>>>> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
>>>> ---
>>>>   drivers/scsi/scsi_sysfs.c | 12 +++++++++++-
>>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
>>>> index e7893835b99a..0ad357ff4c59 100644
>>>> --- a/drivers/scsi/scsi_sysfs.c
>>>> +++ b/drivers/scsi/scsi_sysfs.c
>>>> @@ -1561,7 +1561,17 @@ void scsi_remove_target(struct device *dev)
>>>>               starget->state == STARGET_CREATED_REMOVE)
>>>>               continue;
>>>>           if (starget->dev.parent == dev || &starget->dev == dev) {
>>>> -            kref_get(&starget->reap_ref);
>>>> +
>>>> +            /*
>>>> +             * If starget->reap_ref is reduced to 0, it means
>>>> +             * that other processes are releasing it and
>>>> +             * there is no need to delete it again
>>>> +             */
>>>> +            if (!kref_get_unless_zero(&starget->reap_ref)) {
>>>> +                spin_unlock_irqrestore(shost->host_lock, flags);
>>>> +                goto restart;
>>>> +            }
>>>> +
> 
> Patch looks ok.
> 
> Is there another bug in the existing kref_get_unless_zero(&starget->reap_ref)
> call in scsi_alloc_target?
> 
> I think scsi_alloc_target can find the target on the __targets list, and
> it's call to kref_get_unless_zero will succeed if we are only above getting
> our own ref (we have not done __scsi_remove_target and have not done the
> scsi_target_reap call at the end of the function).
> 
> But if scsi_remove_target has set the target state to STARGET_REMOVE, the thread
> that did scsi_alloc_target wouldn't be able to put the target into the correct state
> (the scsi_target_add call will see the target state and return). So later if the
> driver/transport class did scsi_remove_target again to remove the target that
> the scsi_alloc_target call re-added, we see the target->state still in STARGET_REMOVE
> and it won't get deleted.
> 
> Can we solve both issues at the same time?

I looked into this last part of my comment, and I don't think it's possible.
I thought we could just change around when we add/delete the target from the
__targets list and when the target_alloc/destroy callouts are done, but that
is more difficult than it looks.
