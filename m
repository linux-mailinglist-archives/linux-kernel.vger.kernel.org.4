Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125C621DB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKHUfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiKHUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:35:02 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6E5EFBD;
        Tue,  8 Nov 2022 12:35:00 -0800 (PST)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8JPW1X002692;
        Tue, 8 Nov 2022 20:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=f/7GBB2/K3K39TY5imV1840t9I4fsSrnUZTmiwKTCw8=;
 b=n3S8meHjJrN774EEBHBizFAmhQalpeUcqzq0Y9DAXHLT6prF4tjeByOnNMwRVaV/BU3q
 qb0jpdTDv6RJA9e+DmSwDjTKq6F+HRoQsPABlFUOgr5YqI3QgByzLpqRgWlHQRdFQEHB
 fpCl/yonJQjIrFbpsKbMlt5CunZEgfXN+4PP4vk7hCsHItQyspet0Oob+FfQHfbJ8udz
 +MVV7lCH5E8ZGASTWH3gapdPcWB7vm+jIomhWzys1zWk7QhUtb9+WbkgzymnTb8kP9aJ
 PSwEbX6J7o+OsKa9jOzmKiJ6NHhoHjpNHlE2DnHo9qI3VFHyvuzEWVsoRceYy329ty7Y RA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kqw8r0j0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 20:34:32 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id DFA44806B55;
        Tue,  8 Nov 2022 20:34:31 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 08:34:14 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 08:34:13 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 8 Nov 2022 08:34:13 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 08:34:11 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhKCBBez8AxzksqFp6/iEF/tGO+u6vm5Pk+fkggUwSo3O+81jsF2X38XvD03GCRP9a2IxuViYdK/ntEeBW1X9txDEv7lKXel26gP6B6QRpATxODu3r7796ACmz4ElbXBD4PEyqcOX8NQHt5d9Xq34OdYGSusbIQpizcwHm0VNkCgQBecfMksaaWxtfXwyBuJSDxD7CcXOvNcf3VLYISW3mmDAG8DMAWoBRXOA9t3HMyqj6cq6wlbQTY2KKIaSqVsXg3rduR482DI1GpBziACHHpzswJcs5cFkB4DLddlIn9KqiKkZl/61AGwtT5gzgPsnF4jZAjer6q4lARGoFswmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/7GBB2/K3K39TY5imV1840t9I4fsSrnUZTmiwKTCw8=;
 b=oIruVdP+JnD0zmQULPSQpHFZaUvZX9e11nOI1xxY9X+SJddGhxeajoFhXStIAslzJLzrCCGenT4qQIbHKSgpG47FUa0nL6Ny6uHg+6eP2d8HEctWeLLb2freppkLnPmeeihwiBlk2tUEJHKOO72bl6RMjgKNQyLmhObGrnL6BoTEf/vtBDQ93U4S3PrS3FCaHhmkuDcx/G2p2gbUnDUCu9mk0dasRjIV+6tvUlPlj6haffd5WyUCazRK830dTIKADECy12x2ZI8t4vcWO1NM3NKRAYDDNa56lvoNFRq8u+aJVvngh7VlcL1J2C/k5nLVaSAIIgCuUnx+SllDkqR4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1429.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:170::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 20:34:10 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 20:34:10 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Nicolai Stange <nstange@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     Vladis Dronov <vdronov@redhat.com>,
        Stephan Mueller <smueller@chronox.de>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] crypto: xts - restrict key lengths to approved values
 in FIPS mode
Thread-Topic: [PATCH 1/4] crypto: xts - restrict key lengths to approved
 values in FIPS mode
Thread-Index: AQHY831ixjJdferq10idPflaF1LnHq41ep+g
Date:   Tue, 8 Nov 2022 20:34:10 +0000
Message-ID: <MW5PR84MB1842EEC44A8CB6594D4D0CD0AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221108142025.13461-1-nstange@suse.de>
 <20221108142025.13461-2-nstange@suse.de>
In-Reply-To: <20221108142025.13461-2-nstange@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1429:EE_
x-ms-office365-filtering-correlation-id: 240deed6-6d11-487a-b4d3-08dac1c89789
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OD/S2+Cq47VAjWaR3keSqZr8F9pTuAFZmO6qOuVmmUds5FLpet/jKhFeKqzsj76LYATTvXtExMMHhxe3kknV/jpihA/E3zgMxNh15GNBRRjOt4bPC16j/YH3ZFaJMBc0aqLw/rQGIbXhfqo4qY4IpST/D5NJLdPzJs5+Itms98Sb0OzOKZkBYaRgNa5tDMskEeEXY4xb8NqxytjAjdEIfmIJGZhXO0xmAJjs1xNwrNuwtu3uevXlYSxVaos9Hm3E35rnVh5s4db351ZCznbT3Dv2VzmeDJnXEeLNsEKwqbeSMUcTwxgCLq1pn1OPWACG3m7qwPwviy6m0YX9kOJUuUJhc7MSztkOQcMaRUJqd+0wNFBUT86T/bfmwiHIC+Et9kEGYpKkry+NIac8Pso4y84sEPNHiU/TlONQoiz6SUYJ3mlSgs/OhPC+L7oRDH1kOhC+8aKkkwYFUPgYHTGI7GICVqvwLIUlZZFdalFWLHqU3W6KZS7bAMDrUmZSGhuVWSebPJ3aiwDyR8QVRJtSAJY3eAGR+zMhH3yUyVP31P+ObcD9jxA2Dt2ZC1igIYpq0RERHtrWAbyACNNXTw/naIzF+PtE14TmlhGlDuZdkXciTce9eVbnB98DsKsJp98lQQLia+zSKCEEVw8xm9bjDyNXf+e8uDN5AwbxCbpVfAzSM9Px72a+bjKz+3iiQRWAQdz1vBwLk899OpWA6hfMIteA4DTIFObZq4Ptc3TqIP5DxQhnLEu0L+0Z0yx4CXorZidXhwYv5dsZpbxXFfPsWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(55016003)(66446008)(66476007)(64756008)(316002)(66946007)(76116006)(66556008)(54906003)(110136005)(8936002)(52536014)(41300700001)(5660300002)(33656002)(71200400001)(186003)(2906002)(478600001)(9686003)(38100700002)(6506007)(38070700005)(26005)(122000001)(4326008)(8676002)(7696005)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7hr+beydPqAnGdZOEGsQScOq29Y0E8kCCQCnw+5+hZePrLaDwofHz72is293?=
 =?us-ascii?Q?JfhIMw4PXbZTWLkSK4W7hjBHhyYZF7FMYiQPHCwAV0uLPu7Jg0/6TwcH33lS?=
 =?us-ascii?Q?yqVyfn7mYN9tt4zAbBzxhrmImKpq/xSWTVKndxflLIq9bJ2Qq1WgwtoSpz76?=
 =?us-ascii?Q?v05Tqg8P2vyIOewJ9IN4fmW/c6IMwLKisTg7JG0ZLihkUz+7MJpjZyHOPhGQ?=
 =?us-ascii?Q?WVF39neVnVNYAv3UUjCiV45ItIfFZ9ZCPAAG9kolAFKvyqSTz/JQCspH8T5A?=
 =?us-ascii?Q?2fYpjQbu6lI9wgTh9Kz5DmXSvsZHc+IzOPEcYotTCxf001pvfTBqjQXFcBAY?=
 =?us-ascii?Q?nTBaVSBL2awKKfBlx52O5/mt9GlI3F+bgSgZ/NbkI92YQlQ4tdj1YKO1TL7r?=
 =?us-ascii?Q?TkF+oaNbXl/cawwZqu7n+2EYnluEGsPqlElAVbkgkQTZaMEpJiXTA0KTy8o9?=
 =?us-ascii?Q?5FINOBgFZf1/JZ5Woo5IJYqmbHomXjwDhle/SLc6KU15CEod5ooqMgq6aglL?=
 =?us-ascii?Q?HzJRwVHGOSuiioCy4hQyzMVkY1+ErOe44x+xSw+UN1UceTUbBizejMV34pIR?=
 =?us-ascii?Q?qsKWobT9j7y4LTukSPZCnGWZ81aXM1C3egF/GbBXigp5iuitZ/T7ZQG7Busq?=
 =?us-ascii?Q?TY+X6GWdfBNmhjnjo2VUFpZvh9AJ0SHOwtXwBZqmnBau2T2zYP21fqJOBmYD?=
 =?us-ascii?Q?lO4Ew/YHJutRapD06asmpmxZBOqTJOcxUuyejIHn40sSqRR5cwwKuR4GtqmJ?=
 =?us-ascii?Q?MdrOUfSxl6SzwDIhegfxGRsrhOqLm1F5nX/hw3oenNk/I8oTYJmli+/9umu2?=
 =?us-ascii?Q?+bdHZER2gFPjxMkQA2LpzZqmnOkX7KrZ7siAAVfC3MnuVeANiBLijIaLGnoY?=
 =?us-ascii?Q?8ZGgUu6lF54dyUgkcK/HDkU0Ize1YoM8ZeoxoIPbLN1b82XGj/vHWj1AcBot?=
 =?us-ascii?Q?rWgjji/rfVYqfKUlfwRMc0xgSxJjHHCxjhORsE5PGqBY6xh3RYHDVIFgtPv9?=
 =?us-ascii?Q?SAWU3cM2jMTv4w1TqOBaJvEaioPzsahBbA8SXUy/VPH9AP8ZodhjzXiio4RI?=
 =?us-ascii?Q?bW0Avawdvphs2PH+6+fcz1hnfZoqrVph/Pbq2Fqd+u3+GW8QKJZx8cAdeCjQ?=
 =?us-ascii?Q?RO/TnVaSEbLvj3NaakBwzsfrLwm3CZSgqSmXmprK+ALbLdcGR3d2zh56bOlR?=
 =?us-ascii?Q?hloDQEOd5QDUj5YQffS7RCB6/+RnQnkhja7SjtPkkqtZNRpJKpinRo4TQdOG?=
 =?us-ascii?Q?KI70sHfWLhaJj85VV51tuh8UGe4q8Tk5rGXDMLQcUtYarswT9totA0/OgCRA?=
 =?us-ascii?Q?La5QPY5ua7tyJ9M8CLqQopkMNLGBsbudi24tq/TkStF0INI0b8zFNvgNmM66?=
 =?us-ascii?Q?clv+B30F4/MckqcImAIhhB910/IuAGZ9gYaa7JAdlEeOLaC2GQFWED5s18xi?=
 =?us-ascii?Q?48mRFhpvzzJTPN0o1BWG28dfbnV6TBddLA2DFTZPUy8aUB9Nr3qQKVVq+jOn?=
 =?us-ascii?Q?PQcuwvz7nA8ROu5uq/RIEK3HeEVjevkNqd7Npi5C/tuf/W4yH3yxTuruHvv0?=
 =?us-ascii?Q?gnSu+IJLKR4YS22dWUU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 240deed6-6d11-487a-b4d3-08dac1c89789
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 20:34:10.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gd5uSgdi0FDYNPnzJZ5sDxuXofZKaWrFlkLolALfhFJCRxEqy3C89lUu1VdaHWDp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1429
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: FhFnDzrQpfRWoYBkQqtr2KfwJ2HoQanI
X-Proofpoint-ORIG-GUID: FhFnDzrQpfRWoYBkQqtr2KfwJ2HoQanI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 mlxlogscore=877 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/include/crypto/xts.h b/include/crypto/xts.h
...
> @@ -35,6 +35,13 @@ static inline int xts_verify_key(struct crypto_skciphe=
r
> *tfm,
>  	if (keylen % 2)
>  		return -EINVAL;
>=20
> +	/*
> +	 * In FIPS mode only a combined key length of either 256 or
> +	 * 512 bits is allowed, c.f. FIPS 140-3 IG C.I.
> +	 */
> +	if (fips_enabled && keylen !=3D 32 && keylen !=3D 64)
> +		return -EINVAL;
> +
>  	/* ensure that the AES and tweak key are not identical */
>  	if ((fips_enabled || (crypto_skcipher_get_flags(tfm) &
>  			      CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) &&
> --
> 2.38.0

There's another function in the same file called xts_check_key()=20
that is used by some of the hardware drivers:

arch/s390/crypto/paes_s390.c:    * xts_check_key verifies the key length is=
 not odd and makes
 [that references it in the comment but actually calls xts_verify_key in th=
e code]
drivers/crypto/axis/artpec6_crypto.c:   ret =3D xts_check_key(&cipher->base=
, key, keylen);
drivers/crypto/cavium/cpt/cptvf_algs.c: err =3D xts_check_key(tfm, key, key=
len);
drivers/crypto/cavium/nitrox/nitrox_skcipher.c: ret =3D xts_check_key(tfm, =
key, keylen);
drivers/crypto/ccree/cc_cipher.c:           xts_check_key(tfm, key, keylen)=
) {
drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:       ret =3D xts_check_k=
ey(crypto_skcipher_tfm(tfm), key, keylen);
drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c:     ret =3D xts_check_k=
ey(crypto_skcipher_tfm(tfm), key, keylen);
drivers/crypto/atmel-aes.c:     err =3D xts_check_key(crypto_skcipher_tfm(t=
fm), key, keylen);

It already has one check qualified by fips_enabled:

        /* ensure that the AES and tweak key are not identical */
        if (fips_enabled && !crypto_memneq(key, key + (keylen / 2), keylen =
/ 2))
                return -EINVAL;

Should that implement the same key length restrictions?

