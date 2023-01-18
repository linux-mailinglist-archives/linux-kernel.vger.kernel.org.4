Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895BB672C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjARXX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjARXXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:23:42 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E566EEF;
        Wed, 18 Jan 2023 15:23:21 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmjWK006391;
        Wed, 18 Jan 2023 23:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=H7Ol/2EYSv6pG/a+T/kORC5xR/HPZnoEs5L5gT6SeMg=;
 b=Co2GJAPprdf9PUkOM/3adQjOP3oWnXh0MUGWyHLjSms7Ctq/rMkDxV7/BqBGEtDhp3ta
 syydRJX/k4Aug7LpKYMWLyHiECo7io1H32wiw0yCgxHEySVjDMSDXOOZhuvSqEpKs2u8
 iAngAHPXrbFkr8efhOvAc6bz/e1TRjeQd0TdnLBrhEhjGQuh5jFKOgmvkp9EQ6O0Kj9I
 nUk+ok7lj+JGMBs7OUu2Q4xQ2P2xAVpOGTXWBPFSQupXYrgtYUAFK1q5NFidwFAVAjvZ
 614ZYrmAvG3TFviBUwDd5EvY/e8ilCMMo6gDAr7zMOfI4yb+x2nD3uugoZHJ4oNP7xds Jg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3mxt8x9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:23:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMgHeq039639;
        Wed, 18 Jan 2023 23:23:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n6r2tmxjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:23:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le1PqEuoH6aeQY5rjbfMwDZrtIeDfO7O9K3L8EMuoi7f/Np5avDsiWCu4QMDb1Fi9KQIYCA65hmArFngkoQqsTNDcr2J99n+XJY9bTb2vtdaxluGDCD6gjvAI2CrV5SusgPWgYM4o4fqe8WNzDZKYRioqNbg+cR94T5EwhbwdX3JoO11ADFzEjWBxYZDX2RumPrYNTZTPACsB+X1hFajjtpNvUgTaSd1HGpLW+3Q3ie0AN9bvCc48ZAGo/un2ZFL7WZydeaotLlPReVgSaLUirmj3YDMUBq+PzFj4UScoepbKU1VENrDCw6MYPmLDXkMM8r9Cr9mjs7iDSL9QU+RcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7Ol/2EYSv6pG/a+T/kORC5xR/HPZnoEs5L5gT6SeMg=;
 b=oNYl3bFbQn93mg0QZrIvRGBj4tE84e3aAqfBhqiCB4208K3CXaWVmaOTIkW3s1cM8JG9ZYuV95lHWh3wPYgODjYVCOKQqWIyx8XyYiQPSLl8k4rToUuPRZEFtyjeEyemPevEe8otb6wmh/ugeatRYRdVU8JA9eh4KOb9ri073SOi2yC7vzffdhq8sI92xZhDbveJRF9OtITYxXJrQYxFWJ7jJVkpPZSLIH6liZjS40qpX272t9V1hZDYXO/b64ZK+5JmBGXMsm323u8SBHnfbvzB3TMYdxj6qT45VyMfU3r+S0vmZYF2bRdvEaqQsxmAjgY+1SABqVckZFOGpOO23A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7Ol/2EYSv6pG/a+T/kORC5xR/HPZnoEs5L5gT6SeMg=;
 b=aAvZhMMLb7saO2Cd065SMD4ACURAZmiG0yf72/TqT5Z7aPi+hCheWeVKtkQDxDSqEcjt4vdZGjh1Gz5FdSJFqImGEs/E8T4otBZLpM/V4Z5piM9YOLFcqQvNSatb6nBy1JuUJZ7Oc+Obar8tb9tMzbkl02+u7s4sNBFlWjMc+Z0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 23:23:10 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:23:10 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: megaraid_sas: Add flexible array member for SGLs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cxjqvfy.fsf@ca-mkp.ca.oracle.com>
References: <20230106053153.never.999-kees@kernel.org>
Date:   Wed, 18 Jan 2023 18:23:06 -0500
In-Reply-To: <20230106053153.never.999-kees@kernel.org> (Kees Cook's message
        of "Thu, 5 Jan 2023 21:32:00 -0800")
Content-Type: text/plain
X-ClientProxiedBy: DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN6PR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a88ae2-cc3f-4201-60d0-08daf9aaf655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAanv/DUpKILiKg8QOfh61lX0YZTUEmplrgL88TBszuQiKWcY/uwD5YscFDBtTtYhLQcCeCOar2TDSZ1QNsTgKoUZfX90szQJjh+v2kAm1vLAZ+hbCCCFBPZ2ArqWX14EU1xEs7Ncp9cXA29pJOp6tSTMKReeZMUmjhyurRxsajMEFE7vFWcMktGUjlA6JDMCYVqDnKX2zEyitkT1hpQZH0tVeCz1EXmuCBHMoXm5r1qRTmL+oZhYKUXDdnN2jGxSdRLvzO+3VAiV1oh/WT2HnUcyf8z5DSvDEthsVay6EfQQRlDf2kJJQ+AEi/JrFm70YqFWrZCQA+DJcnamOi/TL6asiu7/Id9NpOZgV/JU4dBmMogeVLaDGseuNwtmFNTG214OfcqxaZr+yDg7ZfhBOXwSoTo++EdYrBKxvWiN2HWhrKTkmzn9XnifHsbmcC1vdI1Yjsb3UtNld286GG/qX4TBKuTbRSbpELLcG/C+wFSsgm8AuxJDXEf6tdEAgw5PysIhQ3XOiyZdnPaU0IV4x9h2XIvmgLIFPHbfYi/DecDzPNANMkcIz7mwfv94Zli7wUvU//3E939Uf5mkZaMvvEN6scnR8U6Qps0xE1h1cotu8CjpwsZDkclkAiNMYKDOsnG+B+U3X4Pnurt+m1Jdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(6666004)(8676002)(6512007)(6916009)(66946007)(66476007)(66556008)(4326008)(41300700001)(7416002)(86362001)(83380400001)(54906003)(38100700002)(4744005)(6486002)(5660300002)(2906002)(6506007)(186003)(316002)(26005)(8936002)(36916002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5rwz04vK721ioHKYyGzY7CdgtvnozAGK++ENyDZ4R2s1JAqSAFusnq+o6p3?=
 =?us-ascii?Q?/kyTS5PxqR21efubSBHOnsCrQFpox7oD9MwW+aN7PX41E2fostzGeg+sM+EY?=
 =?us-ascii?Q?5xl0NCOQqMK9eejKPWEiMA5cDI4e4dI4t+cTM1zWjtgkkW9drglakEqLOfNL?=
 =?us-ascii?Q?xnADILrIHuw38dPPg1KCcmXUJq578DkOx5LR1GGB6ASx5VkzscDjx2keGkJv?=
 =?us-ascii?Q?HiXBgFHkv9K9mwWzTrhLdtKaHHVhztL4siwVuB0rNiC8s8jEKGEKIs4gZnGm?=
 =?us-ascii?Q?Y/Q9350R2u4xoDwhHwR1w8ttYxoi0lVfWQrSlkbikhtKGKz1tkRyKqVLJiMZ?=
 =?us-ascii?Q?L7jwxZKtnaJTW67HnTzstd4I+eMlejDYdPUVTz/WkW1rH7zKLxd3zzeAx0tq?=
 =?us-ascii?Q?ZtusqJebHKrIeQiji1bL0OHjd0RxDRgNCihMQFYU3lx5hMLGDF1kTipMGOlR?=
 =?us-ascii?Q?qofddjNUEX8njMDr2vjHAXKkPHbQqDubghk/q/yPNJSejrILzuhv18kxInWg?=
 =?us-ascii?Q?jaOM4x9vCE1mxZcyPTL/q1tevoXfem/GfDiAAyGQ1xxBr6X6FBnMZ5WG3ZII?=
 =?us-ascii?Q?+4ghaHDd4UrVG9DMCh/NJAHYbeK+FuVUPfwQi6CzHf8Wj4caDtpR4haDkEnh?=
 =?us-ascii?Q?F2ClYhLM+ZaDhWJ3OSWxEw7QQVfdOBb2Nc0CKKihN2RsFCFl/C5UEhRXtkqw?=
 =?us-ascii?Q?FhRSu5W44a/wDAHTxJCe/f/frvvwMqHblx59UxkzBTNimftnnOJmlJhNNfRH?=
 =?us-ascii?Q?SjcSePJiXHNTk08Lt+6oNAwbwH69AM4fd0xisfMHn7T5CgJLVvPPg30ICqbS?=
 =?us-ascii?Q?C/tDAOGTWXhOrUzaDfWlT9Bbvdjg7VzUUYLK+qkHKKBANQ7g3POZspLles50?=
 =?us-ascii?Q?mq2DFx7P23D9orFjQVoIC3pkziEQIcFKisyARKFW2yRAhdkxYxWuatjQuYfo?=
 =?us-ascii?Q?haryTTeeiFYZ/MRsLMffP03pBtGBdT+EtUGfmHTlIthunbii60pRwDm38ud7?=
 =?us-ascii?Q?VmRCnVQ9GwnRdFc9aZrkv8+5vFoaxnLKjF8DHq6uhtgnosDLh7Qf09Nz4YnQ?=
 =?us-ascii?Q?audIFj85XTARqE3XLiNMajwOj/N2JlR1r2HlmnUx7EoWeeoL3eduReX621v9?=
 =?us-ascii?Q?HKDNaZZSqChUBo7jJ94vEgMOdyM08CC5sb1bU6sCNFeGGMjxIE0/R4vH5GzS?=
 =?us-ascii?Q?1l3OExqZQC44Fz32OwBenfvhrwGt126OCVuVZg3pv9PbQVDKD1Qd6SzeAr+L?=
 =?us-ascii?Q?8xcAwN3sZWBIugL3LDZ4NNfXf/9P3l3hL4RqdqebQnI8z0MuvHkW6PQ87DsO?=
 =?us-ascii?Q?LjsamZyuan9LYroNehDv1yR4GZUHNK2PrKxBDi0jMAfB5mr+zTDpX6rl0foQ?=
 =?us-ascii?Q?AQLxUn84B/iu9BhJJXcfqpKHFIQkKgHLS2TO7WnUApNjzcThSWwGou5EtBTJ?=
 =?us-ascii?Q?YqWc/bW5L+husfQOVLjrsc6dz/b1h+hiA0r7WmQDjeAH4sSuXUZKcSUgeWL5?=
 =?us-ascii?Q?LuL5lHHDcfWQskRoXyflbOMCeWjJxIX9bVM0eD6dUNrUoOl+bRrYKkqgOACT?=
 =?us-ascii?Q?IcEFF6oQG6nM7wdxqRZk+5qCN4QW7lfZvVRQ0mZ8QGo24e9Z9vKKf/JClRzD?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: maDtAxMaWG+2Nh1y0r0t9+PZ+EzFqj3TQ3laHDZYtcjhuyYEmOmgtWJMI5eL33e2NzgmBIGHcogwAPXtL9DaKFSqX/cP828rk+Lh8j3DlGkwEmwy0GamuXuei/gwp8NMzCJTMR09jLyALk2vuZ0HRxaivoFrsbHhNo53GNAyQ4N2nY9gASOv2qEzGYZtq60btNLpNpwZF81WKzfT+IS/1mwZyhQLtjpvAzV35iRtsCw0xfyxshEiTJ9FkK/9z+qhL81ZN2g2tp5+Ichb7v8pqsSYEFQUJRIPQTGX134vrZP8ifPjfChTFsEsYpRhVh/YTJNqjjoEbt65IMByEACdIGn01WxlJnqB/vlNJ6n90NanSmYHP8kRPwfxqNuXskSibpkDet5EukATFVfmC/c3+2uEVJiLdPvCdKgO+EBQD7CiLlf1p9d5uvTTKGRctAa23TvpA/ORrWgDvbbdQInItkQZgOdFRa6mMoqf8N9yZ36vEZnXkM/8yeZ/jGfS3GMU2dr+c4GEON+9BIH7goS3rxEcxnYFVi8XaD4tu4a3fSh+1jN+I6IqWrPtiQLiwHZE4lZqTo5kTGGznT8HaxVAomOLb1q1hzqr92FTsKhdcvXCZHnAeoMYNKmaF6bZ9TyjE5PUsJndFBpV96ZQT9CccPOnz96tpGEtf/oXrQQm05hJgO5h+NXIHBJ59zTpaiMpH8+crwp41NxoYwSZbYYA+hpK7asc3MyToyG7iLLi29UVdxi5uQ3I2A4gjuJPn0fQn9HMNCB4UVIm5UmsMvy2W0lwa0oKZaLf9UMagCh2udexnifYIw5ES8zb8NlIpiYlK37AUWiz3VTbEmbiRIYa0VeiY8d+NfD+tT13U/t5DuqTzjwk/JWDiuR1A0IiqDBldujhC1sxXiU6tolZYg6LBw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a88ae2-cc3f-4201-60d0-08daf9aaf655
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:23:10.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGWSaWWhOuUC54XzP/ji2mQdmbPtjW54TsI9tAL70VIJ5vsFK5S2wBUX3QlnIkpHJPK6KJcM+SqOhUVSXX2YRzJpDdx7y3Lru8kdCrYycX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=594
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301180194
X-Proofpoint-GUID: IErb-9jlPQtv-1tcFPnIXLukckOBIotG
X-Proofpoint-ORIG-GUID: IErb-9jlPQtv-1tcFPnIXLukckOBIotG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> struct MPI2_RAID_SCSI_IO_REQUEST ends with a single SGL, but expects
> to copy multiple. Add a flexible array member so the compiler can
> reason about the size of the memcpy(). This will avoid the run-time
> false positive warning:

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
