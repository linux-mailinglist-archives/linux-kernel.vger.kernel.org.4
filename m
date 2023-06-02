Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403257207D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbjFBQmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjFBQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:42:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5BF194
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:42:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352CQErd003218;
        Fri, 2 Jun 2023 16:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=onwERV5za9IuBo+IVsF4kAF4PDQNLwcNglOLVPcNkbg=;
 b=UlKEYtwDSO271NU0EMmb3v/YNjIBit7lNyiloLRBwYbRsU+P/joD7l5vnHg3QC4ZZ8nW
 qgdn+RLoJUPuZuJ5h4Va+HnNqmCm3GbIMFlt2eEQVQt7C5OdPGbzAfjU1LpDUy91JcbN
 RoaRGoAcJznXvlrctaSQfnAxY0oRvL0HQp/KoLH7SZKnBes98HT+27bWmISt7/6Trl6z
 vySowJp7u6yuFHB3PXYaixZ+efwZkny7yLQ8XULtwJlQ3YgmHBfx+Q0MFmpUldgzI0/C
 neD01C03Yy5XdYPBQHTauCfpWDAbQs70uTLxtySiymR+BNBIZPwN7ntwitY/SMT/rIae pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjudek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 16:41:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352G0nXG004583;
        Fri, 2 Jun 2023 16:41:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8afcgag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 16:41:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCvSVfFr/cBSxWwdEH70T8HPgFTUecta3+LxM8daAipPm+U4RxlE0BSzgwh3zwvlir3bDsq7AVVoNdnMzc5rPaMxRUdLVHyU460WwcpxR32VPlxBQvP/GMLA/wDkmJudAZXUOnPLjx/qYvJfWco19rI31gRFMKgLvHYQ5V619GzPKiZhd+DB3etxQO4jm9TwNiDEy4ngFgvgtC9ZGvC17e2j1cx+fcAvfjkQ3iItkHnF6Im1bW3K4DYRjB0l73dpUmU4XTHXzA3afPciVE8zumjpXcTXr3/4R/57YKXyV9PYggOcuk4AGLOcN3ytKzo7c2wJWDfYk5xsjTYpQ6iqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onwERV5za9IuBo+IVsF4kAF4PDQNLwcNglOLVPcNkbg=;
 b=m56B4wyMDuYDLjnDntIar1FH9jQTs0/sAQTEoWFuAdO4YznH34a4ptNDWO7k/Cy9yfeOsNy5O+I0H+cEooEQN9Ms96rYWHc95MI6YWbFCnMUNA2FL/CqfACuqxYvYThPxeDROld4uV4+420YRwUGuUZwOhOsMEAYl5/Ijq1DEGJyXNisJQ0eEepdb3UjwKOgx+rQxM8AsGSXn0wYCgpJ3WqSsdPWtHHiffJ1KzRccfI8u8NnxS0MqXudbrNrzx5kHbzNCQBNdYtrjFjaARrSM2q5xhGMDyH3gLdYeJ2cJoS2T62U6K+yQoDVhELlS7XgiPJiJz5LosjAifx45bwpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onwERV5za9IuBo+IVsF4kAF4PDQNLwcNglOLVPcNkbg=;
 b=IaAJvRnrzMvkO2NuiWH5INwYrJ3u6i8DE2UnMAUbxrLpbFRb+U3bjOZGkd/LUyzlSrREnpcuUO8q9wku6Ah9224fIbk6v4HAusX7h7z6HEJF8RVlg8F0qw0MNNg7GMYNhg8HXyfmYn2KhCF0y5Lvi72zQOtyDSC6PCEc+k1fMrE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6632.namprd10.prod.outlook.com (2603:10b6:303:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 16:41:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 16:41:37 +0000
Date:   Fri, 2 Jun 2023 12:41:34 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/2] maple_tree: add a fast path case in
 mas_wr_slot_store()
Message-ID: <20230602164134.uw6m7t2pb3zhydkl@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230602075353.5917-1-zhangpeng.00@bytedance.com>
 <20230602075353.5917-2-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602075353.5917-2-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0005.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::18)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: 2420658a-cdef-48be-7db6-08db63883bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtaE+6jy+9O6NdDuLJJhEAq/x/XECrDmSSmXLlGUmVXTBzkiUES+ayYSW9UCkoP1vGKJ8T50/FzXvoNrF7BGCVOyimfWCT4zdJIXl3s9hCcbk3B+YwUQRWA54CYTJVSnhRhbBmRQj2DOgK9bvvsEE/w8FTi8wAKm9jLP6qJ2xe+gNRMzEiWYf0R7XV37rHUH8u/98J+bHOn13FF9PdQu+bsRktnZ+tTcgn8bRjGkaR1epeqhwsGL7WQ4Fj9gmpR6h1+PqSeBMwxiTs3agDzl2RKNhsfIXiIWt/VPY6uBnolB0pOw2D1CtBdllry2rQLZLow3XnQO8hzJEktJu8q2GTwLjJ3K4lj3wixuKt5MYtHVABkrZcFNjHpw8Aw+sfdTt5ni9b2XGACSHpK4CD+m3weMuzGq4Z1B+r+CaUyRpNooF30EWVPJPkCho2p8WwvxjI8nAijqwZWtBhl311tMmWIYqs+dVVdOZD+9R9GDNErPHFBa7KyosmNTuw1w3h3oT+I7/mH7gFcfX434iqwZjQrwByAF0u70jJo4Afgzp/gfU6aP5izLBSnU9VsTKU4E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(66946007)(4326008)(6916009)(478600001)(66476007)(66556008)(5660300002)(8936002)(6666004)(8676002)(6486002)(316002)(41300700001)(38100700002)(33716001)(6506007)(26005)(1076003)(9686003)(86362001)(186003)(6512007)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AREl8CCMT9e0QUKAOGkP593JpKhXJFEKMRvkHLeDgbUmgJsA2NbCjqmCS8dT?=
 =?us-ascii?Q?YdKDKy+uY8B5OS0QQOuyvRYf7qal/437xjNw5rahn91UaJEWOu6aS2da1YHY?=
 =?us-ascii?Q?yzn2OVW1oN7VculNpolBiM7n0Pm5Wm6PSOVX5GRt+TFqMU6ZI38sPUkJc5KY?=
 =?us-ascii?Q?qjMvaKD1ZrNc7xOLzoE1CrysbwiAVWk317Xj3O+80lL2PtR1DUG3z6wLIZ+9?=
 =?us-ascii?Q?Ecf530LY6mt+QwPnd6yCcP+nmORo4KzTNgTyeMcSfmgkZFbHxB4P7eOMCAie?=
 =?us-ascii?Q?mjXTSwIE11ufAcW++Wc7N7NQrlDWZvGXmsfHCf8qTFRLbkv+bS5At1vlMW5S?=
 =?us-ascii?Q?CZ0010jLgNxLgEIbuZ9EGPNuHHayOg0/IMfu3BmQ81gdL5eHieCVy2zhVoQn?=
 =?us-ascii?Q?mEi2awL5hsfvgb173MwVJ2mjkfGuM7GWfDaqKkQf+Vxd+wamt91/4VNiWC/8?=
 =?us-ascii?Q?507x7PHDfGuIbvqN0zngRdJOej+DJF+QjIlvkyS9+IzIX6kwolHO51DQqpOu?=
 =?us-ascii?Q?FiOQFlAfQwTymIc0TPdd0STBaHdTRbtPnyL2rM+R9P2GKDX6e6EM9LgN2Rde?=
 =?us-ascii?Q?rTnKz5++6tneTCqLFTeZ6xt9A9faggHygSNCGcU0bcCz12/OE9m/VWOWBa9B?=
 =?us-ascii?Q?ichHDQr4wISrPZT++tXEWEVsJM7rxd6ttSrLUNP0lTo6w7/95ZKneaQLkA+v?=
 =?us-ascii?Q?UtXYsxzbZ+5FgwNTxigkqaGDbXpI4bqgUijcRBH+wDAZr7jTPNWg0TMRxyth?=
 =?us-ascii?Q?1zBpZRzHuLXU+aUOjLbTfrmwPV09BljXK0afaRWhckRC7ts6Db5H/8o6eZEu?=
 =?us-ascii?Q?s8nPGLaMa90E0LnBQs7SQEGP970bEtwsLo6LTeFa3iVdLl0OMqaztvP8P+ZA?=
 =?us-ascii?Q?4s/+Ww39Q0pEZVi4VBoNu5mSnpGoRJ+ulUyeCM9OWXYM3vjN2fnXiPB/xgwa?=
 =?us-ascii?Q?mBFMLPaYjhi//eKc6RzcaReZzeP9Qx03b7ry/goDYz5OJKg1AZdu6rlGzBHj?=
 =?us-ascii?Q?L1LlcABsc5F7RFzhzsA+UUFGaLw7evTgmyVI/Tn0kYKYI86KjmDZ1ynz/kuF?=
 =?us-ascii?Q?DGOV7k8KtTMvBa8sLyZHCbTEuTehOakGVATrhqt2fILexgvT3hvjJLPSLbhC?=
 =?us-ascii?Q?3Ztue/sh+000/Y9sxoRR2NAeaZLOtRVp9EF9HNKjt45EuXy3bqkFFHFpel3e?=
 =?us-ascii?Q?yFc1Vif1aVuXD8yykdRzRW/B5ZorJ5RH6slbRy/C1/dZCWpbIlP30cgmyWJ+?=
 =?us-ascii?Q?yWleM75dme+WWC8jz+4y/JIJIJmX0Gbhj0iBVU2NJxSPvBv6KfphP9o/evcG?=
 =?us-ascii?Q?+/tSdlZk1cTJ8w8ZpbpPGP67ma/YC3fMgOLOA5Y+vJYWKGWsCaJSZXL2JLEe?=
 =?us-ascii?Q?rEj1TZgrCpR7hELpAwK1lhnfstWIjt9FeuYT31m/JEMNXPDgJ981pGqtqcPi?=
 =?us-ascii?Q?57buSAekd1wsXWM+zqnk2C3t6DgbNvLZWCoQnJf5AC0bHBOPH5jrkAideiR3?=
 =?us-ascii?Q?aAFZyAhhjTeJ33r9kiRxPVWSWqfuQj07XmITROo25XccPxqERcy7Sa3dcmSJ?=
 =?us-ascii?Q?cNClSXd1ozhwihupDMhaGCzIGUUcxOHv4xiciGd2YdOCxHLRZ8qeOvbADcAf?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YMxIg9LZFfVYjJ8qw4zgSEwXNgmnLrfRhHgKY/dVTEB8KksPkcCTxKGWnQwG?=
 =?us-ascii?Q?s7CWClPUfSf8ZbWctJ2+4D5nm+nRRSE4EeFuoGrQLSzPsyxZZYlvu2ZMlh7W?=
 =?us-ascii?Q?V04iyeel6L5PX6zsY2M7kzUcUvKpXAgxCEtzle28MOl71xTM+SukDYKdinqB?=
 =?us-ascii?Q?RlGXgExMx8RUVA3ZZmArXkcClvDZTl9vZSWXNTPb9L966yM75K1Vg1/wSQ6J?=
 =?us-ascii?Q?+tDSvolpxRCb+Eg2DzDXSq+BfNwktJy50h5Dlddg4V6y6TWynFa2pCmq5FtN?=
 =?us-ascii?Q?i57adXUL25oY2rIgv4W4BlOE6jpNsUTB1kAS5bmqzE+qnwbMeXyfgPQEcdn9?=
 =?us-ascii?Q?dxkOhu7NiDMp4sqE42R42vbIQ7Cte8c1xgHJVtsZGcUom6RQeUl7dEIv15L7?=
 =?us-ascii?Q?YZUqmzoEDBHPC6wppQh8xp4zvmKWFfvuoeLPy0VJj9dEvAS4FK+hqTU8OSyK?=
 =?us-ascii?Q?0IBeexsgh64tnRFj6BpEj9nCFxwEFct5lDUNeDf2tFYWYuYvRYikZap18JGK?=
 =?us-ascii?Q?XODKfUDfqXZt8bfl196/7ofwCHB5Gi4bejXdIHIKgsUouyRB2QgtW6zGOJcL?=
 =?us-ascii?Q?l4J9uMcq8HNBmi8XeF8AS/WfWyAMVi1wjYCRk0i0YtCw93vDh2TlU/jzt4NK?=
 =?us-ascii?Q?zA7/TN709NqgGdk57JMkmWM1Lq/zaoAyJ/+Yk4z3uyTTBNEndBSIVxX0EzPZ?=
 =?us-ascii?Q?By5mfE8I9NErvRvkrtO7zFl+7aF+ax22RSDPKVm2JUKpTNVER9Ym4lFVyTNu?=
 =?us-ascii?Q?lDXwSJ5fT4QMQSblP2HtgoaQSXHcWqSk6lkZi8V/29ZOMXbVJ/cR4+TYUhef?=
 =?us-ascii?Q?0vxPB/L10Xb+gwxuY6Plk3BqcnJOE0oKWYHut3DrkQrSSQVAzruUN60ZMJik?=
 =?us-ascii?Q?aQF3fBvRdFViaDMLab8rw4a45sPjmSL7yYz3pTIRLDB93sPIWcZkdhqlTwQ3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2420658a-cdef-48be-7db6-08db63883bd7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 16:41:37.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBK9VLrb+RsmSsYdLUTyIaiZVtQSB7iViylhmNdUi9XYfcH7u7s0/LN3t61KsNo8Atdm86hE/6mAy0KG1IDtEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_12,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306020126
X-Proofpoint-ORIG-GUID: mhuFyNAY-dQiOgWutlhdIg3Xrpj4G0l3
X-Proofpoint-GUID: mhuFyNAY-dQiOgWutlhdIg3Xrpj4G0l3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230602 03:54]:
> When the new range overwrites three ranges and does not touch the
> boundaries on both sides, the number of entries will not be increased,
> so we can just update the pivots as a fast path. However, it may
> introduce potential risks in RCU mode (although it can pass the test),
> because it updates two pivots. We only enable it in non-RCU mode for now.

So what you are saying is that you are expanding one entry to consume
portions of the previous and next into a new entry.  We know this is the
case because the end of the node is not moving and we are modifying more
than one slot (so it must be 2 slots)

This scenario is not tested in the testing framework.  We should add
testing before we can add this.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index cfd9fad308a2..ec82441ca3e8 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4100,23 +4100,32 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  	unsigned char offset = mas->offset;
> +	void __rcu **slots = wr_mas->slots;
>  	bool gap = false;
>  
> -	if (wr_mas->offset_end - offset != 1)
> -		return false;
> -
> -	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> -	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
> +	gap |= !mt_slot_locked(mas->tree, slots, offset);
> +	gap |= !mt_slot_locked(mas->tree, slots, offset + 1);
>  
> -	if (mas->index == wr_mas->r_min) {
> -		/* Overwriting the range and over a part of the next range. */
> -		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
> -		wr_mas->pivots[offset] = mas->last;
> -	} else {
> -		/* Overwriting a part of the range and over the next range */
> -		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> +	if (wr_mas->offset_end - offset == 1) {
> +		if (mas->index == wr_mas->r_min) {
> +			/* Overwriting the range and a part of the next one */
> +			rcu_assign_pointer(slots[offset], wr_mas->entry);
> +			wr_mas->pivots[offset] = mas->last;
> +		} else {
> +			/* Overwriting a part of the range and the next one */
> +			rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
> +			wr_mas->pivots[offset] = mas->index - 1;
> +			mas->offset++; /* Keep mas accurate. */
> +		}
> +	} else if (!mt_in_rcu(mas->tree)) {
> +		/* Overwriting three ranges, but don't touch the boundaries */

I find this comment misleading.  You actually touch both boundaries for
the entry in this case (start and end).  We are just increasing the
space in both directions.  You are also not overwriting two of the three
entries or ranges, you are expanding one entry in two directions, so
both the previous and next ranges will shrink but they will remain. It's
more of a "modify three ranges but don't change the outside limits." The
similar statement in the commit message should also be changed.

Right now, I don't see this code executed by the test program.
Inserting a BUG_ON() here and it will not be hit.

> +		gap |= !mt_slot_locked(mas->tree, slots, offset + 2);
> +		rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
>  		wr_mas->pivots[offset] = mas->index - 1;
> +		wr_mas->pivots[offset + 1] = mas->last;
>  		mas->offset++; /* Keep mas accurate. */
> +	} else {

We are hitting this else in check_locky at maple.c:35780 only, I think.
You've identified a lack of testing here by the looks of it.

The VMA code does not do this today, and I don't know of any other users
which expand/contract entries like this.  Do you think this will be
common enough for the optimisation vs a node store?

> +		return false;
>  	}
>  
>  	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> -- 
> 2.20.1
> 
> 
