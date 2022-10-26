Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7486C60E442
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiJZPNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiJZPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:13:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D41127928
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:13:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEDs31001643;
        Wed, 26 Oct 2022 15:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=L3MpZAGgwYrq4FXHQVBDRnmkoENaGNjvxUgeR6UA1sU=;
 b=gdRcyq2qHKqqBKxMrDJHEp/EUQ5iNwK4IXtWXEk9DsAXjIvknGDAaf+G8g8yAU0aOla2
 ZVmsMP6tM/8Pxtz5BsLkwGUya62ySFNApq6jiRfV6xV76q7w1Po68erYKVLJzaMGAcC8
 4XSm0Zc1L0YoV5X7ugRG4iHVKY96S4cJfaXNSrfqbPgEdq6D77ovIHzCGEneSCtNe9Ek
 KAzLmVd3UQApe/5sJuFgoTvoKZvuvp9Pnz6+sXh5ZbU4188rV51xpIoA+Bd8G1SzOou5
 F+MbtRnbQV9b/v8B+4ESIOu64/Umm1+mtmOWG0YtQFW3XNWHRbG7KZCpAclY7NUl5TZK 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xe65jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 15:13:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QEeCgw008030;
        Wed, 26 Oct 2022 15:13:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6ybnbg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Oct 2022 15:13:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He9nBfEFsww0owQwAcqEoRUhimzkNoq2bgRBmMaQguvv7CIgkalzrdcJNi3M9Wu1QSUP9a6Zu/XrnXgB4xKOpIBxyvcA70UbLX40c94DNTQdnGLaSk+hA9xSbAgSmolGwJ/14lmyNTRH+rokj0j5Ake58AbP6DHh5rb2buYiMx99aPz7oqLXMoKWgq3HmtRX2o7JeEjLNvLYoU2XfZcMglTPBhsKjqK9IhTrBIYaYGqpztU6uOI6IwIFkYB5KoKmGylv9VAVI/+IQkSyZg0cpcTrIvWabNeXD0ASz5FzWqhC4M5ZLIOAXbz2rg7lhqUtvL/BwWrGyCV6frZkhpst+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3MpZAGgwYrq4FXHQVBDRnmkoENaGNjvxUgeR6UA1sU=;
 b=Ms74geysHgzZNHe/8pVblt8mB90tYL6xBh02Yjv5uzJZhYeupBxklK4VH2BICPJ09/akIkzrI0/F+veSSw2A7aN4pwZHtkrlLCRjv19vaGy8ZLdV9F/ffmNCEJm8ythfB7g06c6cruhI5OAtEoBOV+DQnDUWwfRpADnPURru40n7Ox6uKeLoRKLeCLo6BmoSg8ynd1hd1qxO9JNw57Hu+Bx4LroO+HbDFUV/gwoKb1wLi73SYISTSp4RqXTJ7UN18AEoZYdBNrRvfrV7BmtjSZkYDQtfU+Zr1TP8bzIGX8ywUQ6Sb96BWPPXpPp+kb+LOkunjNzlHbob+JeyKvy8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3MpZAGgwYrq4FXHQVBDRnmkoENaGNjvxUgeR6UA1sU=;
 b=pr/qWGkdpVnn79HIzNi/IGNPGP0Y71gR5SEVIPaN3Z2+6ZJqxVA8wYaDi3qp0f2LSgqnK9sKdV3H0J83+1R1HrfrrZNYSB19S1FEsa1rtJCwAMiws9zifjIO54lx/l5EYki4BZRCfoEgROuEhXXdBb9YcmkJGKy9lFWxgVzDWWM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5741.namprd10.prod.outlook.com (2603:10b6:a03:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 15:13:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f378:f1d0:796a:55a1%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 15:13:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] maple_tree: Remove pointer to pointer use in
 mas_alloc_nodes()
Thread-Topic: [PATCH] maple_tree: Remove pointer to pointer use in
 mas_alloc_nodes()
Thread-Index: AQHY6U2AqiEOMPyXNEyBbCG3B2KUjw==
Date:   Wed, 26 Oct 2022 15:13:29 +0000
Message-ID: <20221026151241.4031117-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5741:EE_
x-ms-office365-filtering-correlation-id: f018c842-75e4-43a5-9c45-08dab764a36a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FEmni/cAr8kGfHvjOCId2U3TC674FCT2dP9FTBHzlr945IdMOcp7NWECGYpydrm7aczbUUJbV2sF5MmE0bdGjhTKWGFhskbcxLZMjLaLDI3OZ9bpldUGxJJ1O+MSverOgfR/HfvYqXtsrDmUpSVgNZRw1EtJX1Hqy/CP5Nhhf5YEcr/Y7lhWGNPTYOmFr9X4dreEZD6EBfM67RTc7J70Cv6qgyoBaYv9Oe2EsbdKqB5Ui5MhhP6R5JNyxposA0V9e7JZIX/b4eBsbv6wNLYkC/x5ZEyzz+kW6IrzJPkxpYDJb24YCfi3uFkU+S6KJdGx5I2vB5eY0jR6cac+90O68hkZ6aKg6Eg0iEXhJKeY5Jqdk1U8BtmZvB7v/K5eQIgGTGmghPaNW7DtUw4P7570Y6vNH2q+tiI+Zd2qOseTk0mCv5+7P0wdo8uJNSYgYMIpSkyfr8xOmH7eSX08Ch2/z4iuDYQSgOWCSSFcQUSv4wtng25QX2hJiaX0VtLjZPQQAHDL5Lx/M/XB//wsrQF8Vgloas0xc7umxpWEvpn+HbleK21MLwq+loFwq6hTj0XpKBWfT5g0VHLZ8pS50ucrIDLN7mGWqnV8Ih2090p7a4mLKVbfmunFdortvXpSq3QSfhbUxaz7mVLACwoniacTsJ0uRdaVXOst3qJ24BkX2SLuduxZ68xU0eo6vv1Yq1HCqbHv9JnGoKJfjawqx/TXgfmUhk8BvqBIcLuLBEZG2ggpJLhwo1S10bxwhFvJN549frCVjFNL/w3bStNvgJht7+lCrblDoUVJAg63nM6I4JVMU/0tgD+uhN/I5z++xQ22
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199015)(36756003)(54906003)(6506007)(38100700002)(110136005)(83380400001)(122000001)(41300700001)(26005)(44832011)(6512007)(8936002)(86362001)(38070700005)(4326008)(2906002)(66446008)(66556008)(64756008)(316002)(66476007)(66946007)(91956017)(5660300002)(8676002)(6486002)(76116006)(478600001)(71200400001)(2616005)(186003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3AORLydGvkVXcXABF2hF9KAEvmXnIuI3wu5qYEMLoGbbNz7b/5od+FWkL1?=
 =?iso-8859-1?Q?vRs52h1WRbSD9+zqJhbyj9PSok0bV5Zkczrztd79KZC51decKnh1HeEfPv?=
 =?iso-8859-1?Q?riYXLY6hMqu5bHXnHYtw1mH8nr6Sh2mucORiP5xBqM1lq8CZPX7aospJpC?=
 =?iso-8859-1?Q?CK0acs9o1GGUc8wpJkDAcolVFjUrzeAhZfUYWVVYBG9lXF9jnh3t1Oo77q?=
 =?iso-8859-1?Q?ioDPV3oiOHzIhfYKDu+t6ReIMrgnQwpSjU9a/SPZA3/M/ExQItgqVN/ZIv?=
 =?iso-8859-1?Q?yuvMAmoSwt2UXTsQgoHnlRmFwKO0vm7EOqTdXiz712QxH/sn7MUQxe5Mes?=
 =?iso-8859-1?Q?eDhf9Hpsi3U8SRgpdnPg12ksGJ9nH1ju1YsDMd8ZWgrjKkSEFiM8/5/Eyl?=
 =?iso-8859-1?Q?kQYu4ECi683nPeXjwYePTAjdX5E75/A3B6dswsyF+57HudzuONDAZme+3k?=
 =?iso-8859-1?Q?RpUVi34Q+2aXz+mBDN32qYwoRIbXyMgYaK3okqELFNe/kdKY9RttlakNyZ?=
 =?iso-8859-1?Q?NnibjcLRPRJwKm7ePDrEVQvRqnwbOCePe0LDRx/3uiPA4CVoHi/kBvTX7U?=
 =?iso-8859-1?Q?oPTJzSzdnQpkJdYTfO90XV1mZNx8NhjcayRmfn65k+WGuywFUyMxwzNNyW?=
 =?iso-8859-1?Q?Pzo7v33gzLFMEHAo7ddJNZpHjCBKwEy85mVsak36B8q8SXEAcKBxSj+d97?=
 =?iso-8859-1?Q?XFpQYXGoEP0kqnNZgLuPA/BvQD2LKspdU0N6H/LqZhIBtuNK9YaHDLvCxW?=
 =?iso-8859-1?Q?p+zI0GDpYh7TpfohU/UyMp3Gjz69Th2RgXz2lsd3k7ZEV4jJ92785OVRxE?=
 =?iso-8859-1?Q?yPb1gwV9mVdYz/QzKxweBU1d5tAED67fexEPyyz6OiLp3vlqyU0AXjPCUW?=
 =?iso-8859-1?Q?fwfET2Jo8g1PY8TFhTWEY48kowE2jcSTid/13cJDu6gDU0O1QkgEGnz1+b?=
 =?iso-8859-1?Q?wDLWEmYM4LKbTEzkAXAtlAqU2TOVFrybZqIOhPPjawtRdTwel3auXa6AhA?=
 =?iso-8859-1?Q?EeSD6RZnKCmik9I6EZjZC+03tHq6g+Tg028+SnIGjG93y457CysDqdDWgG?=
 =?iso-8859-1?Q?LHxfSguZH1XqI880ze9VlRJeRugd5unl7/8+0miZ1rc1Hq5euwWmZI28b9?=
 =?iso-8859-1?Q?YPHNGAulCLkfsWq7YqB0DQNWwVw5aFGFSnROvV3rdpuFLx2nj3IarMfKNs?=
 =?iso-8859-1?Q?WSPopMgXJQenWWcykLMbqxLBmRKGFBCYYRasxG9E+LeK5rlU1s38kFMSdm?=
 =?iso-8859-1?Q?dYbhwH+wHKT+6I6lJuH2hBcpxrn/uf2beJIxMqkZbPHgb2wRacSos1xy67?=
 =?iso-8859-1?Q?S46YeF3W5NOHNFc0V4MqqVCGStpiCcj4vQFKuM3VUrm3P31NGbkpWcmRrX?=
 =?iso-8859-1?Q?jEdJy8Hk5WCZN0MthdgyfjAW+iAFzHNJFW2gniuTT3WO+pb1xGWPD2/QVg?=
 =?iso-8859-1?Q?mO63piw3H6RwE09ZSXLNoQJyTyUc+Doqi1jqPg7bsmK4NMyRb9+3ZQ9XSq?=
 =?iso-8859-1?Q?QBKgkWU6iuDgVdK/7Bs3o4PT695kycNbMcGFZo2dMQ3IIYiBP0YrXbdlkO?=
 =?iso-8859-1?Q?Ah3X/IeQraK7stecT4L80ceOFx8Wrp22Zu2IITjBXcHnOc13twoA1FpmRL?=
 =?iso-8859-1?Q?zhCdprSNU7kXKTiUrMnASL5c95tGsd9U7lPtCroPeJrUVSO1l8FRR2Bg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f018c842-75e4-43a5-9c45-08dab764a36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 15:13:29.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40+35uKYZNilnjtbfM4I6wlxplnE6JvKRtmNyfItfQYYJhpgWs+LiG09j5Vcr9w9Dj9lHdSnskwkpKTzyPr6+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_06,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210260086
X-Proofpoint-GUID: ngKEJ7fVRYk4rZySmmOd436kAgeDlOFr
X-Proofpoint-ORIG-GUID: ngKEJ7fVRYk4rZySmmOd436kAgeDlOFr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a more direct and cleaner way of implementing the same
functional code.  Remove the confusing and unnecessary use of pointers
here.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cbae5b1c1a62..6f3945654baf 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1205,7 +1205,6 @@ static inline void mas_push_node(struct ma_state *mas=
, struct maple_node *used)
 static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 {
 	struct maple_alloc *node;
-	struct maple_alloc **nodep =3D &mas->alloc;
 	unsigned long allocated =3D mas_allocated(mas);
 	unsigned long success =3D allocated;
 	unsigned int requested =3D mas_alloc_req(mas);
@@ -1259,8 +1258,7 @@ static inline void mas_alloc_nodes(struct ma_state *m=
as, gfp_t gfp)
 			node->node_count--;
=20
 		success +=3D count;
-		nodep =3D &node->slot[0];
-		node =3D *nodep;
+		node =3D node->slot[0];
 		requested -=3D count;
 	}
 	mas->alloc->total =3D success;
--=20
2.35.1
