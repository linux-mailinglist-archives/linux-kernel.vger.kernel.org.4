Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6343E63C56D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiK2QpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiK2Qog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:44:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4EE421B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:44:36 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGP2cO031397;
        Tue, 29 Nov 2022 16:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ZosB8rEVTgf5GQn/ef/szpP3vGboiqP7Fx3j/tGEBYE=;
 b=OYe+22U4hntdSh+mikxH5IaILWJ05agrVmwO1TU40btdipNDqkQnnpW1aZD68930y2wr
 vxNuJy4aF8+y+zKBazMRBE6eAl5NtCD+hS6ESH+c94UdssVIH5M/Z5IsUovRmgCJrh4q
 Y1C3eRmdl2nAbjrOWMQi/MfL8K09l+jUZybFnMGksM6GLsWJOQfUBmnkFgXMISc9Hhdz
 cSnJ6FGIQfARlG0bIG2SWspvixhGQkkflragOWCv7sB8ne/PRBscoDK/4PC1dzAF2im9
 94elTl1T6Tv46QC5Gwws/kiObO7nADSHCTA8RWNYt9Uxxiv5EoYgZSLxL649WQ+SyrQq Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m40y3xarb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATG7rBV030968;
        Tue, 29 Nov 2022 16:44:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m398771pv-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7seCoa/YRJysx32Ew0uYf2ugwPOJn80iMlTYw6fGkrUlFE5rK3pURFzHBTMiyyHERP/o9o112J2RymyBtIZXQHT2vhe9Bli/ZbGhc7v+aQAfHK2ZWZo66oJytcq6vrYdy0mzE3+5MFNY+dvm2l06hZp2c6tMNX0C5s0s5vg55Ic1LxxxDpLseVsV1DW11LskW2tCHoTFJlCAPNYKG7phVdfoIlXVT2daZIX5UiDkWfec3R0FmESdvo+0Sa9UPLDd1HmAF16TUM8A5GqE33tThqDaM/Uky4Egkhi6dmYlBvEjtqkhWR1qU66ATHQrTdWXMqY8Z5+9D8qE4KoFQLV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZosB8rEVTgf5GQn/ef/szpP3vGboiqP7Fx3j/tGEBYE=;
 b=cxoD3pT4h2E7Pkay788AD55TYk/Awg7rJUWNWyORmlNiqJd62VyDPOAlkGF1s398B7DtHE0usTBJLhRugYf0t9swq612TNVXSXig+cmu18K50m8QNh877BjXW9Zazi8CfpRveVhFtUx1mJbquM4PeOAralj0t2HZp9LaKlaJtcpjEM7K6vd20Dzx/g0hJVBgT1JsQoWn21fYxOp5E8ys83HIxFQg/Gk/kv5Q+dTx8LiJKoSZg3DW00wkUx3ku/XZp6paniAzdazDIGs7DP/ajpyd3hTYUdDN6xa9z9Ue7A3Zl3yadrZZbIdv9uBZPNVxTiGGEqXjZRhT+swTHVm73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZosB8rEVTgf5GQn/ef/szpP3vGboiqP7Fx3j/tGEBYE=;
 b=NiRD0gExVv1Tc79sDr5zJv2qkvYSkBjhOUAhHsKZNCVW5mgJ6/r0PjFbX6JEKKhIqaqXpfzqjJumIm39ct7TkOrZ8BHqkjAftglNyNwAnYP8/qDhS5OaVtnTQzwvQUA4P5HXcGd7f80lPViD+DHmFcqfKGyuGvtMG/Ey+qVcwtA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5321.namprd10.prod.outlook.com (2603:10b6:610:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:44:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:44:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 03/43] maple_tree: Reduce user error potential
Thread-Topic: [PATCH 03/43] maple_tree: Reduce user error potential
Thread-Index: AQHZBBHUUpiEpUBqt0CsvfaXX6r3tw==
Date:   Tue, 29 Nov 2022 16:44:20 +0000
Message-ID: <20221129164352.3374638-4-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5321:EE_
x-ms-office365-filtering-correlation-id: 3e1470d8-dabb-4f62-b9d6-08dad228f71e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+XgLLe+/pr7/P4kEsZy+u6RqL+3axD6kIqO7xZYQcEYJIiAC4Ik+2SbZQBBG424lAj/R1WrGk6h6IaVbzQq5WJxv2Co29azgGamIykymetYTaSXShcJtB31fydnn2RIlpRIHaeHQoTSU5FL6GW3OcHsbSGGQ9KTyTTzAsp8HJpQvxGmv05vy2WCzz9dKvQVXA7hMBitbWiTa+rnGJgVCIecBZydJG1VMV+Wbc1PLUDFpvwkN7QSOnFZpae/mJGphuS2G/wyCi/5NLk3Sfxyar6Hqouyi3BdjRHLJx72PWl6PqNvfXsiu01QlgWFWlyu2xvyTQFMDRxtyUkf8UrQm0Q3JT1Mx7G2oUyZmw7AJqgSakkckcc/YF1juwvLO0pcEBDELa38MOToKo7o5Ln49+uStTZIr8NyD5AwJxGVF9t8sR3WT0YRpPbp6Y/GtG+DEkzvDKTzKngsQLxJf31Nm3tueKayLvgFHLYTQHI73YN+eMZCaHPkxs3ZYPC9t7DYog2fE5AcMLVsOZGe2fUPkeSOjq4WbJjgWp9B++v8nwEpWnQm9Onq9SZsWdXT5qO7mZVyb8f42iGVRAoJN/Kn5iit6O8bza3D5vlWzZydGNb8EVr2HWdidwL4YoYqZbDbWd1eYSJI4nfClMd212QhsFkF9j+veXL17fzUrG3Ca5qifWbWjZ+ZSU93/uLHEMeWPevGVaGWK4LHBkb8gsUIPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(83380400001)(54906003)(71200400001)(6506007)(107886003)(110136005)(6486002)(86362001)(36756003)(38070700005)(6512007)(38100700002)(122000001)(2616005)(26005)(1076003)(186003)(8936002)(5660300002)(66446008)(478600001)(44832011)(8676002)(66946007)(66556008)(64756008)(76116006)(66476007)(41300700001)(4326008)(2906002)(91956017)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KqjpCkfcAuzvxAvA8ay6J/6Hfh1g7Pp0pxM71gvGfcua1DPW8rFwVEMizt?=
 =?iso-8859-1?Q?Hzd5Qh17on2quqXbTrqxTesYbA7kx3TxeE20GDFP7EU2kX7cnar49n0KK3?=
 =?iso-8859-1?Q?VH0VaeY8Y+CoIElS5S83oafcIg4TpKSwcVwkKMsysqjlIkQ/cWhj2MbM4h?=
 =?iso-8859-1?Q?Mjku6vQYTe+s+fnQ1AWPs5eENNvTgNp3psCTqgCni7glpXginokHsg39a+?=
 =?iso-8859-1?Q?L5uDJ4S/ZqDhjs1SQ9hxJ1RtpcmLomToLlbR69gtK/2iiq8bza/sok8brj?=
 =?iso-8859-1?Q?blRPv4mlfGOz69ldR3XMFpBzFTzIvxGPWAFMbuRU8xSZXF2PaIvd4+KQnG?=
 =?iso-8859-1?Q?kbMxa806jhP8Nh1+/+ZK0v6XGZVvgmKc0ij2Z7MMTVUKoEeocoMP3SkD78?=
 =?iso-8859-1?Q?UU3yq5tlimIeJcByksmhHpxk76/5eU0UzN9RPdy2ZRrtrn7aePU5IbhTwl?=
 =?iso-8859-1?Q?R59+rm4uttTmKlSpuI5BtpFftR7Je0FRWj0FSBBToENSDDKv0qkfRMqz5U?=
 =?iso-8859-1?Q?ny89a4qz7PrnHv45osAGwc8OWDCzHX6l0YdmAyziHxZZjLOykgBI8KyAKg?=
 =?iso-8859-1?Q?zT2jfz7ANrhTzSa6Thq5tk8IId+d6N0edYw3I7D45O7nUalGfc8cbf6Z30?=
 =?iso-8859-1?Q?3I5xItf8cf6vTgkmHLjHoaCc1y3G56ydH/+CTPK0ejcrd+c3CtYRP5lj2b?=
 =?iso-8859-1?Q?c6n7VE4qs+PfHk8A57KB//kPi+hvnAhNXlPsMSC6R6+tuVxYHCcetn0rNJ?=
 =?iso-8859-1?Q?9NCjdkgquYOTTFvaiLknZNdRzpNCdUceHv6sBwXUT6fAmsD0/JgbFFbUau?=
 =?iso-8859-1?Q?jjeMj1JspDc8hF7kvVkKF4EVyzdHmr/r4b4ogIFGCgIMyIrt8wy3UD+0By?=
 =?iso-8859-1?Q?WZQIwaUXwdqOtaFayMarBgC3uEV3zw+JeElHvlLa3iGFsfX5C6I1jjK83o?=
 =?iso-8859-1?Q?QQAKIpBvBvX7g1w2i9dULH4Kx+zWtLLkd83id9M/QRLIOymySTe0q1/66O?=
 =?iso-8859-1?Q?GKrruX0puJll0niZq+DqcfXpnpBcvbjNHprGDmT53OzBc+7MMCTaeWngQ9?=
 =?iso-8859-1?Q?hSb0p52nxSp9qfJ44KxnEzSYAE6DRsW7l3jRDD9jMGS+I7K27Nnam5wsdg?=
 =?iso-8859-1?Q?edvJxk+3tIenc3XQIK6041AjIWaiFcSLkips1fAp6mgIi8ZfBCYn185F50?=
 =?iso-8859-1?Q?GtjamLHyJv6kLOiGghAKytl7kUF1yBR1MjCJeTJ9WNiSQd6Oz9zCmkzzOZ?=
 =?iso-8859-1?Q?JOd+WHDhKQWS1A/iTi/Fv6ZjY8Q1bcoNX/qbN/QO8hKYtrtjFKMY+ZUOeU?=
 =?iso-8859-1?Q?2NLvuatZJ7PTvySpvJ0uinAOqasuGzy0oA2ma+4aiwUSbcR6UoU8NPR2NH?=
 =?iso-8859-1?Q?Mzusc9+7DdsRIQ5AEG0+zZyY0QdRm/TKfHeSIu2WxJPlW4ajHLMrZfhYF+?=
 =?iso-8859-1?Q?TLMqDtces71M+pS4Ua7Ll6YS0RJvEn14mlaPH1aggNzfZfcBN53G6lR70b?=
 =?iso-8859-1?Q?wHHlpsGqs0W7hJI9Ozbml5fpzF3mg9WKqhGOlKu5iTHdo8fldO5i5+vxmT?=
 =?iso-8859-1?Q?HdlFYWdzamWhTQySZpkd13Kck1RMuzL4QB2Qs1fMVq09pRa/SO6yF8FNd8?=
 =?iso-8859-1?Q?y1V1EVRBnrZ9feVUaBvQrcZdaAgNS9JILX4YdPk/1o9mz4mKJ42XTB+w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1BZtxfGdWEoXdw0jFPbpLKciD3Kk/tbD7qRe4W4ZzEP5ptDbRqjjo/k3FMLOx/rVjOjh6UbaVGMvSQ1LUohtCWVt2rMkWnncdP7tQmUoVNK4B+TuUpxeBErxDV2RIcL+YV+/mXraBbPlhTXPhbYwjp52eslvT4S4qST6am5u8lHyg5j85r4ViBqQxK/6nCVnwxL+O04WbwGdw5TpBhyCTklrV/xe0C9wDpeIzGpmGxinmZF9KlWxmduQoiSPiZTJUF0Fs4MoX2+AFOQpgBVYcZIQgOri7HtiZq3yNuw2tMCczo/9RfGn609hrpuLtU9qdzegP+Cq3fqhyl4/TdEkX7fHpuSwnYGgvwibILBDdkpuVm14WoyyWcpXAjSINQ5YDHgDwJT2zjqUYt3KX5K5BRMGcCkYh/epRPP4S/X8jiPGqgP2vKX5qtC9hOesQ3MrA8giGC5fUUiZq4IG7rJzXD8M+gz/1DMnlkrvhrAzPju+CtcOLnBr75GnpQ9CveYcamfi03dv+20ofHp7dYOPVN7wPIQO+R8wnggXwno3B6A5DqkRF74/fwpAuHROma3V3TAo6te/VFb4GhhE2cfU7C21Nb8G3AEwH+MLSqIct665y1ppYLlAmVcfHFh2YilGzIdfYte242WTYCAT2DabqHaFrW6jw4dob0a/jFMa4mw2w2vyCQXeJnRETToOLZ5VY260aURBCW2FSMoFfY/bQ8BUj5CZLf9qWSFtpXaF+gwXn7u+w6PFaAV4Ps1b33uM1Fut4UGjnBZ0N0GVBLOeI/M58+I8R5qwbxiEnyK+IX5m2BZYbIJOGxOwKiEiunHaQ41itGgdpOHryXH/tBisc5Rsap9YycdBfoIx0/PIRMbHcTyCpdfJXbTcfuY9C2u+Oh6kJIaOamncXTYXeCc6ug==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1470d8-dabb-4f62-b9d6-08dad228f71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:20.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwapcswNL4uANlnSuMcnYJlnuRUejqzL4fcS8ixwzgUiqAWI39nmze8exGit0nKT/Qxs/bAuw4MlwG5aZo2SFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290093
X-Proofpoint-GUID: IMMUhTvDqeyzXiiR3VVXyV1SdMbUg21d
X-Proofpoint-ORIG-GUID: IMMUhTvDqeyzXiiR3VVXyV1SdMbUg21d
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

When iterating, a user may operate on the tree and cause the maple state
to be altered and left in an unintuitive state.  Detect this scenario
and correct it by setting to the limit and invalidating the state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ff28bd6d4745..440539ff0d11 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4735,6 +4735,11 @@ static inline void *mas_next_entry(struct ma_state *=
mas, unsigned long limit)
 	unsigned long last;
 	enum maple_type mt;
=20
+	if (mas->index > limit) {
+		mas->index =3D mas->last =3D limit;
+		mas_pause(mas);
+		return NULL;
+	}
 	last =3D mas->last;
 retry:
 	offset =3D mas->offset;
@@ -4841,6 +4846,11 @@ static inline void *mas_prev_entry(struct ma_state *=
mas, unsigned long min)
 {
 	void *entry;
=20
+	if (mas->index < min) {
+		mas->index =3D mas->last =3D min;
+		mas_pause(mas);
+		return NULL;
+	}
 retry:
 	while (likely(!mas_is_none(mas))) {
 		entry =3D mas_prev_nentry(mas, min, mas->index);
--=20
2.35.1
