Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5366C9C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjC0Hn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjC0Hnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:43:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB61FCB;
        Mon, 27 Mar 2023 00:43:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7Z4Yw021839;
        Mon, 27 Mar 2023 07:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=bYy/CN3hRhvz7ZLe3tT0l6OUd4yhW/dc7gOQ7vrqL6U=;
 b=dUpk4BhaMk6fji023fVodRHev/J1Eroj7UtHyIUgxOzufGfBrVtOlc6oIf3Pai1rkOkG
 I4Rr2kAJLV45ekr82OZHZ/z5fC2bu2pUESUjCa9Kc8cFRaOeOFaIZ8kHIYHiDpGfKaer
 uZi3NPYrNAibFqFavf0MlCB7xAXTo3GHjuqvrzQEO+Crg4sN3AXkdVJFK8hZufFBSS0y
 4r1zke9bWNEpbAqXrw0QGaqmNIhkDtZHRL9MCyXjG+9cIAN/xxe2JgeRwsV/ToW+SnbH
 xNeiJDzaIx3k1zvgKF+C/zpi+ulbXj+exDKKTsHYyku41yliNStXql04+1Tkdl45VpdD Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pk6vmr13c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32R70cQa027409;
        Mon, 27 Mar 2023 07:43:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdaw2r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 07:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E01aFkn48yBK8HSs2o6xDgnIAPHMonp5pRduMZ0c8brr7vKSMWGAjI+JO+IYjvcWIDF75iwAZiFpmNijVGXxHor8qHIFh6ImlMtVtdz+U66PlbVmdXa5ZjY6zEH6uRIKCCWZMMXG046jG7yJqm3JQBtf/Zry40kpPyQsaxbX9MFfVAlG7obeYQDFqT8pcOlOeJe66Z0sv0JynA6ns7nMs7G36AKpVa6Egqt1X5kPh3VF7eLjGvTSHTT3Nb/c/lJ9ZCZbvZTEVpaJvN40ifEpkuaFtyHmcbxssKIDmbjUjUk+ptbioFWQYeg2LVhx0kd52LD0beFNqWGku09O1u41wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYy/CN3hRhvz7ZLe3tT0l6OUd4yhW/dc7gOQ7vrqL6U=;
 b=PTk5IneS0+Yvu4jJENmY0YPKukfrrpYjBwWCqQA7F/tnZuFGE88FTJBJKwFGNnnoAocXVsMVk4acSyfSLPx0G6ejRRZTDBCP9N71kzzrwlyvZmFw4lgZN3QviJNKRfQkutCsWvKi7hsEiwWGpJO8mt0fubyoxWFQTOUzBitBjP0OtCf8nJtZ8bE5F8UyYpgoDwvZpHY4tKC8grzYZwOnCwKkL3hgW8cvbNaIS1eTWHrDdY6xsqPrPD2bCDnBGWLo7yXkmaDs3vQ52KmZZiCUeMXw2Yal2X1cpQq7PnDVHnp0e4F8HVYUzAmoof6AoW0yI8AaoBmbVb1N1chGmMErRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYy/CN3hRhvz7ZLe3tT0l6OUd4yhW/dc7gOQ7vrqL6U=;
 b=qJVNfUfKRrnASe4LOBAB7pfQuVb5P/C+kMA9Y4ZWqAnGzRT01fb8BP+sjTjKpqrSt3Cn3wOwcZhijsyQO49ceLB0IQjqaajRUgpjawpRLD9aawfWtQe/nyR+OW9PlPEcmzxYdjnTPm5KzKThD+K7kHhZISumWZy0EPubsfeno4c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:43:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 07:43:18 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 00/11] Fix shost command overloading issues
Date:   Mon, 27 Mar 2023 07:42:59 +0000
Message-Id: <20230327074310.1862889-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:5:74::43) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0945cc-cfc5-4cf7-267f-08db2e96ee6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIpaKL1L04kTC9H6Nnb4WAU7HXwu8iP2c4l2W3qVBYaY79jgW//p1kb/RR2RZfkGdtSCAjjYQBnAwEzRjvoeI7yFGMHG3NZBYyQ/LhRAXYceyWSwmug9jwTPyDgnuytJq79fUfB8EMoCt8eXi3tblYUc5CiqqOqq16ZQkoqicaqfb6w/uBa+rFXhQV0SVOEVwQXVDnyfZOeexD7HJPl8M/7v7Y8/cGJjnf5mfImKYVTVbJPYbbptMg1X3NujKqTAs2PBoY26t1WfIwKPf4h9L7GHAXfc+f8X4nynaQwhpcHxQt/1WDS7p1XGNK8ZoeS2rImWUqzlEnaqHOw3lOWaZSFCXW551R2fouMPrytYhI04Jwj0FW/OSWAQ20HGE9NofBy9adMzHUTi5nfUlMqkqBYKNuheghMSTbrs0S0lu9hy0G+CvOS6cKaJcJ/X2OSEDTTIfbAq+1vEmSzinWqZMJjjTgRoJWtadif8BilMc95KPPVEfJo6fXxjVfjBncXs7M+vhdOQrTe85R7NHVz/rC88YWynChX2LF/8d8PDCjRDjEBTeKA1/Gmrd91S4/Iw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(36756003)(478600001)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(41300700001)(103116003)(6512007)(38100700002)(2906002)(1076003)(8936002)(6506007)(5660300002)(83380400001)(26005)(6666004)(107886003)(2616005)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oj+twqUrpkYYTFliiZOr/CtFZtFsq0CCbsN8dsenkUC8WNnj2zBFsM7BBvYQ?=
 =?us-ascii?Q?htLXcQRCFNKxY35nnqswvLsLOZ2VFFpNTHip9JaTQEv/UiP1qdTWWCBUD/9z?=
 =?us-ascii?Q?/rzYqzjQVWFC5CzmiDgvYUqLBGTUgwE0Z8o0kpBnnKz/R3Z6Cz1X3uwZdnT/?=
 =?us-ascii?Q?TI4s7EHLrgw726aycmvMzrVu8vlbksVyCnC2xjIaZ+/II3IobVxdzCZt3IfO?=
 =?us-ascii?Q?Qek/hoIIgQYCchzIk4CIXC8SNOr+ZbeR76knz80YzVFTVeA6Yn7KkPSCLiPu?=
 =?us-ascii?Q?mxTn9guRxnYlfMzwZL7fYK1YMxw0dQZ6W/5IcjzMDFdP9X1+fFH7c130mAfN?=
 =?us-ascii?Q?d35mx7itldIFevgc1cPTUzS6nh44jvo/O+a1frDaHK8GU0iU+Jfs+sXWRDf2?=
 =?us-ascii?Q?IbMRE+4fhziq1vXmgzJeFBKqfRLw/DDAlo3yXU20yl679w0EOlNExqq4BTXu?=
 =?us-ascii?Q?KOPRCpc3UGQXJy9fNt4rD8gXnA33oVQImVzWmzDSfpgDjfoNVM6hlkyYXVEm?=
 =?us-ascii?Q?IfN6JjWFNxhUfU7BumJaMfSE9MICj4UgdmNKLzszgxBVkBH0sLsW70lcg1Dk?=
 =?us-ascii?Q?3dDBqFGEKniuQvdSaa8IQ/H/l3sHyfgt9RiEJm/3V3Ax0xTiOvFY4eVKdGcb?=
 =?us-ascii?Q?V8crlgHnYVzhqOK/PlH6r/n6StQOVUJUXDhQqHxxni77Zvnw5oh03G4fV0Qt?=
 =?us-ascii?Q?gTtJiQ8nEQvu7ErTAJyX77oR3yVZpGnzFajZZgr0RtzRcMcTDTPdyxwTRunA?=
 =?us-ascii?Q?D/5TD9t8atNsLjaDh95I7/8mKVLTPRh0CV/L2dsiZv+XWp8rzUB9MVzFV44V?=
 =?us-ascii?Q?0sGJEytcCcu0EAeGZjjkacNhgzc+ZkcOXni6jXQXQxbAvauCF3pTeZmtkBA9?=
 =?us-ascii?Q?7EUFH9mVWXsz2t1RpjYbVF2dE5ml/M0ItXoO34CSfk76ujGVUnJW47wLesSb?=
 =?us-ascii?Q?iQqJZ3JDqtuZNaRcNNz8ApXinPz8dvieWOIeaH7+9cXJ4gINF3Ptz6pSjeaC?=
 =?us-ascii?Q?QhgBLg8FUC2KtYrZw+eZWfSLiB67/EhIviLVa7ss1J7x5Eeqf+Six/Tezwnr?=
 =?us-ascii?Q?+hC7PCIjhqzTrsy3RlfomTr5pZpw2XvzoxIfz6rwOFSA/uZG2WJei22DO3eV?=
 =?us-ascii?Q?lu42hwcWWlph0N4KnDHVLQ57rfvGHLUXZrZBaK5QdfDMRl7BPCZxH+4hkcAI?=
 =?us-ascii?Q?8X4R2I/SOVVq5WY5ZCe1OZlcrU+pApGKBl7Bag9kusaQmSzbMI75nMdc6x+q?=
 =?us-ascii?Q?2RQxOUEtUF2fIgzCh0YlcjMD1dkdr5t27U1KGT6mgGLf3Rkm4ODJ0LHy3FP6?=
 =?us-ascii?Q?+PMW6l3HnfJ9pT/G8pLUcAD8NRKdRkmaUI98rccSsjZunAcqP0c/E90iWU49?=
 =?us-ascii?Q?7aB7O9c8naqPtKFu+pqh1es3X7yNBVK1WgV0RG+01wae6UjO/qJc+nRyF6oj?=
 =?us-ascii?Q?fG20Fraj5gKn6uv218Jt+zPY7VQr9T5d2h3oqziHmHFP+lRb6XrUaQNaFDm/?=
 =?us-ascii?Q?JlGfN8qkP4wZMOUiRXYlQwFNfE2TM9imLim+zfx1gU7175Kq9/wGBYnFspS2?=
 =?us-ascii?Q?r64lGXcxv3RyM7w8hHhUyfTsJUSq6ZTa+EQq7hT3DCgaAPLBP3uXm2Rz6J4Z?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /f6CkJdtRojCvwF91pNP1yKhdiaC9jQs2oJ4ukAhsxl8pYjr3NymntawG6nwXDhLI4tKqTZMr/iz+gLDPc+VsHig6U7aBiWCRbqqKifLcE72qBAmcswBfP9UG7GWfHY4nTqyIQdSySDddyl2DO4V8JNLQuKBjGcffkRtcxmNo0FvRnGeN7rqM6rslK0/EFlEl+PJFCJ3z38sE0ieIvN7y4Qp9d3DdBVl8ij5aai69PbC2HMk3hdWIY6b/LMjuWtsglI0niz3CZSlkBQrHqxzDN86i4/aokBI6xqcWliBW1yoUFIsui5DKXgOyCkEkdFw+ozO34f27quot9OMrw2XuIC9No59mEo0I+KwXYe7RpsD/Gu4tgasV4oJBSGXYccIDz7aONVRR6/XXYy0fvbYlDtrkp1dSpygALCaLXasfTRfFwuFtjYy5JUYBaC0DOAWspECRSIoU93rZoJzi5JNJH3FcsnmosNu/bIgEswuyylInUAfRER2He9l30h17+kgZMJWOkKQU1+59w05437YFXVcM0RtZh6hKV2Q1N+F3JpttNhYKPe8OBP76brgezZE/i5x32vlLGzS8b6Sy1EMDvAfmUgnDvs5e57VCMaRQmDS33VZeXrEkDoEciga6Bg2XcwMOsJRH/idqizXA9A9ty83n3ibcSBYpBLd3znCqsf/u7V/0iE+qtFFUAwx+Owk66qwFv8YO9jD8o9rVvsRhBdcoqbIE62lXfFh+T6bc5eoXXRmu0Y2TZr/K5ZrPUVLOwclW5jZ4oH3GnQMUeHd2VQeyVkr9JL2H+15g0S/kOQDYzZmvhc/F94xnXq14aaWoqYrwxrSLjR4gNuSzZ7CCoQcVbRMS7kRwjY2txHBVZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0945cc-cfc5-4cf7-267f-08db2e96ee6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:43:18.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xE2mhbsMYMhKJLlD9IkztTmFDG6UWCnrSFhBH+tT3eoCwKj6fvMkKYDgsVCIUg1ENBxEtEKaAxJhM6ucy2WxYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=992 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270062
X-Proofpoint-ORIG-GUID: jTUllu3xtGiLyQzCYjFfqL_qRutyWtsc
X-Proofpoint-GUID: jTUllu3xtGiLyQzCYjFfqL_qRutyWtsc
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easy to get scsi_debug to error on throughput testing when we have
multiple shosts:

$ lsscsi
[7:0:0:0]       disk    Linux   scsi_debug      0191
[0:0:0:0]       disk    Linux   scsi_debug      0191

$ fio --filename=/dev/sda --filename=/dev/sdb --direct=1 --rw=read
--bs=4k --iodepth=256 --runtime=60 --numjobs=40 --time_based --name=jpg
--eta-newline=1 --readonly --ioengine=io_uring --hipri --exitall_on_error
jpg: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=256
...
fio-3.28
Starting 40 processes
[   27.521809] hrtimer: interrupt took 33067 ns
[   27.904660] sd 7:0:0:0: [sdb] tag#171 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
[   27.904660] sd 0:0:0:0: [sda] tag#58 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s
fio: io_u error [   27.904667] sd 0:0:0:0: [sda] tag#58 CDB: Read(10) 28 00 00 00 27 00 00 01 18 00
on file /dev/sda[   27.904670] sd 0:0:0:0: [sda] tag#62 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK cmd_age=0s

The issue is related to how the driver manages submit queues and tags. A
single array of submit queues - sdebug_q_arr - with its own set of tags is
shared among all shosts. As such, for occasions when we have more than one
host it is possible to overload the submit queues and run out of tags.

Another separate issue that we may reduce the shost submit queue depth,
sdebug_max_queue, dynamically causing the shost to be overloaded. How many
IOs which the shost may be sent is fixed at can_queue at init time, which
is the same initial value for sdebug_max_queue. So reducing
sdebug_max_queue means that the shost may be sent more IOs than it is
configured to handle, causing overloading.

This series removes the scsi_debug submit queue concept and uses
pre-existing APIs to manage and examine tags, like scsi_block_requests()
and blk_mq_tagset_busy_iter(). Using standard APIs makes the driver more
maintainable and extensible in future.

A restriction is also added to allow sdebug_max_queue only be modified
when no shosts are present, i.e. we need to remove shosts, modify
sdebug_max_queue, and then re-add the shosts. 

Difference to v2:
- Make sdebug_alloc_queued_cmd() static

Differences to v1:
- Add patch to fix sdev queue full test
- Add restriction to allow sdebug_max_queue only be modified for no shosts

John Garry (11):
  scsi: scsi_debug: Fix check for sdev queue full
  scsi: scsi_debug: Don't iter all shosts in
    clear_luns_changed_on_target()
  scsi: scsi_debug: Change shost list lock to a mutex
  scsi: scsi_debug: Protect block_unblock_all_queues() with mutex
  scsi: scsi_debug: Use scsi_block_requests() to block queues
  scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
  scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in
    sdebug_blk_mq_poll()
  scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in stop_all_queued()
  scsi: scsi_debug: Use scsi_host_busy() in delay_store() and
    ndelay_store()
  scsi: scsi_debug: Only allow sdebug_max_queue be modified when no
    shosts
  scsi: scsi_debug: Drop sdebug_queue

 drivers/scsi/scsi_debug.c | 783 ++++++++++++++++++--------------------
 1 file changed, 361 insertions(+), 422 deletions(-)

-- 
2.35.3

