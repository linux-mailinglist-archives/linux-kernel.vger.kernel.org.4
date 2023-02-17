Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E6769AF17
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBQPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjBQPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:10:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262BE12845;
        Fri, 17 Feb 2023 07:10:20 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hppb001445;
        Fri, 17 Feb 2023 14:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=buDlxwX1ZSIfk1QL3TyZgV0NbE/WEPbEBU4QLRON5Cc=;
 b=OBMBjoyjDcydeu3a/fL7ygfEZsyNA3ZcO4MjBuKJ279qQs/FsWm579pAwFXVRlgv/WYi
 S2GNruDtG4tb9Izj0Fe93qf4az8OGxdTTQLq9tskkmlQUkxAf/Lkqevodimxin3FBau+
 c5te/34ztpM6MaC8Z1QZXhD6HFt07iMb8UqXeSXqnktWOTa+5To5aVaj8b7NzCk/XP5w
 yySbZv24JOErcijxemGqPzJa/Rb2yo5hdYgwB47mBurHkjdQe91nTjEmq6NQWcVNcO5I
 aK1VHfTHdhz3ymZpHMz0v2ZRnfCCUCgIAu1+Uenb5wGLsx7PkAZrOHcLhO9ZGUGjLzA8 Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1ednuk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCHgF7012229;
        Fri, 17 Feb 2023 14:12:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa5061-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:12:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaUl5mdXDT7ox3ot8iew6vsdlRKyIL2IG7C9hfkB0bLneLp0Z8ZCrJ2zf9OWYrCEg4sdiPiNtft7diQS17z3WhxsFbegi0rJTtjF01NzZMA/wt0zVp3WK8E+SmqBIpso2jn8F1brVPNtH0IyC7Oe0QrXtPZND1+jgEcsSat4MT77Yih0JAHgQJHOCMeO1gVWqiMtYCwpX0QaKxi34bfqNWWsRjvPfbNPUdux4KhheFjgs64PVc23IP1yvYbw6Aw5+iT4Sqi9knGiVVAYnBCx3lMiBSiEMcmzj1nHddxYDg7+Mlv+TAQzoSfy3hvDQgr8vlCM+nDOCfTUHRxvKVyxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buDlxwX1ZSIfk1QL3TyZgV0NbE/WEPbEBU4QLRON5Cc=;
 b=YH8t3QpJ/z/Rw54oO4pslaLvXLdQ8Y7bf6UmX5oY8I7wCbhjUgmaO5XfvIrrajk9784beMo4VVo0PEUtsGMbpFi1HpzYDJP0YwV0CPE3czMqKCnMR9TsyehFXbNEU/0CdABKzsZVlewyPjgnsppc6aqD5Cd2kbQZdACqanChx5sIVWajBfRCSqlaaSkvWVdTuRzBaQwxQ2xQruEvS+HbvVybWQR6l7CZYcCfFDw2ziiYBwxlF7rYJIHc1rIOxcnW1x3FQN9srHDVD+pBkQBfRiLJ91eiNecw7QTGMLqv8vUI9NGzSkllDBpxO4IZ5QJoLjFA/mY9pEN+xSeMsJxVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buDlxwX1ZSIfk1QL3TyZgV0NbE/WEPbEBU4QLRON5Cc=;
 b=OyNx+2s9TRCklxs9N8svfHLRAf2zkgFqp4wNfFpqSdY94KXY0LigTJiaa8ZvooK4Uc4jKMOOrfBPlie7TUr4mar1VhWfJ+5QyKragw6rhbjrIsYHRTR2LuXBiMjEQsSUNggeka/uSoznuNEtfcq5Rpd31L7A9NJZBopUoMFb5P8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:12:26 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:12:25 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/24] kbuild, irqchip/mvebu-pic: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:51 +0000
Message-Id: <20230217141059.392471-17-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::16) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 260f4a57-9907-41f4-0cc3-08db10f0fea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tbzrCnrSulNaQmHzqBcBoTh942l+DLUdwGDHiAeqslFy0xHopFSQi7W2RR5c+COUuxMaXI3AcRd9j3LezvK4zN5vY89jlq4VyFj3i0CuTVd8hQLeIOpoWSluRHhQpEkyJLECnWRU+tSiAsVTC7b/la2HD/5m+5ceZibFkW3ZqtF/W7vwh9j+gC0lVdEhZ0IFtSgTKd1IJPsogpiQ4kBWoSiRwxtBiFNRjuj6f5MPuWlFjKNHOTlxPUwG5XpfIM6OMB7rIlzOHLm6qfB+jN80fgolZ09XkZJJrp3IlA4C/IiADzHg3adV4F5DV/vdB77ZmOidzkE/GEQnZeilF3aLbL3vPGQUDgFR+noe6VqWrx9EYZxDXbjPCdPtw/R14nG1bMrkAixUfQ34dV7euVRahmZegTgN09mOALyGXi6khrgkHX4+e9oomP45NvnI6ka04Lauktk6TJ40gx87uW02/ipJ7GdgHJLfuxep2D6dK6JD7OFO6zreg733XN6TSnWtVcWTJ0XcToezcWptGOa/o+2qaLj0T1DMol0HRWykH1BZmJ+4aVk9nMdemPnaWOhE/763RCCBWGLrUNsaSjodLYBEK2V28tl6UUxUWRDYUw63WZ/l72qqzxW4Y5OEx7JHNI0NsPAWvKYddDWhym9HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(7416002)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KQOhsimr8caRkqW7dIQsUcA1MbIXiU4OhPbntd3TS1KBO25UkEey8PiQs+Q?=
 =?us-ascii?Q?4hGusp/kdU6g4IxtTBFa8QBlrP3QTWxATh9HsUPKQposUohb0Ocy9eA2/ELw?=
 =?us-ascii?Q?Hih2X5fsnbeO8WDGjegiiqA/W2L1auX52dE+27kqb1vLHnkBJXHN3TZnraQG?=
 =?us-ascii?Q?HV9P24F2yN0RN3ACwzcLx2yNcyvjaBqieOhGeJmYLX0oK518rpuf1dcBRJ8c?=
 =?us-ascii?Q?1szCbQqvhMphiN+HGDplHTKYIqYjeHTBAXsAqJiQUpag1MuLAHHhQNP1cT2T?=
 =?us-ascii?Q?hRWxa2wxL94GGftmmwW2GETDHNYcku0Dj7Bvn+h5wgPGlxPZmNLETn7x1g6R?=
 =?us-ascii?Q?E33I3FPepStLqTAV4YQ2VPi8cXJLbVxvctOKSzVAUEvW0zHnZhOMltDEpUvC?=
 =?us-ascii?Q?i9cluqpnzMD0U+CkeMeWEazAyolzXj6c1kptE+wFkF5n3T8uByxRy78ql/u1?=
 =?us-ascii?Q?bU/vg+u6wAHsrrorR5zDa/my+Wlan9MFj+302zNg08vHJ/e1jP2tfCW3rgAS?=
 =?us-ascii?Q?rdIVz+cDC0JHSgMGSZBHeAyUa9xbMMHR8aiqVbWJJ5s1IburbDM1KgfjGpX4?=
 =?us-ascii?Q?cJaSbzgSbNcV8L9JxIy0r8M3ZSuPdzjISl7CCYP4rkxHxpg2h4QKO1IDHr1M?=
 =?us-ascii?Q?PgZ5ZNJo3nbiDEAxc401HIr1gxdMntSy9pgcM7f8D8xpWPlSt5m0RgzHrq+m?=
 =?us-ascii?Q?XGxRdh7wpSAiXGMc/ro2O8KH+EpB5XXAe/B/9iifo4Iwo/R2EcEy8r9Mwdp9?=
 =?us-ascii?Q?hMLaD4D63vr0rnsXWFSZKCgcgVMcqqbX5c8UtqqbAlz1qdNickgJZ5Pug23L?=
 =?us-ascii?Q?tBMZtWJKEOeI9GP6CKLvfXbe5F4MdV5uuBOzJYYoMEEcfUSG13DvNI71fiQC?=
 =?us-ascii?Q?Bv2IyVxw+PU/8sUATBrm6nRnvQMx8mZ443LBHW2hkOm/51P/F4ig6gq/p9G1?=
 =?us-ascii?Q?Y9kQ6qz7P8sZ8rXPjDrKOOUvRqc2g4ifitOeQR3pa440yHpvpog9s+1nmNN4?=
 =?us-ascii?Q?6BzR/oW78MHLMeg4CkK8pLEQIk/n/jHpyUZRVBaIqir3MGLkJhQtpO7r8Poa?=
 =?us-ascii?Q?fkyS+ehIKsz+W9YQv4O4FTznC1jQm4OjRoMgTww4y3q5v8wg9pG7LcjcsnYu?=
 =?us-ascii?Q?ckwM4KqY1UcTEGieEGubgoKs0YVrNgENcV+/3RN4ERdbBIAlGBQXNlb+fRep?=
 =?us-ascii?Q?VuKEH0P5HbyoeRh6pY71g1S2B8Fv33XC6y7TVWIPsvGbkdQ2Zh7O2WAGleu4?=
 =?us-ascii?Q?seDzzH4V2SHSLu78JA6ITP7TQcgdWBOtsSaOy7c9+uXCvpjWrq/1uf9gM0J6?=
 =?us-ascii?Q?pvOkwpDp3KndGdzRmvatp8Y7MPYROqzVa1VEdGYbt4f26hs/b+5GTKJxKMqH?=
 =?us-ascii?Q?mqS4NDCHp5Dvn79Q5mV5okgZ4AXgHDdagxSABzIqCHP79lniCizovV2CNsDe?=
 =?us-ascii?Q?BmXcaMpjjiOp4aBgQ5vAho203sxfbx9uulTSEq+BvT8ZS48ocCKVRpXpOwEC?=
 =?us-ascii?Q?mG+cUwQ/jqx3N+L/tAD+lNHPIQeg+RWMY3zfbgx/NxPWq87tDkIR2E7vCvUY?=
 =?us-ascii?Q?6WI3bzolNu9y6kJXpRDjElsqnZBt5PuBht3X2UU/Um4TaAFS97Nd+nSVDNUO?=
 =?us-ascii?Q?YE2DPBi5x0fL1pnS+1+ilNQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5HzQ8dSuPhLY07kjXFBX2JG8W2kIyyzNdoIdoUeGeSmpQjPV5jdm2Jyp30rE?=
 =?us-ascii?Q?YHAKeSj856EpTVB5FXVWv3avUU46c+YzzMe9dNNDPwxFJ9muu4xHNBfkdzO4?=
 =?us-ascii?Q?JOyNwl1yEnB4+OB2okkXealS6gyPb1wd4yMu7kK08fgYiKYo8xHR22R861JY?=
 =?us-ascii?Q?RNGcINOfDTvFtjjgBgfwkVdPT5f6CqNypPCRdF1eGYKD9hw+MG45oPX2lHML?=
 =?us-ascii?Q?xS+wXlP+8ZNEAg+cQl0mB3n+uTx9e+0LS7P6OvAiiVl5PBCReUufchLTlIci?=
 =?us-ascii?Q?Q9mMYPiLiTZKSJko35T3X/Df9u4ELV7GpLEG6ZUAiqSv2RG2Zsi2Me2q5fwM?=
 =?us-ascii?Q?A2ae/qd/jN0H2iN4LYalYZkigQCMRkjWRvNP0u/FUkAchafb9UlosF8ukokT?=
 =?us-ascii?Q?Pc/Oqjnf8D532+cdAzL3nSiTKeMGj/6GxNC0CyqWaLvqCBKXi4a0GW5kfxDg?=
 =?us-ascii?Q?R+/5zIobgDWT9HMuxlLgHcHugby5bunbwR0lCZNO48sMcOSV6ovKeNYTG4rb?=
 =?us-ascii?Q?GcGnrVx32JVkNeNfZdYZSEGtjZ98mKhivcYgLf6fHquFyYucsb22CjWOPVE3?=
 =?us-ascii?Q?hTVzD9flOTHICQGZ31jf/uXlQN1SjLQUEsP6FmXOE+G6SyRlN4EITvquWdeE?=
 =?us-ascii?Q?OUitLutPc3f7XyVPx9kvr+efT3d64pTVEuqSflPvja6+VcK/WK16Qy51OjYz?=
 =?us-ascii?Q?MFvuBG4WnsCQh5ezcgVlQOBVVx1TAb1MpLPOJqsrhRbhQOxfRH9op1bCXJAi?=
 =?us-ascii?Q?bjo2vkb3MURpzyY+U1ybxRYRYXfXpzrghfRtnNVq0b4Wy+ODe7sqWBu3UuCc?=
 =?us-ascii?Q?Vp7aLTpMDS86OlFceLEPt9EITEWHyceDtfzYu94Kf/WisVIc7gppi2/2Y9vi?=
 =?us-ascii?Q?2ymWU1WPiFXQ+R4Oeow9A+YgAqJMRG/jGAsd64mvqS8oQ17Q49eiYgzUauDQ?=
 =?us-ascii?Q?5tfKp9lcgADcf4+IrgP2+7EWScw/3mlTU2/n6EhjG5hDeeeEWTvzO0w8TfWn?=
 =?us-ascii?Q?0py6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260f4a57-9907-41f4-0cc3-08db10f0fea9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:12:25.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BiLrHV+uGjHG5um+ET9+NOaLrPAZ7VxR72a1bZ8GOo9wmjGwOgWZq39AGr2ZVKeexgcV6+V/jhC70/s5uie4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Proofpoint-GUID: 7LPi6DE95SswzTlnMOojf0FT3-r_7BGE
X-Proofpoint-ORIG-GUID: 7LPi6DE95SswzTlnMOojf0FT3-r_7BGE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/irqchip/irq-mvebu-pic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index ef3d3646ccc2..37ea3fb6e928 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -195,6 +195,5 @@ module_platform_driver(mvebu_pic_driver);
 
 MODULE_AUTHOR("Yehuda Yitschak <yehuday@marvell.com>");
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
-MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:mvebu_pic");
 
-- 
2.39.1.268.g9de2f9a303

