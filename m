Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95EF6F5F52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjECTmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECTmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:42:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB1276A0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:42:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HoqbS014458;
        Wed, 3 May 2023 19:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=zAPm7B39bCCzVulVOBN8pjwiW4UuUugX0jnvHS4WcvI=;
 b=09s2//KvWZ+TpfNyB/nhhKoGDmJh1nBO7QFJe6IzlRKQjL4HNDpDPkUtYXmaRVS5PBne
 ++Cds+Rq29Bi3mjr9x6XNQ0trWNYzo7wKII9Cbxe7J5fnuL1gJ90ePc8IOyagzz8CIN9
 nJt7kCbIwCzcgrmoGDkZ6c1IyZ2rf6KWR/aD1c53q5hRXBGbv/B8JiT7khh1FyrOqsVn
 Sdr/TB/SV65sbBIBjammLnM3UE7/7sgwCvfL1eukq0FEiXPd3JcZzWjToeLEzE3aZnVw
 GCKeOXQWv23L/yE51j5/sZYGu+CKZuWYPzW0SjU+nqI+KK5P3XkZSYK+Rqa/yvCR/HRm 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t140a4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:41:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343JCxEA025048;
        Wed, 3 May 2023 19:41:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7su3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzme+qWIwQ4FPH1Hg2ZGf9mm1A44OtGKIKff3i8eXODbVk+rEK0LI9rt4FeEIjH603xyzxRnFT0XOzwaCF8n3cGXwh4vo1AiCK7JX7nvC7nVV6ueyqtUDQo9pPEuoPrFdWjK+LcaY7BH6UyvWNZGJ/JcY6sDcn2H95YnVdiCX8/8KRmLF4o+vGriB0O2ynBxIZhXMbl13TuAVhFeBmNKzcajmdMpV0lDSXMHsk7LSXZrMk4fC7PMwIuZyU3aQSWb+jzCFXYUWsEJnIepFkVeZlznKVTGfhQ785PxyhfUvnpd5MQYV5Xtp3fmEemRo4PNvQm7Z9pDlg2yVKxoZCVY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAPm7B39bCCzVulVOBN8pjwiW4UuUugX0jnvHS4WcvI=;
 b=AGvb8sMHkRydvmVu48p0rFk6JMMYTOXa9yoSikDHUjl20gx1WADB0fMMe47OxSq56dtpmd3HX66v9nKYd23g4JXGv1BxLMqb5tBrCIIx17GhMyBz/lNC9PFBIPSxl0jctlviPiA+NUVmpX3Ppis7XhfxdbysK6F7WmJiFxe7xk4FRtspK6ejMHuXeB+h0JxCET814PoP0j8OQzh0VAb81SmqSNdeLsmLMdLDtNztoXVNJWL7w1aquXGCvvJ9gmDc2OWIDidG4+phCGIc8iHzrP7eWVShz9uOO+BLeEHRU5MMbYRPfiBojMePbO8kVeWOgTZdfp3rFNsh1lDeF5kkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAPm7B39bCCzVulVOBN8pjwiW4UuUugX0jnvHS4WcvI=;
 b=Iy0mELkF3U1PYxFZRHbxf1zvia2hZxDdb58mKKZF81kXi9MVD/dTKxqxlEBuxhQaJbN/G8C9/7vbw6n2j4+58cTe7+SsXYvhUHoCR3xzcJibuJMj33cuBXgaO4o+tDGWCey5fnKw8cAFWl/L8ZUuoFYgBM+8b34uBFUkWGUk20k=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SJ2PR10MB7558.namprd10.prod.outlook.com (2603:10b6:a03:549::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 19:41:31 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::da62:d148:3055:6392]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::da62:d148:3055:6392%6]) with mapi id 15.20.6363.020; Wed, 3 May 2023
 19:41:31 +0000
Date:   Wed, 3 May 2023 15:41:25 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <dfkllxtzchrxeqykzyk24ppgwxbztk6rbbb6xyizpbhg7ctibi@fhk77qxo7yia>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230412120736.GD628377@hirez.programming.kicks-ass.net>
 <20230420205201.36fphk5g3aolryjh@parnassus.localdomain>
 <20230421150559.GA162558@ziqianlu-desk2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421150559.GA162558@ziqianlu-desk2>
X-ClientProxiedBy: MN2PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:208:d4::47) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SJ2PR10MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c6a3c7-4fc0-4368-445d-08db4c0e648f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BKIGr06kW/6hi8ju7ZLjE3REsp2ri0G1u7VAiFuD2vyUh/y9XTnHi9+WqRjrCgD1edfxAk3NM/pmDrs+R4oZ33J02WB5DR4zeq3RNbDUgFKPgk5ISEqfIel0iRcS4zyj+RGvxmakgAvPbBjPQgm/bhhbnaxwjX8iN4vHyG4WM2SYyktndFCTCz1tbufy0NilLWQNCEwmiFCaXyhVMg3jCyFsTN55Plgko0jAuJFRlmZ+nRWsyRsu3lkdhY5TSyxrOmOwT1jexPKAWZsJJLycb7GmWXrl7n5By0oMMotWgyGbsy2y6EyiEGESydeGt7S+CCqXg3M5ucxSO9+OjJwNif8BBEEnCXbrZ1ddn/biL21+flGKxCycUrbB0OMBM61Mm1wYpQ9E/WqaUhfcUSWjtNlS/C+PlZFPU04nkMIIYKpVcuj1QZMPfU/+fRK5QAY091Q7cbw1j1F2/OL1azqoyJGNF056nCIIEQP9MhXbDFlRb9fYyuTx7C04nKCaqs1B+NucZS2MzMI06lj8uY4jaMHZe8snY1v5azOZ9TwOrUs28WV4tzkJfSlfTk8OmWT8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(38100700002)(26005)(186003)(6512007)(6506007)(9686003)(83380400001)(54906003)(8676002)(8936002)(7416002)(5660300002)(41300700001)(33716001)(2906002)(478600001)(6666004)(6486002)(316002)(86362001)(6916009)(4326008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yIdA/Qhsak+pBtlkMmxzGfCOjqoSwfHbjnSpXdCn7JYExRyOp2VdO8U4GbZa?=
 =?us-ascii?Q?DNX6wdvw8WRlBd4ysiEbywxBn9m6SvNNp3Ts6L8UsbcOoo0v+u3h61r84qKJ?=
 =?us-ascii?Q?Cg3T4Lk//1q6+y+B6OvTJ6yL1TFRydJSu5GITjuKRVIHR+mVbrGpIyLg9JG5?=
 =?us-ascii?Q?ZULGyUQ4tVfTbbxUzB1EJViCM2Iya6BPjWmf09CXdlypu101kXsWBpRC42mC?=
 =?us-ascii?Q?IkMnfA25KVmIfP7e0cEZ/FJMhS5hYcEsq0CRurk1j7ZRJTqnS3GfL1g3YZPd?=
 =?us-ascii?Q?EiH1ks66jajx1ccYZq3j6Tlb6CjdAPSgVxrZOgjMfPOs9gqOU3UTQKFkPTYo?=
 =?us-ascii?Q?xso86P6ATm4F55k0t0AorlciItAWeSiS882ww7Qb+eS0U0XmFf3Ly/56kjR7?=
 =?us-ascii?Q?MwtNTd2euS5ayV5xWqW3ePAPOi56TRUEYAfXccaZDtS9XLy36gQrN5VzmWGF?=
 =?us-ascii?Q?IjakfPlk873YzzCk9vB5qoKca31pZVrjBa+c0qu7zurl/KQUXQL+JPnBeGZ4?=
 =?us-ascii?Q?AC8ofqP11iFJA5LjgHJsLNDH7SL1lF752Dx2QkD9TpEE391349RF2DaMWzhB?=
 =?us-ascii?Q?tSz3KSITKnftKwJExVZHLZyaIffpfGnN+4tPPfOSFLEebiSM+j5jVIHU9YZX?=
 =?us-ascii?Q?IAZQ/rZUUm3g1ExDUr8yKv1aFK86BH6v+9uxFqr3yiyzq11QJ6FjVB1BfjAx?=
 =?us-ascii?Q?m+Gm5u+yqBNSS5T1je0dAKX8C2+3l9bKU4p3Nq9WFi4rAZMyUeAxAx+vuonF?=
 =?us-ascii?Q?58Dl5AGw5uwDeF8HG79cXZLHaH6tPFwh73q6W3lKNmhws+5lOgOPboHkDRw6?=
 =?us-ascii?Q?mNphz5l9Kj11nwDNpru8pc8wSTa1Ai70fAcH3c6oG8lbojhF1tJfksijbRPx?=
 =?us-ascii?Q?wFB5JeYhedyhTgkNDFwse9evGr487E0Lz7tstdcJhCRfDayP1FzzB0686Dt7?=
 =?us-ascii?Q?59OUCG6xZ1bJWLsjEdWNeV9j3Ybpw4ej+KDxVqUo0K2IC2kBK+FBxYnJmaBl?=
 =?us-ascii?Q?3m+7S09/bns21IiyTNrBCLd4a7hfAbdROW+DIPtpLuuNGiSSrdS6j3OJqhdU?=
 =?us-ascii?Q?kMkRnGRWTpSu/teSJ/1CIJP+8CcbHAL/FEdmANfGEfb6oYaOi1s2tWHSikCg?=
 =?us-ascii?Q?GuxrNLfflQ0uj87Eo5IRDR7GJpavN/IKmqhTV3/mg3ftA+Af7lJWzEk6T4r7?=
 =?us-ascii?Q?TULhMqFinhLUBSS1o+m/LLZaU0BWfxz6h+WhIbPZIhPgWn5vZHMnZ6lzwauX?=
 =?us-ascii?Q?7n1PLdaA5fzLO+quhjG5gA45Haoxrp0FaT+bo/dWUTniR9jDQsj+UXFvWMPF?=
 =?us-ascii?Q?35hk0D31SkmJLUsoBFOrYKXPPosSPIxI8cwd5MzpNnnP7A/0PBw3Nrbq0yth?=
 =?us-ascii?Q?0jMKHd9RSNzNxeQ4RpJHHGCX+s7Ykt5hkL5j7d508mPM7ZE9jziyg7KcrxAZ?=
 =?us-ascii?Q?hasTx+xfRx2LyNasRQZzCVuJS8d15fsCFwiNa9E7nFYspW5Ox/75DiRr3Ph9?=
 =?us-ascii?Q?9QQJOGHS6OlivacA16QM9iBaZxrzUdttltbo0VyeNvt6rq/78X+EWa9H5c7j?=
 =?us-ascii?Q?4HSNJFKzRKEmvl+PTHkhXbvzX8lZAO7q/Ihg9Nq9eghspgHR2DDO77+zZkcy?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PV5unjnKKckYHMJo3Q7aEcAEyqTOKymmsN4rP7YLzgBy6Y28PTLDkahYyTHz?=
 =?us-ascii?Q?5orDDtSsKd2vgDino77Qz/QPeiNUNkEgz6LSk0OEY7grETYCGt2t1w7Gpskn?=
 =?us-ascii?Q?znjdY2RiayOqG9OnM3PPkLIruaFnRXywucYxxcrTtmy3KHrVYxK1EFECeZsL?=
 =?us-ascii?Q?WMfEZ9afxNXJhL+aIp7CnpnJMr9q967uofnlPXB+updk03LbjcQxYxbvPwyk?=
 =?us-ascii?Q?lCpEMWA26j6PsK8ma2wnMIvqsHdt9TFIytyicBPbFUfk5xVn5j4XWuRUJps6?=
 =?us-ascii?Q?jsl3tsIt0egeqhAc4P3Ibs0cWyw49hexYve+/05ouy2oNBb6qMlaUB0DUHjX?=
 =?us-ascii?Q?ZnUzx7JGxX6D8sz8cycYqb3ga5FC8VBY6AseZP9Hm7gjXufpeXWNh9PyQlnK?=
 =?us-ascii?Q?Xwi8ux5VlVXZ2+bF2KDewg9PYK1BINgNdZyz4cTU/Ya49/ocJd0ABlYPxEPL?=
 =?us-ascii?Q?OkOH49JJ/zcZI3qyOeCuKSJac/x6rwh5/eA/lUdxNQ4XiK8f8AmpCnaaNcVf?=
 =?us-ascii?Q?RIi1RrmRCBMU9fw/dVUJIBFY1aExykSodPIYiu+AkTlM6T8X/0oSis383WPI?=
 =?us-ascii?Q?hoLbXBj0l8yW4zDGabWgyiXdNH3poen4TU+bXU0M3PQJHjJDta35QHUFm9OB?=
 =?us-ascii?Q?8tLJUy5v48+mrQKn1cFtMIb7g9i8nET9zMi2757K3NqgchkuWWwQ0rh5RL2Z?=
 =?us-ascii?Q?WbXBanjXoqZZszP5+jvV/tIdzEPnLENkVZEIxWgEf7JtgjaL8fdB4Qeqgo0p?=
 =?us-ascii?Q?Jv0mc1cfJAUydhYElTtgiVCbC+vHR93XAHXaI4xtU4Xxq6vDzLhVdkC7jWB+?=
 =?us-ascii?Q?uT3AtCalP/HciO5TdREBCP80C3bEOQY9ltAaXH6W37luI3omh26GVl5l8HrJ?=
 =?us-ascii?Q?hPesN+qnnXLqSVHPUM+pPZvkDrySabTAllP2jtP1iIjY+sZDJewlEdkPvdZi?=
 =?us-ascii?Q?qY4TcKxwEPndgMmRwmSPsrKKDrMBncKF3cp8APOvON0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c6a3c7-4fc0-4368-445d-08db4c0e648f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 19:41:30.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjujE3/3lZQuRue3ETvk+TBDx1MOf/MPTPZreNqrT0/e4lECmw4YKuxw3cFdc1n6dvWlWOu3O51vcwfA/PmnScyMGRvcLJEVm04ghPd1GSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030169
X-Proofpoint-GUID: 8BLJ7kgSbkeg3nQPz5Un3ayKTyCNBoA3
X-Proofpoint-ORIG-GUID: 8BLJ7kgSbkeg3nQPz5Un3ayKTyCNBoA3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:05:59PM +0800, Aaron Lu wrote:
> On Thu, Apr 20, 2023 at 04:52:01PM -0400, Daniel Jordan wrote:
> > AMD EPYC 7J13 64-Core Processor (NPS1)
> >     2 sockets * 64 cores * 2 threads = 256 CPUs
> >
> >                       update_load_avg profile%    update_cfs_group profile%
> > affinity  nr_threads          base  test  diff             base  test  diff
> >  unbound          96           0.7   0.6  -0.1              0.3   0.6   0.4
> >  unbound         128           0.8   0.7   0.0              0.3   0.7   0.4
> >  unbound         160           2.4   1.7  -0.7              1.2   2.3   1.1
> >  unbound         192           2.3   1.7  -0.6              0.9   2.4   1.5
> >  unbound         224           0.9   0.9   0.0              0.3   0.6   0.3
> >  unbound         256           0.4   0.4   0.0              0.1   0.2   0.1
>
> Is it possible to show per-node profile for the two functions? I wonder
> how the per-node profile changes with and without this patch on Milan.
> And for vanilla kernel, it would be good to know on which node the struct
> task_group is allocated. I used below script to fetch this info:
> kretfunc:sched_create_group
> {
>         $root = kaddr("root_task_group");
> 	if (args->parent == $root) {
> 		return;
> 	}
>
> 	printf("cpu%d, node%d: tg=0x%lx, parent=%s\n", cpu, numaid,
> 			retval, str(args->parent->css.cgroup->kn->name));
> }

That's helpful, nid below comes from this.  The node happened to be different
between base and test kernels on both machines, so that's one less way the
experiment is controlled but for the unbound case where tasks are presumably
spread fairly evenly I'm not sure how much it matters, especially given that
the per-node profile numbers are fairly close to each other.


Data below, same parameters and times as the last mail.

> BTW, is the score(transactions) of the workload stable? If so, how the
> score change when the patch is applied?

Transactions seem to be mostly stable but unfortunately regress overall on both
machines.

FWIW, t-test compares the two sets of ten iterations apiece.  The higher the
percentage, the higher the confidence that the difference is significant.


AMD EPYC 7J13 64-Core Processor (NPS1)
    2 sockets * 64 cores * 2 threads = 256 CPUs

transactions per second

                                   diff                 base                test
                      -----------------   ------------------  ------------------
                          tps       tps
affinity  nr_threads  (%diff)  (t-test)       tps  std%  nid      tps  std%  nid
 unbound          96    -0.8%      100%   128,450    0%    1  127,433    0%    0
 unbound         128    -1.0%      100%   138,471    0%    1  137,099    0%    0
 unbound         160    -1.2%      100%   136,829    0%    1  135,170    0%    0
 unbound         192     0.4%       95%   152,767    0%    1  153,336    0%    0
 unbound         224    -0.2%       81%   179,946    0%    1  179,620    0%    0
 unbound         256    -0.2%       71%   203,920    0%    1  203,583    0%    0
   node0          48     0.1%       46%    69,635    0%    0   69,719    0%    0
   node0          64    -0.1%       69%    75,213    0%    0   75,163    0%    0
   node0          80    -0.4%      100%    72,520    0%    0   72,217    0%    0
   node0          96    -0.2%       89%    81,345    0%    0   81,210    0%    0
   node0         112    -0.3%       98%    96,174    0%    0   95,855    0%    0
   node0         128    -0.7%      100%   111,813    0%    0  111,045    0%    0
   node1          48     0.3%       78%    69,985    1%    1   70,200    1%    1
   node1          64     0.6%      100%    75,770    0%    1   76,231    0%    1
   node1          80     0.3%      100%    73,329    0%    1   73,567    0%    1
   node1          96     0.4%       99%    82,222    0%    1   82,556    0%    1
   node1         112     0.1%       62%    96,573    0%    1   96,689    0%    1
   node1         128    -0.2%       69%   111,614    0%    1  111,435    0%    1

update_load_avg profile%

                               all_nodes             node0             node1
		        ----------------  ----------------  ----------------
affinity  nr_threads    base  test  diff  base  test  diff  base  test  diff
 unbound          96     0.7   0.6  -0.1   0.7   0.6  -0.1   0.7   0.6  -0.1
 unbound         128     0.8   0.7  -0.1   0.8   0.7  -0.1   0.8   0.7  -0.1
 unbound         160     2.3   1.7  -0.7   2.5   1.7  -0.8   2.2   1.6  -0.5
 unbound         192     2.2   1.6  -0.6   2.5   1.8  -0.7   2.0   1.4  -0.6
 unbound         224     0.9   0.8  -0.1   1.1   0.7  -0.3   0.8   0.8   0.0
 unbound         256     0.4   0.4   0.0   0.4   0.4   0.0   0.4   0.4   0.0
   node0          48     0.7   0.6  -0.1
   node0          64     0.8   0.7  -0.2
   node0          80     2.0   1.4  -0.7
   node0          96     2.3   1.4  -0.9
   node0         112     1.0   0.8  -0.2
   node0         128     0.5   0.4   0.0
   node1          48     0.7   0.6  -0.1
   node1          64     0.8   0.6  -0.1
   node1          80     1.4   1.2  -0.2
   node1          96     1.5   1.3  -0.2
   node1         112     0.8   0.7  -0.1
   node1         128     0.4   0.4  -0.1

update_cfs_group profile%

                               all_nodes             node0             node1
		        ----------------  ----------------  ----------------
affinity  nr_threads    base  test  diff  base  test  diff  base  test  diff
 unbound          96     0.3   0.6   0.3   0.3   0.6   0.3   0.3   0.6   0.3
 unbound         128     0.3   0.6   0.3   0.3   0.6   0.3   0.3   0.7   0.4
 unbound         160     1.1   2.5   1.4   1.3   2.2   0.9   0.9   2.8   1.9
 unbound         192     0.9   2.6   1.7   1.1   2.4   1.3   0.7   2.8   2.1
 unbound         224     0.3   0.8   0.5   0.4   0.6   0.3   0.2   0.9   0.6
 unbound         256     0.1   0.2   0.1   0.1   0.2   0.1   0.1   0.2   0.1
   node0          48     0.4   0.6   0.2
   node0          64     0.3   0.6   0.3
   node0          80     0.7   0.6  -0.1
   node0          96     0.6   0.6   0.0
   node0         112     0.3   0.4   0.1
   node0         128     0.1   0.2   0.1
   node1          48     0.3   0.6   0.3
   node1          64     0.3   0.6   0.3
   node1          80     0.3   0.6   0.3
   node1          96     0.3   0.6   0.3
   node1         112     0.2   0.3   0.2
   node1         128     0.1   0.2   0.1


Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
    2 sockets * 32 cores * 2 thread = 128 CPUs

transactions per second

                                   diff                 base                test
                      -----------------   ------------------  ------------------
                          tps       tps
affinity  nr_threads  (%diff)  (t-test)       tps  std%  nid      tps  std%  nid
 unbound          48    -0.9%      100%    75,500    0%    1   74,834    0%    0
 unbound          64    -0.4%      100%    81,687    0%    1   81,368    0%    0
 unbound          80    -0.4%      100%    78,620    0%    1   78,281    0%    0
 unbound          96    -0.5%       74%    78,949    1%    1   78,580    1%    0
 unbound         112    -2.9%       87%    94,189    3%    1   91,458    5%    0
 unbound         128    -1.4%      100%   117,557    0%    1  115,921    0%    0
   node0          24    -0.7%      100%    38,601    0%    0   38,333    0%    0
   node0          32    -1.2%      100%    41,539    0%    0   41,038    0%    0
   node0          40    -1.6%      100%    42,325    0%    0   41,662    0%    0
   node0          48    -1.3%      100%    41,956    0%    0   41,404    0%    0
   node0          56    -1.3%      100%    42,115    0%    0   41,569    0%    0
   node0          64    -1.0%      100%    62,431    0%    0   61,784    0%    0
   node1          24     0.0%        1%    38,752    0%    1   38,752    0%    1
   node1          32     0.9%      100%    42,568    0%    1   42,943    0%    1
   node1          40    -0.2%       87%    43,452    0%    1   43,358    0%    1
   node1          48    -0.5%      100%    43,047    0%    1   42,831    0%    1
   node1          56    -0.5%      100%    43,464    0%    1   43,259    0%    1
   node1          64     0.5%      100%    64,111    0%    1   64,450    0%    1

update_load_avg profile%

                               all_nodes             node0             node1
		        ----------------  ----------------  ----------------
affinity  nr_threads    base  test  diff  base  test  diff  base  test  diff
 unbound          48     0.5   0.5   0.0   0.5   0.5   0.0   0.4   0.5   0.0
 unbound          64     0.5   0.5   0.0   0.5   0.5   0.0   0.5   0.5   0.0
 unbound          80     2.0   1.8  -0.3   2.0   1.7  -0.3   2.0   1.8  -0.2
 unbound          96     3.4   2.8  -0.6   3.4   2.8  -0.6   3.4   2.9  -0.5
 unbound         112     2.5   2.3  -0.1   4.5   3.8  -0.8   0.5   0.9   0.5
 unbound         128     0.4   0.5   0.0   0.4   0.4   0.0   0.5   0.5   0.1
   node0          24     0.4   0.5   0.0
   node0          32     0.5   0.5   0.0
   node0          40     1.0   1.1   0.1
   node0          48     1.5   1.6   0.1
   node0          56     1.8   1.9   0.1
   node0          64     0.4   0.4   0.0
   node1          24     0.5   0.4   0.0
   node1          32     0.5   0.4   0.0
   node1          40     1.0   1.1   0.0
   node1          48     1.6   1.6   0.1
   node1          56     1.9   1.9   0.0
   node1          64     0.4   0.4  -0.1


update_cfs_group profile%

                               all_nodes             node0             node1
		        ----------------  ----------------  ----------------
affinity  nr_threads    base  test  diff  base  test  diff  base  test  diff
 unbound          48     0.3   0.5   0.2   0.3   0.5   0.2   0.3   0.5   0.2
 unbound          64     0.5   0.6   0.1   0.5   0.6   0.1   0.5   0.6   0.1
 unbound          80     2.8   2.5  -0.3   2.6   2.4  -0.2   2.9   2.5  -0.5
 unbound          96     3.7   3.3  -0.4   3.5   3.3  -0.2   3.9   3.3  -0.6
 unbound         112     4.2   3.2  -1.0   4.1   3.3  -0.7   4.4   3.1  -1.2
 unbound         128     0.4   0.5   0.1   0.4   0.5   0.1   0.4   0.5   0.1
   node0          24     0.3   0.5   0.2
   node0          32     0.3   0.4   0.1
   node0          40     0.7   0.8   0.1
   node0          48     0.8   0.9   0.1
   node0          56     0.8   0.9   0.1
   node0          64     0.2   0.4   0.1
   node1          24     0.3   0.5   0.2
   node1          32     0.3   0.5   0.2
   node1          40     0.8   0.9   0.1
   node1          48     0.8   0.9   0.1
   node1          56     0.9   0.9   0.1
   node1          64     0.2   0.4   0.1


There doesn't seem to be much of a pattern in the per-node breakdown.
Sometimes there's a bit more overhead on the node remote to the task_group
allocation than the node local to it, like I'd expect, and sometimes it's the
opposite.  Generally pretty even.

> >    node0          48           0.7   0.6  -0.1              0.3   0.6   0.3
> >    node0          64           0.7   0.7  -0.1              0.3   0.6   0.3
> >    node0          80           1.4   1.3  -0.1              0.3   0.6   0.3
> >    node0          96           1.5   1.4  -0.1              0.3   0.6   0.3
> >    node0         112           0.8   0.8   0.0              0.2   0.4   0.2
> >    node0         128           0.4   0.4   0.0              0.1   0.2   0.1
> >    node1          48           0.7   0.6  -0.1              0.3   0.6   0.3
> >    node1          64           0.7   0.6  -0.1              0.3   0.6   0.3
> >    node1          80           1.4   1.2  -0.1              0.3   0.6   0.3
> >    node1          96           1.4   1.3  -0.2              0.3   0.6   0.3
> >    node1         112           0.8   0.7  -0.1              0.2   0.3   0.2
> >    node1         128           0.4   0.4   0.0              0.1   0.2   0.1
>
> I can see why the cost of update_cfs_group() slightly increased since
> now there is no cross node access to tg->load_avg and the patched kernel
> doesn't provide any benefit but only incur some overhead due to indirect
> access to tg->load_avg, but why update_load_avg()'s cost dropped? I
> expect it to be roughly the same after patched or slightly increased.

Yeah, that's not immediately obvious, especially when the Intel machine doesn't
do this.
