Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF365F450
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjAETVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbjAETUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:20:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313216D52D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:17:48 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUIHr030165;
        Thu, 5 Jan 2023 19:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HmgkQ28QOz7ZNEWXunztBpLVHZCE4edNWbiYOCDwRN4=;
 b=AqnUsF9/fDFRO2iJ5zTt9NftNr44FpFh5qvjKPRUH6+7GoE5fhCJAfk9YI/2prpxmQqx
 +PTjjBSkCJWGqzyIg7QnOj3jGnruSfH98KzX5OIyBO3sCnTP76eEcamO0ABcYKLTkBmP
 15uJw3GZsOY0QoscoIBtQTajafbI2xi2hSEjxlwY3siuBm5Z+ekgEmLH0A8vgkpFvjEb
 4da1l7oM0fpLVaDgL8/iclD1SeaV3XAKtZhV1O7xq9Rshorr5vr7XJy7WMG2dVYwxMRJ
 B4L5tMlSp6E+FvRiK2/A6b4L4QgK4zxdsRtQ5xDHgFhkyrZWOKH8TPsTTrEi2HbDilmq /w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9kby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305I9Tnl012151;
        Thu, 5 Jan 2023 19:16:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf0u4xq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjxZ1cUhPPlmOs139rSLWEnAxVmNBKTQtfDvzB4TjHjGhkdehVx63Q/WfOAS7foCJP09fNYtg8dCQ8NRPzbKKHL939ahf2JFPswWHozIEedj76QXDcJ7st/7rAAvwJNK58cjuY6w6oi3M+SYl00L3d0rp91bnKir9dH0LrjzF7NF4kBTZDpCq+I2EWp3cRrrZVgKbzdj7uvkMpn107iK1jQ2YpfeY1Rxm47VznmKDZ/XuvuYACr70VBckSbqzzFLzGrXcdI88JmZUeTq6kQccfbO73OSQgGNkGPpO1+zlE8y/YmCsKvjFZAWAzMRI68T++c0R1XJgCQlyUtXtAQiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmgkQ28QOz7ZNEWXunztBpLVHZCE4edNWbiYOCDwRN4=;
 b=Vi3DXD+LSevdTJXjJCAWHJoTD41L+UEd69rlKNR4KXigaSQc2nvM6UnYRZb54M6FDai+IvF+a81IE3lsjZRQ4Zk58G9rc4Q3hlKgE+R84Kd0Lc3NmQY67xmYJEzp3MeIb7ijW7vPRNIhFVHUCQVYJvNrHPGvYx106HFvew5cdFbdBXYQajWqDgUwGCavhAGGSd/32B5rE0LVSAV903t2xKkMrSk562RN8Mdm4ZxJhQrKjOrDT+Sbeew8LrvWNlPR5Z5VxUv+QQFePEBPkVWPWbvpT0F65CqrCfvzvPKiZgC7qRmC5mEhcNIYn3esaKiRfjMwCcJXp0i2FKEwCNa7FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmgkQ28QOz7ZNEWXunztBpLVHZCE4edNWbiYOCDwRN4=;
 b=tb61EsKroFQuZKrmVIPalVwLgY3JbOEGBfqayJQ7Z74y0lGgZ/rjp5mOLN/JZtRBgbDESiMkpRwDihoJLViGa3Rybmup5rMccPL1lcvBPTIhA+OqD4e20mySmPp/thNM2Tg0bLOzfwlimkVXwWyz/UMF+cze0y7L4QUtena4+eE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 44/44] vma_merge: Set vma iterator to correct position.
Thread-Topic: [PATCH v2 44/44] vma_merge: Set vma iterator to correct
 position.
Thread-Index: AQHZITooJ+5o/wSJjEyVNtF78Sn/nw==
Date:   Thu, 5 Jan 2023 19:16:05 +0000
Message-ID: <20230105191517.3099082-45-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4791:EE_
x-ms-office365-filtering-correlation-id: b6b76d5d-a603-4a8a-3e11-08daef516126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X/R2plOro2MLTgv/Vp51QKSPAQm3SX4IsaNaW/9PF/Ur9m2xeaNkkWnpRyO7bdG1SW+zqkRwndTZMIKDa12D8NyYNKx/FyqMrZiJl836v7oMjlt4OzZLR5VCknselm++OUYj/17z6e4RkMzpoc4A8O92SEgZPP+RN0LwkyE9TCeyJjolrtzWFXmDB/vk1l8xDPI7usSZH5A+YkShbTitqn2FEKbaR8HkoXFVw8h9oAHTJoeDkLk+u3RurbhZ291kFmHBry1+gtlQJp4AMyaTYFWleXSLRmbCwD1LX0Zz/gedjW7rR2cpp67Dg7MwEiu7YPtki+zF3QBaL7+sEvdNwO4sZ2Smf1geiSxxlmP6jywUzIZeE4qNmzoDmcvsHZzJkF9BAG7KhoaaN5zd/mYcVDJ4d5DJTOhp1Mo95hJ8v7f/sqvaISto2iON4xIStntmowvR/30OdF6u3dS6t6D/pwD9H79WVLPdE7Rh0pZfeE1T0NZYR3TbF0voR+DJaNXSG4Mi9ePSl45AM79ftXm2XpCiqCXeI7wgLRM+ZKfwVSZCk4NBXxwxoT4ainpirREQrNp1xbgcFroz30fiiU1l0dheR3ut1UjrxeDTg7Bp/Xqrxbu9LtRp9eIyrZyST4AiOHzUyEEWJ1My2BL1Hg7zpWx8akXgC6atGg3onQxkXKJt7E97+XaRU937pEL9DhcMp2ZhsJwdY+9krRvRrUszcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(4744005)(83380400001)(8936002)(5660300002)(38070700005)(44832011)(38100700002)(36756003)(122000001)(478600001)(107886003)(6666004)(6486002)(2906002)(54906003)(110136005)(6512007)(186003)(26005)(71200400001)(66476007)(64756008)(8676002)(4326008)(66946007)(66556008)(6506007)(91956017)(76116006)(2616005)(41300700001)(66446008)(316002)(86362001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nNh3q6fryNVL+2L9Vi7PLPpJjwwpJxOVNCRz3ZjDu4cr3uvk8WA7pmrd64?=
 =?iso-8859-1?Q?xBNDxtxwAAKqlzsHEVu7tOj/MYTzMhV3GGxKpIVYT7jpnRxhPoNR1c54Xb?=
 =?iso-8859-1?Q?eKfZozw1nWYskjXVcoF30Lqix4CjqagiWxxpmDwJXAiIjEDpOzbTS2AmhN?=
 =?iso-8859-1?Q?oghA+wplxJq685uPi3gMdkQ/14Cl7RJABWJLBO+vSfdkbbWopBWrNb8v94?=
 =?iso-8859-1?Q?L+/fWuo2abnmwDQ/7uZ9RFb3Iv4+pCEDXB6qthy4mya/BSzh4HUaRavycq?=
 =?iso-8859-1?Q?mHrlnyswPOCvcf+a0W/564LDeVTIzOpaF6UUtU1Opt7r9ICOnaDh0ESXSU?=
 =?iso-8859-1?Q?z+ehpfHCQkj5Vw9se4ZSYe0U2HBT2RrilWwXqH8Bb55iHL+fjdQeCUVyz5?=
 =?iso-8859-1?Q?1jGGkwAcxhsbrrVpIqT4fS3qlSLOpUQHtIi6IDYy4WjTvxr7861QOYz6+M?=
 =?iso-8859-1?Q?sWBqZza8fdSnHn+cWyvaEdviwDA1Ll/xz0tBjgzIRoFUCmBA1soRXIxHh7?=
 =?iso-8859-1?Q?OnUYnNl5YfanTcsEF4673zg7VMGUbCVsHkX5Lhm8wOkQbT0WnAbw1GNahg?=
 =?iso-8859-1?Q?O6DC6SjXrA1HTRrb9xFI4Q8JtRjkxd9X5x7thdQu/vqikLPg3i0ZSRBcg0?=
 =?iso-8859-1?Q?XK+xKuGxgrtJ0VDXWDHKJd8/sprI94z6XSONalKLEi31Kyyu9fE9t/gtVl?=
 =?iso-8859-1?Q?Sg9rCoF7uuBfv7q8+lE91LllIw3pTTH9BoxwQQ3HX83wCHfEx1o+kZbrfi?=
 =?iso-8859-1?Q?Kv9hihf3jYUiBoz1aTINJyAPYGMhruolgyXPdeYB33ymZyQ0quBmZxruLI?=
 =?iso-8859-1?Q?CyOy/SxaXjfdkogaelaHu1cDdTAXVNoVSMHR/z3rMwWk4DtkxTb1+Nha2H?=
 =?iso-8859-1?Q?2lh4Jq5Wkg4boEY2ZXVTc3gabpX6aNLpJJ7MQPrSsJxcgLoGb0i1WndSip?=
 =?iso-8859-1?Q?dT4UCxdsD1yaZGwvTJcX9lYNcil6LQdduOelUwJAp9jdet6/1my1aFhMRb?=
 =?iso-8859-1?Q?sXcjmKK4ZHv5bPogehW0GwkvxmcTuFTadEWNy103YdXz+/hGv5+1JNaJuI?=
 =?iso-8859-1?Q?hRQvMBULYai+Y4VQT4ePhdKLotK9tLUMMf8KkVm+5KzqeiEJzGPr6EbI2Q?=
 =?iso-8859-1?Q?ELJfBLc8iJgioavagJOIsgMv5maNP89P12eG8cEdjUupjlRARwNUnxA06z?=
 =?iso-8859-1?Q?QDqs4pClKDS1yn20PPrFaRoEw1hiOPqreCwCvExMdYkX5l62g+SGnLH4Eo?=
 =?iso-8859-1?Q?chGiS8BFjqQf/4T7N9oUQiRg6xiIdqXWlabV6Qymow164tFbI1wwvhCwf2?=
 =?iso-8859-1?Q?U67vrsIoh3c7awy+SzLnVtD6wrLglaAwdXCqPEZPY9aAXc/sa7UlEejpHh?=
 =?iso-8859-1?Q?efxO0qXH5Z6Esee5NlJ9Y0Pm+Y9uQIMpodh06tn+auBLfBEH/Q/XDMkExq?=
 =?iso-8859-1?Q?Bb4eqTLbgGHRgrcjA5qJrcc5tlJIrn5g2QdaPOaugUgB1t+CRXgIiTptKG?=
 =?iso-8859-1?Q?6YDgDXvjbazzGhiYnJAoF32wAbdvyeN8aB2tBiREPa//HsTHlsMgk6WJWa?=
 =?iso-8859-1?Q?0v00xR+NFnULfXnJuNZojvGPLXxOVpLJoQViCbzsS5z9X2DOJB/PHDxlVq?=
 =?iso-8859-1?Q?gZT0DQgUm5J2O2EsaTJf5JGrLWiMcQ14ynhgpEZ8MJXUZVgcBYgQIEdg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b6jtqnsv1QGs3MLrPde6gXS7gBVSRNOOFd6seaz1xtOahP0kV++rekhtWZ3JnobUV+ka8jEWx/1Lj2rdLG0UBvD1eu8GbqRLjdNETQ36hnHQQRpdL3kACLM5NO3VMGfnDGlVvTsIiOq4zRP60TMK1cgNPILYcoBym9Axhp8Ll5tg8MuSGgQnC+0t44qm9m/0lDsMXfd3nfF5KJAsd+/MS2UJ9mZaSZWQkFaGaJSWr6ZP/1Q2gSaBg2OIWkt6L9ZRMIioIOz+2PCh0+PUUwO9ReyLbzjkH+uZ+vTM+XzblgEeqWxDjdjrIZ6e9n8VzILfsytByfm2xmCBpT33uKDinO8S3fDaVLpFyF5FwEyaMFU4J24xzLXIekw8PN3Y8OhL9nZEWHVdYTJ2kdq0jugLZMBKi/mmQwSrgm21/udHDUyehK08uupd69EkUkS5t2whHyanwXg5w+ceoCWVLFBF10e4gLXK9Mq4qPneDQ+Rp1Anj9Dc1M/FCaUEozFuqli00UwztBsLK1uyAxpU2c+Ak0qhHX4HUYAO1xuhAyuxNJu8rCvLOU/N/lIRaD2Pk2lg9jCAvrhDq32TkGpOTgdyyLGcSrNh531MZ+oynIoZ35xeMm4z8bYRGnq5FoiarLX0PvEWRRtONhjUW4aewDyrhRe1MRTK1JnC0gxfXT5Wyse0aYrOfLuBHAR8q6tXdiDddFB4ZuNay6NRZUXySlvUYSRYk1WA/ezS2EjuBkhsvmJPAYqQUR2vKpfrcr6njiw7mRTdrhvjumcuuO1Ur0wEpwnNNCuKz2IZB0HkaxyeWl9ZkdQvEd+/YaEu5oNebNGDyVmeN8ynjs8o7uAi+vIHtJdLslp6Q9IiEeR2gpRDo55jceCYROlGiH/EzepN5otl0Av34TAFL5jH43lq+aJ2vA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b76d5d-a603-4a8a-3e11-08daef516126
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:16:05.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3CFjJ29dxSN4AcYdVf4icMEzoWkBtxp8J6j7ryZ3J/SuL6lzPh2OXvQbJhiH5OPgQZgvhAZJ9AHIymQcyNfKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=977 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: CjCJIEYrWf6fG-MX3qT4maONUya5GcQ4
X-Proofpoint-GUID: CjCJIEYrWf6fG-MX3qT4maONUya5GcQ4
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

When merging the previous value, set the vma iterator to the previous
slot.  Don't use the vma iterator to get the next/prev so that it is in
the correct position for a write.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a8dba6b6c34d..66e2f1b88c87 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -994,6 +994,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *v=
mi, struct mm_struct *mm,
 		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
 				   pgoff, vm_userfaultfd_ctx, anon_name)) {
 			merge_prev =3D true;
+			vma_prev(vmi);
 		}
 	}
 	/* Can we merge the successor? */
@@ -1085,9 +1086,6 @@ struct vm_area_struct *vma_merge(struct vma_iterator =
*vmi, struct mm_struct *mm,
 	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
=20
-	if (res)
-		vma_iter_set(vmi, end);
-
 	return res;
 }
=20
--=20
2.35.1
