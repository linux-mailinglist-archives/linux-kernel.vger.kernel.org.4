Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3288F741850
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjF1Syq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:54:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6328 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231835AbjF1Sxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:53:36 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGx4EC000647;
        Wed, 28 Jun 2023 18:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=UH13J6XgCVSJZdDvEd712RT4XBu0/jCLHfsA42mmFNUh9dOyb8x3vUwF5Zt2fpPg0JHm
 Qz08NxwT9ibcPBLgFeKhijatvri4R3VzQSwgeZH77cb9HRrMj/idqi4pZ1cgICIZ5nk3
 wRWz1CT/7neumMnmRSykQT6+bfdt/63ks7vQjiW4v8+UdkZQBtcn6RMOwyAZZ35u+wgv
 vMT2FiHOOifEnnJ6U9xFP8Dts6FS4DxZORUJ3nJ1+D7NUzHUhpydLEEcuEKfuFIhdJ+g
 ALnLOZNd+jRUTWkhyBorEqlZqmvTnXlCh6ioGuptS+3mk4EDKxVAjE/WaVCjdYKJU80J Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u8gmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SHbpmi003961;
        Wed, 28 Jun 2023 18:52:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxce51n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 18:52:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKkMBfWCYHZZl18ZJhXaZVeQzDj3JVTKdY5DcqXFSZ2k2vW/M4r7bqgCsX7wOJgOX2chbXTLMaQUi/faznXEHktcd4b/9LIp1oXaiuLPu/202k1dqEP8vLJEtwEeO7YAE/ctPLNLhMnWMez9xZo+5Yl1i7/t0nOAPpt5WUfMftLl5VkjC2nw9GvLN/QXVfuExNyvJof9LZHh9ka/QYwkeGkfuGZdoIKH+6/4d3Lks9e+M20o/N1/mXa+i5Bl1tI8KrD88FE6NtqiE+bVgBwm6bTPbsQEu84CiadkXB2WW1gtdPBdPwrzqZN4EI20JUvAw7IMuYLJ4PijMjdkHSXPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=doxrrkOKoav2oz3h8M1+QE3bM8PfSws2rEMBcPFsTa0qV7qViPH2U6wIPAq5f5aRRXBXemkuOfHBmHNWtyuWkMt5CvJpjFz8SXIq5LTyHaJpg+y5WsoFtzX9cl2wzwffk5HyARELeoYrOXYixbbF4/NOZoRp1Yj9OAMm4rA8lRQmZ1TbBUc+8Mk/l5eOwjEwmQnSmLovDlcHq4/M148HcLcnsgErXU98jA+kRw//tQ6dR7VMi6kprU46rP1hFIGihyslopzayrFU9DlIQY+J6c7gJw5hFDlpFhJjWIAyEwC4XCUUrFQ9A3okJ/HVgyz5xJSSTgluCLVjXN6yQ5eehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+McSM2gKtujfwRfyeOsaE02Y4bKTLqqTyQF/lTUOqg=;
 b=Y5vLPveY2QUDx6KfKBhflOtt+Oz8RyeacYFYLdpIzW+8+btIshN5+lX5ezGw8mN9mH+lgH1Oxbx3ZTxOj4QWXMZNiovZOFhVtg7rEycCm8fAvL63Wqwnd8AJpWEWmfd5GIdZsetxwZd4pxRCm2PxraAel1HraUBtd3UCHXknjj4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by LV3PR10MB7820.namprd10.prod.outlook.com (2603:10b6:408:1b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 18:52:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 18:52:53 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v24 10/10] x86/crash: optimize CPU changes
Date:   Wed, 28 Jun 2023 14:52:15 -0400
Message-Id: <20230628185215.40707-11-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230628185215.40707-1-eric.devolder@oracle.com>
References: <20230628185215.40707-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|LV3PR10MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: e85c2bcc-b5f7-4902-dde9-08db7808e13a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImAFtW6JXEJr9uTwQOfkGTHfkj2SSzV+S5ZXBCJoC+y/92l7kAaF4ZeAEkJxll1DRt7AgSsGCgOwI4D1oaugcEKxZk0mP2NR33BUuz+/nKQVektqN286aVCe3DH5pvzDguk0v7NNyDK1+paRQn9iB/v+8ywAH5/Yp9Fdf9zpN89/jPecYQtT89pNmr+Yt6LlpEPdM6AY/tACuUqGIqHi+R+vdBK84lYlfuqav4tB0IORdb2kxGuQBpszPoBTezjXq3d8SxMO5pMaoc/MsZQfBBaKADvCSHXA141qjDYfSqYGernHWhpBtWKGLGsI97DIqUWHAGiOw8U3+4DLlrgWh8OlC+wxgMsvoytxnB/wWPHh7PY77wRYDqokRn+nBhghzjIxjYd1O1MqinlkG5EPyU7Y8IXa5JyZYxWpcKu1uWr6mIAvaQx9wtEw26yzHS8VBXte/spidjHT93jojAYhnmGWo/QCMRqVU/eU+Dcrw1bNhGvvHIER2eOR+OxLR7zMODstUU7SdQH7yGxxFKtmvyhtCKIviVmAb2oX9WqKEEwyYMYlrDikP/1l1x0d8vUt/iQbs/rEjn/+0NTsBOOtlP9diYf92O1QKwqZaOVd1+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(83380400001)(316002)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(186003)(478600001)(86362001)(107886003)(921005)(2616005)(66476007)(41300700001)(8936002)(7406005)(7416002)(4326008)(66556008)(66946007)(8676002)(36756003)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJerea/3+BNz5KRRpLhJyeQrNcl095YWDm6BfQthYXVnNBdewKdI4UYKQYNo?=
 =?us-ascii?Q?lHU/r8DzdlK2iIJt0AgKfwOw1gdPswCMx0tbbXmJTNy453kv1ZRU/gXl9pIy?=
 =?us-ascii?Q?XQm1/rj9/tUDCqUllv/rzHZVYXKbobi2Hnno9RN7XVVi2+9tqYcdNE+vdcxd?=
 =?us-ascii?Q?rReTPszdDWUaXMeFOfWlvTN1wEe0jAiw+zFn76A/0vTbY2TvAAw9NOeWXCCS?=
 =?us-ascii?Q?xsu5QKN4VUeUd5mJdGBfiv0p18RBgXO1TGmawarGYQ5Q7LAmJi7wkeWUoB6O?=
 =?us-ascii?Q?5zHCzQMJMHSlNwwSepnb0oY2NfJzdAgXKKgEx6oiPwphYUaivEz+9Q4n9jIJ?=
 =?us-ascii?Q?Xt/Alrg/1T0lvcuAQsiCYvA9G+AG6szRXl6l9nqVv9nYj8eUnToMC3GDmv7L?=
 =?us-ascii?Q?0h/hgAurvcnMjv1miosIQcoTLwdUbkwP4SmFVdhF1wGrfcDqYeHYGgP9WTEZ?=
 =?us-ascii?Q?N8usykB8YdxxR0bF2u9g/kuvk3HJ6Qf1hvNfRT9ixjhZa0uh08jkV/27W8PQ?=
 =?us-ascii?Q?lIQew2D2nTCftUkIK6VWmglDCSRCeXSNI6lf5SYLASXbOtBNZ4uK2V1xaNRU?=
 =?us-ascii?Q?krlvoht8ttbZl9xQL16pk/8bkPk7jC5WiVQy+Y3IXmG2muPIaPSYKGzYff/A?=
 =?us-ascii?Q?L5zmqvyhlvcOiexd6I5HFdq8f6vUgLzSO9n9MVr0E6BGWlywFBlfRQFoJV+E?=
 =?us-ascii?Q?aR9mRzEobLqEzKD2wIWnRYuCeo2dFYZcwN5efujTGqxWjBSuKTcXOcj247xM?=
 =?us-ascii?Q?lEFo9ismBM3oSrXsoLjcfwojOHUxqCnM8utY5juJsstaXJEls7L6cUEpIFB1?=
 =?us-ascii?Q?M98CR5daikEe87QlnheNhESOZDCSRxc9kEAkSZiBso83UnyXhs1tul9LCuT1?=
 =?us-ascii?Q?PHIKYy7dD8dIpmCmWxbllOikMYJPd9tFS/WASkrKPN3vpsF9rF7bIqX4ju1U?=
 =?us-ascii?Q?bQyaEVeWUJckWeLlvayp03wML6apMZRtE+uGD2UkLJVvTMRh/0D/KWXZoiGy?=
 =?us-ascii?Q?AutKRZorGYbDJsiktq7XGTOCAiQcNPtdMwzb03UXAv6olrS+mqcT3H86CKYe?=
 =?us-ascii?Q?Yr2+SH5n51Lo2fC3kSg6FWqqqqolRJpnPShrLVVB4bowkHkhqV/oEm2IYZHJ?=
 =?us-ascii?Q?yX3CfFyoTqZ+VRwc2VpW/zlJ2mLWOcZnuDAfczL0PKGfagEyZDkfrQPVqwH+?=
 =?us-ascii?Q?nG2NwbmP5f2gMf/yoHG2zqMV5VPZ2Ez1sB0xoRFSe+JT2ri+JFTDV+AjW7s2?=
 =?us-ascii?Q?AQONiEQNF9rCMmYjXsHBIXbK8o//HmAYfLkEwWWM+sjAnXZaWbQQvVX3CSOu?=
 =?us-ascii?Q?5mJFYhMBLyo3ytB67V8OzAPY2p+4WSYGRkxPAXgNMzMbHMHblYD3M1ezukiX?=
 =?us-ascii?Q?eB/10TZEa7EzVpRdPuXzCJQjCRTPTSFQFqkGTWan3kI9NGgc2uKaBTqPre9p?=
 =?us-ascii?Q?7WgvIhZWVimEo7EgC113Ns0ScW8OftV8FJXq2HZ1Yv4JCQyoNLjhSGtdB5d2?=
 =?us-ascii?Q?fqSgZEYzHyzDlq62lbtjHMUL+e++8u5S/eQLmRVo8wWWh0pBaSUm39g8oXvU?=
 =?us-ascii?Q?KxJnJt9eTGJycz5599pfJAWm+h2EEKwH5jfc2+ZIPwVGbOv6wOUXzF0LCtQU?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TkAVws5gkeoJAKPfhXE8dxZ5cgc0+GzLdUg8jPovMCw3+U7/BfDv84kmEUpy?=
 =?us-ascii?Q?RmYPRNUcizc4T05koyMO4J16dKTlH6Coq1ajlb1QXcB8XKW33MzJA8GotGPr?=
 =?us-ascii?Q?/yPpq2lX7Uh1B/7ChYCtRjKsA2hGG1zzQplIj3cjdGTGEAepgPyuyKFs7n0f?=
 =?us-ascii?Q?vDhdGGN6j4RaoCubEBspwz3w2QShB7ao7q36hk8TNj5awfr3oeK5z81soDVz?=
 =?us-ascii?Q?Db/RYaY4W4Shi/wGL1JwriW63cI36Lb+3FTG2vI0prv00H/xBQI0Jh+uOlXD?=
 =?us-ascii?Q?a++nxRLxqcpp7stlzXI0QJKfmg/cwvvDQRcSs86E4cEiuOQQ+CKzE4USPq8M?=
 =?us-ascii?Q?v6xc9I1ZVzvCajomqKXUYMcfooK+OES9WfwOIhmQ40f0qMSqSM+RMfiOFnqr?=
 =?us-ascii?Q?A3TPNDTB2pYhH/zkMGJppRbE63nJG0pwysiuNTcJ/9HTSpYVbELcvpn0JtRm?=
 =?us-ascii?Q?FSgF8Kb35ylOLtGNVozPhjf7b/TENnRqfB3jq5RcRLIU5jBCXVhAiTq10b5Z?=
 =?us-ascii?Q?LKBJUU5BIW7m1pxo3LA1QsggttoRJLoJ+SKUrwtxyJzV/dTfjNJlirXEF992?=
 =?us-ascii?Q?ejby+4mTqUykB2ecebcC2ZMF7aVmybobPRnxFMnbpML/LJOhwmc71Lr11PyO?=
 =?us-ascii?Q?gxPqPY+Jl3VUwikchfsSqZrHo25VAJoSsF5YgQUenWmilDyP8pv0gNJCp4pe?=
 =?us-ascii?Q?mLELbr73/ZG5OQEtQ47ukcHiKgg0v29ZSgtI8rgdz7HLZQsnMbKwRcKvqtRu?=
 =?us-ascii?Q?BWebzxTKIRF/2tyOHKhOyouJ/yHrQWigARJbyoavS8q3b3+MoxsT/Khe3HqE?=
 =?us-ascii?Q?tRbqfyspmfrPASl2/sBTlNLwWUd0uxRyeF7W0RbiUPBehinf98PYtUw5p/2C?=
 =?us-ascii?Q?JlgqAFiBago9S4jGBdzYDlVw+ViyPbeu2nj3LEcOSwFK5H7mi7rc8vtUES0p?=
 =?us-ascii?Q?PVFDoiq94WP/z7bEG5Nh0jtGJRXTHJRGgM4iPKSYOVvEoOF+oL4vQ8uZiFrp?=
 =?us-ascii?Q?cU5YVUxlVIjcfDAMZ/v+eSfhSiZCgbRM28utGkuRtxB32DcwJUqytLEXyP8f?=
 =?us-ascii?Q?y0DtaUPECkWHJQMUa2oRRXa5vpOb8mU8hdx7zbM0qdSg6Nc5xiyvBKBIBbtz?=
 =?us-ascii?Q?4tzTFtOauBus16z/tv0t0B4joIZ89ZNz/WIVUaoftAeFysdI16609Rpqfxac?=
 =?us-ascii?Q?uaOju03BW4fiv+8UD7MdytFhMC7QqUTknnZiOT5gxJm1J6NfCq3jqXTpSqCq?=
 =?us-ascii?Q?wfV6F0GV6AKrAImXUlzqbmtFC/4+XUT8rKJQhaAmAxw3+hKtgbh4cdzFB5tD?=
 =?us-ascii?Q?a+QvHf6ewQjUEBo6C4bqX1kQBFGRGvD80LA9z4pcwCs3fCWlPkqFX/jhpKEi?=
 =?us-ascii?Q?91rhTs7bDDBps4K0rUthlUgXCbU1INXyjRRIyKhUfaWBh/cgTcgoXlIxgwx9?=
 =?us-ascii?Q?7QM9ayw6caI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85c2bcc-b5f7-4902-dde9-08db7808e13a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 18:52:53.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xku8gPtmRl+UAboMmG/ZI+rtftAEaLZh0FeeV7K48K0IsrWZKdgHSSqpxC0p7B+Tz9qG7nZDAuJeM2Zel+NdTmzzawT1nkMdiqlHGTQeD/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280168
X-Proofpoint-GUID: YeSnm4XcdNd5j4J4e_3Dd3VpNl7vUEaY
X-Proofpoint-ORIG-GUID: YeSnm4XcdNd5j4J4e_3Dd3VpNl7vUEaY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crash_prepare_elf64_headers() writes into the elfcorehdr an ELF
PT_NOTE for all possible CPUs. As such, subsequent changes to CPUs
(ie. hot un/plug, online/offline) do not need to rewrite the elfcorehdr.

The kimage->file_mode term covers kdump images loaded via the
kexec_file_load() syscall. Since crash_prepare_elf64_headers()
wrote the initial elfcorehdr, no update to the elfcorehdr is
needed for CPU changes.

The kimage->elfcorehdr_updated term covers kdump images loaded via
the kexec_load() syscall. At least one memory or CPU change must occur
to cause crash_prepare_elf64_headers() to rewrite the elfcorehdr.
Afterwards, no update to the elfcorehdr is needed for CPU changes.

This code is intentionally *NOT* hoisted into
crash_handle_hotplug_event() as it would prevent the arch-specific
handler from running for CPU changes. This would break PPC, for
example, which needs to update other information besides the
elfcorehdr, on CPU changes.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index caf22bcb61af..18d2a18d1073 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -467,6 +467,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	unsigned long mem, memsz;
 	unsigned long elfsz = 0;
 
+	/*
+	 * As crash_prepare_elf64_headers() has already described all
+	 * possible CPUs, there is no need to update the elfcorehdr
+	 * for additional CPU changes.
+	 */
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
 	/*
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
-- 
2.31.1

