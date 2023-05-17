Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3037071E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjEQTWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEQTWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:22:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0238E67
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:22:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGi04002883;
        Wed, 17 May 2023 19:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Lm6RB75CF9LENi6iGVfJMkradxoAuhqRMV79SkLsVlI=;
 b=PfnuBSUGwyPdgYD/AX/VX5lQnoVBGTwBXFQrm0RPH29jPfEqqjN/EGVgof8+g1Q6L00l
 unxHd6DeNEK6APA90uDRUoq1einJ4M35t48l9sRpS/kvzIhgn4v9RjLJNDS/Gr1XTS/0
 xCi9/+Sk6E42zSiRfYciuoJA2JzFA9nA1Wbz8j977oYGCASAYnzoBREd8KZIo2EZCYTo
 be2YE3j+izh7WgdWBHaWMJPlNvI4vck2jtr6xu8YNDkkO+RFM9WxDtdtaYrgE596klJv
 1VoF+6VdzdlT0YAWzDzS1dNeb4J66UUTmqk6PLJrOmZHUXNC2v1XPy2OP6tYAA2K3cue yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc6p84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 19:21:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIogwm032235;
        Wed, 17 May 2023 19:21:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bveb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 19:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dpr4qOiXswhpCY9nMi0Tmza3dzc9t5u/2okF0OBSNfAkL2Js66BVXBmMUlPuPLXbLh9XCEc4OUfUROCuPV55RI/x/9UuFdCWg0wTUKjmKNuaJpl7lt+eICtedh9nOWTauDwtOBxXNdsiR/NhR6bOTmwVSnHhln+1pIP3XZsCd29dbOIbr1QcmjlhB9bqOG5miPPtSOuVQG9VAu6kDQ4ZYGwDD5ZZM0fb+2YuELgvRLou5OhI5+Ri8uk9QKxpS6vx58m+ATVORHMjx8FF9IT+RwxmLPahyzmrGR/kyuN0zktO08SuXm3JkWoJ4q1dWXl9yPHkJi+pRDZCNns4GgZM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm6RB75CF9LENi6iGVfJMkradxoAuhqRMV79SkLsVlI=;
 b=oUU1rVxOt4neH+VFMplz2HJzCrtyx2AxZfyaO5iRjCCR4M0T1Oz2kMGxD6aHNvIx/2wgT/FEaZQbS35cg0A5IleVaiFFzoHeYIQG2SF3M8Y+gxPH5oU1mw0DMcyUmviKWVzbxFzmNtoHveHq191eH1dtA+f8i61/++H+G8lf/madPejKoYyQyE3m3csQ1OrtjN+vxRU3FWrc9RvYfeIUXetCrBMGFP4RSY7zLKDaonnot70fPJOq3Ybs4v8dJIJL5kKv8lAgCaF3iZgLvrg2XJmfsiA1OAMZpLVtuYfK1jfIsojSqZeqv0nGmtEevjh6OK+eal0xIcS1eqHSpGLMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm6RB75CF9LENi6iGVfJMkradxoAuhqRMV79SkLsVlI=;
 b=yhewbkNYAYn6j9EgtBNqm70QUr9Dr7msKoYfvj0jS4ALGnMXgysAfGr2xE2KpTgbKHJHUKCsd4HLgb7jpCcULPlayXSyQRKdm7kQmjz/PWSUg4MZB+tXNFLFPeHLviMhM4Pp1s3Tq5liIR+8YHt7oZxTuX4viBp3GVD51ILZtFg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 19:21:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 19:21:56 +0000
Date:   Wed, 17 May 2023 15:21:53 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 06/10] maple_tree: Add mas_wr_new_end() to calculate
 new_end accurately
Message-ID: <20230517192153.mvkinx6wdzq3zvm2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
 <20230517085809.86522-7-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517085809.86522-7-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0231.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bbf708-c807-4722-bfc8-08db570bfa80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDOidCfEuwZAxRbqHrhXuRFM/GLVmVeZimkydlIKDKKpCBdJEQqNnIhwxMhzwWwMmWW+qI/ms3dDDSKMyLC1bPNt17mNCm7yYQu/tJVMegmaP8zZJqj+TCetoBvJJeigkJNhVE/oVpNNTvAkURRUnxxq4/ge+QEjAaFR/+Yuzz09wklcQRwkyxDNR+G2uhy2OzIskNke1k3kk3bFTIxYkukIMFZmvfnf/PUWLc69wtQDhADyY3IIaHrZo3fH0ONaXH/p8ia3T/kTPWQW22d/1gwfrm2ElR/Mdzel21oZ3pR4wsx5mhGkT2XXym3a3cBW/jGuEPQXP6HyO8epclQ14fUauW5LMQ/C7/UPXeWzcFCEjrViAopr8hCz4NCgX+fLVAk0mvMCDoKuJfAr4bnAqH/dTuTGMFxzjl1Jpve1eHWxEro8U4sWLXP6nPK22yuo0vLfxun7Tqs0ls6GyonoEQ+3QQnTbQJ/bdSPIjFviVUmKukVRZPMz73sU0nw+CncWSJ5hHS+7479uahDc/cHReCTWSqzcrW9uJjheajg0Tj/REeiqvruojqiRK/7b5ay
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(66556008)(6916009)(6486002)(66946007)(4326008)(478600001)(66476007)(316002)(86362001)(8676002)(8936002)(2906002)(33716001)(6666004)(41300700001)(38100700002)(5660300002)(186003)(26005)(6512007)(6506007)(1076003)(9686003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2+H4Hj1ViZTMnQNIrKPxrwrrQL/GCv4XcTDqygEmW3OHlEE68pKNxtPcLHNl?=
 =?us-ascii?Q?G3QwvN6+4t3u16eEO1ws8ZZWuCZl65mX7t3BH3GMXFWkTQ/jEtrPVv/aj2oj?=
 =?us-ascii?Q?lkvVN+hfhrNzIeorWSegRhnAL58kx3ADRQ4dCBfGRmdL9mqHG1BSCH2/dUnR?=
 =?us-ascii?Q?4WgvRaKhFhYW4aZHeRtkpZar3+g9t5LAfvlZPEZkUkNUq7Rku/ZQJNxp/Bcu?=
 =?us-ascii?Q?VmEQ80XaouVyHRA+3j2MK328Gyr2g4nr2e6hhcdE7lSJ5n7wqFd3EH07iNv4?=
 =?us-ascii?Q?0sjDdUTcU+8uBwueJyBGZoJ0EVgeRZUKHm3I97TMsmorTHd0fWbMKxE2F7GU?=
 =?us-ascii?Q?Vm+np6UA6/Gr1cABvqMrT5TehJaACuZOZzikQeBYMg5aeDhoA8y8DtVbujpW?=
 =?us-ascii?Q?8GIQGYosHAyT97c3yMaDwpFwhjKAidl44CqF2RbRkbHTZT6CtBhP271SzgTX?=
 =?us-ascii?Q?x9tWHDSmYFzgjp+TZ4pGPdMFqiFwLvo+Dbw85B2FrsbxwDvkrj6707Mgtt4i?=
 =?us-ascii?Q?UzVhwsKlgC1euS8nV1sPasJF9lBvahExSQQforZ+uHb1MjRjq0hUtXXty2x3?=
 =?us-ascii?Q?DZnrw2zpAxVdJu16WfS0DHrERGdimXT289Nwmnz/flc7oVXAL+cMfMGV7MuL?=
 =?us-ascii?Q?B2SpOEDDO9HDalt7qzZG/xnDGktH2yJEK1quYGPaTBIhnnSYDRvDsC7X+EtN?=
 =?us-ascii?Q?TSMmIdKR4rYe9BFAh4s6gCtROLjmQ282qF4jN29y7il7IH8ynQ8c8CMCcZrR?=
 =?us-ascii?Q?zMwsUACUdgn3ciFL8zbbX01dsDQKYh1tuia9qR1pDLrNJupgi7v/Iqi9vDOo?=
 =?us-ascii?Q?zQuc5Ev7aB9tN2ouYkJc1xq2N0EpB3gR7HiHCCEzE1f8WutPBpWzPql1QMVW?=
 =?us-ascii?Q?0ddUXWhJaOKzm/URVzui/9xNs05kk/z/iK1BwqjIBaJAB933dbaAp2vrAFvP?=
 =?us-ascii?Q?tLTu6TyiYhPllTGYWdfuqp6bEhr+vE4kyc+tu7nJd4FyiuUZB+HUtNhF6axo?=
 =?us-ascii?Q?loimNKVrhlmeK3T/ZRC9wicsRcrCCb89ZZtQ2euudW8ZTpHcrMg8iE7C8I38?=
 =?us-ascii?Q?W8j8loI0qlLY1n4y/qtvEkS7McJQBfkEwe0DJ/Bl+6466DQu1BVa2Tifbb3M?=
 =?us-ascii?Q?/TymRFQFcRVTilBCqkbQ9BMhwbGqDajf0Qtj0d1abfYVog6vyhHsEHCwbtLl?=
 =?us-ascii?Q?H06A9i4utg2PA5kBJPqe+BD8rfD45DaNpklByaoTptTxVXEVr6jvY2YduGCg?=
 =?us-ascii?Q?Mw8K9hUG4lQLesEo45RBucwzL8HfTMFleLd/6KHKhcB8sOtrUDDC+R2Ug6eF?=
 =?us-ascii?Q?ZrTBCkI//rivpYxXENLL2HMQN2HeMo5l+COqOFmVV9q26UjMz4SYLN+jA5GN?=
 =?us-ascii?Q?DUa3X1BFaewQMOR7KckwJuuMPMOKe+g6YU+NDmRkrzisvOgoAN82whxOcKis?=
 =?us-ascii?Q?LvG0EM2qpe7dS5g8J7DXkjG7dTdyAHb/nXdOHUSlx5LhDr3Tj1+oPB1gin7D?=
 =?us-ascii?Q?FBR251hLz5goE8GrFxYsKbh28910Pat6SgNN7fIlPIYZej4NqoLRYRI9OMUe?=
 =?us-ascii?Q?/rrPEPds2kTeb+5HTr0pLnJPvcixPJqxFZcZSkNjWjZoFF8ikxBrqrQiUNGX?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TXYHolH+Ux+R56XE65q7DZ9HAesGDq4ZgeSHco60LGKrW4whxcVyRaXKfbVd?=
 =?us-ascii?Q?Eq4P4m1zs/GQ7/eqmQlF3JtFdqa8qnqlrITfJTM+BYqs++TpGzfOE/qrN48d?=
 =?us-ascii?Q?niXVoHt97wv0K9vcxHKekazd2PUyQ1mZIByNQPln4zzfPvt/quLZnGpfDIyf?=
 =?us-ascii?Q?UXSVGQM8d68pv7qoBOtOUeGW1NZKD+S95nMU7krAH6IhHLskq5cWfGpKQM81?=
 =?us-ascii?Q?mINg9Kl3YP73Fxyq3XiXXO4nV/2ieUQi0NzrJSzUeMukrz98Lv5eMBC9kq69?=
 =?us-ascii?Q?7cHPQ+MXrPV1MRKyruq9C9c1kQpxLepfgfVTqJf2Y24KDzNEx08M0sFpOSUY?=
 =?us-ascii?Q?MwHt5JBbgU7IEM8GIY0b/F3g5N0CD5RQ0gJcL6Pj/Aqb/uSgnxaIDTytuqhd?=
 =?us-ascii?Q?NBKpLduQSnY5j8UNQ6lHTHtGtiI3NOiW/iDfI77+dKaYahb6MvX2YNVwO88W?=
 =?us-ascii?Q?ipgGRLML2imh7wmjVeMLqci1m8325TV74Qu8N1gbNAepiLQZqR/3j5JVtt1m?=
 =?us-ascii?Q?u15Lt2SghjtwyXMxhVSKfhCEHDyiYDYXHeoO5U9XXiG0YA+qVtfMOVOUVuWI?=
 =?us-ascii?Q?bd5IS4zVqbTF5bEbtH9saOUDDXHVRoV1AeGfARjxolHFq/1FUOrmk7d/hNgG?=
 =?us-ascii?Q?o6VUDitpFsAgt6xeECKuBl3l/+Z509slLj03B5KDfVqSiE8YwzT/nRZtEAMA?=
 =?us-ascii?Q?/UwqGatV4fHQPBCHHL7onnKXt3v4AP180Vd12fDoSm9M3tlToTNbOqzKPHiT?=
 =?us-ascii?Q?BsEnSjNB73PqJwC2bGl1Z9//R/0+7rGmx/teDM4PShJc0+cLhkEBVuybiKP0?=
 =?us-ascii?Q?KX1XJoIdTxL6MmuPC0Xocvt+nCJFCVqe8YzkHiBAYYXJQlYNFXCN5kZ5JeLh?=
 =?us-ascii?Q?NyLU+W2uOc5rYFUoQvb25cmds/CfLFiiZ17eLHT40K8iF193T3SpO0lWWbls?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bbf708-c807-4722-bfc8-08db570bfa80
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 19:21:56.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9OQvrm4MR8zYgqOqwligQRBNo/Xsf2uvfsDL7Z+bvn/x7oJl/JolEkT5TeopMSEaGa765muHucTs5V3sx7uhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170160
X-Proofpoint-ORIG-GUID: wXdftnlHomvs1fy7O9Rc_mDjPwIXgFp-
X-Proofpoint-GUID: wXdftnlHomvs1fy7O9Rc_mDjPwIXgFp-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230517 04:59]:
> The previous new_end calculation is inaccurate, because it assumes that
> two new pivots must be added (this is inaccurate), and sometimes it will
> miss the fast path and enter the slow path. Add mas_wr_new_end() to
> accurately calculate new_end to make the conditions for entering the
> fast path more accurate.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index f881bce1a9f6..3b9d227f3d7d 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4294,6 +4294,20 @@ static inline void mas_wr_extend_null(struct ma_wr_state *wr_mas)
>  	}
>  }
>  
> +static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
> +{
> +	struct ma_state *mas = wr_mas->mas;
> +	unsigned char new_end = wr_mas->node_end + 2;
> +
> +	new_end -= wr_mas->offset_end - mas->offset;
> +	if (wr_mas->r_min == mas->index)
> +		new_end--;

nit: new line missing here

> +	if (wr_mas->end_piv == mas->last)
> +		new_end--;
> +
> +	return new_end;
> +}
> +
>  static inline bool mas_wr_append(struct ma_wr_state *wr_mas)
>  {
>  	unsigned char end = wr_mas->node_end;
> @@ -4349,9 +4363,8 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas)
>  
>  static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  {
> -	unsigned char node_slots;
> -	unsigned char node_size;
>  	struct ma_state *mas = wr_mas->mas;
> +	unsigned char new_end;
>  
>  	/* Direct replacement */
>  	if (wr_mas->r_min == mas->index && wr_mas->r_max == mas->last) {
> @@ -4361,17 +4374,15 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
>  		return;
>  	}
>  
> -	/* Attempt to append */
> -	node_slots = mt_slots[wr_mas->type];
> -	node_size = wr_mas->node_end - wr_mas->offset_end + mas->offset + 2;
> -	if (mas->max == ULONG_MAX)
> -		node_size++;
> -
> -	/* slot and node store will not fit, go to the slow path */
> -	if (unlikely(node_size >= node_slots))
> +	/*
> +	 * new_end exceeds the size of the maple node and cannot enter the fast
> +	 * path.
> +	 */
> +	new_end = mas_wr_new_end(wr_mas);
> +	if (new_end >= mt_slots[wr_mas->type])
>  		goto slow_path;
>  
> -	if (wr_mas->entry && (wr_mas->node_end < node_slots - 1) &&
> +	if (wr_mas->entry && (wr_mas->node_end < mt_slots[wr_mas->type] - 1) &&
>  	    (mas->offset == wr_mas->node_end) && mas_wr_append(wr_mas)) {
>  		if (!wr_mas->content || !wr_mas->entry)
>  			mas_update_gap(mas);
> -- 
> 2.20.1
> 
