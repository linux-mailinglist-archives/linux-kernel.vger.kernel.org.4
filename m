Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBCE621A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiKHRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiKHRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:12:37 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FAE6150;
        Tue,  8 Nov 2022 09:12:36 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8G8RNs027183;
        Tue, 8 Nov 2022 17:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=VjubFiu5aPbODdko/+L31vULKVmssheVVXHeLJmJsLk=;
 b=OB9OB7kpfjjUa+lXycFchl5sA5QyzoDtobPHoFKG1XZkgdWrOopMNOI4G86nbTu6oqDR
 5iX2KSyJZTWle2ZkLM53np4Iv/6JmL7Ra2RMDSiRSX4UoDtWFZI1Q5/8Fw/GyU3/h+Zz
 YfsYK5DCQ8+v6DS5mXp7IN45fAn1gzGbCB5i8ZIVYuatcMYDFJqS18WB72DgW1Afr36k
 eseJ4TSq/QH6C32YX3pWDaWroBIqeZG+WxmPQNm32tdfx2hnboGXdygDxgAbmCSXOxmk
 gmLlPsKetcU5h15VGyad+rV/UVdxBzeIyA90eLxcFnRinWbaFnfUBwSfCJ+QokC3k2MF pw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kqtbygk46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 17:12:25 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id CE803D254;
        Tue,  8 Nov 2022 17:12:23 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 05:12:22 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 8 Nov 2022 05:12:22 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Nov 2022 17:12:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph3c0okCN5LLhKUWNyYxY/DKKjZFreC4Dvywj9rKEm6R0WxneaUAa+sS9EccF18NlC3gnQUzXA/5O58Z61q37gwwWgXjzZq/KNmwSHF4FE8wsvN/mjzLhtNXETNIoW+VJtqH6+0bDD/pmwqOY/h3ILNMJN+whUF/6eF7xA8oOkSoDa8vXxQ4fLY/iAlO/yjwjhHV/LKE10LFuQwkRoOZz8JvnIYLubD50HQatqtxDGIGdYHsLBAMxJuTaOox9Sr6B1PAmzuWPEA+zxiopdSJ2unypcIHWZs+yMmNXFMbgRuEbuPewG3OuLStRq77roBXDR9A2fPELvgpCdLOMSIi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjubFiu5aPbODdko/+L31vULKVmssheVVXHeLJmJsLk=;
 b=YnHMO1SmNkv8f4XzIBJ7U7UiGN4GnBnB80NyIepkFnusYNa/8ldKJNojBZN0mITDvwQX8sjOZxCRz8bOYQfg6+H2O7jp+YEjPlfPgcYcYipQMEeeKYpUu4fJj+nHp7CGF5yVdH8vC1wyPSiEIrZGhbuihu8rJHH6OxjU/OAcxzrLbSx64N0uMpVVeH96BC5D16EAwOp45KjXEpXpE2YCdhEYaKcJbovEE286/DYJ0cBd2gmli/ioX7J2ywy1pCbf7w4mDR+8SY+TCRxcMQjVMuPLx+Db1Y+Va1u/EotRp9d96jmSHi/pSqLc93pPRos5KTyZYdtGMW/CVMp9pakG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by MW4PR84MB1682.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 17:12:21 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 17:12:21 +0000
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
Thread-Index: AQHY831ixjJdferq10idPflaF1LnHq41P+BA
Date:   Tue, 8 Nov 2022 17:12:21 +0000
Message-ID: <MW5PR84MB1842A19B7BDA70A7C81AFB98AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221108142025.13461-1-nstange@suse.de>
 <20221108142025.13461-2-nstange@suse.de>
In-Reply-To: <20221108142025.13461-2-nstange@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|MW4PR84MB1682:EE_
x-ms-office365-filtering-correlation-id: d2e9dc3b-b611-477e-4e19-08dac1ac65bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hywChcCQZ6q2Vom0rG66cqpuV3c5KV4CY7H4sQYsP1PGeKUQoIR5/4FOBFbXy40R7FQL/5queFkJ850F2SX9Jv5PHgHcPv1+VMJ25OAhBeRc0xplgIG5/wvI7cgk/0IhMdnoKMef9gorSDZ7L8N6r4kELtGZBptu4PpC0tM+V3pSOaDehB1XsuXmX2zKaIAgbMTOVsqilMW0yFSKAOf2T2sJIoSTFRhcDXM8ccEWc4ToZHsiQFLZ5j9YgH6jPfLEUC/mNGf9gVRdciY4hS9B+glxp6umkjUMGPjj4x+oWT3vk2T2pUqSn1QM//ABsFfY60e48pAdzovIjyhspzwW070+cQalsNiaYzTBPO1oGc3Riug3yKyOW00P68EwetLmB3HtxRvMA59KbvtLkZmwxHEms3Y20Edze8j7zmpUr81/M0LhrSnBPzUopNSg3SxofehlqEeDXslXpF5ZQO7IpkkgNykMherIrmsybuQhn4E9MT24j4F880eMnzso2E+ZVjS+a/GGEDMzf8SxZ3MZtUkjBRbJPK6/79bkCecF/BnKqhoHXlrJNJlchKTRcYdUa7VTrA+GkCZLdCJGc9UQ10O3WC4kM25V2+Dzl9zAKh2uxHXCrc8WZ8WwQOicFGqQBVf9cFZjKOB9+HXjT2Xz12qAkSik3zwXa6HeZQqfMt+F/Ikk4TRG8ulCwXoH+Kqy9UeR6NSC1/OuHql0tmka6DucAmmaTNLOj0qu81CUIfa7O+Ic4jEeUBFZFwoz9wjfgtSZ5L5Q5FBsiV34bjS1Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(38100700002)(86362001)(38070700005)(82960400001)(55016003)(33656002)(71200400001)(478600001)(2906002)(7696005)(66556008)(66446008)(8936002)(64756008)(66476007)(4326008)(66946007)(76116006)(52536014)(110136005)(5660300002)(41300700001)(54906003)(186003)(6506007)(122000001)(316002)(8676002)(26005)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UalDIT0dujtjLjg3+wufsxPoCNW8lBJvEKJBGPehRNYo+YjGsF5xYwKclFnP?=
 =?us-ascii?Q?/CPbjHzH90bsY8uQrBCOi3h9Vps00ivx9kkU7q9sPUfH6NaRl8TEj4CMoiwu?=
 =?us-ascii?Q?3tHXMkuaA8WnVr+Jr1Q6foMWVix8ADJpHl8V87oI1eVSffJulwEgHrV5gxlN?=
 =?us-ascii?Q?SvcWvsPnOX8bic10huRHd9pe1c8GQxPX8Is6EVMaukIpJJv/O8/RX9mWSzhO?=
 =?us-ascii?Q?AGf47WxZV25tpOmMqH8wFG7iT6STlqj9fbtNcg5arxTb3QGiyInNDS3yaet3?=
 =?us-ascii?Q?I0S4Co3pfdrZpv0ueT9MDh+uHfecKzNqT0VprNZlH9ttwAp2itom/zVXgL+b?=
 =?us-ascii?Q?2cGM8yo3yWOhIs+2iRaSwk6Fso+xQ8XrZGhNYWfCVYetUJRJ8/sPtbby7ljy?=
 =?us-ascii?Q?hbziLSUfq8ELh+hRhunJYcL2+RlqO2jfETPbifnNLUzi5PePRTX3Ph8RG5nb?=
 =?us-ascii?Q?OFmXd5plONmv2KofwCXhRitMOhLgLShb4JGm8sqRmCuG2LbCtPJw4uHxZsmj?=
 =?us-ascii?Q?KVbaEg4z8xB6maWRJknnjq9/+z0U2zdVdNrTu3EjcvOCHfhNI/FjAD/6YdJm?=
 =?us-ascii?Q?W1TcYOQ06IYSR6vjh8VvR6vOEw/vO/WaxrBkAFM6PyC+3PtmEPX1SE7rLQ1s?=
 =?us-ascii?Q?MqJSsA96Q+EZwwhhawx1Y4W4He1gLlAwFHgo5bOF0UfU6eyfl8tcJ/rH/yiu?=
 =?us-ascii?Q?lD6BF9ogahOwON2SPPNeUAPrIilISmePds4Q3WsFAQo+B01l0oE1fz8ZvFB7?=
 =?us-ascii?Q?fHiCjsl862I/IycDwYI3MLQQiMwfIiKSBt7pP5uoL5tvTKbizVfe+Uydk9Em?=
 =?us-ascii?Q?9I0jd4st2xmqNBL7eUakbbisHW23xUYqit+yh4r7jUAL48KqD7rcaDaRMxDj?=
 =?us-ascii?Q?DkuIqffAh0Vn2nShauC/aPimfzh6Ott/I0l2g6Ov6WdvIDMYEBBRCPGkDKTH?=
 =?us-ascii?Q?4qVrsLdf4fr7dhA3/HvNdc2N3QWxc4dcdWyatl9yJSJ5fOHBqXPqVVUH9fuD?=
 =?us-ascii?Q?6h53gytSTi3TWyJQlBN643R7ZrelX7dMWUrCf+ISRcNewVC/17G9bTJRXILT?=
 =?us-ascii?Q?iCq+854HV6S8gKUNsFj2XHEamXmG1W4NMAt2bZpPscnqV3lscprhuEFZb+74?=
 =?us-ascii?Q?hnRKVt/mCcH/nRNb2T97R4uo9u21alc7nP+jnrPLiKlbeQeBMLm7GmpjG6G3?=
 =?us-ascii?Q?Gj5BCtBfC5R2RYCAyQVdHXAFfhv8xtqUvGrCQmxJ6I8wdxSE8NOew7NS7VdA?=
 =?us-ascii?Q?eCU1TiYRIfkp8etzhISvT6rVf6JCH8pLyeBaETLb2jz3P7OnorXFVPYrQopD?=
 =?us-ascii?Q?TqzBckTiZVpfg84zU2kpgVm5gv3O9BDH5uOy6d+aMezzjfblo4r5uhi/6Yh5?=
 =?us-ascii?Q?QQmq7wAIZretrWsgkH8aS1EbGw0A2ixvvo5bbynFFfiiEFx1eJlLkuMcJN7t?=
 =?us-ascii?Q?nGRr7lN4abzqtbIN0nEKbTXw4f0E1WhOvWR9B0O+FYI8Uigs/vD0/LmSV8TV?=
 =?us-ascii?Q?hfFQPurXzyZfJ/RoxDyOUxIXEJuT/kpbbVD6Az4fICo+JjvfLctLF1G9pDwy?=
 =?us-ascii?Q?ByU4QykZcMAg6tOoFMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e9dc3b-b611-477e-4e19-08dac1ac65bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 17:12:21.1096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4yzOJEMy2/pEUjz82BMEcls9GLQeONsxadCaaP/yP7Aq/3/hQRwEMCmaND3aS++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1682
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: W_NBAQvxgF5zG1N925ZLM3Qnn5EPJn5k
X-Proofpoint-ORIG-GUID: W_NBAQvxgF5zG1N925ZLM3Qnn5EPJn5k
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=722
 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080107
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

arch/s390/crypto/aes_s390.c has similar lines:

static int xts_aes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
                           unsigned int key_len)
{
        struct s390_xts_ctx *xts_ctx =3D crypto_skcipher_ctx(tfm);
        unsigned long fc;
        int err;

        err =3D xts_fallback_setkey(tfm, in_key, key_len);
        if (err)
                return err;

        /* In fips mode only 128 bit or 256 bit keys are valid */
        if (fips_enabled && key_len !=3D 32 && key_len !=3D 64)
                return -EINVAL;


xts_fallback_setkey will now enforce that rule when setting up the
fallback algorithm keys, which makes the xts_aes_set_key check
unreachable.

If that fallback setup were not present, then a call to xts_verify_key
might be preferable to enforce any other rules like the WEAK_KEYS
rule.

