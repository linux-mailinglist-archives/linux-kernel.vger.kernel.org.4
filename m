Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608896A1E26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjBXPKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBXPKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:10:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4269AC8;
        Fri, 24 Feb 2023 07:09:56 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEmrqa005521;
        Fri, 24 Feb 2023 15:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=67XuLq65AUw4fC+ndCYxsy+aXRFVgmuRkCdm5depkbA=;
 b=rRiypWborqz0Jjfv+kd+FB3poar1zDwHs+mPM1oz17vY1SEq9Mn4V/vWhl3/5lufUvgq
 7l4f4VI8Xd/5O8YzLkTa6S7Pq14YXRuawIlnzNnnCVSN1FAiwAtrNyVI0bsNPmphHbw0
 8EiI+LmjJcvdx4eWzl/McN1b2l0+4pLgHHMAL4EBGpJyBCIgVrvTR3wBFSDA2w66p+dP
 fyvAGXm+xS3WPjEY6Wb7fVCEfvuYglZTtONpKrmtRIUeNR2gGpEvLCQqblDU6rhf6sNW
 Gx4Q9WQW1Ivuaf5LuTlivkavfeDR4rXW/7gkJAZJexrnZ8qVniUdJM1D+9QBLnSw3+z2 uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9twehh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODWTAY017930;
        Fri, 24 Feb 2023 15:09:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49v8f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJAp1FR6Hm1WAVpp/qEFIAdGCnBxH+d2TRJer6xm7gTy+mVywucblZsrJr5ZheRTrjKd1GIXihECrFxVQm/ZdhgCb8XomTQDDCHcdX4BA8CtYjT6TzSeqdHd3FcNKE9bfH4vv3dvJtPm/kCUv8csk1ZteZ9kv8Xl8LTf+thUyzXd6r+aBsf6YIbR9e11PVReoaVERGwdxsfH+R0Kx6pv6yLYiy2Uv/+Soxj4ttnVoWQ+l5wankvemIi1pl+MKG/jcSv1UzpCs30Pjg131b7VxguklWh51e2bqIP7faYDYmugcQuH6vktUs03iKz/Zq4FqFSpEEXVM6x1Bsm/1ya5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67XuLq65AUw4fC+ndCYxsy+aXRFVgmuRkCdm5depkbA=;
 b=GUSM0KTVpQhEx+vRlYyatjURmkRfM+T+ZB1PoY6ZNCW3dc09QO4exLv1j5VkufClVeaSQW0jUeH0V5P0Rq5NIo6qET9/2ANW3m2zJmBWvuRoAIbAU3JvtZa3ZwbUyXmLX8kYqmRP0QiW4Z3LmHTh7HblNLFddhJ86GOzk08bxJzNpvPvMU3I6CE0ytaPZwRaQhlAJrShhA587iCGqM3+ROGe5wOL+aTbBhxbO7kwxdlNKl91691nh/hd1/hOM6Qnj1dQY44hhZ4dtJWZ8N7+gqWVVUQccXCZ44HCIPIj7v8Zko7jUH5CvlDrO+SfhTFOGCjdjnCPXw7QzkyiKRK1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67XuLq65AUw4fC+ndCYxsy+aXRFVgmuRkCdm5depkbA=;
 b=KI/DmuaBWS2ZFCf0dVrlDgqbAEGRup6rstS1cB5yiOzHZ4mI6RXk7fUwc5tzBRrx/tKqYMwCSsgxf0nWS4R7eSxxAZnBEZ3phCmKvb9LIimqudZu+Ug+17ozBGoetEv9DcDnnhlG6n9arYLlLxvR+oCXnzjqMArd28mlXxrlZVQ=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:19 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:19 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/27] mailbox: zynqmp-ipi: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:56 +0000
Message-Id: <20230224150811.80316-13-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0515.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: c71ba46c-df46-423a-8a01-08db16791a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsaSxZtpYaxf30+Bu/QqQbCSjccIEasbyg2R3C5oFMNcHHk2LEpJwrXF47omWSqeBBewKM+aEHoLIz0J9mz+1pivzkZ6j/yoUT5g28Jt01+C67XkDc3IJymrHyRuqtcH7/FXongFocG/wDR1Ub97unQrNJy+kDhmWqv858J1ogVFz45fnoqGe+eygewsIoxYRbtaDGQOtSAjEtAKjlH/GQuDaA8kn9fnZyYwYh/dznZBYvrfZDEbw6xThrgRinVLFEw9AMBCNmZXiagd6ZjNyg5q7A50deN9WTj6FHnBsS2XYPTebDfeEm3deeeVB1g1mp4qbe4VRc7d/4oB5ArftoYLWctab5Ad/CEPA/mM5Nbe8rShIzZgv5qGFsg+0QBdXVQtBPd2p0727zULJX7F7JPNrSLSRr2jCGXthfCeyridTEWcN+3nanQ27kxpJysv6KrWhP4kBBLj4mJkC95nOPO3ABCjD98ITQz6pVF/SY+TzAfEGlqE09jre02mDV24SbsTOOIdzYqe648+2iiC1RFEA1oUWONtw2tKrfDcwJrINmpua8r3Gr1JZH0CWJ4Yy1xKOOG1eZhhUM6dM0j/KdGWa3Ei2XQX4DsOxLP/8MOHrzOLAQILz8GIC/OI+kiT9oQ9rr7l6c+5UrDc9EFKTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(6666004)(186003)(15650500001)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TLiyeuPj/GP6Ej9m8FB9tywxh38y9FP85ON83QaYeh2r7g5VxJBXue7x4ey8?=
 =?us-ascii?Q?OVp+m0rQL41MUwJ+R8TsHr+koDtJuolIk8JeSHIoh8Hd01Ad5yHx4uMlntnr?=
 =?us-ascii?Q?ZIsELz5xFxv5Ptcf8NrWwKpJnCEImLL9c/mzxr+99xLBPwcZSg4l8YfHe8/+?=
 =?us-ascii?Q?OQ9HpPvTFm7gEZ4lkhX0GA6bZ8SKd+aqpQsagWf271SlR2v5LUQ+QEDs1Nci?=
 =?us-ascii?Q?QQHydfNx6HwLZIf1z0PIMW46qtUpHhgphLIksxeUlUgtpD42uQziSkgkoaq6?=
 =?us-ascii?Q?6CRMwBvp0K03nFF1uhdhA8BTYyw2tdTdu25t5NPm81V2JSqxhUINwIR0NCBq?=
 =?us-ascii?Q?ITKOv5RgWnmNjcjEYfV0v5W+Y/r++K8v30Nwz+r5lq5ofk++VG9NbJ9PS5K9?=
 =?us-ascii?Q?s1roT7Ve1+Cp+Y/cj9mNeDL8IKh+qCjyWYc41glUWFpPzYLQFLp6LRuHY7Fq?=
 =?us-ascii?Q?/ro8QqUvWeiT7BCj/Gusn2fTXD7djyyP/rtjhmThcxLdlFniToBCLwm/ewal?=
 =?us-ascii?Q?pEFJFedngx8ghyrNbiFE1U8CRWht/GkPZBxAL7K9wkjpmsgEeO8NxxdXd9n9?=
 =?us-ascii?Q?0gnDvkNE78usNtK8Wx5LjhtEDKnSjm2oH1MKo+YkPr/UZjCBugtuhvqFLwAg?=
 =?us-ascii?Q?kWVadOxomWsSr6fjbj84+of4420mWnEOq/fVqFWnBhByipu3OqyAiXF7k1T0?=
 =?us-ascii?Q?ni1YavLI7E3Dk1o/2W2a3jDIHymb/UIazpYRLGOXl8zvTmz5S02JTYsL0VWc?=
 =?us-ascii?Q?LcpzYw9OfuxVwku6/rKP6pwTJjpQ29XhOEIGBtMjODDvN0heK6Ej2RBrzkpN?=
 =?us-ascii?Q?7Gbtwlllv9uo9lPID7CMIYvyj6H82JB3AeHCG9rnlUoWG5sKN3X41byoRmNY?=
 =?us-ascii?Q?lRaGQalowsrlOZBe3OeAY/vVVSkpH57zTNipSgMjAGX1Q9Q9zVAiPXQ0ccdh?=
 =?us-ascii?Q?Dd2x66IPKwTvqgpsaFkxfOuI2OvWXouX24JujCjDaEhrTcEGb/fAmDkPgIhB?=
 =?us-ascii?Q?9SYkfAJSaeW9ktdkArPEwHJbe4QE0SB1MM8op899ef1QSLzBxq7j1EQAHiU9?=
 =?us-ascii?Q?DojZX7H1GvLJOz0kwN8pXT9QZLulj8BLEgOrdJzZhdhp77uGejpzPP4+LQ/M?=
 =?us-ascii?Q?+tk6pI0ezLbzECaEk6GzRPHy+GToHBRKjReJo1dt7V1tVpDZTP8l9haTMpc1?=
 =?us-ascii?Q?dK0ZWQfUmxh6WChjl/KryvLhQ7ngIokSYiTFc7XHk++oRGVvXLSX6k6bx5/e?=
 =?us-ascii?Q?ILwtUKnAJtKRgl9ziU+pjlLT+FCB973+BULUKroIqAecuyQUUJKc0ZOax+tK?=
 =?us-ascii?Q?x35LnX1qs79jstmChqV4nIRhitft8JrUGYndxQ7KtnlubuRyWVmwNnhPNot4?=
 =?us-ascii?Q?CV8SqQnnc5tpG/U+5UaThjgY37k2rsHSiGC5td4FbAOU8zh5WIj36R8uxmya?=
 =?us-ascii?Q?mJ7OXMn+M+HX2xjbM8lyR406BkIbVhhdGPOyMbTf7hjQdN8JpUgqCL212lZA?=
 =?us-ascii?Q?XocuY30jedzyZ/qbCJyr/jkPOqXSd4nYc+ZRDdOGUddWhZAGP4F9YLz2iL7f?=
 =?us-ascii?Q?FRhDAunVVSYNFHOdzp8mhNBkLsGxb4G50PQvxls/HSvdhJtLPyBCoNnLl1dB?=
 =?us-ascii?Q?4aAQV5EmlOBqQOD2tE1RQ3c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9oPDQyXe0dcZKeypJc8xuiQbUvt9qm5cjR+fr4Kpn/jQH2mm/3jPP9FnUDDN?=
 =?us-ascii?Q?Jhpsotj0VF+i1KRGxBOTWzdO7dfyaz2iex4W0/cNq0OXv2YM0Z3N2SPpO/1I?=
 =?us-ascii?Q?aK4wx+YgnZpPEEKpL77pJVrQHOWRn1B+NtkayK+iO5rYWdBbrgGKkpWM98sQ?=
 =?us-ascii?Q?6h/Im7GTq3bLfRMmFemm2EPfjiFCdVWTj8GfykGobUs3nAzqCVyv11Ra2+RP?=
 =?us-ascii?Q?3NhMb66Xl8A0grE7I0T04z4jw685VVGC75hFGD2sv5kkcSEQow5PoBiUt9zJ?=
 =?us-ascii?Q?1jQNMc1k2ito7Sadd+DsTyRjxKitYv0a+1wPRwW5w3pT3H+hIqOyC3PWSCrC?=
 =?us-ascii?Q?eyQW2CoJkKMUHjN2I/ZK3HJOKg2gOZhk3Lc98VpZbo/TU9rBVthuafratyL6?=
 =?us-ascii?Q?hFBIm+sqjWbjkgo5+S/dydL15GK4K0Ekn8HZXcpE+pnBToxnrWhDZHTaPFmv?=
 =?us-ascii?Q?uCu1Gd2r7P4SOsly2h1m4HozZKt+OD+EN41tQBVe2ot0RyKERTmAi4kIIQlj?=
 =?us-ascii?Q?SmGL957zm7+XiRkIxhL5Bxm0v6QHUytfcLyqPUhTBayu3A3Ap61Tmg74wXrM?=
 =?us-ascii?Q?am9e/BnEdsmO9MLNeSzUYZXwJUSAdVT0Rf9AR3Gu0925s7wCnP5iJhZpk8rh?=
 =?us-ascii?Q?6/w8K4gpibx4tZFbSVYxlTOa3AQMFRw10Ypt2ehizmG57b62hMUMlTkGpdw/?=
 =?us-ascii?Q?X80EtaNGrpoGsnyScXBem8snw7SXLTIAEyPS/P8ehev+hU09/XWZg6qbZ+0u?=
 =?us-ascii?Q?/GF7XodeUKlDtKW6FIY4/okE+HQ5JZZg6MCvelGenvDoRPr1dD1in/d+xMlZ?=
 =?us-ascii?Q?mDEkCa73dyVBtKqEz1A+B1V9M1oGsMBsmML2oRb6FqTvUhhHlgrJBaQUisnt?=
 =?us-ascii?Q?uuoWBxnWiXQFxsrxLZ84Lvq6wDTkBxJ8jKrapihvc1RjsEO238y4/D3cafQj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71ba46c-df46-423a-8a01-08db16791a92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:19.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwh9mtdmh7vA5MejR+rFeS5ln/hFKbrLLr/qBFCksW6iV0TExM+VR0Y3ChQERUkOTaYWvZFb1h79AW75kGWjvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: 3V6czWXVGJaUog5J4GVlMOZsZ3JnQkxr
X-Proofpoint-ORIG-GUID: 3V6czWXVGJaUog5J4GVlMOZsZ3JnQkxr
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
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 12e004ff1a14..c4619d31477e 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -718,6 +718,5 @@ static void __exit zynqmp_ipi_exit(void)
 }
 module_exit(zynqmp_ipi_exit);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Xilinx ZynqMP IPI Mailbox driver");
 MODULE_AUTHOR("Xilinx Inc.");
-- 
2.39.1.268.g9de2f9a303

