Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A49B6ACCC1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCFSe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCFSeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:34:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74234E054
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:33:41 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326CxHxi017861;
        Mon, 6 Mar 2023 16:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=CotqKnVdDk3X1prrVrS1EFkdXw1CdpNKpqP2m/gFs74=;
 b=bLRUPtJUFR0LrHJ+z2BnRXiEhstyeDOwh5lvjMbDjPGEgj0imwpUKj89PLINakulIwcb
 leo/dJiaGm48pLc6m2iZLMUNVrt4uj6jkSX7pMTLWNX6cSbun44jRw8dxpENQSH2hWOX
 fXdpB4MfEGR/quh+nwFFH3RbBkisTYP4YdMegUxHERe2h0qCXjYuHD3CWZAI/O31Kqdf
 oXY+HPl/IGhuk46/8EWCltC9zXFJvdU2g4auTXraphcjJgJSpy/Y8+jBGWmnk5fzaEOt
 vgy2jvae4hellq2h/6fNn1TnaI/bhCQMVhi2Aw/cVajoyqqz1I3IAyq9aP3nzUI1UlIt SQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415639xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:22:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326Fui9p027088;
        Mon, 6 Mar 2023 16:22:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u1dq5yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2alDXDTRzfHMnZFU2Smz0TkDn4MbDh3RqIgDI5IdbtuWftX4OqqOoQ/D/fR/KzAJ8VjZxIP3GesiUwTIIbG5e14gDRH2VB4KEkn4SeXf3aZVtLSUAFtr8bHsM4hJWalyKQ55BCKSmAd7XjcFqFvocdlb8FH+3L1E5NPMlYIC1UP0mt51n2H17wvTuneQ/lTgKa7ATF0iL0LG1HOLzg6BtPWfH4uvTcBenYcDTzHMYiLDY4Do1duxyXvaqOTkllAs3lOu7HdlFTocmXXBj7Ka5aod3CTrgEgXuIJO32g4wjKgvF7uhmZn5QwXh26WI+4JYsASrsXxYIUsZKxttWA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CotqKnVdDk3X1prrVrS1EFkdXw1CdpNKpqP2m/gFs74=;
 b=LljgKIbblpCGmVVk+nQEOV/F8PGTqKePtZdazFVS4DznOaMAkAAjmR8o6kY2F0vzF2YJ2lCYYYqQ8KxBnqelLjq7rtqdTfzAVUUWgRBVmya926SIc6T6qiFXWacMR0PAHPt2Vri5fki9jUXlgPkn+cDGke+p3HqYwfjWrcv38dIYrseXSyewgYl2aJ0+FvMo9wJTBL21uwRU11KeC/8b8BYi7jV9SOr4K1MLofCQlnlV2d68ki6nKdGqTTVomPDeKBhrVgRF6EkFx/KDfJuoD/dlo6SG+zxTxjHgnSvsglOTUujXHIa5f7jSi3b6p82Io0wLRbB4yhaQJuddAHOMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CotqKnVdDk3X1prrVrS1EFkdXw1CdpNKpqP2m/gFs74=;
 b=Tsgww5AmBOQlc8LvOqMCrotc4/HHF2awpeiJrSvB+AoTH8M5jfjWK1EnpotcBXmGxFjEW3DldKuLoKThwpTEBLGeHyXQ+bMrgatgdup+lS7Sn1XbQSGmG0A8ve8eQC2YQVzW2YGSw5aB0fqfUan4y2WWKBF7SDhSX0gsrv3XZrE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:22:38 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:22:38 +0000
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
Subject: [PATCH v19 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Mon,  6 Mar 2023 11:22:21 -0500
Message-Id: <20230306162228.8277-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::31) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d938303-3d69-4be0-d214-08db1e5f001f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyiMcUcsU05SysE2xbuyG1QIVjK9YLhRlSAcrxw1XUyLEmlhWRrvBOt5IhZSxwtSUbWaEItp+mg7nCTf2WJ48jS2zaFELVeU6ODScfWwDUgl42vFhusZ+R307Spcew9ULbbsHWjsuCbfsym91rpnlCGK3TtQZNb3c+CTfVnSk4lvBbmtji7OrB9CHkXFej3JtVhPeyzf+tuUuNzUYY+lgJqQiu7LeR12wmC5aMWo4gYKm8F6rhO7nqTmDiJ/WnlWvZXNlWWO7BfHQ+zwURV7yDoygq02a9FdH1/Of1tAQj1EEIrwPFOsehRXABd1WxfAoKB2mbrIx2ogsZxr/0YydUEv7ao+5pOTRQ4rgOaQSeWgRWH7XJiDrV/9sHftDCytaUKcziIz++C3zpBvZIsuuOC2v2lG8NSvHJ7QCEAjuGnT7I9LkxfqO6UNzQ2zlZk1zRgcgEaBL0B+/ucbfP0M6jZXdBjMpzAxahKB6OUquChsboWOKttUeq2dyVVyzOTwzMxEcut560Zb4kQwLDbIuJZWb9ILKbTTUScr60wnTLID8IkpHGb+KH2hr1zJkhuCg2TXZnrpP8/pN8VR+z11wKIR0dOZaDNSL/L0mo/Tu1j+8LZy0AzcFE/I3nVTg/Tr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199018)(66899018)(66946007)(66476007)(5660300002)(4326008)(66556008)(41300700001)(7416002)(8936002)(8676002)(86362001)(36756003)(6486002)(478600001)(1076003)(6512007)(186003)(26005)(107886003)(6506007)(6666004)(966005)(2616005)(2906002)(316002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mXQ/GzfRIwsq1NNgppC1MlTdK2G6Rh0aSUnznnhFk36845vTpNNGhjJR3JsY?=
 =?us-ascii?Q?qGp8+IURgAv8KIuWXel5D5dIv6IMmbEEYcKhp3CNH5SveQ+cmMS36JQmlICK?=
 =?us-ascii?Q?5mwZ7jh+9MgKdDGHfx0jKgQl/xOrxwScGjUVUNRIFOcaMYLxvaiBmqXxR0IS?=
 =?us-ascii?Q?s6U7I0JPpAA9H78Xup5WmQGKQyovzZeQZIJYb6v86v90Ado8OSYAOHohZ2Z/?=
 =?us-ascii?Q?vV4Mpi6vEa2LemQbHwFkcJCbABH28YPdsT5Mtt4cIbI+Qlk5SNGB0ZW2rCL0?=
 =?us-ascii?Q?dn44M+k/EYFFLRtrMj2iHE3BkANaR0HH5cGZxJT2oTXQKftFuoTa7puZ6gse?=
 =?us-ascii?Q?mso5TD7XeiGM1NRhXO/NZiuEW/W09WfxJ3LIp4qL3kgYfPtachabyqcbEQrk?=
 =?us-ascii?Q?mudGTAnUKPKtT5pNLOl9ujS6bKzvsXbN4LNCSRFuN5zUDtlfWr7mCUL3uze8?=
 =?us-ascii?Q?Z5MozWnNLB8NvC/UilTsCJLPE4Ywb/Z2M8FYflQhj6KgT+WGxu7Lp//iDuGn?=
 =?us-ascii?Q?Is93R3YJ32BXdzpjFyeiC/K9ZVwqzEKGaBz1i4uF9OOqOVEA7lLjyV9N0OWU?=
 =?us-ascii?Q?/d4+cQUZrqD1fQqzcynMRGrVTpKHsGJhvVw2r3G48oaS8oDfhTzKy6hJL65D?=
 =?us-ascii?Q?CJ9rpGGFdan06XtpKfxnT+wacc5uRvCLtLI4EvUIEqG7YJJYp4bbOJ6DsvQT?=
 =?us-ascii?Q?WNoA6YBsLIY0HWqEMLDzkuEtZrZFgyLMbqNxL3MvHhgk6n4Hf681bV+TLSyR?=
 =?us-ascii?Q?HS2rAPvawnLXH05qzDFVWmaJvN6xJjYFpVWsn10i8dbTyjtrD1/ZOK+QG5Jx?=
 =?us-ascii?Q?SckGPAx1wLlqM1ZUmm4BoPbR0qtY8FC05FdS+3fFbFU2icOrIecvW/P3a7GT?=
 =?us-ascii?Q?uu7yqnP1LipBUjo7OwzE2VTKrJGCSyMyc1bHSk9iLcf5+ttfJ23NO0AxGTTr?=
 =?us-ascii?Q?YCu31jNgDvW6ont2bzYHFvqcRVVtQsDZ8BFk65OPC+3JluBc6Q0SF+yED7SH?=
 =?us-ascii?Q?8FmIT/xZET6tZFO1lucaVrGoHuer6gAxGM43tNNUAko0HBfMI2qGKfSQq0v0?=
 =?us-ascii?Q?ajwj7J3JPJnRF29+e587EMrmdNDUB9qVtJ+xQsSJCiloVLZaa7Nc0ArMxr5l?=
 =?us-ascii?Q?9dbONn4Ax4OvvHK8+Ix7eGFy0VNzlzMlL6llU7oAO9/ENfZ8vgA7XPGbVrdM?=
 =?us-ascii?Q?QuOh+5Y7BQk9ZqpVwSj05KJzaFAbtOcP3HOSN6IG7gxkXfy5peE+NqzpFANM?=
 =?us-ascii?Q?WucSwn9sQ1A3wpqZnqBecriXIm1zU91oIxsrv4zH617U6pimE7l3NeoA6IKu?=
 =?us-ascii?Q?ICau2BHY6MGsS2hSYFbdoMsYS+MV2WvrClTfIJTV0y8hW8CnPxNf2qgQw6Re?=
 =?us-ascii?Q?o90K1CVhDpgyXqtMU/Q5vFL7+G0J8TFcKjhmmN50JcqxMNGrmTc49+JM23yy?=
 =?us-ascii?Q?WpfcWm7mt9eMZqAbRTBx/ag6MvoiB8ZDDaX8MrSQbxLdXttOP6oFRS+ziu9L?=
 =?us-ascii?Q?+InuDZR9HjDzi5Ov7ZsnM5HPqjIQI58yBXZZ7o08PDREMpcQe7+yJiW51koQ?=
 =?us-ascii?Q?aN53oX7NpUBY/+/7UNzlRCSgMbxmfBkAX8iAubiYDxVg52nR0Jbwl3Hw8uT8?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UbFzCVoQu1Ikt+MUWYyylcNCqRqEdyNl0P92yVaPs2Re6aoEr31kECh2KCZz?=
 =?us-ascii?Q?c51cKsPCnKZo85ZzVRzBaqoKs0jBDAXFPO4qMWO8GDaPXxjQatSjJNpfdMKW?=
 =?us-ascii?Q?qekbY+3i9+QmRMmMTtYspvKKGi4qOShe4KBhL7EFWeoPTFKPM/6dtjo97cXY?=
 =?us-ascii?Q?KDa+afqD2uXVZrh4Mm1JlJ5nE6dc8BW/F8+jN8HfXXwss0JC8jJf9uq0eJp/?=
 =?us-ascii?Q?Vkx/nv+NRhWqz92ds0y8mDtPZTE6XyNen6+lFujyn8iyu+T3sFANGq4HK+YB?=
 =?us-ascii?Q?vK0n6hLukPfnSuRAQTea61aWdzsPRUcRsyqCxlRWKAfi2FQJFXGzSbRJqtdh?=
 =?us-ascii?Q?2co377ZvN/CqN9b9vZHGDq5/YwMmSLGQx9+eNDEFPm5jw+2PPfhr57yXNFT3?=
 =?us-ascii?Q?uepZH6PPC6LLBRZDjtLkVHPbfT5AFHbjtMvM3cSiOS09H1MLNjW6O/DGteKM?=
 =?us-ascii?Q?321WfwIS/xiUD3Xixa3qyebD4QgRQKU0/Znz+qsifuAxSXQO12deDkLYoaWJ?=
 =?us-ascii?Q?ycg7I2u0ukRFCLPJUL3MiQ/gtXk8OlCHdfISEmkGLp/SLL7oef1tPVfGPI5J?=
 =?us-ascii?Q?GRC3pa0drtF3OxhXmTTCpgrg+9h6lOTQVIES0NZksmriWhiRSm76UWJqaj5m?=
 =?us-ascii?Q?LYIBY8/5x4EYMt5Ycl7KZfrVWft/USDJ+74dM1ywGQ8Y0drJJXeLuDRXTtiC?=
 =?us-ascii?Q?ILZe+kcLLGAhe9aX9OdVRvoEmTYZFq13jb5QERK8tLauasz+aBE1yF6s20si?=
 =?us-ascii?Q?VYYGHICEFEduPSGMXythZj440q7dHZcXiPsLgFppWwIOF8FMLDfXeVcNJ+18?=
 =?us-ascii?Q?N8LcwX7GYs9VAaZJ2AEk1Ym9xrtso6oehyVAYbMEIz5uiNHdYyGmyEHFZQC7?=
 =?us-ascii?Q?dBRL6JQbUSBZi8hO64sjYBp5vkhhMbB9a0Fy3XgTxJjXP8AF1KmUloXhET2A?=
 =?us-ascii?Q?8ScAzZLVN229yFykXUBkgq3w0wMIaCN+041YP4Tm4yz1ZmLb724Aki1B+Nh6?=
 =?us-ascii?Q?UC1c/+KhbFt49fQNY60aCxFYQCEyhVipoTCx+9MdyqTlAnszp2SDEaRoy/D5?=
 =?us-ascii?Q?9Lb2zu8jUdA93x5IEjLU8bMTsutkn3j5yMEovxm4Gp8Nx59tuIJ7U9WeIdHf?=
 =?us-ascii?Q?Bjm64Si5aO4+BJekmwnj5bXwQsu/PWqb9lfovjIVpyidNkthsCcNkHo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d938303-3d69-4be0-d214-08db1e5f001f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:22:37.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oi1eKqmtNpN77kIZuuIlysIlgsscasug/ukQkTQSbCgXI9I3W/Q/tnpGxrW/Yc9MxYhpYoER/DgFyZOx5hC5Qvl7NgglIC9suev06fXYPZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_09,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060144
X-Proofpoint-GUID: E2nQlhAP8PNbIKA3qfgd-qHTNSsgzxXI
X-Proofpoint-ORIG-GUID: E2nQlhAP8PNbIKA3qfgd-qHTNSsgzxXI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   cpu and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v19: 6mar2023
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (7):
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize cpu changes

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |  13 +
 arch/x86/include/asm/kexec.h                  |  15 +
 arch/x86/kernel/crash.c                       | 129 ++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  49 ++-
 kernel/crash_core.c                           | 320 ++++++++++++++++++
 kernel/kexec_core.c                           |   5 +
 kernel/kexec_file.c                           | 187 +---------
 12 files changed, 577 insertions(+), 203 deletions(-)

-- 
2.31.1

