Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C30736CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjFTNFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjFTNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:05:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA78183
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:05:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KBEQYl004098;
        Tue, 20 Jun 2023 13:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ulKftwJeP7BVP9niDSF6Z6zXt3a6+YgF8mHcpsmM4G0=;
 b=OCQj8VqjAD8DdiaBWUk6cjBkRUoZzI4WLDEQxR4jLGU4FtQTySU66jRDwQ6hy4p/HxTf
 BPeAqGls/CZ5AcQgO7ei65L0K5ZDpdi0G+p5QV9H3j+Hp4llL6drMXvNKbPn5cCek2it
 TLuUTGio1emHRNs3ft4RYZArBtm1aEYHq8RkuTNWVAfLMf3EDKRHZn3qbabiJauUAmlW
 KaBxPnRrMvEsrlf5u7RRowaBXWbcWVW7JOa4PFJPYGkg+BzBxfTkzr7GkaZKUpnp/BO6
 RwAKe+/TdgMPRNGaO72iB8SPyuStpo4wUpSF9F2x/S1gkLJkirOhU2JIerGp3tqF3cxW jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcmphf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 13:04:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KCfuAL032820;
        Tue, 20 Jun 2023 13:04:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9395hdna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 13:04:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwGdzMmHzVFlbpATZZu/TIlPwCMYkDr2PMAjQlc6rTETJTfUVxB93RbEDsmqyNwWtBNjZW+OPNrTqW52enPn42yZhxkIOhOXXy2D+skSQTkn00H0wZOEQXaZamRUwZbIo422vi4XF44QC/iZ2aADsqownr1fKLVPkK0uxf3CLmcoRP9Oak9QAYmG2C0rZyOcEleUuQKuaBjAJZM8b2aFC95U+rEm3Ss4yESD3HeObTZONGGhQkyH/EnjRUyeOBnMOSu0VIueu8mI0kM82pAx3rAOm9fFw4ciD89OKyBNPBW17bNLOm/MRXiTmZBC+43k8+17kpnHgaTzrVRM65t2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulKftwJeP7BVP9niDSF6Z6zXt3a6+YgF8mHcpsmM4G0=;
 b=bBtCUeCh3VXaSdgJyUi/VqfKVOt7FM/x9g1I8XqK696sasRL8s7c9OTkFKqrUCL8ckPKH1NF5vug6WzrUIzdWpddEY6Ee35h/KdMbzS8XnxUdhnPQwSGkFScG2UqmNMvmigXJKc3WLGgXjyBSU0WT/k4y5QvILcDxaFDWOcH/i9FENZKwpJyRW1KQgObdzCNPr52wZFvXlLU6h8r6NT/FlZ3lWfnyLVqw46Qvs7kpXTnxQxUHpnPolvrMVAbAT1tpkReUPXLUReuu4Mvyz5glQlwkMeA+fXZ5XD/uyZRBwVdMdv0kIOBEgUmzQ656zvoS3pTc+xU8/nJkexc1SMMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulKftwJeP7BVP9niDSF6Z6zXt3a6+YgF8mHcpsmM4G0=;
 b=X9QKKlNak62mJuVB77VWqSxxwSdCguKyR3YImtlWrefXFCD4K0Q0rRjCu3m3URbHcIU99Oo4GEvOXfDiZVnie2ktJqpUvePNNl3A05548NaKEHHKUS4tpmRKRIbFwHn2w2HSJs+sl+d4PRtlVYKG2XIBH0RyikDHwIjJ/TSe38A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7642.namprd10.prod.outlook.com (2603:10b6:208:481::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 13:04:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 13:04:15 +0000
Date:   Tue, 20 Jun 2023 09:04:12 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v2 04/16] mm: Change do_vmi_align_munmap() side tree index
Message-ID: <20230620130412.lxri53iekoq6lpfb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
 <20230612203953.2093911-5-Liam.Howlett@oracle.com>
 <20230620122619.GA2934656@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620122619.GA2934656@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d02ba0c-62ce-4723-9d48-08db718ed97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7CC3xuummwE+7h8U5n6DPykiJ6pC9jRmVSOJYuNjuyBPgszfEIEttlhbHXXMNWNzF8ehSoGVvV0buDX5I9/F8Ia8MRaqhpPlQdFhyUy8JlgvTmSEzyow3eeAcGpEzoYtNpFTc8scUXf54rP4mxb90Z7fGMsZQJHsTSPD+r9DYpjfNeXubO0yzQNmgwOSJD+4ragUdcN/4CqZZDAXnBDSHv7iDRRI+a13XM/tiwO19X0Vyiep9ejV2efWlbS741v+iL6jjWekXeDVuCQlKZipqKtJNn9Y3Ig3HLEyo+/KWIoDaHVMicLQVqk/xurxLfeLi390ythw1+lmF1v1P/V4QzTiuUoFT3agtadODSpuiSfvXpDU9TJxXafFNfXeHA8F/NKndESyMNu4JQhvuTTyYPpJ5fgQvlIasOze2GAsCWXDmMR4i8Euvufkfl5O+OOfU2HIuEKow6P8nKFy23e5LLrq0uxFnPqX6zaIFBMO7C4aoe+fNER/Jyt60cjkk2n1Dx/RkvfI5w4omWaA5OFcx7HUbpBl1peJnyihoK/uZEN6tDuxcXR9obsL9vW3MDv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(83380400001)(86362001)(2906002)(5660300002)(4326008)(54906003)(66556008)(186003)(66946007)(8936002)(8676002)(66476007)(26005)(478600001)(41300700001)(6916009)(6512007)(1076003)(6506007)(9686003)(38100700002)(6486002)(316002)(6666004)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NxV0Js9T65YV2HPLmpcyjJR+lkNdX4xD6LjAQzqalsU0v4bvP2wSOcUURlN?=
 =?us-ascii?Q?uRc+kq32dgTaXCOCX+PggVDnHkfI3SUgHJfbmaIWn+c/D1EVH6fOWxSoKMNB?=
 =?us-ascii?Q?KtAkQKehRXUPlzw6OgvgUZS4h2L43eKFZv5acqIKzIIkqPKqhnOSudiXsCDs?=
 =?us-ascii?Q?Le4FnwUcKtRwPNA6X0DGLupC1xlNkoNg4ccjSGz8XAmGtooO4jw91xrVyVIB?=
 =?us-ascii?Q?EqDdLNNVt+b7U8zLTuH4fprx9/EmUoCArnTOdAG5VG8ViVK+7HkbyDpHvY7K?=
 =?us-ascii?Q?KKDH9X34gD8r9XgHHbXu520joWuRBScuTYbiyuTBGAJQ5TKOBVn4Nk5OK9pB?=
 =?us-ascii?Q?2194MesDXN4lwAbAaY/Erb/hs6b2W3zr7f/dSotmWnKGKv6yPzUu+rw7OCpi?=
 =?us-ascii?Q?VXQ+FPg0VxduccTj7EKcgp+6sJvhIZZeP6v/tHQyzNqppXHKnMB7+l/xvld6?=
 =?us-ascii?Q?poNH6JKzjd8LJ8C4s/TdmTEXZGoJ2yPdFQhmP72SE3wycfjv49u4TktriTzI?=
 =?us-ascii?Q?gi8adk0VlnbW8VRLe8+OqUxA+qd0zcUzjLhoz2ss8eVXGL6VovdRUftPxBHD?=
 =?us-ascii?Q?urt1Ulqe0uExnGGzbt2y/gHUUcV+Zx66qnQE4vK7f0EvyeY+ANLWeFP5P1st?=
 =?us-ascii?Q?8J/CnO/wEYuIx2DTxuHW/BGbKXPFA1MMknDO2L3IZQzvNWLdgYw/YUOq2hqc?=
 =?us-ascii?Q?KU84E+sG4pd/dXkrbGw23Ji5d6QOkCIH4IdFQrZ4lhY0IdjAMXtWZOBu/WKG?=
 =?us-ascii?Q?NJP3Wad5I+LNc0HHNC6pYF6FsBQVSpEc6gNDJ1xjOC4aXchROdZJ/TrAf1jj?=
 =?us-ascii?Q?m8mieFA0VEBYx4bgRNGzPum7fFCGo637kUXdTixp2Ci6frR9CwLTH8H3CNo9?=
 =?us-ascii?Q?qbjvspJ7mezrIjJvvz6wxMw+lUn3dpPwkQPzViVLkAkFSdryj/jeS6TyOYnZ?=
 =?us-ascii?Q?afPtKv0vGMI0WW7Bh5tw77qSQXYTrfOWp10+xUo8xxt7cSjVAVRgR5ZD5IdY?=
 =?us-ascii?Q?+LUGUyX48qp0qYX1oK11fcp53im8PN4Wb0uuEe9LGUtPRT2RVVnC5w00BMgX?=
 =?us-ascii?Q?95rdKfeBrHOTqvBFZdmMiFWqLDpkJCTPebW6ejEsZXl/27pMs3NZHULox5va?=
 =?us-ascii?Q?byayP9JmfCe/6n/b4MJ5gUmaAqPESvQEgpoIrQNnpIMCPBXBiaRo+eYDZB7Z?=
 =?us-ascii?Q?TuECKMh235YVO18R3A9UHSIC/AT11M40/fQz5Y8pUVZE260SDDiubNTZ0IHA?=
 =?us-ascii?Q?eJ6YwHnnEJGnKN55PBwIA8A5/Ric8YtVsmSLX8FF0kxkdSwDjPpRLna+3Atf?=
 =?us-ascii?Q?dJHh61Q0L1rZ7h5gQ9dCBCKrzhtQOBhj8O8Cwcbs1aLNTc5htAH2cUB3/l98?=
 =?us-ascii?Q?VR3GzaFpXWTPf3urwWN1RiOjqZwFMLxoyLDlsae6GkKLLW7BdAFJ/oFhSVtx?=
 =?us-ascii?Q?ETJvlRTE/Ib2+zkAu9/tC11LxjxMp2aBggzXW99cltH2CIoO5EuK8X0Era2O?=
 =?us-ascii?Q?y/q73atOal0+QQF7MjLmHa3/okfax1reIDqaDAj80xUsbZ8tvTxVSCMSh4VE?=
 =?us-ascii?Q?e7vdsxtEh1MUlxUAfHsPLiABpCMsEAaPYEo4gHoz2iZTVhlShV4vXPHuCxc/?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fhTNoZCNo8pDlZdFkx/QdYmNDasR4zX5GxsnU0mQLGmlJe/XF02jxZNC0bKK?=
 =?us-ascii?Q?ioFLr4I6p3Ee5GLPzjZLR4RXvYPkaSeHM6wkU8FQAqc2grNr5sehlukzeBsE?=
 =?us-ascii?Q?jHhNSddwUjRNy2CuovuqQsUbc45Avfms5F/F1Uhd6jjUvISuHhNAgSLjfyvb?=
 =?us-ascii?Q?AGNgCplda6dFhlBCHjzc0d1Xel3aOCWbRqVZ0+cjVD9ADe1B+ICKb94X9ZkG?=
 =?us-ascii?Q?+gWPLSKsMnAp4mx5ZloHXGk8GMO6cpHYhz6gKSx9tjWut2BPGlaP78SPvV86?=
 =?us-ascii?Q?bZRfBm3nK3vyjuhrL/N/pv+26WLblu9BrpPCnm0Y+IbCO0r4PQ9ktN8Zu4jC?=
 =?us-ascii?Q?7igH1h2p1u33v7EvEtehqtEmiEpi1f3JLgk3k3AIzF4ZPU0aJ3IDXtGKy3YV?=
 =?us-ascii?Q?OGyJeZ2/3KGcJUwi7u2MhjCgUNWSuKyNul7/nbBZgMV/fdQE9VBd0msu4Mad?=
 =?us-ascii?Q?+XBpW/8nn3J8hcc6zzTnqmMM8OEKuOU9fqjBhSN1FxGSrzkiktlPJ2tcuuOP?=
 =?us-ascii?Q?YugvxxVcuS6Sh92DtzBoGO2jzPU6dz3Kncw9vRcsb5WJIloITUJTO7J553a2?=
 =?us-ascii?Q?5Xjy538/KsfYENiwG5GWkqJSJAU4KULI7ueZ0X54YFTLHbUnitN52sTEs2W8?=
 =?us-ascii?Q?0LY+l+dgUX9h6bvjH9bq+WEgdIsOl09QUVvPYx5pO8RTAlBf3j2I09kaKGUj?=
 =?us-ascii?Q?cCS4CogXe5LK+eBmSk0w4lTfFwdyQ5m7Qodez9YVwCeLsVxtclNpxV7g4/AQ?=
 =?us-ascii?Q?bp5NLNrWQQfBS4y8+5a++nvPt2ZWR7JFMO5qIdcGZ53pudKweexZGUJmLdKp?=
 =?us-ascii?Q?6ibJ9q33kfhk8eVGaXqRxfNsPFREu7ilR0tpVai6Vm/3cmJ5Qizmw+9cxdmU?=
 =?us-ascii?Q?sHlcZmq/DixS74e7Ylc0RIUTFrziGpOYqkliGj7hUP55rxr73IsyN23/z0/6?=
 =?us-ascii?Q?llMB593IAwqCcDvYsRWfng=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d02ba0c-62ce-4723-9d48-08db718ed97d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 13:04:15.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ezmo6g36Vg5IrOdHUuK8i5d92zu8QYgCwiBT6txGhnAqYiCDw2O/i0MvWw2FHx2Us4k4kGF3s6qKHreTNnmTxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_09,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=924 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200118
X-Proofpoint-GUID: f7HrQ_ZIsXuBmsFeIIpcMuoip4cBWdfl
X-Proofpoint-ORIG-GUID: f7HrQ_ZIsXuBmsFeIIpcMuoip4cBWdfl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sergey Senozhatsky <senozhatsky@chromium.org> [230620 08:26]:
> Hello Liam,
> 
> On (23/06/12 16:39), Liam R. Howlett wrote:
> [..]
> > @@ -2450,17 +2452,17 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> >  	/* Make sure no VMAs are about to be lost. */
> >  	{
> > -		MA_STATE(test, &mt_detach, start, end - 1);
> > +		MA_STATE(test, &mt_detach, 0, 0);
> >  		struct vm_area_struct *vma_mas, *vma_test;
> >  		int test_count = 0;
> >  
> >  		vma_iter_set(vmi, start);
> >  		rcu_read_lock();
> > -		vma_test = mas_find(&test, end - 1);
> > +		vma_test = mas_find(&test, count - 1);
> >  		for_each_vma_range(*vmi, vma_mas, end) {
> >  			BUG_ON(vma_mas != vma_test);
> >  			test_count++;
> > -			vma_test = mas_next(&test, end - 1);
> > +			vma_test = mas_next(&test, count - 1);
> >  		}
> >  		rcu_read_unlock();
> >  		BUG_ON(count != test_count);
> 
> Something isn't quite working, I'm hitting BUG_ON(vma_mas != vma_test)

Is this with next by any chance?  There's a merge conflict which I'll
have to fix, but I won't be getting to it in time so the patches will
not make this merge window.

> 
> [    8.156437] ------------[ cut here ]------------
> [    8.160473] kernel BUG at mm/mmap.c:2439!
> [    8.163894] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> 
> RIP: 0010:do_vmi_align_munmap+0x489/0x8a0
> 
> [    8.207867] Call Trace:
> [    8.208463]  <TASK>
> [    8.209018]  ? die+0x32/0x80
> [    8.209709]  ? do_trap+0xd2/0x100
> [    8.210520]  ? do_vmi_align_munmap+0x489/0x8a0
> [    8.211576]  ? do_vmi_align_munmap+0x489/0x8a0
> [    8.212639]  ? do_error_trap+0x94/0x110
> [    8.213549]  ? do_vmi_align_munmap+0x489/0x8a0
> [    8.214581]  ? exc_invalid_op+0x49/0x60
> [    8.215494]  ? do_vmi_align_munmap+0x489/0x8a0
> [    8.216576]  ? asm_exc_invalid_op+0x16/0x20
> [    8.217562]  ? do_vmi_align_munmap+0x489/0x8a0
> [    8.218626]  do_vmi_munmap+0xc7/0x120
> [    8.219494]  __vm_munmap+0xaa/0x1c0
> [    8.220370]  __x64_sys_munmap+0x17/0x20
> [    8.221275]  do_syscall_64+0x34/0x80
> [    8.222165]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [    8.223359] RIP: 0033:0x7fdb0e2fca97
> [    8.224224] Code: ff ff ff ff c3 66 0f 1f 44 00 00 f7 d8 89 05 20 28 01 00 48 c7 c0 ff ff ff ff c3 0f 1f 84 00 00 00 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d f9 27 01 00 f7 d8 89 01 48 83
> [    8.228432] RSP: 002b:00007ffd15458348 EFLAGS: 00000202 ORIG_RAX: 000000000000000b
> [    8.230175] RAX: ffffffffffffffda RBX: 0000562081a347b0 RCX: 00007fdb0e2fca97
> [    8.231833] RDX: 0000000000000002 RSI: 0000000000004010 RDI: 00007fdb0e2d5000
> [    8.233513] RBP: 00007ffd154584d0 R08: 0000000000000000 R09: 0000562081a3fd30
> [    8.235178] R10: 0000562081a3fd18 R11: 0000000000000202 R12: 00007ffd15458388
> [    8.236861] R13: 00007ffd15458438 R14: 00007ffd15458370 R15: 0000562081a347b0
