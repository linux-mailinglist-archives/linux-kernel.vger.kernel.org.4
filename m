Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF65A666FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjALKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjALKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:43:01 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2082.outbound.protection.outlook.com [40.107.14.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC6E51327;
        Thu, 12 Jan 2023 02:38:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3zdnMlkjnqLXg3daS9eV/LXLpt4Oz7zXWXaVmqXpR38wWLtf/fm0a+uWjDsjJlfOov2ShJ1yeGkN6ndk13p/bQ7/qX9YRhkpNfcWThovanKL8YAcoK+4U2TtI3l5RsurxqVPb2DhZqOtbnfV3TjQLo3o1oydjDcRKyYDSY741I2LFBUV43ncjKbKEo7q9mUtvrdkLdJsKc/Ixvsaqkob5m/b5wOC1HVaea73tLJaJ7J4Whx+Z2suTG90MtnHRcpF2hgMe/W+Md3omMReahvcvZiiT8B0eyv8+m1G1wYgSRkm/7S5mLROv5RPVqBh6usaCo7dViVvtbVdOO8XAXghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lwgvv+q2oxR9b9x4+zYL8B/WHAX3bPUFmPJ8T2jT3fE=;
 b=LloDQhj+dDJ+4xninG7LQXGeZJ48adeNasKYD4vHIc5siEtTvAYvS/0nTFLELYEyGTrN5QD+V4FZTtNJKJHqWfUA6xLrzFU8bDMn0XFV4/Lig0kXC91AoebTuWCVflT0kB2L+d/xa/W7gkfVC3DyBiz449DWzTBPHj7TbaajiXBZDUPf2UnQ4IEttpTrAXPkHD1tCjGZAfX/Bgu+rzPgS1a9X+woy4PZPx+lKNJasaG6h702D1Wt7PwMPgRDFvdTmJy7m0df87rVslU8UxOKgsnCZmttaJNzD7KHaR0o7bT7VMhtYeJA01r/smnL50K5zG6C+z+EJ1qIZhMk2J1E3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bosch-sensortec.com; dmarc=pass action=none
 header.from=bosch-sensortec.com; dkim=pass header.d=bosch-sensortec.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bosch-sensortec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lwgvv+q2oxR9b9x4+zYL8B/WHAX3bPUFmPJ8T2jT3fE=;
 b=MlomOiwxZdpUniCEuJWyRKbs/IQZEshNccqEUABhhfIg120Yq8Dck4AIPbZ73pcQFJ4iy29/+W4slrxUDKgXS2ZYOvRwwEHUQUhq/95yLEeAMdC4sl+KpeozyzNxm4zn86KcKV3tH1EJqZ3q1i6YGnLtc+Q1jJYjSoR9koPLE20=
Received: from DU0PR10MB6608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::14)
 by AM0PR10MB3602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:38:20 +0000
Received: from DU0PR10MB6608.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5e32:5c80:72f9:3605]) by DU0PR10MB6608.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5e32:5c80:72f9:3605%8]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 10:38:20 +0000
From:   "Contact Bosch-Sensortec (BST/SA)" 
        <Bosch-Sensortec.Contact@bosch-sensortec.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "ak@it-klinger.de" <ak@it-klinger.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nikita.yoush@cogentembedded.com" <nikita.yoush@cogentembedded.com>,
        "paul@crapouillou.net" <paul@crapouillou.net>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new sensor
 BMP580
Thread-Topic: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new sensor
 BMP580
Thread-Index: AQHZI1wa513kGEg2hUaJjuLn/fnwTq6anOog
Date:   Thu, 12 Jan 2023 10:38:20 +0000
Message-ID: <DU0PR10MB6608FA4549764C670DB9E214FBFD9@DU0PR10MB6608.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
        <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
        <d0e98b2d-1c00-b7cc-d0b3-4477e27cf822@wanadoo.fr>
        <8c4826ea5698e4e1b2910f5b01e66a41970a8053.camel@gmail.com>
        <20221230182253.45fcfdf4@jic23-huawei>
        <0f86cf66a14b4d5900ddee68cd7b49807128b7e9.camel@gmail.com>
 <20230108123501.3f88c11c@jic23-huawei>
In-Reply-To: <20230108123501.3f88c11c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bosch-sensortec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6608:EE_|AM0PR10MB3602:EE_
x-ms-office365-filtering-correlation-id: 75f2caf9-aab6-4119-9788-08daf4891f8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxp/k/jeVBdb+TSYga4kbLifUf2rU4xoe5xYsRpgjEBAMlgfNLzwWJALMF5NhBwEAp+IlcbfMmOCrM4iKLLA94d5pyjgMT57pxbP4tww8TtK2Zn39B/SYYo1n1UfDnna/gaUGD0dmSIqm879gejSjyX16NJV3JUP+6nbmhJdGjHHqQXAP1Komq+dpD7euuQWbiPE19e5VKeZXZsdG88c87gVUIRTgZ+PQJ2evbtnJQRbA/xa0Z6Yg8J9DYx4+LRCdcnOdW+Yd8c0ctEEaRbuZp/3UGS/1IHlnmMdbbSKsde24vAmmCFU+pxE5dofBvNW1DLBad4I79i2OtkBCEy9I3g9ZCX+SmRBu3ZUtqXrTr7yb+wq44YoPjDxp65fUU2Uc1G02F4zWf3qQfwM2/mEK/gFQ1C+ICcNkc7p8IMtYiDXGjRGSOGmykR7AgtIMQ8A6FnKXYd6A2mhwWC9xizBiSvPEajixaH+otTp662tmzVYKEjaojd3rBzh17DBjw5dlyYbStrRnoJ5XooB3t3/DrbrXoKA+NUvAi8nOR/55LcQ8i/SmvhTw6JGXAGb4xxaFFhyauBy0a4DNFTHQ+au3mIBW9nIZO45Jrr3qw81jnXefNSR8+j9r+1p9l1cfzXv2Ezdi0zfQxpHNPGPUjm4Yb2dCiW2vc2y2aBqgEyrUukaWIOYuR5wXXHCxlrid3OShlzajpBj0RtSK0PYNN9gzKjNZ2M9yQOKUYeDDL2zsKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6608.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(4001150100001)(2906002)(66574015)(83380400001)(33656002)(478600001)(9686003)(66446008)(66476007)(64756008)(7416002)(55016003)(66556008)(5660300002)(66946007)(52536014)(8936002)(53546011)(122000001)(26005)(186003)(6506007)(7696005)(82960400001)(41300700001)(38100700002)(110136005)(8676002)(54906003)(76116006)(86362001)(15974865002)(38070700005)(966005)(316002)(71200400001)(4326008)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wwt/b7wO4qNasjEPYDxtd0aJBuXa7rhFgZ9iP0zcScGjJ76PL20VoxE8iz?=
 =?iso-8859-1?Q?imEOkicdu4IMORPqxnezOlLAQtt/k6WhPBOydtE2asVtxjOfVgN2NlDt0w?=
 =?iso-8859-1?Q?MV9jezPi5G1x6t/p0fNqCVIwQvV+ga0wFE82AfVu5zJTPvE5We6lNy8mUK?=
 =?iso-8859-1?Q?SU60RKTxdT3/raZ/4H+ic9sd1tqn6rrkCmgRi7K2jKnWsBsZ8qKTvvTDhG?=
 =?iso-8859-1?Q?XlsnZ7+HvD5q43R2FXwQDNfEA+AljDRtmxVC+whXvLvGjrv15ch0LKpckP?=
 =?iso-8859-1?Q?QPSPLp3pgqhPquemmm5hhmrAvOHN3rsQi4FG/nmwu++/Si0Z2VFgaXsedr?=
 =?iso-8859-1?Q?A7wht0uZu+ucmbgFCeIysvs/wIDQfwE5nSIkc90uuCRlPhp1o1VW3dzeYZ?=
 =?iso-8859-1?Q?dRlIXh8GTSpGgE+uXrvYZuvd4iQzi/nfo8xmvxwhbR+jvbwM4RQ0vxpymz?=
 =?iso-8859-1?Q?DLOTGRmu50k00AcUU1W3N3g1T1u0e3G8KH/I6JVDQyZ9LNwJYMcwFqQlRO?=
 =?iso-8859-1?Q?Icfv89q/HiNP3t8tsT/DXHBu1UiBlWzAHEc6Xhn7e8HZDkV5078wsS8uAT?=
 =?iso-8859-1?Q?+c22oG+hihVZtlyk3BljrgWgUN8cjv7SdPUn8XxqTtBgQ+4nHrroorP/aN?=
 =?iso-8859-1?Q?5P7GZvZCY+nZCJ+t8D+p1CiH3PRuMJPEtmzQoBIEo+39taw16ZXGYK05bT?=
 =?iso-8859-1?Q?4xZMjMcta/8gxWcdQZ0i4wrXbjkWf98eAxAzgaTHx38D4++PCTeyHD+7NG?=
 =?iso-8859-1?Q?s0MrtJtoS7FLJA2gySxhqGAc1OMhg2zAsoESL0jE55myi+SZTRnhbRkRM8?=
 =?iso-8859-1?Q?Gv2LNz429jgHr3hR+UHWJCF8D9fgDb87tVRY8xn+1eKtSiX6k8xYrDTSdX?=
 =?iso-8859-1?Q?MG4aD1xQBFAy9gNu0xPeLB+D2TqsombfpiOoo4YOShgWr7AqIIaEmHryCz?=
 =?iso-8859-1?Q?orRDlUWOZAp7+JxMBdZBzgfNqH9ORV7Enu4FTEtMRQM8Ck5SsS3BpQRd61?=
 =?iso-8859-1?Q?vJGwuSl0QsBWT4FOb5+YdJiFl14JDIo0eJek96rAOP/k7frewIwkeBav0f?=
 =?iso-8859-1?Q?gayk5md723qBXJKRg990rMXOXtUv4604SX3YbTW+vdDPvHprT0gYV2URjl?=
 =?iso-8859-1?Q?ZTCCVrWrxeqn/QClxfHQdf3s5AUZvgas0Q/HyL5F8vDtKxv2EXD1zGw5BK?=
 =?iso-8859-1?Q?qKsklqrREX73z/lY3e0ZH6AicMgi1uZugKkpKEipvCGnd3liliUYNJcnfD?=
 =?iso-8859-1?Q?6bUz6nCfGFqlp5kklnXSyZtzwSUCY+fUYqCAL7c3vBSv4Ewyl4yxhjlj+M?=
 =?iso-8859-1?Q?+w2C5bqTHNeleWLFIJOzbU6mUHnBLvvjXIizFkvy8W37OyePZigMt+x+Ut?=
 =?iso-8859-1?Q?AqDtIK6tei1y/8iLjkOD2V9lL8Ds06rrxs3rKV6363q4TYuCDkkfmTKivD?=
 =?iso-8859-1?Q?4LbQVFkNIqcK43emP/AJY6IgVNPObt/mz04cWPxnX/jzkgD1dCM1TzC1AD?=
 =?iso-8859-1?Q?5Q7rkh3ubUhkMmsXklKWUbqR95VSgHld3h6/KFkdc7RSWIyPyfZUK/E1PN?=
 =?iso-8859-1?Q?nL16EJBjozsUSGT3lyWbyL9keA7Id18Rd6MgQp/SPF7IE3IQLHvvOLxq+C?=
 =?iso-8859-1?Q?oNa46WF9dJS5xJ5bxR60tiKApKvd+LXHiD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bosch-sensortec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6608.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f2caf9-aab6-4119-9788-08daf4891f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 10:38:20.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knBgsh+fXbl5NZkou51pQJ16E+9sh2aQHsLWrdh5RKlA45dyZ0bsDYCzNuFSAIDZuHfu4u2woI88kMXGDa0JQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3602
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTTP_ESCAPED_HOST,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jonathan and Angel,

Aligned with our product management, we can confirm that the CHIP-IDs are i=
dentiacal, this is correct.


Best regards,

Bosch Sensortec Sales Support

Bosch Sensortec GmbH | Gerhard-Kindler-Stra=DFe 9 | 72770 Reutlingen | GERM=
ANY | www.bosch-sensortec.com=20


Sitz: Kusterdingen, Registergericht: Stuttgart HRB 382674,
Ust.IdNr. DE 183276693 - Steuer-Nr. 99012/08040
Gesch=E4ftsf=FChrung: Stefan Finkbeiner, Jens-Knut Fabrowsky



-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Sonntag, 8. Januar 2023 13:35
To: Angel Iglesias <ang.iglesiasg@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; ak@it-klinger.de; a=
ndriy.shevchenko@linux.intel.com; devicetree@vger.kernel.org; krzysztof.koz=
lowski+dt@linaro.org; lars@metafoo.de; linux-iio@vger.kernel.org; linux-ker=
nel@vger.kernel.org; nikita.yoush@cogentembedded.com; paul@crapouillou.net;=
 rafael.j.wysocki@intel.com; robh+dt@kernel.org; ulf.hansson@linaro.org; Co=
ntact Bosch-Sensortec (BST/SA) <contact@bosch-sensortec.com>
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new sens=
or BMP580

On Sun, 01 Jan 2023 12:16:28 +0100
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> On Fri, 2022-12-30 at 18:22 +0000, Jonathan Cameron wrote:
> > On Thu, 29 Dec 2022 19:23:16 +0100
> > Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> >  =20
> > > On Thu, 2022-12-29 at 18:35 +0100, Christophe JAILLET wrote: =20
> > > > Le 26/12/2022 =E0 15:29, Angel Iglesias a =E9crit=A0:=A0  =20
> > > > > Adds compatibility with the new sensor generation, the BMP580.
> > > > >=20
> > > > > The measurement and initialization codepaths are adapted from=20
> > > > > the device datasheet and the repository from manufacturer at=20
> > > > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fgithub.com%2Fboschsensortec%2FBMP5-Sensor-API&data=3D05%7C01%7Ccontact%4=
0bosch-sensortec.com%7C5df3784517c940394e8308daf172e38e%7C0ae51e1907c84e4bb=
b6d648ee58410f4%7C0%7C0%7C638087774478147184%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&sdata=3DYarsZiHIZ%2FBkNNqK%2FunjfVWGgIwOtvf%2BPXs8ipHQdRQ%3D&reserved=3D0=
.
> > > > >=20
> > > > > Signed-off-by: Angel Iglesias
> > > > > <ang.iglesiasg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > =A0  =20
> > > >=20
> > > > [...]
> > > > =A0  =20
> > > > > diff --git a/drivers/iio/pressure/bmp280.h=20
> > > > > b/drivers/iio/pressure/bmp280.h index=20
> > > > > efc31bc84708..27d2abc17d01 100644
> > > > > --- a/drivers/iio/pressure/bmp280.h
> > > > > +++ b/drivers/iio/pressure/bmp280.h=A0  =20
> > > >=20
> > > > [...]
> > > > =A0  =20
> > > > > +#define BMP580_CHIP_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A00x50
> > > > > =A0 #define BMP380_CHIP_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x50=A0  =20
> > > >=20
> > > > Hi,
> > > >=20
> > > > this is maybe correct (I've not been able to find the datasheet to =
check=20
> > > > myself), but it looks odd to have the same ID for 2 different chips=
.=A0  =20
> > >=20
> > > Yes, I also couldn't find a datasheet for the BMP580 or a devkit anyw=
here.
> > > I'm
> > > developing this using the BMP581, which seems to be a variant=20
> > > almost identical.
> > > Something similar happened with the BMP38x; you could find the=20
> > > BMP384 and the BMP388, but the BMP380 was unavailable everywhere,=20
> > > datasheet included. My guess is this is a similar situation. In=20
> > > any case, the datasheet of the BMP581 is available here:
> > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > www.bosch-sensortec.com%2Fmedia%2Fboschsensortec%2Fdownloads%2Fdat
> > > asheets%2Fbst-bmp581-ds004.pdf&data=3D05%7C01%7Ccontact%40bosch-sens
> > > ortec.com%7C5df3784517c940394e8308daf172e38e%7C0ae51e1907c84e4bbb6
> > > d648ee58410f4%7C0%7C0%7C638087774478147184%7CUnknown%7CTWFpbGZsb3d
> > > 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> > > D%7C3000%7C%7C%7C&sdata=3DdNnnClouPfqXntLuTWGQovRw39ehaLeuzKuN%2FNWI
> > > 8y0%3D&reserved=3D0
> > >=20
> > > Regarding the chip id being the same between generations is weird,=20
> > > but at least the datasheet and the sensor I have uses 0x50 as the=20
> > > chip id. After you mentioned this, I checked back on the reference=20
> > > API repository from Bosch and it has both 0x50 and 0x51 as valid=20
> > > IDs:
> > > *
> > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > github.com%2Fboschsensortec%2FBMP5-Sensor-API%2Fblob%2Fmaster%2Fbm
> > > p5_defs.h%23L198&data=3D05%7C01%7Ccontact%40bosch-sensortec.com%7C5d
> > > f3784517c940394e8308daf172e38e%7C0ae51e1907c84e4bbb6d648ee58410f4%
> > > 7C0%7C0%7C638087774478147184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL
> > > jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> > > %7C&sdata=3DtZgYdnxpvKIndjtJaaFfcAJbBa4%2FcIgKhb4XH6sAO9A%3D&reserve
> > > d=3D0
> > > *=20
> > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > github.com%2Fboschsensortec%2FBMP5-Sensor-API%2Fblob%2Fmaster%2Fbm
> > > p5.c%23L1444&data=3D05%7C01%7Ccontact%40bosch-sensortec.com%7C5df378
> > > 4517c940394e8308daf172e38e%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%
> > > 7C0%7C638087774478147184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > > DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&
> > > sdata=3DxU9Yh2zXjol0vyF9iltRmkBK3CUlGGdcjrp3AzwvTNU%3D&reserved=3D0
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> > thub.com%2Fboschsensortec%2FBMP3-Sensor-API%2Fblob%2Fmaster%2Fbmp3_d
> > efs.h&data=3D05%7C01%7Ccontact%40bosch-sensortec.com%7C5df3784517c9403
> > 94e8308daf172e38e%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C63808
> > 7774478147184%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2
> > luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DfaQZ4qjLF
> > jfYN2US64FbZJo%2B5lOuFw52mIY3XqoXDKU%3D&reserved=3D0
> > I was curious on whether we had a wrong value for bmp380, but nope... S=
ame ID.
> >=20
> > Huh. As per earlier comment - who wants to moan at Bosch as this is=20
> > crazy situation?
> >=20
> > Jonathan
>=20
> Well I'm doing this in my free time beacuse I wanted to setup a meteo=20
> station and got annoyed needing to patch-up userspace code for reading=20
> pressure and temperature sensors on a very underpowered ARM device=20
> when there is a kernel subsystem for this kind of things. The rest is his=
tory on the mailing list.
> I don't think I have any leverage to have Bosch listening to my=20
> complaints

Sadly I don't have a good contact in Bosch. So all we can do is +CC the con=
tact address.

If anyone else has a good channel to point out this silliness please do!

Jonathan

>=20
> Angel
>=20
> >  =20
> > >=20
> > > Angel
> > >  =20
> > > > CJ
> > > > =A0  =20
> > > > > =A0 #define BMP180_CHIP_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x55
> > > > > =A0 #define BMP280_CHIP_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x58=A0  =20
> > > > =A0  =20
> > >  =20
> >  =20
>=20

