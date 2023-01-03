Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB51E65B9D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 04:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbjACDiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 22:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjACDh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:37:59 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA24D2C4;
        Mon,  2 Jan 2023 19:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr3EtS5+aMLDASFU2soxLC78JoT7PRjZKW0tOdWl7z7ByzFChi0Q0iCsrtr50Oh6u1P3BKPxkbqJ9rx/jfpbNyXyp9Z17h4CScoJFf6F6ID7SSOLwxenSf/kFC78ij/mJQL0zH5x2sR7FE6qDfLAKwqFjTZXAJmXdtcNTXIZ21o4PJHihpOLsWOVclwnK4L16iyfZt9mQSR7mgEUVZ0zwRP1U/vG8iqxByU7NCerDoQPeJdYkixyVhsa/Lo6QYbcl35mVWg/2f11rJkkuxdRI4XjLox/CF71pQTv+B/j02+W5Fy3T96PBT6NFJl/omsSqn4F2+JZl/Kp7sRqWHeuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+91SXb8PrY8K/2IWgJo9vDKxQSTSQz9Flc2s+Ap9R4=;
 b=JKFvCYNVUsShL4chdYlybIzlBeUQykpqXi9fZnDnNFSb9CuFW10x17jgwSNJIKeEjO2W07z6wFe3VFoEs0b/dIDn5+aoV8yZOw1EnUdfDzGALTYy6EN3Hn43bz8h1ugIW18o/5ZZxcvKiIu0+9NdGMMKL8g29mp8tsqjE9a7bKZYBn4S/dt7AROrMs8E4x3lJbmU86sgwppp7SFOHwDOtnUPBdGCE/TdYr3KesI5IFa9OGqnVEj0EmZ+v+1z/sRMroU0x3Zvj8kAruyqQ+8Jo1lj1l8CmLA/48BAbkfoE1AN2ShaJKOBIDZUab+3mhM1REhaR5wkBV5R75hMEPk7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+91SXb8PrY8K/2IWgJo9vDKxQSTSQz9Flc2s+Ap9R4=;
 b=U1AC8OB+4TURjLbKb1hjqoOYDKQXTT1Sv/c7EY+LVMot7nHEZ0wTevDdMyX1QjbLyWd8GPEiI65SG+CaLCIM1vqttFto2JQCEepBB61hgstG2jX5Amji82xxE/TDmRyZPbkZw9ewFsYqoym5HNURJdw+J/tJV59FGcJP6xCnxCnG/8EPkHD5k+J/JKcOBiixXJHvc73+NXMl/aIGbqy4nIAG2gAde5/WpwxBRuRvmsCIaZ8ZPtXl/+tFddsgGderCXxTz0Yq3so1YPgbpoXpdV+l5ytYXTPeyP2XKq+c7FC83kPD+1vmHjC03zGWmWphG3AbtO6P3aL4abEby19gaw==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by TYZPR06MB5782.apcprd06.prod.outlook.com (2603:1096:400:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 03:37:48 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::abee:6367:ef03:e60b]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::abee:6367:ef03:e60b%7]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 03:37:48 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH v4 1/4] crypto: aspeed: Add ACRY RSA driver
Thread-Topic: [PATCH v4 1/4] crypto: aspeed: Add ACRY RSA driver
Thread-Index: AQHZD4nhuBerx3rD8U+/oUEvaZ6riq6GMoiAgAX3k6A=
Date:   Tue, 3 Jan 2023 03:37:48 +0000
Message-ID: <TY2PR06MB321306D17A97FBEBFE969A8B80F49@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20221214070114.3966155-1-neal_liu@aspeedtech.com>
 <20221214070114.3966155-2-neal_liu@aspeedtech.com>
 <Y66hXZHl+kqIivOl@gondor.apana.org.au>
In-Reply-To: <Y66hXZHl+kqIivOl@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3213:EE_|TYZPR06MB5782:EE_
x-ms-office365-filtering-correlation-id: cf9276da-77c0-4956-6b9b-08daed3be2a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zi2Oa2GCIH2gjTrk53ZuHmFelc94b4tKrHB1g9C5ClWt+VAgx3FV4Btp6n/f1MqSq8F1Qvw7y/Pi6J3AIb5QBMdVsLzfM9CuRRcJ0i92jSrEQwSOQsizkxQI3JGBXBOlsezFZe95Fzmg2aTh32O+QhO7fMF7+AqttNCGxZoP78/q3w/ntlJpzs9kgUCFjapppLRiMcBCSzD9VrFi0KEf1VZiRUx/cM+FKgJAHIMtWx3h9PPGj9ZU9jCPEJyRQ7oodqZ94FZf5DqH6aBPjS4ZjIqPeV9Jh1BzO301tiQXQzxHKFYy7prLafzRYPNzd+UaqzJw+u9XIzp7voxLg+QT39OjU7EmuJ8HE4cusd3iwDWYwiEX6y2K3HbIA1ARpugBlP8wu8zag/sRPtWOxnuOYUHMeu7RQJ6QibE76TYsZNCJQTfX5sHHPqH51XhKQNwiR8Tef/lVFRceQp65k4VxQNUtJHvFuIIa3gHmuuYSEpOWhyXcUAAylGlgAN4QK9alXFBZNa2gY/R8+y1rHezdh7vFqNMQQ0dJEmMSdVQeDnsYq4WuANOUNLcoD4khBuL+WLTOlpOxhsp9f8Zw1iAkxa2nIlhd8ulM+z3qCTgWjXT3mWIisKLrjIViVe91S+r7oFcnCv5AJYcg6FIQD9gQgZrbfl6jtkE9q0OsfqSlhokfda5bcKD4XWiXuBjygAg9qfGQcSipfXsf+5g4UqYDNaK0n9X20hgVHPQ7nVEYo9HwLJ5spcH9mmWCjBXGFwgq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39830400003)(136003)(396003)(451199015)(52536014)(5660300002)(4744005)(76116006)(7416002)(316002)(41300700001)(54906003)(6916009)(2906002)(66556008)(66446008)(4326008)(66476007)(8676002)(64756008)(66946007)(8936002)(71200400001)(478600001)(53546011)(6506007)(26005)(33656002)(186003)(9686003)(83380400001)(7696005)(966005)(55016003)(86362001)(122000001)(38100700002)(38070700005)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V2LJcRbkxuESCOlwGE6P8fm6ijioCT31TTQ6qjtR7wSXgo/ZBjYFi6qwbAl/?=
 =?us-ascii?Q?LQElNRJVtiRB4eRRtdRTY/dQuMIdmhChjnTlNchELUaZwhEYLXUOgCYBGcZh?=
 =?us-ascii?Q?luZj29aAX9l9y0KlMlOs2UZxYLRSjBzeP81zlu5y44iaVcZHYQhmN2JdgBB2?=
 =?us-ascii?Q?sHzdynE7CLK2rDCIApJH9m9d2BDPeke3EY0+JcuyBdx5gcED1A7zcl9HI1zP?=
 =?us-ascii?Q?ZckbyrBSH8jc51QaL/ggDi4SLphX2WVXiHheLzPxdLNCE/uN8l4WS/ooTDEZ?=
 =?us-ascii?Q?/uo5m5j1ZGX7EL1VsiG557YgFcnjKK9CAUbtj1lzdWYhsXHkVuCFZIxzloNQ?=
 =?us-ascii?Q?EeogY1pQkpRBkw+M778YLvpG3W6yjfdtooGVJj1rDSOfMwaO1htxR/wQRAit?=
 =?us-ascii?Q?/+yS4htiVCTTFpz5koL1hzQf9OHh+1/ktkzEykBFGvv02jndemAVVKoYcRoS?=
 =?us-ascii?Q?Tb/O+OzuFVkNrfvRtnjkpDmJNX4ceES5M09oKTPmEGwDYlRLA8au+gGlUjZe?=
 =?us-ascii?Q?bkWBROVlcFLqjsyKYFhDXs5vamhW74jnsh0z49Fz2A+JSnuLy8ZTfAZ7YAju?=
 =?us-ascii?Q?I1bxX0RKdX5IbGSON6+0CMqH2c9zk1HzQm8KDqeCHa1AmhiCRd0t+u2OM9+W?=
 =?us-ascii?Q?XVFwe0NoBdSfRK5LC9D9I2/QhAg52SdM/81sA6Fd3iBFOGfRW3Dpg9sS0fsy?=
 =?us-ascii?Q?pqgDCe2O71SGsHvxl5+w3omVpn8uT8sIXQXqF5ISAIynnClEOF/6tfcFKvD7?=
 =?us-ascii?Q?A08KKt8XGfzI+ojC1rwdCyrsj6+qgMUrwqwohrst3/Dm8O2OQiZFxOCqw58r?=
 =?us-ascii?Q?b0XQpEEidb+G2JXV1rcwC9lBMMh1Npqsyqf7m4fz6gh1EelID1op0eOiP6qf?=
 =?us-ascii?Q?YsT9CuYsHLZwGT+MOFzkjubKlL0L8VN1nYt45v0A1kU/toOeGuyYRZxU0Xqq?=
 =?us-ascii?Q?Sckyt4hEUGf61pir5+Ae9xJ1fN1kGIohRVGmn/xdfdMoMnJQYmttCkGJUAlb?=
 =?us-ascii?Q?lUSikjkJGycZXSUPD9FA794CGFH4nyUIhFkb5/wL2cGnHZfSOlql8dhFpDvP?=
 =?us-ascii?Q?ykdz2hbfOjCFHHYwt4r3qz36rjd+p/Q7mUuYKlmy/gFrCeS0boBt7k0rYjdo?=
 =?us-ascii?Q?g6ihSWj2WC9/2CcsO0jVdMpWW2OYFez51O7IYowk8Ljw6783tEXp3yFVqJUg?=
 =?us-ascii?Q?g/vm9Z1Tam0LoU+OkMprBzmzfjlD4q069evBVnzUkbQZlgxPc2gyNe54PSgc?=
 =?us-ascii?Q?Zq1Euyd9SbtqM8AreX4DTYdv7UqbrVe50aEJdvsl9wskInWNSIJX6XV84b3b?=
 =?us-ascii?Q?5wHcNyaRa29rObuYoeX6brpQfCN8kwEUOiHqujNdVAGVnDCzUcFSAsbaQRCL?=
 =?us-ascii?Q?nyy5P4CNFufNowcEfbymOw9D+ujT1ZZKCpFgWyg3iGCCM7iumWzN0amW60hd?=
 =?us-ascii?Q?z7WV6qU471CdLof+9hjIEFdCQf3DzlgnOrQQjxZX8YFrWJuOxleqYmvvZ7Q5?=
 =?us-ascii?Q?6sNPnusMORe2glYDx31eTqk4i5c9moCaVTV6mRqd/IdvJaNOtw9XbSQu2sEg?=
 =?us-ascii?Q?N/wLvozqCIGFCAgh0iiwrIBdohGBYMhoPk5u78qw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9276da-77c0-4956-6b9b-08daed3be2a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 03:37:48.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/1snHlQmiE/eDcnWAyb72/2kmd9FjWvjShmYNCKv/51SsbM/18Aa3rogIAlPmFapM6Ml6STU5LyeCpbVKV+ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5782
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, December 30, 2022 4:29 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andre=
w
> Jeffery <andrew@aj.id.au>; David S . Miller <davem@davemloft.net>;
> ChiaWei Wang <chiawei_wang@aspeedtech.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org;
> linux-crypto@vger.kernel.org; Christoph Hellwig <hch@infradead.org>
> Subject: Re: [PATCH v4 1/4] crypto: aspeed: Add ACRY RSA driver
>=20
> On Wed, Dec 14, 2022 at 03:01:11PM +0800, Neal Liu wrote:
> >
> > +static u8 *aspeed_rsa_key_copy(u8 *src, size_t len) {
> > +	return kmemdup(src, len, GFP_DMA | GFP_KERNEL);
>=20
> Please explain why you are using GFP_DMA.

Looks like it's unnecessary. I'll remove it.
Thanks.

> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
