Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C696A8C09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCBWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCBWk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:40:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069143B236;
        Thu,  2 Mar 2023 14:40:26 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322K423J013550;
        Thu, 2 Mar 2023 21:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=AmxGD3qlYjunPtLoFbiMLm2514iWGjQSquTr2rm4r70=;
 b=x2A+Uw7zKuoyQLPyg9Ed7a+tqqyK/TDOHgsuAvNrD5FHgST1aY03X85qBWJI4qS6dcmG
 /iu0SQSvof67dN+V8FfVKRP/6AJxraog4/YDQSqDdwQRXlkksGwv/r9QYteBiq86SQ6/
 NwOvZT54r7kUr6RfvLyuyy50j2GAQ9PPrJg+QSksUH0+RLfPpJ8lGkyu5cNefYYqHu5g
 Dz9UNLEfDBeY1rVNWUfsejFwebGN7EOvGAlcTEJOC5ix/tsSB7q5DBBkDmfuvliRxGdR
 95D9u04A6n00KroGRQ7rRjN0y+gPd02Y/H8H+je2Ryazyauppcu2qF0kirhCcbhWkJca Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb6emxu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322Khan6033044;
        Thu, 2 Mar 2023 21:19:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8samj8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 21:19:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG99iwaIiAi+JtXlkmP2XrtSoI6aKSbTfXlpJ54rW72l0nMUkrenulEM6hwFcpK1JcZUhTAa1+L1Q8VB/CInY3Y47tQEmnnzh+wfcUIQ/ZOO2AegYhH2WgZPOTw3pyfyBuj0FQiImEJ1Ng3aiflbn5OLni9XdnO/4TwpgfIcQOEpUHAeB8pZtZ3rVe/FdinPceNlRpUw5v7Yyg068CVPxCLEvVhc8BqWSJqVeAZGVuYfdRMQBJ32vlCsZY2yd3V+IxYwlZzOJCQaKD/ByUG97AwzN221OsfS8ePH3B1oBgY1VDoWIpV7osyg6/htc4bAnKs7v8MR7WdxkcFbQgtMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmxGD3qlYjunPtLoFbiMLm2514iWGjQSquTr2rm4r70=;
 b=XVEdLBGiZ07gud6cXHRvgANVc+i/O3PuJZ0EhdO84OpEw0wv8UDe6f2ytZ0a5XZgkC8VLdyAoVDGnHxxvfU5WUc+6IGNk+ClmlcnmvvAgxl++Y3iOrQIfbDBWviQYIrNkiXfTdj9mVo3jDYWMPdAEnRv52ajdc1i+f7iaoYQMs5Cr7SZmbr7/S0O7uvT4heSB3kZdx+wfQHIIN1ue3yfb4mKv2Btlm13hiJF224SMMv3Pr1BUP+29aqxqYrYKBbdr+SYoEWOuZY46Eg2K4SYg/sccP3lAFPBVfJCdubfX+kRKIpeelKUlqMvmPZqD2ja+dg++lStAEf3PL4dBgGWTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmxGD3qlYjunPtLoFbiMLm2514iWGjQSquTr2rm4r70=;
 b=ePjF2siXORAaP5ERUi/WrEcZgfOKfP7VdXLzsavSIuYxpu3148zyKmZaLaCQIhFqlKd5VH9RYjJrIpgTd6TDQkQEXAaw4Np0SXyw4DrAIJsXx6PaMov487R5l0SjsMUqb675dTaRd4fpD18itUFIow+47d68LaXC7p+gaKGF57o=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MN2PR10MB4351.namprd10.prod.outlook.com (2603:10b6:208:1d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 21:19:31 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 21:19:30 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 17/17] zswap: remove MODULE_LICENSE in non-modules
Date:   Thu,  2 Mar 2023 21:17:59 +0000
Message-Id: <20230302211759.30135-18-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230302211759.30135-1-nick.alcock@oracle.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0231.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::27) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MN2PR10MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f299c86-0a80-4556-d288-08db1b63cff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdz7DmMUJOuHFRa9jpGOGXP/+DM1OyL50jshwJTJP7cG+oLbvcct4LraC35BGEUzLwHNVOsYcMog0st2u5wMuoFBFgr66wFjovN7joX+RbnH8GKi3bD5JtfcCMSxIs+CUyPa62ajlpYnr+1N/XpYxlPT8FSmx0XISC4ShbsHlC1hwhbiEsU4DFp71v+uBwVdbNF5g+gdj+vBqZrz3jFLGy7yU2meA+2fLpmrTAN1ZIpve9GCBFZaNvDkINqFKH31j+rn6p/Al1WFcJJHbp9D+mEdi/YLDSbuUkd5NMkwnuWT9ZJxHJhv/zu69bOTh99eTa7Ka9VlFHXrBUkpWfscRCNj9+sz/q7KLMuGgerb1fgbH4EFMzAPzY/3q83DlmWgt8S693w1wV8zG62eIqjV04pKoJG4Iqm8GqBvSC9P8ahw+yJJLTdLAI3iogjJQqzWIsosa8hNdZZTK0PvF0iRJ2czvu+SvctiUmCk2ji/X25ah3wKixw47aTaDd/MMYGkWYchXp0TaZWszJ+NvT01rDXFm06INvDHD5pllNYghv9KFmn2aluYAJR1778f1TmWtms2TMWPIBEXQcJkub8UcmmZ3/QwGFzjFFEm9IL22qp02VEk3AOKDNrlHBOHtUrzQzxcPfeqxYX2eMxcCsxs+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199018)(86362001)(186003)(1076003)(6666004)(478600001)(6512007)(6506007)(6486002)(2616005)(316002)(54906003)(36756003)(38100700002)(2906002)(83380400001)(41300700001)(5660300002)(44832011)(8936002)(66946007)(6916009)(4326008)(66556008)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zJgvj9zXA97TiSVTtAIbuw6xIrxWeAkGDadKmWIOgSaWx1Pdg22IecCFNciP?=
 =?us-ascii?Q?cBfVBlTDf4HUVuKqIuuZE+0CCvzk7yXAHD5F/tZA8838FQPqhDPsOcPOJ4cU?=
 =?us-ascii?Q?BwI9iaI9UEYcbDcDcz29OwsdyWT+9qOMR50Et8gaopGavdud8+vCPOPwIFcl?=
 =?us-ascii?Q?sJ5d4WLaXptR8eBALvCCEW5oOGUxC7X/vz2MxiH6GOTJLVpInK4zd6sBTa0X?=
 =?us-ascii?Q?6/4BhePuWNyDdL4kUxFFiTqZ1vIdKsEqfrshZ974cHe9g8NXsKLAjXfQ6mR8?=
 =?us-ascii?Q?sWRKklg0r/KItCz1A08aAov1kfWcBqWesZkB/IQhNrApmrCLcIOl3VuFS/23?=
 =?us-ascii?Q?cFq+tzYYSYfVgfi2iTcRmqn+nPXw1nBXSAchSc2erGBWQx71ROpCbIyvdtEn?=
 =?us-ascii?Q?qn32P9Q/cUgxmiwv3s5sIUxyKWVUybcezFzh3qaN5ujQb1tRCZMz7fIWgMSF?=
 =?us-ascii?Q?wFIZv0V2AZKGXVkcVJVBRDY9GdZXXdT1/7i8fF9b5zOycqt8+yeTCsjy3ThW?=
 =?us-ascii?Q?QNd01E4IuydODt1lwhWeuZRhNtTGt+9Yf+E/LStpHmSx8VKrDtCKPtHkmdxy?=
 =?us-ascii?Q?9OwTQThuF9laEn2TAEM2B53Tc3+SWAXrYAnnGe+5UBzc9o5QK2X45MePdHWG?=
 =?us-ascii?Q?NdksqSZfIFrQTRtXl6/OSNjmd/dr0V9WPs6NbYueJRQ4s8MoB7WxS7qr0IKn?=
 =?us-ascii?Q?mnuxKnp5S4O91C/coCMGhNWVc9ImIcJt3GcXmO0x4sIXCTbhyqALKP+pF0G8?=
 =?us-ascii?Q?Q1fu1m+K79nLCk6rZvSDTY+J5eMI6A5IYTpgBJIv8jPcqERjmic2B1NYuUld?=
 =?us-ascii?Q?DrekYIXVhHkiyWAbtAn6SK84cOq+z35yac8RKgu4T6/hPiW62kwC6Yzqm2Xg?=
 =?us-ascii?Q?0V3G7Bw7H9WHc22Hz7rOSmaJiPcgXGzZ4z7mmtK+icidFxOWzlrnUYcL8mvS?=
 =?us-ascii?Q?C201WoL0kORWxhqoGIiT7+g1aayDx0z20mltmoG8XejPFZBDd7mjZXzJXk5I?=
 =?us-ascii?Q?b/GP4/tRnrCAMO3TU5K3pIKzv950iSLUzoit6SpXzMC0lkT2k7Lp0HZmwiIq?=
 =?us-ascii?Q?wGjZ56XHy5ic+RuvxXcfXlmsu5CFTRut5kiZn+h5ji3/rFYVyus505z1ENal?=
 =?us-ascii?Q?xoapUWYgpAPvIndKYZpYRLGiq/p2FPZ9Ll6eoCmc/BquxCMcDsEe88QiLuqW?=
 =?us-ascii?Q?A854XFhcrJRB3fEh1R4++420aBM/HFoyEMB+oj9KgxVE1rqLMlcg/F9MllU+?=
 =?us-ascii?Q?+u2ujBdSbGnyiaNsGup8A7V1pYkSLe9lvTqLZ2gNldV/0WUp9wdVWWDKB6bD?=
 =?us-ascii?Q?H8NNiF9Ksq1g4fcRmfVoxuRWORjMqTQhHOTyECWlfC7bTumsDSZD8m28o/u8?=
 =?us-ascii?Q?qF4+gJfZeGA5DC5y/cvjvzkP8sDYGPOctuV6BVnxwuLEAmhgejfiIbx95QME?=
 =?us-ascii?Q?svaxAxTpNARguG8KS22PBy89V8xeLgShicysScbLyfzWn4hBmm7/mNZqsMSk?=
 =?us-ascii?Q?QT7QP4fyuT9xjT1AtxjewUN1YQvekWsdPBvwUKiiU953zOdgnNLnIAkOTycz?=
 =?us-ascii?Q?KwJv8ruVJt/TB69v6osMprtJ5YnMDbfZLoI4nkW07M88Q0hIZSI0JLj0/toW?=
 =?us-ascii?Q?+87Yt236+hJX5e/n9089gEE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KyYrvURBEgBKccUo5ZPN99x+hOUoM87Dg2HetmJi6gNahyJ6YeBzpLDee+vx?=
 =?us-ascii?Q?Wf1+rdGLPSklkfhZKLUWDUuB6aRjzqcIm8pqt02I1K9U+G/7Xz5LxmJ5VMw1?=
 =?us-ascii?Q?IRkXbIrn8RsZi6vh4is5wEcWL4gzxfi1fyDUe4bLRA/efwGghkXiMcZq9sMd?=
 =?us-ascii?Q?s0CX7hP9+pyGhev46h1BT3dd5KqETJRQsRK5VCX3Ru7n9CrhvfUBvLUxph8k?=
 =?us-ascii?Q?0kq5FMBKxi7z9uDewov6rFKMggrRzl6BdD4/QzDiAt74JyAuSaMUXxxXPTZZ?=
 =?us-ascii?Q?i6pZoQwoOANlbIZDufmXU/inJEAAel3kGq2fk1wA0/I3ZJseyhDF5teT/OIf?=
 =?us-ascii?Q?cjNUqN9G/1tS8qtPd1h2YsOa1Qux6HilgoSYdu4P0jcqhJBgsHmlHEfAv51D?=
 =?us-ascii?Q?I7eFDPSy9qFvH4reM5+R3llKXIP+bWTgGYthbooK8aFncxdd2j91jnaEQ3A/?=
 =?us-ascii?Q?D9Ysay77Lu4erUS2RT6xibCu2ZQmfKZtH7Nqj9N7G+MowgkiMCDAImVT27vn?=
 =?us-ascii?Q?vFBjs9PT+s11S2amb/qyraeWjmss4q+l2QXj7TLBmVnBerQg/vI851H0+/2O?=
 =?us-ascii?Q?1qL+Bz12GsaRSHSOJ1NN7/Lk+wGufeWVTNKxOahDtL3y9kdwdS1I8GjE4TaB?=
 =?us-ascii?Q?fH0A3yIN1jWvPc5K4QLWuTS7iD79z/1O7lBQ45QCuYy5jZhReB3dyEuRU4+P?=
 =?us-ascii?Q?jj7+cPV4Pn1NbGw9WFXv7vfANKSaqI3zACRJbFLSbsMnlUJ3sZzl09NQqaL5?=
 =?us-ascii?Q?BgRRMgXx89zFkMgUZ6z44pwBP922ILDP6V3LVMhRmvsOi5SyEu0ooZa3ua/1?=
 =?us-ascii?Q?L7g6n92dPSH6MPOuT6NiPC0vnyBcA0oyV7ZoA9chYsbhH9nCdYWaVzpMab/N?=
 =?us-ascii?Q?BuNj9dPk90JmsbZ18K0gIueZdCBqeYWkAXMUDkN4ARokyR2zTP1EclDuczIB?=
 =?us-ascii?Q?AGqyV6ZKP/mFk7kEbPndVxwCjJJcW7ePYWqy8wND4Hk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f299c86-0a80-4556-d288-08db1b63cff9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 21:19:30.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqDARJ9ZawAEGn/Sd365dRuYwMvO8pFDEcCD3wg8HriIaGsijfCw27NKldcqPBfOsrmXLAE6Q723mSyAg9hFcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020183
X-Proofpoint-ORIG-GUID: rKzmmjjMZNo6GtpwHb3LiYpNEaVPyxE7
X-Proofpoint-GUID: rKzmmjjMZNo6GtpwHb3LiYpNEaVPyxE7
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
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/zswap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6c89049cf700..f2fc0373b9677 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1540,6 +1540,5 @@ static int __init init_zswap(void)
 /* must be late so crypto has time to come up */
 late_initcall(init_zswap);
 
-MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Seth Jennings <sjennings@variantweb.net>");
 MODULE_DESCRIPTION("Compressed cache for swap pages");
-- 
2.39.1.268.g9de2f9a303

