Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18506873D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjBBD3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBBD3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:29:45 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF735BF;
        Wed,  1 Feb 2023 19:29:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPnuSuIictaGZwVFtKTL4i62c0j+xjnVl8GA+aIWG9AOBu9TcFFjXSOW2j5VJ7tJPjlItTfuFRCDkNr1zgzOhmdJyUlQI+Qf2SeOLF7ZMW1lUu7Puu63g9rp+As6T9C74nyXKsBM+k1C7WP3qubckxep0J543HGvEQu+HnK9AYichuzb3H/YWSQM9a+1SpRfyt72bCF/oHzUhNonxMG3c8gLgT/MAQu4OZBckPailAMMiabGR2s1ZXetOaUQWDEldcwarYUk6sPw5hJ91fa4LGHYDp9KTmEtR17sycod84FOENWkc2X4dGoYtfS6ce+QZeIhyCvf1CORZ6sbA1iZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMOAc9t/qgDcMP2sjIGA8jrFyMhy/3fvM7t3KVM66LA=;
 b=bF6sYktdyattVP8VhCZXdQW68zOwc+fNwMP5HKj9y3BuIoHaBDJ0RzUV86Uaj0h/YyfuINxbiMz5NtuB4YUIM+a6F85Me3iCgAIkYNr2s/AaARLJZqenUm+R8wPGFTxvh4dhMagdX9DQw1sSSVRkaUrOtJXoAy7YKPqHOqeMoOf7dFUn1/wjcfagvG1OaoCmHYgeTVk3LyM/vRh3zlVgXJ5NzM4iZA3NZLoMXf6Cx2lKrCbGBos8cfIRbbxwcPmunGAEMGa0fEXbL3dxDPynkyZa9zn2urWI2qxl5TMilxC8i+XmxGZ8JGiHaldQSrC/28GKlHZyrSZO8i/DO5PT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMOAc9t/qgDcMP2sjIGA8jrFyMhy/3fvM7t3KVM66LA=;
 b=w+ua8X8L6R1XnF//8MhqSM1Jm0ppzIkGiyH5qrHbGk4WcAtgsHrcor599SYjDcZMYBLgF/QeKAZZ8pEipd1u+Fgmx8n/04XamMtMkaC4+MqUuq60KXRjZXRsQdZsl9wjZZxeCE8g9bUrTQvL5OvIr0x5iw1LMTz1S0KLP6KIqGNq2AC5+fgAnaIo6L1SKSUBHzW8aB83SXt1/UEFwOLvUERhKWePnslLi8FxGwFSqwKvfcjqENrPMKfecffIsyrmNTH3QPg08ByvVpf1IMFxVH4+nO8sWL4blILoZlDpKazeWEM/lpwy6KldUYMPLny3IdMYqpK20kcza2fE6c4Szg==
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com (2603:1096:404:97::16)
 by SEZPR06MB6158.apcprd06.prod.outlook.com (2603:1096:101:ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Thu, 2 Feb
 2023 03:29:41 +0000
Received: from TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::b113:70f9:7dc9:543f]) by TY2PR06MB3213.apcprd06.prod.outlook.com
 ([fe80::b113:70f9:7dc9:543f%7]) with mapi id 15.20.6064.022; Thu, 2 Feb 2023
 03:29:40 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH-next] crypto: aspeed: fix type warnings
Thread-Topic: [PATCH-next] crypto: aspeed: fix type warnings
Thread-Index: AQHZNrHmMT+Cp3JQVkSaFLeXTAj48q66+kKAgAAC+UCAAAFlgIAAAKqg
Date:   Thu, 2 Feb 2023 03:29:40 +0000
Message-ID: <TY2PR06MB3213C9EDE5B9A07F63B5295880D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <20230202025600.2598548-1-neal_liu@aspeedtech.com>
 <Y9spg/66x/wQ3x+g@gondor.apana.org.au>
 <TY2PR06MB321395387369059BC9F9722E80D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
 <Y9stLeguRuQVpbiD@gondor.apana.org.au>
In-Reply-To: <Y9stLeguRuQVpbiD@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3213:EE_|SEZPR06MB6158:EE_
x-ms-office365-filtering-correlation-id: 35e7c305-3260-47f1-35e1-08db04cdb82f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZY1fN1p3GwUIUeMAuaLyN/85eqc4nIa8j0I/V+ekpv084iA54/ITrTJGRfV9dmM26QTxZbTBXp/spfR9R3h/ZCzmfexUdxG6MiKWlx9r39dtncD5rVYVrUs4qxRHfolydoJ0fAHsqKfAxReLQ1qtjgTCq5z44eS6NgTbGnjF0FLhP2vAfoS1Kp8IDqV7a8J5E5rgxADtLTJg9Eb8s7CztVN9bTYhCLRgzXsldzpiXAT+biLSDsYHRpnKpGlN2xfZMyikH/DF3ofvsTzusrvJpp039+OLs2dXo/ODzGFXjOyD7b0Di5tsFhELpAQ/JOhV3AoBzRknD/LLfyQO1qWapgDGq4OSU2QDm7+epIGdkX2fwSe6sr4lLjEBn9PTwU0DEvDAA1jRClL1yC8VLTMFh1JxNwPxtsJbONaQVsjUqa/rGoJPdVnMqDimZgqvbU7AkAmd2jn5uS0tNeYbq8fmMhjGq4XVLU4n8P5duB9w3bFmp8pKAxRVX22bOMnXV97XEak4Hjyv5LzokFOqeMmxrtsk53GXIh4tV/7WjWbMshhi7v8z9uBfsspL44gcKQ8CLuhHAsxUsiAAdKwaJBuAhcRIlwUiaIDv+MzpNtXN74WXsPLZJF8p0iTa/m9k0yWv43VrinwwSYU7Y9xb+sEPrEom1RhS9rPjI51wajU6JFQGzxgg2o93xSCyLT+ygiypbYZNM2N8QDDM9yRyZa2Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3213.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(366004)(39850400004)(396003)(451199018)(33656002)(41300700001)(478600001)(7696005)(54906003)(2906002)(122000001)(86362001)(38100700002)(66476007)(38070700005)(71200400001)(6506007)(186003)(4326008)(5660300002)(316002)(66446008)(55016003)(26005)(6916009)(8676002)(8936002)(76116006)(64756008)(66946007)(9686003)(66556008)(83380400001)(4744005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cbFwFZ0ls0Jfj0dMlhcJbRPDfx4wuHM5qWWMPVi26stTtNXsK9XfiX7Lljhk?=
 =?us-ascii?Q?IhKJR3p+qzfYVUn0sWHv4iEQxmwRzi4PNmCzSpBE9BEmW8YitvAdiisdja5b?=
 =?us-ascii?Q?CkB0JEKdgwWBQmZWu2YZhbYKJLCurSDwYUim/+2qkFmIg8EI8BbS/KKI9649?=
 =?us-ascii?Q?Zivf4EDfEex/Wdxg5yB8Ug/KEZ78vdsHAS9gbudKCGXFA+88+EmmiotGDd5t?=
 =?us-ascii?Q?Abs8OZPpBx1qEut8ygzKjvnbs6B2A1/SYB60zn9IedcQ6eA1i78xRl7tPH4p?=
 =?us-ascii?Q?y9pGue0ThE0vUZbqL2xo9T7Z/f0E+NeCB5wW2mDu/GB9JTUx4l0VwrJnjh1W?=
 =?us-ascii?Q?e3NpysRK3cNWQmxC31SMzc+fIV6vvYSV3g8SE3JE6pHlkamkjaPs6fjaVJzd?=
 =?us-ascii?Q?qNsIpvT+8dBLNbwaMYU8QxHn0DyqDcMSx74YQHsOTanUZ2+JQzeJsMO7GCkZ?=
 =?us-ascii?Q?X4ao338QKRCt5JllzFP61TragOQibrOh9fLPdN7kteaKDkpR1JSEoTzxNobs?=
 =?us-ascii?Q?CDU9G26MSpLcei9v7rCfaYc0JRsZsXjLwS/HHHUVt0tnJHV1DRwAaoroxCzP?=
 =?us-ascii?Q?cKOAJGwrcDQvP/KlUM2GpPd/B0UkLvnN7H8kbWfXV3gpxlUokkpA+eBYLqFH?=
 =?us-ascii?Q?0859y1DQceOTx5j8USCChRldBtARvMOiA3n/FxRejHow7/e6fJ5Hr3+i4l5X?=
 =?us-ascii?Q?2EEw++wiH+mdmIjpDbJcmatWO7QQkVemonvghnLstgPVYzzeYN0d7581qefq?=
 =?us-ascii?Q?X2Edu7DfFmrEZJZ8LXanq/Tb3+9lpegWANVZCsb8u+GrMwB8FXs0AJZYMq9B?=
 =?us-ascii?Q?AVXI/PqPtiYzRiD4fJwlRAVsRHEW6ZI80TEN26OnAFJ5RUaS/ainRLIRT3zf?=
 =?us-ascii?Q?MsAOn6UeAFcsliGOLQBvJoswOJYqTjpN7PwBjqdKO4YCuiK3TqzsR7mizysc?=
 =?us-ascii?Q?GiVan82l7Qkz+13SvO1qJao2UfWyhbw4Qlm4rMf15vXlKO2KfsUzcJ9jWrXJ?=
 =?us-ascii?Q?qtjvo+q9Kh7hn0hhdQ7tryCNuXL/JTfa8djn/4Hw0OlQPx6jdMPXLqncMPvO?=
 =?us-ascii?Q?pXVA+iTgQFJT/0ytubCIHyAW6hajCnJvag2wpHYMBvAdpNkStTDzgSN/a8WM?=
 =?us-ascii?Q?AExAC6Xzp2eJKcaPZO0xFk0ABYUYOfoVEsSgF8Z45bcfbTrAMGZMVgHprxHC?=
 =?us-ascii?Q?r53Zfp2C8WpKi3IdNzLG+bQYoEm+WV3NyXHJBJW0kV2M1//NTEOvBoJLmW/B?=
 =?us-ascii?Q?+QXsRdCQ7tvQ9IphtlmNPZdqFOFATczxCvPOiQ28WOugHa/URKp7Zbs1dlsF?=
 =?us-ascii?Q?AMjUjCVSxsk1dkK0whcIWbAI8GjmlGwh9v+SUFw+v907eJnpSLwfdX1rRNyA?=
 =?us-ascii?Q?rFHGNGALikuSeDXqm7vhuNfygcvQYDSE5BZomNDE5ZqrqGDJ31OS0MJ06q5H?=
 =?us-ascii?Q?aXfkysDAUA9E2fI9Q5JATR20Lh79JXtQN88Ebmq4+6qDuCogU6+0+ZQGZxwV?=
 =?us-ascii?Q?tg9QnRP2ppLAVE2kiTryYXMVd9aRciJExHXQv4DuuH5LuaBVZbBJbG4O1DtF?=
 =?us-ascii?Q?Q0Ahmk1ic6sheQylUo3gEWE+RKWtBJi+9pujSHvr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3213.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e7c305-3260-47f1-35e1-08db04cdb82f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 03:29:40.7809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bxGOH/rv9+1kDTK0JnReINahd+XAqGS9pOz0TeMa0mlf6tkbK45pOOpebwUgI7SSsTUMK4bU7LHhg1lZgetqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > I cannot tell which way is better. Do you prefer to keep the iomem mark=
er?
>=20
> The whole point of iomem is to prevent you from directly dereferencing th=
at
> memory.  So casting it away to remove the warning simply defeats its
> purpose.
>=20
> If you're worried about the overhead of readb perhaps you can look into
> readb_relaxed after considering the effects of the barriers.
>=20
Thanks for the information. I'll send next patch as you suggested.

-Neal
