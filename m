Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F351663C57E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiK2QqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiK2QpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:45:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962776457F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:44 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGQ1wE012682;
        Tue, 29 Nov 2022 16:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fQ91Lje7tYkNzBw0bSrk3E2yqJ1Cv76dP0pNqKsHZ5Y=;
 b=LfScxEWOx259Bh9VC6YS1yiA+FDNpbwUKCtDEuCdjwyHljNHMqN1l+/f24Lts1QPOZfJ
 F5oPSHo/gSesnQA3et9hzWRt/2Qct/cHvHIdHqzTQhkgzu3QO5Bs8m07K++/ngZJgNUr
 aaMa2KFaQYQxDnV3VKtZ31TUIzSR9wviw6UTAjwsXiCb93nbr3ItUA6O1DGEQYL4ZOBN
 E8Yr5kzT1eFS2LexNGi8ltBkb+JuiY27eOix1At2G9enjoilwdOYkgsrYRhs+UTH1F6t
 3Xwq7nPiYk95Lk0f2e6bqKuMgDU52QZxNDIdbzPFoovBEUAfWXxp15L/AqPHFDwmP+Bh NA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m4aemdn9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhsPj027963;
        Tue, 29 Nov 2022 16:44:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m3987f2au-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS7ixbCLEKqnRafSFZ8m3HbQ5kvzkema9NPUn4oJsBASK/mMtMiePUe4AfQ500Zg/vF5PcEl/5a+hliKvP12VP1LQCHXmgiiCk1CofSRvTsKSLTsTv8SmSnHmRY4CNf7YETo78JUHP4xrDYr/mA7vlPzxugNQU3W4u9MB7ZHiQLkcjNKVpANj9W3b1dsxvVvNowIVhvN2DwIq+LPXtrjh/DOtIaPiUefwtNxEqDiwTyzSAECXREzHeuUq0wiIWane+0M8pDBPeuJKMGhrWl/P3JN9cpw4cGYnp86NN7MLpxssrmbYocm+C1OtiZJZBsAhVIihwUcc+yTzCbGOdmVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQ91Lje7tYkNzBw0bSrk3E2yqJ1Cv76dP0pNqKsHZ5Y=;
 b=UaH2ffDOxi3Htz6O4tyGifIPL6/PnJvi0YGTl26dn8vEnxjxIFXtOaIo07MzvU/G35iTs9GVZBkuVVBk0L1cy66K2shlYsLcFEPydL7BHv7qvjZDlMwmDzbS2TdOy2ruE1wxd3es7oN/75wvbHt+ZhYJdHxMsKItfltmkbgiz7Gw/h0QEfTpcS0JxuJ1oBOWdXfqZ1B40YzALQ/VTX9KzvPwGBqd61U12I7ly2imaxMpUR1aZwZDbagXF0fjwkTQStos7YQuDB9I6JCrP3hAsOOhl9HK5TxG2RN8B1vr4dhJ7ncu6gncAF2j7dbxyaPU7KaCDy7PFU6iSQGn3W5dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQ91Lje7tYkNzBw0bSrk3E2yqJ1Cv76dP0pNqKsHZ5Y=;
 b=ChDZWGl+oGQjXSlJIk6tADLrFOppjhr2OiSvOpu2H71qQj3R+CPqG/jNT7BDvqkmSyTZ4LOLunxFxHEEJQQQ11Eqaz0pLjiAJFEmVXTl5yPWTll+09HSpu4oM/aL/IZcD0fa7cSvUc3gfoluvYnQ6X7AYbkVapO/gJMqnu8ivG0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5788.namprd10.prod.outlook.com (2603:10b6:a03:3df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:44:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 17/43] coredump: Convert to vma iterator
Thread-Topic: [PATCH 17/43] coredump: Convert to vma iterator
Thread-Index: AQHZBBHYMBt6S0euQ0KP7f6cIcv6Wg==
Date:   Tue, 29 Nov 2022 16:44:27 +0000
Message-ID: <20221129164352.3374638-18-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5788:EE_
x-ms-office365-filtering-correlation-id: 75895d58-484c-470e-1d3f-08dad228fbe8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNTS8ToaY9McGF3CWJjDYny6BhCT/rRgAfdhK1/TPGXgeOpf2kUSSPOzQB+YpXcIyP134vPT+AQEqmQAhxD2CISnmq53kY0yOkL3INp254/wPYFho7m6aA6uhBdfYQ+srWcBZyNtVqTb5eaWkYxM7U5syPgJ3s3ARs4JBsSTE0rQJsGPdsgGlPeMNgFZmKj9ianZ/khztNQ1EbYyAa2mvJkr8JNzLBNdPH92M6RhY2I+OUbIPILvuzJA3hwGDwORr8VPjMuQRNmyu1fL2fkdg2hyunEdvZh8rPqXxLR9b9cOLkEvmIYKoYZkizdL1I4af1OobRUzB27TBWLY1VD4COBB6VYL1rbiLWao5MliIS4SK6/rvvNnnOlBdNpJKj4/nL7g7q5GAXvIHRhfd+7f8BpZvXguCD8hyyrD3agnpohnxOtoAp7LeyNaNijrYBcsj7zIYk1MnUo56QxU4a8bXtSmTV8G4jx7+fODGdoiGo819QP6rGRcg+5khnrZR5/F9JwvQXuUKm24LqTPRawYtwC6pQTHMaVxkOfteL+bjf5QFwbTHjlqlB5zRGUTZB+DGOaprA43RDe7XVEcY5bl+1lbdpS4zB7nxSJk9x+B1eIVvIAwTuHEPH3rSsYUflRmMB1aOn6oZ1wJKtu1Apy3wnHZ2zLFYi6J7cK7Ml7OsZ2TZjFZ0LbyW9tdxwFHEDTFSpI1tLYfwBp9kgrcX3BX5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(2906002)(44832011)(41300700001)(76116006)(5660300002)(36756003)(54906003)(316002)(66446008)(110136005)(6486002)(91956017)(66946007)(71200400001)(4326008)(64756008)(8676002)(66556008)(8936002)(66476007)(6512007)(6506007)(26005)(2616005)(107886003)(186003)(1076003)(478600001)(38100700002)(83380400001)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nVQXdseHe4XZXDb15qUpM3kcrBsSk/ssHYKOStNYoKkjkuBir0FmITqSed?=
 =?iso-8859-1?Q?AVru3+ux3f6jMABP/EaUTof1O8FH49TnWWkJHT5jxw+26WqT97uQEHTQ0Z?=
 =?iso-8859-1?Q?+xvWHYGPZa1i8G1jhJ+S/JMjlpR7EazWw6cBuL8sRFidVpQTD6+lHftzix?=
 =?iso-8859-1?Q?avCSwrxUlbT83SFCZQbs6KYrFL8LCwaVFMco6lf3C2qW8pcuYUiQ96E2bv?=
 =?iso-8859-1?Q?L1caGwkEdjuY/7OQHoQHmBvm7IEToHXArNDtfXlgGhrAk7htdSUU+HgDXl?=
 =?iso-8859-1?Q?oYYno+0/fJkqqDK7/1BioszPntB8oI7DXwixqt4WUpWI9NzKFO+54tHddn?=
 =?iso-8859-1?Q?Yf9JFtSWcIDuAwjxNalnddj3qnry/3/9k+E/fImCjlnm2rBXkrxlq5Axgd?=
 =?iso-8859-1?Q?dlBZhoSr7gQgqSc52B7gyFn3dsH1P6G4gyo+2FlCUfv5euBzdImPBggwje?=
 =?iso-8859-1?Q?CP1XSpptwFll+hzku3UTlLIkUAye3GRxjQQzxlBol4qO9cOoBYfxEoVL85?=
 =?iso-8859-1?Q?9s0z39ucdTi4ZclBBJOavGsewHSfwx5pbbFTRZIKJruMfU01JOihwWEc25?=
 =?iso-8859-1?Q?Zw5OU7VfUzG9todFiIGsfygnkgSoCewo9TrPmKcjz+slcSy2IdPf+LVqP9?=
 =?iso-8859-1?Q?sz3VR41t/lvJfFApdMsmHxRorR5WOvdcmbxPm39NOWiMT1r4JsYZ1PkA/4?=
 =?iso-8859-1?Q?gbDEHiGN3adIeaX/Z0NUBaZi1xAk5cT5jvBp/f+507CGs7O5kKlAwGyE8W?=
 =?iso-8859-1?Q?Oap/d+OvkG2s23UztfSefmjU5j0BH5HgR/zROvusEN8P2gPLRi55VCmNbD?=
 =?iso-8859-1?Q?Fe1QDzrarGMPb81eb7/3DkMbnhhOAaaU+8/II5wzXwG13loOyj5kVLnUwM?=
 =?iso-8859-1?Q?oe77snRQluw7oZYNMDKfFCUKJtLs+vVgMmuYN/Bvw6zHs1gN5Vh7QqC/Ok?=
 =?iso-8859-1?Q?1pFW0j/yMCLyfeE4hRh86W9XuilFK6WEM6B4YbqR2MGD8IA3Jm9cX5N4SV?=
 =?iso-8859-1?Q?xyS9t+rJ564fct4Cf249uZggvYRde2RNSOvkPbosA9e+y2T2JA6qFuNT/j?=
 =?iso-8859-1?Q?U7xfvPx094soNjyLfOG97EDgNdz3umoaiE+k9wy5YcBsxTqDrCYMPoPVwo?=
 =?iso-8859-1?Q?0Xgw1j8N+k3klnV7A7N2ECpEPtwOwvxhwD5w67yr1Y9GTGuQ2LDZ2FBD4q?=
 =?iso-8859-1?Q?VfaUiqG5EqPjn2gjKxfRUiQNGGbUv89AbFa/OaouHQy8hyDg4RazaiwyDf?=
 =?iso-8859-1?Q?/obi68ySzruBrmZYsa4+CCWbewbxBBxUlqpHp3Wb71h8jqZ54NkQmyqJgG?=
 =?iso-8859-1?Q?lE+nIxPqAjTSLQFUzmf8B7z0tj/xlUljrhp42yq2izpjfZ/VkjaE1kSfWj?=
 =?iso-8859-1?Q?u4H6g0c8QO9aBgbO7IBN9PD4eFmudArCXYaN5uw+LKfiVS3p/oQ3BJ+47T?=
 =?iso-8859-1?Q?L0cgTq1hkXaQmrcA+LiRYqan85L5d8PNcXNxsT+JuMqiMlaDibBkY2x+YS?=
 =?iso-8859-1?Q?ONAgpWp4Zz0O1zZf2ZzxhWZnRyRpV4MK4QJ79X5fM0kHIS3ENO571LfpYn?=
 =?iso-8859-1?Q?2A3qNbILOb/NG9te4PdPxbxgEdny53o1sHqAXaiaczbwjFFaKH1avoBaiC?=
 =?iso-8859-1?Q?b7zEcgnedaytcajmRbbs1/GqQZbkSIwmVUeRvgFMpN++LYiWpit5hLlA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2XeViv4Rs4PzDzeSxCZzTXNAEgSwm9/HAbHUTgURh7fJPBR+wGjXh8+oa0Tz3XKxFR2re9x5Dlis6XKkudT1Wdgf+rMElg2rVormuNHTm6xaJP/m1PuVgBYJOlqpJg3/MyloIkBbaPW5Ms+nEPz1vNoMbsatZVuCmZjPesumLtf/T/ZvswI7JNpFYh5PT5UpmfexxZ3HNHA42AlvT/GLzGMwrXL68w1wOuaysTLl5IgucxF4qmH7z6+pxfEtty1O0CiTrH582mFuy5tvXNMq8DSDKOeNt74xP+utEo2GF06aKInYaRsNZLW9FXyMjIP604dfXsaOFovkH+e5BFi5l2dIimOpao6ZlfCQfWWJteR82VoZf5T7UA3Nq4yQdZR4Tf8f1wKO5Auvln+gAxQBLNRsCc434KYmhx9MkYPKb4XtJWkfVAN9TKQBMnE3VlOzarEkvuuk8562V07wm6KmAA47N2epxMRi23W/A991EkncW3Hu2XGvWVnmHwTXwhEwtfBcJEWRm8AxhP7uLAQu95XK0tGxtvz56TkwIngOM3RqDuyEaf0wqUmAOVzlypRb0jvmYSeD6Ten0MXz+hSly92cdd1iUN1bIc50SPWwhdsjm3XeASRoN9qB7t/xIJodtk3YG8H106ZpgT5d2oenggcnppAd2wnfe36bbJE+bL+kDEiDQUQ+AE7uSpUQnP/SMVNUs8FjBphCLCUHek9DB5O+1hTACWuqsSR/p6DjOru6uF7WHqQVMcMdO+NPO+Qshc+iavWTQsqIMhH4gwF/RPV0H1cCTrV3n8CqHc/lszFCw+QZoKofoIjd9Va66d6aYa7jQWHbyfIrAwWE1oRgCvBhwqEKeH4MuyZtnapAav6YvFh6dAzIhZsJL3NQZptsF3fBnBgtz5pMnqCxoWrvng==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75895d58-484c-470e-1d3f-08dad228fbe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:27.8634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcCeykb8hXfpaFq+ezHvGvCby5g5gKn6CfDocbL9TXS0XNwYjlC8ponvJBRS1rzxAX3rCtujj8O6pqAAHt5YNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: 1wd7gPArU9FACsIbvHlYtqVI30DI88h8
X-Proofpoint-GUID: 1wd7gPArU9FACsIbvHlYtqVI30DI88h8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the vma iterator so that the iterator can be invalidated or updated
to avoid each caller doing so.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/coredump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..bb1afce78f45 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1104,14 +1104,14 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+static struct vm_area_struct *coredump_next_vma(struct vma_iterator *vmi,
 				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
 	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
=20
-	vma =3D mas_next(mas, ULONG_MAX);
+	vma =3D vma_next(vmi);
 	if (vma)
 		return vma;
 	return gate_vma;
@@ -1139,7 +1139,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 {
 	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	VMA_ITERATOR(vmi, mm, 0);
 	int i =3D 0;
=20
 	/*
@@ -1160,7 +1160,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
+	while ((vma =3D coredump_next_vma(&vmi, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
--=20
2.35.1
