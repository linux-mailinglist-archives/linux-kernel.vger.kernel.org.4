Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3767852B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjAWSm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjAWSmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:42:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D001632530;
        Mon, 23 Jan 2023 10:42:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NINsLE017718;
        Mon, 23 Jan 2023 18:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dmXvAXVmA1aKPTmgKwoD0Y8l5pSruJ1uY4QwgPtZ3Ak=;
 b=jsCS3fUwI4aGR1BTwTsO5h0k4X4NX9arONR++2omDVeXgGkLnTky00gfeSv2dl/nT19j
 UO0xlQSHxty4soIVC4Z3W4Sc5JoUWtflbA0y6riKEwK2y+sK1nBqRvMp+WTEl+yy3Kkf
 8E1dDV6QsYamjwYfaTWIhKJfZ0DH67eyvTlkal1W0wRunbOShOZHrQiOptLqDB8s1O7t
 bCg8t/OsOhp6A6fGfnLCBsfnqYmNOIKMpehFOuZBoTX9wGXMMjdwlXVHbNR+JIWMIOT4
 q5hFhluvubfWXvmHmIABQT3aJ+/GAuTEUldwf4MEJw/FULhW3v5zyVFF8QM5AtQ+yf/+ AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86fcbm2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 18:41:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NHhax3011686;
        Mon, 23 Jan 2023 18:41:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g3e32s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 18:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpTHmr0YJQJ2TjPo3/kIjPAzhps5oSj3xPKIL1bykms3/lZ8NerN6EhXkypDPyWA8DejdnlhJbyGWnIpxC8w8GBUTtbuc6Ah3r9mUyuZz+IqWsIEuU/ZkxqZ86kA1minEz3dFWGp0awWrx7AUJYJkwTV2PDYNJwlnpl7HDbn5jTl9Ct1+j4VuBeWg4glIUri7FS+Z9zs8UU8ejiqB8oFS7/YV1G2U8KMRsl0CHuMdb4ucCADwa7GEbw5tFzifNfEKt2Tc2/7GFZHwxUECQjHmjWCgrWdMDAX05h1v53+XhEQSR41h0GxRug79sy3lST4J8iDES1Fyh5JxygiWgBLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmXvAXVmA1aKPTmgKwoD0Y8l5pSruJ1uY4QwgPtZ3Ak=;
 b=YIX0gLFfVmoGclT41xC/Ut1rOdc4UeCTbGhd03E9oXlprKFfWmTzD1S4gmeP8yUwvg4n+F4C5yD8eiTM8yvKMo0uJg6VjDv32yOqbqTNoDyJoO9wVDyJOdqkTUcm7sKhWJ+RXz5R0MpLvzG9Gi/bldsLAs8o4SSdjRfboyj0LuFyczC7t9EUmLl9gTOQ+sczuFYzxnc2elHwmYu6NQfY/vc41wZaMaZt0mz8RVKUQQIns8l8/L0sTkHK5oDE7MB/pt8KgTf8KzXAKEV2Hn7yc23FC7x/+ULtj1mNV4teWXIjfsNdKXesMIN1k88S/7MrQU36b0rEMV/g0USx4Vq9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmXvAXVmA1aKPTmgKwoD0Y8l5pSruJ1uY4QwgPtZ3Ak=;
 b=DQ53Vb9ixTCzBRllW8ZIDGEsJg0zSgFSu9QTmosnMYQVkZCRFBjVJqCsgs4WTdDT1BckOHhFStrtlSEVsFvMAr0Fd0NEBpcnGpd1exjeSJAYgwr5Uj/i37A+k9rVHKEspzgJ4fVRSiEmZQjy8wAiuwEzZ7Cl0alvAnjI8qdwuGw=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN7PR10MB6381.namprd10.prod.outlook.com (2603:10b6:806:26f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.16; Mon, 23 Jan
 2023 18:41:54 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::bc55:518f:9d06:9762]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::bc55:518f:9d06:9762%2]) with mapi id 15.20.6043.016; Mon, 23 Jan 2023
 18:41:54 +0000
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
CC:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: qla2xxx: Use a variable for repeated mem_size
 computation
Thread-Topic: [PATCH] scsi: qla2xxx: Use a variable for repeated mem_size
 computation
Thread-Index: AQHZI6E2j5Qarh/OmkyGvGCGvWBPGq6sbWqA
Date:   Mon, 23 Jan 2023 18:41:54 +0000
Message-ID: <70C21723-6FC1-4590-8A37-A567E5C5D4E1@oracle.com>
References: <Y7spwF8HTt0c0l7y@ubun2204.myguest.virtualbox.org>
In-Reply-To: <Y7spwF8HTt0c0l7y@ubun2204.myguest.virtualbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB2943:EE_|SN7PR10MB6381:EE_
x-ms-office365-filtering-correlation-id: 1ea249ec-a509-4825-6295-08dafd717fad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbNwy1N9V4z8Y9XbxhAoFM/HMuXALNuI1/VqO0US/OVnBjJbI4X7F1OxD89WOCoD6774ECCc7Q4O2wExX4ym29bSnl7L5FDXnqlJUZz9QnZh+Rw6elulHBbPwjdnMMjw/ncO8yxiqKtViHkZsvhlHK1iu9gid6DG96JuEn20VKs5mTkRUHNcxezArhpkCF7B60xhMQ46KPun+c7Dchqa8mfUY12c3yRHEcLtYp2xF+Vi4cj2Uj2eW6+RN6o7gbKTFBdjY5wwA6u0RdPU1CUZFcvvrgrbYR5Pr8m9gSKTE4W2MP4DsgWiDG8DuzIAHbpq3/jGKrw1WITuzsyq7lIwngMdwu/2qOm1UtinvXn0uIWOwAes2WkcfP3XlUbgpvJJMiLcJMc/gUcgDcmS8zeQ+idMgpsA9xWVtVir22l8Y69BpgEcERBBU0qNhvmsexGvq8Ee/UBQZPrUm736NrVXEdhItCosUgFzp+kZJKdSqv8btzuVncafGomkpws0Yl6dvG0/NGOSiorS/XhPgXu+LNTWo7aLyxSRXen+Nzc/neiQAafEL0R3NmpHx4YU9ismkV6cKba3pq4vbOfg/EuaUczVTwzVhbvRw7BVPzjRG0GoLtskW5DWuO1z6K8a3SMh5+kgakzyQNmiwKZ/c61ZLUkLlq1YekkQI1R6HQX8Q/yEByAlsWeo/LyPoaYgBIEka0izG3zceK7CI4yA5815L4XHa+zRyQgmZeGNbJLoHKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(6506007)(53546011)(2906002)(38070700005)(186003)(5660300002)(478600001)(8936002)(6486002)(6512007)(83380400001)(91956017)(66946007)(41300700001)(76116006)(66446008)(4326008)(64756008)(6916009)(8676002)(36756003)(122000001)(66556008)(66476007)(54906003)(71200400001)(44832011)(33656002)(316002)(38100700002)(2616005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JIPxC/g1MEYm8ylsXqri3gpXCPBvFiTGwHCUF/TeDWAdVe778L2i+OP+nhrF?=
 =?us-ascii?Q?KE6BdU66IZiqAsdd9YZpjfe3yFSYQwsi4FLmQFX8rNPRFC661ugNBQxSMGvM?=
 =?us-ascii?Q?lzgYNhA1NfHPpGgMKb3PPuM7iizd7DNDRzXZewx2eWrqVmkWCG/tu39mDf3P?=
 =?us-ascii?Q?ZR9wAx0uLfIgFp09+0RkXgEL6+IVSy9kn7RUYnd6l9iqkFavo+e0hGp9L3BI?=
 =?us-ascii?Q?hUCLvN1+8GOoaZPEo1sHhfAoJP8yyLNCLEYnS+ywwTEdQ8pkFaKyIZusaO27?=
 =?us-ascii?Q?vTIAyeDnFURbhtc4yK+ggi/KicPY7nzBX5KkzSv4yQoAFAmw18f+DAF98JN7?=
 =?us-ascii?Q?pZdsL+QJSUWlkp28w4f9MHHqRI+QBGURr4KQP8sdQYZs2oOksgy9Y8s2yWuc?=
 =?us-ascii?Q?INlDABK5czydBQAwYu32QBxMTo6dpxWISg69zYrCbTxfrRPAHA630BJm+Egj?=
 =?us-ascii?Q?Hs5B1M4h1kQ5BhWusobg8fbCuuKvoBh+nW1pzk7F7zdOzilzhxP7pbFfuMnt?=
 =?us-ascii?Q?gOu7vL9QPirhem8RG4qB7UtgeCFoY4A9zInNgIMXCMElJhrQDdnBhW3ilRFI?=
 =?us-ascii?Q?ozP7JDlPAS/Rk4Mzynz6cEbwT3hKqQqsZYAHamEqjACO9nz8PoUj15a0TMJ3?=
 =?us-ascii?Q?K8YNW4YfiRD6ZfKx7NfArPhnG19VwVsxxF0J+NGtEcj7UwvOV4zlxa3TNZW8?=
 =?us-ascii?Q?p6QolxKch/QTl34eSJArfsjEu9ihRdcsQugPByjTF90+jTZj45enHJ2TiF5n?=
 =?us-ascii?Q?Bi1xkb3SomEbGWh2uTSANS/zhS4j6/So4W2S+yxO/oH0PTbd3zIxw8KICJPp?=
 =?us-ascii?Q?hdyNYjP1vUqjXkpZuJu7YwsYjoXTIJaTRc4EzykXMRNIR2R84QpSpeMDlpsL?=
 =?us-ascii?Q?BdVoxbusCpqRvtDq2xSdyfXYCrpLW5u95p9VNw2kmMUWTrSpQRVshtnKZWaA?=
 =?us-ascii?Q?cBjs4rDgVQbtkh4U/M3plvD5SuWCnHbSLBX+aZF9AqgC4AhtW/H+chLyv/Qe?=
 =?us-ascii?Q?PrFWsVijBBV6cCJR0sneDVSbEGW9FndUstr3g0fhfNHbVioEBVjxbdVJjD+A?=
 =?us-ascii?Q?VXr9RSUwRoDZAMcM7SRElStHQJjM2QYZjFtr4R4tKJ3KA7sNCprW/YNxKSGi?=
 =?us-ascii?Q?nbcWAVuaSwo5zZXUGg/YB4BTiCpE3FwNQOyklqalSbOttTflUUJwyf5RjEgV?=
 =?us-ascii?Q?GCGur1fnDiz2ce3k5Fesejfr0cZVF2tS6N/8zvEJFIIrWc8Vgio/IigMf7p/?=
 =?us-ascii?Q?anG5mpTfEUL6MAI8f7dyEk9YjQbmnK1m3SDN8gWp3Bay5IcqZQt8N3G6edBs?=
 =?us-ascii?Q?H35u0afDF0Kq4MlVc07KF7fkHMVlwvT7zGl+bvw8G28ndHvNhiwpbkvAZ23i?=
 =?us-ascii?Q?B+G8/IDkZ7KwSR4XSn/8v+c2BFdRRQ1sPOuQ2kbiahR+9DhAxZFTs/Ycgi/g?=
 =?us-ascii?Q?Ex4oKvOuhkHGOJbGXSwo9KgmhI7nFBsOsRqk38RgPtpiqtshodEyMwCyio8J?=
 =?us-ascii?Q?tm1V7/Q17+GknKrumKLNn2cl+7goCiDZzJsJCH8HPLAD0qvRB9USv+P+Nmsq?=
 =?us-ascii?Q?BkTmBJefVlsO/1YbDMoLSHCMdfQSzbXj2rJmZX+pacLTv62ucfQBZioDZfFz?=
 =?us-ascii?Q?tGV/70NOawYxmnUq5QEfrj9CHrNYdfSD/zAmLiQjSEzg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EBF36D47D9F19746BA38B511266A3454@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ze6054yRHqIFRYe6EEtbk19l4MVxsiqiJDmMygtYReh61OYtVRpS6xSosIXb?=
 =?us-ascii?Q?0zR79gfD1Ge57ntXuwFLjUdIIdzrgjFRshfG+ru6iKLdb5wtBDVul4O4AYz0?=
 =?us-ascii?Q?oTAWs/1WC4XoM+1idI5e2xpVi4tuJ8Zmbiq2r5i7MN7/FqVZR8ubWJ/o+42h?=
 =?us-ascii?Q?pmorDz6Y63raetJ/37Bz+RrTZRN4qlAmkFwzzVG8hFgnEENO6d0MwQuml14a?=
 =?us-ascii?Q?CzX+4uMcw86IW7Qne4gcedykwNJfgrAr+xsSFcjkR152ijjtZ0DUbE6TROBt?=
 =?us-ascii?Q?Uz5dSH/KJR8OL/Fmukn+dlnXvnGYjj1rOOEmCr4FPkzpYFM3PbGVOIluMxE0?=
 =?us-ascii?Q?wJDDOM3dgT0+oLSPYhL0tmOF3yjkj3qVTkD1UHYGW8araoMRcdA3P58v5nSA?=
 =?us-ascii?Q?egCMDwW/2fVjSmgC34oy/pYXaiqf7XxnIsPL/Hl9N/teQr2TPrxS9PCZOhA8?=
 =?us-ascii?Q?RxCw8JSrgmL4LQYt5wv73lDFFisBjlFTD4ZESFB1CuQbxQhJURt2anzxxHuB?=
 =?us-ascii?Q?kK5+Hj+4idX3ru2mtTZrmx+tZ0gpC8s3v6nCM/QA8JQTFoYUEruCmZYm3aP5?=
 =?us-ascii?Q?m/ZzyBjnMACAjkDbMUbMzbvCUJcPOVrT0V2VZ+aNJHNt33gLqlnB+cb+f8Oc?=
 =?us-ascii?Q?wB37i2RLeTMhd04fYkYNV+gA6v4BeTJfaTSUJlVOLs6vHiht0OyPOMQdzww2?=
 =?us-ascii?Q?rZKR8jLMGSbVbh+BGZoIYC79UcICIuD9nb+yfcxG+eiY/G1jiq4lOUKcX+UO?=
 =?us-ascii?Q?btCNvsWOqeusiBEVu4Tov33gIM4WyfDqR2eXYjtZ2znTLTQAOEEwMzgxgDCO?=
 =?us-ascii?Q?SJTjfssCR0gZzdDLUWW7SPgL5dTCvGk+8cxQxiuVy+wn3DRrXbL8kouTTTZx?=
 =?us-ascii?Q?9exVrc//ZJohEnekPW5Vbrrz+AVhWfLEKjtFBCfaoZXDhEfAW+GkK1j0YzOx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea249ec-a509-4825-6295-08dafd717fad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 18:41:54.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmYCC86wLB3Iy3xAIaZrajL5x/Ol/XbtdrRbHb21i/hejkNfS5JNpsgkDa0FWT+d/DL0gSfbFGwQN3fIkreA7JezOQRspVnHM/n5pdTwI3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230179
X-Proofpoint-GUID: GZwvKef5FP5mj6qI0tRa4qpl3kjW65L8
X-Proofpoint-ORIG-GUID: GZwvKef5FP5mj6qI0tRa4qpl3kjW65L8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 8, 2023, at 12:38 PM, Deepak R Varma <drv@mailo.com> wrote:
>=20
> Use a variable to upfront compute memory size to be allocated, instead of
> repeatedly computing the memory size at different instructions. The reduc=
ed
> instruction length also allows to tidy up the code. Issue identified usin=
g
> the array_size_dup Coccinelle semantic patch.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> drivers/scsi/qla2xxx/tcm_qla2xxx.c | 13 ++++++-------
> 1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tc=
m_qla2xxx.c
> index 8fa0056b56dd..8024322c9c5a 100644
> --- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
> +++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
> @@ -1552,6 +1552,7 @@ static const struct qla_tgt_func_tmpl tcm_qla2xxx_t=
emplate =3D {
> static int tcm_qla2xxx_init_lport(struct tcm_qla2xxx_lport *lport)
> {
> int rc;
> + size_t map_sz;
>=20
> rc =3D btree_init32(&lport->lport_fcport_map);
> if (rc) {
> @@ -1559,17 +1560,15 @@ static int tcm_qla2xxx_init_lport(struct tcm_qla2=
xxx_lport *lport)
> return rc;
> }
>=20
> - lport->lport_loopid_map =3D
> - vzalloc(array_size(65536,
> -   sizeof(struct tcm_qla2xxx_fc_loopid)));
> + map_sz =3D array_size(65536, sizeof(struct tcm_qla2xxx_fc_loopid));
> +
> + lport->lport_loopid_map =3D vzalloc(map_sz);
> if (!lport->lport_loopid_map) {
> - pr_err("Unable to allocate lport->lport_loopid_map of %zu bytes\n",
> -    sizeof(struct tcm_qla2xxx_fc_loopid) * 65536);
> + pr_err("Unable to allocate lport->lport_loopid_map of %zu bytes\n", map=
_sz);
> btree_destroy32(&lport->lport_fcport_map);
> return -ENOMEM;
> }
> - pr_debug("qla2xxx: Allocated lport_loopid_map of %zu bytes\n",
> -       sizeof(struct tcm_qla2xxx_fc_loopid) * 65536);
> + pr_debug("qla2xxx: Allocated lport_loopid_map of %zu bytes\n", map_sz);
> return 0;
> }
>=20
> --=20
> 2.34.1
>=20
>=20
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com <mailto:himanshu=
.madhani@oracle.com>>

--=20
Himanshu Madhani Oracle Linux Engineering

