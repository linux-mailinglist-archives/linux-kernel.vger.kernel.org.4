Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215C26B53CF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCJWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCJWFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7969B10A4EF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:04:03 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ALhwmR001335;
        Fri, 10 Mar 2023 22:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EolHZHT6Q+0bjyd/RRHxdGdRyCaJq/v78qTo/904u5w=;
 b=kF/9XLfsAzAHJQ20ukYR2RA7jIIz5Osw3W1tON8BIsO9+9aqL+J2+d6ZZKs/PeFMhQlM
 nq99Ycqsh2IOMOU3sPep1zPJwUBTdP20/rMwFv3b9EPHDWN84cagg6fHJueXwj0WVjzZ
 GAYji7ykn+VtCS8lsCgfi20nRHMZFoQCK0kgXVv3v88cQHH977/Qkz8xS9iHeCO44YQH
 CGh52uNqBiMUjz/Mx5OKz9cCiJlmycvOmmOja+hEdmhsZRCvIbkyKJZjgQaz99iFZ6np
 E9UzvaYjfgpN2gY7nuMKTKBTGL8XKZE1KkClaqrQmTVGelNyizUwAVgXR3r+x0/AgWyw qg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4181644c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32AM0mBj004846;
        Fri, 10 Mar 2023 22:03:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g4k82kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 22:03:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc+R/Zuh61qYun2NQNMfZC7DMXPI+bBYAV755IEAwTHTY9kFXnMJY/NEbNlzApdi/DJqIHkcIHb8v+bIJmM99vOd+ooILGkOtVV/O903JAYQYC7CA3wXYCaOVjFEHUhcFpEAhPENQ5CM8+Wzs1g5WTDUMMIp6skS21D7dIokD+LtwSytKij8vHct4O9y6EuHK7SJRBmly0XpGpRdUpPLlUzgbGsZa+uTMq5zc/M7KPCCchp6JK9ydE+ERbSdvrz8bvH3b/JIqeoBYPLgnJRnGMpM0yjUrLvnJjEZUJb5wfUU5J1zHa0MqFHdPp+oSQvNIWVDV3sRma/4hEXTREbAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EolHZHT6Q+0bjyd/RRHxdGdRyCaJq/v78qTo/904u5w=;
 b=eiAZiYzaSmRNHmATdK1l4s9DvNp0V7ULrjZiL6u78iiSKfVTYkNsru0yD0ZJe0C9RVY7OyLz8GKLlkS601yFoZ515zYu8oPb0ZukzwkSZi7Chi19rDl2CpDURwKHLfOKLlaaFt7xKa3YAEG7kVTSYsLwF5BybsdVaIhfJ3WOWF8JavjMQcw944PTgfFm2vxFUNIdi+NYXYSy+43wbC3RKmCqlFYFMysT2TR/V9wMcOC0Wf0MEKP0jcv14NDxR5iTenWmHo3RvfDRn9uIYyXj1+fGzn+U7snxh7LJByLJp7sHywFUCGOElhBIAWl+UUi+U6mLMII8sjZfzETdFPkzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EolHZHT6Q+0bjyd/RRHxdGdRyCaJq/v78qTo/904u5w=;
 b=c9z/DKFYnjwzFQdIGec4UpAIL8/u8XmQNOB1nrM4r/pg+1+HA9SBqDaSlNEtXX9ZiH21PwNQaLlhmvMrBPBeS/x1WH5wiIO72RyYCURBuiwhmqB7tpSbKfCJZa9mMOUm9BQW+bUlQF9oNK7VNnP99a/B8rbtH4MnAyqMiSeH8EY=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CY5PR10MB5940.namprd10.prod.outlook.com (2603:10b6:930:2b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Fri, 10 Mar 2023 22:03:49 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 22:03:49 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 08/11] fork: allow kernel code to call copy_process
Date:   Fri, 10 Mar 2023 16:03:29 -0600
Message-Id: <20230310220332.5309-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310220332.5309-1-michael.christie@oracle.com>
References: <20230310220332.5309-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::28) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|CY5PR10MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b63177-8e27-4694-ab6e-08db21b35385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gucQb2DD9S16X1s+iraDvAWs2qfIG+zRExTsnGrjOiRpw6jCFv0ur3BZwy5aCA9H/QzG/Y/hTvlU0ZpFFKUNW79M87nRv4ObIzScLJqi7vuMUxAFHJJe7332uY3dSqyCFz3hMA4vrGhK5BhFubCCK4Q68m2cgnzMih7VCDvRZIIk8lYHEswNDyuGUuYetPRJUOP0jjiuZC7Qyr26KOChZklI1jsoDiGpVKS04wjd1WD2zl2OxrS79qNJjoy+os2MO3mitJPXxSUqrxv07QsIoqMUN/b+mqm7xXEjU9j7atm8EGF/T10ld4R88OR1NvbWkCMqHuGYd6O9s3umfrrzgN5ODYNGwwwUsDkYQjc7HsShBEVGon5rTz6ZG+58nqtvnxdfWVI08Jz0TcmqrD/15Mq6VDEgPo3AfDJr7ze5hALYUbHXE46gfYBrknidb6hk37UFTLd0xGwDAYJA7nk2UNBcD1m2ur0R1d+2UMNtWG7hELvutLqCxjyN7ceLgtpgIV6p43Y3eHp++c3mroTxf4nyKbrKINQ8IIkskQRH325ewy5XZBMg02LBXTuFmvzRjjb97VAQCYqB4VcGPfkS/qzo8WR/RB/pwCPu3EU/yUIdcGQ58wgecRrnOCqWepWjz1SmCHVTW8aOpzkc2H9fqljpetedD5cTvVeb8ASkFDzzFlvwoJHitLXVj47vN1d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199018)(36756003)(6666004)(83380400001)(478600001)(921005)(6506007)(316002)(38100700002)(2616005)(6486002)(6512007)(107886003)(26005)(186003)(1076003)(41300700001)(2906002)(7416002)(5660300002)(66476007)(8936002)(66946007)(8676002)(66556008)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xAmsn+ldACmCzZaUalTKB/7WVy0nhzcrknwB5Xm3f037pC/C5dAlzZyR5bET?=
 =?us-ascii?Q?F2nDoIB3QUXas4dQ0hGu3Uptfyfepg/OY/bd2njCGsHTkHNN4/2Rp11UDaVZ?=
 =?us-ascii?Q?Wn1EFVND8H3wjrv00d5GB30KZ+IH2m9jCbeBWhAFunuBip+ZxbeuuC4jxRfa?=
 =?us-ascii?Q?QXGlr9z30q3KbpYWS2sm2HHkNEZ61IX6vjfpzep4HggA0vbuWTEsVhYOU/tN?=
 =?us-ascii?Q?QAscpJOWxYEmuLD9U4nDHt8oiSXI5FD58schNvSq1SWvdpN1GHSNUR3yokmD?=
 =?us-ascii?Q?5rZeqBQP1FMfl9JrGTpolsAypsCXQw/y6kQ01p9KjZk52l7l8NdRTqcMDLOD?=
 =?us-ascii?Q?p3vrRGD3flkQBtxExwBSjyM9MmpyDgZuXOb2ig6Qtfo/LlVGERZvNpOPiTlN?=
 =?us-ascii?Q?Z5PG4ZsLBv/xEN0gKKEJYltWyrRF+SuorjUVZLZw7w6p7cjls1YOegbKr50K?=
 =?us-ascii?Q?ZiRJ+8QrXlK8dyqp2w46KPmavzQslqA11yuNK18/WGcrvC0uHiEy5cb0LrfS?=
 =?us-ascii?Q?5a7IIxL16Y3SCotHCepd3x7Z3DQUBhYVTRpNF3V/GKf1MPgj0hXWSY12qrsP?=
 =?us-ascii?Q?nQc2HDrIZEwhs4T36UYzcr/8q4cMMP1JquKm86Mph1b0RWF7Tj62Ti8IjeY3?=
 =?us-ascii?Q?vq9fKZ3R4T/l01Z3VkzQXn80jRFpb5mMpZYylKq+2Pq8sqIEqfx2yaZMaF0d?=
 =?us-ascii?Q?Zh/nGzeyhXgWkwtg7axlSt7xx+hDkoq7FPVx8TDVVlvm8ZnPDQNu8U0R0y1/?=
 =?us-ascii?Q?KVbSM4VxamooMh/RWtXyGHAjKahqaP2JyYm7Oz+9GQUpELJ2PipWOl9adnSf?=
 =?us-ascii?Q?Z2ovOgvPhxxwvA4mE/v5Mq3H2M+CqM/qNYDES1yGtaUEU8HrJxIne/mOcJfe?=
 =?us-ascii?Q?fOnQVjVwYF+zbF6f39SF1DpaQ7dRLHdX5BpZkCL8zjkKE4R8aghjfk4FC2Uq?=
 =?us-ascii?Q?9mzCxy+WUGKcb9SN9sTbRxJDdxWoA6pBUaZjoG0Z/IbQDszTksIj9390S3YF?=
 =?us-ascii?Q?q3H4rmOul+fNdRgOs9vuRHzM0eRkY0tNz3PXXlIECEKGQ7tRHGhDF3SNMpmZ?=
 =?us-ascii?Q?dIW/Js50a7wDgowoeZ3ZKPxyLGQj1m8AB6XnmHKexIAqOCnbgHjgsKrysq0O?=
 =?us-ascii?Q?YO1DBbVMjovRc479XuwR4uHSHbkXcR/MgsroRi50cpDxaIwmxoGWQzRoc5Y7?=
 =?us-ascii?Q?IRuXXXLIODNgixN4OXxCI2nDmQ3Un8zHWNU31N5xR6nn1hmq0d8SmTYifYn6?=
 =?us-ascii?Q?ztLgY0fI50fd7dZ7IerFUxRjeDY8PPi758+66aTxSv0PhkNpAr2D3zwmJaJ0?=
 =?us-ascii?Q?DKsLyLcDoQX6NDxKMoa5RW3peb1cP+opc5wZSrpr8jxdA5WFhlFI5moeyLE9?=
 =?us-ascii?Q?iiz2ReT1KFYhTP8oXavcn3t20D53d8v4SWmTsvwsYpxUMTu36mbtx6QTvHAJ?=
 =?us-ascii?Q?YSPeFUkgLCVfiKBZSNzHEIgxQHRBvgDM2iRa0DEd7fOcCkqiW7ldM4JkljKC?=
 =?us-ascii?Q?uqvS23I2Qebr+4JbKkqTX8bSqOTyu4aLS+sMb4lMoIhbMMSXN0bFd7duoht5?=
 =?us-ascii?Q?e1UUYFjewxVIFxuz+M31xek5TQKRU74UK3y3frdgas7AviiiH2ZbbA9JYtw6?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?delXFw+jI4QaSg6EWvg8uwdqiMewEE/5b9ZlQwvqKMLQrLKtkAM1alPN6ic+?=
 =?us-ascii?Q?7ohJkqAAwLzUkcubvaD+npLVRLNi2IeJ7+Lom1Xji0jU+NaTPkwkBwPG7Z0F?=
 =?us-ascii?Q?LySHF/gcu/mlhEjiRFRcOrzsQiV9+EH9+fR4T4gn9cOZ3GdbXS0SPAYErw0m?=
 =?us-ascii?Q?ZNnlRlKoYY94yTc6qUDGOEKMDR/R8NQg+G6uvS3a/D6zcTYOhecek9wpqsa9?=
 =?us-ascii?Q?rLeBqc+VF5SeNnYiYKbBs//NdAS07si7lHgrNX05fVl4G0eN6Brz80h2KpK3?=
 =?us-ascii?Q?7lcuACb8AF/ABiLDMng8p4nCC2a/2/gFLX1Tezq2Zo/FOg5Qa48r8/J5afZ2?=
 =?us-ascii?Q?ttoApEQZjjfU0C3T1DGhmY0N7f4s7N0DfxneV+QT2cDtRLNjgEqOo0JmJ6W1?=
 =?us-ascii?Q?V4MdPyu+pRFq/1sqXtunfJRQaHCRS7jE3AmJiSETRcGx9cNbqxCQBetf5L7W?=
 =?us-ascii?Q?DGsUd0Aa0h8YsBRgnQB1p9iICn2FXX5DbvY0OwhrJdAjIpS46k1vwiu0zZvG?=
 =?us-ascii?Q?4D0pq2p7rdsZxD7WoFx8rISVTOdq+D3Sq0p28vf+S8W6AfW3TtbRc1FVZzHm?=
 =?us-ascii?Q?drOPN/VmRLN6aXVg4yZwjEA0Hs0YFSwH+dSwTeIR5ycOTGKzsxrHydmIjXe8?=
 =?us-ascii?Q?kspYLjZUlt/RdZNevtCri/C6NcMEr1rVQg7jLoVvXbiYnN9PlUx4Rruq/nQl?=
 =?us-ascii?Q?2pA73B2sBe7Se7LlT8TpA3SXmct/khTxVL6+zs4IRnXSLs/G4Enk3r0vTB1A?=
 =?us-ascii?Q?Sy/h4lzxbqaYpMixHexjMfgLn7L6MEIDZzECBJ0qS6CwyAeEh3EZ8Dgy39Y3?=
 =?us-ascii?Q?MURI5aFu5Nq85cgWHLrSpY+yz7lFK1c/+OzQrddvHbX8E6mhoLPk/BG72E2c?=
 =?us-ascii?Q?4dufRIgztcQD15EsFuIiwaBx2ElBkuE4/7rBFJEZe0WYwDDQ4CgUkQ8F6+hP?=
 =?us-ascii?Q?Ghc5npl5WwyVWz4DetFVX5YQqyVSKB3JtgTF2W0erXN2Mifx3A/gu28ojWsL?=
 =?us-ascii?Q?gk1YmduW0zXaOolvQKOe3rGyVw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b63177-8e27-4694-ab6e-08db21b35385
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 22:03:48.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG9hb7moc/WKPzAu70riPIzGR40yO4HZV4uaNbW4DEUdmE9+jWB4B0E4keTAeYqrPfjtnoaNigWhI1aib6I3/wKi7su2sBTx0rci4Ooh+e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_10,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100176
X-Proofpoint-ORIG-GUID: -U0ideFEjJj6Eq0s4-S0fDIIb0A3nCH6
X-Proofpoint-GUID: -U0ideFEjJj6Eq0s4-S0fDIIb0A3nCH6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch adds helpers like create_io_thread, but for use by the
vhost layer. There are several functions, so they are in their own file
instead of cluttering up fork.c. This patch allows that new file to
call copy_process.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h | 2 ++
 kernel/fork.c              | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 00c54bfac0b5..537cbf9a2ade 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -93,6 +93,8 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct task_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
+struct task_struct *copy_process(struct pid *pid, int trace, int node,
+				 struct kernel_clone_args *args);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
diff --git a/kernel/fork.c b/kernel/fork.c
index 244aae6c2395..8faf9d0adb3b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2013,7 +2013,7 @@ static void rv_task_fork(struct task_struct *p)
  * parts of the process environment (as per the clone
  * flags). The actual kick-off is left to the caller.
  */
-static __latent_entropy struct task_struct *copy_process(
+__latent_entropy struct task_struct *copy_process(
 					struct pid *pid,
 					int trace,
 					int node,
-- 
2.25.1

