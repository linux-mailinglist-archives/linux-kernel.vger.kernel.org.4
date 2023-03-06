Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73D96AD311
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCFX5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFX5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:57:43 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF026B324
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 15:57:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326L9s8U017765;
        Mon, 6 Mar 2023 23:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=+ZBk3yKmRye11luhE/Kb4jWYj/tD0Xrpsp+BfdWAE8g=;
 b=K3PW+SRnvQe5WCX5SbVINM+isw1cyisIHJvMBs0ORUnCc96jkuWmfIbPMIrS0eNT/P5V
 uhwQPYaP6qKiy2jY33ZaWz97gcvqae38P9paXCcBlKVBaC+WkcW+RUSG5sPt273cW9Ws
 1hFBg7tXn41f8Akq/K3D1Yrx+n/PlBDEoyZFhaxRhtfhv1plkMKvzYqHHDMVvMgO5BHT
 MoNr+bSfW5vGE8s+rbrDkjUo1EabZHJnGb4CM3DFMfrdargMUyHcy9GQdrRx0U+Nf/fx
 Afg+4dsAj18s4pDS0BEw3tJFxn+9FaL+A+A1rdMwhqipdzBRfdATFO6hZfa6RhkXNJ/B dA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4161v945-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 23:57:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326NRweu011181;
        Mon, 6 Mar 2023 23:57:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2h0fka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 23:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kirUIBIoneShc8v4jMRz0JFaIkdoTQum6/RhQB7D9Pn0CLllvddCzlEcrDioKCgwiHY91RTErMiHal4gmJP/B4FbStTfh/H47Z0QKUvmATn3+VPaD+4bIchEoTGo8QO6Yh3RHTRnFU+2G/WXQj+/Y8wxN6LCpO6L9sTl9uPi3ToHzhnu0o4ZNvUlOoMy/Rqh5/S43r1UsNu15LwaifH/xsAB1rkMJ6NogOQhjs8Ow66ek5jg+oqOu1xeLv1d9JVQw6CPyVRuqQnpu15e3mz3xtSFu5VEVWarZ6HF/QBxsNjS/CRb4v0hyQ4zIl0s2EOWK0rIBbtpVRskGGodfqOeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZBk3yKmRye11luhE/Kb4jWYj/tD0Xrpsp+BfdWAE8g=;
 b=BySdXdgGTSx4RywlTr7SndPEDgIIQO2HYCeCHmOOcHUYrIfHvwgKgAX4AakjSj0tyd3FwE/2fkkrmOYb1/v+RaIxxHzl3prAtc/RLsJbFOgJoXj0IAeJONWvDfqvicm6hmFErFnpu2QFzmWep0htvnMnGw2AvlmkgdHJPwbORCiLdHz74kLRR0gaAgg5qZYb2MM0IHAjWguKnn57CBzOjN4MwTZU34Kxrkr1keRu+7pDh2PgQAtC2NHvJHhGuOvIpQ5rT2v0fmJDQOfC8zCiqDixGkbb0ojvGkMN0KyS+gEJD/rn3/dNwLf+KfhMkzQha5l2cO63HBjRxP66GxzYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZBk3yKmRye11luhE/Kb4jWYj/tD0Xrpsp+BfdWAE8g=;
 b=pR0j3n15LAlxkym2H9Fm1LKhGQ8wHmsV4ovV8tcVfGbXcuaTVb1tTx/lDBOj/BEV3COTBNIu6pLyRFwL9wK2mw5CU8f2icYKV0tTZ3+MI4hrUPNu1Lmu7UtjLV38jKarYLn4JPU8jv/3m5wWwlelLwK7/LnHKXo14ea4MPjlf3A=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7170.namprd10.prod.outlook.com (2603:10b6:930:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 23:57:33 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 23:57:33 +0000
Date:   Mon, 6 Mar 2023 15:57:30 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: THP backed thread stacks
Message-ID: <20230306235730.GA31451@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 848bae97-4e5d-422b-66dd-08db1e9e8dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqVjea5Iq2epPM5+kjQmI0uwRNJDpJn4jrNCbWg5J8ny9IpFVvPRQUWZDUV3tLlAxrRRc+lYftack5JGv/mG2oHDZ1g/o/+k5co+BfkCBmpgYG758Z211nJDDV57h2lWOkJ88nA1nyEoOtr/KjDMgk3ftEkJupIDIdj/Yl02qMzmeGzwtYUqdUkFSHYkYaAkokPb8N4ENRQ7Rtl7AR4Hfx++zzb8MgR8LNG0JfpdYR0kqD5VgWY5qZDey7z8O2TvCIGA38yMI5NivICx31IK6A+n+pPkx0vYzu6nsQKIDJOt6F5TBowl2v0Zi1nIZ/cKxhx5sOHw/8SjHuq5tFq2WSb4xvzqo283uYXjFky4b0Hzo4R5UuChDRGozb1uDPCbdPbiIZ1u5O2Ca5PrU3gQ/ZMdWDjybeYPSucTu4dV1TEyiD4dUrXSKdh62HXGSLCsW2YcZY4CqixCZUyfQu5e1s6qk80x2rdvMb9kI7r2/CMxYODk+Fl3lmVehATK5eRBVdyPQu85XjPLMBqjJvhCPxBRqcYwEFl2D+YjkghENjndYqfNI3QgGIRrqd5VzXWNNb4peoV9vlAT9x7DAsJM0UdRGhSKpZNkvgs2q6GzXOarIiippqt9m9upEWToHPCuQ/PW9Yirb/ysj5LTRCGH3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199018)(66899018)(66476007)(66946007)(8676002)(6486002)(478600001)(66556008)(316002)(44832011)(5660300002)(41300700001)(33656002)(86362001)(1076003)(26005)(6512007)(6506007)(186003)(38100700002)(9686003)(83380400001)(33716001)(2906002)(8936002)(3480700007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tmz+NsmTy+S3olvh+k8HJkj8bjQbX+xXgyUK0fnu7wtTfaUCer918vttbd3?=
 =?us-ascii?Q?Xi5t2ylpxYcPpEazu8C0lZW7CK3RHV2csPd0NBC/c9WhXuzmLGfksybwHr3r?=
 =?us-ascii?Q?T8SsYMY/ABfLhUUETISeo/6uYsjUZ8ovafJJjTJMDGlstPyF1TfLYRa7jGVu?=
 =?us-ascii?Q?PqXUhdbIpvZDLjrMDO6mm7UjF1E/OOI+9j7i1yCkmdVAKNzg2vl70+UaxRUu?=
 =?us-ascii?Q?zDedY5rZCnU4GiIpPL30rAyCQpTIX51+6f7sR1GpKzRC3a7VYaK3dJdwD/86?=
 =?us-ascii?Q?vPnJ8Yz6W6ftMTd4fOG/va1T+akaoW4NeFkmEJogesTspfXkjYYyVewPm7lM?=
 =?us-ascii?Q?3YrLVQb8jE/9O94jI4t3tOL4XWMkK/k559nezCpOT4Lj3D6wAogYn4vHncQ2?=
 =?us-ascii?Q?cfkwJeQxkpwC+uJHaMmclXJgXJ46vn9WWfKLWZHckoDmKlCkFcCwggBpYcVl?=
 =?us-ascii?Q?tLHv9MiYhkvFjBrcpI9spLHfKY3o3Vj/IXBjID70/WE3eKmNbEGWbABNXQcy?=
 =?us-ascii?Q?jRCz4rw1cFeD2iS+3/bISKxobQ6DSw+5EGfwMNSUVTsB/lXM4QfOqerIi6YC?=
 =?us-ascii?Q?GKfmCYLIqgLy3OigxG94HpqB0wNFHXVJS0f1pxL8mLQTd8Etcl88C5f9C9qZ?=
 =?us-ascii?Q?DTA3gDpw61JJ+inmTfsayxuTjc7C1++2peCq0G3Idty0reBBxqMnG/OSOQkx?=
 =?us-ascii?Q?1yDkyJ/fZ5htyGzyB8XwtgPvtJVE57OeOYajrmwUOZTaEAOWTr7uOPVrmR25?=
 =?us-ascii?Q?0vK8G1xebo56OZCKQdivCNxi4NYzfRm7SfhYJfUOUIbx+uTjLrwMhs8WXIZK?=
 =?us-ascii?Q?eHjCr25+SbAewpNgQpvV7QNoLLcO+qoaEr7hox7SSHSxcLQynQwK+klfISMU?=
 =?us-ascii?Q?RIBVqieNRi6EaJkzcGrjKV4np6MDk0pqL2Bjfi3oCze3TFDSzSwrL8mV8gjv?=
 =?us-ascii?Q?IiC2sJhbQYkk5lPSHFZgdX4iyDomLiQ50cayRB8y+U5aeNiTXfr2A7fNzyDu?=
 =?us-ascii?Q?C7z8SkjK3OVaLOvLqneyrKMBHGqdg0DSv2q1azt+VDRQPDOLOkL9Cs+/xmDJ?=
 =?us-ascii?Q?4JEbvj5MVE1AaCLjKQF3xDHQUBolJR9K89bwQsNGuS/XYzx8bEp476hbuOKA?=
 =?us-ascii?Q?1ZQL7UV6EclcSBUSQ4xnOfGbMFuZU0a9OIRs09EUufiNG9OSxQh4C9tMEWwm?=
 =?us-ascii?Q?HdOeuLRLSK+xwku+4gU6DHxNHljCAusnS8xyAtIEd3hO7s1ZZxtOZAW9p2ih?=
 =?us-ascii?Q?XuU2jQB3hBqpdKE1i9gYkiMNIwPR/dMnqIDbUKCkw7+ifzkargx1NH0hbEuW?=
 =?us-ascii?Q?1db7ixWoF/JbFFeAGBZ9HDb2xYfPlpRqZiULTglDoWBV6W6HholRHIwdXo5N?=
 =?us-ascii?Q?XZgOtpn4JBMOv+LiSasdMGnORe4wLrmiL+AJFHxPYoyEWTME7FAb7ivTZaZ1?=
 =?us-ascii?Q?1jGL7RbcK5Fc2hfIy2rOu79tlkUKAI16DO2mVfaZ3WZLbJGnJ4Q3V5W8N3J8?=
 =?us-ascii?Q?2vXF2DQ0N+aoRyHPjT2WK8vRjPNwtGpWapk7qBw+mVKp6g52XJjzcLKgXOLy?=
 =?us-ascii?Q?Ps3rzNAY1Z352FeZ0QBzfCgf7CPLXPanTegc4HvW0eN1rPj2LCRbDCfiCPhS?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +6ufhGMprN4d3ig4edOAM5KvSUONBPVSXphHbjxF9OLvoLZrINQrOJl/Y+EqWswQGwBzhMT8P3XqjKiA/zOVVua/AkaTyeilaecPTOP7/iW/mvhVkLxquGmsD4b8iaBF6KhaEJMxjbU0f89AZQu048b+0CRoxKMf8diK3JBZ1VHTPoHKN9Itc/FxT5I8HOapaxFjWZx5qpwFhO6vNbjm2uO3ocHBOW/SZwUoedL/8dnb2jmQWatO9TT+wSvE1jJ5D4meU7UwOnSXiu7S3Foifn4uPuMhA7zSh3OW2gQdeXMi+lvFhqk9lMPW8wT3Q+lMsxiwQdqlfX+ZHakHGns5UhYW84PDXaPmRdNUWeYC031AQ/1sqHYtnqJPpoglj6z3xiZfo8ma92ndP+/vUtN19QyADQk2xgVZ6AKfS+NJrQVtva2iOEsml7yF3nubl67LV/UVDWPG4YFmh+CxhyPV2FqLqCKFfwEUHLt6DpEI86AqtEp21obUNeaZJpo8VapkfWC3GIzYKQPIwgDbMM7oD7yLj0ND+Gs8X1sZvbXOamvgxpp1bovk1lFtY1yUNWN0Nq/kyNr7hwEjUBF1m1WADry+A89rX8F5Cdjejc2oAMSu8Up54PhYTY1uQ54m0Yh65gmMabrKfSMMHbyOyNAB75OR0hNCAzUslGLFjeKBC3eSpzjIORKoOC5QovaTlXjqsH3oZADAxBnPFMMr7vIEodYxCD6L8QPTNu5oYO+gMMCfw03FpgYdqvWZtZ5evx0NOlRpGgPoIdN1Qi1o7VDnIBS/V4LwYVcsJHrsekrkIQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848bae97-4e5d-422b-66dd-08db1e9e8dae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 23:57:33.5145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZ6Ja6HBl6kdBdReJ3vs7fXMvXIlyMjs9tg4aq5ZZWzCiNLIybzflptFxJ6cnWDMX7r7gYjmh2BJNJktndsKTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060207
X-Proofpoint-GUID: 5iEs4ZJB6DCwHl7dG4v6L8uhelkax-iJ
X-Proofpoint-ORIG-GUID: 5iEs4ZJB6DCwHl7dG4v6L8uhelkax-iJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of our product teams recently experienced 'memory bloat' in their
environment.  The application in this environment is the JVM which
creates hundreds of threads.  Threads are ultimately created via
pthread_create which also creates the thread stacks.  pthread attributes
are modified so that stacks are 2MB in size.  It just so happens that
due to allocation patterns, all their stacks are at 2MB boundaries.  The
system has THP always set, so a huge page is allocated at the first
(write) fault when libpthread initializes the stack.

It would seem that this is expected behavior.  If you set THP always,
you may get huge pages anywhere.

However, I can't help but think that backing stacks with huge pages by
default may not be the right thing to do.  Stacks by their very nature
grow in somewhat unpredictable ways over time.  Using a large virtual
space so that memory is allocated as needed is the desired behavior.

The only way to address their 'memory bloat' via thread stacks today is
by switching THP to madvise.

Just wondering if there is anything better or more selective that can be
done?  Does it make sense to have THP backed stacks by default?  If not,
who would be best at disabling?  A couple thoughts:
- The kernel could disable huge pages on stacks.  libpthread/glibc pass
  the unused flag MAP_STACK.  We could key off this and disable huge pages.
  However, I'm sure there is somebody somewhere today that is getting better
  performance because they have huge pages backing their stacks.
- We could push this to glibc/libpthreads and have them use
  MADV_NOHUGEPAGE on thread stacks.  However, this also has the potential
  of regressing performance if somebody somewhere is getting better
  performance due to huge pages.
- Other thoughts?

Perhaps this is just expected behavior of THP always which is unfortunate
in this situation.
-- 
Mike Kravetz
