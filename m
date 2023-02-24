Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07436A1E37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjBXPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:11:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7828A6ADF2;
        Fri, 24 Feb 2023 07:11:23 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoA0Q008490;
        Fri, 24 Feb 2023 15:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=a34cf8zc8KvQlsJyGSt/TDVPV+RaXCR7xP4oOnFyk/0=;
 b=Xos8VQkXbGioAVlagwmrefBBFfMl413+pfhGfCdCnEvPD0v+beRtNv73q4APVCHntgEs
 9nDEnpONvWuVuaWGQZe9Lp/csgKLe/jCYweEzqfw6lgplAiq27+3Ya9CvCI/nxgMFPyd
 PsR8S4DlGkRglXfWwqqQD2oqklso5VNGIHX+c96Ga2nxdpkmSfl1OewjGsGZdA4pHMwh
 MSLGPzlotYPrTGOHctROvj1/Ayg4dXIpn0DPkmXvxit4AE20gYWjA3d7Lw8UdlsiVxwn
 3opNgq1Tp4BwMRiwLr0USGcBjj40s8ZWP8wt4b3X3pojEcffkI2C63e+SS7pTe7H6Zfj Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbw75e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODiFWR018014;
        Fri, 24 Feb 2023 15:10:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49v9s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHKGgPyzvYm50O5Vx9wtKI/GiaKXfn9RgqaSQLqBZjejCSkKkecIjJ4GNh2bMiG9/kpL4guy1NiqSrdxQN84feUUULQSMfsUTQ5NGZLtuNX7bSmpUV5Le1PzD1qyLZmJKmqf9ovdls7P3ivlMXvogXYHWqlIxa8ieaJYxqipRB6lo+iOUYkDs71Dg0EQAWNzbgoHGLfcSN9TpqWqE0/2k53mY2N6Jn5BRf6uSBplkGF9n09rISgdkXRLScpkWwV+hYyoHcX3mk4RxXkh0xhDD7J+/AqnVIsJhPzo6L3b/Q7EyWM2v2pqQMxPgRwZf1iR0Bni7j1ZVsykm6A+qNZGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a34cf8zc8KvQlsJyGSt/TDVPV+RaXCR7xP4oOnFyk/0=;
 b=IWouWXGiz1o6m/r+ce6QHHSFhEfmjztvTyT7UP/GjrpC0l8gOQ0hSln43mOuFlqFBr7sfgKsyf2HTQwkAHqnRDE305lFnT+IGBydg7wbPMOfSYWFbQnR4zhQt0atWMC+p1gp3/gnjRYGqnBo2lkf/G4Bmb8uF8M6QjVtQvaA6CHChfuzAvWKIXZq+7DQ/z34Kwmj2iSNJZUqUsI+7O9D1xR934H8YIGCEIwTDJ0QjSRFq3JBT/AjvVB8kPh4ct9hovcPZdQqABf49u45tDGQ0/tfevUU2qSd2qqcLENEzo9g4fN7vw0FsxBkVcFTguGWt84QYxTU2G2R5j2fWf39Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a34cf8zc8KvQlsJyGSt/TDVPV+RaXCR7xP4oOnFyk/0=;
 b=xqs0SuEbbcoF+9HyoKQJTU4tSNwuTAz3WVqeNbdmPkYjgFj5qJ/7AyuKYThSXCHmyKUCma6dRBhaSdFdgVGSmHDv4KFuXYixwa//NxWxJ7AS4jqH6pTFhbfpvcj4S9/ueP6oJyqwfekc6tkrdTUsU+ESolyT+PFDFn9hb62WxBs=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 15:10:24 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:10:24 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-omap@vger.kernel.org
Subject: [PATCH 26/27] mfd: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:10 +0000
Message-Id: <20230224150811.80316-27-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0379.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::6) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 7391efb8-bb2d-40a1-34a4-08db167940ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lrwn6xClL1dT939/aqGi8yoCg53KodGZx+KVLOGXaOSVM4Oue592VN8vO9Nn3u8lSaOQn4b5wPc8TKFK1KTpth14bD/Vq8B6Y3zkh+c65UGd8tW6uzww6EmBv2lwTfW2evyFNBsfE5tVdcjqky3iKoiUn/IpJ3N38UK3U3SP2eQT/tYFKBA57S2eyIVl7k0QkjaIkStgf+tvSIMVZ5kVVESVM15C87YzSkdNu8AcwJG4rclTKY90dQa0o+KprMKWpnD8RHi0iFH4VZEDpo+9104932oYhT1BDXBfoC8yBUe9yueHktk+W87Wa1wuzyXQTsmcHYxd6HTgGyrg+APlIpqz9E6DZSQS7AKbHnELstU9Vpp9bCqc8Lla3kf9GOren3RyEfSgJNl7nbpBc/whWS0vaPDgx0dzae/8+W35+In057ViP3fzmLQ4vz1dYbQTfTRxZBICKUdQgOIfTkXgYO1lha9/C7TDWaAiUGQlBYfh1xJo7EHuG4U9Y97Yug1ZcCXz+WOif5tcD/dH/Fadf8RnXocKG/mR2cRboKSlxGop+M2nnC7gu9Nokz1J6uThxRGE/0tWgDofVKXCRXlp6C7DlpsxW0YlKdiNlH+RADD3ApEgSdBKz6g48j3eiPOUT4qMTRVPDayA2AezajZGAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(83380400001)(36756003)(4326008)(66476007)(66556008)(66946007)(6916009)(8676002)(86362001)(2906002)(38100700002)(41300700001)(478600001)(186003)(2616005)(1076003)(54906003)(6666004)(6512007)(6506007)(316002)(8936002)(44832011)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3kzz+2d8zPuUDqiUIf4eaD7MCKfWx276nycExl4kQDhYm0B1U66702cOJvMU?=
 =?us-ascii?Q?A3Wd0MZZXzFP6xir7l41PqMsUlYNbYLftpLY17NLlKxEZaFB3LRUYn2baxtR?=
 =?us-ascii?Q?lDBQHke+4G0l7bpn5rnPoJ29kyHnlkQDUNYQiwzbsjHQTzHkx6Siewoq7bQS?=
 =?us-ascii?Q?nY8L+ukbFW/hWXOyWNPZ7JCoCOQtO2AtjxS0Jjm2fK+wkDKLlQHFSNJSjlTv?=
 =?us-ascii?Q?cCoeI0pzgUeEJWcoobju//udyYurm7PTIaPo74TESte/hNSu41vqNRwY1F6W?=
 =?us-ascii?Q?zsCmgIC1rsHShiJc9y7zgEcKFojW1aR8cIxR2aDEtSSAxJNAQ9RopYRo451t?=
 =?us-ascii?Q?Jx9DGEG5HsCCRxGUeMls32fY3ItqVjMG4C6pWMjrIW10mM/G2EC5SqGSyb8o?=
 =?us-ascii?Q?Fay3iv95wM0T42GLuIbNuJrSrj7QpR/rdivu94gfZbtLuY3sh852dUlbwJD0?=
 =?us-ascii?Q?1DXxfT/hTGUh2bmuA4PR8bASPcEWZFJN+YRxEmx57ECVsEU6VhvOMENEptGi?=
 =?us-ascii?Q?0p643+oAE2Nxnag2uCJGbx0Uux40498jue39jBpdPG9oiYoIY7ZVYu2YDgx3?=
 =?us-ascii?Q?XMYmMe+A06aX+gwipXsY/v0bc6ZLhau1DoBFgELZNjlQpyGJnv4Rzda+pWEN?=
 =?us-ascii?Q?5u//U9W8JWIMKVphEeOSu2M64thkkJKUPesdinh4HBbT053FXOYQn1mDIi6j?=
 =?us-ascii?Q?6FwPJt4lp9+BpbzDWZgAYQXf4wi8lqcWCq28K0NW/9iXcjUQIL9t70DUY4fl?=
 =?us-ascii?Q?ta4Kse5q/4CXuWsQa8tP805XM2hafR7736WjcuOfJlpxTfzsxiV3vSGNIP1+?=
 =?us-ascii?Q?jtTLolbTlwPlNCrLB62zemJctwLouT+ClkDFjpLi5s3182YWH1qb90Cord6Y?=
 =?us-ascii?Q?Cb3BU9Zzzxb71MFnp/hMGg4sUjCGUEJpXRS+MIaepGMpijZQeTqQqWZoYUG/?=
 =?us-ascii?Q?NgYzP5Xoyfg8BIVSZmEqw36IWVdpZFiES0vLD762p1TGrNKP3B61Yi4ZrC92?=
 =?us-ascii?Q?kFQNDUe2lHC1jkDORdYJqjF0qV1d8Uc9JjE8dy9nCg1cwFjSnrvcJRrJ2ejE?=
 =?us-ascii?Q?Wc3BtrIG6GK6unPvfKgUz4K+ng9Es7u+i2uIF3sg5AL6Ob44BgyxmvkTwHro?=
 =?us-ascii?Q?5SmWaZ41WAEkJ2eFShy/k9F26/UIML0lD1NsrtV9VIWdidKswuMtlPaDfY50?=
 =?us-ascii?Q?IUHeAaTHXliqJXmdvB3g1F+y8u1RyZG4H3kS2TgNBgavNriAuG1PpNzuriEK?=
 =?us-ascii?Q?ZjU/vPa+0UvPexQph6iCaTtELEFegksT7JD2dJcIm2jAO2eayNWRGxlhsNxV?=
 =?us-ascii?Q?LVFtk47snh13uDegWdy9IvyGbwdYAfrsK/UV2kfD5ub+INerBokdLNmvIa/t?=
 =?us-ascii?Q?R8Ge5BQrtJz6K9cwhhxq27KkTkSE4oIpDYgUuIOnq3VlfbjA+cZBcEDLrKnZ?=
 =?us-ascii?Q?crpcVdWUZOJ/0d5bXiRFl8vk23q68MePFtiOfK5ev50G0Nq+OEjXF0Iyq3tq?=
 =?us-ascii?Q?txdV+ebZE6/mfwYpRfRXiOM35+JeIOmJtBgyjEeWnlu1rb6tjp9lQuJIykKD?=
 =?us-ascii?Q?vRJoTeEkidGGoQavn8MhAKyYH3kQKFPsIFsf+OiJ2Hg9B56X0G6qLmc+AGjy?=
 =?us-ascii?Q?yUIqKhuQytPyQpQV3rK0nPY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YyE+ZkHb8gBARzEqEZpHACZ5B0fR8weTMxVuW7LrNeawDgOKW8VBE5fMI2CDfJg72i2z1K/xh6pDMwSAcsHKtCy8C1TBzZH3LNmAPzxPdPr76vJp1KioVfkvVBxgujQ4SN0s2+xX8z/Jv7yz7Fk6c1UH97lIpX2vBh5P3JOIth1bos6NHxJ9OAfCEG5Aro6lRyAElbNZbWYg0BoDVxGYUWD1a9xhfXLkwNMGTPBcDqemCZvb0636bpngcXobNMX1uK6JvbBKTHhDX7ykh0kqCaEN7RXyqi7i9RK8M/XkNI0dYk+A4TLRDN/5a6kU8+bsOfygXJniHpSxEcT80RCfbJ1lHC1DyB7BDc34VoVSXFZ+rv8aX+iX7xI7sHi5GIVsHfxG6NUDwkAHrSa298h6eLv483xW4JhX8+a5HK/2N32jQIk6cTkrsqN1o7RxXMm1Cu7QJITt1QBeG5RrneFfZsVgDY2T5COO1RfRjbFnKMux85nofQqpoHYYDhRO/L2WfiURpYxqGMMtIx5qzrHuhDplzNtdp9l2Hw+or0Zqt6uLkDqwkomHirhOArLk9dIKiETgeWkUmuqcJbB2I5W1sF05GWTUekhZUOVtm78OuZvopgdbK24d/yE5slJWn1cL59/jtEnG1PePTqdPu8pJMqoHnmKcEIG8Y2HDWfNjBF9FZ7C86A2nIMU0+Ymk/EdDaoSWroYdqhhNqfISlgLvLvN/27gcQnLztAZHreXnKC4gU9Mtb9GXowhfiWR4lTB08jkZv/OqGr2qGuaS4BcE6QMkx2evjgCmbaOOz+I1yc8Fe0d09F10fzT5wBBmxaKftESku83WOvImUdUq8x7oV3DuYYF7C+MTPYEHERsrqWo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7391efb8-bb2d-40a1-34a4-08db167940ce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:10:23.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sxeh75W2bzVbA5JpCjdv2S3lglUNJ9pWDdfHJzMDJLYMGZ7XB84unSZ9vh3W0hkwz2yGOo7sZJMcKPE+EmGMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: P1w39P-srS0RU1wcBM8ZDwM1szLu0Z_a
X-Proofpoint-ORIG-GUID: P1w39P-srS0RU1wcBM8ZDwM1szLu0Z_a
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/omap-usb-host.c | 1 -
 drivers/mfd/omap-usb-tll.c  | 1 -
 drivers/mfd/twl4030-audio.c | 1 -
 drivers/mfd/twl6040.c       | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 787d2ae86375..7f5775109593 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -853,7 +853,6 @@ static struct platform_driver usbhs_omap_driver = {
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
 MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
 MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb host common core driver for omap EHCI and OHCI");
 
 static int omap_usbhs_drvinit(void)
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 080d7970a377..8ca4067da6cd 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -450,7 +450,6 @@ EXPORT_SYMBOL_GPL(omap_tll_disable);
 
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
 MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
 
 static int __init omap_usbtll_drvinit(void)
diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
index 4536d829b43e..88002f8941e5 100644
--- a/drivers/mfd/twl4030-audio.c
+++ b/drivers/mfd/twl4030-audio.c
@@ -285,5 +285,4 @@ module_platform_driver(twl4030_audio_driver);
 
 MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
 MODULE_DESCRIPTION("TWL4030 audio block MFD driver");
-MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:twl4030-audio");
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index fc97fa5a2d0c..e982119bbefa 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -839,4 +839,3 @@ module_i2c_driver(twl6040_driver);
 MODULE_DESCRIPTION("TWL6040 MFD");
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_AUTHOR("Jorge Eduardo Candelaria <jorge.candelaria@ti.com>");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

