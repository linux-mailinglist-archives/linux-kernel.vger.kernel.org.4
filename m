Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DD65236B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiLTPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiLTPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:03:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2715BE4C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:03:48 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BKDJLax027086;
        Tue, 20 Dec 2022 15:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=G2veW28/rRxY1HTKyjUBFrqud+ZRm1MSnighCPzGR3w=;
 b=hCR43QV6tGDwJRSaK35AWYVozParzaKYJOPW4I29A05mJdbMxa2oGKvp7VdzWb7mlkqT
 ZJETCL7zmqUMnEItg81Bpy6c8wI6dQlC7XfHZ/EHSVZhRBFsTjy/RiDctif1ZwSaarZU
 aWdus/34285arodikbBIjBg/8BIjcNIN3jXJ+vKLqMI1L+YCJKl5I1im2yjAPI1I2DJG
 FeEGjbcn3w0lrCOIdbtY1QHrFaeB9PLbKDmhKS4PxksCVeT8rt0uafmSm4tdjLQEg3V8
 IBAcSIvc5ftZN6QCjk44Ro6whoS1NJOKwxoOk4IWO0QRsSvitztREKCxkOFIp40VXqIa mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tp620v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 15:03:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BKEBdTZ008001;
        Tue, 20 Dec 2022 15:03:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47c75qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Dec 2022 15:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gerOyzuZhS1tVgFggUYNoLqO/Hr+ynPavvSmSxSoQb/z4059f93KdaCnv9QHfdbTpQDiaR5Rnd79kgry9pIbHkXondhm6HfHzHULGN9OwsQP0Ibwgl+Zhq5OiNh1WZcl+BXjDfiLcXAezN23bS9TXCgsthiIGWjOmJC7SYo85j4ByJk0CDSjz3HE5xHPStVxWvv6U1Hn3xuaupeXVLiIty3DdjmA8zWjGv6U72iQhG6kzOqfGu/31OYe84X0/WbW7hk0Vqz85narAS59h8JkQ9e2+1sDoCwuCKd3UbtXbvVItb+4ciQf5htETIa7jO4OyIXWJVHhl4Sb0GjVmmXayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2veW28/rRxY1HTKyjUBFrqud+ZRm1MSnighCPzGR3w=;
 b=FxRjQRfdI3v4v+Kwivzw3iQ6jo+WuBrsb/a6hg9i9xxPRei6sR4JH4a8s2itlCpL/5A93FplhqxSmuhuxXUrqKxTGPCLf8U6cjwulpbJRqdQDl0D34eurpy6sttXGjfqJFJVCFW28QT9XGSDMBugWSPmjKD0QfOnoOZBlMJ/d2ns/RCbgfSJXpKSS0lyRkjH+YACmtCeZdHAJS2E0ilUucIrh4+jk7/fFsjyH+y6LkQDdvqGq8XnMrZkJwtEufotF+E64Gy9UBFciy0rypsYcwHOMXm3uxYOUFpDpfgKD31LjRX7q51pvflhOKWE4+lOpPK7wGY+6HsO1fl2dN9MIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2veW28/rRxY1HTKyjUBFrqud+ZRm1MSnighCPzGR3w=;
 b=FuzOTB3b1bFkR2Li+Ch2Y7O+r4YsJkUeMMMMwh6aXyCdKdSQ+ppw/plax/7HtFP127RUOMiXmJwZVxS7+CJqqxPh/ExYwZs9aINCRfR/I6ts331EybteCtE1KxjppyWS3FJgTD1il5Du57wrgLnkuXatgWOCq32F24AU6DnuVgg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4717.namprd10.prod.outlook.com (2603:10b6:a03:2ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 15:03:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 15:03:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vernon Yang <vernon2gm@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] maple_tree: change return type of mas_commit_b_node()
Thread-Topic: [PATCH 6/8] maple_tree: change return type of
 mas_commit_b_node()
Thread-Index: AQHZFH8Wjm50mACylE+Yuuc9fGTJxa5231oA
Date:   Tue, 20 Dec 2022 15:03:36 +0000
Message-ID: <20221220150310.kfzx5paymtaepbxk@revolver>
References: <20221220142606.1698836-2-vernon2gm@gmail.com>
 <20221220142606.1698836-7-vernon2gm@gmail.com>
In-Reply-To: <20221220142606.1698836-7-vernon2gm@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4717:EE_
x-ms-office365-filtering-correlation-id: 446c2d02-3972-414b-234f-08dae29b5eff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LH0czWYjLfEcoxoq2KAvgbytUWfnCsMOU7nNy7gMt9XaRl4rJ3Vm7RxHmYC7Qk+A5gev9tqlC2K4f0/L8Fc/eZXQWhB9/3s7UZrQVZic8sh1jcFJ/BJX9ESn+9s0lckcUm+Q1aUgarLocI6vfeg9zOywnb0CbLctF1ibemkW+CVvDyemHcHrxTSkc5u0h0lDV/BcJnDPhnJ3rTURxRJPu7KXYdUKR4TEYUki/C6Zl035abZVm0E5JTL4YMjkrgeDFKZgNo6h6HIysxH1/j1O7QcBbdoY7D4MVngzUjDiqzT1/vuT1bXQX36UVAoLEOQq1+hxmtfkYdDo32jVthd8qgju8Q5SVs06m7s+Icry721rhj9ULZZM0/SUmmkpM5QKgLRI5gSOABrpT7SDTgJEqQngLnIRXihiGNHbsbeZnFSuzbILO2Gguk405YuZUQcCzko7RJXMJcNDAALgxnIx1R2J9ASc4yIxvQsF+7gVj+/yTVuMFrGVUdVA+Y5FCF0eO6+yh1pbBF4PxDzroPAifBNR3ygIwzjuX3UIbDE/2TfK0TaDIfwVu4XW5sbV8QirE7bXFOHm5xoI2FLlUUUNSRFu5fRd/fh+hQzf5g7BEPC9XX/saou+KRABaFyQDByZzC6rQnPRYQhc9rxjpoePoZ1P/vqojaUOruD2fxsPxY1LtXSAn8a5KLcBlpCPbHBZQgQr1z++ID42tNd7RMRCw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(478600001)(71200400001)(86362001)(6486002)(1076003)(33716001)(83380400001)(122000001)(38100700002)(6506007)(26005)(186003)(9686003)(5660300002)(6512007)(4326008)(44832011)(66556008)(66946007)(8676002)(66446008)(64756008)(91956017)(76116006)(66476007)(8936002)(2906002)(316002)(6916009)(54906003)(38070700005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tm2UWykKegKhHkLR0v6UDRJtDkjKu6NFz4NoG1nUdZTSZYscTVvDSvHUibsI?=
 =?us-ascii?Q?1LIm3VJN+5WvgUJLFbxfTDbvjCIaXWrOyPE/vjQPwlMdT8qxwEbeCrRkgebS?=
 =?us-ascii?Q?lL0SSUm9q7wmVztwG9k78QutTuPP/4xe1NWGZVXxvk1aDE9nBHvxYqZ0Lb09?=
 =?us-ascii?Q?dmeHdqlqkIZ/RZ0bDa0WaR20TZUUZF8gmwvcaUFJj9OlPcd5xiQ24aBi22Gh?=
 =?us-ascii?Q?7nzHdTCaoGnw10Fyv0kCZNs1W0ivT3Z55ucrVcjflg8xRnxydtjAnN2kbZ4j?=
 =?us-ascii?Q?NLLUr7Q8OEhDSDxp/mN4yYLVmlGc0zWdNL4wwGsEyrzQafrhsYCtDPohn+zo?=
 =?us-ascii?Q?S3/pDk09bpvOcFKKxnJ3pxcCZFXgttCTIrrfQ4kzXoDTkBj0hFbiSOizUFR7?=
 =?us-ascii?Q?8j+Qc1+c95WZ/wSVnD+3D+uEelg9v8D9GVrfptwsRAzBCtOCHWXgXhA6wXQg?=
 =?us-ascii?Q?GmqkGWf5dRXsz/Eo+ZjCPmI/mGWtA5QsLRTu0bWoCLFpcgBSrzOVHVYZ9roP?=
 =?us-ascii?Q?hA/zRjk0UNd+EouN9yKbqV4K0RJ98jA885Sw+HVrfayi8jbGJROrQizYMCmR?=
 =?us-ascii?Q?Jrw1qPJ1WIdU5/vekpCVBwcP8Im2hOxBCtF7+tFn9eafzJr4D2EV/Zm+KPkU?=
 =?us-ascii?Q?jh6xe0H67B0RvTak7H428xxZYRDX31s08k9Ecgbljm5GEHoMpdIkVFeudnIH?=
 =?us-ascii?Q?PwUSZ8Cc/8REZWGCqo8RbU26bBzKfR+r9KeRPu8CiRs+GyLg8i2teG3PT/rC?=
 =?us-ascii?Q?FNSDxqOvPpwZRBWtsGsX/FoZCSlRpd9BPpv0+nYnLgyPr/tKezx2nnuu4pHw?=
 =?us-ascii?Q?GtzwjNV6HBSLpmhyl6hRmAr+4L/J6QDt4pdl/dZQ3jijTtB3tMOzF2FcJC95?=
 =?us-ascii?Q?//PJ20yHN6O7EpJ2d62nCPEHKjaWl/Mw5ifwFCvcUOd7F02QKR70/bCQ64YD?=
 =?us-ascii?Q?uUoA4X+pJjli6VPkAB2zvPIMTS5DGdx1sDC49vG2dkvMz0+Acx2DQrnc7iz+?=
 =?us-ascii?Q?/RJzTVueDdL57joTZ+F8EUtyoVfp0wnFf3B80w+reRo3JQ8RxHGe9zY5y+fD?=
 =?us-ascii?Q?h00CneTPkYDiDjIbRk08dHS3Ist3GnkTm4cUHCrJ5hvZZtWMhHJx3Nyiu37E?=
 =?us-ascii?Q?QyR7uICmcM6WvSXn/0wYiRbLahqryv64gFuCAJxb6tDvEWptWLdg9knKtAmt?=
 =?us-ascii?Q?OKmrusVB4oKMCjh+RLB89NsFHZB3oDw1gu2IyzWJ/2QdrnWTZabsxLUsZCz+?=
 =?us-ascii?Q?lFlicjsF2r02kJ8mWStDGkuOSHniYHQLuzBGTPJUVL8EiZG9NGOqJzEqtfPX?=
 =?us-ascii?Q?punoXDeRilgcwtckqsqAdBI6sUSks69gjnuhqNe07dRMxywz4u3uexanPGYC?=
 =?us-ascii?Q?ZGt4aeF+UiX5fG0yV82fquyNk6HqY8EytcbTpiVF20nmQQf2Ssr/OHyP+uk4?=
 =?us-ascii?Q?ZZjL45Hsp07jsw6KSlngevNBDsMuUXziN+Z6fMRix3YAE1d+ajTT28z9VGs8?=
 =?us-ascii?Q?dqA572KEiy2D15UQS8snioF6ymOpHFW5Xbi87Togr5FW5G4lFDdvR6AuN3Dz?=
 =?us-ascii?Q?tsArZEEYvSVw6dBIUNC2FfoyX5/6VDXARaizEYiAaxRF+EVF2xrN4IGcLj/v?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C9019B08C5AEB4DACA70243A048199E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446c2d02-3972-414b-234f-08dae29b5eff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 15:03:36.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6YSNwAzk0CaDZLjZreGzQVKufgSEM0Xia7LnJkNYGdrb4ajS0wodw5lunhyay+nfv2cclKyeuPIpsNl5P9qsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200124
X-Proofpoint-GUID: NOVwbKynIYuFQvzFVL_LwdHJ37HS1vkh
X-Proofpoint-ORIG-GUID: NOVwbKynIYuFQvzFVL_LwdHJ37HS1vkh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vernon Yang <vernon2gm@gmail.com> [221220 09:26]:
> The return value of mas_commit_b_node() function represents whether
> the submit b_node is successful, and can only be false and true, so
> the return value type is bool is more appropriate and for better
> readability.
>=20
> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
> ---
>  lib/maple_tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index b3a215dd961e..e7dde4a1d6cb 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3578,7 +3578,7 @@ static inline bool mas_reuse_node(struct ma_wr_stat=
e *wr_mas,
>   * @b_node: The maple big node
>   * @end: The end of the data.
>   */
> -static inline int mas_commit_b_node(struct ma_wr_state *wr_mas,
> +static inline bool mas_commit_b_node(struct ma_wr_state *wr_mas,
>  			    struct maple_big_node *b_node, unsigned char end)

mas_commit_b_node() can also return the ints from mas_split() and
mas_rebalance().  I'm fine with changing the return, but it seems odd to
only half-change it?

Initially I had a different intention for the return type of int, but it
seems the return isn't used at all from this function.  We should
just change mas_commit_b_node(), mas_split(), and mas_rebalance() to
return type void if we're going to clean it up.

>  {
>  	struct maple_node *node;
> @@ -3598,7 +3598,7 @@ static inline int mas_commit_b_node(struct ma_wr_st=
ate *wr_mas,
> =20
>  	mas_node_count(wr_mas->mas, 1);
>  	if (mas_is_err(wr_mas->mas))
> -		return 0;
> +		return false;
> =20
>  	node =3D mas_pop_node(wr_mas->mas);
>  	node->parent =3D mas_mn(wr_mas->mas)->parent;
> @@ -3607,7 +3607,7 @@ static inline int mas_commit_b_node(struct ma_wr_st=
ate *wr_mas,
>  	mas_replace(wr_mas->mas, false);
>  reuse_node:
>  	mas_update_gap(wr_mas->mas);
> -	return 1;
> +	return true;
>  }
> =20
>  /*
> --=20
> 2.34.1
>=20
> =
