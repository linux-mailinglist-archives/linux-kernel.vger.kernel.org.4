Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2365F43B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjAETRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjAETQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:16:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED1E032
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 11:16:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305IUIHl030165;
        Thu, 5 Jan 2023 19:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=22Z6OpYufdBtzxSvf9B3LFJ2NyY1sjKM0+x62TTuiWc=;
 b=UHllwHGBwCQ+su8LmWECIAESoIoOfC7Yvqq68MG8LTpJTfl+89RncQsiW2LBL6qQtozd
 gvyBA7sTUTa2+Pypgz5+3SR7UhRK/ZI11zwbo4roFmx9wV994MR/B+HTwn71WKw8Gt8l
 17LGe24Cb3dUB1reQ1u0CbjNqL4GTdNJrREPwK2iny/8DsUEF+aCq2AHzuW8jCpy1g4F
 3lu6H7LPFSD+MTMOsd54ouoM1A9UKKgelnccS6mx1wgGRbcMsXmrn6seppat8cwF+m3N
 6XGbP3Zc9racLgmFZnqhnKzPoKtvhf61fkU2h9QFCBpYd61UyZkfsQ1XYkuNg2dxBCvl nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtcya9k9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 305HgaKV033879;
        Thu, 5 Jan 2023 19:16:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdtsj1fk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 19:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGnGaSW9WJS1HBJN+9jNPXHhuq2cavmfT23kS6TCWQRXnbknMniacJsOYSv7kL1eaumqS5MwGydOqgYQnkz1ChE/EmLpHuJwmmTpfhkreQuHyoQXp9JfBruC1m/ZwJKSC+dEtt68poNbbC2TbI8SkHVl4/FiLvjtl5JVdVv2Y0ZrQ9UZfOCrSW/3sxcAwV98k0eav6WsWDUZZYi5fdQ/ou25Q44CzLWN6CseWdZznXKp4f7MHT14Fsf9bPD4CDzHkzcnu6ygFSCHaqHdeREYL4337oIOPoxaJo+HhPNdjDMtYKST4EZdDNNlJAJW/L5NrSzMnzQ/+XoTKwscEF9nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22Z6OpYufdBtzxSvf9B3LFJ2NyY1sjKM0+x62TTuiWc=;
 b=dj0SZTnrMZVvY7rlVUi3cbdFnYXtzjBXxAeHK0MjR2RX+ih+h/jX2E8+Comms7ehUNM9mB1h9XL8eYNJRIFnA+rDE0V3xfaSnBc7XghQh2lKJNak/ytKIHMHPKLkw6F0ReY9/XGVSyyhQYqaag/sQTjAXE/VyF72hcHU+zoxFscCBs5aPegDTohZOzlCeqBuqBQgFTO1WTJO4UMNm8qx6heyekC/2LsVsO5qo1e91KJ183tg3xrBmz3dE43BuqB23wqyWH2jA4MygXYkaUGOObMZYtIXpyPh8OeejqwGbMBjZXsyMJihFX7U9eWVqAjQ6Bp/Am7nWNLieOj86LIfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22Z6OpYufdBtzxSvf9B3LFJ2NyY1sjKM0+x62TTuiWc=;
 b=LHGWNTBVLLuyUAf1FdW8F6I8S4RM5DHei/9wDurDwysKj8JtCEd892buRUqN1KcLZ19zAd3tLMcSSYBjFOh9sl5u9KOPJ0NNH/27i/z/n8Nz+BJe0Wf+gsdEdpmkmwerJ4cvSwtXrkgjTBqkueqIPyhwAwkBD5iX85pDDd0nae4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 19:16:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 19:16:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 24/44] mm/mremap: Use vmi version of vma_merge()
Thread-Topic: [PATCH v2 24/44] mm/mremap: Use vmi version of vma_merge()
Thread-Index: AQHZITokYKyF8+fOxUGqtQvwBErbmA==
Date:   Thu, 5 Jan 2023 19:15:59 +0000
Message-ID: <20230105191517.3099082-25-Liam.Howlett@oracle.com>
References: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230105191517.3099082-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|IA1PR10MB6075:EE_
x-ms-office365-filtering-correlation-id: 809964ce-616a-4ef2-1066-08daef514a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxudobpIXKnLqcIoxsonSrR/WTmSQP2P01si8p21Eyw3taKauEVi4RiXJRXbQfp9KaM7hTO/sCEO54rkysGo1FAglX5z/SQeCE1SFzu5azXyFfnjaJJiwMPL4Rn39MxNMGjEj43O94C/vlVLbDTU1rZyhiOzC6pscRuHu38RkijWiJhaFloo1nC+Zk8JZaBf0gF2BzzAI2DLXXaGocgujcHW2Lt2lGhDEEm0Q5gNcmDnfWyN7icye7XWA8eKHyJv66BkVMnICvoM6FGul9ARiZUm1f4byKUXO3Ap805m0JGxRDcma4uTZ80AsbyANyUKIGL4k0l+2oRPoOhlU/6LwfooXe0Fi3hrrFGBdgaF2ZnUcP47tOrO/JWLCWYF1ntSs4E45FPJqSprVR7prmUCz+J8+QBummKU7XePD7/Qi5Iqk/FlFiBqn1P149oq1SyL+q+VQcqYyHoC3Jdm36XWGOH6Xe0Knhde0KHnPbzcJEFhl+fV0XQ81SYuNmkDhi5BdBjZmgflRI0HPfO1/uHnz5Jp7e8xfqbUkrvR8Xl1n2lUSyRlWDRupZJGc+/wyH9xGIXvd7LbZv5hzVvP/aWVasDHZiyaRCqb5uiW7rzB/+NoXsNwR9VwHb1ucMbUkecL8dJi5x2pmvI+rRiKElEtX9xgYkyIXrMcGrMtkIAl4PztFx8pl9/RufhdCGQOWkghpe3BjLwT6Qen6+bq1z65Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(38070700005)(122000001)(91956017)(86362001)(38100700002)(8936002)(2906002)(71200400001)(83380400001)(316002)(66946007)(41300700001)(5660300002)(44832011)(64756008)(1076003)(66446008)(6666004)(4326008)(6506007)(107886003)(186003)(2616005)(6512007)(66476007)(478600001)(8676002)(26005)(76116006)(66556008)(110136005)(6486002)(54906003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Oowv80GqnMboYgf/gjq5JUk4U0DDCKcEwBUKWPFRiMMShaDY89nAVonSFm?=
 =?iso-8859-1?Q?C+MpNA5Bhqic86WiIwfCqnuFNXCprCAiB7mvBYHpVwMmWoFBKx5gcXzrvV?=
 =?iso-8859-1?Q?P19Ex76MbaoHm8lZgAV+Sy2Z1R3bpGZUUtaZCC7xyPjXHEKanUACn6rguF?=
 =?iso-8859-1?Q?m2mfNp1wbb7xCqtOfnMw0CexA0U62GxpqKhmHUU9gtKXbPnXnro7nUaySz?=
 =?iso-8859-1?Q?gpYkle1OQ+tCiubpa79a3TL9N4VA6uKnDTXwg9VaToe0ZTZuj3bmTDz4PV?=
 =?iso-8859-1?Q?bQCz5+LcYl3CSGPCyH0Uea11kabGyXEerEL2Ohj/AsQt4Hkym6DtTFegBo?=
 =?iso-8859-1?Q?3e2zQ+yWPsjvWIbql2MOVKJYLLP5a5SWIsTiFF20ZkzUvopKpmIBkfkK4B?=
 =?iso-8859-1?Q?ajNIqUyrAWK4jcMZrMFSbWBlTvUwqIsKxOKq+iiZgxhUefkrrENh9/jsaL?=
 =?iso-8859-1?Q?Tkb6IK3MZ/qaRio+7/7/f9e6IH2T86rWBdolpYmKhVGvwUEKUOIJYmOj+W?=
 =?iso-8859-1?Q?p13YLPGa5ee4BRDoe/fD5AyzEZ48y+5Eb/oC4h2ZIGuuDKKSJTQVft2VjQ?=
 =?iso-8859-1?Q?7aNcW+A4tH272Rqf2WTpcg7WJjiYzgpdYKeSei6hUT857EF/nGnmOm8aBy?=
 =?iso-8859-1?Q?HtzzyHzELeL3uIcYYXZS0PPnqpXGw8W1Y1EQkC16iFID7p/mw/0wbOPEeH?=
 =?iso-8859-1?Q?qwyBLSgGaxGC4DFSf9nxArMLnohmUjzFVtSWYCwwDOoxWYrbLroBmxxmW+?=
 =?iso-8859-1?Q?t86mfcr3eBiPEbnYEZsygoJOXBSqzYsuCHppFFznQvPuQsp0Vu4QBP56JP?=
 =?iso-8859-1?Q?eoO/tzIcp2PS/nphRnUKzEuvR1Nyr7FOs7CsP38aPtky0X/aN+WURcSJa8?=
 =?iso-8859-1?Q?iaoGPO3aud7FCc29eYuOIDGi1wjV8jbDTA3RsZnjsP8FgGFAph8qYEghrp?=
 =?iso-8859-1?Q?uIg09Xg5xeu/mQ71UTl4ibV97IgZ2nM4rj6OYqRkf39d6/ca+m69kvDj21?=
 =?iso-8859-1?Q?slOLxddl2TaeDV0VmpIUL5CQyuwYhhCECcHnuZA5iZQlQrArRsSt01mrOw?=
 =?iso-8859-1?Q?JVykEVPCwBiLnuxEkFC15UgXZVo2KA4n3KtpZGcmahq0qlwfzkD7ywFSCR?=
 =?iso-8859-1?Q?7As/YvxqepP5pGmvO8EhVTZVho895+yHcq/ExCQnLvwbBr8eAyKqkbXO5I?=
 =?iso-8859-1?Q?1AqpM55bGWo/Hv3ai9VpMoE/2qF1ouIZqDR0Tik1r1RMFE+rHT0Znw2NSf?=
 =?iso-8859-1?Q?+oYge0PAsxHhKRiC0kak/c2xbmhnZC6KUCqFybxBC7cWM/YaSb+ChGZtYn?=
 =?iso-8859-1?Q?9EBr1IIdHT16Zy1l2WVY9HaR2jGJJRCHZY8W4/bVcFRIj54yJ8By5xa2TO?=
 =?iso-8859-1?Q?BTAMs8K3tMI7i9BM4ORTjTT3PmJkiAufpGfgE2Vk4ZBZO1cAsx2CvdvQjc?=
 =?iso-8859-1?Q?l1yNBpygFY17TT3LbtrG2u3ivUBHks9vf9A9BVoAmX6RyaPch8GeUTcJBQ?=
 =?iso-8859-1?Q?JfTFEev9vkTxw3ydq30ndbL1Qm+AjjklWwMj4UIk9tbJkphdbkYae4zB2V?=
 =?iso-8859-1?Q?zWGY+33Dry0IOoGMfkTJOCYqG+Q3Ge44ZkahQk/N6z5Box4YDMYb+HEHXV?=
 =?iso-8859-1?Q?vnSteeK5qFk/KSfkRZsJCx6xrXuA4qnHXWPbEtBxePzsAj6JCd/1GNWg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O0w9AOf5wsq8C3nOCVAprFQmJrJKbu8KV258k30JQX5QqhgLEBvkHp4IlUBv6zVTyG0OytheZfu5QyhFbh65oDRI+qhVwlG0W++3Ff5pk880aE5y7MCmqnoZfBFyNPfZnrE3XDibzwYA850kLSrVDAm5qy6fKItk2q+MgwtCH1Lf1z9fiHKJgbnPmMdo4vEbVsc3TGHB82YDKeE2r+EoqskeP+7/ue48U/TR3NIySJZHEANTpIwEN4LmP6+DmTfHfOV41UsfgrfOyuFc4x4j8REOn470B+RQBqIMVPBwa4Q3vgBUtkC4Xn18eMIMBEXxWGh4LZUBfh98kMXcg7+gIkEXvZAp7cGI5gGkF8a6r+stGAZA2pcvOskW9YhpsR1zLgZuUpqFC3JmiJzBT9B0t3njk4e2wNiiM1b0HHP94nYryxAavFjlT6G6+iyQ9IqDd9c6Rd5rVSrc1btBC6SKOzdf/dE6DIgliPombZWWAsiafKTCH4WRdQjlIY6iiJ60AGtQxcPbTngWriYH5eXJ2n1l0T7lVxVEClj0Y1MbBXmAan0VVEgQSYkbDLInB3rBJiow1tf2QEGahCYl84x/f1Tf05WRyS0gGa8nVPWPwta+p4zEAt17l8gpS4zBefSxTRDPjA5wWe2bcS+YQ8qSFztgNr1PKdr7Td4MuaulNFWUO7q1Ms3NUsLRLP2Ahy8DEh5NoGSUPcsgVFp523SZR1UgZmt2AKHsLt1vS6ocI3rV1z7n/V5v11MC9escVSdddTQpNgs2LaIO3IczuUYrS/gITjEr5penJWo+Jc83+wkW0Rl6ZncIat19Rx09jJ4e+UyWSFvxUpze22K1jVPKbH6RwTKri1JgT68je5gHg9SoTtbt7xVQslUgSk0qiyE+bvWS8EjsUhVapzSWSnxuuw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809964ce-616a-4ef2-1066-08daef514a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 19:15:59.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ls3FUOhliOeZcUWQYyhLrvjiDEdvIB2r09+BgbEHdHYLPN8VJt5DhB2z7qe53XTTGcp7s1Y9mCUisyGvoGU0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_10,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050152
X-Proofpoint-ORIG-GUID: D2pqDMu1FnEKnhcOXtIM3phW9N_hCqTF
X-Proofpoint-GUID: D2pqDMu1FnEKnhcOXtIM3phW9N_hCqTF
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
 mm/mremap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 94d2590f0871..4364daaf0e83 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1018,6 +1018,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 			unsigned long extension_end =3D addr + new_len;
 			pgoff_t extension_pgoff =3D vma->vm_pgoff +
 				((extension_start - vma->vm_start) >> PAGE_SHIFT);
+			VMA_ITERATOR(vmi, mm, extension_start);
=20
 			if (vma->vm_flags & VM_ACCOUNT) {
 				if (security_vm_enough_memory_mm(mm, pages)) {
@@ -1033,10 +1034,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsign=
ed long, old_len,
 			 * with the next vma if it becomes adjacent to the expanded vma and
 			 * otherwise compatible.
 			 */
-			vma =3D vma_merge(mm, vma, extension_start, extension_end,
-					vma->vm_flags, vma->anon_vma, vma->vm_file,
-					extension_pgoff, vma_policy(vma),
-					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			vma =3D vmi_vma_merge(&vmi, mm, vma, extension_start,
+				extension_end, vma->vm_flags, vma->anon_vma,
+				vma->vm_file, extension_pgoff, vma_policy(vma),
+				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 			if (!vma) {
 				vm_unacct_memory(pages);
 				ret =3D -ENOMEM;
--=20
2.35.1
