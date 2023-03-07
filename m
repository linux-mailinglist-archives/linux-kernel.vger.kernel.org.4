Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84926AD53A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCGDER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCGDEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:04:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8620341B45;
        Mon,  6 Mar 2023 19:04:08 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Nx0jX003594;
        Tue, 7 Mar 2023 03:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=DbWBqQQomwX2fbitoBy5NfYFHEW8d2fQ+IN0nHJZJ3M=;
 b=wKNbCfkFfb9c1apLDHv2f57DxqZLfg8bPjaVH2DlaTQNifYS1AYS0Cs0L9e5lHkgmuyt
 ruEUo7360IdDytTsNYpBw4tKqxxkTLnuFAhSRqVm/p4hRuLhcibApgn2zBYYuH3Pa90m
 pt3xe4DEdwhvKhtd2dH6kAh6NrJ/cuzC2eKX3G4rRrKUAdlHIwSGbLz5MksTtO7g7tD6
 YxAlrRpag9ZHym8ouVri3/3YlScfhJucczgrxAgqw7aB3DDv8zHbMVVfcgsfwEyC+FEP
 2LvnYl9uVBJNj+QjEftiFkfwUNtYo3hMazYuz78HrvbLipVdBwPz0oGyTTS/9+4EFJzq EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417ccge5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 03:04:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3271xUhU011213;
        Tue, 7 Mar 2023 03:04:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2h5as8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 03:04:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O81Sn+YH++4HD7OlEGucZxdIwX6g5r32i2EqHcK0OtnFzEh3QPaXrDcNqLr+avOsxsi2pyIF5zAm/y5NVur/v8M+R/AqTu6XFUqlIHZ7qmajurlXoBQDZe4DtE9+cmsCi4HM1MFxrh6PpWMerCZKNoRKM5zQUsP7+miOu4xS5UBdtHO5AMiktWN9ioRDci8L+AK3vEzM/hZaMuBxL9lW5xAvkwrTwVv8BMglUIJXIrtRsw81zx4b0ZG1Y0Aox8Mf921LupMtGLBQYxP/ue6DFjAG0Xr626VfJ0l6LGFeW0GIimFQFiUKN9YBklTebKcLYc+HtWnBg0LQis0xozwlCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbWBqQQomwX2fbitoBy5NfYFHEW8d2fQ+IN0nHJZJ3M=;
 b=fL3UFQ/6aKRAgWwLsntPkHUOF9zJTF4fLuifLQB8V95qZ9oK9gbjbtjihUAkok8MburjEzHdZ8QjJ4nBQNn8tvZWfGnWfP+PkymD8jltZuYQveNR5vbokkGfQy8nGUDX6N51koPxSxdDNLfTrtSmyleh7GotsWfXW2XdoyA2aZcE7hkZOlqVZIl/wGSRzsb+Su4Mdx8WjZkvn6vGrHrJeIw4OLNZJzedJ+IMXir0/ohOkV2DzXttARfoQ7y//bJr7UntSNPvT9z5UGnxVHnoM1MtRUB2N6t2HFHBfDOgUzeozZPJXkKs8013VXyx3GD9p/Ke8ye+0NCkJKBle4bjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbWBqQQomwX2fbitoBy5NfYFHEW8d2fQ+IN0nHJZJ3M=;
 b=z4n6h3qj5IFYddqOTwYDVTYzVrT91Sk6piz/DHOsb9TrXEBIjzLq5ZZP2pRTGR/xUgh+XlToYOl++nkOKHQl33knK3EoU0dpD3PmIJZes7q/209NHxBnIMXBL3nQGDdOVQKtMqbkxucrsuWeC65oq5puaWJJCx6tLaq3aCgFRU4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 03:03:56 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 03:03:56 +0000
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: message: fusion: avoid flush_scheduled_work() usage
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilfdl0ts.fsf@ca-mkp.ca.oracle.com>
References: <0b9ebcfb-b647-1381-0653-b54528a64a86@I-love.SAKURA.ne.jp>
Date:   Mon, 06 Mar 2023 22:03:53 -0500
In-Reply-To: <0b9ebcfb-b647-1381-0653-b54528a64a86@I-love.SAKURA.ne.jp>
        (Tetsuo Handa's message of "Wed, 22 Feb 2023 00:02:46 +0900")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:8:2a::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eca9b65-9dd5-49de-4eab-08db1eb8972b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBRZp8bplejS/a3YWBnlHMdGaXPrnUXxqfNJPyy6SKblOYDNJyG2kTpW9p7XdHz8UW5odGbfCv1eJ7RIB4hAAXFtMUwcIUFj8nNJIeTswc4oih/piXe3m3ikqNgERvuADZUS03r5iVcQRoCBdAGkykQe8wYHnzoEjullLv+G6GjhJe4eHUG/LXkGv+Vgc/lUPwoKt1j6nq75zGJ44uDcFjjCyIvpYxfVcD0XDn3mVfWRyOV3SEjAxiCJQyuosmdUZf198ydnuJiYPjQgr93KPc4yng5tHKly5V/oCN+mbLa6/51wr0+ydiWqjz+OkAk5PFYeV0OAXzkqv5FbgMakxQxuxnkIlbSxyBDbJ+GUlynVNZZ6VvDyMiRzSVJT8sknQaDpJWZQgaxXbnX/ScCgPgNABYNSYsWniZ+qgftnPMn7ecHVtzWZ5FCmkO/7XCV/ui+GiDkTohstpAvllfCTiwA8eRGdGT5WB5Klc9IwELta/H0FMTWgOVda43vRZDQG7AD+YYZVcStWMgamawwnSxxO3RGzYQErA/2KLPLYyDLygBDlKNZolXJwNTTh1er9xODtgS0Jqup3L4cA/HBOOPfwJUpqnMXNkVfbRIwxiGpVtB6MiWEqYPiYUwv7iHqAEf902bmfLX3xDyzuass3/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199018)(26005)(6506007)(6512007)(6486002)(6666004)(86362001)(558084003)(38100700002)(186003)(41300700001)(66946007)(66556008)(66476007)(6916009)(8676002)(4326008)(2906002)(8936002)(5660300002)(478600001)(36916002)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?isk87lyPivHHWdM77LWnaszsr4T4d9dMoY/ni1XUMTMVJohNydpjd2wjKIkM?=
 =?us-ascii?Q?pvXE7q6U4xW+2ech9GHhn5jF7w43QOrweVVc+FYDm3RMJQv/abysu2vwcxfD?=
 =?us-ascii?Q?6nLzVkezULv4t2X/FjeOxr7hSZ2q8FydWsj7LFl6J1CEoO3OxdBs1KIBXUnU?=
 =?us-ascii?Q?3nGRefBSwWN4ugNnr5tmqcZEtURy+Z87YofAH1MvFytH5sW4LEjVlk5tKvv0?=
 =?us-ascii?Q?1I2bnQLgMxZSTstTB/4HdZr3kSqJb82SdXSCaH5cFGOFtISyOaMInejpEQHd?=
 =?us-ascii?Q?EC4Z596kV5chaaxYY7shWhJU6zgpaiWYm9EVxwlSQvoUypaWMhz1nDmkxfm6?=
 =?us-ascii?Q?f7ft6ZVevrsy97v9dfewzZaZ/0dmGk7xPyOh1XQ5VBjERpvPUkbWPUePbmQh?=
 =?us-ascii?Q?uNECr0zlRnNT6ItU/tobwXNfGCYUpgVxRR8LHEJm8hWLQ0yQMbPb2g/EeH0B?=
 =?us-ascii?Q?mNdlMOkja69BThbLKvzEcdYuZBCXOPsl8jvceZmVLTLSU5ajtv/61CH71Y8c?=
 =?us-ascii?Q?1tI5saQo9bE82UW3Un5/N+mjILmhoHaekP1rhTTMfvYXWqu5VslVq8EW0rys?=
 =?us-ascii?Q?bGttCMnvCyytyVrlHPc+ODcFk678iRuQE27LkZthPtkeOPZCXOmU6lD4/Z+w?=
 =?us-ascii?Q?MgMo2kUq4G3tOmBijehsEqKvWjZr5ekW5gsglmvdjqtx204FzGZfeZgCchfy?=
 =?us-ascii?Q?7rQEgsxizdoyCwZuLXqaXVT8eMWKVNzK1l/PANBhN/5Nf3vZoELdr+ddg8mf?=
 =?us-ascii?Q?MZVMZHdOTASMc4+Kv3RUh2FCq0IHDM4KEDG/k+2hNeu3lJWahcw9hskjVFBH?=
 =?us-ascii?Q?8H1hNI9HgOxIipRhwKUckMj5jF1ovFd/pY1F4dvlOHNdqWam2TfukeRVgAwU?=
 =?us-ascii?Q?/hfuvL79ySlDFhcG0/lgkkPVgjnD+yV7cQD+qNTMNcdg7WHpsZeq2vAUpzWm?=
 =?us-ascii?Q?jtEhx3GA+qofsM+mDSJOWkIkkTN8juxo0nCGqntcVUWjiB/PZg3VMzUhB4sk?=
 =?us-ascii?Q?qkkSoeirrIQ4zcfN5IqvSj/FJAt97AxiKT9M+BOonrsCQtoQeYMKvWwFgD7I?=
 =?us-ascii?Q?wzwxuXEvgz8CQHfSk1YdlGYtFyFvyqEX5NZVVBpdJQk0LUnXcFRsH5Boh+e4?=
 =?us-ascii?Q?lpjKQpb0Y+05ACDSCoezSv8J77C1c8cVWy2Oh1KtTUjljWjTSCSacd49M1rt?=
 =?us-ascii?Q?oOQGSLJZc1d573sfgr+Doiu+PTbKwqqdbFoBF00/3LolO27HinyjxL30JA7/?=
 =?us-ascii?Q?ZWci9kIh1i0qn0CNvbwbwzcM6mEkG9EkIygCd7sAgL2D+L6qhSHg050LiXg8?=
 =?us-ascii?Q?IzDCXbPhx5ZLUpOvBN3gXE75pAk1kzk/lxfrNTlopR3d7XMaMOpEsC2GiLLc?=
 =?us-ascii?Q?NkmWzQL9wQq+3NWpeZGi56enWmspCKB8K3J4oNrCchidsgH1IWXl+TN6Agar?=
 =?us-ascii?Q?SZD/W65ZD0QcUUJZjf05j5mZwjxQ/qHyjqFkd2+FD7aFASnjFFhnUgSUallk?=
 =?us-ascii?Q?LmNcKlau5SvzTJM1k0J3yhl5Wfkss4o9nTQxeVWQ9qot2iCzH74Z4sKPT//s?=
 =?us-ascii?Q?zYgrSyi07b3SGXFzmDnbke/tJdpF5SvTqv7OWIxQ1q5c+ZSAuFH+pDH3qSZw?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eAKHrQy0JKKksS2N34IX1QscH2yF0dhSb+EiIgbhp84RGjY+2NoZERSyFpqiVHTl0xGQJ5iXVMrorB64SgOaNxg2E/zP0NSMjFTCMqcCym18Lc6LS/XiPQ0jYbGOXdQv6GyqtSc9q05XYxqx0FYO4WqyN4wr31V9vvA39yKRWywPFbc1xGW7ycPt+1VqRP8LzpmX1efJIhGmqlT6AmHwr6nUQoJdTT0uIkj7SB+9zz8a789fR6EZPYy1bAsZ70gIxECanCIkBlCVFs/DvZEBvtmkbosris/swj/q6m8yxs3oXlqYDjeYnuCGF7BV6KkFV7Cjg7W9nO/9QlW73l3gTeJeNymTzjHzPcVThQARUhNqYRDCaK1kcXwNeSECJmblqBQ3oeeSBhYJSdMYvv+hbPPM/X/qgcOUBYCZIsGHNkC93XrpjJp7tuijzVQM1AZxMkLCBUiolsQ5oT2Jlx9KO8y3WFMmKrZNZaDeUeJ1jMkrNoGgyPc+puZX1lHWBz/+U7Fc0j2dr47v8h8GcqluTCaIwsx60eMUF7K9zJn33S7qxI0KnUWZqh4TuYCfbaXJIAZSsRz9xTPcidJdq+0DrPzXZ2UysDgWoQPvasAJZABMXkX8b3WlG6cKMKHKssQStwPKfZOLVmnI5/JarccadMmMCjquO+GeLJwWZVsMilG3LpMTWjCDDJcV3jXqkJbyuhQW3hcHOKHfC5LAepnkY4oIg4/zMZpwF5cbCvTQCsPZ1E1GxmfvzPdiSnObwPFiaGiPc1fDskiq+ylvJJ1WLs3sDeV715RVQhmoSu4PxUgYdM2XIHiR2wknPqIQ9ylcZOlMv6lTwNTt+NkzKLk2rGNRR5T9lSkQx6wmhnw2w14=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eca9b65-9dd5-49de-4eab-08db1eb8972b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 03:03:56.3944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c69KnG5oQjrPWgKf1YfdmdIJOauWNrqR/OInb4ONoPKsHPu0qGm8hWvGRG1ziPhfrDntCzhSTL1T1Zmsh3Oe45NG7wlyaWEBfyfxX21gtwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=917 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070026
X-Proofpoint-GUID: _RbHmQQ9Vr1CYuKbFdoneKm-Z_bdK5Co
X-Proofpoint-ORIG-GUID: _RbHmQQ9Vr1CYuKbFdoneKm-Z_bdK5Co
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tetsuo,

> Like commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using a
> macro") says, flush_scheduled_work() is dangerous and will be forbidden.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
