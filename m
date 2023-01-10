Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67E663E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjAJKqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbjAJKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:46:14 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D215714;
        Tue, 10 Jan 2023 02:46:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csxk6BA4lcJM0nTEGoO4eeMGHDOiD56SmI4ePEJnspoZVCUOty0+IPs83GZ4tQxvU5x5Aq6CqLMv+Pi3lcR75/TLh25RbZdEWt+nBE1KvCgnN5Vu3W7alkQRs6JpNaVOn7UnCr6pkUudwoNAmdNQ/0sWqELLRFliAA99Kf1yj/523+EyGzbQe8nqJj/ZfkcO7K4ERKDBbmjCsXy7nM0KfhJVtC1NELp+8hlc798sUdzbMackQDG5nx7NIt8Sw6d6sPx8IQZKO/5pCEZtO4w24R6kOnosZxar1+Q91PnxJbrMI+cLijT74zqemdBKV2fFtDG7SPNnKbiGCXtKqxCQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WemXPSDzP1uvfDalct+Neudc+HETSHmEb/HMgu7kVN0=;
 b=dCGZTIXwyQ/TnxPG5S4PQT/Wkn8Zzavjyi7LxWUTZ+1W3Z4RT0de4SijC6soMI6kMbOHcU4K8+yanUlEEhVpVzT4OiGIeOJhChZaI5KvK+6LqOUAwS3R6kSvi/iPe24OiOW/5BynLKFpD/o02HIZjswv/zY0iyrBPQ0hPsUFWx7pVtA0DfoGkXcM5McqyM2dMHryj2WlJgIuOA/1deMZNZtfD1+jUhaCjFAvF/e/+j2rdt7AekT2ZXFC8tAxzHddHrL/DyRRBkG14/8OyUGWfxo9zH9+1H+QqF2AHPXKd3vuqxw8LZgr6Yd3DCYW4VMfK79eiHkifHR/64wPiyWcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WemXPSDzP1uvfDalct+Neudc+HETSHmEb/HMgu7kVN0=;
 b=Bttu2uRkLwrwB0vHdCNjIuFY34z45VKIHcLOmAuNROAXRwrQqpFnemjL0dG3mwq5V8PLqmzYf7oS2WxMe4prTFmTjFy1xcZwd6QRqlG6LCqf+t/r7Gn2arQmHL3o80xIeKt2Br72EJXS7jai0TjjFdrgl8gwT0Kvsd51QSc2WPoDbH8ouivgW8Ea2LE1rXYI/YqdTx/sQqma+4mBRkGFomaM9cuscNtsEcLfGw1HA2GLuc9tuyiX1o+XBeW98zBQTF/mDkVuZ+5dYOiWg/R+sGDNPF+7e7+MTXtdoOUkECnOPm6twLlD7a+QgWdoHuG4fsFrhxAtBE3dBx0QlbZ4NA==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by SI2PR06MB4122.apcprd06.prod.outlook.com (2603:1096:4:fc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11; Tue, 10 Jan 2023 10:46:03 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::abee:6367:ef03:e60b]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::abee:6367:ef03:e60b%7]) with mapi id 15.20.6002.011; Tue, 10 Jan 2023
 10:46:03 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] crypto: aspeed - Replace zero-length array with
 flexible-array member
Thread-Topic: [PATCH][next] crypto: aspeed - Replace zero-length array with
 flexible-array member
Thread-Index: AQHZJJRaDVnvok26Y0eyz/Y/HvnX1K6XeAsw
Date:   Tue, 10 Jan 2023 10:46:03 +0000
Message-ID: <TY2PR06MB321351BBEA501A7BACC9802C80FF9@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <Y7zBxbEAvcEEJRie@work>
In-Reply-To: <Y7zBxbEAvcEEJRie@work>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3213:EE_|SI2PR06MB4122:EE_
x-ms-office365-filtering-correlation-id: e24a1b5d-f759-4404-208f-08daf2f7de97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Je0QQb1UPdWaXJkFeTBHEYOV3F4QAJyDPZrxpqx/W90cSs8QjgXQKxYf+uGbjsxnNpTxpIwLCDA7pHYD9JQQUI63a8r/tBh5nfz3efC6OWXkSVle35Rf6bVGzSZHmR4BpYnAYV2bL4QYxh7nut+NsVkq51Wb904T7mpOGj5SIqf298dUgxajaRUp7qcLwL6MguZEw6DeuzEsIv3Yy46gsPyiaBxrAVzGlfoEtBqMPMfqVmeHIf/wfVmlLRbzhoSGXfCmUmB9q30gCZJ14UQpd/M4cibj4PFYCBRQurRKvMqtpOyfVV30YAcyWHUquC/jWkSw7uxKTP4CXFbIu17Fl3zt97o0YWE7BGTmYK8OA/m10c7AwZV7JCfJZNaJAZ904eSbe65Spz3bBVuHCIxoJJtq6X15AOYIPRnODyE4ODg/87nHQQMkmSUIViLyk8J4VJzbCkdfnPWGtC05mw6sDXM8mfPvH2/H36RE5LvBUSbv53w9Pe8mPGdcnYgtPZaxSqLfaJWM8oYwdspCdFtj+CKgeXxI7l68LjrONAkkVZsfh14aKTAQQwmG0ub0n0NasHNT9r81EgY2WPj9hguS2taHOBBchQ6Rta1bU4OtTwlF2Hk2viAGypA+VU6I6h8aF5hFhhP4a82CPGpP39NEEtZr1JwPryRGBoPpGczSNeLzyCZKItv2f/iUOfHjXaOW4TZ3f66OU/9v39/CQT6bMSityFAJhHAny9Syeju8uIM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199015)(38100700002)(122000001)(33656002)(83380400001)(38070700005)(86362001)(66946007)(41300700001)(8676002)(76116006)(66446008)(66476007)(64756008)(4326008)(66556008)(110136005)(54906003)(55016003)(8936002)(2906002)(5660300002)(316002)(7416002)(52536014)(9686003)(966005)(26005)(186003)(6506007)(71200400001)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1JLTJ4oOpSgfGSc5cyDqGENUk5UvTYXB3V3aBrojkX0h8fqujF8SWfUcRG10?=
 =?us-ascii?Q?75zZhjoOpKsTEYd9Fy+aNPTASKeXlJVIirEGtOcJ038UAde7xe5zP1h3niUQ?=
 =?us-ascii?Q?hwnpj+KV/iyvaoanhIH18VcPZclbdSg6YtKIvM+yqLNYPoBpx6f+lS8pfkeh?=
 =?us-ascii?Q?gU7l0jVMWNk1l97VS8E0uxuINab7AieFk1C4Ks7T4YTRvz1WYvtDZ+kMqQ+s?=
 =?us-ascii?Q?zfMG5m4e/pvc0SwED9aKxXegnjIWydzfVNmagZOZ+iXhmOk/0lGreHVQuB3A?=
 =?us-ascii?Q?gfL4AZv7A37+nPGZ6d9uoUrecyufjbUhzXjZqGCEq4wBRlSX402DrPIwaMCw?=
 =?us-ascii?Q?961zhCHCFUfXhS6icZJl8KfCMgSH+n6DWQr48Dtqk+sGPi9Y0VyrZW2gRS1W?=
 =?us-ascii?Q?jfkVjUxl5Aq8zK/59eFW53geQlPJzRL0dWXBfAmegghoJ+c5SWH8lFPYwuAf?=
 =?us-ascii?Q?U/8FYucu2LKRgMc7iaBadE1CB582lrBPuli2wELBQWACK290BXMm3ZUZPaTH?=
 =?us-ascii?Q?VtEiWarfEg/fsEFWwc0ySNbYM7cSuEJodR07csY79TV7AOr1ZS/ORsxLUJWB?=
 =?us-ascii?Q?Hb1638HhxhOpBwPXV74mHcPkmz0T2X0EKAPWa5czu0wk5Xc16ZGOEYdtfIKS?=
 =?us-ascii?Q?vAlH/Y2Uuu6yAzc3pBfCfW4qV8ZEnVo/rUy1sHGmGuv/HIRMBNe6qvcua34m?=
 =?us-ascii?Q?GJNb0Rx50PljY8JCdMJP1QZTaYfnr9uaGlRn/uEkp6RUxm3P7859KRo8hi6z?=
 =?us-ascii?Q?UrBAJbJ95afOn2SDtfjtw/22Y/wxd+iVxdCffI+cseN/CV2T35ejZoys+8bz?=
 =?us-ascii?Q?wrzyt2ucZqyINli0lpY7vhc1j+A/N89SjgHSmPwIfk6XJcumsUE/5zNjuEQL?=
 =?us-ascii?Q?7EjPO3Lnu+Io+LV4xnoP9RcHifBlyZBlm5j8D1obYafc/JZxjEr20vSQu95z?=
 =?us-ascii?Q?9gYXPerdWsv0ZurNPGzWsJkwI5wfha2PH1WYOPmoOUW/IAL4wh7GyhrNNYHw?=
 =?us-ascii?Q?5ELy5mYcwFjWgJPj6DwHctK3MA17Iln7VHIykxz+YCW47H3dCrSfFMn3tFgU?=
 =?us-ascii?Q?6NZB3ooV98xbaOQySjfl9ZgZ4ogqywooD0yhWOCOZNmD5m1SwAdPmUNPsCxV?=
 =?us-ascii?Q?jjFXTmtQJ4Af15b6vsPgLZRe7RknA1jCRJ9zLoNIodLeqjvNjNXBEEaVQUAX?=
 =?us-ascii?Q?BILDE1nHFz/rNUynKsLBU90osbXqteRnlE6wp0wYpU+tVrQQxL6SWq7YQrNJ?=
 =?us-ascii?Q?6Zh2q3j7oB63udJYW16WRefnjI3fpUiKv9AoxbYJyBrFWVZaZbQw2LClyck3?=
 =?us-ascii?Q?Gx2MZulxSpM2hSDWBnnFf/TiJbUKoWawsIH7h3cH+XJ/8F/uOrHns8mwixvz?=
 =?us-ascii?Q?3wYoxNkSxUEQr37R+o2AWdJQdEIFkRSG+889iDLIs0TbI/IVv740lG6kG8cg?=
 =?us-ascii?Q?ChLHxMgP2nIEag1META7GLsmwzt9xNcvqev7Hm71nPvPHj7oI6YaanhYJnDJ?=
 =?us-ascii?Q?/iHb5WTedgYAOt0TYqP4k0cgJieQ0jTTPToivGS9Hp81+DGn5Nw7xT17rXDv?=
 =?us-ascii?Q?tTrw6QULaqcQ09+ZGHb468dlXDAZS6epvy9QlTJR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24a1b5d-f759-4404-208f-08daf2f7de97
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 10:46:03.1480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74LZMJPJgUCN36thYG4OMSfD5wFD/dA2VqxZUzOFkxI4Jl70jmFXSoVFpPK+xLmQlN31HissRwCjugFcKn1O2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4122
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Zero-length arrays are deprecated[1] and we are moving towards adopting
> C99 flexible-array members instead. So, replace zero-length array declara=
tion
> in struct aspeed_sham_ctx with flex-array member.
>=20
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routine=
s
> on memcpy() and help us make progress towards globally enabling
> -fstrict-flex-arrays=3D3 [2].
>=20
> Link:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-lengt
> h-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html
> [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/crypto/aspeed/aspeed-hace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/aspeed/aspeed-hace.h
> b/drivers/crypto/aspeed/aspeed-hace.h
> index f2cde23b56ae..05d0a15d546d 100644
> --- a/drivers/crypto/aspeed/aspeed-hace.h
> +++ b/drivers/crypto/aspeed/aspeed-hace.h
> @@ -183,7 +183,7 @@ struct aspeed_sham_ctx {
>  	struct aspeed_hace_dev		*hace_dev;
>  	unsigned long			flags;	/* hmac flag */
>=20
> -	struct aspeed_sha_hmac_ctx	base[0];
> +	struct aspeed_sha_hmac_ctx	base[];
>  };
>=20
>  struct aspeed_sham_reqctx {
> --
> 2.34.1

Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>

