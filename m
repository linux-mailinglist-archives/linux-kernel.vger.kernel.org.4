Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C846DE8BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 03:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDLBQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 21:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDLBQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 21:16:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B93A82;
        Tue, 11 Apr 2023 18:16:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BLIwVs019697;
        Wed, 12 Apr 2023 01:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-03-30;
 bh=CC21UGQG17j7hotnjbcpmZoWehurUuBhc53UfjnbtfI=;
 b=05eUY+7lnWX6MZle64JYJuID0DF8va99/BM8Acxz41I4MHGCw6nDd9nZiDvGMuGuP5CY
 7JNpcSFdV2KyeciMytlCW5D0x7nNkcdFjWDffNCx+3e3pOwhky28tnhiArdYWvfz7LSM
 EQTrkX467CrKBO5qBdAAIr01S7bBK1hwIBwyjhydXyd/uhYn8IxmJHKovdKdp3u/u0bT
 ZyVUEs4L/CBWcZLhFICpJkHTq9mbwiRgFm5w2lkctTk249OUS/H/vnyqlvBijmtGU0RU
 NOgRuMZa46RydIZmRi78vYPD5NRC6J25jLKkYTtzeXaCDQDJsyQoHfP8n2+2vqCXYsr1 Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0b2xvde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:16:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNqHgm009851;
        Wed, 12 Apr 2023 01:16:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw87tfhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 01:16:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAiU8KF/StqGU/jxewB+R/2TBIGwiljHflyg/iM8RFrU/qu8JRL4H81a0O1y1bz77a2aFD0Jo7/yUjZ3AXQ/919uvyRP2sx/ahTsxU2rHyuUMI6eChaVbkMQ648MraXbg9wI1+nB8LWmcqG3o+gOeTkAFvFPJIsnFQ5j23kPZGsve/2EoOuulu7GZld19kz+CCULDsJMuW1D47G1mFf/c/B8UTzba2RNP9WfYf+mXhTHGN6DUqqx+KAJKmc0R69dyVeSGA116CHaX51vyU6kOaBF2rFyd6q0jGGUkXgTwvMnyMgTpeTP+6nLCZQTZ7HlQQEE0etve6wKVnkPGvfodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC21UGQG17j7hotnjbcpmZoWehurUuBhc53UfjnbtfI=;
 b=G4EO6u9RiO7IhPQan2LuJxiiHNe7kOr1jiaqJm3DqAHnCm5TdI0WyvaQ3h/biSXBuxYEGPBHd0UgXooLbIgjauxZt1fRfYrU7j1zKpQ0vJcNyY6Pm4WlzOIyZxIe0nV5ULP9w6jwubsA40N0qmVCjemNkbolADcmMLZzX2HmY6rM644oc3cGbCx9H/zrNeNc5nBG4HTJZLflf6y6tpWv6z9l75PhtUYXnzSy2oA48f4is9m9NYilue3PMVUegtr1UOLMgbwGmW3YeVXYT2r8DAjYJ0LIJ4YFo30mb4ywAkFeOKfHfxgondJkCZCTQPA885ZP005Z8dPX2ZVxEjYezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC21UGQG17j7hotnjbcpmZoWehurUuBhc53UfjnbtfI=;
 b=iyDtyIwXr6DW8e26G2019JMyW8PDafviJXjsODEaMmqNKd/dGUTSPkhWGErfbmUU3PhgEmervomeyc1bLiAl9C9OWXeDa+nJ0lRSGphgfdpSh4jys4jn1lWN0vvo2/mo/F34tHDwx6YwzkxhwwvgyTIQoXFrxXS9NHlfWwK+z/c=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6396.namprd10.prod.outlook.com (2603:10b6:303:1e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 01:16:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 01:15:59 +0000
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] scsi: scsi_debug: Fix missing error code in
 scsi_debug_init()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20230406074607.3637097-1-harshit.m.mogalapalli@oracle.com>
        (Harshit Mogalapalli's message of "Thu, 6 Apr 2023 00:46:07 -0700")
Organization: Oracle Corporation
Message-ID: <yq1a5zdoq93.fsf@ca-mkp.ca.oracle.com>
References: <20230406074607.3637097-1-harshit.m.mogalapalli@oracle.com>
Date:   Tue, 11 Apr 2023 21:15:55 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: af025cf6-f105-4b58-bc9d-08db3af37958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKKnQJBtHmDRRhF6xWrZp4ho626e+l7uuAyWL8u5UPNEHrf4ey7aBLaryYYeLfdLh8b6VtWgv7Uf53fNRLAbawsD/YXLg0BcBto2yp7HGrVDebHOy8/Qc5fJxJ+/KB5MMdelbkssx4xse2O7XBDp0k4+OdseSDTZZQsmQilYcxs+PRZIqpuBYr+JCWRnCZGcaHWXw5gNtaQojv58FDNZ6eBFM6WQqVh1lZE+h2gYJWJ/e9UWh4j+6LebuHf64B4we8OEWS55S+4ceapQkuHcGvWF/o7TFgjYM4XA1S1odfcrlii+cEvWvk6q6RYomAJvU+Q02qhkCZOkKGqoqIcp1oG9a5BJ+yGLofSTSC/it2rd0+a2QPNwkA7N68iF+vtd2Tq6UlrE4yc84T+coSOdgIgzkxoCLYyHJ49ijbcphyxJKzrANs/RyFPglAvVqtkQpURN/mL7znqJeHukqYkMp9r0RO/rCHlQbXe8UAMIwkDG+9vPOqK0UlqhOZPLpNLExznoIfKYjhQYhkuc8okEqejMvRD9S7oPFHjTwmLSsCfYzW3tWeWmiGszsV2NIY7O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(36916002)(186003)(4326008)(8676002)(41300700001)(6486002)(6666004)(6512007)(6506007)(26005)(478600001)(558084003)(54906003)(86362001)(316002)(6636002)(8936002)(66946007)(6862004)(5660300002)(38100700002)(66556008)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wTWYbB87yBv9iE6Pzqh2RJ5FTOvElYefw77xJP/V0SOTXRkS89S00w0gHy6W?=
 =?us-ascii?Q?SSFrEAupPAV09DDUZI2R97cjktIXydtXN8t+fBCF6VXWZYmcSw4VraN+kFiQ?=
 =?us-ascii?Q?5dowHDzuBjKWk/k9eEgUDoNFc44j+mMv4bV7mKekfmJ1s825gLkZ2SsDQzdH?=
 =?us-ascii?Q?pSl1OTn0QDHO5xJiw7UH8TDiYY5UlY8uWMsd3jARYaFV4+8lsDq3ocAP+O2I?=
 =?us-ascii?Q?mU0Ce6b3OTrVn1WIH1ifzlSNKHIP0ReRTZoaAkXNCr8JrwsDy5V4rjE1voUh?=
 =?us-ascii?Q?N4yw4htbE6hdnAaGk9gwOv11eh57hlCkLx1eNuLRowqbVPWTp0CB/yMx2zAa?=
 =?us-ascii?Q?/KF6gAnRcaOe3TApgBix4IrWYD+0Q4wIVOb6qdgrZ3KrizoQNDi8jDSSLKOM?=
 =?us-ascii?Q?n+1PHPVCPdwT7fbFYqASVqtXkZo92+iRtnrFMzC1Y8FMPzUJGpCJWwLlOk94?=
 =?us-ascii?Q?pD0l/pypMLn+n97CxQGtZlSsYcinIQ4AqEOvPlgrqXYtSn8EBNlsvGX4ZLrv?=
 =?us-ascii?Q?qjS3Yc/WoC3acY4O5iZoJKyuTESw5Qk3lKSnt5LVHh+gZnvzCTuA7FzPEbNE?=
 =?us-ascii?Q?4BkTA0Wl+2R6zWER0xpSPUqSASlasDzV+WnDbsNz4viKJVFZb1zsEeoaecHP?=
 =?us-ascii?Q?q7MlSNL9mnJGGRddZvIRHMRV6T2trJUbXqVrHJBnmryZZBxJQnMJPEvCYaZ0?=
 =?us-ascii?Q?JfTkgJwZ4FAOTTs5eO1MLTIJWmUDkdiz+WMs158HpzJAUbc2uTKXPhv46ylR?=
 =?us-ascii?Q?TLGC0htMkzDg3eKrkW1s+jHfKU9VCb1WsGSrM6FkAt1xN0JLTinMoakziKWH?=
 =?us-ascii?Q?zzB4ciKtCypIBVLY+tHr1Q0GOcHaaxOGcRyGSunAMst495rSS0xEFOZCQ3VR?=
 =?us-ascii?Q?2Pr7gGc1keq56M3bhM8TGWM+iTp9+E99S3BLUcN/OFi/+Yxia9Zmy8XYew81?=
 =?us-ascii?Q?/vrV6sG4v/97U5GkRrCT+UR4gK5qg1MXdS2N099hhVGCZNCHC7ZKxI7p2mf0?=
 =?us-ascii?Q?V3tlTyVq+SePU9n6k6/pIp6Pn0bNqiyL2iNVVozR2fJn5Okqi9P1aSju7WKd?=
 =?us-ascii?Q?4/NE1i3eSW8m0IZbfx2y0lG/DKd1lmlUB4lKoINxAXgBRGrLWJZoIMZiKZN+?=
 =?us-ascii?Q?uNZoPy5ERkLcQyyaW5M3mqVE0+HeKHjNBPXAbFea7kXNVVk04ZjDt4SgwT1J?=
 =?us-ascii?Q?YstVnfUt7Y4XlvcgaBG365nj/6tScCxEoloVzqko9XMBeLnoTrHaMrwXnO7r?=
 =?us-ascii?Q?KpawA72VSnZbEdHsGXAE5fRW5Sw6mZZXZ1KkDmzcZS08Hvb6fzItBmEmEzZV?=
 =?us-ascii?Q?KhZn1zMvbJh7Dg0AI2PiGuYcvUuw1b6LXl20TOEz16PVgiljGQU2aWsfVY8a?=
 =?us-ascii?Q?dtDH2AUFXvZcVd44ncf9wFWO1+8G9cfsvo0zcHZXGjXy0x2BxnQ5Au/xDRCs?=
 =?us-ascii?Q?8vEx6+yZEn7LLQauPveBBXJKUYwn9PSwc4Td5kOenj4tRDFn5Txe9BrGTpA8?=
 =?us-ascii?Q?UYeqVa4d6qS65nqh5sQ9XLwY05eBX+IGrLwLJ0JNdRDHrVrpG0IObpp107/0?=
 =?us-ascii?Q?qu5Eque6ddVE6dYpAdUT5qPg3CyiX1f3vOhQS5p5ZFrashp3HDFKrL4Xeq+Z?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lrHG5/y3qzxUn9AY3ZWg3pX+NIBvkmizCfyaXKi1pQcBvCOkuIHB1Y0ey1f7dhrxo8P7jXrPvrFI2zebY+Xg4sS+HMQ4QQ6Wh+zweXOs8ere/cPBwXcxEysewzqGvoDY1pqPCcNU25kxOxoucqAcLARIYoHAdJT7eCRFSswr6yQrPylU3JCcKBUqoXx8QHM4cYHcqIFvJkvDqm/sLGI+diOQeW4JXbFdJCW1qghlFq5kjpw/6KqHRdbWFRkLC4e2XK0fPb0mUFrIuUEBNBLEao6kO8P2NeEuviYIadAvG6N3HPuU/a7jnZ2+msFUtvxz9bq80SCkthpnxcIyo6h999B4KhHR6wRSMXu2KKoH5Rf5kycF1YpAlUGGxIbYKVWfu0JOlDPU0UquE4/PfPO9ykwCAybyiDc31FkQnjUKD9NQgvNYChmXvSEUcPvBMB16zt9ZfwpPzFAtPOm96ujC0KE8MEu/86FPBFfOEVARe9HxUr8gKzM5wr9soocJpdIztS57DIWHDAilDBjq4O1xkiVXdOhzYiREQ8XwDg38IfMAT3cge0dt2/c32fzln5ZdwbYBfB4EQB4RMrFFeYkVkL15/qcSSnNnIMPuwcMBELKy6qKGbdtn/Q5X2gkwP+5g7aKCEc23x8cmP3jO33Jb5zkQqk8+j/TYxRh5164fAy6zq/ayhJzBFez8gOUsOXWJo8SRVpOqxQbsElXFd/fdo8ZK5bm9Wvo3HCx2qZLC5LXq4XWzwepGI9Q1ePFHrwggiN+j9piiy5Kz64ZGKJtWMVeV+IgcoGATaa+7DVssZH8Hc0TdYdXh/doEPa7IQTtO8IUo0bbW+dyNPhBg0FGPgg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af025cf6-f105-4b58-bc9d-08db3af37958
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:15:59.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWrXAKCB0g66Qd9kVxM2IJjQJ1AgWikAuH3NzQWOhYdW+ZX9VNZDHZzFKJ3iez+o6AA466b+kfUJbP++2kuUMogPXxLvDl/PZDeqjfSU8qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=895
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120009
X-Proofpoint-GUID: YCCAJs5PKNk-0VBJKRHQIWqEqgruOfA3
X-Proofpoint-ORIG-GUID: YCCAJs5PKNk-0VBJKRHQIWqEqgruOfA3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Harshit,

> Smatch reports: drivers/scsi/scsi_debug.c:6996
> 	scsi_debug_init() warn: missing error code 'ret'

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
