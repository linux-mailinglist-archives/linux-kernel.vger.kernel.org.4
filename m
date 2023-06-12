Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDAD72D305
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjFLVP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbjFLVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:14:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF22976;
        Mon, 12 Jun 2023 14:08:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKNtED003133;
        Mon, 12 Jun 2023 21:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=xuGX5VAufC9o5VNhQVzEJroQvU83AHxOwU7kTgRqNnk=;
 b=ePrlhCffLV6nz0kYKx9xaVqVvMspo2/YPI0k634E1ZfQmw0eL5TwAL8Eeh1/pNeMgVmU
 xib/iIqFhD9QfldO75V4lpCbnPR5VEkD+uz4XvvuE3eRH5VXmKXaPekQXBdh6OTdlaRa
 ISPBojU+880eUR0DNgBa21BAVarHkgaYzHvIxUYt9LFNwCYEiFdvjPmEK/vgdFF8wzZB
 zJmv0Wjs/EECmkgp3kRcEk7VoeM6RX9SPMM3DpJrD9UaQCmQr6UKMC4yk9QXWFKloJPJ
 5TkiQiZJ6gHgUrC/zEkpfoqdpXI6FyAmDWtdAR3sCsuoPlyj/RyBrfoFscuWv82tC4Kh SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdkv62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKU0X8008319;
        Mon, 12 Jun 2023 21:07:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm9j9p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0DtPhQmV56BZ3DoQfoQdUyqNUQqLSjph+MEXWqeeiBDulSO837aOwktOEydrKQGSF9paLFKaIqBRSZpc18E15Urd9xIsq58UvV7cW8TxJ3HnBj1O5DoguOHOs+Ffw1JKLXDEQdL2U/7Cbl07P9URDJVumI7jbWOoKVyGAXhSMK5sTVhRRnlz1vYpTBtFnUGiOgruItnXgKy2Aqn4oN0C1QTSCE82j98bpsflmpLuClta7Zoinjk8SsA7Vv5oLErQdWNeUkigxMv0GjjC5Ktz/iSgpbCtbeRzxAFlXXPxQnLhaYbyHnhilboRIjdI+/QMtrcnFSW969X6r4HIbPklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuGX5VAufC9o5VNhQVzEJroQvU83AHxOwU7kTgRqNnk=;
 b=YdXY4WJ5K1opytkFag5VirbCCGfLQchij5PiYdknPbWDB14VMrPnGmWqOrzvJRL8GaZaMyCbGFRNiETmL5WLmPsLpLzYbc2+MNJy0ZLfe/h20YyO1hsBVE5v7eVy3arKuITgX9daJKU/9zqt5+siQRQRmLigLhhFRKUInOeMQGx2bdQ78AgD09vB6yOkN3KG7+vN8UNtVgDXv43MUm2W+MbRqLxNsXeLGX8ZyGIHhCWsa+ptoHW6HKZdqA/vkI1Bl/7qUjxylm6SeppXHGHnhtoOKgJRJtIu9Rb2VvCVbtSGHwnf3CE2UJnU10BvZ2tYox7YVLYEqfVyLTo5ppZyCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuGX5VAufC9o5VNhQVzEJroQvU83AHxOwU7kTgRqNnk=;
 b=hi5ONUpQFyelxkAZ5sQWOivJ0fYKV7yydmiizbTOfCJ/JQSEGkPnG9vfLAnqZRTcgWJZtfAoFffay1NbWeW3yREnhDX8GCk3y08MspspX87c8HHr2AP09D8lSlyJ+LqSMGMzO32In9arVjrkyXQDsv8iPpK6UZXdmkGtMvzD75M=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 21:07:43 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:42 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v23 4/8] crash: memory and CPU hotplug sysfs attributes
Date:   Mon, 12 Jun 2023 17:07:08 -0400
Message-Id: <20230612210712.683175-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612210712.683175-1-eric.devolder@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:5:60::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4371:EE_
X-MS-Office365-Filtering-Correlation-Id: b38c7dd6-bb28-417e-e14a-08db6b89101f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78PRJ2YgnxiBNmNLxTq9OCLteZgzVkqkMCnmLnPBF4e+oFvm0Ssk///gOvgnYwOUIm9MMUDKNNVUlxxkBKAhnU2mgLhZ7mXWP1b9SyBVeY0nwdWGPoFmNgr10cSfRWdanYZedXaIDOzKzgVX0zKyswqWDgO/Kvv3pcwmwMabl6YHWedfiKO1qc9cYS0bCUYmrphghaWCo90+zcw71+O+HhWKQAh0stCjzeXbZxY4u/Vviha6oIrunLWCXIHfUwlQYluRmcDmHafDIG1LpXJNyLC2c9u4fdiXGyFS7i9w5Gj5A+dwlPdJVkOlsl4Yz6GJvAZOSALU+uxNasJsb9qGzvfyNBVEroecw6rTt5meD40E9XD+5/ttFD/jLg7QOi1JzFy7QAeKj3TirxrYAKwMDMn3MoEs50Qvr8N4vejRm3SnTlFwPl0myF7HdD2EJE0pqPBgA+h0nETKSAD9vOmK9vK/6wHQcKxqPS/xqb6uM3+j7JD+3EK438Bd4+Wb5xBCBseUeyZoJt2m+n4tJVnE85wywTvKIRq0J8clNP7sKp82lG3qK9OzSSRu12TlB6OzK2gfrpQGNYOPuOeTsMtQneMj8my3KXrBryLaW2e2tLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(6666004)(478600001)(7416002)(5660300002)(7406005)(8936002)(8676002)(36756003)(86362001)(2906002)(66476007)(66946007)(4326008)(316002)(66556008)(921005)(186003)(41300700001)(38100700002)(107886003)(1076003)(6506007)(6512007)(26005)(6486002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qq2h9hbiwQTBpfuNBG1q0J1DaUR2Zh9mK5OtxcWmcgc0FjFJKNjMEka9w6z5?=
 =?us-ascii?Q?DmWCatDtltPYYE3LBOJMIihSJIWSasg3AdtNX/ba/ojJwl/63Z8TDY+KWLBR?=
 =?us-ascii?Q?CDTaqHyB8SHkIOIQZIOnAFfDMAw5ahhCFR2ObRJVmE4URcBpJoZctYUN78Qb?=
 =?us-ascii?Q?C9ZY2NOC4ywjBlz5DVST95AkkDo+w3m61jc4Qi7YeN1f7estS7R4DoAaAkYP?=
 =?us-ascii?Q?/to17U5JMnkpoyfj1jWFwdlStw41cTTNybaSt92DBfwhi3f+IQMe6cyCxiq7?=
 =?us-ascii?Q?k8GUMQ0uQdIwiL6jgAczKxEH2sDvvzyqC+FHNV9TDj8CvlFi7fPqhX18z+vH?=
 =?us-ascii?Q?TkuyQ0cw59SxSN957NhpeZFmMh/aOpdHqatutaP7gMLa0sKS6cd94FP5vx5K?=
 =?us-ascii?Q?GkJ+hGRWMvszxROpjUuLDyhjncNpRQJVsY7/JtRhj4HIu9O9D079Fbb7PbtZ?=
 =?us-ascii?Q?y3xk2tdTklMt7nKK6u61/Tso3ccyPV09HGyronTjC1Qc2DGjHkgBk5msz0aD?=
 =?us-ascii?Q?s6+z7QQXLvpH3BUuvEHW7TBvTMZEsWZo94yftyspab0c+bGUKx6L5YA+i8S8?=
 =?us-ascii?Q?23Q93hqj9U1TnfjPtFE9klAasmnRa9BC2TjVIVAtrPRxqWnmiNDbTuaRwgZP?=
 =?us-ascii?Q?3hrakABJopkeFzk1xdAoDuBR5m7SE8U9xSqwFeJcZs8eJoUkKOZUsoev08bm?=
 =?us-ascii?Q?MhVmBAlPpy13irn0SU7MgMfsIZjFYcXkjLNGBXRE+ix2guZ2QbXLfcKZZuW+?=
 =?us-ascii?Q?gjS5xT248d/vnl88bP2wZ0KpEwJgA7uzMr1yDTaqhWHIdtOLkH5eio6v821r?=
 =?us-ascii?Q?v1dGyCdpp35OlKIJsoVlLAIEBfPzyf4WsbbyVXVcehZt2z6JAow752pmJ73B?=
 =?us-ascii?Q?GitNwtoqksrKsl5/+pzjalPkqi2dGk5C9BwyIyNC6M6XMvoHxL12lBKHsQjw?=
 =?us-ascii?Q?Yo+89Ne3PvasatmbngSmvE5XOBhIAe87hNbBhNGOirV0/97sMJPIc46iBq6W?=
 =?us-ascii?Q?IYg3nPo+yleO3PRwsFeiu285kc8zmvAXnPjIjP24tSXPZyHH+1xbgW5vcUW3?=
 =?us-ascii?Q?PLiNRXvN+8Pk7fKkjwIQKXjRAcYk8E94b2G/gZBhYBPzLGYCfOFBrcIznOZw?=
 =?us-ascii?Q?aZTSgDD/JZlmjUEgc3XdGJMQt6hCWilzwvzyj33zEZhDjCk1tJ7SetDv3lUC?=
 =?us-ascii?Q?+Gdiprsye6APNSlT5j76tMcoVIrC1Yxz75Y7WZDdUjyuMSBw3ILV7cHt0sjp?=
 =?us-ascii?Q?laJ4KGoKoLgnyOD7+mn92dogXi3zjCkwGtJKVQnWxyuZ8pcHcCkVlZ1mtLxW?=
 =?us-ascii?Q?to7XEns+VDEHZVkop/j/7/UGst94FwFQr2Vbil9HKArfXvR0gXA31o4lEfq6?=
 =?us-ascii?Q?2WpZpx81BGXP71yysExl/q1q3V3ik63CZOfpfoJqlKPQrfn4XYzymr+G49iw?=
 =?us-ascii?Q?BR3+9iBARFcvj90D7ARYfCHr8Ld1t7iZHybzohvbz6jvSWjrQR5CiYYDDFmL?=
 =?us-ascii?Q?vXJNMHNQT7RzK5xK2tsXcodrB5vb+nG1MSLsRZeq7c1ktj7UY6nNu21fuOrm?=
 =?us-ascii?Q?+Gu5y25OWWmkxENE9SuG8xGtDKTiTztwWbtzlwVbPVSnQBPPq0qNM1W+xx3c?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qRP3s9J5Ffxqc+Jh89sZ3y2Joglnus8y5p8mYqgUgEywGDu51J2pIGH2i5oC?=
 =?us-ascii?Q?Rhl+cFjUFpoGswniU66NlRdgY3LY+2w5j4KYSouuNZBaqvRbvz+W48YNnqSS?=
 =?us-ascii?Q?4Iwa19NLXjnyWPfRuZSS7dXJS/DM2AWVfbaDry3C2dnx67kDOwDnZ5/lb08X?=
 =?us-ascii?Q?VHk3X0s4VHb5oUVtfxoRflhS/wav/+x/668jzS5W/C1+QeB6AADff9ThoOCj?=
 =?us-ascii?Q?5ZvIbYyxjBoa6TdH/ON/vq5LfJ6xugPvjpxeKobb91AB9lFlUlbNC230TpIf?=
 =?us-ascii?Q?58rWG6wAzquQ/Tm/W99i9KMnyKd98zkTFpcyrlogdY8yLbsYi07aKL8VoO70?=
 =?us-ascii?Q?+mfVafG1eZ54TM7cyK2XG27feoJCmvTzSGlpxroMpGhW1WWBDI4KTHYL9zFE?=
 =?us-ascii?Q?pjveYJxLW/YZOXde6Y++kxBPLReqTqJt9ZmbdNjMYuJTTFSWXsZsNRs/EWQS?=
 =?us-ascii?Q?Z7/Gp687Krh6o16dzCnTwNAbR2fp/orywOYLpoHV0r0kL02m00r6NGXz3Btc?=
 =?us-ascii?Q?h/OIYACE/HuarAJmL/0mr3v1ee3pOso60u1nXKgofSSh7bse1S7pyi4Ve84w?=
 =?us-ascii?Q?eM2RbVUEvF6gc/3+RZ2NTcwSczybdi23UcvYfVt0WuCkVeaCbPsstqR5Ddqt?=
 =?us-ascii?Q?N57bl7z805yYLrhUOHUEjgXXbgttprLwH0VWNCVAnRpfgORlqIxHvfC1U2+T?=
 =?us-ascii?Q?nY4VmNlEB46o+BKac298vhubFqDXDMyp4H167/OQ0dsDPg5kdyjwlSbbeRVP?=
 =?us-ascii?Q?3nYw20AWcfWU6uAdiGd2JjwdDJpoOLwPqEBZwe7cv2uIt5wsUPb7atYmwLkG?=
 =?us-ascii?Q?ce1OJzXXfR7G9+aGAsTTfzqUw5LT5GNZKRQe/Eicq3cIKSA2K5bS1OEHOUIf?=
 =?us-ascii?Q?LwWFz3jSOokkRu0wfcXvOxpJBXqc1aGmKbB3wnudObxwsdXr3oAB03GkunAN?=
 =?us-ascii?Q?SwQb3YfEAzoEY+qb69ynmXXAGYo/zV6XjM8L6Gi6jsuWSBVD7rzbFlaVqq0B?=
 =?us-ascii?Q?naudjgZLvjm7JGprP+zWHg4a2oEGvGjoHFm7aB+5Veq4BEWCbmng47l13Fuc?=
 =?us-ascii?Q?5EzhrUK/vrjguPwLQfztzeQ3wsZxRymA6D8GR8rYfxk67MWm1iitPIUcVcLQ?=
 =?us-ascii?Q?F15v1XZP3bsF/RLtO4ZAYx/nBiZfBECjGBBV+G1rUyGaIeKwewIJgPrreFaF?=
 =?us-ascii?Q?oGxXq01OmBqfTUanN9af6ajI40/emd4vRmRGiqohu+WhWYs3IGABmWwc+WLV?=
 =?us-ascii?Q?RKI7ZApdqFrYTTVDvA3l4C7O0j6xeWSKWqCIY1UaAKb9sS8Ah5JDnePLiuh6?=
 =?us-ascii?Q?kRhcKhb9XJ3lJL6N5g2exxbXbqmG6AGyETkx6Ob3z9MWvLcFs68rI/AeebMO?=
 =?us-ascii?Q?57DD8QZqkUEa8Wstg7BgozjNgyaQvMeCGUlJBZN10SzdAzgLf7SAlgJW78k4?=
 =?us-ascii?Q?3bt+ZuYd0Ic=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38c7dd6-bb28-417e-e14a-08db6b89101f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:42.9069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri6EsE5JARBEhIO1saPfP5X/AA6NGB43Y0BaRIc2eRSD6/zLUU4m+QuOJHDH8WhDLeTCVAJn/hEidNwcaABWOLplPtVLAPQmq+sbmKmVcL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120180
X-Proofpoint-ORIG-GUID: d_jhI1J6LcfavGSSKTyPs9UTEd3feC9n
X-Proofpoint-GUID: d_jhI1J6LcfavGSSKTyPs9UTEd3feC9n
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the crash_hotplug attribute for memory and CPUs for
use by userspace.  These attributes directly facilitate the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, expose the crash_hotplug attribute to the
/sys/devices/system/memory directory. For example:

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

For CPUs, expose the crash_hotplug attribute to the
/sys/devices/system/cpu directory. For example:

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
instruct the udev rule to skip crash kernel reloading for kernels
configured with crash hotplug support.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel updates the crash elfcorehdr for CPU and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above rules
test if crash_hotplug is set, and if so, the userspace initiated
unload-then-reload of the crash kernel is skipped.

CPU and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule skips
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process CPU hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 1b02fe5807cc..eb99d79223a3 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -291,6 +291,14 @@ The following files are currently defined:
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
index c1815b9dae68..06a0c22b37b8 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -282,6 +282,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
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
index b456ac213610..24b8ef4c830c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
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
@@ -889,6 +899,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9903dd48e24..6a8a724ac638 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -501,6 +501,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
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

