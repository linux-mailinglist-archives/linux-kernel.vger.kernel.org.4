Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1A66B756B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCMLLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCMLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:11:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2045D775;
        Mon, 13 Mar 2023 04:10:56 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CMlCRJ009856;
        Mon, 13 Mar 2023 11:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=38wPzIDHvQoWGDPn3lnBXoJLXweg/HBV0/4Ju9xfAlk=;
 b=zpoa1F5l/H/BnKr6QEOhNH9ORwm4paLCX5iSm8kAKj6d+jjXR2cQm4wmqFkC+iaPhKs6
 4kwMuw+OHTx1MSPMrjwTFIaZysDCtqUdJuOgQ6a82jY65NIIHED75+nlXebHDgbgrQtO
 uvsu8ZCRZI6JT0q5vGZGTrMc+HderNwsScsvClY+v+zI0926fYdUBP16mD+Smoxh+G80
 rXnTfJidN/OGDM7MEi4EGku421xvbmTJbySoCIH13DKZQaUAQzYT9zjM/ikXb5TNyzZN
 zp64Rf2cXuTRhdp4iDCFiZnw8HtvKhVaPz802QvSo7di8Czi8aRuq+Mk9HLRT8P2sYUv ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8gjbbkfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32DA5Xnk002375;
        Mon, 13 Mar 2023 11:10:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g3b0k85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 11:10:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itOk69uicYxunsIqNPq0ydUZwbePcOOOMSVkOXzM6jCR+Oxq/jwKaNd2adaVZeJvVYprC2U1BOZc6myGQe72Ecph258yDPIo4kn+xk1WCt32c0NRz8oxjp2Npjek95w0h51Zmhw2LWZDGmCeRKE/ox+3grgbBx45RmCX3t7xvpHfDO/RdzwrQ3ULkDBt4pnFpUEv9fwJUGCfPiZ4lB+W2cM0t7k8WHYEMTec4ValUTZkSgIr8mm443FRdd6pcetl/ErSq42eY2NZ3NZf6OhsNpWhDMwCcXlc0XEH+mk/2Cn1yZcr1iebjxUaV36lkn/nwv3SuMJhP1wVeHUpNBYhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38wPzIDHvQoWGDPn3lnBXoJLXweg/HBV0/4Ju9xfAlk=;
 b=mh/CsRVj270eBAtDxcqeD0N311nZSUR/EW7PNUUYq+q0dGWccMMRizwVqEK+xlPvTZpD4kTDMWWs63rq+woaiS4XqktZMQVnuQUiROT+nOMoks7Ppw3uS+SSI9eoXuLs2XeZESBaBhjyvRBNfntlf6zLkZ81io5NuTlJbSpUyovFoxkvU74zxvsT+RnTqp6nKeJZFhZRSPkhmEHqZgDR5kXHAXTqeLGCqu94IiU4Wi/pfUF2siNoUFiAdQvURRl9QDV15yT3YeLdyQ+7LGS+eZrTvhABMtNYxs2Io9XqeDuriSd9auiFYjgspJDr4nQR5vwvcchkgX4aPprFR73usA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38wPzIDHvQoWGDPn3lnBXoJLXweg/HBV0/4Ju9xfAlk=;
 b=yvepCQCjYWxEANCGzAn6h5JBf6zrh69iraGPcNfuFSgzQNLMWWwedImEKiBgDgsdgnyx5XIedZkJ/tJQy+C8wKkuAjsSEfEghMqoUzr4GuRUJJNUjWtFrz6VYEXuulCeZVnPU/pAlK3RS+Q/4mIwtd9J/oZFQlZRVMMXxdtz9wA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7672.namprd10.prod.outlook.com (2603:10b6:a03:53e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 11:10:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 11:10:39 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        dgilbert@interlog.com, hare@suse.com, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/9] scsi_debug: Fix shost command overloading issue
Date:   Mon, 13 Mar 2023 11:10:10 +0000
Message-Id: <20230313111019.1521680-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0078.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ebd2a3-b88e-4b32-b526-08db23b393eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RY6ljq+EGqUo7KobbecUDeI0M/nNhBKvREht4HX/odVnOgcyL7hhiLGcOlO4KwNQ7GiAx3MgEaMMv6LMvVbbRJKDetGJaBTgYvJ07n2P7FyLuuvYpqTOki5Hkfox7Tz9ZmQn2141aZfJPdmeCz2AJMeltx3YDVjEqYtStwkrHKBlUN5443ygIu9MRBWGcXppiuCYE7uonEPccKgVezIIdaPmSM2KP23MWA+mxLwZ1IrrrfLDxwigC8JmOS/fLsPffbd2UF7ZKz+1j8CgWz3BXhzsKiikLIv9M2Alws0JJnSj1l9VTi0/2VyLAz2NdkVfr5uHoj9cyYQwRz+2swB2ZuBT7UbAJUFBNlFQ8YAnGEunz4LHLHe08fcALRVeetcf+O2V0eo03IfadI0FDeY7+wXg+dgjmorpS9e4rdzMS2u00B2rgKNPkSY8VlvK26hOGvC5EB8Q6S1Z910GFzRgHPEd3/iVgZJukaTB3q5pFmJA59/9f76zpa1ORigbeSS60g57CmQfgtbvF+xNCbeIauT9Zt1t4HQYwGO/j9g0cBqH6PyRurp8qnc4VeaTEC+1GS9ocnwwCXW9vGtK7zpDy0thKPV/zPEdF5MBvZ/BqYePS1QYYLZj48RkWfO0pO3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(8936002)(5660300002)(41300700001)(6666004)(107886003)(6512007)(6506007)(26005)(1076003)(186003)(2616005)(83380400001)(478600001)(966005)(6486002)(103116003)(86362001)(36756003)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W4yEUkZgD0APF+d2LRkvF/Eqzi4/hLE8ksY26IX8l6R+QC1A3hQz8Fx/3ILq?=
 =?us-ascii?Q?/KlaG2hUvdREL3w1NQMHC5nTMQFXv8kZwWYM0OtsEY7jyCPd3kOH0o1iqcGA?=
 =?us-ascii?Q?qQ4X13zWbMyFlUGYImsT+4INX4+8tTiDa4phV1o7R/Zp5K4spR3n+jblyrHI?=
 =?us-ascii?Q?ET/lI/0rg+IhHx3ElbqVubzvm0toR0vWriJZnfKhVZCJ0L8EgTmRSyGEHcGv?=
 =?us-ascii?Q?/3BoQxok3+DD/EKDtyitmOB5XVDTf/rUIpDDM72DuJSy3WnYi5FU75fSYt6N?=
 =?us-ascii?Q?KfpcLanaYtgvGEcZK6syVS8LAs0/a4ZgKwNpS93z29hH29ndSFsyLGO2tqWQ?=
 =?us-ascii?Q?B1evlcDeIib8rBBE9gO/b310Ua0UyMnrpjiqoYJyE8Z1gw8/vX5EhnSBPcGg?=
 =?us-ascii?Q?Gb9WWWVi2GlLAmfcwo4j7YmAjvu3Pq9FiX+BdsNjNBP8DsICmXO7+LwWL8cz?=
 =?us-ascii?Q?DEqpuRVZD3SMzYN5RbGuFHBHzzlNxQGkRlguJe/GsinZTh9mzSdqAfDSo9i6?=
 =?us-ascii?Q?0z9yS6K2PzxR8ZvUcVwBtxx7L6se5W2ZKcgGwjOpR2yZkBwiOzYnY5bEF3oD?=
 =?us-ascii?Q?4sG2cntHWEN9HMZAXPcVSr7sbzCHfXZWNDPRx9oZT3Ul9Ga2GQRWHc5ee/Hz?=
 =?us-ascii?Q?2j5uj9bapGDF4WQrFrzECUauU6HhtpIFq8zCU1zBq9Anf05LE1z4GRhCkZNv?=
 =?us-ascii?Q?IwTt2AhXPyPGbkdPk3HSYwUFn1nh/sJwMTYfcN1rcQde8GQTX7+dzk7z/D5f?=
 =?us-ascii?Q?TV7jZ1lE0QxFRERNNsttNIEn71A/+NTMMuNXjndtFTdrA7qUhLiEO/vO93fD?=
 =?us-ascii?Q?iTe/0ZOGFQsFC1/nYZm0lLgym3qAtCD7B/0ax+wxyskTyAN9X2tDEcGVscbT?=
 =?us-ascii?Q?L6qXV5p6AqsIxNnzgkDplGJj288MhxadqKI4Nu6tRHvhw3Y6THZBx0aHyANP?=
 =?us-ascii?Q?PS7X4DqpTegHdqGh8EAgaT7cAT46qj7DISMVBwPZtClBmgF5Gh2DhsSOR/8I?=
 =?us-ascii?Q?rRk6Jq7ss3ry64ERtvriYY//9UvGTlCW/0u8PbMWeWMWSF3kgiiEL+nEOv2x?=
 =?us-ascii?Q?lWpQ+4JJDdxeoWKy0FswddCh+qezb/r5PeBtIbD8qMs7S3m1yJXsH9LTuOPD?=
 =?us-ascii?Q?+F6B+615lHzCqjzrc2sPNBnGMvAlaxsUs0ValMtyCtZj9NTN1S1pCfyTtAxY?=
 =?us-ascii?Q?sVn3rMnly4Yzzt+WeOdJY3Q7lcr/tA58uoYtmHm12fwEa25UjD+HQSdvHb/Z?=
 =?us-ascii?Q?+7rEPRKusH9LnrfuPPnwgzNW+PHa8hBm0HvO+LH0/IrfiI+/V4EPZy9U/+Xb?=
 =?us-ascii?Q?J4JM73VtCOWnidmObu605iMaGbX3dGuouRPYnV2oERk5b/ORqh3Wggm1NRPA?=
 =?us-ascii?Q?tiEZtbolsjLkSf6yC97EYp8+LZmxj6dIpchWWZWRqULT/N1U/30aS87Qeg84?=
 =?us-ascii?Q?BaBN2jgy8V4EwVr61sJSZrLTui8AKPKrGallpF2RRMxznxS0jTff2BxTRS6S?=
 =?us-ascii?Q?5fp+LLaT4DAKSBpzyJkgg4eOhg9QJlo+oTc9q4raZhmO4j9nM5AmJBtQylZI?=
 =?us-ascii?Q?g2LDXTwfcoFhP96stwjEz7b6L3AM2FT2dE4xZ3P0i97riZxBOpMDnUjlk6TH?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YMF9LLwlc8jcdBQaeka90TOCc0+zs51wb3scUY5Gn/aHFv2AHbuF8sFkkqhhYnwMyqYhlwMBHER3B7R5p+7z3Pwd7ESB14k6SBGfsaibco9rFQXPGd+/dL7QgO5c4Vq23BB+AUc+gENcOlhFbrHfeKVNYkXJFMcg/tQji20RcCM0OAfpOpju3iMQIvlHbq+fF1pD9YdQrco6WRD4jGjAo8yAoFmnZaa5EduHphp3Fgouf9wHzAz4zvKK1rI2oAM94W+J3daF4XV5iwp06vu3XV1DxNzA98NyH468eE2tGEJ+baUz3sX1v9S7hvyE/YE0LeuqypwlNuizAM3nprQa79wenkhp3i4qZprjkjS0oTd9U+JH0zwNrCXHDnoLAErrZZCnQooJ/7yft3mVdxrDyNAtvrIzoaHw/CXe1roz1cgR93tMOVzmGHlb5ilmyUn1KhcHrCrG0LXLh5fOdrRmY/RCERPaqTTHvy1+JEYtfJcuqffoKWhZBluK0cgbBwMznQlE3IpfDkGM2mrvzC8DoQtzRjTEjomIHHhyBVK6u4FCiEHnPwXj2urt1vzeGyphjqdnDPkVgwGN+v/wx9/ZwZ6wkDWxBODmSgFbO7V9/3mUwWeVM0kjXLVNh+h/Fq80hXBhGDjONgVrlRCZwqSubY1sZ1fxzsE+B/4kg7xVgaNCDaTLDeEtZLIfvQk77CRyxbbSNieNj5UGC7Nd9+AAotapA8dz3WuziYDh1Wx1ZuOLbD9quqEqCMCt9Oe6peDpjaHplyOi+eE/G6qAlABbW5eSZszLpTCqVosycQPxiUDbyoqyE/yWm7WbtUcqdruWvOdRbsEa1F85UhZUar50b16VYxhPakgF8wH425idILTuD/fI29y7aHHH6uPvRlgGWOY/xbVBCtclrAsnGk5+uV9DW3+u9lFl6P7vxU5v6kU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ebd2a3-b88e-4b32-b526-08db23b393eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 11:10:39.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0geDiv5P+Un8+cDnl1TUOEI+BB9AnSrsKAB23srUUO0y5p19FT4Mm7pb3NRmMuanaNdYjaqqKrSKlROT8KGZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_04,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303130091
X-Proofpoint-ORIG-GUID: FFGQePd7BSJ33cHfdPxB13TQbiIWG6mW
X-Proofpoint-GUID: FFGQePd7BSJ33cHfdPxB13TQbiIWG6mW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easy to get scsi_debug to error on throughput testing when we have
multiple hosts:

#lsscsi
[7:0:0:0]       disk    Linux   scsi_debug      0191
[0:0:0:0]       disk    Linux   scsi_debug      0191

# fio --filename=/dev/sda --filename=/dev/sdb --direct=1 --rw=read --bs=4k --iodepth=256 --runtime=60 --numjobs=40 --time_based --name=jpg --eta-newline=1 --readonly --ioengine=io_uring --hipri --exitall_on_error
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
shared among all hosts. As such, for occasions when we have more than one
host it is possible to overload the submit queues and run out of tags.
Running out of tags makes the driver error in the submission path. We could
change the driver error code in this scenario to request SCSI ml to
requeue, but that is not a proper fix.

A solution to solving this multi-host problem could be by making the submit
queues per host. A downside there is that we make the driver considerably
more complex again.

There is another separate issue that we may reduce the host submit queue
depth, sdebug_max_queue, dynamically causing the host to be overloaded.
How many IOs which the host may be sent is fixed at can_queue at init
time, which is the same initial value for sdebug_max_queue. So reducing
sdebug_max_queue means that the host may be sent more IOs than it is
configured to handle, causing overloading.

About submit queues, they are not really required in the driver at all.
blk-mq and the SCSI ml already manages tags for us, so that the LLD does
not have to. The submit queues hold per-IO deferred command info in
sdebug_defer, but this could be dynamically allocated and assigned on a
per-IO basis.

This series removes the scsi_debug submit queue concept and uses
pre-existing APIs to manage and examine tags, like scsi_block_requests()
and blk_mq_tagset_busy_iter(). Using standard APIs makes the driver more
maintainable and extensible in future.

The last patch is an RFC as the LLD should not be calling
sbitmap_queue_resize() for the host tags.

This series is based on my earlier series
https://lore.kernel.org/linux-scsi/20230313093114.1498305-1-john.g.garry@oracle.com/T/#m80f1de854ac590ce79c577e307ee2ba94a3534dd

John Garry (9):
  scsi: scsi_debug: Don't iter all hosts in
    clear_luns_changed_on_target()
  scsi: scsi_debug: Change host list lock to a mutex
  scsi: scsi_debug: Protect block_unblock_all_queues() with mutex
  scsi: scsi_debug: Use scsi_block_requests() to block queues
  scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd
  scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in
    sdebug_blk_mq_poll()
  scsi: scsi_debug: Use blk_mq_tagset_busy_iter() in stop_all_queued()
  scsi: scsi_debug: Use scsi_host_busy() in delay_store() and
    ndelay_store()
  scsi: scsi_debug: Drop sdebug_queue concept

 drivers/scsi/scsi_debug.c | 767 +++++++++++++++++---------------------
 1 file changed, 342 insertions(+), 425 deletions(-)

-- 
2.35.3

