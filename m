Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AFE63A882
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiK1Mfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiK1Mfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:35:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB11A069
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:35:45 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASAfFtx015015;
        Mon, 28 Nov 2022 12:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4EbpFA7RMaCtROAnEWYDN69iJMuZ2r8XKziUTpDmfM0=;
 b=da+1k3A+myApLE/o1qCovAnRkIWa2lnHXLMPuz9vbwtep+Do+zFvi6pUimO1LqxKgxbi
 k3pea5K41TJF86+AvJL0gR3i7rOPvM7pOefIbk3dlUR9jGct3sO6n7gTqe8xk1nzAEOz
 f4ov0B/xC7cckZdvbG0Q1+JUYWIu+4gx/2U0e9gRVDZLJCS2FbV1rxSt28323lFS5FwK
 fJFzV3iS51YOAMlqAsVBPcE/RGd7Bu3WUgIaFaS8Ydbzti0O7Ape57vYK043UoLenG0y
 eYQIg5aT3AZkGkjt0plWRg1HhgIGyMjr3YHnm4EcTTsDso68mwPoOZ7vIr+PiTB2n2N4 bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3t57q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 12:35:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ASAKU4L022543;
        Mon, 28 Nov 2022 12:35:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1t7gw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 12:35:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/poaSM5l7fLpWBVxgWkgUXbF2GAvDO2TkSVOX/yu2FgJNBxW8Bi9UzFKngMfDUUmSPDQZfFk4jibieUR2XgrFCl250iqIULaBbqfyxUwQUcIsun6qw0blB2/Ga+7xkkQLTgpVQ1xyPQ/P3P2Gt638F+LlchxqSyR6gbVhJzrvjF2Y5teKOYaUh2VeFDdINgmAgB7XA3pDiiQ1DQUrcdyVwIKyjcvToKB5RfF8nmSB4mz7/seQ5OE3++CrXYh5+jARiXLEnJ/7Y3uClm6AONTFd5vExJg2fgzEufauFbuQFtzEGJaDqoyTWCiQZt2FKV1u8TjQSqBbfnCeewfi5mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EbpFA7RMaCtROAnEWYDN69iJMuZ2r8XKziUTpDmfM0=;
 b=XcuvLkcdFHwF/86ycQMomNE4pUA3oRcAR3BX3pZireqH+isOEABOuaQ21f9zRKfsGFo3F8NY0ZAX2tqbc8v+pqJk87fLKDcVakqwOan93UDcY0hLeMEu1iu733a8YSymkXShm9jqD0iRvwLRdep3RLNW4//8eehL6KuOu4IOqr/YMNL8G0gujuxhexFaXl6nXVGfuU2crT30i/1BLXI0kXZuVs54ReNDIRyPXX41WUYdWzx3c7e4Bx/SYTfDTolPY6+2ZcGqRUET7nnqjiJin9xleRZk8y0ywadGrOTptWuSBGh43tipnR7otzQCLTRnO13t0TckEwLNXCWcjJ7Lqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EbpFA7RMaCtROAnEWYDN69iJMuZ2r8XKziUTpDmfM0=;
 b=lxE9tTuETHOfNT9LJjkhTrUGp+Vmd7JtT3AutQirI+kPY71jj8ekADm97zgZCRIDPKEqTj44/eH+c0Wf/SN5kwOqfMo9zAC7Ercw3Mggkq3Z1es/8BbFC0QVcliwc8JC0Ya5PqYTgBo0nyDewKYp603pXxeJDFms8jNWdajfyKQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Mon, 28 Nov
 2022 12:35:34 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::1717:5a07:63ca:fdab]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::1717:5a07:63ca:fdab%9]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 12:35:33 +0000
Message-ID: <7dc11da9-ddd5-d73e-ce76-7ecbd78b946a@oracle.com>
Date:   Mon, 28 Nov 2022 18:05:22 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2] vduse: Validate vq_num in vduse_validate_config()
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>,
        Dan Carpenter <error27@gmail.com>
Cc:     harshit.m.mogalapalli@gmail.com,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20221128083627.1199512-1-harshit.m.mogalapalli@oracle.com>
 <20221128105312.3ajursuudvmysiie@sgarzare-redhat> <Y4SUOPX2WRFiuB7n@kadam>
 <20221128111310.6exrqi26grwspqcz@sgarzare-redhat>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20221128111310.6exrqi26grwspqcz@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4e95b2-f3ba-48b2-289f-08dad13d0b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsS7NyTEw3suxNh0lzIfrOiKUiHRHx+OpwgOVgJ6nLO5gLFAQgBbh/y5MVz0TeTfsYY9f7wXpkQy+ICXPo6Oy6CwWuRX7fBKClJPN0/u0KVKVdt8sy3fFHVddGnZLWPRMXH7qpCx26/ZqTCiWbctBT7jc3FI0TOhjIrujnpAwDvOeavbcb8s2mRi9eQibg+ejYzaGhnKbpOGCCYjtiEJJ35a4AdCjbhAmw6VKcmaYbu5AQvSfvoTvUHJ9XXc9jzEqBSWkhME3KowbtaD06FIBIlxktEZ+2Xe8uVAng9Hy4WI3Z0jHblG7ebAPhrnj8IB4n50kReh8YmSBPAR1D9M73Nspqtf+nNYMx/KUO2ciHTcVoH+3xGKdkY2/VFAagGyDaibde1Qf+qRYDNoMcJZ0UrqLgIDjg8FGP/xGcvIgPL2mhhbHkM0C6p+NC8GlRb4QEL0aZ/tASxkMpylXmrTXfjqfsdSKRPKII5L3DqnD+qNpvqd9/4fO7R0jbj3spt7tUCkVvO00soQMy67QBP2eB9ZotjM/8tNDwmaVRr0EnxlxHyaRHjNDYxUceR657UFLgt3iTpnUNjS1ZoPDBr1k68ze0vNCyMDC5jnAR/wxt0wp3Tx76tTcXUzRR05s5ioYGCSrUlwo6MzOBYKJ0nWvERO8JDHHbylXi1fvZ7FMUDZpOB3ZhLxjYu4gh7Dxy5gdxdiNoiAu2A4ALoS+SHkACE0Dv5FkOoFrr6/FFyZL6L7yknVSf9FtaBkdj94QFOA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(15650500001)(316002)(478600001)(2906002)(186003)(6506007)(86362001)(36756003)(8676002)(66556008)(66476007)(31696002)(4326008)(83380400001)(66946007)(53546011)(26005)(6512007)(54906003)(6666004)(2616005)(110136005)(6486002)(966005)(38100700002)(31686004)(41300700001)(8936002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWpTN0hmRFFPU3BVM3E4TWhMbEZRWkJrQUxWU1JpSFljaHJtL3piMjU4ZG1F?=
 =?utf-8?B?cHE1VTVZL280RkVGQUorK1JpaW5tU3BzTHZSR0Jtb29hOEREVGZnaUpHamV3?=
 =?utf-8?B?TG0vVjB2RElqSGtOR1ppVHRxQmUvbmgwQU1ZQ3QzUkJwcXlWRDh0ZWlDN2Jk?=
 =?utf-8?B?dkNOcmZUTlFvSGw3alhsS3lwVGh4T2t3bVFhUGZMMVA5enpLSVA1bWxJTDRO?=
 =?utf-8?B?Y0tjeUJITTVCV1p0cHlHdlJVODVCcmJqdURVVE5zaktXcGc2MnFpaFpTQTAw?=
 =?utf-8?B?N2tYbVlQUk15K3FXbko1Znk2NSsxU2FLL0drYmo0U3hETE5YSkxlbFA0NUlU?=
 =?utf-8?B?ckI4UldFQ00rWTRNa3VpbjN6Z0dtNThNdlEwQ1N1ck5PN0lNcWZUMllYRlcw?=
 =?utf-8?B?R2ZTcjBzeGFVZUo1akcvQ2pqYklVd2xTTnFna3hMMEY5Q1I3SnFGRXVPeGla?=
 =?utf-8?B?bzZwUHJOQlFqWnl1RnNFUytUWnVxbVpqUlUzbHlFRFpyR2Z0WmljR0ZxVi9v?=
 =?utf-8?B?YlU5TDNGQlR2VkZ4MDY5WHhpa08rOWYrQlRBbGkybGJjeDFVZFFlZ2RyaklB?=
 =?utf-8?B?RFlEUFhEZFFoNlRsSVJURnBuY1RldDIrU0FWU2RPN0Rwd2Q3V3k1a2JhMFpR?=
 =?utf-8?B?SVNTbDNjRnBwd3RNQlRwdy92d3piVTNsT1Z5YjVlMmpNRGJpb1F5dE5xMVB0?=
 =?utf-8?B?SGpxang2TUlpMlIzZkMwUkFZaW9XZWRucXV4UVNlRUdWYk5jWXBYN3VmcTM4?=
 =?utf-8?B?U0ZFRVlBZUdzaEdVZUxrTTZ0VitXdDNKYnlaM1BXY2lnNmtJK2xpYS9YL1VI?=
 =?utf-8?B?VFRYNmo0MFVkQk84Q2VUQU9aNWUrZ1pFZ24rUVhhYmIzMmIzUms3NmttNGdr?=
 =?utf-8?B?T1ZmeGM3RnJBVXpEV1lpc3J5YzBMbDVmWkd0dTBuNDdGUEN1MzZtTmd3REFs?=
 =?utf-8?B?SElkNDlyZWsxbEFTWVNBNThpSjRqalV3RzExT0k3aFl5aVcyNjZnSU50Mjlo?=
 =?utf-8?B?SmlDWGZMaW12Zk1zaU9BZ0xvOFVXZHlCK2U3bFpSVHRXNTdHTlNNRmJEVnpS?=
 =?utf-8?B?U2k3SEpWY2Rva3ZjTkUyODlmT2NTSEtXUlEyRjBjOHVrb010SG92NFNMMTVm?=
 =?utf-8?B?cE1zdStva1pPUy9wdmNHVWVUc0tRRzhmdENwR3czTEJtRDdrLzRUaTNBRURn?=
 =?utf-8?B?aTNVZTR4TXpBOVVjMmNvWlFGa0NUemE4N25KeklMYTlHZWFuQnpuWklFWWlU?=
 =?utf-8?B?K1I5Y3p4aGtWYVN0VVhuYW5DeVZVR2ZLd21ybWVRbWpqZTgyYllzN2NyWmpB?=
 =?utf-8?B?S2Z6VVgvVHJ5bTYzTTh1NEFVRVhpRHBOU0lhMFl0dGVpZEFENnJoTGdLZUsw?=
 =?utf-8?B?QTUzZ2NQMC9oYTNEK1VaZ1k5ZEVQUkxnWmo4dnZJWGdNTlRYN08zOVd0eUE3?=
 =?utf-8?B?Z0d3TG16N2g1bUZyUlVIckZUQy9NamlBTzVpVmNWSThnVTg0T0lWRnpZWms3?=
 =?utf-8?B?MDNWS25uditJRTRwUkhrNXF5NDdkT0F6WXJVcDQ2RFRCM2dGVEdhS2x0alpy?=
 =?utf-8?B?YWNPeXRCV3RxZzIvakwrY0lib0xxYitkcFJWMmZXV0NWR21CTGlnMmtxeHpU?=
 =?utf-8?B?RSs3a1BNMzQ2bFRaYUhPbGpNWTRrWkNjQ1NLQ3ZRcDQ4OXFqQXpiNE94K0Nt?=
 =?utf-8?B?SzFQaU1ydXUvdUU3aFVTbS9SdkZqR2NIOG83T05IN2FNaHVrN1RBYzA3bnha?=
 =?utf-8?B?QkJUWWMwOEkvdUVvZmc1ZFFESkFmbmVhdHZ1NjN5THRMVjJxb0MrSkJkSERz?=
 =?utf-8?B?aW9hVGJydEJ2Mm01L3cvQThvVWgybVQ1aVBxOWF1bWJUbjlZcTd5cUZxMjRy?=
 =?utf-8?B?MkRubHovRjNYTm5lQUpxc2JrcncwOGtxVEtKeXE4Z1FaajZlVVBnYnlNbk9K?=
 =?utf-8?B?RmZ3enBRZjl1Z0hUOVo1anN5T0tqTXBTY0NncEVWMGRDMDQ0VU1xbU9WQW1n?=
 =?utf-8?B?TDhaYjFtTHdWcFRJZ3BlVGNLUVB0VnVyRE1nbFg4RkJyZW9QS3prYnBwWW13?=
 =?utf-8?B?MXBBR0twcCtiVW1SOFQ2QjdFSUF6a2VzY0d2aVFzbEpCYWpCZ2VHMUxpQ3Ar?=
 =?utf-8?B?b3Q2U2xIVXNpWllGcWpUY05xaVJkOWFPTXJWTHArWUxPdjhmckFiMmJVWTl1?=
 =?utf-8?Q?LFwzyUfUTZ8E7fXNOQNS42g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NEZ6cWhVM3hzUnFFbzlMcWoySGh1SThOVEZZOFY4ajZ1WlhzVDl0S0RPRUhx?=
 =?utf-8?B?ZTRyWU1wL0gycW9LVldkSlQzbVJMM2dMUDBuakZSVlRzYWh6VWkvQ3pnUzhY?=
 =?utf-8?B?OHE5UWdEV29uZHN4YnBKMHd1WHlvSVN4NnJYb0pITFdRNXFLdGk3STd4WlBs?=
 =?utf-8?B?ajhiak9hTHJLVnlFVzJaUXZ0amNwTVJkelRaWnBtYUFsbTdBbmlGWUdIVWVv?=
 =?utf-8?B?OC9sTFl1MVI1YTJvT25xdGYwS0NvTmNoOW9yQzUvM0pwNWI2bkU1SHdSVnJM?=
 =?utf-8?B?MDU2QVhBNERadVgwWHdwWnBtaGpvSUNCVWtBVDI2cWlhNjF6U281V0t2cVJa?=
 =?utf-8?B?WkR5OFVXeGZoWlA0WlJEVUFuSUFYWGVkRElJOEZyY01vd29TZHBIeGpSZ2Rk?=
 =?utf-8?B?Y1JxOHZ5ckhVdms5UzFzQXNVSGZrOTdxZWxFSktIOVg5TElsMTlLdEVlMm1F?=
 =?utf-8?B?RWhtVTVVSHZST0YvNHB6eEo1K2VBTXcyNXVRN0NyWjNxNmFjOWNJSGtGUDVk?=
 =?utf-8?B?TU1KRHhuemtiZndyLy9BUVRrVThoWStCOTFXdC9iU2pIanZXdTRrM3Z0bEE0?=
 =?utf-8?B?QmV5Q1dMQUo1bFlpdlpuSnlLd3ZYNnNsaFp0WXBRc0V3Q29kSURDOURIS2lT?=
 =?utf-8?B?TjdHTTVMbUU2R0JtMGM0czFieUJGMnJKUHJlTDk1OHBiMTlIdE1xY21VNmtL?=
 =?utf-8?B?TTB6a1J1VmUrZ3Z5RHJ4Vi9ZR2lqQ0JEUHVHV1NhanRWd3MvMk9WdGNBRzBu?=
 =?utf-8?B?YnpiVHA2MnMrQk0xdVFpQlBmOTBHdmNTRFJNTjVkQkY1bjFxUCtva3FxRnF0?=
 =?utf-8?B?VGRZdmllZ2hZY0xZT2dBVXZvdG9pK3ZkNmdlS1EvNzY5WTlHdWFKMmoyRmVF?=
 =?utf-8?B?RWs5WVdPUFJiOC83M1FaQzEzK3k1eGZ3Z2Y2VjdNOHQ5d2pQa3BFTTlKaVN5?=
 =?utf-8?B?NXM4Tm8xUGd4QjNZcjZxNUZBeitnbHBGdm9iLzlyMnp4dzN0VUplMW1uNjYy?=
 =?utf-8?B?VlR6NkpCRUVYdVNVWHhRbGdETHFpVk9ZaFZGSjFyWWRhdFNOUjJaanFCdnUv?=
 =?utf-8?B?S2tIQ0l2OWZkd09mODdCYTZnaTRLRksrS3lPd2hWejZTTFc5VlVndzBCWEc2?=
 =?utf-8?B?dmJFY29VeklzdlFBT1lCQjI4QUFtMmlUWGN4MTU1OFQ5TzJZblFaRzE3S3E1?=
 =?utf-8?B?dDZJWUlnTzRaSkxXUUUrbTZxekNNTkh2a2dDeVBNbVUxV1h3ZVpHQksxTlQx?=
 =?utf-8?B?cWttcHFkTk5QcUNlMGhaemdmVU94NnFnQnk2OFRvOFpXeXJhcE1Nd28va1g3?=
 =?utf-8?B?ZnNsSGlhVTJZVWp5WUhWbG5YU2pFdFd1emtBUWVvSHRFeFJQWmpLSXloeUdO?=
 =?utf-8?B?ZThEUHNzbXVvR1JLS1lwWDcxa0FOUEc2c1lqMVhhaWJSVlpjV1JCVC9BWGov?=
 =?utf-8?B?cHVIT1Q2bHN1OWpzNDlZN1I1b29NQllEYmp6UFFBbDdmbmNrZlBxUkZJQnNC?=
 =?utf-8?Q?O6DUbU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4e95b2-f3ba-48b2-289f-08dad13d0b16
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 12:35:33.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxQyPMZUhVWRVN7ZPuCGZW7+AvXcvJizwRjLOxvuqljbz/vV68zTBj3ZBalC7I6Q38INp20cBLykhZMUVGtFcJfPGaZW9uCmNOClUIIOClTst7GDGa4q7rJlRDjSxrmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_10,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280096
X-Proofpoint-GUID: -_T4VMPrgebqVfUMeL_XysUALASxWWe6
X-Proofpoint-ORIG-GUID: -_T4VMPrgebqVfUMeL_XysUALASxWWe6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/22 4:43 pm, Stefano Garzarella wrote:
> On Mon, Nov 28, 2022 at 01:58:00PM +0300, Dan Carpenter wrote:
>> On Mon, Nov 28, 2022 at 11:53:12AM +0100, Stefano Garzarella wrote:
>>> On Mon, Nov 28, 2022 at 12:36:26AM -0800, Harshit Mogalapalli wrote:
>>> > Add a limit to 'config->vq_num' which is user controlled data which
>>> > comes from an vduse_ioctl to prevent large memory allocations.
>>> >
>>> > This is found using static analysis with smatch.
>>> >
>>> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>>> > ---
>>> > v1->v2: Change title of the commit and description, add a limit to
>>> >     vq_num.
>>> >
>>> > Note: I think here 0xffff is the max size of vring =  no: of vqueues.
>>> > Only compile and boot tested.
>>> > ---
>>> > drivers/vdpa/vdpa_user/vduse_dev.c | 3 +++
>>> > 1 file changed, 3 insertions(+)
>>> >
>>> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c 
>>> b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> > index 35dceee3ed56..31017ebc4d7c 100644
>>> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
>>> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
>>> > @@ -1440,6 +1440,9 @@ static bool vduse_validate_config(struct 
>>> vduse_dev_config *config)
>>> >     if (config->config_size > PAGE_SIZE)
>>> >         return false;
>>> >
>>> > +    if (config->vq_num > 0xffff)
>>>
>>> What about using U16_MAX here?
>>
>> Where is the ->vq_num stored in a u16?  I looked for this but didn't
>> see it.
> 
> I thought vq_num referred to the number of elements in the vq (like 
> .get_vq_num_max), since this patch wants to limit to 0xffff.
> 
> But it actually refers to the number of virtqueue, so @Harshit why do we 
> limit it to 0xffff?
> 

Hi Stefano,

I may be incorrect about the details of this driver, my v1 was purely 
based on static analysis, Micheal suggested me to put a limit of 0xffff 
on vq_num. I really don't know about the driver, while I was searching 
other parts of code, I thought 0xffff is based vring size, I have asked 
the same question on v1 today.

Ref to v1: 
https://lore.kernel.org/all/82e8ce27-0743-59bf-fbe8-a25093167451@oracle.com/

> Maybe we should explain it in the commit message or in a comment.
> 

yeah, we should clarify the limit in commit message, once Micheal shares 
about the limit '0xffff), I will add those details and send a next 
version if that's okay.


Thanks,
Harshit
> Thanks,
> Stefano
> 
