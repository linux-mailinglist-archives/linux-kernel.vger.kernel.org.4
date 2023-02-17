Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7313769AD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBQOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBQOML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:12:11 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7307969292;
        Fri, 17 Feb 2023 06:11:53 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7hfYX014901;
        Fri, 17 Feb 2023 14:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=MkbFxMkbeF1hxwptFRTVrRNzdsjIshcMzIrnLT/1fgU=;
 b=V2ABMx14hmK/Sw9LfUe7aYeqhCQKjSwLhacys5WbE0+TXXfFWDPjdWijyKKyl1zWCyeM
 uLa1zvzjQww5SBy94+NiWv+yvQYffLYHo5eR/euPB5GU3kKVGdsUiEReqMndjZXMSsgM
 JwSOb19J/kRC7LG3MdtwqRfjFCE+r0pTO2vCk25+oE1MQajLNHYPI+EAvw02KoQvVuSM
 BPc3AmqkcxuvLsXfAorU+KafaSVBSBTsth9Yb+xInsOdymjUaj4b2nZZ2rG9uUg1Lk5x
 ScIazazbv3Zwq8ee+YBWspWspigjXUKjz9EE6l3Q1scYloNimqzz6juJL+Oj4yD/U51y sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2wa611q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HClMFx015268;
        Fri, 17 Feb 2023 14:11:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa7nrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 14:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwtlpMAZLgtvxZZfHFbpUJ+cNnGPKctKEREOVPAtutnWGJ6dLI7Y578U+Q8eyd6hIAPoPcobjvczUbEHPIfUi0KIeMRyfy54K4fOWgkgJwWZskOE/O7d10K6gLbQ+wUKjneu8LYDAXbxPxXsdyOeUmLtiQ11xItHE9aHpXB+Kb2s5m2y+JwulzStwA1PizK5ZLXuJLZiKdpjMXmexls8aYpAnbgrYYXBQ5Z5lFNPbf15oNAHE9bkN5pnPJ1JlXTCf9Z6DzaOaP8Y+RDHmAIJqDvmeyH7zJ84HXg6WWU0hWWpUdLyMMwi2sNoC9XNveIJJ3LIRUc57dCgJIngr8CJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkbFxMkbeF1hxwptFRTVrRNzdsjIshcMzIrnLT/1fgU=;
 b=AHaT9vqwsGPhJSgZK2UF10ezpaGwJ3lnhwqk3XoRP+73TapagW81JVAb+w8mbmZMSxOa/jxdobpRXbE3+twAbPpBZi2ilQTxHfCZHjOmoUKni3IV9ird/TlTg9YA0VHxhCfjyrVNiMmonHdXRQdqzOGUMuWw08ES4KysmZ0iQ9Pr7tmhhfgroineQ6DrHP3Ls/6Bk2r6TMrxlDe3xfQeZ5YqBbG60K60+HLPj0SiQlrWuN508EviG2kno4nzJqMvPMWPLGe3gje1+8IL/3zpMw6DzfTbEGECr9A6nZKznPZTzvMSwaTejW8uPEi/+tnUWoGyPCQTFXQnUm1A8EbFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkbFxMkbeF1hxwptFRTVrRNzdsjIshcMzIrnLT/1fgU=;
 b=O3Z1XO2BtqwRUlnDdeSIQRp3/Xgu2llvX1T2KbC/N/2VdDKKJkTdT3adA4p3IBDAR5YJrxy0mlohXbXUFuzpF1HQl1jqqkMOvCHzMZ6FjkOqrOLH+6v5eGWdha7qg9mV4jrjYyTr0FoVoAfSd188PQKbKJFqxiSm7imI3426GUg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.12; Fri, 17 Feb
 2023 14:11:43 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 14:11:43 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/24] kbuild, bus: arm-integrator-lm: remove MODULE_LICENSE in non-modules
Date:   Fri, 17 Feb 2023 14:10:42 +0000
Message-Id: <20230217141059.392471-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230217141059.392471-1-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::30) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SA2PR10MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 334e64ca-f343-423c-5b50-08db10f0e531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zCbMzjsy3oBOTC1vx39gZBUbgv+LiY8FxcyVTng3Z2qxPDth3QflZiqIRQsIAZvKTzSosMO/xC6nE7mGQG3somaWeMO4buEUNyGjjC0qaJG24HrYDYkm+4gRi2noHvWk7qiqmJqArs0JashKq6zdkanqZ+I7lYM1XUK+382rRp4VLu1r35RDrthqb1mZKRbX1cpKvV5NGxUsuJOAKB3FEvlPEcdcfYxCpTmr4qOEs0P1vr0vgRvrUHkREP+/uEkTu4AJD8uC7R/r5GQ2f9xbSQuId/gMfeBkZAzWucIu+FT+usKj5ygtB3s2p42j/Z0F9G+TAKsQxCFIPpkIw1s2bJPbZSNPFufrEIePEfJ+lv1EcS+u+F0osoufJhyS6HepbjzBq1hFjuAnYEGqCRzq6KTkqs2x/RbeFsXYRP7hpvNOwTFqrfsDznrElifMWoJA2A3ZeDdTjv+ydpqdwjPTEk30yLEgPeWud9g4L68hJZF1G4TtOzvJrvMDRZjTq6BWDH3f6wL0Ft2y4jTAwGeT0ba0RP8SVnh6Q+Nhq1LDxC4fNErPV7HT1KjR3Of1PBHrALBCf+vfa+PyFgYCdM4d6bfQE0el1pS27dlEfwqIMkRUKGprhGbjqUxEd0nYfAqSh9PnzWYsUf/JgyjcsNsXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(44832011)(5660300002)(36756003)(8936002)(86362001)(41300700001)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(54906003)(316002)(38100700002)(83380400001)(2616005)(6512007)(186003)(6506007)(1076003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gVirF831hD59PAMupzUtrRprABw37iOVZfiUx2tsEj6ZLt0DsyVhcB8nR5zd?=
 =?us-ascii?Q?dd/pLwiexZhrH/JWOW9mx1PoT6LTUz5J3lcWVwYCRFmq1HfM4jl/FCz0ijNb?=
 =?us-ascii?Q?htXLzMWmsrOucfCYwaLw/DpPYxGCF8GpIEPpQvegN86ioyrhYaX82BCRfzU6?=
 =?us-ascii?Q?/2KmKoJebJdqAwmWpiH+9sRCnxQRkgy+Hb9Hy1kG4Cgd6Qj4UEA0okJfI4VW?=
 =?us-ascii?Q?zPzyEMx/hFckTNZ8JnrH4aLf0bYUMvOSjAj8Cvg/qzrJdCSjIYGY9JAQIXtP?=
 =?us-ascii?Q?ZemLO7+RlsvCqMrJ/e+5WI4Tga9lGp9+dwNc/RUM6Xhxtyap5mpMXkwv6+/O?=
 =?us-ascii?Q?cRdHT4qbnfIYo97RqPcC/P60rNr12CesE+xOGdLLlXp4Bxb0onMNebQWAl4l?=
 =?us-ascii?Q?lZbkcdMQzNKZzkZlTiFC10wOew7m7h6FDcQiBBz9DMAFc8R9nSj2lP3ELi+B?=
 =?us-ascii?Q?O/MSSSCILTG0V/t8muVoGtPxWfyP6/3MjQ1n+USSQhkHX4ZjzYOsspOSQNEI?=
 =?us-ascii?Q?5iyR35U7Tj1xt8nIDYHhc4dyUk3Belv1EI3i83u5uwq8hCQ4N9iPMEp8iz1d?=
 =?us-ascii?Q?54eMTIFyAH5WO7EjYbLVaKuBiGnHzkcuhZsuwmodsPs9dzNwqRyM0DbtevSk?=
 =?us-ascii?Q?CVZ5AaQswpEjEOl1Uxt5IUyU555CwPPTpj1XKsax5kwScj6ErKJz2IMJvUk+?=
 =?us-ascii?Q?tvCbLrS2SnN/UVV6cMNVo1cUlNnRoI1hY0Cyy1K7N8tKmhh35XfLOc3mzQOf?=
 =?us-ascii?Q?ufDOORejIMRLX2uAfVcz3YuikvfDVWQRmLkDFAGaLdsCIWXu5ztUNYr+YC4v?=
 =?us-ascii?Q?ffkhBUCqSn1Zi22olXwxGG9OZg32O83qKF0Ys4FdGOTr1KY1lHS90nrgScJp?=
 =?us-ascii?Q?ImF2iW0maj/YqhSraNvgp8gzdXdutcYoZRwNZEcjiktnv1Y7V7epFLbgdJBx?=
 =?us-ascii?Q?5N0zd3W6PacmkF0evZK6ZQ2hXvha3Z5fWR12SoOIlnQbOAeUUnCCKwoHKdAi?=
 =?us-ascii?Q?OW5z6679Hpu1Xtj6YCasMg4qXHjtSZS/ZcTpZtTGz3+3CiFNZvNFElSgbaCJ?=
 =?us-ascii?Q?yqjHxC5wEpA64rAdyU1+T/lmFpe3HVRPo5dVaXaGGPDp6TmmzqME603aw6Mo?=
 =?us-ascii?Q?jTTHgAR2J3OdPWgaRGxeMo9Ia2n/RhorFIYC3XhJestHBp16LqeYxJhSFEet?=
 =?us-ascii?Q?/6N8NSGV176SiCop/N3prjESPC6bJEWzbpi75+8+QADEYtSjrG1qSzLClbtt?=
 =?us-ascii?Q?/cVTmT0VnSaEPwvMRJbxx9pmBT90BsWbyak7ZrfLUsJHY+/YEHUWUMxoUs4b?=
 =?us-ascii?Q?KyizRAb/kG53F0Z7JouF6oiIZcbFpIYGOgcahyFicDOGkgfkE1NgCEVF2jjK?=
 =?us-ascii?Q?ZVB5jcVmSbPz57n13I5QU4I+ywGVd6sDtEp0HLDpp9DoC8iVWDCizLmGTX7r?=
 =?us-ascii?Q?OHXQSV97+WVFsf021/BlqcAlhvfIP/r8Qn6Bcj4s+y1iDdLKOoyRBzBuJgBP?=
 =?us-ascii?Q?+EMl+VbLxR+WqtrCUxAfnXeiUxbQiOzAQiJyy+4UgN/FbkVU1bqPseHBCFy+?=
 =?us-ascii?Q?UY0nmValZEtkR0DIQRz33isTXYgQ4QIz0LQtD/jtX95rGVeNimzI1mrug2NA?=
 =?us-ascii?Q?H3VjWhJwtP/AXAyivvqXmQk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eihRkZNaEyIOqB+mtdj0BW7DZ6x2eSHwnmjh7eDu7PYZ+bMEimeuCG3nEAKClPITK0B8sMprQPZ65eV5ncfPXXyMg5kfkXsNkega19qD818bcm3hxuLHihkARg0VqCU08XPs5Pbao0UuIiOBslT2XjEtx9K9baViCCLNIZD0qAxREjXFRVosGd8e05YOVpz1M8hYDz2/SbYl8Ok5kHMr0pNLzcyt2VueTcvu85JZJc4J55lCaSavAtWc72lr8hg3aupneu0zABtnsY9FIlGSGXlsZRjfZSiApuzyhRHPYtySmRWNzsSKDpSvMHQ2YmAFYYwV9m+lpXZJzb/jKOFRELipijSQX6f7/b/JtFhVW9wst8DEnsARyFtgJICD7VmVlEIifLzPoeuo1g7WA3R4qOXz98aMovNBLCoYBWV0eyYVbBKROB+B07BJlMoPfZBxJd52VHWsI1nScWBtLvFEB8pDyp1/dT9a9iOoEOtCSvQpGD8q/Al9PIyDt1GipcPzT2f8Hcyz3S0cu/+Iny8kIIk2LKxhZkLPDKgYvuQRYzEmsXeyn2nTOx8AaFFIvY6uelKQepiozILfKTJ/K61MEtaizqX+6oCcZMWZN3VWbS8f42FEt+9g6sv1eUI/eAGT0qdR6tbpysUZqmKvZTStBPcBIXKegNdBYSnaVuJ/VOIFmWKZYI7Z43RMhY9SVTdWH1+yxwKvDeSJxKMH5xm6tHTUX7ROi7qnuE/o4nKnJh5hakmXrTo5mv4l3Hl6VGTVDtJo8t4GG4UjtediSqTsWkmuWx3/OVkRkJPg9WA5XrwGA0fRHfk/SR4qxguSz2TEH7RuiDY2OE2Shossw6vp41/EAxW32R8l50BQbzZ3/OXFZGe1xSjO+7cpVEJwIosyUFp9A4LpB6zploHlirkE0Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334e64ca-f343-423c-5b50-08db10f0e531
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:11:42.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wps/qTXZazaxHq/GzcjaVmku5isN793GAfzaSJ33KmpaKAhQlZjLjMN9ZPmEMPmXCl0rM+hN76Cs+XNIdmAzdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170128
X-Proofpoint-GUID: IFmPxx0xO7lwXK8JdfUm-fjmUkMzTR0m
X-Proofpoint-ORIG-GUID: IFmPxx0xO7lwXK8JdfUm-fjmUkMzTR0m
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/bus/arm-integrator-lm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/arm-integrator-lm.c b/drivers/bus/arm-integrator-lm.c
index 2344d560b144..b715c8ab36e8 100644
--- a/drivers/bus/arm-integrator-lm.c
+++ b/drivers/bus/arm-integrator-lm.c
@@ -126,4 +126,3 @@ static struct platform_driver integrator_ap_lm_driver = {
 module_platform_driver(integrator_ap_lm_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("Integrator AP Logical Module driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

