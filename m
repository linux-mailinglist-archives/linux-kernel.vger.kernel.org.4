Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080C6D0D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjC3Rqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjC3Rqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:46:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE32CDBD1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:46:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UHNiaq013095;
        Thu, 30 Mar 2023 17:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=AIsi0VTQ5XZB4nWcCj3f44QUU9WatEsQqF31mVJEUqo=;
 b=lQ2I1mFiLKda8gB+mnoToK2iGDkfEbLo5qFpED86OqInKzMTtQZP5NU9wgxeTTPSyPCt
 ocy3l4ABzAwcfjWvkQ3kCxKay/vvJSvqNGxYdYf7NKwahQBtNtHIxM4U5itTmTWsKexS
 JR1Hvurl1hFv6r0apGZrc/4hvYGqxzqNuugYACEaAmkgAHnMpSb+UyVfZoKkjvX/lkNS
 3nCrDIsnsgcJl6M+F1w0HxrC2/dVI22DIubZ6BrSeIEIFjEznAp/cMoyuYyRakjGYJsa
 Jer9G6HKBIS+Z37zEKLAiu4U1m0iDi/TZXaj025tU9waK0Tio1IVwDqdvDfZNeB0ReFx qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmpb4ujp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 17:46:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32UHcGho036472;
        Thu, 30 Mar 2023 17:46:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdhk6fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Mar 2023 17:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/XCtz9avTuqj0aAeWgTh6ibh2gKqprBwwKgrzhna5LUWS+COUztQ4RL2mxQKJ7WedwW2N5mL4rnUfL/Rul4mAaZpQm9Xmu9FDIL36PT882RmvjATR9ihroB+XfeM6sJ63tCTap4BBzTqGATqKuGZhfD3AdGdqPPRc4BFjNMxGWGsbWdzXRf5QTXMI0oQ9GnjymIv5vWa6htoCxB/YIs/n/xmSzi5aHalrVKNs8TIDVWNe6+DqqlE9iO92MUm8lH0AJuYH25TRhkZLuvg0VQ3O9zmDH5o/sL98NNKterWsSgg2FG73oPHyypaj0dy8ipKdDWeLTlHOfQFGvq5aqdxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIsi0VTQ5XZB4nWcCj3f44QUU9WatEsQqF31mVJEUqo=;
 b=m+6pW0nuqwOtg9UnTEbxn2D7kVvqBIgEAGZ1wFVgL45MGl9kMI0U1mwb5jOqiRjonhfIrfXjqiVaspQWTR0FvzueEpJm6SxPedNaMi7r/Z9GRnMa2sZoN+qdhGo8tOEWj7oajh48vagY/Q77yYvRzZitLVSy1Zme5ivuRb3e61U19T11F37IX93UOGDO/hgUzhdVlmeFbRbnDecBlxqjIvKEWPu3HKawBx1pKsqRdwMuqCjmY8PY7+oBR97PGCIRSaKprdqxwiThubR7Btr01ApiUp5DNdgk9ZK7plsiDLhXiufi9upVPiKDfm2+EQYE35AvxPpDHn0EnTJYVNStjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIsi0VTQ5XZB4nWcCj3f44QUU9WatEsQqF31mVJEUqo=;
 b=YwI3E4k49dI7B8Iy+sjWzCl7AHfRA3Im+ug/VbU+vxtBexlJOONPJx6DfLyrwS6lUA6XJuKHW4PHREHmofMiuKJXNKBcij8u1kS9U8z6pizeDpWUpkdfOIaHIbf2bkcEWsUTEDVKA0NDKU9URPH5V82YkzTJ9ZOmaGxSPpG2WQc=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA2PR10MB4521.namprd10.prod.outlook.com (2603:10b6:806:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 17:46:02 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::3e0d:2900:bdbf:949f]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::3e0d:2900:bdbf:949f%9]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 17:46:02 +0000
Date:   Thu, 30 Mar 2023 13:45:57 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329135455.GA108864@ziqianlu-desk2>
X-ClientProxiedBy: MN2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:208:178::38) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA2PR10MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: c544ae3b-92e4-4f4c-c4f8-08db3146a0c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4x7GuQNL8o7cmdIIUwyr9ItYW7BEcfPyvBhLQJauF9T+IPLN1t55S1H0DG6DbwYBRixtVbL89Ig3G/DBj5NFKvTJKRLqwxu8W/SjZ0hDUklSBfb+JkQoN6++AJlzX2NR9EsFQ41hnyinIkb1icztJmcmDJ9Ru76YtTs1uJJQlzIVghlPFUegK5j8BYs307myn3sBs9QhUcg8Nlx9txygzjWHmaSPQL8RV/XNHCSRK/E9H6o6Sen915Gwwu4HITKwrLW9zsT2//zfQse7ebWcbcmIFDdyUArqg2CFVAYeA0xYo65/ssea1dLEyFaMfwuAygHADFkky5+j45Jj4vBjcl+GPvqWxFADn+tiBhhSo44GSEuP9IuMcgx3+ahHKJC6TbPLhGYVQr5NWhGeUW/lcIw/jfd4jlvYbn1cDR4uDiJSKRpLCxsKLokWpEEMtOwOLpHK+w7364s4DXbYSw13dRLfWD3swqmaUHkF9wpHAOQKBHMr9O+gvozkhElqtqKkykuGZOgyV/PN2rs1E3Fw8q5sOMtEmuape/fc+p3HlSOz0+BxdtYIC1qVJh3GxGJ9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(66556008)(66476007)(186003)(66946007)(8676002)(4326008)(478600001)(54906003)(316002)(6666004)(53546011)(6512007)(6506007)(1076003)(9686003)(26005)(6916009)(86362001)(38100700002)(8936002)(7416002)(5660300002)(6486002)(83380400001)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PcWTqkyZVU5ci5h7UVCjjKRbSer0BeZiD741mxkA6zVVCfoBUhbDOketuLFQ?=
 =?us-ascii?Q?SEZ9Y29QG03F0Y8c5fV12hp4AcfPDZfeAnFXO/7fXMf4ydWmm1CshOuM7eZv?=
 =?us-ascii?Q?Um42WAd2fg0M8CnGAhD9/IvEqQX56TeIfzz8wG7ttsyPFn1z6o/65FHliT/u?=
 =?us-ascii?Q?WH6L9/KGVMzw5nUgW8D/aPgDRxlsYkTSc9r8WLEDAqEqzAgnsB1kxuFZBCw+?=
 =?us-ascii?Q?P9pp3DnTAKRlMsmaJUU3wXlMcIhjIoxSxh1MOHlXKcmlRKscgITdh/iIJl6p?=
 =?us-ascii?Q?m2hsYbYH15RvQnLgROXxDflWe6h7V1BXiAol9LwfEfknTUMhkBvp7QuE6vAQ?=
 =?us-ascii?Q?P3VI5A1Bu974IH16yi0S4+jOnkBV/2te8D6O4aExC3f63lQctn5Cw3SN+T8U?=
 =?us-ascii?Q?l+1ekb66TK47nfObNthPyautUfObw2HolO08TXJ0UCdJd+Y7rPNxJz4M0INy?=
 =?us-ascii?Q?ZlslM31E6O5FhoMRgoMxdt3YGEsckOFQPTTY/xclFhvntUPwYMjoSpKa1NYE?=
 =?us-ascii?Q?57xzywBAuKbLPo52yDQKSkHRPf+Wfv3vDon/0fkRmxWrI6juGrBTMWfN7qHk?=
 =?us-ascii?Q?nj/A8WV1+dIWKI+Z0iZY/igqROAe+/jfXQqIZ12O/9r2p0dhGHqgnrYrDpGg?=
 =?us-ascii?Q?Vo4tqGMHx3vdhconVtBlCfuX+O6jj8NsiR5uBqjlbGT65og+1vY5zcPsivb5?=
 =?us-ascii?Q?FVJNQk/WlCjP/S8eqy5+9eh7BCEKgYd6WQCZWyNvQTWmgHKj5m4psLELSs8S?=
 =?us-ascii?Q?netvBElTxcHIktDd7OvLvq1L/LIg0HClXvDID9+xR/xpa2QE81AIop+I2Zqx?=
 =?us-ascii?Q?vYuimyJimMZEpjbsl+NyPHZQmRT2ekfib1ashV5oI/Y5uMYaq6ZB2GcDIzMG?=
 =?us-ascii?Q?YUijxfiQh0OeOTIjoZjXAHuoywp5lu9cpybX09RTqfo9lOWWf1tb06wS3z7j?=
 =?us-ascii?Q?bYpQWdz47kIRIuyZi93b7FIXySgoJWvQZ4F4LHkY50+qHFbGxVr/YcheIJKH?=
 =?us-ascii?Q?5LHVGaZ2HgggC1mnJRCfpF+YvvDLKd0rer6UTrzMlumbj5BYXx+XkMn0a4Np?=
 =?us-ascii?Q?kRxBZa39uGCL2YLBznYtYMrvJXHYPt7kO7cd18h8G6SRvfXplHLUPs/589gP?=
 =?us-ascii?Q?jxBrNcRFkdgaCh0rxgo1ndcuGdSswaQSyG7cisP9zX+HXNhMg7LkY6Hfc7MY?=
 =?us-ascii?Q?QwcVa9qiJAP5MiA1eYxILpItplXec1ZOuUsIA9bTWrascRqO05xVvv2jAqMo?=
 =?us-ascii?Q?jUFqbNxPtfdDCMxn06ZuCBEr0/56Rtlkqlbiaj3sN1+vky13jMbvqNlJ0jeo?=
 =?us-ascii?Q?8GXMRyEf4rWmGV7GkmzroDhD1SvINaJMFcV2rpmlzmztNzk8EQrNEd6QIjlW?=
 =?us-ascii?Q?SIhN1LzcB65AhD4pzYNx8XiqUFoFBpRBw1CqVP1Zu2xzKnsfOSKqO51CMvIO?=
 =?us-ascii?Q?0E4/k6d+98GxSfOwxO6N9daD+Y09yxVihUbyexxVTDD9X9DhlePZW6yfwWhR?=
 =?us-ascii?Q?z3pa1B3wgRgwiL0cos8YxsmPNDfiatU8wR36IKQ9Y8zk8ctgJ6w0KQI3vFG4?=
 =?us-ascii?Q?Zu35gR9VmeP6mhc6KqTeQ47M1Cs1VqRt423hbka/YX1bEfn5dNE4wCHSuGJb?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sXBJPzf9pGfPF1Z9IQR4F+6dp1f62zDhgpqwdxgWWQt2h9p/xPRyoM/YZTix?=
 =?us-ascii?Q?4kztCZaLJyd8tVObNu/WzJJjjDGpGkvxC/U/3ODhl/yVyErsnFatvA0IPO+P?=
 =?us-ascii?Q?IzSNqAfouIxceZ+NP1SPWegHAXAJKefn+2Uxc/cGH1VZAAguG17H1e2zL2vm?=
 =?us-ascii?Q?eHC1peGv2gGC+gvQAvkkM041/KQQysfXlvsk6QHI+DXylmfp7K7HwKsx3SoF?=
 =?us-ascii?Q?W28ef8FysMmQJjRTC/P9ZHDN6FkqzssPW8i8m8W8iUJbc4aeQmWNuwHTsa64?=
 =?us-ascii?Q?xVrS1IQrPn3uSaMenBZmRxAeicDlRbZH5TzrST3RFjTUS+oAhKNhhsZSeibK?=
 =?us-ascii?Q?Go0fURvZMPUcGXkchtevwDAbWVJLMByS2GXfJJIQn/zR36MqR3rR+k29I751?=
 =?us-ascii?Q?K6kVXxPEwgLDEcUwF9r2FB31mPkA6Rs5jo/hb0ytlpvow95PsmHhnt7fcgWe?=
 =?us-ascii?Q?2DBjrlee9F5rQroFvSGAwM+rMG2QzaURrVi7A1Hlh/R+jX1J7pry0MA8cd4a?=
 =?us-ascii?Q?WSZQIpSnkXtHBHONJ1Q7HWrDc3r7twcr3B7aDXajcsaJ/mzkVZvy7n/3Guwi?=
 =?us-ascii?Q?R2DcNvcbDiqATiFQ1EU+1N4TfyorL8+0geWOX0S7WF/LqzBBgUPSxrOLskoI?=
 =?us-ascii?Q?GxOoH6R6I7pYIcPJ/p1gfZaI0BvXuzxMBJpNBFnOjNwuOtDjmf4OIrU8jVgX?=
 =?us-ascii?Q?H8hzaQKcXhqo1NNYotH4493wpGw/3ppl3Q5WcHhMuabJ5iowqYny8U+E4D1h?=
 =?us-ascii?Q?VN53Qf2ko+XfxFrxI53nSm17gMhTka8L20bLjRwbEpnfB4VOyk7V6hBlsFX0?=
 =?us-ascii?Q?9UDbfXefcmONFkj0pWCuGzeqMqMucDnfINC9rH9FvfPGV1Ck/FjicgiK6DbV?=
 =?us-ascii?Q?PAl6su9sSsbWsV9GxGUjH7L9VYq9iAZwdl4t/WcrCePQWocJWkIl9zN0ksi/?=
 =?us-ascii?Q?ttZfU7Mq6LDY1zTimqhoUdu2G4Jl1rDcGj/cvLkOzH8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c544ae3b-92e4-4f4c-c4f8-08db3146a0c7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:46:02.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRwba2XAKr8EOXqr//X58iisYHa7XUQmU+lMgTRwJOodCIVabcbzkeVSRG9hR10Q9YVJZQ8qFruSvWeUoU+Mg6owyua1ZBQ0lwZJoZa4y6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_11,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300140
X-Proofpoint-GUID: deKKDxp2IablM0o2fEggRR2Z_7w_IaSv
X-Proofpoint-ORIG-GUID: deKKDxp2IablM0o2fEggRR2Z_7w_IaSv
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On Wed, Mar 29, 2023 at 09:54:55PM +0800, Aaron Lu wrote:
> On Wed, Mar 29, 2023 at 02:36:44PM +0200, Dietmar Eggemann wrote:
> > On 28/03/2023 14:56, Aaron Lu wrote:
> > > On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
> > >> On 27/03/2023 07:39, Aaron Lu wrote:
> And not sure if you did the profile on different nodes? I normally chose
> 4 cpus of each node and do 'perf record -C' with them, to get an idea
> of how different node behaves and also to reduce the record size.
> Normally, when tg is allocated on node 0, then node 1's profile would
> show higher cycles for update_cfs_group() and update_load_avg().

Wouldn't the choice of CPUs have a big effect on the data, depending on
where sysbench or postgres tasks run?

> I guess your setup may have a much lower migration number?

I also tried this and sure enough didn't see as many migrations on
either of two systems.  I used a container with your steps with a plain
6.2 kernel underneath, and the cpu controller is on (weight only).  I
increased connections and buffer size to suit each machine, and took
Chen's suggestion to try without numa balancing.

AMD EPYC 7J13 64-Core Processor
    2 sockets * 64 cores * 2 threads = 256 CPUs

sysbench: nr_threads=256

All observability data was taken at one minute in and using one tool at
a time.

    @migrations[1]: 1113
    @migrations[0]: 6152
    @wakeups[1]: 8871744
    @wakeups[0]: 9773321

    # profiled the whole system for 5 seconds, reported w/ --sort=dso,symbol
    0.38%       update_load_avg
    0.13%       update_cfs_group

Using higher (nr_threads=380) and lower (nr_threads=128) load doesn't
change these numbers much.

The topology of my machine is different from yours, but it's the biggest
I have, and I'm assuming cpu count is more important than topology when
reproducing the remote accesses.  I also tried on

Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
    2 sockets * 32 cores * 2 thread = 128 CPUs

with nr_threads=128 and got similar results.

I'm guessing you've left all sched knobs alone?  Maybe sharing those and
the kconfig would help close the gap.  Migrations do increase to near
what you were seeing when I disable SIS_UTIL (with SIS_PROP already off)
on the Xeon, and I see 4-5% apiece for the functions you mention when
profiling, but turning SIS_UTIL off is an odd thing to do.
