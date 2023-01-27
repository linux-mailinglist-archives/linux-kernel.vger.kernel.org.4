Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7FF67E9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjA0PjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjA0PjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:39:19 -0500
X-Greylist: delayed 154 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Jan 2023 07:39:16 PST
Received: from mx0a-00209e01.pphosted.com (mx0a-00209e01.pphosted.com [148.163.148.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A9947438;
        Fri, 27 Jan 2023 07:39:16 -0800 (PST)
Received: from pps.filterd (m0131214.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9jSX3010814;
        Fri, 27 Jan 2023 06:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=2moKXPveB3U/AsaNrVqV9yZCXCpoAiH1zAPuuqyWI5w=;
 b=p6/Dl+xugjPR99gOa14xwJYOe4nUwr4O5+LRvlOYqjOMZWGpwNGnLhjMhuH59AUifcem
 CJ5RxAjnv8Q/9tBrYut4WUyaJC5NrJ5N05OvkPa8WboLuRv0f/nXAGr/Dsyje0ZYYZLR
 /btQe8dh+h8XnEsuyq66V1hELzrFLZbyjEtHYPezAbcmS5JxZn7Qeubspa1qUpCU9zCK
 muntmG5+10t9WnNoCuYDBwbsiRKe3IQNGreFAvo+GjLEYMLM+KnlOE3uRi1QzQtBskJ5
 MuzOuboGvQ1DKTtZVrCKuApfxJakZHdv+HhCo14zwjhRyVCUgpsvXFJqtQUoPbmmeBK4 Cw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0b-00209e01.pphosted.com (PPS) with ESMTPS id 3nbsmsr1vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 06:39:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS6m6PwbKjI8gDJk4YrAerigtCtoKaw7BMvoLOqhmrE3oPSPJ1lVJh3c1Yy05Qf849yIxtfYlnITP1W84nDmYvNlBnAcy5HHT1vlOGIlbW7RBbmp2qx4Wr5YjSyIEZvai7B9wf0vK6h07Y+hZczNrO/mQXRISp5MCwLBuesRJjyOK+ETO8MQfBOjA1DXqziItM0x/Mgz+AH3XP3wkEV7qBz0vuH7iaz3Pv5zpYfYFPXhRZIjZEHxqYAw8NUgAO2N8L6LtjiubLfHGHxa5imjTkmAW1nj4xAV1s5EXZRpjoVqNKgZwgwOYm9sxvxHYBh/ptWBoHz+kSG/sTSL361Hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2moKXPveB3U/AsaNrVqV9yZCXCpoAiH1zAPuuqyWI5w=;
 b=CK8yNUFS5oVP0EhzNv3X5lMTWBzrlI/15BVWwx6693dFL6drZ4pMv6Yu7tB39S3YFHGU7HDz2dKpKJSjvLJHS6RTpQ3Pp5gv2+sNtjmUyZVYtf4U9OKUbgX+L26Z73Gghgf5Q909U92mucTC3GJX0X9sAE2gnXC70sUaK2A8cWWkoUbxZhOXnaWLmtxuUQvOrSaovk2DcACMdmdEl+kwGpygL3xF2PbzJmLxTDBOko8DWkAnIHBkVDC94Cd/fVREb1IhYKnn10ijvjrCtvsGc0++wCoiOuYs32KMRGXknW+jkHuLivMx1fn0MGnG6fhC9oLIAnNSh5xdh3pDPYXo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by SA1PR15MB4468.namprd15.prod.outlook.com (2603:10b6:806:197::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 27 Jan
 2023 11:39:09 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::e141:b605:48c7:bcf6%3]) with mapi id 15.20.6043.023; Fri, 27 Jan 2023
 11:39:08 +0000
From:   "Leonard, Niall" <Niall.Leonard@ncr.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Thread-Topic: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Thread-Index: AQHZMW99YCz74HQkk0+hHBCSYD4Bfa6woJsAgAF0QhA=
Date:   Fri, 27 Jan 2023 11:39:08 +0000
Message-ID: <MW5PR15MB52184F83BA524D9600B820F5FDCC9@MW5PR15MB5218.namprd15.prod.outlook.com>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-1-8a20ce0e8275@ncr.com>
 <d4a70ab2-c5a2-2478-3fa9-c703c1619252@linaro.org>
In-Reply-To: <d4a70ab2-c5a2-2478-3fa9-c703c1619252@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=true;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2023-01-27T10:41:12Z;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=dc233488-06c6-4c2b-96ac-e256c4376f84;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ActionId=bf6f4fa3-0652-4cd3-b06a-6e6caf7b13e1;
 MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|SA1PR15MB4468:EE_
x-ms-office365-filtering-correlation-id: 83afb761-fcf7-4286-4504-08db005b1a6e
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qu1/EO/ykLui4GadzqvpCuMlrTLDg/5FL9CoxNAjaRL+VksXTjxOh6JKrppGpF6toPa/pfylVF3pn2Ba259UUkf/E6a+T1CYcGWbMWb/K2HWWtL6cabh3s0qXCWG91qDIA5yxFGYxX3VKhXL0h65yon/cVAgmeIfYQz/he9/P+5SJHyujqZMrP2ZPk6BlE9A6rWwlG74byVC0+wq2JBSbib9s6SFye/0SQHdwGM/d+ITqgcQU/ie+WjGjL/lUgckRWgGFxgfUmSGMSMliK4Mc6xq0Jwav00NdohmG1d4azj/dybHDyaOHZRjG4tZr9uczAMs92Ep54H+ROavucStfBNwZkfN5DCUSYw43YUF3HESa4UgQE/5Li8SKZp/1+jBLlxlosKrCfVuvg6Iec1WeyO1Rvi5/OlpS7KaPjD9QNSO0nWfFD//mNC/PoZOHXQNqrJwoB0AsVMy+TFBvBXOB5X1AB3Mj1i2whsAizCAhLIFnoucv3xh//yrTKE1qBd+LMexZh9LLge/Evy3rxkP/kFODw1yA2kCBb1s9v/kSM3OoRkeBVxWkSNofecSJeWsRycnrrspKpH0jX5SDXzF6FHQu/bDC3Nv+fjgALrInntkpypV/KrCkiwQUSuJeIYJlYOqOc/JAkzWuLy7y8//lPfXhfUA1iO9lkrMBQGt7BDolLwCmgHaaLYrsm5vs3MtdS+DKhfNJoBZ9XGmTQArSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199018)(66476007)(76116006)(2906002)(5660300002)(316002)(66556008)(122000001)(7696005)(33656002)(26005)(64756008)(66946007)(478600001)(4326008)(186003)(110136005)(38070700005)(52536014)(9686003)(83380400001)(66446008)(82960400001)(8936002)(8676002)(86362001)(38100700002)(6506007)(53546011)(71200400001)(54906003)(41300700001)(55236004)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y09PapT8yXUwcWpPq4eleI7B34yP0HOC0RlMnnw4AgVcvT+m5hc5iHIiY2qs?=
 =?us-ascii?Q?l4tCe2AWbLlIXVhNttuBFPmLayKDJJ3dPh0EGExlmuRvOGoLjmB5v4H3d1GI?=
 =?us-ascii?Q?j1Ret+9wWzalhjSPU1ldvzM21kWlw88Lum1nh6/DrTVIybJI79lcp52YyFIk?=
 =?us-ascii?Q?fq+Pwq9kAoxLNBT5sjMTwsfQ4mge5MEadSh9/muWFTWvFg3+cNmYYP81qLlA?=
 =?us-ascii?Q?+LDwOqMt3aETadMPkT95I/KOTaoq2AXUYIK9zQZ1a/8j/DEb8mGfFzdR2RSR?=
 =?us-ascii?Q?h4e3N6iXgCwzJ2+tdngMzPRB7+0b2xfuJRHbUC0cKA9KxR9QtObg3iFFHtdJ?=
 =?us-ascii?Q?ToH2v+tc6ECi0/UIDRdtkL4xZuaG5val+F0rzQWjqcL0lOEItl7C6EKNl3kk?=
 =?us-ascii?Q?ioUH7R22l1DGD3jrwVZ7TgZlbpSntmCuugoStBdin5mwsaAETDqo5NwvnLLt?=
 =?us-ascii?Q?5Kcqq9g8pPQ59UhRBVB/MnMExvk+2zzqtl0wsKOzc6TkCvcPn0jstaCA6ApO?=
 =?us-ascii?Q?2VATIJdlRlQPcf1MeoCCuKMttoDDurqq6gvT7cBDfMQqHeJ9aUqbDY2fLLxD?=
 =?us-ascii?Q?APWHwY05bHyIKvMdyaH3XGs4nLbACVd6a71yjHcygWFhveWQ9cIRXmiATJ+f?=
 =?us-ascii?Q?rPGm9GI8QWl/924xlPKpVeXVh1b60Rc+aN4gOrUQvCsiI4ppiQkimkCkNSMB?=
 =?us-ascii?Q?dKsweuWhVvamrUDFhBfK9UhYZprGuYMuVyLF92bk9WMA4vqvRKuvLweaJ2N6?=
 =?us-ascii?Q?ame0MewnJBdC8dTOYGruiYRrJcYEUgURqlrv8IoEMH2OXrC5/LGba673tARK?=
 =?us-ascii?Q?jRO75XcMyH8iYKDkNamv2DEOO0HUXNXvxJM/0NUvhKM1mxUl5DHATt5iv4Aq?=
 =?us-ascii?Q?hwyeCdquCHv9OFOS/HSdwkDhP3aVd31R/+ZueekV7fSaaSPCLiuB/QDZkv9W?=
 =?us-ascii?Q?TFJfCpw5nbvb3hZkxSfCdIxCKzFBs51Ox0yBIYDCgcHfGomfSgqo1nG5evIC?=
 =?us-ascii?Q?4UmmBwUuPd+7ZAJpAdDTgN9ikm8F67NNnMua9uLF7wimb6DzsdXn5kpxh+Hw?=
 =?us-ascii?Q?am9f30/4Rs1SmdNp1SnJQrSmBEKkVKAY15C7sWyY2YnegtNqa0mNyzNdHzLR?=
 =?us-ascii?Q?rwHg3D/uZ6oq9IYAbi8IP89dySBII0Dp8Z5VCyv5IlE8nUyIW7Zn+2NU3pck?=
 =?us-ascii?Q?QLlqqRfnWa8f+tYg1k+L+4c2j7bGYrUopz88gz8o+gEfZpNRyhYFu0XGyS3G?=
 =?us-ascii?Q?vH9n0aKuveH33nBX9xzAnq9E3n35CaPhW2NEn7MLWwW49Is7oF4qZwlLXf+l?=
 =?us-ascii?Q?8v2DcbtlKThKh4DoN7HGPh2fk7bXHvuky2bVGJJ2v95kBc54a02qeFJk30OV?=
 =?us-ascii?Q?1MXHprrRxzqi9aj0q28va6EPXiUvvRbcb42JZJG9EbdIbA6e2gZShrS7lkAB?=
 =?us-ascii?Q?JZb83dE9DYk5YFCb+bvU829Hl/SynWfTRKfx0QVxLrzWvgHkOB7Ihs49HHPj?=
 =?us-ascii?Q?s+vkRSfa8xMQ8Cr+45UdQkAHCSwTRj0kxaAOyCY8qeD30kdJfbyjZzXqO/2i?=
 =?us-ascii?Q?OsmWr8taE4zVuf0RhFCeOf5U2N7asyl2HbADZx+C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qe1V3S2WBQuxqo+yf4g0uIejdIC1PRJEgV+Xuv9KiZ14fQk+YhZ5pBeZRTM1x1bzGbX3wGIzjPLD1URrGI8MeCHLD1TIf3Y4TEdquO1AgrO8Lo07KwpCZAH8fcSpRGol61qNbfijRkUhST/TxtQrhDsjIaScficEi07fsaftsFIzKvfG7VsLny9p4u2MPpukUUO5o549VClnytNRN2zfBFmChTcMXV/Ri/WOJf9q6HvEH75IdRnL3ifSWSaZ8/4odjeN1S/k6o+xHorfgniRWOIsypI2c91q6SshexOn/wFRjSpNYP0/jriucSsUfPndCHjuMVmYIEhY3U8QGwUNO9WM90BUTxzpN/g7ZMYyfX/SkUpdRJQhS1UuYq55vad5YojMN9Bab47hcJC4mfRHWLYWFtnvHFqAjhhVGOD0komv0QojuIcAWLYNAieVotfQInD18csUlIhQ+OD1BSmO2DUp7q27jRS5BZSM5QYlshpOfbxl+727bMmMSuJbhJGMVe/KyNwXoVpKgu3/PDZOw7JqpSojAYWBFZ1wSNGunWj0x2UsEPM+HGvtrxF0q/PmRPi14iE7mYOIMDzfSHm964JV1qx0K7aoCUVeaNqnkxbia2pQ8pDq1ZPwv7sGxN4W+/BkIPRRT4jEiNyiJdF4Aj4GwVRcT1MgWD4GRoffFUJhJqdH69ILIdqJDtifO+eoLVd50PIjeaSK4stR5vDMxOD+0HrG+peRIuacLVTOQ9ohXzcjo9GhteiSU+yIlY4bkUoRTTdbH6N80DmL3CjPb3a8EfJkHVjT9HUvQS0hMeacvtZJ8mB5E3f+VolwcSpISHlb/UTYdmOPUfPLMUj0bHNzFj08blJPeoKYnVlU0rM=
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83afb761-fcf7-4286-4504-08db005b1a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 11:39:08.8358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SDC3Hl8gz43WiAjcs9xLFXCfAYcA/AMxkq0Unt5zcvRE+3mEyXG4y5hwIUfIY1r2t4K6Nm3pcXbiFN9Fz8yhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4468
X-Proofpoint-GUID: Y6oyQigHHMV-Bf1whAT_v-ic23QUCNLE
X-Proofpoint-ORIG-GUID: Y6oyQigHHMV-Bf1whAT_v-ic23QUCNLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: 26 January 2023 12:29
> To: Leonard, Niall <Niall.Leonard@ncr.com>; Linus Walleij
> <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>; Rob
> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-gpio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gp=
io
> bindings
>=20
> *External Message* - Use caution before opening links or attachments
>=20
> On 26/01/2023 11:17, Niall Leonard via B4 Submission Endpoint wrote:
> > From: Niall Leonard <nl250060@ncr.com>
>=20
> Subject: missing "wd,mbl-gpio:" prefix.
>=20
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.
>=20
> >
> > Added optional "no-input" property
>=20
> Missing full stop.
>=20
> >
> > Signed-off-by: Niall Leonard <nl250060@ncr.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> > b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> > index 038c3a6a1f4d..9405f9dad522 100644
> > --- a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> > +++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> > @@ -18,6 +18,7 @@ Required properties:
> >
> >  Optional properties:
> >  	- no-output: GPIOs are read-only.
> > +	- no-input: GPIOs are write-only. Read is via a shadow register.
>=20
> Why this property is needed? Why driver cannot always use shadow
> register?
>=20
The shadow register is currently only used during the write operation. It i=
s not available during the read operation. That is essentially the change I=
 have=20
submitted.
An alternative approach would have been to develop an entire new gpio drive=
r similar to the 74xx driver, but I felt this approach was better.

> Anyway, please convert the bindings to DT schema first (see writing-schem=
a
> and example-schema).
> Documentation/devicetree/bindings/writing-schema.rst
>=20
The bindings for this driver are duplicated in a few files even though they=
 use the same driver.
i.e. wd,mbl-gpio.txt, ni,169445-nand-gpio.txt, brcm,bcm6345-gpio.yaml
I don't know why these multiple bindings exist. It would perhaps make sense=
 to remove these duplicate binding documentation files and replace with a s=
ingle one for "basic-mmio-gpio". I happened to pick ". wd,mbl-gpio.txt", bu=
t I could have just as easily chosen one of the other 2.

What's your view ?

> Best regards,
> Krzysztof

