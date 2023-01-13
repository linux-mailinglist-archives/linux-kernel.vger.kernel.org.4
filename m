Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9C066A5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjAMWcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 17:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAMWbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 17:31:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A076EC8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 14:31:44 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DK47Qt017331;
        Fri, 13 Jan 2023 22:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=/QULkUox5rmihInJovSFDI1yjAOFhDzEXSOdbMBjXi8=;
 b=iLFI+vkUqFXATgbCM7wRE78BgT6H49s2Q/Uti8bH6Q1Ha8G3PrKC/h2TfPC/xrMDQtzh
 YohNFKVaYkbheuc1vhvdaogbwkxXsNfIdOWfygmuHN0i+y8tIXJ/uM33hJ7ecbxP17zd
 d04l70T/phwWDYYqgNwR+rZNw44c0w9JpkzimNHJlr9/MN3+YXDZzGbHuw0ldWJvq1tn
 0hnWA7e+fDdFAbYB3yccnsnRGZSjf9mypZBC4uqf/FmBm4QzwVoUhLj7jbr74toMFBQa
 B4VzKHKshdMvFdoKGSGgC2n/cht901omCyX4iPhsP5LRnT9HUUTicvn3Vb9GCjG4yPcn 5A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3dxhr9xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DKwdPU006693;
        Fri, 13 Jan 2023 22:31:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n3etdjktp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 22:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpwIQYacfImDES80svwpo4TGMzmcKnZHIDH15IxyUjbz6Q0GbV0bU6vO0w0yrmVlaUC/rQ9jW+6MnXFuWDM85Hjj7rCq0nBQJ0KERBiBFXbjhm2VBn3xbF8Z04mP2YdBIv1TqLwbwXhfSEa9TOj8Sk9LC6J97TOLh8AWhnJzj+D05dbS6h+H36mSiDMZ1N2W0D+m2DhLeWeBJL1ndb/En1+SEMStjHJaHmRIcaQv9I7+aS/wPiLF8VQp/uMprZhxEy3e09hCD7Pfnup2LSRTqQzOdTljuEj+hyAUVVeyDv9tNQqs+8XIb5hU9X4idMNVUVbG4FlT9+i9fUQYSIPGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QULkUox5rmihInJovSFDI1yjAOFhDzEXSOdbMBjXi8=;
 b=cfRk4baA57e5YfF/Oho5BfKvg3oAYi9ffgq/ItHGAzM7dF88X/N6e4ZW/Sh6QU2JVnPxwHlDz1I+uvUmhxx4FyPKBlURje3nE0NUhqdqaVS+OPbWigfUnycKydiBzIm4BPyCSwSBLQ7+UIeg2BKOczBHCGGXg63lyc4Q2dlnqf++I/SooLJuRhGnqTVOYEJ+P2R055aGbShAIzhUxse8u0oAExfukh98z5gMMwe0+BExZs4TAuepbEllJn4KyK/QF4HvGzuzlmHTjlt0agd2Bydm3j2TDgZwxQwlwxKnfJZt2BLys+IpkNgVdAexBmSoXXBo0TfTBJwX4i9m3iGQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QULkUox5rmihInJovSFDI1yjAOFhDzEXSOdbMBjXi8=;
 b=kW246ouD5xIROEDXsbwVEafuJ8oL8MQAZpbmfW8tlomQbUnZa+a3OsGa8YjzQzaRej1KpSUvBE4OoqNp76NxdA0NZOuTNKQqpXloaoPxy84bfdW/J+M+fzIaLPU0Kg1kSuTaPgIKi+kuoebDWXcye5s2esvCZWZo2+Q/KrRnEH4=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 22:31:12 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.011; Fri, 13 Jan 2023
 22:31:12 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, jhubbard@nvidia.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH mm-unstable v3 6/8] mm/hugetlb: convert alloc_migrate_huge_page to folios
Date:   Fri, 13 Jan 2023 16:30:55 -0600
Message-Id: <20230113223057.173292-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
References: <20230113223057.173292-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:610:e4::24) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c70bdf-fb1f-4636-60ee-08daf5b5e00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5idka6sIibe0a8L2kII7BC/x1/ueSCov7s8o7QoIf7nArJZMJRdoOCYn14OEamjoPihBdH05tgFKjCtTDnoqyH/jXGYMN7FKlPPpjcqN6IvGUO5C7aB4KHVcBDaOvGJFGJRN7qHTNN8RNc3r5w1WMq92ovQk/VUQ/BRYZiEKk7VG5lnFCWafdtVUQWYyvYUy2jYZuSYd1JMEBxfIgo9xLwvCDrgvOlvfw6e2Wujii3wh/UcJ5cfmYHhpHd7pRgxlEWSdyfg9qqAl9WamLdzX35dBot/IuUVVrLWvFuoDPnpzhmpOlPgX29bLNH9iraTLSrYYv1G36DZBIFmREvGHdKOQnFwegKhOZRmXZcEkPDmE4PxryRIDHxUCvLO5aTfy1NFag9A0O+yGmcF0I84qzM63R8/XocJ7qNW4XnROlkN+GTVyLBPmm5qAVAMQ3lWBehcA6fkiCA+18klLYLGsBJEzXQPMc791xGcgbcIF8CrhppomSbncHZ5EoVY/Tle612ZhrbR1/loItIG1UBp7SwaJFYu0OV7SJYS0rL24nQFP1udXOv64A/k+EVHapxNwjTw0tU6VmCsJOgIjZKGSX5mfpjn/thKJoPfzqIiainwDKXe7bOcBmlKRQ/mNvN5uvHuN9+1lL9Fc4ANCatmxb+61wK4IutZ5K8kEEyHTwBp0o4O5TgKRwaHEVEG/6e2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(44832011)(38100700002)(86362001)(2906002)(41300700001)(8936002)(5660300002)(6666004)(107886003)(478600001)(6506007)(1076003)(2616005)(26005)(186003)(6512007)(8676002)(66556008)(316002)(4326008)(66946007)(6486002)(66476007)(36756003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?On0CBKCY/2wAeT1JLFLoF5AqaNEE4qvbwY/eos4Jt214WjxIkiJi7fFA4CYM?=
 =?us-ascii?Q?FOiMmSqoM83tI7v/wazLwFvXQWOMe3gX4sU4bxq5Yu9zPPGFKtErPAqNWHKC?=
 =?us-ascii?Q?tvesZkdCbjL4v4Lz/dKKGxQiLcG9rYVMamIeutmFOfJxmAttfBGT5DZO445Z?=
 =?us-ascii?Q?lOBeAAMNBYGycE9MMjFPhkmyWmlXry+gxRo6kX+O/cOXK3Vr+nc+puyvW05+?=
 =?us-ascii?Q?6dVSjsuLtKr3RpHBe9EY9QRAOoExQg88dZ9J0YNyjf4hjHQqIY3tunQwmMJW?=
 =?us-ascii?Q?aD9b7zYZiuApPgCn4WaRRjUuP1L9ywnIg1T4Q4TmxPZYlXTrsmreZmGQRXSw?=
 =?us-ascii?Q?5oFn54pOhHkgQIqauAQ4IQrsCLw1RX2jjBb2Hx6luDjpCVc+6rFnm8zmwgrF?=
 =?us-ascii?Q?70tk1NhQHql+PlPvTSX2vdm3/R+JgZ3mAE1PlftBdOYs7svia3M1+KxS922e?=
 =?us-ascii?Q?1JenIdhHi6WSvdG7iZv3T34d14mduh1QhXD06OLIp/HIN+nTRDD+987mJisW?=
 =?us-ascii?Q?XNts4ECHRjyhFEqh8eCKHSKBLGsEKUjGBdJdw/Xg3PU4BACY7gCSKrcvVAjP?=
 =?us-ascii?Q?4dSA5CUIshMMMWFqyDu+YDZ02i5CItoKGY8AlGrKK9CKJSokJSAsne67qw1H?=
 =?us-ascii?Q?Yq4bpPOqHygtYsV5Tr8jTZpWWI7udR3arjs8qhENMVAPRmzbpwzkfRZQCKWq?=
 =?us-ascii?Q?31feifz0ggaKk5zZlXQHha9bWxj3NkPuH11Q/vpAFAvH3i0VmIyp9EKWF83K?=
 =?us-ascii?Q?MW6JKpyGzdMsVH22S/PGN50ypyy8AEvkBfmP9TwgjAuLPwU3fHeBgQJIqxh6?=
 =?us-ascii?Q?jCAkbSbruBqUZVErm6hLwsgg/AxdrjrjpxKlMBYgrcdPt2adt6yF1ELYN9hu?=
 =?us-ascii?Q?h3us8QYk/M12CSLK4A5nkVQPlAOzu/mOGZS/ZnvMBoZpSEyE48gIuq0K7CRL?=
 =?us-ascii?Q?x4KSdwQpmq0ivhGxdZXXaJ/fpe1t2DWkDjAoT/pWFBW4mlNoYUMspHJWfune?=
 =?us-ascii?Q?ip23pXOyw09//hD/PptTISGIjP8rdMP/vG5S8Jj0LHqqYGDZ9GjcHq8Q/hb7?=
 =?us-ascii?Q?AIcHwITrRInoRsfzcwSNFtsWPmXPn18+qjQF4OPmJnpQZX8TSbwWUZKcPH/c?=
 =?us-ascii?Q?4FMBe/ZmG6Yzo4diTruROseEzycTLbIxXIOmk3Tmfyb1P7J10Oc0ikfhhSHY?=
 =?us-ascii?Q?6Pgap688Qi1Tjjj/8/jdqNlLcQy8nfy9i4nNWt89frk1YoEXjG6Xo0MX2Znw?=
 =?us-ascii?Q?Qa3jcfm97P+br8papUDlOpj4UiiF3jq1zMCxWvc66LP2gJrY+LaZ3JzJBPSB?=
 =?us-ascii?Q?n/Bola9ioGQ9b8kEi9JXKKcOEgah8JU//Z4o+yWXl+GgAsluPWfw+nwuVv7i?=
 =?us-ascii?Q?Lc2inlsHBhQlwbdq7J9n2qBwfzLP/Gfd9z+yZn3uWfM4k+hfMhvgAoD6R43D?=
 =?us-ascii?Q?5y22L1BT7uMFYJDgsRbnRoBHVN+ycpHCklsbyQhfWitvs6BshWjba1GqCAzf?=
 =?us-ascii?Q?LZfT83873rEAtvOW7O2HJEUZVRrIP2XBEnYqDQvXkuorAqnFvGMyF12zv5fE?=
 =?us-ascii?Q?qA5r9sFVDXoxmDDN3yJcex+M9ISnGYiQQAgT/h1suYspaR69SFD+h/7sTbCw?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+blppuFLsGB0TY903+wtROZjRDE0c64N0jH5wkkNp4C7tdnlEbIJX7xYHLIJ?=
 =?us-ascii?Q?xg3y2sz3pvy33AGZJr8XQEbTlxEG8u9Z1lAGy2ILFnP5vJa6iLONqzzvLjOb?=
 =?us-ascii?Q?tnvgnFX/nfW4/r9P+oOxV33Gr7xRW1g/PI7AgZLkxjTvIEmaJd2b7k7v68AN?=
 =?us-ascii?Q?O3DWGQtr3kJvk/ylQ47oTOk4djb/ZLmK4ac3KdniXZsiG5E6EntH+QvYe48p?=
 =?us-ascii?Q?TjJ7xHwTz0qabtVq9sf3VA3nJBNAZgpfW78KxA2fVl8ZSgDAkxqZk0M8G7xd?=
 =?us-ascii?Q?xf4Vr+KSsFeE8FUuUd1kL3u051GFzPt5HfNY7dhwJb9dFp3L+aabAf2AUS4o?=
 =?us-ascii?Q?zfp3wpce3lxOQ9QyuM8J0o2FqZOnfbHHiC9EouCHdtsO5BZeZuNCq/UPxO+4?=
 =?us-ascii?Q?t/px78kbq44HAZleLXbHZHqsouQjAAmW9c1aShuZ2fVw3gSGU+vZjHzR/48N?=
 =?us-ascii?Q?YcCFaQnP9BDzWYpodnj2KAcEePfaWufp8KHglgyMVF8TQxWzvXSOg1OWU/O7?=
 =?us-ascii?Q?i0HSwIyrlMf4FB4r04Y7PuWUKC3292VSjTv/a0fKxZcVHkWspXyCS22R/jql?=
 =?us-ascii?Q?HVl/3gsngGVctVy54E6GLKsIH7m5BTc1qaGlnIXz58q9cQw3UNdAcBlLzS6G?=
 =?us-ascii?Q?cGW+j1C6h0V6e7nyK/LJhlxFr19nY7hZy8cbDjn9mlE5A/p8B7t/X1xL5lMx?=
 =?us-ascii?Q?IxgLs0QWLafxPZn3NoDISbTp9e5RegiIe0e9IDP/ldEjhOp7NaJltA4RHq4x?=
 =?us-ascii?Q?CUYbTJTCrP5+cUNWgZQ/48K2hoRcCOJQSw1/TiCt9YYW/uSLUYbhBbyxv6Nc?=
 =?us-ascii?Q?38RMrD7KXEGl30C5tPNh3qBTSnKQPPHEskXy2EeFlPYDsstSGaoSoyjJDcan?=
 =?us-ascii?Q?5jrPvUTY+6G8lOlvos7VuU4sUmvZCmFOggeQE1PwHkYhgbjfhXPpoIhgSOzl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c70bdf-fb1f-4636-60ee-08daf5b5e00b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 22:31:12.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGlEtD9Ku/4TAo6IYCBlqMraL8XB1bkn/4b59Wtt6QT0DyrqRedyWjbJBjaYKQH9qsWfthMMaVL1qBRGspkMi6S/TYjTGa24KplPs+/jh/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_10,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130154
X-Proofpoint-GUID: ncM5SHMg8SEG6cti6XMu2woIi0VAkiXF
X-Proofpoint-ORIG-GUID: ncM5SHMg8SEG6cti6XMu2woIi0VAkiXF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change alloc_huge_page_nodemask() to alloc_hugetlb_folio_nodemask() and
alloc_migrate_huge_page() to alloc_migrate_hugetlb_folio(). Both functions
now return a folio rather than a page.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  6 +++---
 mm/hugetlb.c            | 18 +++++++++---------
 mm/migrate.c            |  5 ++++-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 482929b2d044..a853c13d8308 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -680,7 +680,7 @@ struct huge_bootmem_page {
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct page *alloc_huge_page(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
-struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 				nodemask_t *nmask, gfp_t gfp_mask);
 struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 				unsigned long address);
@@ -1001,8 +1001,8 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *
-alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+static inline struct folio *
+alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 			nodemask_t *nmask, gfp_t gfp_mask)
 {
 	return NULL;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f3e1d052b40c..c0cfb075cd58 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2275,7 +2275,7 @@ static struct folio *alloc_surplus_hugetlb_folio(struct hstate *h,
 	return folio;
 }
 
-static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
+static struct folio *alloc_migrate_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
 				     int nid, nodemask_t *nmask)
 {
 	struct folio *folio;
@@ -2295,7 +2295,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
 	 */
 	folio_set_hugetlb_temporary(folio);
 
-	return &folio->page;
+	return folio;
 }
 
 /*
@@ -2328,8 +2328,8 @@ struct folio *alloc_buddy_hugetlb_folio_with_mpol(struct hstate *h,
 	return folio;
 }
 
-/* page migration callback function */
-struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
+/* folio migration callback function */
+struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
 		nodemask_t *nmask, gfp_t gfp_mask)
 {
 	spin_lock_irq(&hugetlb_lock);
@@ -2340,12 +2340,12 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 						preferred_nid, nmask);
 		if (folio) {
 			spin_unlock_irq(&hugetlb_lock);
-			return &folio->page;
+			return folio;
 		}
 	}
 	spin_unlock_irq(&hugetlb_lock);
 
-	return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
+	return alloc_migrate_hugetlb_folio(h, gfp_mask, preferred_nid, nmask);
 }
 
 /* mempolicy aware migration callback */
@@ -2354,16 +2354,16 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
 {
 	struct mempolicy *mpol;
 	nodemask_t *nodemask;
-	struct page *page;
+	struct folio *folio;
 	gfp_t gfp_mask;
 	int node;
 
 	gfp_mask = htlb_alloc_mask(h);
 	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
+	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
 	mpol_cond_put(mpol);
 
-	return page;
+	return &folio->page;
 }
 
 /*
diff --git a/mm/migrate.c b/mm/migrate.c
index 6932b3d5a9dd..fab706b78be1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1622,6 +1622,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 	struct migration_target_control *mtc;
 	gfp_t gfp_mask;
 	unsigned int order = 0;
+	struct folio *hugetlb_folio = NULL;
 	struct folio *new_folio = NULL;
 	int nid;
 	int zidx;
@@ -1636,7 +1637,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
 		struct hstate *h = folio_hstate(folio);
 
 		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
-		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
+		hugetlb_folio = alloc_hugetlb_folio_nodemask(h, nid,
+						mtc->nmask, gfp_mask);
+		return &hugetlb_folio->page;
 	}
 
 	if (folio_test_large(folio)) {
-- 
2.39.0

