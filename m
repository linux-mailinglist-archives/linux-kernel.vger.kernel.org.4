Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328F15BDC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiITF0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiITFZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:25:50 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297CA22BCC;
        Mon, 19 Sep 2022 22:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVUPOFfaXKravu3JZhthkL4Lr8Z1xICFzuDx2zzHGXg7yC+zJKbCjUE780HTcywmfwgnKys02MALqSUR592p7hX++5EdzpuZ5ELmg8VJIXkZD9Vcc6BqoHuivFShG09BeSpECfsRgw0+X1FBfbBg9sd4MuxdTxwMuShAwRncBXxGbMX/wr7LxrxY146DRa2lfk6p3sl+jlBTbCpsbGlUOglJymrCbZepU3nMEbT+oX6SZl6AG1CDKPYllA4RLAo7tE5+bQToXsTi+hVWY7l8gBga4kNni5md+mi3yzMvLlIKCLSJuuEQmZjJwFD61F7inxgH/uVZETUpZbl8wk2AqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtegD6e8uyeS8Ho8KQyFwt0iJdQAyULi3BLvUMO2gco=;
 b=LbM87vo5XsvN15E8DRVpwLHz+P7ag+3LLRIZeQ1MZd82h/AnXXONtKE5TMunv+2c/Xpp/fuNhZ52tn+7XsoQcb34U183lBXEBJXO8xAfXZLocH8pgnyandHim9y2YF5i+7Wg7TjyIAVDYYlkG/rqE/zdKQQx4qLEaOtnRZRwskAN1kEWgqd5Varp8O7MGHuYrO2d7q18AkidAHHINza1JKvZvBlNQAkQZHW3LnqZp748bYq8zCWA4SP4m2IvwzHSiiXu18Pxc97a28v70AWcK0QlpxjjMEcXyeKzLd7Aa/+PcXj2sMkRrIESfz+En4rsS6is+aTaO01y9exqV6GZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtegD6e8uyeS8Ho8KQyFwt0iJdQAyULi3BLvUMO2gco=;
 b=MEtsG53tXb6Tm+mkRm/7ELKrtR2SV2QOR7QjcHJaSDoDLG42wcThb2W7NE1YVIEzZrf5V/VR7xeEILjCdh8TTLbpWn3h0MwPi6rP2NKGO+GRcLEDa4LbL5U2RyiMKdUcMMgfUc73aUmWLw0QXm+1ITQIRekouWX6twTmvYh0tDUQ3hxBv1Sd1U4RaLDXqku2gy8L9r0Db1qohGbxt0AZ6lfO0miVbjiDoby9jEXiOCg/1BTilHAGrgIsya/Sa74a7fiNcLOpgzhmW1qWI4cAX8yIob+J5nBBnImlSYTC6VnPXtmzeCyyygav0htiM6sFvNTH52RL9Ybmz/OYAGTDRg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SI2PR06MB4156.apcprd06.prod.outlook.com (2603:1096:4:f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:24:59 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::ecfc:64d3:aa40:f00b]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::ecfc:64d3:aa40:f00b%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 05:24:59 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>,
        "dphadke@linux.microsoft.com" <dphadke@linux.microsoft.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] crypto: aspeed - Fix check for platform_get_irq()
 errors
Thread-Topic: [PATCH -next] crypto: aspeed - Fix check for platform_get_irq()
 errors
Thread-Index: AQHYzKASz5W956DPPkSernGxRLDZAK3nyTnQ
Date:   Tue, 20 Sep 2022 05:24:58 +0000
Message-ID: <HK0PR06MB32020D94813ECDFE5F16B900804C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220920032118.6440-1-yuehaibing@huawei.com>
In-Reply-To: <20220920032118.6440-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR06MB3202:EE_|SI2PR06MB4156:EE_
x-ms-office365-filtering-correlation-id: 8424e262-ec0b-4e5d-78fd-08da9ac875e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FH0zfoKk54mlaAHuYp5monhhlIIwDmHJ0g9BP9rpspIIq/LqRbGEzNM3VyDg7XN0Xhb7EyFF9WGG8DeQwqkqHDW8Zhu3VDQXRWjpnJ+7lc9Nj+3aahsJy3Xu+HWjv4Nou9rjsAfem6KBxxUMA6RUFpl7Ml45UX/aNHaSPjmXqtO6Qi3dF5WaHGuyKZ4RNBYp+p4guRtIPXQMquTL2/+i6j3w5bmhJreOPd/PKZwEWKwC0dIjRwe5hgwx7IhbAaN7cg3kVrrB/OypsdUaOsIDKG0F2KUS+rAuynBjdBDsgNfN0EqgRXDzay2OgfSKJ410LYUtuc8icrFt2m7g7UjGTziMY75DgzI0vRuLtM0HAW6vRjA8S/ijn0AAwCbUlIk07RMILfPSkb41Iacm439uVR73LkOttsGhK+O1a1MWUVMetIww7fvfyIHxMHX8jVx4apP/ccXmWfIPGcyIqJU/m2rnGpx7tq0b4hvlHaeJc5VdoWfc5GJJ11gpoxeVbf3w1h1NoC4VMscFDmtDYj/UWlvcFE4YBpd6XnlZV9/VDcZVyjNYgbhRtmqbofp2bmCC0l2IE1+TTzq3MDLbKi7xtdHhW+e/cN9S96Bt7Ws/2ZLEBF8x3ciQkjBlxWYU8xt2z1uBQ/1RqmAT7EPqAi7sHXX8x0tyqVkcYOTYTVIkHbv75ICGWcyN3H1i8qMnzQFM9vlEg/gU8KnDu3lyqSZiQVXiw0Ts7S+UVnHk+u+/RLKQc4bU5mRw1LOfXtoY3nP66T6nP2IRDcRn7lhfCsWJ5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(366004)(136003)(376002)(396003)(451199015)(4326008)(54906003)(110136005)(316002)(71200400001)(33656002)(86362001)(38070700005)(7416002)(52536014)(122000001)(186003)(38100700002)(6506007)(478600001)(76116006)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(41300700001)(9686003)(26005)(8676002)(7696005)(83380400001)(2906002)(5660300002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CePbIgUKEzkpz31Cd4JIWn8mp42VeV3DISLyDhe1/UFy22RNrUcVi8plxTEV?=
 =?us-ascii?Q?RzBP/vhnaPeYkSuo1//fCqrQvRIsY4xzdtU/H3InheYTsCiHCOuVY9syyITM?=
 =?us-ascii?Q?EQ4vxpbaAsJUT2iexrFuKekzSEdDRn6xyC1dB4W7b/MDdY4JeRrUAqC2MOJQ?=
 =?us-ascii?Q?OlIm+k4B5IqfEDEcZ1EL8nSmj0quYc6/hGtfGz1K+HAKeCxCZhl9hca77Edu?=
 =?us-ascii?Q?tol3WHcGls2E5wX2iyKv7iNEv/VgUfsTCq8YlEZA8ggotLwLARrWiTgaV2a4?=
 =?us-ascii?Q?29rb72ITcJIHu17n4wWWf2KzX+dxysa1JSTb007sPHeAvyScNLMe6TH01ObH?=
 =?us-ascii?Q?R6g/LSu0XP6hjLdbMgWB2kPrJOlyeHTM/IIlwc+B66Pwm67i8D+h1Y9r2LtR?=
 =?us-ascii?Q?PMb8GDsiHabm9ReP0727n6mzzf4bnZg+b8t6rR2wcC4Q1wNd/jMySSEKZBoE?=
 =?us-ascii?Q?L6K67xg6+OUFxxuVQHx9Rvc4i1Bx0L7iifZW/FE04RmUjul/6kdFfkYQP41E?=
 =?us-ascii?Q?1izX27wLasXCnDm7O4GNfkaMBpOrjOLstvl129PVjdEpBYFpFJGT4aCT1DJB?=
 =?us-ascii?Q?N/LTh47PcgFc6yw1fcIse1dgarXqbZojdb2Ft6aBDCyRmVxorr4nU8VGPCmK?=
 =?us-ascii?Q?drAB5XlRDMnXHeYuq4+zPcuDGWXht7FmBMZHcJyn6xlMXiUYQhef017EpAzM?=
 =?us-ascii?Q?CnOZl/oB2MXs2cmWcgG4vQttFwRXT7xc2j7pe3eKrVjyn8MYt8k2xKDySepb?=
 =?us-ascii?Q?7x/9/fs7daU4Fwl7udQvfb8H02/vRjepum/TDDJh8Kn3BvMdehZ6d8G+TlcS?=
 =?us-ascii?Q?3GYlO73vezebU/ikB+LjKsrojRJPpbIPrARh28MADwsQu9qGM/RZsIH2khQV?=
 =?us-ascii?Q?L+68opR2x5sYul0qUP6dVkZ+qkf1LpEGALWQJ/O4cGI7VB1R7Vcj/czv8pRZ?=
 =?us-ascii?Q?84B/DKzsieIR4cCbL031q1SHu06kM5/6S3i7jROpvtyyglzKsCj/wJFmkyCg?=
 =?us-ascii?Q?O5bHlqrLKDtZAgTVHiqFfnFSuA8Rdfl3DwlElqVi72VIL99mp4hgeNipAdRu?=
 =?us-ascii?Q?XmLDdYBH5kzsqQIIS5vXK3CGM/x7in5fzSHgyrjEw4WRGgObyuzS1rqiOQn/?=
 =?us-ascii?Q?tdxDl6+mzd7IX+PyGIVrOZdhRhOZTQMfIXvB0bK54mC8fJdPCUHDxr9cBpWt?=
 =?us-ascii?Q?pRKVYeFCYoExQ41zydvaN+39KpXy0k8UBkSgFdi4x5kymgYmZmERd+YQQL1q?=
 =?us-ascii?Q?foJ6F5Oz2as/BHgbIW60a63IpgnuVfzyBr2xBTnqlsXJEtL5ANcdwlEx1Acw?=
 =?us-ascii?Q?zyWLEHs+bWJHGB3zjRMg45Q7UuWakJHq4qNtMie8PfDhJ6o1dCH0iUbh8K0o?=
 =?us-ascii?Q?ypM7DW9YmAsGE1lREfhFsVxM9PYd220dSWBti6kLpv8+oby9OV9bSmxUxYJL?=
 =?us-ascii?Q?mn0zQ49FHtnpadBkMfAlnSbyB+96eJJ+q0fxcf8m7sEEkb5QQWlFOf6jTuY1?=
 =?us-ascii?Q?9uEC8MLwgi/FGVG4b3hLKrbpYIOCJWN0BdYKqI3Dqyt9Lt32BPxoWfAq6Gi6?=
 =?us-ascii?Q?J1BUH4q1LGy4SaRcXcidtgpa6g9sgbh2u5YyR0zj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8424e262-ec0b-4e5d-78fd-08da9ac875e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 05:24:58.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tYUbsqwc7l5micGCjgSEY2paiEmjJnuPbt3s9GuxbjpwAZOQsn8acLv6YR7Av5TdSany/py7euZ2/XgZWAVZbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The platform_get_irq() function returns negative on error and positive no=
n-zero
> values on success. It never returns zero, but if it did then treat that a=
s a
> success.
>=20
> Also remove redundant dev_err() print as platform_get_irq() already print=
s an
> error.
>=20
> Fixes: 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>

> ---
>  drivers/crypto/aspeed/aspeed-hace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/crypto/aspeed/aspeed-hace.c
> b/drivers/crypto/aspeed/aspeed-hace.c
> index 3f880aafb6a2..f7f1d33defb1 100644
> --- a/drivers/crypto/aspeed/aspeed-hace.c
> +++ b/drivers/crypto/aspeed/aspeed-hace.c
> @@ -130,10 +130,8 @@ static int aspeed_hace_probe(struct platform_device
> *pdev)
>=20
>  	/* Get irq number and register it */
>  	hace_dev->irq =3D platform_get_irq(pdev, 0);
> -	if (!hace_dev->irq) {
> -		dev_err(&pdev->dev, "Failed to get interrupt\n");
> +	if (hace_dev->irq < 0)
>  		return -ENXIO;
> -	}
>=20
>  	rc =3D devm_request_irq(&pdev->dev, hace_dev->irq, aspeed_hace_irq, 0,
>  			      dev_name(&pdev->dev), hace_dev);
> --
> 2.17.1

