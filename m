Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D009B6D3CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjDCFXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjDCFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:23:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652E21987
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 22:23:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332MM9Mx025427;
        Mon, 3 Apr 2023 05:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=UjM07Xo3SboE2ZDIKJWFIgfW4cJRS+1QtuqFInHyTCg=;
 b=1WOqz4d7LZ6Zo//oL3jSMkScTNg8MkljM3a2AvUGDRL9NhXxfqwq6za20/VP8Rt+BveG
 WwSOv61eHLje0XWyl7g/KxyPTeLKcPmtMUcgIFEEgyiUiabzc3qyqlLA54RWZwk39pE4
 Hp/F/e5emxKhiPkwlKrNUnawXgj/aT8aC+HtKvsyMyIuomzQsNKONRa7mEGhzRgaOadU
 YcP+bAXBKdCxZwyep90VRVBKJgcF6Q6U/6PdONgClE5F0yFTtEzrqj/zun136DGpwSdE
 5iAJV/qf2UUIN2E1INTUl4BZFQcOQHy9yDRoLrY9ic6rp5Q15hQE3qIvl0mEzTGdWpYg Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1dj5th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3333Uv6Y038324;
        Mon, 3 Apr 2023 05:22:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjptnhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 05:22:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwI3s+LsyusrVjnaFPv2Y/9rT3KrXGz3nEkFzYrxeiTsnBdSTjp/6CjUmfHcVNQieDLldaTL+BjEzNk0X9JyJ4l1YN8BII3sfw85XNRqRiWSTSmTdQhTpqngCJQ0svNGurkzEWjsQazl4ehJ3nNhHlZSXrvZ+4TdXiduLByVw03Djj815SpLdetgVS8KlFIV4MpzCDl+L18OxaR+6x6MD4oG2q2g4KF0RAh/KV0DkD6mrNJxZQ3N+uZHYvQMPOFCFBX1QpQ8X9tlxA/WJMY/laBaIzN594ktvMTX4TDTJIsqnNywPK83UCgOZBi8ImNrT7CA7Gr3hD1N8md4iNVjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjM07Xo3SboE2ZDIKJWFIgfW4cJRS+1QtuqFInHyTCg=;
 b=BB1EaJyKAaWcDrRfS5W9Dqz97Qe7zjeiSwxNWKq1MREshAbkEk7xGVK0S/gSgaoCtVtEyBg7cgi9mHSCrW6axUt/6LGd1tv0ijJVME5XVGuAaAY2UYRbY3Mp5ZvEX+zCnwdA0Z4OxXcFkn/DuNfcX7GRlMNDRBVadO8mLBNa9NabalGV7jM3wotuvGiIwdqJHRfLs35gXE//AFIgFzIby0IwPM4aNZhyM8A2Em9yICs1thqByfGQPx6I6862YADtWIG3VA1qDqNI8KZcVSlRVoFYYIrveTQAHZpIHSGU+gCz7YK+hm4QAS+XIjgSrvQ3h09H8p1RR0CGgWYEz/A+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjM07Xo3SboE2ZDIKJWFIgfW4cJRS+1QtuqFInHyTCg=;
 b=n6sXqHMaO5hzCTlLFo8CTQFiIk8a/a/x85w1hx0YUnRws02gna4e7JWmCr7AwTxFAUcGU13b82WatIQDvsNyU1htOOfd01dEnx79PsbLdLp1N4hqBkf1NZflzM9bWMk8D+rLEwEI6MCa5uD0Ig8rZGn95VBl+udUA1Yjgc2lHxo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 05:22:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.029; Mon, 3 Apr 2023
 05:22:34 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, jon.grimm@amd.com, bharata@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH 4/9] x86/clear_page: parameterize clear_page*() to specify length
Date:   Sun,  2 Apr 2023 22:22:28 -0700
Message-Id: <20230403052233.1880567-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:303:b4::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2f8e1c-02d5-4634-cd1d-08db34036e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WffUYm/xCiTWr3T6eBIlnT5ip5e6/1255qgOJCqYMQU1Dbqz8+vjgF8lRUmDYweMNPybA+AhbJC8VGgnyroj2NV+ZudsVlg0aD5+HVm6s7lY1xpFBcPx81m6eaiNCpWgYBPyc4EdRPadCeBjWWjroUUObsxOp+/UTim+ZivcayyGP3qW6bJli2hP94ymhS/DRz1dV6bhKgW9KGW3nI0oLs3E0/7sDrWUnUDHHbYDYzWssM0in0DKbX7ZULzgi+gp1nJxKR6Kvj8ne6/x3lI0WhjGpNRsILD9PXC+zG9jw4lWq6KqgQds2SjkAuttGRPx7zNe7zIX6qUF0qbYXfBgXSo0HOwYnSAGUx5TZ5DuJl04/NrIvZ3YBkjEGs3gTm4w0eM2MOSdBhjt9O7yKdSK9wS8QiDNKOjrmMWBNKGZc27eMDQHh6FhGT2AgIxcF3WLzk6Z6tbwJDFCqTYv5tGIS/jU9bPbaTzHdNwWOna37YZFx7m9uVaCjANMlLkWD5MhaFN4ammv7cxZ6nX6UaYJJH8gtEOx8fFixwGyI/ENpmt90OPowiHDnH2bAO7gIaQh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(2906002)(86362001)(5660300002)(7416002)(8936002)(66476007)(66556008)(66946007)(8676002)(41300700001)(36756003)(4326008)(316002)(478600001)(103116003)(6486002)(186003)(26005)(1076003)(6506007)(6512007)(2616005)(83380400001)(6666004)(107886003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yx05J4aPr+IqbvHOpvXk8ZEo8RheJNIi8S3M8yMX1PhG+wVxEpvFRvCkX/I0?=
 =?us-ascii?Q?p/aPxICamVJ4bCIPuVwNf6SmJCbioX3TtahQIlZegGNjon9cYJEP4y3rFx6d?=
 =?us-ascii?Q?fVYYUVxbZW3qaDH/JZmdvsHj4DRJhI+7Mxu3e5Wgyu2iTun++LGIjhljWSvP?=
 =?us-ascii?Q?Bv2bc+B9vk+C7s2Ncdpjkta7e6y+EG2jFAP3zCFCF7earEul2wJwUQ5neJq8?=
 =?us-ascii?Q?Oy3Iip89LOrkdagaocVB20+XuUsKHky4tFgm4CL3JfV1oWVKQctLP/K4Qqxc?=
 =?us-ascii?Q?NmyLo430hxlmso4qu+PwnhdpZmsEKV3eMA/0uPwNypAWI2K0kb5S9qVWKnU2?=
 =?us-ascii?Q?VuU4d/WW5/ci++QdEDYxIgh6ekqJubcNMWRhQR+hgJ+zOo9gVINXGrO4RQ46?=
 =?us-ascii?Q?Vqg7+7ZF3b2P12qJyJg1IiHx3E1GHDfUM1IGGc+tkTD+1XvnaPCjSYD2SIH4?=
 =?us-ascii?Q?m1oxNaSIcAJ6ja1/fPWbUApPJQnyjKkoUbdEHejG/p/Y8kD3OzWF//HAU5OW?=
 =?us-ascii?Q?LyY8cOxCRbZav7jI0QSu1HioYDP1vKwYjfCBpf88NT5yBYjWB7QRKyTlfGAz?=
 =?us-ascii?Q?gD5lGEn3fzJ6yK2kcK+Oony+p6KyoWg83AObNo/KEQV7/B/AIr5SY0fqlzog?=
 =?us-ascii?Q?76J4xT5nv250wvaCkUQ2CIAgJSgFR2SSJfHkEUzfdQ7EY5jqrP9RyZm1paIA?=
 =?us-ascii?Q?SiB1QTFLq21SxvQWW8dNAwuV4hyDKUcIyZpOhmbAhPg3zeHAqWBPyW439F/a?=
 =?us-ascii?Q?zPXSm78lCW4Ah2gGrZwCuo1dpVQbiiARmZY6gxAUpO7VE/9hbwGZJ7wcmeN2?=
 =?us-ascii?Q?JD3Hacr6rhlC/rie+3qnh4vDaUGPhP2iriTzArAzHCyELI4hvX2qhoBD9sih?=
 =?us-ascii?Q?0zEhAS0FFlhr8x7eHA1XrLX+R/IsBRDxvv1aJavyBQAgCRsOO2nLJOkODbK1?=
 =?us-ascii?Q?TyMKPsHfF9pNTzRSUDoEZqS2fBQ3pmstevurkwT6RaWVthxhnOQCnSFLbkVj?=
 =?us-ascii?Q?y24fem7oiiPRoX99LaE44zLKCFSVEA2hxnm35ls09PXIylHTs7AXWXpNogns?=
 =?us-ascii?Q?IGFOfXzX0RyRE4OrX0GsPhCx+OFe+zZEQH4176UFBpBhQvYfRg/WsPc2JDDk?=
 =?us-ascii?Q?phILFJxzkg3+fQ5m3ON1M7Qo6T1PgepMhwyBAnJnjR/y4MvJcM97VvLS0H6o?=
 =?us-ascii?Q?s8zSDe+BV8+ULdGtoZeDlPuv0J7v68xzD3Q5QKcG/1fw0MfWQDjbzd13jQ00?=
 =?us-ascii?Q?UhA5wDg+v3x22iMp37a8l8vkQ1lfljoq/P1sqB6JIzPTIcznG4wPe/yCQnV2?=
 =?us-ascii?Q?YXWaG1THOA0i/Wd7Kfya2vkExOQZduwOTvCEeh4GoTR/All2o/4irtvv8WP7?=
 =?us-ascii?Q?MLqB5YYrRN73sYR8fGz49+/+DZuWGm96U2uVK8KaI6xkubdmh/qK4k40IPZH?=
 =?us-ascii?Q?AjrYNpglxONXvCg+dvGugdujKHPYBqJAZRKbqmOoB1BwK57egGt4pTNmKmZl?=
 =?us-ascii?Q?NzXPa9peJ5w2ipXLJklEzzPljhvdet+vi5NBouyeNDhb+Xfm7+0Kk87s/WMG?=
 =?us-ascii?Q?AB7sdATzrEBFRdUxqADA4/Y1hMDfVcI7KgIHE5iD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?66vfYUq6go70SfEIgOxUSAfQFij07W6OPe7FvVXIA2JL9SaJN1lsQ0P9kN6Y?=
 =?us-ascii?Q?4rTu7ndfTOxse2dvOohodIA0Lq1+wzaeA82Ic5CpC/V6zC9cqqwHTIzEt4EJ?=
 =?us-ascii?Q?Zbn4TaS1p1XavDY7doWOFz/89T5/DxsEmB68sjeWtuEl4xtfHPR1x9uUr2kT?=
 =?us-ascii?Q?TWu2U45MzhW92G+krl3TbfJadq3R+jiaLgtaUjmW0yCb7STlc3NJ8/LSUeAt?=
 =?us-ascii?Q?Qb7dcH2AtRct5XUpfIv0BLKvAtay+6yDMfkWGbB6OH/4FkSNpHGQkV/qiBV9?=
 =?us-ascii?Q?Ni/COzfQls5S86Jv6U9MfmZ0QV1tTVbdaBf0NSwF3dGFWH/lorLy6zGkz0kb?=
 =?us-ascii?Q?oKyq+NXyzTVVTboASyNFjtT3HeF07ehHnItLhREr9jw8YXBE20fRKxnf+zbj?=
 =?us-ascii?Q?uQuZZj6H0mgNslEyYe+5u/6UatAdn65rqksMKzGpe48rDrWOeYKHv9jNClhi?=
 =?us-ascii?Q?OLZicGTVdsXajQZuc8gmIgec3pTJLz5EuCxm/vHmPEPWas4J5KLpqTbEIfuq?=
 =?us-ascii?Q?mzl+zykPLLX7OIBWs3bWg7qQ+srAP955viutQkVSx0Pw9amMJTUR2zj0XoYF?=
 =?us-ascii?Q?zcBsuNXAnp1Aw1u36iCQyFV/+IPGFLFni6+RRDuQiN1MoPj5qiu39aFIiA5F?=
 =?us-ascii?Q?HQfo2wt122S/NbMr5U0DZg7rhhHk2s1NBg4MitwNQeXRhBhNddOm99i8Xa3/?=
 =?us-ascii?Q?WcyX+00JmXUs9dgY+CAPKUI/+ixckPkqcAlISt3mN58Uo2xE9w1vmCvjMplz?=
 =?us-ascii?Q?3v5GdYd791XzL7ykK11UZxfLU8Cu01DZiFO1wKzoR21vicK0lb57QbDmiy4i?=
 =?us-ascii?Q?Oyokuc+dVpijPTwZ3KI5qE7bFtmmzTetWq5oTNzhzQy3STJhv/RwZDLXSvaO?=
 =?us-ascii?Q?01SLpBh/9iHHZNYDPkjPnTG3O7muGBArh/ySj1HTd9Ttioqx35dy8dKNIrBb?=
 =?us-ascii?Q?Dl8dItR61iLzacZ6lo/AcxJjlgRNrQgc61QTKOxIu0XGjJaYaRp2SRfWlFO/?=
 =?us-ascii?Q?z6wJlT7z7LaQnMnm0MauNJ9rB+JoCzXJ0wD2EVopg8rkvF6aQFvbqRIsSzIL?=
 =?us-ascii?Q?zFk/IJjYh03ex/xil9SDxMYNTv3Yozh1NIG8UPsflZ71cNkitpIa996NfsTe?=
 =?us-ascii?Q?aJXGrEsBaUDU59AYXH4oJylL+KV5RxnMAschuljt4yZ0dq24P4FBUAw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2f8e1c-02d5-4634-cd1d-08db34036e7e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 05:22:34.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3va0khPeFN/HQs9xoXsiigLDI9gJ2EtiUo0uLwscOI4GgY64IrUkLy63zeq0OBaKYqG3GTbBxGYyrzeqRqpovULADgJ39+1Ezviu2Oqk0yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_02,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030039
X-Proofpoint-GUID: rLVRmwNI7i5to-8xeaNRvZvYUnveTt8w
X-Proofpoint-ORIG-GUID: rLVRmwNI7i5to-8xeaNRvZvYUnveTt8w
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change clear_page*() to take a length parameter.
Rename to clear_pages_*().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

clear_page() is now defined in terms of clear_pages(). This means
that all clear_page() callsites -- which are more numerous -- would
use an additional register now.

Opinions on if that's worth optimizing?

---
 arch/x86/include/asm/page_64.h | 18 ++++++++------
 arch/x86/lib/clear_page_64.S   | 45 +++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..7ca3bd2448c1 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -39,22 +39,24 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 
 #define __phys_reloc_hide(x)	(x)
 
-void clear_page_orig(void *page);
-void clear_page_rep(void *page);
-void clear_page_erms(void *page);
+void clear_pages_orig(void *page, unsigned int length);
+void clear_pages_rep(void *page, unsigned int length);
+void clear_pages_erms(void *page, unsigned int length);
 
 static inline void clear_page(void *page)
 {
+	unsigned long length = PAGE_SIZE;
 	/*
 	 * Clean up KMSAN metadata for the page being cleared. The assembly call
 	 * below clobbers @page, so we perform unpoisoning before it.
 	 */
-	kmsan_unpoison_memory(page, PAGE_SIZE);
-	alternative_call_2(clear_page_orig,
-			   clear_page_rep, X86_FEATURE_REP_GOOD,
-			   clear_page_erms, X86_FEATURE_ERMS,
+	kmsan_unpoison_memory(page, length);
+
+	alternative_call_2(clear_pages_orig,
+			   clear_pages_rep, X86_FEATURE_REP_GOOD,
+			   clear_pages_erms, X86_FEATURE_ERMS,
 			   "=D" (page),
-			   "0" (page)
+			   "0" (page), "S" (length)
 			   : "cc", "memory", "rax", "rcx");
 }
 
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index ecbfb4dd3b01..6069acf6072f 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -2,6 +2,8 @@
 #include <linux/linkage.h>
 #include <asm/asm.h>
 #include <asm/export.h>
+#include <asm/cpufeatures.h>
+#include <asm/alternative.h>
 
 /*
  * Most CPUs support enhanced REP MOVSB/STOSB instructions. It is
@@ -13,18 +15,30 @@
 /*
  * Zero a page.
  * %rdi	- page
+ * %esi	- page-length
+ *
+ * Clobbers: %rax, %rcx
  */
-SYM_FUNC_START(clear_page_rep)
-	movl $4096/8,%ecx
+SYM_FUNC_START(clear_pages_rep)
+	movl %esi, %ecx
 	xorl %eax,%eax
+	shrl $3,%ecx
 	rep stosq
 	RET
-SYM_FUNC_END(clear_page_rep)
-EXPORT_SYMBOL_GPL(clear_page_rep)
+SYM_FUNC_END(clear_pages_rep)
+EXPORT_SYMBOL_GPL(clear_pages_rep)
 
-SYM_FUNC_START(clear_page_orig)
+/*
+ * Original page zeroing loop.
+ * %rdi	- page
+ * %esi	- page-length
+ *
+ * Clobbers: %rax, %rcx, %rflags
+ */
+SYM_FUNC_START(clear_pages_orig)
+	movl   %esi, %ecx
 	xorl   %eax,%eax
-	movl   $4096/64,%ecx
+	shrl   $6,%ecx
 	.p2align 4
 .Lloop:
 	decl	%ecx
@@ -41,16 +55,23 @@ SYM_FUNC_START(clear_page_orig)
 	jnz	.Lloop
 	nop
 	RET
-SYM_FUNC_END(clear_page_orig)
-EXPORT_SYMBOL_GPL(clear_page_orig)
+SYM_FUNC_END(clear_pages_orig)
+EXPORT_SYMBOL_GPL(clear_pages_orig)
 
-SYM_FUNC_START(clear_page_erms)
-	movl $4096,%ecx
+/*
+ * Zero a page.
+ * %rdi	- page
+ * %esi	- page-length
+ *
+ * Clobbers: %rax, %rcx
+ */
+SYM_FUNC_START(clear_pages_erms)
+	movl %esi, %ecx
 	xorl %eax,%eax
 	rep stosb
 	RET
-SYM_FUNC_END(clear_page_erms)
-EXPORT_SYMBOL_GPL(clear_page_erms)
+SYM_FUNC_END(clear_pages_erms)
+EXPORT_SYMBOL_GPL(clear_pages_erms)
 
 /*
  * Default clear user-space.
-- 
2.31.1

