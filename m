Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E2610DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJ1J5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiJ1J5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36856543D2;
        Fri, 28 Oct 2022 02:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iznz/8wD44Qx7EYna6QXvwZjsBoqa/BA9AyMNqgLufyAeJcC9TxO8wQZM1OrYV0PR9GoQpD00ol4rcBkPV7zml0I8GdJ7Szswof8UIGyLiyCltwPxrIvirov5Orew/DEkXj3PXKpuUzB4XEXUoCnJa11KiCHoW9xQUUFop8aHyCwbJcxY8gYpkj3uZsY+N1NekS8U64MtOFErPOQIVSSkNihY5MW9ywgtveGdU4HMAe9x5kDlLHUapMv4mrOQ5VKqAehcVscYvlrV4CUZejPcgBXr/O/zltWI+Ob0/c7dwc6wRdRQI1yWkvaaRovg1EtiKr6cgxWWTZK5CtK4WGeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+svCtqOdszc0oBgKaxRnHig4X90ziMVzxJfAGvHGB6I=;
 b=BX6cZMQoW/CpjcqkKO/VU5hqL/uXmUXFDYJtIcrm1yjj8toNAhlP4ZwhZfjhhaIuT8ebWB4SR2kQvroRdppeq/YfjEXGD+zaIxmFMAbB0ZwWX7Bu3wrtxeg3t9wWDI8jNZAAlt5Ev/4N5r9VXICiJqyzav/8rH5T8dVd+FLdX3eWf0nvzmhLGQcXpFHhy5YRJCmVkMtz9lUFiAr6ayFbg+fQjDVweuq9A52M7ZZ/R/d+aXwGtRH9EpVTNMZXIwHpmyWpi5ocCgcEUmY6hKWge0UDq5MChc0zeI1fSxWZW/H53iQ6ZhuTk3lfPhgo69sDq7saPtGn66b3G49Fp1HBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+svCtqOdszc0oBgKaxRnHig4X90ziMVzxJfAGvHGB6I=;
 b=jYt3PzxpFPFHT+F7UlccszHIkx4W9+1pE3BgHjvLRBOef0yBHTRyoczB60QAiZrYP/Ce/ZgI9SWKPfGeQ9sMbCqTMAKGOsoLRIQDDgW1k2aGmsGSbWbYGgbvRiTjYkshG6i1qXtTflHeBOylYWICSpVXtxxGMyAPTnQnLIJUuv6/EAgLjB8Z0MKs9cG3YnABYo0/nI3FMaqRfRWo6XcA0GIyCL3xJQshmHzGn+KHLEV1FhSQzeTVYYqyv94wfP7tGTJpWnoGCa6Vq/nel+aFDwXwIciG/227eTnOT+SABNeEZPB5nl7qRus4g79YoY3zkpult0W9DcZ10/3IU78rtg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY0PR06MB5056.apcprd06.prod.outlook.com (2603:1096:400:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 09:55:57 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::9ae1:4f06:2773:f8dc]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::9ae1:4f06:2773:f8dc%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 09:55:57 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Lei Yu <yulei.sh@bytedance.com>, Felipe Balbi <balbi@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH] usb: gadget: aspeed: fix buffer overflow
Thread-Topic: [PATCH] usb: gadget: aspeed: fix buffer overflow
Thread-Index: AQHY543fG2IRDKPpjUCvaIBADhhwbq4jYB2AgAASRYCAABWy4IAABOeAgAADxYA=
Date:   Fri, 28 Oct 2022 09:55:57 +0000
Message-ID: <HK0PR06MB32024F58191E17DC5ABC99F380329@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
 <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <CAGm54UExHOBw61DJNqxvW67OSr60fQ+Q247t63RzymiMOmHmFg@mail.gmail.com>
 <HK0PR06MB320203EF8E3AD14C34359B0580329@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <Y1ueEYJk2epT/g4J@kroah.com>
In-Reply-To: <Y1ueEYJk2epT/g4J@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR06MB3202:EE_|TY0PR06MB5056:EE_
x-ms-office365-filtering-correlation-id: e6e908fe-47a9-4bc2-1eb1-08dab8ca9c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnj5RZGd8RIeYc8TwFkFxTu4tdMVYPXZLdltqupK9dtHhb0Iz9m6gMZu2CQyI1uo+rzknmwfFDsvPhC00PMLrV8FYPnM9TIvuwwUKc8yqdNx343sEUVI3+K76ENpJAwZML/QohnoFVlyt3dLQF5BUw0G/WQT/WcrEJUlkzvM2jqA/+xBe3rkV02xsw6l1G1j9UFNWVo/Rr8X8cF5Wk3+6ccyA+XU7GtJYNAA7Xew1hwCxaY3bx01dCxotShyfRITvJxhaw2g3CdPXv6ty4GqeNxcmWbR4i7oBqek7tGUunqFic8NBZMqiGx54g0HctW0FfJMMXloakzf6wxfW8DqrCJVGbgqyQVozH/arcBccpx4whWxHrbmei/4YDIZ48QxVDEJzY/0Pzf9yewTZi9GGgoEbe77l3Z8Dl+Gg7+wejX8LGwuQE2MZ4C+/4EKMUBq4XCsCi5NxiHv8DvE1mJDgm9xxyh85MM/ILwBEeXIbqdRUJIgRXmexV4MIuqkxDR0cjELHO/SyoVYdw4RVR1oxtrPnnVeBiPvFvmlGP9t22D6IuNy7F2VvD2q25nkAZT7OsqQCv4RXmQBlOEbB9v7pNiQWnq6z+CQK25cCZtji+qDKi7kREHpN+xOaXQoifY2URnV6mFKfTeVcCwvs5hsv717I4tZd6KCrEuwC+gEwGAjFsN/mSY+/oeBQP5B/U1H0Serg0EjOmyZ5rBmqyb9lvB0eMjKucK8POqBOPzruIcXaZTDFXpzivaeR49Nk0z0+hDDMcNep+xs2FYO8+gj8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(39850400004)(396003)(451199015)(86362001)(55016003)(54906003)(38070700005)(107886003)(6916009)(71200400001)(316002)(478600001)(33656002)(66556008)(83380400001)(66946007)(2906002)(66446008)(52536014)(4326008)(66476007)(186003)(8676002)(8936002)(7696005)(6506007)(64756008)(76116006)(41300700001)(26005)(5660300002)(38100700002)(122000001)(9686003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IJJrYeakPo7AYSB9q4VzqPzNgL4e8CWJsJrqrVt0g7gMPpCTi6Dy6syr0szR?=
 =?us-ascii?Q?AGgFPpkDUJ01KoIKLd7xTpnjep88zUd0f2Bc94114NMlUemQqthqaLlSaT6h?=
 =?us-ascii?Q?4jjSN3g11BVH0BUG/tIs9K38RIg6l8FeKgFu+6Zq7s2oJlwVInJPa7rg4Wao?=
 =?us-ascii?Q?BiceMZCiS+BbfvdizUHvjxqb82E/iyP06RmCkY6SIPQJuv7nanJPO8m1/ijL?=
 =?us-ascii?Q?Rq+xzfl7LKOcpfDAPQ4akZWb/ltcLxFa2QzfICCTd2Aa5qbHVvy3mQ8PkpCN?=
 =?us-ascii?Q?8/VMVGoFykZRarvVfBl2+NBwGhzDYtKkaJ92ezOibElajnmIddR7872x43rd?=
 =?us-ascii?Q?DYkpKAlaKomSXwd06mXqSttQlj9m1kU6Y/lcp+2jaffP1RVOM6DMcJ6l9BHr?=
 =?us-ascii?Q?ji/tL+KdX5Xgp2zyH8FQuCXhx81NOXeI0bgjKS0cmCmuSYLaXSzLlGrQM5pE?=
 =?us-ascii?Q?vsUdFVG7TyVXi7YojPBKn5MnkqSi4yZ7n//Tpa3LTHQV6fjM3PeszqdO2muY?=
 =?us-ascii?Q?UMwuhDBXpuZZ9ej2Z7qPvXzyZPJwCunqroGx2mYJqcedi0ObZ1YntLQW9Fpp?=
 =?us-ascii?Q?6WVEVT/rubTz4651TlFpxgEGz7CQiHPmla1cKV4IqG2nWfQ+4AJHc1Bx04V7?=
 =?us-ascii?Q?Hsw89vmXeOZXiMIUHC1zg+FajTn0Ngtuhz1KubS6BlCItAW6HgvF0GbRNLkG?=
 =?us-ascii?Q?AcXhXxx/tUz6tzd05mY7oc2FONLaxnXSyxxEyPZhvFB0zTv7EvVKqSqLvHJa?=
 =?us-ascii?Q?vBhqio1kaBN56z5ix5tfCq8cEPR6DQUN2A26lQFJlYSxS9P4+537L6dSMBKf?=
 =?us-ascii?Q?aHNmM0s+458wJzicGIaaHJxmP0jJq0twOc2hg0FlllrtFWbFCAs/rpVbQZab?=
 =?us-ascii?Q?SGTrvnCJPwMXJmoIhfkZJ18dbFHxDo/kMwAXtabAYMPJY47dj/UN1qkiiTNL?=
 =?us-ascii?Q?+ASEoei09qNS3oR8OQ+TRXM4MoTciRVtDR90nN5cIzKUFrC8+QNlT8YHoZ4X?=
 =?us-ascii?Q?hUR2XLr4yYqzpxvQn1FP0W9YDWfHRX0oJw09FwO0aD9FSUQT/v6Sfh/YMxs5?=
 =?us-ascii?Q?GbnqHM9uiHWuhSwZRVIHkI6YO5Dq4sjXqPwZ4Xas1Te9H00ejV94t+GAWnoX?=
 =?us-ascii?Q?MmXokBLVReBb6T6IF9fzMC1/8IgSafTBLtpmHy+wJ+/6L3qIzyVkbuTdXfSs?=
 =?us-ascii?Q?CjZLaNCTZv0dHA9eCNpmd7gptJkWx+PIAU/vBbpx6+y2gYSThplnXKvygkMF?=
 =?us-ascii?Q?ngcqXvPlfA0LI/qUftTX7NCi/Ah3pJGARc212nOfqXTxqTnBqH0QK1W70CPY?=
 =?us-ascii?Q?iPST/u7uJX8q2ObYIAK7GCnHsikBo8x0/BTx/CTJhZUq7Xx/42i8UYDL7HnS?=
 =?us-ascii?Q?T+po0RYHDBsAwDX4hGqd2mNuJFZnfSomI7yFUZ/GMTs+39qyJFu8kLSmF5ZG?=
 =?us-ascii?Q?eUMMiisSb+vRTmaig0MIn/6UTkO1hjP/7yUBRVL4utlIVErMkZlQ1GwQ3Mv7?=
 =?us-ascii?Q?3Ys0Fr4VbBgaE88KGT+xQz4i0xRvy5urdfm3Kwlptxm8/sPfG09IRJnBl1FC?=
 =?us-ascii?Q?fHIyVNy4BhKTkA98tRFuEgFxDj57kcoUHfDErmyf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e908fe-47a9-4bc2-1eb1-08dab8ca9c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 09:55:57.0860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUq8Nz6l6jNRDgMiGCMjneIzOrwpzaXzQGbB4rUd7tEs7rqgyBdryRc+8AdFAqZoC/8JFRrp1a/rrbw/D4DKjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Thanks for your feedback.
> > > > I tried to reproduce it on my side, and it cannot be reproduce it.
> > > > Here are my test sequences:
> > > > 1. emulate one of the vhub port to usb ethernet through Linux
> > > > gadget
> > > > (ncm)
> > >
> > > We are using rndis instead of ncm.
> > >
> > > > 2. connect BMC vhub to Host
> > > > 3. BMC & Host can ping each other (both usb eth dev default mtu is
> > > > 1500) 4. Set BMC mtu to 1000 (Host OS cannot set usb eth dev mtu
> > > > to 2000, it's maxmtu is 1500)
> > >
> > > Not sure if it's related, but in my case (USB rndis, Debian 10 OS)
> > > it should be able to set MTU to 2000.
> >
> > Using rndis is able to set MTU to 2000, and the issue can be reproduced=
.
>=20
> Please NEVER use rndis anymore.  I need to go just delete that driver fro=
m
> the tree.
>=20
> It is insecure-by-design and will cause any system that runs it to be ins=
tantly
> compromised and it can not be fixed.  Never trust it.
>=20
> Even for data throughput tests, I wouldn't trust it as it does odd things=
 with
> packet sizes as you show here.

Thanks for the info, Greg.
If rndis will no longer be supported, how to use usb-ethernet on Windows OS=
?
For my understanding, ncm/ecm cannot work on Windows OS.
