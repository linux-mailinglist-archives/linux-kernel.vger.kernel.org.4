Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF867443B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjASVWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjASVVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:21:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4C9FDDB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:15:28 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKwxqw017683;
        Thu, 19 Jan 2023 21:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=voXrOW87B1fcn8BS1GrK82RwJhoSLlOH5iYcJrBrqAs=;
 b=GV+f6yu+PyrafYj5bbYi+e85WzOt3FlVA+SDJiOirwexxHbQ1ZUj1h/k+/QFqUqCmMwR
 XPB+nJsLJzCpF6156OlzqbeWWQL3cACjzUmpdXGzG3g8/hhIIkVb3ruleluOef9BOlRF
 uUTuk3/Wq8Cdslr7eFkgmnEuWMHhhSEW3OH/B5vFKZbe+qGhBCT/ZZhTu5Nb7eCz4VtQ
 1VUD51srAYlag8gtkpZukAYG/J3M8tFsEK311xnHQAQ8VZydO6vInjqKVo+s0/0HS7Gb
 gdiJmYDYKA8xMJFZ2vEdtx6iplEcWcRoznfeg6SMzOBRHotuKFRnImEDVpXqHapcq3sg 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaak9rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:14:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30JJWTFL018798;
        Thu, 19 Jan 2023 21:14:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quh8ssg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 21:14:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPko/1+B4QZwk2+Tm2A26vW0aETPlufQ+322v5WWFrcMdMTVCU0g45QPfabtVUUPO5cJpHW1CoX1HSjlSO47CRKa19Umc4DvTogKJ/PViGnSUeFAwu3Vzuzhwua5Vexy4Uq266OUNl8IHN4U2FNWcZDhVft2ppOLXWlw7MgPvvVy4Pof9m/QSC4VCjvg0Tj8bwZUttn7LxLNNl1V5NbxhvPZ2ELW7gzOD6FglkCy8T5AIMcjlQgNvsbJUWXIBMP89kfoWfq9hWTcOZQ83IlfpZLBK3uC4cSEI9irN7Z7K4xsUuHoeE6daMVyB2/GDcK4hkmhWT504LBuHvc1DnCwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voXrOW87B1fcn8BS1GrK82RwJhoSLlOH5iYcJrBrqAs=;
 b=OM35AVWTop3fR1HJgbeUttrU7w54jviiIdgXmOm/kjRSE78SwdaeOjuwlcFccasag/KBVQciYV27G8liAZ8tQ1U9V8UD185/GFS5hU/Esp0UNqslaNaEICXF7gwp1bs0OLbpQPard2CLNRuEszY8K4nmIAJPYzMgh+4bA+IZXczHIHxjhfx1LFTBg932Q4upQKQosQTTuzOKfXfGesG2a4mdq9EXcF2PhMcX8yGWa+BUMrW0mO8jz3wqIPOj771+rXXgXgqJRvpHDKCnFt49InsD1AIlis+6gKhGGy/ZbTDiIx+fRDFaIWKwalqt8GbIkHHUjeBhSv5mpVGhRueFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voXrOW87B1fcn8BS1GrK82RwJhoSLlOH5iYcJrBrqAs=;
 b=pKBsrSeWTUoMyC67gJCWjI9sKjzyCHd/k4kR9up3Kb8mCe01jsNQp7K5WdWm22vHJdOeIUMHP4TcdK75oZ3/gHP3zYcRN1gOTcZ6r4JLXrZp/UDk6ZIRbOaCz+32S2lvFQt0za5jJWsjT4uyN/6vQWLMUD9yDWm1NURsmWeB6LE=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Thu, 19 Jan
 2023 21:14:52 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Thu, 19 Jan 2023
 21:14:52 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 0/9] convert hugetlb fault functions to folios
Date:   Thu, 19 Jan 2023 13:14:37 -0800
Message-Id: <20230119211446.54165-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::21) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|SA1PR10MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4c2a2c-c041-4ee8-5fc6-08dafa6233c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVH1PBHtGipQKT1rU/cVjAZi103ETnj47zXyclyNuTPV+oELRc9KV9mjpiwqeiu2OJuI0T1bV5Do1rN3KSmvDQNUkbUeDYrE2nFSb0t2T/oo10VwgpBS3A8Amz6jFpzPXamyItk4hJWZ54ukBPbjqSO7SYPECDUhLEm+WjN4utIXsuPqxTfRbWvyC9NFR1EA1D39iTjZME0fXyZBpZSkh41RhgqVA+OgeN1H2vGaT/bx2HVZCxyx7Ora2Bs7oNmJjQntB8RXdXE6egHCVnDz7k7IonYJ3lbcqwnMmjKBFYVpFYagHb2cyeIltU61BxjEnwVnJ4caQyowU06WrW/ynnRrDUC+4CLITc6mAErSr+10P/rgQWFRZACu3wtxCWGmtLYY1nWeWUraAU2+md5zRroR0AFW8RBwVASWeJ35taNYMCTDgL+QbcP+vUxtJdz75rOTLFtppht5p+eOu8sZyDTsxjojHAC0YRFZVZcA0Vb6LII6IYIqOFvZV6cakM3e6YxccFeBW9oe3VGhQPyQi1Ax6QhE3kfYkJIDMXz0kFfwlkj4wkMP4s8x7MfLfU89ioMCuX/01FyPnb9Ws2w+w9eUXtyz1rdOZJblpIV+9cHW9SNvtLuCq5QiC4wvL8YhHyyP3oX8yABi5Lkz5GoMfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(66556008)(83380400001)(38100700002)(40140700001)(5660300002)(107886003)(4326008)(86362001)(8936002)(2906002)(66476007)(66946007)(44832011)(6512007)(41300700001)(6486002)(1076003)(478600001)(186003)(6506007)(2616005)(6666004)(8676002)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IU/nW/Ai7PGUWK+/EMO6mMfbxsuMmhW+I2VP4b9L7vcaMw0qSlXelnuCQQnB?=
 =?us-ascii?Q?261cUESmPGnqkQIpslapASQfdd0OEOnuCjsM8ZSnCxeLynA55CZF4Z3JmnNw?=
 =?us-ascii?Q?dl3NhGV8W2p4dszPIOiK/Z0OaB79Uwpm+PRrUtLOnbfvF6D27KoKuhVJ+5Wj?=
 =?us-ascii?Q?Mk+5GsUvY9VBbCZql8v9lup6mUxFpcqxoPTzMxTWemtbbagKY3UVryN80vdY?=
 =?us-ascii?Q?Hg1mbZz70ciV7XkTixQ7zRFKoNZ/Qqq6+p9l2Q5MARNEEFJ3M3LHIGF0SjRx?=
 =?us-ascii?Q?6fcu+h0rciZPzIjJHtv0CqzTLxKd4HYz2mCCiFdKHUIXjZHkUQFyzDCysiH/?=
 =?us-ascii?Q?4gIp/ipLuH+peAWeiKDTLK0kVvACBFVZRtHS60AVbymv/3TdGGk5U2jCZapZ?=
 =?us-ascii?Q?yG/JQBDmKK8PHwXBm6BWNcZRyr+JzPHPY/JAmzHmJlitV/4vuUQdCiuOxUjG?=
 =?us-ascii?Q?hXKRUiRQ4SY+rZNyo4sp3VvPxmy5Du4lYr51jBbe35PggU+x0VpZAo7lg5JP?=
 =?us-ascii?Q?YgohQb2ZVmkqXiZWKI0lv6HI6LV6YZa1Oj3C3N0QkgR+jH4N9tUZ4t0+/d2P?=
 =?us-ascii?Q?wv09SODrUbnyEqZT5CJWWBkxdI/PuM9jXkT35WYJZO5M6drrMbkDIr7PFAc+?=
 =?us-ascii?Q?JNRG+6cnvIgguOBx3X3erqCdgyygINhnJM5qteW3yqNN4pWg3j8PXIcP/UdU?=
 =?us-ascii?Q?Rn0qTqkZd+sdobzIK8jYFKo6OAhdgKHpDYbs7JjjW+UIdd6eteaIfH0ovUw1?=
 =?us-ascii?Q?9NkchECMs2f5KCBe47rwDEJAcCSz3CwYQqvKhyjQhBPSGoDBmoKX456/e4aM?=
 =?us-ascii?Q?73BZfX6wS91MUdTGMARF8WVrPbJjC83M9GTzBexnWi91yWRpaWMLwVDqSCpg?=
 =?us-ascii?Q?3T+u0mSb5UVh1yQpLHB9sMJc1bk5m1m9QXVZyWILn3ocLDG54phjhYJpGxTe?=
 =?us-ascii?Q?FbVC8oucXOWZDSGtsPz7xvcKkPUClf+C6isrAXfNH4NukvScRUwqnq+k39oF?=
 =?us-ascii?Q?QMC0M+Ofq5XqPH3ipNLirh6q+6f538j+ZCb9szn66s5CQfzfMTeKAAtwtkep?=
 =?us-ascii?Q?RkiSjDTkr1nnocnmLjtCDWIgYpqCIrqG37TYGzwuyTzYiTCmHiIj+eVT1Q/C?=
 =?us-ascii?Q?CbuuTxRDO+mXLNvKnbYtO9cDzyHJKphVfukSym8dZHE/O2NtdNGZoGfhwVK/?=
 =?us-ascii?Q?CnjsjpXHf4MhLRumZA/otR0CBzvG5Deve6XG423dSGwFFioa4Te0NUv1+tmN?=
 =?us-ascii?Q?Isyd171K3eGwSI22ORgqYKJAVovDXGoGJFwu0Z2cCeV3BWGkICyU6tEKzkLb?=
 =?us-ascii?Q?xGA8OmrKPNmRIOWEaoM+skbAHipZhbagDAIIECzr6gzC08Gc7EUFpih6XbKI?=
 =?us-ascii?Q?3ywdsw08Q4+51PiOJAw2k5MIlmqM66J3rXeyRI8oE0SBttOFYJrSRGIQDsn6?=
 =?us-ascii?Q?R5qIBEzqnkUQG63V+vE89OunL8eVfyDpnLfips+691KQjuzfRAREwlP0Fv/I?=
 =?us-ascii?Q?2FxN9XxteEvDeZK3LjhgRd/qJSjtShEjBSwFVFilvOG9LKGQw/7r1MTzTr3j?=
 =?us-ascii?Q?Ms2NqgssXa6CE4g5AbQuW2EYhtHyhZc13vnzJkHJ7Y+pFWUhyNl1rDlo1ch8?=
 =?us-ascii?Q?e7CTd9TnYIu7TtZf1Gi2N0LBxwYh3OQVLoEqB+x6vlzmefqaduJQwNK0WXOL?=
 =?us-ascii?Q?9Gr64g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IpuDEuvGVtcQCtrGztmciwbWck3jacVC0b4rUh4HbBUPrgPzLQtAo3zEzOP2?=
 =?us-ascii?Q?kF7C45v2bcbpLGi6HimsCrqWKtlbhN0YWr2L2RsTecbKMdKJso3dYrl+4Ow8?=
 =?us-ascii?Q?1nS0iPcKG+NopVITL5q1JxrHDFsmIWBa0ZwoqgJGQ7u+ZZ2SnnDZNdXiWdWb?=
 =?us-ascii?Q?ltGl084zvreUarg7lu+YfYFircfcg0pRBw3Gmt+ZvuyJYLNvpwqR18uP4W9E?=
 =?us-ascii?Q?OHi2bBYZ4sw7Yj0ukSoIsed6Qwb7ay9BI8/maae7RPwTID22J5u4rG/E881a?=
 =?us-ascii?Q?WvPH8seWheq2bvmaL0rgM5OaYEWB3PZCqVXncOr305irgBtKuh4zz6E5U7Fr?=
 =?us-ascii?Q?hT805qSozf4cw7neGvGX7+2S5A1LzRa8puxD2FS0KhcISHf1AUHEBNZQd7Xx?=
 =?us-ascii?Q?AbSETW4Wca5AmWwpyzwFOAf0riqkeUO8v4Xql17GVtLg8Js4HKQRUM/Uo6Fq?=
 =?us-ascii?Q?Fqe1S5FKCrIZ0S7F2hMqmdtv+oxwKk6JMRoMYKVdPDr0jUUl+OSVzGWyU/2c?=
 =?us-ascii?Q?7FAXqksUr2grkIau+qzUsa5S/p9t4SW/gIogHablsMOmePUN/WKFnbIZXYqU?=
 =?us-ascii?Q?Z5KgegofLadGdflX1Eqrt8NSwYzROFZf0wW7Y2zXlMeyPKxR2C5FbvYbRN/r?=
 =?us-ascii?Q?sPHCUyiwZneH0a3VbAdVSl5CQZvOy/79xb/lPAK7O1JNji8oMmR8vscGVUDV?=
 =?us-ascii?Q?FwtWUwP/AkcXlsZlEFVk6PYhW0IVMOm5FQM/ndTh01malHhVkuJcAYRauYCQ?=
 =?us-ascii?Q?/cohr7YSPPq0EN9+j5e6BdM7a8u1g8TuJycZLs6EhVHoXYA6AQREgwggSDdl?=
 =?us-ascii?Q?CHvNr/C/LzW3OkrmWDdqZZxzJ3uSSfwDha5CgrCoFWTAgF4GRtWlirTYbQ+L?=
 =?us-ascii?Q?D/DNP6V/Ez8AzoMbZ0g1FqpaI+mN45+umVnwjEsX2wo4Z8QRjhSs/fmEcXcT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4c2a2c-c041-4ee8-5fc6-08dafa6233c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 21:14:51.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TRU25G3bl5wVsypgC0PlnLBQ3wrouPUzt5vHCdYcKFIRCTaKu75hueBXUxXRoo/a7VHVC6CdS8htiQK1sl/1M1ZsQvHqrWxhvAedy1dFmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=909 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190178
X-Proofpoint-GUID: 5OmiFE9dVRRz8TYrUm9sdVMptlwISVKe
X-Proofpoint-ORIG-GUID: 5OmiFE9dVRRz8TYrUm9sdVMptlwISVKe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

============== OVERVIEW ===========================
This series converts the hugetlb page faulting functions to operate on
folios. These include hugetlb_no_page(), hugetlb_wp(),
copy_hugetlb_page_range(), and hugetlb_mcopy_atomic_pte().

patches 1-3:
	- convert prerequisite helper functions to folios.
patch 4:
	- add a folio variable to the hugetlb fault functions and start
	  a partial conversion to folios.
patch 5:
	- fully convert hugetlb fault functions to folios.
patches 6-8: 
	- convert three functions to take in a folio rather than a page as
	  all callers now use folios.
patch 9:
  - update documentation that references alloc_huge_page

============== TEST COVERAGE ============================

Linux Test Project Hugetlb Test Fault Coverage

[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'hugetlb_no_page'
FUNC                              COUNT
hugetlb_no_page                    7796

[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'hugetlb_wp'
FUNC                              COUNT
hugetlb_wp                         4623

Using fallocate commands to create files on hugeltbfs

[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'hugetlbfs*'
FUNC                              COUNT
hugetlbfs_fallocate                   1


Userfaultfd selftest
./userfaultfd hugetlb 256 50 /dev/hugepages/hugefile

[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'hugetlb_mcopy_atomic_pte' 
FUNC                              COUNT
hugetlb_mcopy_atomic_pte           6240


[opc@sidhakum-devel kernel (master)]$ sudo ./funccount 'copy_hugetlb_page_range' 
FUNC                              COUNT
copy_hugetlb_page_range               3

============== PERFORMANCE ============================
using bpftrace to track time spent in fault functions over 10 rounds of
the LTP hugetlb tests

pre-patch:

@hugetlb_wp_nsecs:
[256, 512)          3675 |@@@@@@@@@@                                          |
[512, 1K)          18875 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1K, 2K)            1366 |@@@                                                 |
[2K, 4K)              77 |                                                    |
[4K, 8K)              12 |                                                    |
[8K, 16K)             10 |                                                    |
[16K, 32K)             2 |                                                    |
[32K, 64K)             0 |                                                    |
[64K, 128K)            0 |                                                    |
[128K, 256K)           0 |                                                    |
[256K, 512K)           0 |                                                    |
[512K, 1M)             0 |                                                    |
[1M, 2M)               0 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              0 |                                                    |
[16M, 32M)             0 |                                                    |
[32M, 64M)             0 |                                                    |
[64M, 128M)            0 |                                                    |
[128M, 256M)           0 |                                                    |
[256M, 512M)           0 |                                                    |
[512M, 1G)             0 |                                                    |
[1G, 2G)               0 |                                                    |
[2G, 4G)               1 |                                                    |

@hugetlb_no_page_nsecs:                                                                                                                                                                                                                    
[64, 128)              1 |                                                    |                                                                                                                                                            
[128, 256)             0 |                                                    |                                                                                                                                                            
[256, 512)            67 |                                                    |                                                                                                                                                            
[512, 1K)             66 |                                                    |                                                                                                                                                            
[1K, 2K)              65 |                                                    |                                                                                                                                                            
[2K, 4K)             198 |                                                    |                                                                                                                                                            
[4K, 8K)              97 |                                                    |                                                                                                                                                            
[8K, 16K)              3 |                                                    |                                                                                                                                                            
[16K, 32K)             4 |                                                    |                                                                                                                                                            
[32K, 64K)           678 |                                                    |                                                                                                                                                            
[64K, 128K)         3401 |@                                                   |                                                                                                                                                            
[128K, 256K)       96746 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                                            
[256K, 512K)         107 |                                                    |                                                                                                                                                            
[512K, 1M)             0 |                                                    |                                                                                                                                                            
[1M, 2M)               1 |                                                    |                                                                                                                                                            
[2M, 4M)               0 |                                                    |                                                                                                                                                            
[4M, 8M)               1 |                                                    |                                                                                                                                                            
[8M, 16M)              0 |                                                    |                                                                                                                                                            
[16M, 32M)             0 |                                                    |                                                                                                                                                            
[32M, 64M)             0 |                                                    |                                                                                                                                                            
[64M, 128M)            0 |                                                    |                                                                                                                                                            
[128M, 256M)           0 |                                                    |                                                                                                                                                            
[256M, 512M)           0 |                                                    |                                                                                                                                                            
[512M, 1G)             0 |                                                    |                                                                                                                                                            
[1G, 2G)               0 |                                                    |                                                                                                                                                            
[2G, 4G)             283 |                                                    |


post patch:

@hugetlb_wp_nsecs: 
[256, 512)          7640 |@@@@@@@@@@@@@@@@@                                   |
[512, 1K)          23314 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1K, 2K)            1171 |@@                                                  |
[2K, 4K)              60 |                                                    |
[4K, 8K)              14 |                                                    |
[8K, 16K)             29 |                                                    |
[16K, 32K)             2 |                                                    |

@hugetlb_no_page_nsecs:                                                                                                                                                                                                             [11/27]
[256, 512)            64 |                                                    |                                                                                                                                                            
[512, 1K)             75 |                                                    |                                                                                                                                                            
[1K, 2K)              70 |                                                    |                                                                                                                                                            
[2K, 4K)             209 |                                                    |                                                                                                                                                            
[4K, 8K)              73 |                                                    |                                                                                                                                                            
[8K, 16K)              5 |                                                    |                                                                                                                                                            
[16K, 32K)             1 |                                                    |                                                                                                                                                            
[32K, 64K)          2562 |@                                                   |                                                                                                                                                            
[64K, 128K)         7084 |@@@                                                 |                                                                                                                                                            
[128K, 256K)       99292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                                            
[256K, 512K)          66 |                                                    |                                                                                                                                                            
[512K, 1M)             0 |                                                    |
[1M, 2M)               1 |                                                    |
[2M, 4M)               0 |                                                    |
[4M, 8M)               0 |                                                    |
[8M, 16M)              0 |                                                    |
[16M, 32M)             0 |                                                    |
[32M, 64M)             0 |                                                    |
[64M, 128M)            0 |                                                    |
[128M, 256M)           0 |                                                    |
[256M, 512M)           0 |                                                    |
[512M, 1G)             0 |                                                    |
[1G, 2G)               0 |                                                    |
[2G, 4G)             428 |                                                    |



rebased on 01/18/2023

Sidhartha Kumar (9):
  mm/hugetlb: convert hugetlb_install_page to folios
  mm/hugetlb: convert hugetlbfs_pagecache_present() to folios
  mm/hugetlb: convert putback_active_hugepage to take in a folio
  mm/rmap: change hugepage_add_new_anon_rmap to take in a folio
  mm/hugetlb: convert alloc_huge_page to alloc_hugetlb_folio
  mm/hugetlb: convert restore_reserve_on_error to take in a folio
  mm/hugetlb: convert hugetlb_add_to_page_cache to take in a folio
  mm/hugetlb: convert hugetlb_wp() to take in a folio
  Documentation/mm: update hugetlbfs documentation to mention
    alloc_hugetlb_folio

 Documentation/mm/hugetlbfs_reserv.rst         |  21 +-
 .../zh_CN/mm/hugetlbfs_reserv.rst             |  14 +-
 fs/hugetlbfs/inode.c                          |  38 +--
 include/linux/hugetlb.h                       |  16 +-
 include/linux/rmap.h                          |   2 +-
 mm/hugetlb.c                                  | 249 +++++++++---------
 mm/mempolicy.c                                |   6 +-
 mm/migrate.c                                  |   8 +-
 mm/rmap.c                                     |   6 +-
 9 files changed, 179 insertions(+), 181 deletions(-)

-- 
2.39.0

