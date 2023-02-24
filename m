Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA486A1E25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBXPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBXPK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:10:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05604688F5;
        Fri, 24 Feb 2023 07:09:56 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoRAF007465;
        Fri, 24 Feb 2023 15:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=uD4Cm7onBRqrJ0SMiRRvSqHMQQFPr+vOdtYmLM4NMT0=;
 b=2tyIEJG/MdW9VvBvM09JBwkxi8DYGwtZ19whVW1/nwQ+UfLplmqzZrZjdIQ7IaNegb2v
 PJp364jQwf8PrvulCX8Z7o7WwpOSUtQG6I8ghL11UubpkhxQOI9SV3ltos0WCYgCdrZ1
 rJzZRLH4wkG9hd8mh76AVvhJynmdOKdRWeMuNIWUXy68q/+f3zldmB5o+Ib5GbyNphtr
 HsxiR/+nY9RlcneQPzBU3p/zaHhU98vbnSM+nujK1fZ0ZwXlKvSm/HeY6LmoWId9/+k+
 dDpHGUZc2OqLlnWPYyu9Z38xX3Wfwsa9FutKwAAQ5M2OjdWpx4qKhTZFcO+DjiH+0QwT YA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90wb43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODh9Mf031681;
        Fri, 24 Feb 2023 15:09:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49qna1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdnNEVONbu/x795MbggFvaqz5g4PXfBZTM120wNcORaVUsSVYfkIeXnFgER1E38YJ8BhgJJzKi7iBzwONCoh25JDWnVWlBKb8lsesRushTyePZs+yPzm/8UiWej0SoPZQnToYnFpxQY6YS7qvvIvODJJtjQ4ZiNOZ5/zrzBY4sksidyvxztuwPJoVFjhL1QnNHWpqxz+NFk17WpvF32QFq8f+avLgUOm6EWETWjj+GOLvzT1N5esfpW4pyPY6mxRcbpahAVQxfOg2PjHjNWzJl+Wntv/oRRDshMApn4isZK9On3eXUBa2Z6xwcOA2UvK7B6nlp5wZa3bjabowZjV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD4Cm7onBRqrJ0SMiRRvSqHMQQFPr+vOdtYmLM4NMT0=;
 b=EmnDftrS20PUet2j/aGmrixIf8p/++4Qd4iikFkfsAH7741rqPq+uGd0dmbBfZ6yzJ47/wIQAVa+e5j2mjBKCZ9OCgkqGRvViMMpugetnOfifMoULBHgEJRQcw2Je2aMhLcTFLicNnJ4PW3YCRbKwyJVHbyeWx8bXpYMb/SFhXshOsuWtZ7/dF9cTnDokp3eg/vq0ALugQUXVyhKG5SOkGgDh+c/JB1N7r3k2AvvAx9TteaiJig4JXZeDsMa1dBPtC8OYdBXO1Po4bmtcC00PMtr1wJKOHrszdKV/zmwyfgrtt+NYcd4eTT6SckNESCQXAgZ7aTERayMqBpgcgwMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD4Cm7onBRqrJ0SMiRRvSqHMQQFPr+vOdtYmLM4NMT0=;
 b=uOmNbjqVjjgyXjsvFFDS3JhnifU6BjQK/XZcf/r7RHyS2V/vcMN8/wh7MCUXfPweIwdlIesqMWA7jGy9O01G62H/r5e1o2qMVQded3v0Bcfki8eeT8ZuhxJWQr2s8kghey3oE0M73OSeIQGtCG1el0V8njs64VuV4UG8AV5BUaI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:15 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:15 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 11/27] mailbox: rockchip: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:55 +0000
Message-Id: <20230224150811.80316-12-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b6b5a1-812a-4c90-7db7-08db167917de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHGnuOztv+wQWWbI/IgZbNXNa7ThcPSIkbQvZX3i8e2nrYm9zXgg1OECpbG0gihNHb8W1md79vSowY+0OpzZa4de58qmzCeSAle73KmUgJbUUDZfqNuryGcE6cmkefAjZ9SMBZIBQb72/tYR1rpUJ0KYCNjHCf1fKa3w+yS+RgVECINJMihj08v9Dve8/m62Q+N1IctVVJX+l68fdGU88xKJWYM8nBWFUJtWC+COgJ83s5QrtTpQod5f3jfO5dLvQGwQZg6XPtesNifRBES/ONmpwe4i05p75cA9q76uC4gX2eJXZ8Vi4tTY7b9433Atu90xuwU/TyJSs+YSX281InBtXA2viDtq+h9PUp7B5/snQlzJxgryn5Nlsgy/Z6gDXR/iS2CsRUY2WikFZc6B7/ARTQNwOrh680T0KZ7Y+w+7scGxBwJhfZPw3NzbLFzFhCwwVy2mpQahOg6rYhe5VMReksMcxIiHaBD5tgrgAXYLdP3hCJtYf6GzibQNF6y91Fg+08WKl7+Hi37+et0rSNXBdZZYU5GpL8jJ1m+vVRrKifxTKP/YppBiIOlScYVw4d+uaLBg5icO7GJR26q4ja03N0/mTCTAcqNJGYEpu2SH2gRUiAAHihHNZib6FoetEKoglIW7AOjqG6zFxLVLpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(6666004)(186003)(15650500001)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uECHE4ovAeLUffAOzw4dMIiA52D1l7hHcHXbprCWWABTVv7CdeH/bmqX3q56?=
 =?us-ascii?Q?eU8Kprz38JimDJDuFmhyXxpmrcEWLsTn6CIQrIrKKhohw/O1IHFZwIXCL883?=
 =?us-ascii?Q?OXoGHblgTVfpV9+ssgw3umVvX1Q43TVsuWZVgTZ6u2gDRx93MC/bfY8GEqzZ?=
 =?us-ascii?Q?afDCbN9rYSTBhqszskfCNZse7NYD1JMNe9EN61cPv5T2vROHRINhXp4plxUQ?=
 =?us-ascii?Q?pWNH1YqJWKXcjwph1W6mCE66c3j/5R0/A0ncS0mqEik3AeOKfunX1IrLZbfL?=
 =?us-ascii?Q?13TGBVAcXnG4M+bgm+0UdD0mwiQqbGFku+zt67AxdvGwH4TNSTVF3D7KbdJi?=
 =?us-ascii?Q?lVAHp/ebAcHDiHH4r1otstUsMqZCC81LQ9o94gKULgkONspMtNWALbytPnwk?=
 =?us-ascii?Q?Gr4IhlMlKEVUFCIdyrie7jH/AJUa/kZj7h9esZlWhMRJ+DRnPN1M8TK7rJOj?=
 =?us-ascii?Q?nicd5jtWiTPI5FsbIx3Rj93cb5judUL/3LjKftXgSnz97fRZ8sYHA54LGG6u?=
 =?us-ascii?Q?apNYRyqtIXofizMtEYhAWziZDxaQTDXXHZVRe6Oofb5HmbV32RZjknI2ui4x?=
 =?us-ascii?Q?EwLK0TwSed0lBN+SrEU1wqZ2og53u0gXjalDbePd39te9nQujEGTGdbYJPBU?=
 =?us-ascii?Q?dLD0YNBQDoBlfwc6qpcOdTEhuPDMjEfygiJ13OZnUeNZ73mt/URMLbE2tkHg?=
 =?us-ascii?Q?MFu0g9RBGKKIX9i0eaOPVB52X9ilgMSiM06Hr+HXoAZIJ5ubIztdrUTl8SuN?=
 =?us-ascii?Q?tQLSTCZgtUyoF0xk+Lrc37BrnTdaHSIc1RZX/vSnnHm8Qth1vP1IqxttnFbX?=
 =?us-ascii?Q?ud9EqErs77TK9FSLZVwmE9lkngfoj/0ZFwcvsE2IKG/bwo9t1UHjUMkMBM02?=
 =?us-ascii?Q?WsxSgA17YEo+NhcLyRpKPM3ib3O/+ZA9nCbqgu8OKLnhoEfmJ8Dzp05WjyuZ?=
 =?us-ascii?Q?N8KHBZh/wuib/NoZpqx9OzCKqSRgeYEMT/lwKGyHFOXEwqYHlj6vmwTcED86?=
 =?us-ascii?Q?ipES3KAHvae5auXuh9HUI/RnWdOi168gIhXSQAV7w0Ni568uiAuRS44iRe/Q?=
 =?us-ascii?Q?/WQN8Td4n5eg3vXKUMO8iekd7Mle+B+HRtJUW+Njd64/vL9F6iVU6qkHWGaF?=
 =?us-ascii?Q?fGs3T5RL+428WEO/sdB/1aEfFmmcnnFGOLNOMhi+8MwOMb2O5AhtZItCy4r9?=
 =?us-ascii?Q?0hadYQJslCPSKc09HUkp1aWH7akryGcA14XWzOpin2q8DSOLcIfqXXcNE63M?=
 =?us-ascii?Q?J3NbCt3F7Z+5fJT7MiPmH67CHyleEUvJI3WnqHVmKoCZ5H0OSvUqgBbsMU02?=
 =?us-ascii?Q?AIRMLuVcqi4wCrzQxM+s4np7cCu3zPUo5375494o6uyeT0woEVBe/uzwTDJ/?=
 =?us-ascii?Q?z2qaBaYUU1u5oTFm0gbJtu3bBNsdYiOE63sDbL4ZaiGa3UmSMVY8gIoKPPmE?=
 =?us-ascii?Q?yl0kW8id9iFORcLa4hshGHUXGTfemEBLcjBRR66bxdyvzZDPOBQNwTZjoJOs?=
 =?us-ascii?Q?F+JFJS3mC9gsK0af9YFqNCBROAj+QjO3GueyUiV4EZeKWkgGyn+kKzKVZkto?=
 =?us-ascii?Q?aFP0nrJwm5Y5MdQ1LNYAk2Moi+bQT0tWBgHhZ1Z3XArsC5//kEo4k15RA9Ct?=
 =?us-ascii?Q?4RrscMWYPX5ex+ldDvR/ZhA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wsV1c0iGq+RYlp8Bz06SNjx5+yky5X19YVEh9TR0127rASwnByuYWIUkMFa1Hvl7C3KBDq5QmKbZAG+UdVzm8d0a6iyqz8do0F0Dc9RTAKT5HNvHB5cuaIm7ysLsSb0KOjJO3m2i9D0pL4IS/nNvBqo7PSNLTogRCYvR+cpTVqilVrq0xz8dFsLxlAvhXCBo06OPXla08T31uGvRk0nz1sRHEU8cdhpBKpfHxappix1cpbcC6UmY0Xqq8VdT8pKzHmry0CcKCJRcu8YJi6fGbBlKNxdXrYNmSL9ZwZQW9+UZIhxpymr4AZjkkk672LB83m6YFTPGO3QpXnn4SBconBv6n0Pc1YYp2KBBF04Gg95X/n5x4CWjwGHMMrs1rloWG7goTr2gSC0ZPGZKQ8Q7e0J6Ryg/2xrIKVMIyxdWARhwdQLjdbqniGdbXecNOvUidJA+7POhLyYNu72H+VpGJLfbAW1Ja4Iz141Qb5Kk5R3DPFk9d7xhvYyzfNuTOL0cuC0Rsugk7aOX0YMCjId9PSEGxlQneYelzBhmVeBqcNgSK05Hv/U5TI8obGM+J06s/9c9X1BaCSw42OywZLDE18ZAphi/Epsaxe5t+tPWPZyC7oKhqD97D/W6fBJIASNMJadQFG886jBNraWA3VBG8AUFfr+6MhLwVXk+/015yQ0UvBXP7OUGB+x0n2IIus9AJVzdDEPLo1MWQU7CMyEHcu+sFAmuFGI5a9E5LlLhajwyNtAsxloTFBQR3ksiQHtITCsYUprgrNw2uefOPZM2nEIvV9b+ud66aDFX6BXh4XNZMs3iw+3xUrPWWqSD2tWCxAZoy3Z8egXATsDRId5/K3ozJUSvmHFR2pW80LQgh1Laf6EpF+g0NxOLY3FqO9mmn9yMaQ2FCJr3c1FD8t1Bdy1SkbOl7UFGdq7skOUMBeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b6b5a1-812a-4c90-7db7-08db167917de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:15.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEZFaO7Y48aWIPU/Eh6MPiKgCocgml29sZPqfTN4Y+xzVicww7WaUdScMnBp1sM0A1jgbSeSAp0cflb6HOCFag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-ORIG-GUID: agZWTMsE4WXcnbZXykDGEQWgGBY3dZyQ
X-Proofpoint-GUID: agZWTMsE4WXcnbZXykDGEQWgGBY3dZyQ
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
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
---
 drivers/mailbox/rockchip-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index e02d3c9e3693..28d7bfee2641 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -254,7 +254,6 @@ static struct platform_driver rockchip_mbox_driver = {
 
 module_platform_driver(rockchip_mbox_driver);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Rockchip mailbox: communicate between CPU cores and MCU");
 MODULE_AUTHOR("Addy Ke <addy.ke@rock-chips.com>");
 MODULE_AUTHOR("Caesar Wang <wxt@rock-chips.com>");
-- 
2.39.1.268.g9de2f9a303

