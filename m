Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFE683984
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjAaWoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjAaWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:43:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBF46157
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:43:50 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiM6a032618;
        Tue, 31 Jan 2023 22:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=8tUD23MLKHSi2Mcl5JhPnpLAKNKqOrZZxS+XQHu8fgY=;
 b=hyEHuU/2uCiZlRbKzwJRSpx9EMB5bRKYHpQLYV1pYdC2iXg8WMJx0l4HlCZOcKfE/VM2
 J/fAva5LBn7+oQt6vn74oY8EXZUbaN7VvEBYDU0iZqSE18WveQBhLf7USYN87U3f504S
 b0GswIwmjO2WbYH7awoxg1YwNLPPhpnq1wKPQ03/uZKn7oveE13KbYnkW4A9Sw8NHCvK
 6Ea4TDGPL1Z9UZe+4i9JZ8uTv6+GaKgsdrwfADrQcwXG959vl4q7kzMitDQGIoMWEF0z
 jPmdAq0wn5eq5oX8cUFOCwXFvhSZdetj5lorEN52V4XhdXsXCidpJ4S572xttTl+dYSW Yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvrjxx38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VLG1Ou012963;
        Tue, 31 Jan 2023 22:43:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5d7q9v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 22:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfPrhwrnI6M/nAwD9kgqEZBDFKno842UOSV0zKg1Pf70kMGGHyEG+S/Pm0x/Gwp4QIoiVGGF/8DMRaLW+tAssDcWvFxPyJZ1/sTtrAdJXcSgwBVXWhIKcta4g0HS1X9amIhsTEVb2W97S3T9jL1PWP98F8nHQBa1uu3nzV1Vlz6NiANlpSrfiFiT58GyQyzFaxCKswzsaXAu3H+ruuG9TcCS5Rp6JLSZVfECJYfotVc06+zgCOUwASDIhZ7WbQLSOMUIvAWCq2J4N9IpJ6XxtvuPk4c2JI6N74dpaJS/FbM16sR5Ils7zhWFtiORabV5hEaxiq+IYxyOdNuk1v/bQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tUD23MLKHSi2Mcl5JhPnpLAKNKqOrZZxS+XQHu8fgY=;
 b=lKnJgQ1Sih9xSTC27x2FtMg7AxR96oLMgyybD6pCNHm0JVvjZ7YuGZJw0S0fR1wqJZTVYnR99KgVcYoR9PSScY4AHXBD/cGjA75lKHhgXco2Am2kwAzmiypjcTRMnWacsyO+5S++ygFDI23U152hHoObYpBfI687wKLWJkISf4EogOpLkbUsi5DEuc0N+bER4kI9/HwDWudL3hOB7zuWaHr5P0CpsO8HA4nbXzveGxPmb7G/qK1BdqSgmaDacb9evkgUCzkzClKCs346Lbn3azBcdDcr0SwwNdxds3Aw6x4qms2jUCzD/kvqeONsgf0Z0/PGLl6efvWCL8yusBoD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tUD23MLKHSi2Mcl5JhPnpLAKNKqOrZZxS+XQHu8fgY=;
 b=MPBtYCyO6DDlqDdcDSPoaUtNF9c9lYpsV3iEyOzYP7s1k4HXY0HTtwCOsM63F/oBzdnJPgLRtIo2tQTowaUTsl6ORs8ot1FOKawtOU8ZNfc4aTtEiH9/Eua/EwM0SJBNSkNMTVd5rJ/tYEBsvyWvhly6YE1LYifDvEQsg+DPPOQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 22:43:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%6]) with mapi id 15.20.6064.022; Tue, 31 Jan 2023
 22:42:59 +0000
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
Subject: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Tue, 31 Jan 2023 17:42:34 -0500
Message-Id: <20230131224236.122805-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230131224236.122805-1-eric.devolder@oracle.com>
References: <20230131224236.122805-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0062.namprd05.prod.outlook.com
 (2603:10b6:803:41::39) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f991337-5e24-494d-14d8-08db03dc80e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvKTyM9HQhSJMcTGJYMmD/NK/fmuxEK+/JS7YEw16/hRIzE3SsVMHi58imggausEmKB6ORlUMaPFlqZB3ViKBbnPGE+TNBwRTqtJIPWMsQPpg/h62ylWjmn5hiMXIkw6qGHmgfst8OZ/nGenPFjiALqdYDW8Hw8elNXETwEPtkb70RB8ZpI9bKZUCrgY1AagzH80NMswn33dWQqY4zOonvtihrZQ3c7NGULQ91A908SC5ZuM+Zrm1DhhBW/52fZC0ZE1bG/bcKqt/1vpezIfySrUxFONi7jXgztILxp6abXPJyW3wWITP27asMYLM5/RMU8nRdXJwtn3V+f+BmCb1tGvKV2ksmwErHcIIApkAkctpR2xdNXYt9V6QSZRtWHDs/BkFHP4bTO2BFtwlTYKtd08GP5AqlQJlb+7CG48Y5M79v4mCm9eub3HOEIZxnSu6KmZXDVugSUcelLZhOyc9rJeER86VM+Jh0t8bqwUO/3zs4ToZE0zCHh85y+GLZq/Hlf0cvjHDRvH7L3obmDsI4QLnl3WQVlnd/XuAHNGWqGMTCm0zvSyi9Ub8ORnSB4aHlnNxhxKwqmeuUiwMyrrxmVSfAuEwWPUPJKtvdAxi7Xm+i9/fkYiwajk/OYg3mVK8ifXSlhYW7KR0Bde96Cptw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199018)(2616005)(316002)(83380400001)(66556008)(41300700001)(8936002)(8676002)(66476007)(4326008)(66946007)(107886003)(6666004)(1076003)(186003)(6506007)(26005)(478600001)(6486002)(86362001)(6512007)(36756003)(2906002)(7416002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNgbG0UjLR4kZd+V+Sd34XjBC3IKDy4ZwuXdydwZQ7occPZqZS6TzQxS7yLY?=
 =?us-ascii?Q?ki5BxcWFfGzYqeAWfOKEfV0fcasC1saLbLI4vNh/MC8PkECRIRNAnij+XvrO?=
 =?us-ascii?Q?JpyR4LqA+2Ip80wiJoKjePpljR9ThZMykax6uVlCeVHpIa7KpZUxxC+U/tRO?=
 =?us-ascii?Q?2YG2R2E0Va/O+FDy2toGXiJZxQuJRSe59XRiIkExZn3xv62jHab5JFnSn0YU?=
 =?us-ascii?Q?/e8p/g2MJtWyiOkjt9DmvZ7tNhdxHz8HUG/L3PgYyriZGgwW/1rYiZvHwCEJ?=
 =?us-ascii?Q?xNRnuQo7AdmCcc/HnoLPi+/AQZsvFERlrx8vCTyfWALbDCaIuLUccO2RxbcM?=
 =?us-ascii?Q?yfRD53mL8+vtnyWOJ7jcksYUJu42c9r1ZxvvYIfQQhGoB0WSk3hGDMJ221aZ?=
 =?us-ascii?Q?Jc6n3YBjiYCcINv+TACLFATgphZuoF/IX7mSQLfktYATQIrbS3jRUdJCYhXi?=
 =?us-ascii?Q?UvWPe9xl2WsvJIuSVUsEQpKB8Fj3t9x74c/GMwU453OxfnElqniPa+CfHWW/?=
 =?us-ascii?Q?qHO0o9zda7RSGhdD4gWxDF0nx4PT/knTolFHHOkMlYvx4HieNSwQZBzg97R+?=
 =?us-ascii?Q?qaE+rB1oU8FgfRVjxRi7J8UPIOHiFtmL+osga4ycn2DnqlV4t/M/bWxj45fX?=
 =?us-ascii?Q?DEn2w1HG28OBNg4nRPLW1Hp8ncRgJHgtNlMU4M+NWrHgL3h81ByR5Md6yaKx?=
 =?us-ascii?Q?vykpGZoTc71+xpHyDIeasyXuAPrmZfdagTHMWQ9o9kWFpbjZ2O4puDM9Odj2?=
 =?us-ascii?Q?eNaZpsdVm1IdGjT+BDWs2HFA/+hXbA8RTkdI58cM4hHGZaopFMH2M6Q0utJY?=
 =?us-ascii?Q?cNaNkZ31wkFxIsavz4izCt/rzU2sjvHtmMw5siJVFomgHucBjNnBTIkb0mrd?=
 =?us-ascii?Q?JwiH9IRUg5JioI5cbFQ90Rh5qjU/i/9W+00l59YjIcZO1wlbqnTiunDrsyl4?=
 =?us-ascii?Q?obREfgCMxfrsYY0IeAGJtxc6zuw/qJc3pJeHrw1K9fy/fquK0uYRR3Tb42Qs?=
 =?us-ascii?Q?FCVtteRYOg1ez1eOnuPD5pqg7bLXE+ZcWvQgFtAcrlmj1AXunFvKpTfa3cDg?=
 =?us-ascii?Q?pa9RvobkR7VhUmN+bhZm8VtWuTHn35rOOzd2hCp/BVsVnCVFHq3kqklOXbAv?=
 =?us-ascii?Q?zkJJzWWASXGI2oNRGamhgLOF2TKDkC7Kfe9KegVuFmsFAOHM5xLdDKuVl/JP?=
 =?us-ascii?Q?8FgnbN/E5VPXOdV74NLrDV3oNzHQAV51LVBk5/uwtpHmanTo0lwI+iFXxMby?=
 =?us-ascii?Q?SxocDasGXwIUwUOkgjTgOc6WEr/bZKCghGuMrZMO2Qn05EoGMU7GaE9gRscA?=
 =?us-ascii?Q?b6QHpRhe56ujACnaZ8bvsUsS4K+pSCtNwge+2DwQSG8PdNLlxpX0BQW/b5rl?=
 =?us-ascii?Q?jII9BN6/xQuXbZ5swDkqG8CEJEeFG17p7okTWU8iXHoWGVmW1cJd4k/EiIr2?=
 =?us-ascii?Q?QVsX4tWmA6cUL4mbYjlpEeUzpvNuQqDu+XjWASqKOYjsuSE/yiw6MARp001t?=
 =?us-ascii?Q?anbKqzcf29g4sOQOAjN4aRsox3/ySfhvBldyxRz9lJKc//K9HlQyZTQrDXzV?=
 =?us-ascii?Q?6inE4Tg4f8cVTmvS7YJhGw9EC1Jvm3mUwH7Ns7XcHcgygfqHQxgmMq3ojP3c?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9fsIkPe5kMReztkR/eGmeSwLW0uk0+WpobN6toBgJPUAKH4iMc8yzlQ0qveh?=
 =?us-ascii?Q?7OfpgRdNVGsKm8FUYocaFoTUmKQHbGanvJZOJ7U0v7mg89LlNGCPMhZ/kxeF?=
 =?us-ascii?Q?dTMqaKWs9I99C6M/rZ7p4zOoQ4Cdy9KiUrRA446zxXR3I5Kw8ntm/kGDVlIF?=
 =?us-ascii?Q?raBZSWrMXDyQxjYZrg5m9Z8wGckZwscTSRp0tX0pgiydbj654cJT/sqGuf3i?=
 =?us-ascii?Q?a35J0sLtjlKUr8uD/OLO0kR0IVN04sJfH9j7ppx0REDvSta6crKEL7SUb64H?=
 =?us-ascii?Q?gNz6vUY6DQiojQoNzbNMpEIDGfBk2OZQL4Jk4SpT22TKaJZmnABDYCMY5jgB?=
 =?us-ascii?Q?1wycohUk42FpQw7HPMtcTVP7BuPb9mcHqcddbmlgJxtxmiBSE2Kdy9kWicnO?=
 =?us-ascii?Q?7i8lR498QySo3dtTivjVHZ2hQNBVfc3kvQeHwJYUnY6Jpw9gEDJz2NSEz4IW?=
 =?us-ascii?Q?R+QUSmOVOEu2zjkjeiJNFVW2fwOhahCu/qHpGuz6VOO+kCWR0CPN7CQqe/lB?=
 =?us-ascii?Q?mQbma1uPanTKQXZaUBEER0aaLXsV99shhIaIHYPSNapTq7CiI0HR04UEOe+Z?=
 =?us-ascii?Q?oxFRf94ohA/Xc2dC/vua/T9H7sBjS2ZONv2dZVcByyDbAzthajttimv5b5Pc?=
 =?us-ascii?Q?x4Sk+69vtN7sSEYGllN6wiJg9Z6Gj8z0iqmZxT4/jawV0rQ1aI1s20xGQqpy?=
 =?us-ascii?Q?VfA8w91DnBnjLbhoxuxr9jakvAP5PDwmovuwJmD1vpU9R9sjuI11bLAccYwy?=
 =?us-ascii?Q?wty7y3c+8Ka8VwhEOjg0e4FuWqF2IckH+U6B74UHou2lRnLuFh5zC7crXmhw?=
 =?us-ascii?Q?q42R0NcmuH5DR+t0u5FjaObM1qpQKsdR/iSTI9OCGzqgBHYCIV+VTvfCTQmJ?=
 =?us-ascii?Q?LTXZFnYjL823QPkgUAfwrdfybhzD9r0DKazE7FQNq2HhSV6/fBIVobjaQXKo?=
 =?us-ascii?Q?fQDjElsRjo92XmyjI6NzkTrW1MaDaqJIFFd05M7JWP8G4YXz9f/bNpRcp07H?=
 =?us-ascii?Q?Tk/h5iap9nxz41qcQ/7IL9caBY7vo20bxUF1Oocnva02tsjtSaXlnT9sLovY?=
 =?us-ascii?Q?bvfsEqxzG+vaBlBR4Cy+RbGX3l9EdPfVL8rve0YwUa1h4TCGbG2DVAv9rChr?=
 =?us-ascii?Q?78t40tOtwCL13bD5iNAycVkyC783Yvx0c0C+QurlM71UaaHh+m5+h7g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f991337-5e24-494d-14d8-08db03dc80e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:42:59.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWTVtWbz8nATry76R49poY/69evAK9ByoXSimH+INJ1eFftdzJLmXV4UCxqdca6UJHWqVZXwpvFFEAKc42klAazAffsySCsYz16L42u3izo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310196
X-Proofpoint-GUID: eGlfM_w9TWFUqJXfI1uoDEDOJ9gdLrit
X-Proofpoint-ORIG-GUID: eGlfM_w9TWFUqJXfI1uoDEDOJ9gdLrit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In crash_prepare_elf64_headers(), the for_each_present_cpu() is
utilized to create the new elfcorehdr. When handling CPU hot
unplug/offline events, the CPU is still on the for_each_present_cpu()
list (not until the cpuhp state processing reaches CPUHP_OFFLINE does
the CPU exit the list). Thus the CPU must be explicitly excluded when
building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 5545de4597d0..d985d334fae4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -366,6 +366,14 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+			/* Skip the soon-to-be offlined cpu */
+			if ((image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU) &&
+				(cpu == image->offlinecpu))
+				continue;
+		}
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -769,6 +777,14 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 			/* Differentiate between normal load and hotplug update */
 			image->hp_action = hp_action;
 
+			/*
+			 * Record which CPU is being unplugged/offlined, so that it
+			 * is explicitly excluded in crash_prepare_elf64_headers().
+			 */
+			image->offlinecpu =
+				(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+					cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 			/* Now invoke arch-specific update handler */
 			arch_crash_handle_hotplug_event(image);
 
-- 
2.31.1

