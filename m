Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F566683985
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjAaWoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjAaWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:43:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF44474CE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:43:48 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiLdE014801;
        Tue, 31 Jan 2023 22:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lZHxvhJxu3EgYdDyb+xldPTjoyTFBCi3+bZNLUK7LNA=;
 b=0zpCtsueWJ5WoB3hmThtxn0dOHLep77/bC7ehxOLucMnV7dbDw8B/BUEvJ18ty8CfTFV
 Yz3XLXjqpimyci4lmEA7Rlt56QdLLFlOOUUJ1HbUIsY/2Pz5fX98qpvdFiA60FMrD4bf
 zTXW0icKSuZU9/bsE8wLTi5kTWte/8m4HN76Kjl0/LjX9UjSF9FowZ+W2d49TBmFKsb5
 SKdSvLtBq/A/zEzYWx31uXia5hh/KT8if3tBdd8j2RjWetqwdjnXNeGq+YjRgUCI0QYW
 y6p3O1anZxLzZ7M0alkK3v/nCIPvASv/7Qk6/Cbmnmd05pifwuKKWHUdy61hFY5H+jmM 8Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvn9xxcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLD9MU031581;
        Tue, 31 Jan 2023 22:43:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d6xqy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN/E5uwIgXnWJgUQDMStibs7DdbWjeWkMjD9xJsfrK40S3jOmqLpEPZpAAW9aPd1ssX9Npqu2iss2OIHkRSRqpUSuap1mFKwTNbvo+Q0AjcN06jzE+88V6OKfhmof80cyd2hEK6n2ziYr84Wag+hSuzLOLOTrbl/ygtd4O1nHX7v6K0jxsMiX15YO/RQrca+oDFZ99v64vIROsT/hcVcvHdtxaQGqoNC5N8x/CJQJo9mvxCd4t1ad9vS1SrI4Tej+TnsPFSbOVWsTXX0GzGdoZLnLWo+RThL5PnK25n81qLxze9/OCLktjYUAg4DFJq/aL37HD8Gz2BGaqZkm2CwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZHxvhJxu3EgYdDyb+xldPTjoyTFBCi3+bZNLUK7LNA=;
 b=ACHZUaNcFuLWwnxBbBJrpa0VlmWuR+vo25h5Ni9ftUntS1m7/TuQ0o5e9URJV/tvcprx5CdSlumzObmzOEq1SXxLmv1vgIJnh2fkRrAgj7B9tHW/Xm9ERF3zkOuVT/dWTwgsir8d3HUKa4tcXFh2Bgu5KhovnZtDJ6cIzOYyf23wl80LcxMFUItKeIt6NZiW+od4Gr0lEuZHIoCR2RrkVCrU4iO3a8Qs8aeSwt3w6cUIz1YQTBpnMYcq4VtKt/UPdM3vWFkUiaXxX4tVcpQ9QcmGY5w7HaXxDnQ+YYRQbqIWYdQFSFCMwFSdOgi0oi9AFzUVODMF/LJUlhzUB0Vjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZHxvhJxu3EgYdDyb+xldPTjoyTFBCi3+bZNLUK7LNA=;
 b=lp+VvhD/MOWZNDru5cjSaTNS5XQNxH6I2bHoToBT2+BZ12iChNy1HeugTen9jRXlCamTPcLfRkPPUTcugxkOnhe73/O8VTOVYVcn2LjSg8ysagOxGCy8FTmUKUoDCfPhgIrGoKLKIgXcLqY29dP4wOcciVJPjkVwPRZYowGzcj0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CY8PR10MB7241.namprd10.prod.outlook.com (2603:10b6:930:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:42:48 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:42:48 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v18 1/7] crash: move a few code bits to setup support of crash hotplug
Date:   Tue, 31 Jan 2023 17:42:30 -0500
Message-Id: <20230131224236.122805-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230131224236.122805-1-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:5:190::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CY8PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 15736b29-312c-402c-3d98-08db03dc7a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVQUwPpFhJcM2Jl7si1n08/c9pMH8W2vgSJeKPkRs/THrD+Lx38UNraWgKN4r/UoBXIaIgGKiUpwfnhICypW+G1V+7DhjsRLyJzev25pyh4IRisXvBvCiO3N4MeN3gFAKH01qS7pZ8c898t9qd3Wh8eOR7rMqkOHZ0pFd0Ez+Dsbfp4Y55MYkQeaB7xFNEj9AzIO2+SK05uQHqWvxuu3UygQjZfCmxWIN0OvCuFOfMJRjrZfrRZ3VmyBF+ptZO/AvNJuIXCreKOf9OqW22rNJ08hHYHdgAF8tZHqmXceGN25HgN/WLAQicVGnEuAC2hMKRhhSb2j9cIkCy6SsjmbND6e42r86iHoomcMuXOov+NZJNBmyxhXiZvi3UfDvG13F6hPZ863ygey1ro0MYdPGeTBzjLesEKgmXtd6yYZCfdYZPf4S3J0xQcUT20/6Yz4YVeIzs9dTJigV+tMAx9IaXo/+tbcQ2BASuvMlCLF/2AJnKSACvxkmSHWjMxmekSoxuiExKFE2oNDrMPdbFSG4dkxM/Fu2PdN/8alZ1Rimxqh3PCaJoxibgBG2S9PO5otWjj9YU0EY5+Mnn0Ocj/iZSQsR2f78eccjfNrEGbHUZODY6TkGuMWena1f6iYakdbQawniQ3YCdLVCmM/yT0Xww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(83380400001)(41300700001)(316002)(8936002)(4326008)(66556008)(6506007)(8676002)(1076003)(66476007)(107886003)(6666004)(66946007)(6512007)(26005)(478600001)(6486002)(2616005)(86362001)(186003)(5660300002)(36756003)(7416002)(30864003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JUmbsYSbl8Si7gB1EV8715mmGEaUDL8oBE+xrrSeiew13kw9KIbdlA6hkCQc?=
 =?us-ascii?Q?ZrixRTkfq/Nt71NbptgE6u9yfsYET3CSjS0AvHiE4H7SrZSmwL27TnXX+IfL?=
 =?us-ascii?Q?tX78Qs/NW6UYZWRcQnNpa2YanRNe2KZvbKOr3T38V6fKeJg+3CgeJBwIKCQm?=
 =?us-ascii?Q?D9fNiZuW1kIVWteechaEe+NrUE33zalBff+Apt7sQO7/BKLZZSj79DOfPjWp?=
 =?us-ascii?Q?iw9BteQalp81WwX3Wy3OR5Q80oA7hnPisa0Uwcp6r26bUbG3ZTopjZwBW4OE?=
 =?us-ascii?Q?Cp1oeuKF0JiyfNo8KguhmqbtoyaBIXeijXyEFd0piXcGG7NxDB7emWca1iU5?=
 =?us-ascii?Q?B9LvXLgNTk6WfiD+YjFSIUMWPPP+Fs2Z9Ma1Xe+wlkDWyJ48HxiOFGN62/8J?=
 =?us-ascii?Q?WVTtzLWzmR4Pvw9ibifWpA4+Uq2eN1txYz5sXDsJnXKE4Tyl8mj9/5X8nUi/?=
 =?us-ascii?Q?WTO8BrfxlKZUwCIRI24kg2qICxJTCv7FFbFwLVaDdsytNLEV3C7Z7VawWEf4?=
 =?us-ascii?Q?l8RvI40xHXnIogEhCHOETC/QdQgxf3r+f6qt3ErSLC+NMY+qjXW9LsG+6Wn1?=
 =?us-ascii?Q?X0yG518w7uY+jQJjhN5auIj0epe1uvyFDv37oBszM9xJXR7leTmvw661Qvpm?=
 =?us-ascii?Q?Mm4wWeT4BgBqzj2O0Vz/kEnOCxuoN2MiPO65yW1Hq/ruBKF8ncrl12g89Fqu?=
 =?us-ascii?Q?CVfnjU2USUiSF4jU5wAWM9Qr0MdTkoRIQONVgvBs+zjSNoV7uyaLXA1E+X0h?=
 =?us-ascii?Q?VdLS/Nmc0rDYWUH5mFo6MMwRn41ldzIvVP71Vw/AHWmLFfupuMQSnFG85p76?=
 =?us-ascii?Q?a3JAodWtHNR0/OUhvrVt7Y8oiqPF+akV7V/mZKMxvfzwazFqqSmLiMvydbC+?=
 =?us-ascii?Q?jLwbE8Engu1xERpZB0cd45jmyZ3e4qaFfdiEVdx4GyDbAl1iKIehvKjnNlbP?=
 =?us-ascii?Q?GAN1Q7pHS+53GgUzTPgcIhdy99Qp0R04GF3mruZci0vB/xf3O5JT4pevmDGA?=
 =?us-ascii?Q?RLbrmB+WE/uxITQgrnJRcwzejZ74XQVFu+u5AoOSxZOoRXzsoxoU8GbpVJ1j?=
 =?us-ascii?Q?sbVbekdSC5vc1gu8Woe71C5NcJFDN7deINWzJXaL/LCYoAvJTZF51F8oAFnO?=
 =?us-ascii?Q?E8tlzumjtdNCNWuD80Uu8WYXiVFj8rwTjAFsOUHPoQy6IQLdM2eFoE8yV5/x?=
 =?us-ascii?Q?iMtn0tngwTq4w/S1RMeAocrIBuUXr4uIHX4cCng9ZhUBy8VaBCQxDZ2koloT?=
 =?us-ascii?Q?oUnezz4A+2LA6ZgUG/Yt0FdiHOM7BmtwjFiOYiy8eWfDkNsdCLDQvPyJTEk+?=
 =?us-ascii?Q?4CxWlwb/4N+8nDDukybEa1RObCzvo1boJFgQdJL2EYCWUFcEHDv+ZcvUkezE?=
 =?us-ascii?Q?GBCS8dFMN/rTG5a3p4w4FLSpNyR8cgxdalEIiu3OcKiU6DvYBVIP+Etmj2Oe?=
 =?us-ascii?Q?GKxrn/ZX3sKCPofzkSmkzWBYhpnAcx0sEZGLQy1R8RtgRLIzJ2PfBgRaJTbx?=
 =?us-ascii?Q?nVi/CfEUJLutlHZAQ8Ad5ZmEw3J/XzLO9eHwF2TLlVaxnDSsKCMtfEGtsyVn?=
 =?us-ascii?Q?oZ1D1TEavC8oJkCHHM3Rh7SO/REs2IQYAB00lWf4dZ2qzsJfIJC39AauW4qs?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VvNjms6KvKfs1YB9EFzLTTwexiCz7080su+rPWBC1OAJu5+ylv1z0lK6wpSF?=
 =?us-ascii?Q?6Mr3pH4FoiJDrIGUpLN2kXIP2H2OjYb0ooy4n+XtNSfVeyfsOz1LV7D/Zcix?=
 =?us-ascii?Q?RfXORA7xIn365rS7sadjnu9neZSc2+3daDeqIRKwhWwdUO2aWRgqu8MhrKVF?=
 =?us-ascii?Q?7bTuTkUiFlWze0VS8DyFOMuja0CXeGNqkEkGSpAMJ3uFwrpdOBiiPwg1iITk?=
 =?us-ascii?Q?2pDYiSPbUCSq3sEpCM0AZ/M8qlB6SRmr1qXstUi8h6pUzls/5+fuMIYcOv6O?=
 =?us-ascii?Q?Ofk7Or/XdbNjFjrdT0QEQWozw2nD4V5ycnCE3v6aJH4ia+xDwyMc/s3Lv2bR?=
 =?us-ascii?Q?g32uBIIc+5A8vNB79wyVL+my/M2bfB3QMpw8U9J/we8pS3ywMD8Qz5Z0FJN3?=
 =?us-ascii?Q?jSZLa8661AXTFs8LUR7pKItbyHRmac2YDmMQ9Sut4iSrPUuU4FfRotAlZXSG?=
 =?us-ascii?Q?YbHN1dqoifELPmQoVvWfaD3Wq5mcxPz8RsDRIM4afNDLsEw5ts3kknwEekXz?=
 =?us-ascii?Q?rPOg3wSfWbLfwr+FckCs1yEzKkLcZc6NXfmQK+HuIiWBTUlCSAljVe9VULWX?=
 =?us-ascii?Q?njABh8ZVg/Az0kttc2QZw3VqMnf1zyauzQI94PyG96B2yqdOh75VcrtXk/H4?=
 =?us-ascii?Q?mF6WUPZXCPkrh60nKjXw3S0hSWwy+wT+vUiHssa4PVObS18xFZPPSj8iBWyi?=
 =?us-ascii?Q?5xVkbA26kXXsjnE4X4N2bu6h6Xx3fpoppJCaJy/Aejd7dnq/YV2MuORQmO+w?=
 =?us-ascii?Q?5O4GJu2py8BxIOZBmevCyngRco/q0ketb/M+SWtEaEoS3zG2I8qpUdc6/BOy?=
 =?us-ascii?Q?VVkPA6HthGILCUXvNBC40Ou/+g2UECeRU/e5JAYr8SqifRVg8GR+jGJ998Zj?=
 =?us-ascii?Q?c7Buvy9eISRD/hAO8DQXIF5io0AVls3VOdomxaBIPu/5V+7C9lT8CQ5I6zYR?=
 =?us-ascii?Q?uizppALI0zovLZYIjzcwvGANKUvVpvDDfG1VLJuJpqvAGKHaCOL//lJr8PDe?=
 =?us-ascii?Q?nsa5B5AqzUone5zzG/T+Qe+AReTIYLDv5pUez2zJFRakb8xaAsBM5XyLBCdQ?=
 =?us-ascii?Q?aq8SEh10Ns2VN82ERYfQsgr+CTyukyBDQibTGuCUbcytOG4sox3pY/C/ii20?=
 =?us-ascii?Q?rd0TVxIj/IkxMKKvymh2BOabiyony0grShg7RPoRSq0N99Dhcr/+aZg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15736b29-312c-402c-3d98-08db03dc7a39
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:42:48.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSC9oQ7AiZb2pq1b3VjYvw6vWYzkulo4YnDxVFWga9MWmIlR8frgoOiG/JEmay8P3p74H6uXvWpCIKreXrAX9GfXBuVSIW8ztViO2E6Zbbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310196
X-Proofpoint-GUID: K-3s-bYv-cmZBf-Jx02Hn4cZv2Z16zhk
X-Proofpoint-ORIG-GUID: K-3s-bYv-cmZBf-Jx02Hn4cZv2Z16zhk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 5dd4343c1bbe..582ea213467a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -238,21 +253,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 87ef6096823f..8a439b6d723b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd5983010b7b..ead3443e7f9d 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1135,184 +1135,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_HAS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1

