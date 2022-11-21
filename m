Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E3C632E92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiKUVOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiKUVOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:14:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7965C1B7A6;
        Mon, 21 Nov 2022 13:14:48 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALKuY8o016419;
        Mon, 21 Nov 2022 21:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kbsGAOHZoE6hv8zIQsJwWQr3Um1cf7ipxfQV+UD3BTM=;
 b=BFVCsDW0eToFk8VxD7+yZp9GYMmpNrG/7b8YIME/mqO2uorRBqAk2iIBu0hCZyrNgNYJ
 GRx3A1AeelXoRFAy1FZOm4cZwybBZ0P+dXxrYitrU2ai5PBu2Sbulu29NMxZFpwKKca7
 UeXoMBKBB63dweuX6IzA7rJBjm6O0GzHox4GgYSxeZG36HcoT6GeznpwhlN2Tu4+BAc+
 eoT9FnUiCq6uXpKDnU2+fUgFWVN5bLX3TSJuXl6pKod9xcChKC0sj60uljarImMQgY/I
 VB6skaZmmngjBXtkyXumXab3VSZ9uum7zWf9LYpPkxgBZ81LttPQOLMGMfH3vuJmF/rd sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m0afr1j21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 21:14:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ALKWkKR002271;
        Mon, 21 Nov 2022 21:14:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkb3wde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 21:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH7xriP9JNrDuehcEo2B0wEniqRYyntGYNeTbyZJzcf9efkrmiAu7sBCZPZktH9bEEj64eMxJzs5ZJsA1+yvztPDGzYiHbmqKLtrsvoKuCxG6ElxgzjhAI1syQY2KlLe4h8tDGTGfztpw2yta23ajH329OUrk4LHDxVgfwC03vREHnH3LwSoehU40ohEVnzsNq0zfTBarln5zjS99MX2hkadolol5HtK9Gt5wUWfJPLLa0Cl0LGpKgPoPx7oc7suWg74uUHKMDzwUQa2a9JbkYTxRxZL59fwsW21YTZdacQA+x6/3ilWLeBAEf51ZhwCD4dHOB2Km1VoBUYY66ZTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbsGAOHZoE6hv8zIQsJwWQr3Um1cf7ipxfQV+UD3BTM=;
 b=l0vP7qMCCv3sVC4ZM38wCSpMwuSYKtBllnogZnlrAn62/L6Oq4zSJUu8oqP2rF3lzP3d3gglbQMtI9yMiXMpX2/rNuw+G1aka4Rsa3X7IqXQOwS1OfSmf1Fyf63e7SwpDIWDnqUVzOh0k5pwoBdHkLx+LIfw6XkTFapYAmBkEpGA5ML37pxLYXLZ8VOS1KyIrqY5f/vCfbw354LxYwXOLmBcqHW5qL+KhIXXbLipNWVNFG7jjQb4gne/ZgU3AXx5pe53QDn2/0FSYgXfneACxFlotZlWaLChk/gIIuB7u03llmq9Ia0gaKT2oW37eEjKKD8FZui/Eo7WLSTdWB5rgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbsGAOHZoE6hv8zIQsJwWQr3Um1cf7ipxfQV+UD3BTM=;
 b=wFFqziwdGkmYDxzdBHeGbzrpIXrTKwj12zPqmbM1GTg99qE9gykqcz6fQ4sOnzuy4LvRFn8Lc/PpITk5ykQUFG8GJl/x4HuKMCqnhnTG/jiVfXQ8OTQL5Y511UqJS4Y+RIc6RCnDVIidKjS6UhhkbYZt1lV8tS8G+gkupuLuFoU=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW4PR10MB5678.namprd10.prod.outlook.com (2603:10b6:303:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 21:14:37 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6696:2164:2057:4b25]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::6696:2164:2057:4b25%3]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 21:14:37 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-3-nick.alcock@oracle.com>
        <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
        <87h6z5wqlk.fsf@esperi.org.uk>
        <Y25mXAGty35I5lQx@bombadil.infradead.org>
        <87iljhv321.fsf@esperi.org.uk>
        <Y3QC0OIbZgSmvAxT@bombadil.infradead.org>
        <87sfics595.fsf@esperi.org.uk>
        <Y3vNs41m9I51Eu7x@bombadil.infradead.org>
        <Y3vPGDmKVx3UWbwJ@bombadil.infradead.org>
Emacs:  because extension languages should come with the editor built in.
Date:   Mon, 21 Nov 2022 21:14:32 +0000
In-Reply-To: <Y3vPGDmKVx3UWbwJ@bombadil.infradead.org> (Luis Chamberlain's
        message of "Mon, 21 Nov 2022 11:18:48 -0800")
Message-ID: <87o7t0row7.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW4PR10MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: a40e1093-b784-4ca0-0be2-08dacc05654d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmjkzhkN81ffHuaIwVIUquj7hiLjA/IPjQMl1oLdiwZT2SJwWWnQavNAGMLS8kHBDlGGEsJgSGlWw6vu9nF0w1B7NyT8rlQ0XMC/hwQ5vyCDDXFFZ3f1YR8ipji/a8gIyvzJiyqviBCpIB3ITYWKu15ossD1/VS0Z/KlZR6Kqm3Fo1JyAaN5vXLqnKqlwR/PBxKbPTTfIAqjuxAQRV0g5GuoAExhiXkZ0MqFsfeSrNr+asfd/iRM6V8w6b2NW2VHtRFxI4yJNW4nNQFApi1fZZCd1V6C1NHZC17vTPq4LN0ncCaW9OqzllUDm7YvAc8DdgSpky++aoUpIjPfjl0vSqtw1wDcY6uwEMQaJs3VAH7E041fMcyDvxQSMqdTfiMSysPiW71wOmpHNlPTi6kPRYpJ1WnRFza4cAxkj7rG99zIVjox/bJ3sLQ3Sqeyfn8kjNwx/g8mzVYwsxAHpidD0vC8b/rC+DdiQicjWdUc/fh9ZYDedmde+dGxVVqwSaIAGp+WbN24ITSg2DMYsrX3289nrtg+821Uq30rbr+YzmZuoiqXq1NFgefPj93aVxneJTexyc4xgDDI/HhM+nK/AtR/gqnM9QLFQm1Gpb6+dX9eAZqG14zFn5EVPlek6GIykOUPdk95/n2rIBnlEWYI+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(41300700001)(8936002)(5660300002)(4326008)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(8676002)(44832011)(478600001)(36756003)(2906002)(9686003)(6486002)(6512007)(6666004)(6506007)(186003)(38100700002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eiej5xASpMd6x08ymTpWpDn4TA0B55jGpzxNeF3HHeTVtaJdvPmmSsd/NL2B?=
 =?us-ascii?Q?uDAkGsv4uFb9HBl0eQokZ6UV+aovOz/vJKNAwz4va2PPUxnK6f+Ru7w3y5M1?=
 =?us-ascii?Q?LyyJWnsZ/GvGJEoyN0L2/3f94nqCZZI7sqr8NMiBtZWS9TLggPLf09U/u0nA?=
 =?us-ascii?Q?vA5r3oopHJ23hsQ6N7cbYJXxBKPfroQUFG5/5J0s4yizUKvPeqiE2ZsK11G5?=
 =?us-ascii?Q?8wBNMTexUa3SWuePs2cM+oiptn7JEgENCfu4YLaec/VpJSB6v7HXVpm3NzQg?=
 =?us-ascii?Q?BqaI9OU580OQWtVLhtUOSrUQ6g7191I5O2Vp1jkZpAUSpEiNfVo6mQtM3XNB?=
 =?us-ascii?Q?gtd9GzzJyjQe8kFnWSNxd0Tkax/nb3YX4HjZQAqxrxbLkHjObxkXYeRMVRZE?=
 =?us-ascii?Q?NaUbNquB6gENRUr1fTdbt80ehG1igR5PxatGIiQtG42LzC2MFROojJKIk9iS?=
 =?us-ascii?Q?/Cm6OTKLwp94+W1+jRW0gslhB7Ett2Qk0UKCLrei7Nd2o9itfA7y8w/YWj33?=
 =?us-ascii?Q?F8clZAnUrpKLCVVVgMg6b48jJZU1dXQSZQ4AFkdCrd1VH2gYOVmUCeHPVAzb?=
 =?us-ascii?Q?m0OBoUJ31/hMaUTcgvjWbXgAkTzjH0MNSnqtVBsHo48CkYGcaZG0jOishmYQ?=
 =?us-ascii?Q?vJTD6K7TdL7er/ua2/1KZSF5v5MZ1bxCjBo+9+T6O9jar1LxE4xegHbXB8Hv?=
 =?us-ascii?Q?qQxFchgYlvdDKvWFZbRoalaiq6EKWSq8fsJH42YSSauvRh8TEIj5+Hwo9kOJ?=
 =?us-ascii?Q?lY85zRjYm/IIU68/+ej3QuQPKfD6hrCRbi86NqE0rL63PLYnYVTpudCNF+a2?=
 =?us-ascii?Q?IjUIIDsFiiFRkXrUYORPjcVcDn1wDfIkG81FLU87bQRlqpggS/+QHaX7PBV9?=
 =?us-ascii?Q?LESqxdimDqKU5ncqTl4iyxD31Dbc2+Oatheve7lz8C6mVRNDZbBOUxrDblWW?=
 =?us-ascii?Q?i/4JLbOBr6hw8LvsI0kUIn6+C6EtQB+EuCl3fQGqENWYDXXgDTHjo4I/ch6H?=
 =?us-ascii?Q?4L+zjbp/58bYPEIIecfNTzAnsVIZxtAwUE4cygZUDoIslO0P4WPIk8h90zsy?=
 =?us-ascii?Q?JhpqTVRLTdV8/L+6csEpv+YgnXIVx4m1NBck47QERAvv0k2zBxFXU8sfYA2V?=
 =?us-ascii?Q?FtsMBt4Z5uOOMY0ChWfpgQ4sPW/DVEJiH3JEZrSHfVsVAIb1nRcLeldm3NNC?=
 =?us-ascii?Q?E6aDkh2GtY6AHKzuxz38ZeGys3dHgOAQdFo2/BJVzXCoxjzmFZjQwJh93YSX?=
 =?us-ascii?Q?tZHqtYHHJRqthx8erElA0ZtCNpn8k4pLCIyAY6+5o8dzzaouILso5/getB/4?=
 =?us-ascii?Q?S88+86jsPTWWBAUQyc23Yh8BQcbHayspSPX2aC4pynNlxbgw0O0tBuZYnevN?=
 =?us-ascii?Q?M4QMKUyIxllSHygTKIOql3PgWiXLR3EtA8Nmp4pyVw5BBww1N4lXsEhtSi5D?=
 =?us-ascii?Q?UMnnsEWcNwgMT1QDwbLb2YIyIikE/yN1luLvjbWAiasR3PHd8tRglOMRr3HR?=
 =?us-ascii?Q?xat3NdyP9X5vcctSIHJeUeoQrVOQtDj2TaV8GwuTgSHzQeJdEQ5LXIOQ2oY5?=
 =?us-ascii?Q?yrHqMQjUPWq1sz41/XKhPDY8TjcRiC2njBW0fTdb9KK4PtPRKs7SrAWvHEvv?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CxIU2PSqj7hoLpHU9zlC6ed/cCoQ5aiawaKDf28vI79ehv7hA3buBwpkeqCA?=
 =?us-ascii?Q?/sKcO+QenDe+nlVtJnRW6cGYoA6zglZwQxlgZeXFCRPpIyg15GJ2h54QMvbg?=
 =?us-ascii?Q?qTu2nw6+Zs8Yn66K0Mo16176JNys6qUszA09tAaO+Y/ntyobXoQE+SOWi2lh?=
 =?us-ascii?Q?kpL15rSC9tYqrKU4qyojDzNY8N/LzVS7GObaTDTs46gohqMbMODlu7czUF6T?=
 =?us-ascii?Q?FYGTclNXkLu4RVRy5Ie2KKPfwTrkBdvzb9njW/5vtWS0bosUyCFTt3mbN5Qb?=
 =?us-ascii?Q?ZPt6zNydRthRF6mnMNQ3EohtY2zlS8YYIZUHWPQtffa+Qp6vsqV5ooLtFDuT?=
 =?us-ascii?Q?MCCHeZ++ltR5sam25axKRxlq5bRMbV7kdYUoaSybuXVihTKak4s+Sfn0m+3S?=
 =?us-ascii?Q?EZW6I72z4PvTEjZjMSLuMeuTsAv4LdVKxUueThUhKZ8mevxw6F7+3Sc6/uC+?=
 =?us-ascii?Q?Eb4CeTrSSAqs34udq4DBLcOUwRYONlB2XOBjtkni6w2EPp6wgiA6W5wJKW0W?=
 =?us-ascii?Q?SIBz3Pe0AZnnNfJmVMCj160EvJqo5FQlaoRLxy0Sc6fcUOqk5N+c6v/HMw1J?=
 =?us-ascii?Q?yli7jdpYNM/rmGX1EnSzKVnS2qLlzskzkAp92rrO0MdCflp25870iLKDNZjm?=
 =?us-ascii?Q?RVYZg5mJf/bGQAzae+TKwej1RfyRO+b9K+JNP2ZZUGDtS4uIfKS1EzOUEuh0?=
 =?us-ascii?Q?fJqTCBu4xUV3NjBTI8WQwspnB9vakxunRx2gT2/ZymbbIAfHKbIqdK20Ezzk?=
 =?us-ascii?Q?mw0hPhjHGL9ycDTBOtZ6VruU0OCaEibRTcgc78oU+uAv/fPCPeaLbxh6Ty++?=
 =?us-ascii?Q?MZe50tt7AP96UQiIJSHETKxF5FE6HOzCkF9OCYNhp9BThslo7XFqcJbwvCzl?=
 =?us-ascii?Q?rFtk1eHNT1NJloiJsJBlRoh+5Ur+G1Oi13OLmEjgF4U3k7faQPJmzJzIcVE0?=
 =?us-ascii?Q?8mHPinGBVFgNIUiwB0zcIYQoUIQ9d4VXgKjObpTrMQE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40e1093-b784-4ca0-0be2-08dacc05654d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 21:14:37.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pwdn/Kfi59Mus9cnkM+5NOZxWLoJpAZWla8a/0aws8XO5FwDUfNtTjULG7NENHVu8C3ZG/q7XpTN5DOyWIJsfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_17,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=908 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210160
X-Proofpoint-GUID: VgXn2KwIe3ZoqR1O8GAzLGi7XqkpaA0j
X-Proofpoint-ORIG-GUID: VgXn2KwIe3ZoqR1O8GAzLGi7XqkpaA0j
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 2022, Luis Chamberlain spake thusly:

> On Mon, Nov 21, 2022 at 11:12:52AM -0800, Luis Chamberlain wrote:
>> On Mon, Nov 21, 2022 at 03:21:10PM +0000, Nick Alcock wrote:
>> > One question: do you think it's worthwhile me submitting patches to
>> > de-MODULE_* things that need it?
>> 
>> 100% yes.
>> 
>> Yes please remove all that module declration helpers for things that are
>> not modules, and after you add your helper which will nag at build time
>> when it finds new ones.
>> 
>> For justification just mention in the commit log that after commit
>> 8b41fc4454e ("kbuild: create modules.builtin without Makefile.modbuiltin or
>> tristate.conf") we rely on the module license tag to generate the
>> modules.builtin file and so built-in code which uses module helpers
>> just need to be removed.
>
> You should also mention what modules.builtin is used for as per our
> Documentation/kbuild/kbuild.rst, and that it is only used for
> modprobe to *not* fail when trying to load a module which is
> built-in.

Yep! (Which is an extremely damn useful improvement, I must say. I'm
relying on it already.)

Only two remaining problems in your patch that I can see (hacked around
in the checker, but consumers shouldn't have to hack around this sort of
thing). First, some very strange lines like this in modules.builtin.objs:

drivers/hid/hid-uclogic.o: drivers/hid/hid-uclogic-core.o drivers/hid/hid-uclogic-params.o drivers/hid/hid-uclogic-rdesc.o
drivers/hid/hid-uclogic
drivers/hid/hid-uclogic-test.o: 

(note the line with no .o or colon at all.)

This seems to be a consequence of lines like

hid-uclogic-objs                := hid-uclogic-core.o \
                                   hid-uclogic-rdesc.o \
                                   hid-uclogic-params.o
obj-$(CONFIG_HID_UCLOGIC)       += hid-uclogic.o

i.e. use of -objs as a completely random variable for holding object
files which might or might not be in a module. This seems a bit.. risky
to me. Looking for a fix... maybe we can just ignore *-objs on the
grounds that if it matters it will always land in some other variable
too? ... maybe?


One other definite problem: drivers/staging/media/atomisp/Makefile says:

obj-$(CONFIG_VIDEO_ATOMISP) += pci/atomisp_gmin_platform.o

This subdirectory is lost from KBUILD_MODOBJS, leading to the file entry
in modinfo and thus the resulting modules.builtin.objs pointing to a
file named drivers/staging/media/atomisp/atomisp_gmin_platform.o, which
does not exist. (This is also seen in some non-staging directories, e.g.
kernel/trace/rv.)

> How many of these are we talking about? I'm happy to take them
> via modules-next. I'd hope to not run accross many conflicts against
> other trees.

Going by an x86 allyesconfig run, 169 total (probably plus a few given
errors like the one above), plus no doubt a few more for other arches.
So not a vast number, but enough that hacking up a checker was clearly
not a waste of time.

If there turn out to be any conflicts that aren't spurious I'd be very
surprised. Hardly anyone ever even adjusts their email address in
MODULE_AUTHOR when they change it :P

-- 
NULL && (void)
