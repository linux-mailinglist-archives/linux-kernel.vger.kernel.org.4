Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EDB6BDFBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjCQDof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQDod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:44:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616438668;
        Thu, 16 Mar 2023 20:44:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H26PCB017660;
        Fri, 17 Mar 2023 03:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=11bNJzNSsSlMNqr+GEuRg1wfGhtzr8bPKdK8FKzfFQk=;
 b=p2lnCHS39He4ERDK0G59lBH1w1sjduBLI8+4hUQFk3eh/BnT2YRTR8YpY3KDPNse2q6M
 omnNul4SGwUNj8fLtfYBK5aIAuwTtSdXnwwEupyd+SFehJUnrV2y1bpwfIJrxJdyvKI1
 UbmhpdUTH/SoNCzgS9v4HJEf8x7fnG/P2uolZ0rW4KafULCxcLLPqi3yNW9g+EESVWZS
 R07TAiXmOnjLe7xU147HbA/np0pp9AQLiolbCiPmWz8sj1qXH0GQhNR5jr5tz/Oyb2Lb
 OXCM2XVcgh4yoYOISMnisIRcKPL0BUNAw4Wd0ebNfVh7tS+ePvNGi2Nw5sNr0r9xECbg dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs2atrvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:44:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32H0YcXb003166;
        Fri, 17 Mar 2023 03:44:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq45qm03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 03:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZsMu28fYxp7qzWB+iVNOU6r/KZoXKhjZQgyTOh3v8ynLpb5kOWEQlgEgp1WCHCF0yXjWf8Jvg9RuJW6bxzphnFc6O/Wn6C84JQi+9o+HnEveQcI5mKhKniHVjnQsD9yp4EgV0MkzkXQAS4w7rkMd4pV3P//B6ZMR4uJd9rjcSk2bqqIPTQR/2TypzVYivCv3O0xz1CSh0hjI6gihvQlv6TB9AiKVYv7Idta9HW9kXwk9EPHxSFjDbsmGsUPortpdSwPQz8iO8/9kHlldn82U3wIUgKONRKk48yE6ZZWplpptWFImKqj56/xQxXs5MMzUk7fJfMvVvhJYZKyw6DilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11bNJzNSsSlMNqr+GEuRg1wfGhtzr8bPKdK8FKzfFQk=;
 b=QpFhewVPaiaJYbRVJzBrDSGhZcEHQ34USDYmkm842G86KuFkYanUgZSxVNsXGDEmbCtiSsdhOoTG1vdKaH+hCKYb9k3X+NeQOWGyOXkUlRAl+5V3bjnn/qxrmpQArEWQFXzDQod75a/wxs8DOiEi7wmgUPXhDOtE4sP0lZAlYTv9AQLhYARVYlayM/ihqE2kAEUNWXae7HJRs2WU67Ks+cOC2CL7/h23vvekIvzHphU9RlEx/kUKpLGM9fHad85Qv2Bton9/sXZIuZ2qQhj7erF+MuRb9HJw59bW5zJl5+jryflDgkPv3bF6QqxkTokTHv76X7toWKTvXj+U2b9gbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11bNJzNSsSlMNqr+GEuRg1wfGhtzr8bPKdK8FKzfFQk=;
 b=OO9Lgtw2JOmEOX7W//9iNWJb9/9AZDfIINe+DI5ZtQz/FM9Dlo6ywjS7jI40+SVFn4+ZbZeyh2BLyungIUqyXbSYjy+33ApUDMSblShhJHvvkwD66sh79dZnPYMDR/vqx+W5naFKl3LTXOHFBSkal4nuPZPVwQn++INHQlhXjs8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN0PR10MB5935.namprd10.prod.outlook.com (2603:10b6:208:3cd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 03:44:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6178.031; Fri, 17 Mar 2023
 03:44:23 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Use of_property_read_bool() for boolean properties
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15yb0xcs7.fsf@ca-mkp.ca.oracle.com>
References: <20230310144723.1544999-1-robh@kernel.org>
Date:   Thu, 16 Mar 2023 23:44:17 -0400
In-Reply-To: <20230310144723.1544999-1-robh@kernel.org> (Rob Herring's message
        of "Fri, 10 Mar 2023 08:47:23 -0600")
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN0PR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f5363e-43fd-44d8-8b55-08db2699e606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7k2Qla24kASlF+nZJPVYOhWjIeoKiJs276iatOzr7vUyuMsbtckdySQTW16dxyG8Khayoah7+JZPzD7Ymo0YZwgF2RdXBz4UabMUVJHH4/UmUAIZjTl/8zj/f7W5jRh15y1m/C3Bqo4cUa08iauFGwbsUQlM5P6lLewZ21warQI4SOp5qetn14N+BId9RAI9PpfM4MGYBCVmBFS5T0B+2hYKegXAfmcMGZtrT6Rkii5wJu4ak5JZjVbkQVbvjQfHi5tj4Sleh4JiM+tkk91a4BNwdV7OZ+f3yooNyNnu8UC4egeC7sgETCxkpLr1kbyv1KW3sk2nayDNeTXTd1WkAbCjJR19b1UgQpi4+Xl+HJ2/Q+d4UxhJs8IrSq7lljIT5R+95/HR7LiB3sfVW02RKeUl4ooXcWxvR8BrdZ45ufy1GyIkZ8VqiXFyZguEqiOo5BA+JzjC9Po0FxnaYjFVxyfbHx7tsS6j197SQBWROz8IrYsjSrEHaA9T73b5qkZ822x1Okj4gRCVQNnDEgs+9fJ7tzog1kmx1jGQ0vctFPy9RraDClY6Q1uJEalQ/6tfLXzSynGq3d+vjsehEmLDCRJVrqM08zFCO3l8rsvpo6+HvR2xMSD2UFx19/3Snc9eF8BedBMGiSrDxID6CehtIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(86362001)(478600001)(316002)(4326008)(186003)(6506007)(6512007)(41300700001)(6916009)(8936002)(5660300002)(26005)(6486002)(54906003)(66476007)(66556008)(8676002)(6666004)(36916002)(38100700002)(2906002)(4744005)(83380400001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rIx1F56x1MK7exxxcJctUUfikGgnX0xhcwgJ2tbwMRK/fznfPhXmLxr02+mZ?=
 =?us-ascii?Q?yNE92N+bEMJdiD64/Nfvkk8t0hrBHkfmz/44Hj767Ovzl+BuauOwO6+Ofr52?=
 =?us-ascii?Q?mIwHRWLFK0D2KhoCoILueJXH5V3djLGPmsV/YWB9bCC1Fr8zjIu927z5myF9?=
 =?us-ascii?Q?dvTL+8difxvVQg4nvGvogFedH9sQweWVJS4wvS1NwdhGYe8E6uwK4waL85UC?=
 =?us-ascii?Q?5unpUfdUY8LAuOGK+NNWDArD8eTzAZ5SLwyh3IZUQe8qzx+XRzp9SHpJDV1L?=
 =?us-ascii?Q?DqrmY9xZg6rFVklH/tJUCjgsoHA65ZSghxHFyiPrBbqTEAVEF0qomo6aPdJg?=
 =?us-ascii?Q?BzX9b1brRYKP9h4Au4NerEfhmU2wrk2AnBjkYjFp4HpuFzGEY8Bf+1thjR4f?=
 =?us-ascii?Q?3vwZqBzzhwIBLi17tZYY3JP2u/Ck1OfnBAAIimNY8v80dp9oXU43sR4f2QbC?=
 =?us-ascii?Q?P6dSr12BKWMAm7mXLomuD5ykrtOTLw0iskHcBZzS3lTC9TSqRsnEidEhBN2s?=
 =?us-ascii?Q?xq2cPh/FPRwqPYiC0r074BVyF/eQ6NE8vb3alSDJSUfGErDg2ejd0vvm4J+X?=
 =?us-ascii?Q?/UrPHisrHto1F9nf5evSTWpcSeDCuoHxhY9o1EYDs+Ri3frOEtiQ5yj1elmE?=
 =?us-ascii?Q?Nv4OSegA+M4mlfrVtHBOZ+aDQaYK1h2EDBSQx+aa2PxY1WkQkBNXoMbvoILG?=
 =?us-ascii?Q?SbTyxaYWyw5i/PLv7EGf7aHHszk+G0i7VmVuwah0s8Urw/BI0tA/HSX31SGh?=
 =?us-ascii?Q?F8ofCqSZejkC36SJhpDPSChJCpfz93AivwG+DpWHFMD9b4XORoJSDDdoVf1m?=
 =?us-ascii?Q?pOx22CPa6o2dd7npAYoM+FD0W0W7fBU7IH3FLl8D28yiHChVQtmIvuBn38kg?=
 =?us-ascii?Q?Ep9TqFNkphxkmlwrrNUEkkPXsBccJ96lvw+g09iRtu3lXBISUSnZI6kO+xDn?=
 =?us-ascii?Q?p1cdLKpryU58CBSYqU0tm21aCSmiib3M0iUNfzs4ubgpvunRIgfkNfwQa8AJ?=
 =?us-ascii?Q?2U+e01PC0wsXqtRFYplLYv1D/66kjWI9jed325kaEGuxSSWzoRzBHyPh4N31?=
 =?us-ascii?Q?4Y3qylfb/+6WPkTqyZUgB+fLa7MDI5BnLjGnpkPByVgSvK5/x4MtRMl+Whvn?=
 =?us-ascii?Q?u7keWET+16MXejOEfOfSQWj0wXCfiFF0vDsyIcJfz8iG8RWNRS6M06nudlb+?=
 =?us-ascii?Q?sUvuU5RC/QUoDuyDz4HDF46iGHcS8O8BwFH9DoY+sIv0t73WIi3s5fixI9ph?=
 =?us-ascii?Q?GuCSGirMAi6+06rhsfF4Lo3z6DxX/9gyv0VPhZtX6qDLa1cpIdmLecS348SX?=
 =?us-ascii?Q?sloeMOpz+K6i7eOwqyhf26XilV6QLpFCYYtJOgsfZy+QNq+CL8Miw+tJVSEp?=
 =?us-ascii?Q?H8NncUxRwAlwpvgkU41H2bOZwoySfQzpLmp/4Fl6BZJg7req8OARP5cfdtRV?=
 =?us-ascii?Q?2YtwaOAXzbDDelw0mIka5j2nyVmpvUrdOdkSmKkdkSXPX8L9n8G1d7eoBBdP?=
 =?us-ascii?Q?m/r8ZORVQr0aQSdDJ4aU+vx+12H4tkJgx+ms8WscULl7SS4xEhSrk0e/M8f4?=
 =?us-ascii?Q?Cm12bD56ok2//xZkQN+p9lyuYzjCch4dzZTMKdkaIffzeLvY+jBUhPrFrE7X?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5W9L3RW3t6VtvOVc4Rz5xmz9gk8DpNIUV4cqxzTFkU5gU54eivlB17DI7wO/xo+u/ipxUBICfwm00MtPa2gNWBTNxZLP/1R0n+sKFL6Bf6w5gA6bDUhXavhjuA3EJ6ViSieKfND8iMiWmeJIYtX5fyPJShjtrWpk8eqHG9Ogm1Za+WM5NDwLuc6unpTY58/jnjn+rgAEVlM36qvQcWuoMW6SbdiJqlx9L/PXbGx/+IHdvCfwJ4BbBb5WfHDFHIYV0kaNJl9UooahXsD9isPBaoaeyXUbz3KLSG/ji85WHC7nUVBlnzteIEXDK75KdICrYHG8Dz1RW4mZI4Zo5Tsdg/t1NrRHfeomiPHDjHLVb3rbHUDn/VO8ynDD222vsMf2JnpjzBgJRCErnqdbZzUxeff4soMVQCBE5Z4f8w/CdLuFBJLVhv894v0BQPPurCEVAqUg7n6E1mW47837CvXkgr5ogm+uB4xxTOZ7PQ1EwNsQnmImr3WW2bxnb2x9EGDP40zYbB6hx6ZOLXVOdnkg8zdYBwHdrgKQ3acsG/zGyPWq4ucbQDztCAEXcdt5zKKapRvt1JK2qJrYVMFW1e9dVbIepNjj4EYiv2WIAIEziPlnynV9/KINvV8GjawfO4cG7U7cRD0zw174S/0rkqWlj+rJQpHuAi0BbZAho8Mh63TYGwaX7aEVqBMkAfllSxu9+X8UfcW/AaJwxG4Wd6XrxD8EtZaTY11h+78pikUP709capvtOdAdyiSocq0ltjWCiF87y/ySQc45jbur0ud50jx/hawhJaL6nJV72EwylXatyqPDa0oVO0VwWvpCRdFiHT1tL3ywOtJ3OtqT0xcLwA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f5363e-43fd-44d8-8b55-08db2699e606
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 03:44:23.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkFEc6U6QSAae4wtCUBgMNph30bhSfj5zgmK7UhFC9/JV4Lu5a4+DBh5/LsP2QjHMfh63AQmQ69083DJFYH0H+jcporE9sloAefjNwFUeqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_16,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=970 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303170020
X-Proofpoint-ORIG-GUID: rSXnRd9YDcH0LT0Jj0xyyMJAZ4tJxa7U
X-Proofpoint-GUID: rSXnRd9YDcH0LT0Jj0xyyMJAZ4tJxa7U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob,

> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
