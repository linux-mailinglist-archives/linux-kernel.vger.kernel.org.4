Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9872974B253
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGGN7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGGN7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:59:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F371FF7;
        Fri,  7 Jul 2023 06:59:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367DruTb029831;
        Fri, 7 Jul 2023 13:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=xP52Cnsdf+5yj+BWl2X4rkAuMbKsR4uCyFiWrO1xrfY=;
 b=Q7HagMjdoFRbyurdYKfF6o8gMSKZvub7rSi0PMb+3T6cechWuX5WF7vAyGZWqtV/LTG1
 NTsJLq9ZEdJS1ZkGqloGjgmAbyP1e1G3a4+z4+L6cINbVlPKUfEBTyKNJGZGn5Iyx6uu
 ydZgEW6+RL+P7f/+2SVdkrd8HdIuJuUUeNCI/AGUBwjj4SoDriE4iq+QA64iusYkUtS+
 Yx16JNpeucYSF9LPcyYhfh0uFCXeebZPCzhZcCFK56Q+HOBUw6oUKtatykMrmI2ZMvip
 wN/Lt+85zQTM98Z3zUMQRXk7Uezi++EWsJiPiCDh9filIlIezqKF4zlbo0T2W176qaIm CQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc6cu36a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 13:59:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367Ds8CC013526;
        Fri, 7 Jul 2023 13:59:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8gh37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 13:59:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiwtJTbKwI2UecxSHSmgYWYNu0s3FsiMQ1yFcWzi47tYeXZeFrtORhKecvU3Jo3gTzDZt/s+tC2tx6aRK9BmyblsHdnPaFCDlEHTxlbHrTBqgvqIbgzOefh5T4Gl9deA1QQkNft5rtPzQ2PM8O3PeDe7/PT43MieEH/nXhrwVemU8QW9Xqq+MvTcnhPay0BwkWt8x2CIJlgyJrutyqmgHX2A+kNi+jzAzaPeT8Ers8b5ia/xqcTiy3oab3dn1C+0Q+HVCnBOrSRP9PNRDpk0VJZBlItmzJxEN3N+Bs3cIWrQGeDS0a6H+FfkElQM1iJx8HKs+7rL/Fn2+l2cCFKvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP52Cnsdf+5yj+BWl2X4rkAuMbKsR4uCyFiWrO1xrfY=;
 b=alQz62nksD/IDkEKOP2xegpJ2aoZ29Z8IrecEzHQi426CTre5u5CZWMHchm4V9UKpGmd6IJV3CJ3fGrFOj98wowd3KJBxpCidXkX/ve0bujzUJm3FrH1kV0iTk3dElDeVphT1ZBtdoG1qYrie5wfHiarSxs5jkakWFjMMX9kLL3fPoc7Bg8tiDynj2VvYY7eKK7zH/rMJOBdMX0/+G9rV6+wZDW2Xas9xap3XMUesROrowaPBZ+Ti9uOMYaLcM7SEtRppvTxh5JArePjIWzIfNFqFpMzJucpv9r+j/mTSsMdB4fZxU1+fDnXNeKmIN0UIT0PLud0K2geLUe98YbwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP52Cnsdf+5yj+BWl2X4rkAuMbKsR4uCyFiWrO1xrfY=;
 b=ed3cW4aIirOVKVtXbID2Zj339U7ne7MEqe2VyU3D8OjyqKzFNt45PRNAFYX19RSK+i9eP9XVzMe0z1dhBlTfvknkEq4XiqcU1eWlgFK2e/kIJndXWUsOY6sR7J8zslDIFcxuFzwEgv7FrNepgxOFFWUs+2XS2wt+nwXXd86gSQo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 13:59:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 13:59:12 +0000
Date:   Fri, 7 Jul 2023 09:59:08 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/6] netlink: Reverse the patch which removed filtering
Message-ID: <20230707135908.uchdpeqw2f5xy34a@revolver>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
 <20230704001136.2301645-2-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704001136.2301645-2-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b65ccb-2350-4d26-bb60-08db7ef25786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNf7KQ8D6VNBjuGn3AVBgRlFWVUlvqqws9qUN5ossp2tHLE+4crAzgXTfXhsaRFJzXjNhdrvp1RTrlIIxq21n1YJH84BoaypYtSBxNu7j3qm37QsMM0YWfWGad+DZxzqMzXEoNGK4vDybJrSDHk+cf1/d1IfFuol5YIay1ff/RMY9rcOAnjIXIfM7FzmPifYDd68K90rW/fdWAzm55fjmOtyRl0WneLqdg8H29Hc3QAvkKJI3wqUmn0191JDjM7gP4XQ5BJY6Gc0izHDPoXfgATondhqpuRUPhPbsi2DIs+fLZMjv7U+QX6vDs7wlRPzk6H0Wdkm3YMznhlv2yNnPcusv8nkXb6Sg6mKFLuQ4DIbi9FwFBY+jojqTkof1IfqcB29XFqbr8ow9IpPuJtYPprz395vQDYGOZop1q5ZD/q0+kDaWdP+ATvMWc64QRoz0y9Zk7FWMaKyNWCDisy0Hy6aA/Qn07EbhL1NquqUf0cgKOYUDmk3jn6kJE7m9t3Lfn+9IDwxM1VkCiFRf1PscpbDXpXRcGN1HjEqx7QennYxT254P9BCArJJPRwA1TmM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(6862004)(8936002)(8676002)(2906002)(5660300002)(7416002)(186003)(6506007)(26005)(1076003)(41300700001)(66476007)(66946007)(6666004)(316002)(6486002)(6636002)(4326008)(66556008)(83380400001)(478600001)(86362001)(6512007)(9686003)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+t78/bxjNU/W7YrdBa/Xj8Nc4j5Xt+Faq2xNDpPFSEvTYgaQ7V0hmRXlc3uy?=
 =?us-ascii?Q?Se+8+At1hMZ6PH3FA7UT9fBaChrW5OgsOilS0mQeT8omHOgCUTxyYC//+dzk?=
 =?us-ascii?Q?CkQnnvR8dYJ8zsnbwMJJeJv3MIx2r8sKyapaZr0kbEJBFrnBYYftRkxkjs0P?=
 =?us-ascii?Q?f3ent/WyLIlXjeIe/RbdfPOboBvEZzLYFKovIlS7ptmpYXTCe3+S9id/LEf7?=
 =?us-ascii?Q?9a8jUXtbT3oD7QooOpQ886vXFC4So/cT+zaDxpdOZ+RMMWY1PeoP2XXYJ5pR?=
 =?us-ascii?Q?RZYPNVk5Y6b1/BioSlhDl5XdGDDaYvCkW5fd46Jv/DP5rDAVMOj16Ru3mpMY?=
 =?us-ascii?Q?XxXoKIxL/zDFZD7NvzM5MidXHIhc5uupFOwsE6RRnrCKLELcN4dDXwr1+BPm?=
 =?us-ascii?Q?q4MCDs3xxw2vPocEfAvaYcOW0zvlE21WiZcnGEyRvTHke01uYhb8LqTBh2Ju?=
 =?us-ascii?Q?EHSRgbg5ulx8Nc2i3DZV5FpR/E9eQNx5pwNGdYQZHHkEszDMrMMukMH9aDb1?=
 =?us-ascii?Q?xv3JIhhMhun8cX4NY10GvSSBRyHmkDwnH2n5BUv8ySLES4M8IkHY92iBT428?=
 =?us-ascii?Q?5R468hvQxjTR16WhS4k3shQy2QZOh1jKxFgo2r+OZnGYU6mZQ8vUVmlfrEVC?=
 =?us-ascii?Q?yTtsYCOMM6OvufCUt/dc4pu+XZS4gKUEOhhO9WOxOK+xot1CfA1+BahVx+Yh?=
 =?us-ascii?Q?MGa85IXoWOcIM95Ai9wxLv40YjRfNfZK7irrbmHinITDPjmAJAnhfVgCHNmu?=
 =?us-ascii?Q?NLf006M3tSxRcMmkZht4LLc7mRzYakmpwuYJSmtwmThQZwjWR7SRZmqne6D+?=
 =?us-ascii?Q?DT6LRIXOM4IaswYPs8P3InKfLXjvWtLXROpmN3+fSE6qv/hZFSeRu3VfSVyA?=
 =?us-ascii?Q?O+9jedPTeAcwq9Xqp9QlDRRD6X0g5tLsb26BwBe4c2fm2YJeo9tYOZZbjsvC?=
 =?us-ascii?Q?iJnwBUUPYNBIn+rJQfKqaUr3/Hjn43v2gNH0SiwgtyoRszqxxcQ3UtbhGMuA?=
 =?us-ascii?Q?7q1Eu6X/fonLQgAo2ACGUtipycmlB8e/4QDLhYW2PRDUgMjgBTUEwt1Mdi1r?=
 =?us-ascii?Q?u552YsuudYNtHZkSEbHBRwysALVKlSno38HIyHyIM8X0a9EGHTFDuaEcHBKc?=
 =?us-ascii?Q?LLMVWBFIBbmzsjvQCjINOMr+fogiy4y/X56gaGUtiqI+ZGeurAI0bTUmUyTs?=
 =?us-ascii?Q?OFLqoMxPysziRbO7/APVDq7XK08YhSR1/aDFVsnW5stQY7yon4Yi3J4KPa1Q?=
 =?us-ascii?Q?0VmCxZgcbYF+uJyrlCdbtOtadQBnYOaDQoMqhWlMvHpkAPT1DhKT+/VhOtsH?=
 =?us-ascii?Q?LzDTbRAttYL3TWq99UWELXah7swthbZKpnrzHkv8JUR8VW8/rfYcjV+SXRcz?=
 =?us-ascii?Q?czZGCIL0QeM80Mr3+F+Y0iSJBAP6q3tpyOaKvXwGJp+46ELNS6+Qj5QMua5R?=
 =?us-ascii?Q?vrIX4zrf4HLi8qcMhVu8IaAQ0O6ab/zuDiscaHZWjen8aYHj+BfhdaXffKhb?=
 =?us-ascii?Q?jIgI2R6VS7xReFOr/WHQicb8RWGUARyEA5/aJCcJOEjpYzlQdC9eYKcnlwIE?=
 =?us-ascii?Q?2rydY71vEcdDO2QYrmG2pCK8ZBeQE7OPR0Mt0U3U89ewVeurtqFc5ZzA8zbd?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fOmITroffDvP0f9Kzp2jEC5jvl5zopCofdD9Gt2vz+CBfqku3MFOIsuhuVdk?=
 =?us-ascii?Q?98fFIga56PZskllEA3/sxQoawR65VW2Z/RRkyQKCussTpYAT0EMwbIoXDcJR?=
 =?us-ascii?Q?eOLeAGmsHb2dXD2bRJIrY9H+fu8vripgMX0vm2wD3Y/xPQuAMP8qt/dq/Sm4?=
 =?us-ascii?Q?lRFbfTM9vzpmRwI5ikrlIvHWgikzqH6nXyVuFwnqhcClLH713rtIQXAVgHi9?=
 =?us-ascii?Q?x9f5QqS3v/0/VQFGx8u8UA8NuL0kb4jtWFRn5KP3MRW3MVtAvopX0F+pCd2B?=
 =?us-ascii?Q?x2TtfKCR0VG7TTKvWmYseWrUWVOisQzqMBeQKNaGpEy7T/wByjgSW+ckIsPK?=
 =?us-ascii?Q?ro7ZA053LHorcAN4jEt4LpjTPRBaxAJn10Az6X7xkIkpVaitzGm55ux4Yr6A?=
 =?us-ascii?Q?1y1UnU5754idHdmg8pV13aMdkeBB9ps19UOBXHt6v0ycv1gVVom6GiMg8Cju?=
 =?us-ascii?Q?FCcd6rQJsSDfhzAZnj8izosWMOVGgxd3bUA/Q+OFgDYTCepHjFZK4OUJVjyK?=
 =?us-ascii?Q?YFPEFtK41/tYvemzF7SqGRJM9yN1j/CTxLba36+ZUEuxU5yoZAEae6ORoJ36?=
 =?us-ascii?Q?1wf8scEEiyNQhNzuCMKTB42mWyfRJcu8Eka065qWsLzsIMUag8rANY5FX0QC?=
 =?us-ascii?Q?PWMCI02fcx/QWSVx6zCEZCXhbBFArix61KjU4Dcq++PmqK9rFjKnx8FqCfao?=
 =?us-ascii?Q?0Tgfau3WPddPK5Nh0atuEkujeRRgZJMtgUCIvxEacb7PVfbmtMxRfAoOYeX9?=
 =?us-ascii?Q?sVahj0nn9iCTCGICeF6i7W0mAEUTSUqwjRTdmO4pBDDkb/Z6ch8UnaTDSSsE?=
 =?us-ascii?Q?olu2roggrYhYGtPUecBkujs7P+BBHPvyX0AMjXZEWYorUEje4InpfAqg8rxh?=
 =?us-ascii?Q?ioGRVJAInUu3uY22KQj+QVXN8hb3PVBp75QI3zO4tjNUp52AlGbZnciFyslD?=
 =?us-ascii?Q?uwpA7+yYZO2Efg3Tfmjwpo7SpLK0dsyTdYTqIfGihuZzQzCFW3/bHfGhNZlE?=
 =?us-ascii?Q?MT6fwETnRy8cBipXM3O1+BnGKyrRHDxSkpdkd541U0399vZTGfXWL3YzuRmr?=
 =?us-ascii?Q?laqZ7hk5ldR1HOphllK6wNJKMzDrzhMUOoYqLhOevzzCy3UJL9Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b65ccb-2350-4d26-bb60-08db7ef25786
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 13:59:12.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4lR4tZToBgkkU5UtlCmMpxavETVHK+D0sFVd7lIWnhGpQAxfjyRq2NsbgT8cY/UjN+1AXrIR4AyiZuhLay3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070129
X-Proofpoint-GUID: 387MxhvFa2ccFwrrvZoiud-YujMzvWfX
X-Proofpoint-ORIG-GUID: 387MxhvFa2ccFwrrvZoiud-YujMzvWfX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [691231 23:00]:
> To use filtering at the connector & cn_proc layers, we need to enable
> filtering in the netlink layer. This reverses the patch which removed
> netlink filtering.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/netlink.h  |  5 +++++
>  net/netlink/af_netlink.c | 27 +++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index 19c0791ed9d5..d73cfe5b6bc2 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -227,6 +227,11 @@ bool netlink_strict_get_check(struct sk_buff *skb);
>  int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
>  int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
>  		      __u32 group, gfp_t allocation);
> +int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
> +			       __u32 portid, __u32 group, gfp_t allocation,
> +			       int (*filter)(struct sock *dsk,
> +					     struct sk_buff *skb, void *data),
> +			       void *filter_data);
>  int netlink_set_err(struct sock *ssk, __u32 portid, __u32 group, int code);
>  int netlink_register_notifier(struct notifier_block *nb);
>  int netlink_unregister_notifier(struct notifier_block *nb);
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 3a1e0fd5bf14..e75e5156e4ac 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1432,6 +1432,8 @@ struct netlink_broadcast_data {
>  	int delivered;
>  	gfp_t allocation;
>  	struct sk_buff *skb, *skb2;
> +	int (*tx_filter)(struct sock *dsk, struct sk_buff *skb, void *data);
> +	void *tx_data;
>  };
>  
>  static void do_one_broadcast(struct sock *sk,
> @@ -1485,6 +1487,13 @@ static void do_one_broadcast(struct sock *sk,
>  			p->delivery_failure = 1;
>  		goto out;
>  	}
> +
> +	if (p->tx_filter && p->tx_filter(sk, p->skb2, p->tx_data)) {
> +		kfree_skb(p->skb2);
> +		p->skb2 = NULL;
> +		goto out;
> +	}
> +
>  	if (sk_filter(sk, p->skb2)) {
>  		kfree_skb(p->skb2);
>  		p->skb2 = NULL;
> @@ -1507,8 +1516,12 @@ static void do_one_broadcast(struct sock *sk,
>  	sock_put(sk);
>  }
>  
> -int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
> -		      u32 group, gfp_t allocation)
> +int netlink_broadcast_filtered(struct sock *ssk, struct sk_buff *skb,
> +			       u32 portid,
> +			       u32 group, gfp_t allocation,
> +			       int (*filter)(struct sock *dsk,
> +					     struct sk_buff *skb, void *data),
> +			       void *filter_data)
>  {
>  	struct net *net = sock_net(ssk);
>  	struct netlink_broadcast_data info;
> @@ -1527,6 +1540,8 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
>  	info.allocation = allocation;
>  	info.skb = skb;
>  	info.skb2 = NULL;
> +	info.tx_filter = filter;
> +	info.tx_data = filter_data;
>  
>  	/* While we sleep in clone, do not allow to change socket list */
>  
> @@ -1552,6 +1567,14 @@ int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
>  	}
>  	return -ESRCH;
>  }
> +EXPORT_SYMBOL(netlink_broadcast_filtered);
> +
> +int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, u32 portid,
> +		      u32 group, gfp_t allocation)
> +{
> +	return netlink_broadcast_filtered(ssk, skb, portid, group, allocation,
> +					  NULL, NULL);
> +}
>  EXPORT_SYMBOL(netlink_broadcast);
>  
>  struct netlink_set_err_data {
> -- 
> 2.41.0
> 
