Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1A60D29F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiJYRi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiJYRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:38:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA22165CAA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:38:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PGBtEF023481;
        Tue, 25 Oct 2022 17:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=/SXSnGmkJNttJRmt0b05Ofeb6ph1Ce7F6X2Eum1iAFE=;
 b=U3wYIY+UeJEgxnBxEDjyavymE2TsTjkX3pIDpfGT2Ao3LUQqipGLHjDZ0R8PJuwyriq1
 A0LEzDpHUgdKTH8e0B8mkXZEgzRcUUQrBFGmkvnZ5lQPA3vIxyHyDrYHGcLsNox2mPkr
 ux5VXOK0+dny/nfRTArZnS/gVciOiliNH2sXPiD8JxyoPM6E//FEgMDO1X35hKKlrHg/
 nqMzEdlcHC4b+jQBNcsjG4oaDuaHdPNlpfn/0r4aiMCOkCukceiss9SkgLkIugEvauZp
 SWLl2xEVxNTpbHEmhKZklAn28Njo3FzxZBcTqOPoGCOg1wtw+3bRZYEC1Ph4jYEGJdiB qQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc741vrd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 17:38:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29PGUwfR032146;
        Tue, 25 Oct 2022 17:38:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6yb589q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 17:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsrAjgDiwEiU9c1ntf/S8RsSkj6XR/l4CLctW3eGenf30TmvMneISreDZNR/BIxdIa7SqUCIwemrkuOJU6AAcXpFkbfIydzpiJUY60Mcg1KRuWbE5+vd2zYIwOwIvChplq3XOIfWd8KhkLOZh9SVjVS/KPjpURQQW1klKiy9IaVLoda3kzczb1Jah+YbXwh10/eQn6GGn6Kn6lt547Rn+THaLes8LS9ZZkWbn8xDyfkW57s8+ymTymO3XAViIg9rD/ae29tJAZcghzNGyjjNi0/0kWYq5NsAssOw9+mahbOwM4Xl5xy08IC18n7zhZmBfFQ5614DHgOPEzl05X5D3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SXSnGmkJNttJRmt0b05Ofeb6ph1Ce7F6X2Eum1iAFE=;
 b=W0v+SG/BCdLoh4zFBvSkV/Nk/5JT8fCBhA3vXui7vELLVbQxlVFhR594E2eNlTnv7c6elg8Ml9yG+XBgZc4GUwLLOZ5/F7HTwwCoIj9b6UlX8RsS9Xu7Mm0Eqn5au3SUambaKpDFvCKj45WuyvG07o51QCIRNLbzRZgoE8vbfzHYtz7sx0Adgb8HXry8QeOAIAVVEnoyom2paWClks02u1/oUdySboBJZxzupXpLx+yvzzqj8a+fvWuOjGsv1iM0IWiZVYkw8AYNiV2sgnKWoY3UUOJUggXuRDHTqt+xQJ7lj4AVcD78+lYuLO0fA2MrFk5b3U39EHi2zjSekDthmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SXSnGmkJNttJRmt0b05Ofeb6ph1Ce7F6X2Eum1iAFE=;
 b=TiLgG/A3vIfHUdt8zrqYXaeTq6TMNlUB8/+Pv4pSnRM4+v+bnOi0vb6kPWQqkGO9dgSsEKiCOHfHr4Z1vRuA7M4rnQ5G5fRE3G7uigec2J9NtiWAALmbJYBvte+j9NT8z1f0DCKCRHLD2s5cJWpy5xJwWqVIw+nFOYko8wIS7OY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4299.namprd10.prod.outlook.com (2603:10b6:5:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 17:38:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 17:38:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] maple_tree: Fix mas_find_rev() comment
Thread-Topic: [PATCH] maple_tree: Fix mas_find_rev() comment
Thread-Index: AQHY6JiPv00Iwgft0EOD6V9XHQaQPA==
Date:   Tue, 25 Oct 2022 17:38:14 +0000
Message-ID: <20221025173756.2719616-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|DM6PR10MB4299:EE_
x-ms-office365-filtering-correlation-id: 15cc04b1-e5bf-4639-b741-08dab6afb19f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6WFb6lkVYGTjqz6JUiuv9FiSN8NaA7TZsn6V5jbVpQjH6Q2fIvy4RiNLlTUB+vQelxwairWTQFiskX2DawTmbMR9MlAdBbFAyczAoEC1eusdN1NPlq+lsW/s4TTdGShsX69cHjhqR4EjSBynT0IhleSPfQJYYN0oIQ3IW6gC0ijY/uS1Y1hpCimfq7IAPhdlnmF5fVugM2Nh8CRr3OYC5tpHrFfSejQGFd2pdYYpA1nVJKswQtVJCNNe1tStzMw2JZZvliwo2ahlhrb1PP+yGCQm2QMHXux441GBVrYxZ0ZjSHuPtmqf8+D+cGHAjI4q/Bz9vkwqU5u+P6dl0htw39MIgWoJe8fMsscsVA3pzbCvZfQolOCiqMIGr60+v5Rn1lRqsT9pb/kZaH/I1SW8iyiZyWzzDFolw9OGvObyK/YyI8BDAdKCw7nZunz7WYkd6oY/USS5GITFGhshuOAngixtoK4MqTsK+ceWF0vnTDdsO9nDsIc+4merEg/C28xOoseonwWOrbC/D8UPrIyV157NE9NaLC5ogFnRzVap4M+g5tHtOLHeH6o4AqeSut34LDUe2HDIZPULwS3Fl+xILJx1e+JqsEMiYi6Bf9KhSEM21plPTEw4YrRIQd8iOTnvH9dzzAgFdIjuXYV2UtC47No3n5MIrwemTn3lafiRaBAuJOmcDgEVcom/YY+utvBh4q7BJxGy4HX2F6oZ8Snv4F9lM1IuJaKi/a0Xs5zdUXnFMb9G859OZUldOl6PpKP9H4Fj6aFUGhOlm0itd/lkIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199015)(41300700001)(107886003)(6506007)(110136005)(38100700002)(91956017)(36756003)(5660300002)(66446008)(66946007)(66476007)(478600001)(8676002)(44832011)(6486002)(8936002)(316002)(76116006)(66556008)(71200400001)(4744005)(4326008)(64756008)(38070700005)(86362001)(83380400001)(2616005)(6512007)(122000001)(2906002)(26005)(186003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bgzhTHBUNYmQ/bdPTHOw5x+/G4Mo0Xk4VwUwFq7OumpLUaI8cgd6LuwB7O?=
 =?iso-8859-1?Q?ksVp8mwX1ylQOxJkG8sxbi5irVkd1EgtUWk92Oa4v4ftdiq2GmrBac+W46?=
 =?iso-8859-1?Q?B5ubjjTsfGeGBz5rfj7wN2qLRHSwjXMQIBTvzSxLnoyCgqFy5YQPYSoghn?=
 =?iso-8859-1?Q?yQulHNCrgJy+2gPZaCziiQQ4B3Gc6BCmIwRYkcB5JuZeT4IM4AJOtsrgtx?=
 =?iso-8859-1?Q?pVQgj+2ySWdUDzTLge8Cz6qNAx4wJn8PqtIqj1/E6T6PT4GrXtPOMcT5qr?=
 =?iso-8859-1?Q?QYeyRpB1Bh2IUgExk6oE9T/AqDm9+hiAI11ToSo+SmM1pvvCWs/UJZlKM7?=
 =?iso-8859-1?Q?0PW5CMvBxGchq9Eqp7Jg0p7bfsS8P8OLG3WOKbuik83gfTy2gtaZMEBnSE?=
 =?iso-8859-1?Q?Rry8sM2FptIVxtmytI/4shd8FoAcnwFmnvlFwQNKUyz35CzbkA510yIwm1?=
 =?iso-8859-1?Q?tWoAkLek867+u89AhOrHqMccyDsYM1PRoPB4VbHBUd4ApC6OOhKBEQEywT?=
 =?iso-8859-1?Q?ptfeKxnq6rjXvree/5QuJaJNR/n5jzhAlEz/6CG6Eo8Du7klJR7/CBl0Ow?=
 =?iso-8859-1?Q?4v+7z0TNRHaGwbJAU8z++qBN3LQglQfeGgb4/CNvGGNhQuxwKi6hWqqLJW?=
 =?iso-8859-1?Q?J+E02XfqKWO6LykBG2FV6ultnu2RmkBcYEo62qS3LueO6JWFarJS2dAr2d?=
 =?iso-8859-1?Q?oZYIODxa6yVYVX9sRbFbjBW3nPAqPQQCV7iDOuDW1EIgZUolA6thbQrBPr?=
 =?iso-8859-1?Q?9LBsohdOtFHSpi++VrWOzLfT31cygg321JHp4bIEYmvuXSOgkM28XjEbpB?=
 =?iso-8859-1?Q?mrqmAiPtWG59Gu1pXh3t2t3sFu7IN3b1VUwjgk9FzW7+fNaPhg+2WsqhHp?=
 =?iso-8859-1?Q?0+VMs8mOR5QgLcy2ipO/+d4TGVLvEK64tNvYBn+4Ss1dzanBcy/n6/nepN?=
 =?iso-8859-1?Q?+PQzG6UI/e4XQC0ueYQsBCBDw+hQT/0rQOr1+gkja4urI5lJE3EFSO8T66?=
 =?iso-8859-1?Q?CzTSGMPCYtGaI/1Lc6TZ7nI7+zdDWHkAhe+NGnQBGfQrXPqAnOf2WF3ZoM?=
 =?iso-8859-1?Q?tR5dag4uEXWp3GWzYI42y3ggTa9skL+bpryKgVL/4MaZUl3QGflBinu2Gu?=
 =?iso-8859-1?Q?oLLRfJNduYkSrFoeN7KHJD1Bl8ONQd6Hn9whH2odTcSRFf2R6vCXUh7VkA?=
 =?iso-8859-1?Q?bhVXGuEX8at+AHXsPutB3zeNFW3VTdT5VaB79za23+BXs6p9Nv8nzIgB58?=
 =?iso-8859-1?Q?Ko/S2XwXFWyj6B0ZogvSX/AQXg2ThAjI1qhJcQoY5fnpHufCl297NeUqvK?=
 =?iso-8859-1?Q?nCOr4eMy3A4OfRHBlN61W+wNMo9vIuAfuCvQ6TA63oBkbit/upSP/ttwzt?=
 =?iso-8859-1?Q?bV+3kfa0YUxB+9FK8cRLF1cYdyyvuLvVel4SGpRQp7Oy49Hm9fkNFo9h5M?=
 =?iso-8859-1?Q?34wb1wCM1MXUA0JTTYkU0X4zgrxb+gi/RZw9BWWV6RnpB96Lk4Y30ap0dS?=
 =?iso-8859-1?Q?Kw+iRV+z/sRk/T0CBFQst/YZtCqAJhCqtXQWPaugiCYRwHmpBhKwMCp1QX?=
 =?iso-8859-1?Q?iZz4ZyB2dkM6b14LICL3M4mh9R+xMDTCS5e/Ql5ykHUKAJ2X6wOtmIupZH?=
 =?iso-8859-1?Q?FcMtz/QzB13qFPE6f+8UZ21Vf0Drqzi+qU1kE+Qf7Enx9Hx77CXBgVaw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cc04b1-e5bf-4639-b741-08dab6afb19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:38:14.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSwdNKBKe18PYD/oRXyNwYToPdzvRdsvAnHzslxlsQDA58UJ5oHlkVnDhVY4n31hVieSLhCTpoLR2Xa3XuvFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_11,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210250100
X-Proofpoint-GUID: z7gB3yWfF20mw6mfhlPcGKwG0DsYsjh6
X-Proofpoint-ORIG-GUID: z7gB3yWfF20mw6mfhlPcGKwG0DsYsjh6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_find_rev() uses mas_prev_entry(), not mas_next_entry(), correct comment=
.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index dee5ebd30256..2afb38437626 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6057,7 +6057,7 @@ void *mas_find_rev(struct ma_state *mas, unsigned lon=
g min)
 	if (mas->index < min)
 		return NULL;
=20
-	/* Retries on dead nodes handled by mas_next_entry */
+	/* Retries on dead nodes handled by mas_prev_entry */
 	return mas_prev_entry(mas, min);
 }
 EXPORT_SYMBOL_GPL(mas_find_rev);
--=20
2.35.1
