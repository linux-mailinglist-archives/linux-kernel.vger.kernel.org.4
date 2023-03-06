Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566996ACC3A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjCFSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjCFSOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:14:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722932CF2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:14:19 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326CxG2B017856;
        Mon, 6 Mar 2023 16:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=qHm4Qdh/f5x/LfFaP6306ySB97O/QRQxfBSmKTnF90o=;
 b=OAHwFF06UUoX6W6pTky3mqRoAjH9o6RRKMcvwqt5W3EvE4ZVJKh3CEZMaKFTD2qocRti
 PgGF8BgXsN2zMLDC4nq1sbSyz9IEoarXc4h7BWt8QacsCvCvkmnBCHvGhSXYPQrESnX1
 ZKcYgm3g8VHo1RgaHXxE1m+dcD0bAtNWn7Hk4XmWgNgR1yVVEd8J5zy7Nw3s3tb7+xRA
 Vswgtm3hTDYwC91utDfyKB/T/cHXJsTOAXFR+IDiuM6o1KHkPFAucFAMJ+JYJnfPQWDK
 Gi5hP97sS/WfFv3rifss0LLoC6tTwSCl14+d5g89BHnuo5+RTsDq7jjMP1SPqOx4c0FE Eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p415639yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:23:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 326FmI8f028608;
        Mon, 6 Mar 2023 16:23:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u1dq69t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Mar 2023 16:23:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1k9CYMomCezSxR0Uhks/6hU9xQEAous7CP4K1n+Bt7PFAPutUfeub205AnPyFHiqH70FI9siNckemKTQpmH7YKn+od1qRKj5Hzr7t4dl8bDreNq02aBhqf6hWBPMdwpn9hDRmn9j8NlcAQC43XptQkJ3/vwMv9Mln8zYd01rir21pV2wNiyN684xa1iCeS/CEiNFiFWdEf3288HyxUkSsNUvvbnYMv+UpBz80Nxl6/nZufQI3Y6iGy+k/gFEVkqBwXX6Z9QLZ3D/E95SU5LaGLXYeC/wsW1SM/Lvw9KgF2XLMPcKWV53Tlhk2NVeJqvpCBWjOezS86KPy0+qKo+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHm4Qdh/f5x/LfFaP6306ySB97O/QRQxfBSmKTnF90o=;
 b=eoOpuSHaFRbGREBG7Hz6tkJOoNkS6U2JiJUj3WDpSF7TQLsYCndGn7rEwS2KbS0+xRpatAKcX4h+LBRtjAENxF3+WPzx26fL6hPMJdLfx9bJB5YyMGRnQtxGXv1vCpTR/QDS92Jp2HlfwF2HFJUfIowjAdZPHnkCRB7ecTBxpcyQSbiGFUaGWDabErLk7CgeWJ0UdFUchitT4jIapgIz5/q+Eq8dgHwiDtW4IJnbeHN6Pbiwo9DkGSClDA+ZWyk7TaB3pQOoivDvrKBB0xzN0q1xibNii3w00g+3yF33QFj+X50sAH7wnVSQGSX9RsxV9FkyiEwvRGVaqNGSb7zrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHm4Qdh/f5x/LfFaP6306ySB97O/QRQxfBSmKTnF90o=;
 b=GqV6Bilty2QeAf1yufDQblAwLBvdpmx17wURGbkAImfYllf/Ds2eeRHtSClMXVeZwBVk1MEFquk8ue2ibSdDDG8hslWjiw2s5oecAlFIKsAqsNU4J2PZtPgQQ3+3hKeK81sPeaaeBz6slIzKYRqOclr6ebLR/WSPagmxlj59pwI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 16:22:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 16:22:54 +0000
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
Subject: [PATCH v19 4/7] crash: memory and cpu hotplug sysfs attributes
Date:   Mon,  6 Mar 2023 11:22:25 -0500
Message-Id: <20230306162228.8277-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306162228.8277-1-eric.devolder@oracle.com>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CO6PR10MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a7571d-70f8-4c4f-4b8c-08db1e5f0a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wlmUdRp8XOB4gTZlYwH9mEgPvl9k3siizImAeyZrVl851dsqDMgcFT/Mk92R64edkl5fMhB1xg0VpYEbcWecmOdM0bd25jL/8zIqkQc9FFo4/3rJLiKvyjjzOIESQleHfSQMKGgU5LUSWlJV9LYU2FdBBmqLz+nqwla30klGZkvJqSZJP2DzsJmRSUiHGV/7h5lV9+/B/gjBiE+vsRCUnbMsRexXVd5q5jASErQyMEIZAPw/IDBYKAjK+I0xDIqUAKIjdij4OrcJ0ObL6i8Um+A2YsJGHvGA2wb4B8iPzSrpqfRXwnGaOfqelRFw20EAnxLGXk2zBUOCcb42/4w0vUeoDYLtL1H8vqume4S0MDEh7YmFvFIvJfDGEYGZfU2GXsf987hE584huafxnGtH1TZwoYrdtQR7MAQBMiJmWg4dHJRMu7023sS4E1B99zoxsq3BRVfI497Jytw5D9nMVK0yZ360lJM6zZ1EPjFUy+2YWpjL4O3WbWcsdzFKbPS7JxVf9wb+yYpV7V6b6uy1nUR131Bpn4UWq0svH23eK5AFIY/J/Yuin6AKsZY1rgSnEk4WJvVX9fnigLW9eKyjUlGfvI17cIsb2hsLXRlhkGxCq9NoJcwNt35ddeV1dX+8npZzqSt38cDh0M68dPTDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(66476007)(8676002)(66946007)(6486002)(478600001)(316002)(41300700001)(5660300002)(66556008)(4326008)(86362001)(36756003)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(38100700002)(107886003)(83380400001)(2616005)(8936002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EB5r1YBlgaOYH+KJALotwjPROspzEXzpEojjF1qgnsLV29kQtrqbe7OrO4Ii?=
 =?us-ascii?Q?VnLsbVBt6eI1iDoXyukIEEjD80u5jM0x4gXAxWw8FjtjnJK7L03zNp4i9Deb?=
 =?us-ascii?Q?AneODzOCtnLTR2LySgKdzjJybzludiSRCE1/vauETDf0L2wv1K4rdcdQMDaa?=
 =?us-ascii?Q?CMIZWNVm61UuzDnPyzF2M4A+iT89oMFpJrOOv60KVk9aXr9c0MwAYt9MFgpr?=
 =?us-ascii?Q?owyaz9ymCVrVEKlWfSiiQS1C6ePy80UJWIDROUHUDcMsz1HD/d8GztFZ+08C?=
 =?us-ascii?Q?3L7NS6i8lYqi+q+s77aMKsXWaw+mdTKwEXmh68WBs4UuiCGRdSVyiEtDyCJ3?=
 =?us-ascii?Q?3yVoQyQNyXasm7IzlVaBP5n7WsahFAgX4E2mhlDqLNI9xaWvDlcCCs/0pRTA?=
 =?us-ascii?Q?besGrZt7mxTPam8hnb0mebqMhRMxM0bIFV+u1juZc0tWw4X/0BU7bBEM5syv?=
 =?us-ascii?Q?8BKdhmASjMCeGZyahgw36r/Mdzcm9BHF9gDDAlMYrzr3ncTwix1RlqJvMmZh?=
 =?us-ascii?Q?iMd1BH/cXGcuak+kqO14guxrFvXrPjY1j5rmPEoQv+bhqBM3C4koo/OuuJQa?=
 =?us-ascii?Q?FZ+NXCAaIuqK5EPeh3/nuOJ9APM8Mhz0hGUvDqA/hGHWogQdM79kPpAooWdU?=
 =?us-ascii?Q?LtyEDSiywGnL9yL+yK0VUqA9e6hp3vOtR2dZ1x+lTculIfRer2eKl/bIcapP?=
 =?us-ascii?Q?8VDZwsul2Ii7lSHH39/3JkQO//Br+ZjhL1j//EYyRfNc3mqfCbM/58EO2gOU?=
 =?us-ascii?Q?7AsFxqp6IgLmsDz2byZIpuwSET6YJc8l6xiDCKhlmoHhCWCnFzUmLkmcnngy?=
 =?us-ascii?Q?YtxRru4E5B+k08olnm+oJ3AskAR6DtWXL8WYNG8MNQ0QwZtg9+Z/PHFQHVI4?=
 =?us-ascii?Q?KlPdxtGD3TFcV7M3PXKqD4s7I/7yXJAFScTnJ/6Hi5sl5/h9FUXhtgn83YZo?=
 =?us-ascii?Q?9SaghHgUOgMBsl9pvzax6HAubj7zci7v6wpxi6drYt6/iqj0WS2jGa2qOc8f?=
 =?us-ascii?Q?RAH97VoAVtf/TQDa+At9me14ETUHCL9/rbhC6pA27oQrtN0sxz3FEIKfSMlt?=
 =?us-ascii?Q?G07ZDYi02tL/ACoM86/cRb6E6bkuuCoVoVixWAg90Zv2I6xoGHBAUJN4iKat?=
 =?us-ascii?Q?dU1/mRZQtC4bB+BJTXSY4LVtw25sSujGxAy/AQr7q89D5cCIGlpiIYn5OnFD?=
 =?us-ascii?Q?WitzwqgsyFP0crkDfztFCwieTfCCfugUUx/QNxCBlcq4ukAnnSPLghqxfMFp?=
 =?us-ascii?Q?JGEQIGWJD5QWGPyXAzWqWMQwwtOsqhbmdxvdg596NBkW5vaywUsPQVzitfR9?=
 =?us-ascii?Q?QElDJko8Mq3uvXONQ8ODDUz6UEw5nB1bsaNGNOlRSoRSp0AXTmPgZdJdCDZc?=
 =?us-ascii?Q?sqzNvZHukULmvuRcfDOy1DWx26bWM9TMbANVQlm8BDQtQ9G314q95nkfbVTq?=
 =?us-ascii?Q?UwDGsUl+rJWJSc4p5lgNFyeYJMv8I0DKbsSKCFGkgI0ac29sEqdc1DHPb4gP?=
 =?us-ascii?Q?ACYKDIvt8w9z5Gb6Wd3UPKLWUQthmdkUSyrPjS8E1yQxBA67/+5tcub/mggs?=
 =?us-ascii?Q?GJinG2bWJvmYLMrNnExjRqWzxoCiLWupFLHBneup0OgQyFcThRRFdL/yf1BF?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?60MAULtsSWBlVnjZQSL4MdlVDcp4iKSfm7o8TZhkqPPGn9iXKdMhKX4k29Qi?=
 =?us-ascii?Q?0lFrUNizyPBHcGRdJx5zXblG801ODSW6c0evx7Yv9sECXLL8nuw/Spc57WEA?=
 =?us-ascii?Q?uuEMyidY/0zOzj544sqeIeSVIjVKT52eRrRox/MUxHVEmrp8h3g72NAv9qAz?=
 =?us-ascii?Q?OqdsUwBD2+IvKjRZY7XKG6XFWimXsyicPrYarvVvNBWqSG/z/SZEyTwxDNru?=
 =?us-ascii?Q?bgAHGz1lTwgYRmB+656W4D/cl0mY4nPTBf6MejiBKzOQBpwjehd7gJTr+niM?=
 =?us-ascii?Q?XptxO0rZguEBchQnoc5LxlCYYqRRVNHhSeo7L+yrxiMljvMXRImmds5laBX2?=
 =?us-ascii?Q?PYkIqL6CCbuc88wFUzSewbkttXPJ6QNi5GbSjkw5TC2PlrFdvVpyGX5160Ii?=
 =?us-ascii?Q?uJ/BHiLgHZKUqBShOLliV4uWwZ/q2sr6PZVd/J9fSCATSex9WAynCdsYSTXY?=
 =?us-ascii?Q?HGEvGudauybD4VZikf6A1tWh2pbgiZReUv0HsjstRZrQV7q0mKjaPJWNYHnR?=
 =?us-ascii?Q?R5wVrCik9FY66cH7VVVOhSu/vxXUYpf5lXb3+vuiMcQ8hQexeQDtPTkYIj39?=
 =?us-ascii?Q?380j416DTpMkgulMsTK09ZcIMWEkL3onslGDZ09S7bTgfOHNr/UvzitBorhw?=
 =?us-ascii?Q?ttaC+1uq3r95BpRU3txGkFXVRvN1RnHuN9WGQ+KT+UgrjmrJsSLDKIKA24F5?=
 =?us-ascii?Q?vqOQGPCvRQVbEmZCCZ4V/8SFjiV4OREdf57sZwcC+CkmuiTHQaUrmXa9fW4Y?=
 =?us-ascii?Q?IpxSecJpKkrP+r3bjjwYovzf2LLguC9naI+PbmegkIz6GjSNG7X7EVu+/sjN?=
 =?us-ascii?Q?i7D6uwmzgXg1eEQi45dx3acIdfMv+JyIl9YH+YaBUFNtjaLaayXHHdvWZHy/?=
 =?us-ascii?Q?WyYnlYDvJ6flT2bUphEtApUi8EN/IIHrl2yJe5RUt5bRXAV9yNocXUsUM26z?=
 =?us-ascii?Q?+D7wdycxnmIsEIqSaP0nYr2ftL5nH5EFzQMqSX0Ev45eLoDNJh4YkP/9wX6m?=
 =?us-ascii?Q?qa+8zNBA2xZ6wLF3jO8Ug9IvtXjdmmiCSm+eWBEDnUKlsFWwdGN6CA4GxUlx?=
 =?us-ascii?Q?8+guGwXPb+ytS3LMEbay0wxrswPwTDo76Uq//Xq2j25z1Sz+ffgdTjpJZ9Bp?=
 =?us-ascii?Q?ynv09WjsZEE82d4aN4jEMiEURG9W59XZXGuRaYHdnBWfQhkA3m0synY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a7571d-70f8-4c4f-4b8c-08db1e5f0a03
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 16:22:54.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWzXnXJC4PF965AVGQeKykPU11FLXxvSZnF4CfdVN6aBjFH8GstuY0Q1QlCBszm2GFnH5WU9qktvrz2AbaZxJPDLN7PQteCjvGOn/L76PY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_10,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=965 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060145
X-Proofpoint-GUID: gZTZcFJKDafMaPLIYcz36hJ4-YOOaTM_
X-Proofpoint-ORIG-GUID: gZTZcFJKDafMaPLIYcz36hJ4-YOOaTM_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the crash_hotplug attribute for memory and CPUs
for use by userspace.  This change directly facilitates the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel handles updates to crash elfcorehdr for cpu and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.

Cpu and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule will skip
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process cpu hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index a3c9e8ad8fa0..15fd1751a63c 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -293,6 +293,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index f75778d37488..0c8dc3fe5f94 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -750,6 +750,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a cpu hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4..fedbf87f9d13 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index fe98fb8d94e5..a3f37cb57d79 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -495,6 +495,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -894,6 +904,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 2dcc4d65f5a9..5a0369b14d09 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -508,6 +508,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

