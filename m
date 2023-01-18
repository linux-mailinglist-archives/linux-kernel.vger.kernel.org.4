Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F07672AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjARVgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjARVge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:36:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506E564D83
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:36:33 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IKmlEu018138;
        Wed, 18 Jan 2023 21:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=e0yADqJ81jLTv0pyZxCiQ3ni7M2ufBxAvQM4Z/Yavws=;
 b=I2FQD5pgOxjMdb6JwQ0dcWdun4A9n9AUxLR2FjR/JA7YsrQ8Osqqe/tBqAyU0/2Ai4rs
 3A+o5A/+E40KdgT8vq+sCVvV+BpWa5+oFve28jDhSIJSgmvSgMZaXpcLQ+RLzBpUzFVO
 OL4m2O5Oigv1PBVz0CmNpSd1e6aOzizPh2VS1omunBZTpJ3Cg1bI3GraN59KopF+r4PN
 maheotfjmRh7Aq0YRTKwryS2P8fYmWpKCXvqbpYCINwYf3UbEmATYOUjiZn1++Zr0a4R
 jnVcEzY8EMElf881WvAe/MAL5EPfgLtwcIiV+5TU7DDyP+nRzVHIWSmmrX/sabC/j2D+ ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c8qts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IKwdfE016614;
        Wed, 18 Jan 2023 21:36:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r9e1f20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 21:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0CmyXCfCbpc0H+Ahi2sZp/lt1E/29Rd0gVE4cUvXRwe1WImFjOrdJFcFUxu/hPrKuT1BgztroxQxhSOpPw4io/HfKwKyPJHcI/n7oGf4E36wt+Qz/LBlX/7hfUK83zoiserlFJejWuOP1NhUTVlRmPfV9uOUX7n4awjI/ZjWlBSfz7MejCTaB0QDzlg9vRBI3cLUMDVBrZTHbz8HmO/52ULj2EliuHasNVoCGfyOU0opXArEeodQivHN1Mmo365l1c5M3XN17ifAeMuV9SzhEN8Aqlk6S8MHWKNY4i7E7SyFn4CN8DeXgGwFsU2e4QsEcnJ9s3CE0o4lnN7BsIK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0yADqJ81jLTv0pyZxCiQ3ni7M2ufBxAvQM4Z/Yavws=;
 b=H3xLdgmbiQuBvLZ+zuXxy1kSCFtiBI5C+Ob0QgFGJg0QTVbafnAQAsZEyZmhNaa77S6dXTc+V2d5IgW8FZ+DJo92tCOjvqmhA98V8URCKRFI5chgCXCzLu8gaJaetJo1TWLU6b+G1Utzkcq4qnOi0GLtfJhtLpDr3tgY+hVIaZE+IWZ6aOdgpwjB9ebHf+3BVhXOVFPHZ3ttjTZuINgrXCxKaau/4EphatLALfM8ZyptgSeMtA8T/0c9bKCNUBAsl4ndbcD1V5MrgMsCYe4Y52dWSp+7kYPB/O5WsWdH9V4DqTYq85gCyxLOvF6HglW/GYOD8kPOmIIjJH/6c6anlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0yADqJ81jLTv0pyZxCiQ3ni7M2ufBxAvQM4Z/Yavws=;
 b=p9EnabMG6iPoupDBBcPlNflsHyAjOtEUemU8Gq/qP9W58KdWzE3t/nZFq7dQrYCULzypbrqyK7nq4QtbC/gI5feZfcfqU2NnwXuTvSP8+Rb6wJ+PKQe1O+EAN+hkDz6lmLHoIbX5PIA0s5JhwujhueWSVRelyMxmWt8QFnbC1Q8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 21:36:01 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%4]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 21:36:01 +0000
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
Subject: [PATCH v17 3/6] crash: add generic infrastructure for crash hotplug support
Date:   Wed, 18 Jan 2023 16:35:41 -0500
Message-Id: <20230118213544.2128-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230118213544.2128-1-eric.devolder@oracle.com>
References: <20230118213544.2128-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::41) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: a18ec4f6-0e0a-44ba-e044-08daf99bfe40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2xzfS6gqmZy5wKEs/+prZc5CWg3QCstRerBjiNzxbzGFqg4R6A/Dh0bEeLYjMuXEvzk0Dkz0YaY7NwAIP5tLtYk9pyfC9vazV5w8Rna5KpEIf1bZ2rREIxNUiC5PGB0XzfUGTStSkseEI2RP7TIiR2juqVnUX0NsW9x9+HrgBZcGf7etStTuq5Zf0u0dwP/qhph9Y/h1olhIk3t1L7K6KGABbtkNiiedxpSakZqBxRlDX1T+qicpRxvS7F1JtDAKZPi5E3jT13KaSg7e7AebrdXfFCegCYgOCfJJvh8/giJm2/1gMqVkeytP+OnKhKaOuXUSsgw8PjzqMyTks1JB4zUoZeQMvdlhrftgeZlYVviRZpel0UbGo1lr96dK6vuUDsgecE6bGo9t/Q+hmZjuxLc7wvOIDfkqcD7Qn1XzmsJM3QHaodk3p7gp4FktRLoOKF/ayt4qGKL00QkY9NifB0DL6TC9R+s/Xd/ihEo/PkenGm4RYYweBpd9AlYejff0W3R+vTXkiCMa8lWUFLkVw9817CELmlbpYd+uywgidQUVzrntUcf/0eCsUh/pnC7L8w/dqbrSYIENWFIWlVDu+DV6+J3KZgKYTE4fA1glNLK3C/7fu6CY0u3x83XYterRxjNcvZFu7OT/C0NWxVdx2QXIUEc8Xe/XUbMs4l4HnZNqRakwHapxy+CzK/W5WII
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(66476007)(66946007)(66556008)(4326008)(8676002)(36756003)(41300700001)(83380400001)(86362001)(316002)(1076003)(2616005)(2906002)(38100700002)(8936002)(7416002)(5660300002)(186003)(478600001)(6512007)(6486002)(26005)(107886003)(6666004)(6506007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w8pHIs/YzT+IGXnZVMg8Ic2ZrsjnLo5gAeY5Mgm2vlCFYPQXEIkIZ9ZzU2Ix?=
 =?us-ascii?Q?+e0ECJ+cjxD1xmOPicnEHLQNPOvv9WTd9mAyziDryqdobmD/yHEKN8sFeRwc?=
 =?us-ascii?Q?T4iRBqBld58HbS259gqAosAsToIXa7pVWKDF5FWJN9iReBETlPoOQS8XVrZB?=
 =?us-ascii?Q?WTzDoHP2jB9iGo0PVcxJa3u0dmC4wovF1suEIAYvBykXMOFc0irEkvuRe8Dm?=
 =?us-ascii?Q?vM3Qqzb9rMti3iEFmrdyhq5qmSyagITiP08JvBx+ZgmuxyJwTGHoOiqjA9wZ?=
 =?us-ascii?Q?tRINYmHTM+amoutDIqMe7iY9yFOoYGu2BW3yGEYCMMgIg3um32uFf7NFe+ZX?=
 =?us-ascii?Q?djoDnloFEwOlcyoq/P3A6jGR/HjlJ4VgGjQI6vLbM9+rR84FGTAhwO54JIQb?=
 =?us-ascii?Q?QjIDoLKP3iUSiVtZm26VdKpW4EsQj6cmQgGj7daZDNygNioLb6ubpD3QHR4T?=
 =?us-ascii?Q?/axvuYkqv0w64DrLSmGafr9M7Ns9YxpiCH2jdHVRGJy74G8geH+zDz1laNgO?=
 =?us-ascii?Q?go67tN6Je2j2KkhwlfSULlFcX9wTqMfs6Cl0PnJ/kHlLOjf/SLGLwWGYmErH?=
 =?us-ascii?Q?PAyZYR2NXunUu4Q3Asusld9PINvjHwusKG31RiQyNHPob+Wg2Y5lgdODvo5a?=
 =?us-ascii?Q?6niP2pHgxg+kcznfcxq19muDJV1sMtk8d463T7/dJlcPqiHjsTxQVgvV6Bm+?=
 =?us-ascii?Q?CvuKfefF2g1Jth9XXuahxov2CZK2HhulzJZn4qkokFFCEbvsNs2n6DwjZ5TE?=
 =?us-ascii?Q?LqLK0YQtPt6WtuCqmYOSsOqi+GfkWX6upwwlyNCajEOJN4oRQyJbF+Hq4C3Q?=
 =?us-ascii?Q?pmWl7HNarUcAqc3RktbU1P1hD5VXvPCo3HWcI3gc+7vPC/J3znvDo8MxrNPJ?=
 =?us-ascii?Q?bMcglu5XC1loXxvvv0a5u2/QAeTAhjxZkUb+qPAPVHnufC+g9ri7wHxrP76M?=
 =?us-ascii?Q?3UkoSQAQ8aT77F9VukYeH6VRJFCyWJYMA6LOutrutTdlir7Iu8sakvLdvIlu?=
 =?us-ascii?Q?Hjr2qqhz0gYV0FqxP4ygdBGrXSF097swcxlgSHRixtTb6k7QoDHD7mF3Hqfp?=
 =?us-ascii?Q?zVVi8i/ZkzA8F/2sq1BT7eFe3DbhLygy9KgdlblLlCaudpjxK7/73sPfc+/V?=
 =?us-ascii?Q?/O5ea8HaxeH7/oKXMpQ+faaQ1rDJXlf9IqstwC02aUWnYDFizpnjJ6A0BMF/?=
 =?us-ascii?Q?cGJfjnrm/eKrMjlFKqjwecqw2yMy7y1BSyxOgYmMZYUCLz7/HY1xKjUXTg5x?=
 =?us-ascii?Q?DU8BASjug1CsagaAjCjO1yTBz1WnQIyJ10VYmcMFUF9F9E7OMrjiQuajA4GQ?=
 =?us-ascii?Q?UlTeUxEiMdsaFt9oKY2XnNJFoI0hH/mX3351uXrSqX1FDVXod8JVqM08UCT+?=
 =?us-ascii?Q?UH4f9Ge/n1JV5+rFiktbvqAFGfwG7mBqvMclWObx0XpWn8EG0q8OuSg99fPO?=
 =?us-ascii?Q?2RvDOW17AA4LkqB1KGuMyzZXbrgok5nOH2beDlHaX3iIpDRHNdt0krepHrAk?=
 =?us-ascii?Q?u5GRTJFmsY76KgA/qhZX7roTtP677MBklJpZRTU45Wp2YeGB9whylCndoYfY?=
 =?us-ascii?Q?IgzqiCxPHxSQzOxBxEQsqLhNwgz3jlZE5djxXpB7QpBBeh0hrVOKu1V4A2Ul?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?daOEC8p7K9+Sq7NY0s2K3yyzSlfCU+yjBCnslOOK/YaliLx+zDtBVI2Ispyv?=
 =?us-ascii?Q?jD+2V3sy68w/b0ldck/6ROtL+p9LwtFteEgEv/yNpoazA5SHAraUdPHbYVOi?=
 =?us-ascii?Q?XXNhgloBTRGMAHA2lCfe8165Z38I144jobum7nIFR7N/mN2kti2DNBmAZHiL?=
 =?us-ascii?Q?YV7hW/IFVncJhr5LXuf/u0AyS9xrtly7HJHDCRxIsIb4Mr4BnXk+8ypguHeQ?=
 =?us-ascii?Q?JWhMIteywLibLaOGfajmdJQsShGuu1LUWgatsz3vVIMQHJqzB+X8Utzq6dIQ?=
 =?us-ascii?Q?E2yI584zp9Nl08hlTK5L75gvfj/WEmPolTAf849UyYzrM742zalO7YCwZr8c?=
 =?us-ascii?Q?jrEzjiDOGvZ/zx4onYwggQhi5mascSPUEoDc2RE8FO7qafac2bJ7w0bcUR11?=
 =?us-ascii?Q?SnmmNWiELTPhQalX6TeFhluwRuCveHi0+9F1efJynsPz89RoU/oF60I8LFBR?=
 =?us-ascii?Q?alsbILQTtTyYt4OrsW/2phC9jZ3n2MicQI28yjY8C8sGUCAAvX4rOEQCoVmb?=
 =?us-ascii?Q?7C1j4LJdGySfF9N90aE90CI5LM3W4MBxpW3LG8v1546OkxUlIgtQB0m8+7rp?=
 =?us-ascii?Q?WrPjqoy/uz9ziM9ApnTX3LN+H0EMqzkZgKaV0/ams2ODhlavxH5VaAOb/WHs?=
 =?us-ascii?Q?2xnN30xB6p1FIzDH8KMvwmxgYvE5ShDjvvAiHsT3KQLTHqObH3epylad5/Rl?=
 =?us-ascii?Q?TGZ52Ni4xUVZCBvYO/Q8pha2hOcc4XDm0ypKoMJSzkWagLu5NZdaqhrGoxYl?=
 =?us-ascii?Q?G5Mp9m/E1DSGPkSgaoVZrIb5aEIP1VuJAynGD/W0JqdtnvtqrR9VvsjcLJvk?=
 =?us-ascii?Q?XRMjU0pRq8oLyenqr8DL3xIQpag2wVK3c47MHNuHIQlZRn4K4slZzw2FNzl/?=
 =?us-ascii?Q?mPnTVJxUYeZipSfFQdMUkXn5I7qn+j9EQcNn3b21b3l8UzOlhVdaoaOzOW/K?=
 =?us-ascii?Q?yRBBXC7goZ4gP69lB4rDtdtPixD9mWg5VLa0alGZTC+PrszxVLmsO+Iu4Oeo?=
 =?us-ascii?Q?uWZ5vhlTAIKlXQLTAwwG91YEdIGiDD3Kh/72baitdndh91+Es4uuHLZIQLji?=
 =?us-ascii?Q?YwrqHOe9uSTM6ZKBeC7a0OHchPgVjkVu/mndrNcy5xwrYk+WzOlfI8hSfiyy?=
 =?us-ascii?Q?TuJ4XrD/hvRzVU87awurdYkX2DEulwN1k92OP5A12snrK17oRrsYMqE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18ec4f6-0e0a-44ba-e044-08daf99bfe40
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 21:36:00.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAmYmtxwxUUnwriVOuFEEOJBBSioHyR+/aR7OVLavP7kqtPwCgwvXtTymfc9P/EyJxOymoi1zQ9XcNVg33tgig/7rtqugXQnmH2eLuI7sMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180180
X-Proofpoint-GUID: hLgdDf8pfsyBGpYSSTNcGOPCBoDONCLP
X-Proofpoint-ORIG-GUID: hLgdDf8pfsyBGpYSSTNcGOPCBoDONCLP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU and memory change notifications are received in order to
regenerate the elfcorehdr.

To support cpu hotplug, a callback is registered to capture the
CPUHP_AP_ONLINE_DYN online and offline events via
cpuhp_setup_state_nocalls().

To support memory hotplug, a notifier is registered to capture the
MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The cpu callback and memory notifiers call handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event(). During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   8 +++
 include/linux/kexec.h      |  12 ++++
 kernel/crash_core.c        | 138 +++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..a270f8660538 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_REMOVE_CPU		0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 27ef420c7a45..881e8a43db89 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -371,6 +372,13 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	bool hotplug_event;
+	unsigned int offlinecpu;
+	bool elfcorehdr_index_valid;
+	int elfcorehdr_index;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -500,6 +508,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a3b7b60b63f1..ab074a706e55 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,138 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	/* Obtain lock while changing crash information */
+	if (kexec_trylock()) {
+
+		/* Check kdump is loaded */
+		if (kexec_crash_image) {
+			struct kimage *image = kexec_crash_image;
+
+			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+			else
+				pr_debug("hp_action %u\n", hp_action);
+
+			/*
+			 * When the struct kimage is allocated, it is wiped to zero, so
+			 * the elfcorehdr_index_valid defaults to false. Find the
+			 * segment containing the elfcorehdr, if not already found.
+			 * This works for both the kexec_load and kexec_file_load paths.
+			 */
+			if (!image->elfcorehdr_index_valid) {
+				unsigned long mem;
+				unsigned char *ptr;
+				unsigned int n;
+
+				for (n = 0; n < image->nr_segments; n++) {
+					mem = image->segment[n].mem;
+					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+					if (ptr) {
+						/* The segment containing elfcorehdr */
+						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
+							image->elfcorehdr_index = (int)n;
+							image->elfcorehdr_index_valid = true;
+						}
+						kunmap_local(ptr);
+					}
+				}
+			}
+
+			if (!image->elfcorehdr_index_valid) {
+				pr_err("unable to locate elfcorehdr segment");
+				goto out;
+			}
+
+			/* Needed in order for the segments to be updated */
+			arch_kexec_unprotect_crashkres();
+
+			/* Flag to differentiate between normal load and hotplug */
+			image->hotplug_event = true;
+
+			/* Now invoke arch-specific update handler */
+			arch_crash_handle_hotplug_event(image);
+
+			/* No longer handling a hotplug event */
+			image->hotplug_event = false;
+
+			/* Change back to read-only */
+			arch_kexec_protect_crashkres();
+		}
+
+out:
+		/* Release lock now that update complete */
+		kexec_unlock();
+	}
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+						   "crash/cpuhp",
+						   crash_cpuhp_online,
+						   crash_cpuhp_offline);
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
-- 
2.31.1

