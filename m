Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1DB6A694B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCAI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCAI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:58:54 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2136.outbound.protection.outlook.com [40.107.249.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829DF9C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:58:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx0gMP9np3+QvEaWpEAV9KtTMrwWBX0InfYdZlMyncelAQt7WxU3HvFOW7VyVFU4VIfBswd32u+bcLN+AE/Jg+2eezst3zewb5RJDw65AOi5F3ApuQJg5KpBDcEKT62+cOleWHL1fLIxAFZQyQcj1UticQmxKwRFPLvij++VpWeATd16Tp4/kDzsTSjl3Nn2VHm0BDC0fC7e2GJik9ihRxFuhSV3KUKDe0obe7OIswZZd2ZbO36Wz7DacA0asW1dwFT7hLYFJ+htiZfigbq+NW/n98Z4JPoGpXEab6z7DtrhD/yu9UuKAakj3N+efmg3CH22ZBy2BSuT1JlJy3koIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcOVtW+K+K8DmZODS3J+V0YCXL072ek1z3oK7rL94ec=;
 b=c1+PDPwxplFDCnRl57IT2daVEiDnw36OslcK9lUITidb1Yp1SbwSVPm7538Vr9s9pOD0V/rj0WUcWCzBCcR68o0cQJHQBONCiYHG1EtlzjweXOGCttWHnMfm+9IlnMOM3kaSpab5ME2huKioDuICLqo4fZvhSDXistvknyCMJd6fADOPOmJJts4TWD5bYhem8/yIBNmASrN02XQ9iZ8IzCtPdFzDqJlzXd/nA6rM9/qLiw+FxQBehcQLRLXjuieP6683DdR+Extc9MaAZvdTa8Fq3gFVhIcd8cjKBM1ygTHGdxYpCHNqggSnVXypi1QHyyCqV0CtWrxl1LQFvNPiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prodrive-technologies.com; dmarc=pass action=none
 header.from=prodrive-technologies.com; dkim=pass
 header.d=prodrive-technologies.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prodrive-technologies.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcOVtW+K+K8DmZODS3J+V0YCXL072ek1z3oK7rL94ec=;
 b=ZbgUH5Pm8gVkM4/81yCp/UCASKrSIT9yz0OXVsqQrKGuS65vZ7ha/gUui/hGl/IJyGVBwmIQnxHANvDQ/GKKFRb8db38kxmNYdYJmhHwa1nEdvS+uHLsBa/Ahoh7i/XgofKxMWPmidBm76450K0WQ9vR8PralGa71Xb9vCqISbM=
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com (2603:10a6:208:15a::12)
 by DB9PR02MB6906.eurprd02.prod.outlook.com (2603:10a6:10:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 08:58:50 +0000
Received: from AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e]) by AM0PR02MB5524.eurprd02.prod.outlook.com
 ([fe80::b0de:8e68:fc8:480e%5]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 08:58:49 +0000
From:   Paul Geurts <paul.geurts@prodrive-technologies.com>
To:     "krzk@kernel.org" <krzk@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] dt-bindings: net/dsa/: add brcm,bcm53134 as
 compatible flag
Thread-Topic: [PATCH 2/4] dt-bindings: net/dsa/: add brcm,bcm53134 as
 compatible flag
Thread-Index: AQHZDjG/ekUYOqqJTkeoSW37sDG0067jqvCQgAEJkgCAAWZBgIAAALpA
Date:   Wed, 1 Mar 2023 08:58:49 +0000
Message-ID: <AM0PR02MB5524BE8BC053F45CE4E04AE6BDAD9@AM0PR02MB5524.eurprd02.prod.outlook.com>
References: <f5238f9d-20aa-2cc1-8e83-820c46a33a52@kernel.org>
 <20230301085531.3713797-1-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20230301085531.3713797-1-paul.geurts@prodrive-technologies.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prodrive-technologies.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB5524:EE_|DB9PR02MB6906:EE_
x-ms-office365-filtering-correlation-id: 8ec4039e-3a9f-46f2-6a84-08db1a332cbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EUGETKGI9veJsalmGBPkgvyNqGm4qQqjdRYPUqAFGi9rPbaFKDZDJSO/4zSpZ0pCkyWQ1K/oUMkl4OibWA/xge15Gppx1L39LNohDCOSqtSYaP8DuJfuyJcAU7hj9aEkYtyw3Ja2ijZu1iPbJmJLxP8y6UPKQ5PcErF+aAbW75w7aaPieqAoaqmyUIqzUhjEIlZp2QZWrW4yg5QN3pZvt+TQk3o6W55e+CDmY4fjKW/CduTJkRXqM7hn1v3mowpLL5f3JzPUptffcBZNVQ+wAo7fCBgNUe9eviBPrIfx0OB4OrGu+WeCBFi9hjN/To16DMwotaS9B1w+KK1SyTgHGc6n+4NNJy6D7Cu43KGIKyhxivcyU1ymGG/Rhpqeoi0Mrh7nNfDXMVcLD4ijZz3fGdD7V6S8rRzOYP6L1VCgpLYLZYn9kiAPw8RvVdMNzRhOrkIrWDSVnya+dTOMPTEb/z1PLJ0BsQWJ3xYkrqW92nz27rsHpJV2sIUZCzl2Yu9jAa1QEggyzwZ9rVUiIso0ctzfxWsDxkEZBZpTs6rLCuMo8C5fG4HRZPgDRgFrkfjGgNgQMe5FvqdPfWG2pglgBR/Ruj+OcvFvYgE4sFT4KOg/2MdVyZzQb21415Owzta/2/ziP6A2lqfGGh+7W+ReQOnFsVaLs8I43O8sYtLcn2auJBGmWY5qj/nNUL0baxNf+vTLYZ3GglE8sSRTe04qSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5524.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(366004)(39850400004)(451199018)(33656002)(316002)(478600001)(71200400001)(7696005)(6506007)(9686003)(186003)(26005)(45080400002)(8936002)(52536014)(41300700001)(86362001)(38070700005)(2906002)(5660300002)(44832011)(66946007)(66556008)(55016003)(66446008)(64756008)(8676002)(76116006)(38100700002)(6916009)(4326008)(122000001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NsY3GLbmWAvfr2oPuDlc7coc2mWaqXEHqPXOHHX5utp90IqUp2rkJJ8W3gZA?=
 =?us-ascii?Q?/L9Cy8sSiNtIF1pDM9sGYwaBvX5+Mb02MwHg5120N8dYtVJ0/MFxgOL2sh7L?=
 =?us-ascii?Q?ck0c61y7hYrx9ojMjEmNBwVcSSa7ME+Q1TLBOezK+KT1WfdusefRViD1GmOo?=
 =?us-ascii?Q?hI1gEjzxThnutzcvj4644YLU6PMvHJH6PsMQkS2KYwFCQQKtotRFlzS4wuMe?=
 =?us-ascii?Q?j+1uodGioNliGgHovp6nJlpSuBamzljJ/RBcwgnD6zrnhySA4e3XLvp4apbA?=
 =?us-ascii?Q?u6skrZVgDh5UU/pQMtko44Ta+6ctjUitrqF6zJgCee8MyK4tE3AkaGevmD6N?=
 =?us-ascii?Q?dAlAS8cQLhuwIQh5Apg9H0KTZ1R0tZZhMZkV7s1gGSu6Iu5lUIHG8JAL3sUU?=
 =?us-ascii?Q?L0h3P+5yl/T3lMXOsmdyWLPcglsm5Kf9ME0hRk8FHnDepvyRQKWcs7xt8bYH?=
 =?us-ascii?Q?khi5aGpHjP74zMMFhft6j+8+trdAbRlOImajyMpq7Rdw8Wpnaz2ZHqjR5ELD?=
 =?us-ascii?Q?nVjuvpLB6JLPqjgyRmVwZdren6c+GtQ3X72+fgJUDShDp3yEmYUgsA82il/H?=
 =?us-ascii?Q?Z7fgMbTTu8TWXCvx7rTZejn/vjaTLfC+HuklgJWSDWIhMBJu+wuv560LamAV?=
 =?us-ascii?Q?Twy5qzQm7sUZQB9nvJAm6mPJPxwwOiDfQUkSYi6M75IMjPDDT4eWIHqgoXGA?=
 =?us-ascii?Q?ySzk56f57KoTgGiqgD4eNe++J4hDbJOjwipReqYOPrqzZDdV0qjFnxFYPJJQ?=
 =?us-ascii?Q?mnuRvbi+4kdcI0bzV0Te2z4hxF+MfcxdsZTl6v0QzNFCGWJi/FRd7ZPVwscD?=
 =?us-ascii?Q?Ocxbx5YWB+ekA5SLN9gme7GTXcYb1vl4O6AAt6Xxy62/POH5MtOJN3d4l/hC?=
 =?us-ascii?Q?rHBScU7zFAxshQa3JyPQelQdh1qcLu5vZuV/TnTg0FzsXGLcXE89yaOfzYfl?=
 =?us-ascii?Q?PbkG4j11UjoSW+GpDecS+NmmmXKpl+kxWjHi21k+2DbewySwyY7dlCfsOisW?=
 =?us-ascii?Q?ay6+NkmZYcHsgMD/XBXWbPZobKUAtJ4HFXn9z27CBHic+pIrC4qx4tSebqpe?=
 =?us-ascii?Q?Lmg/J6Rnd3/agNjBVgTr7ehNzfN2f4lwJMC4efhzHHFHYp4Z/i03+wHgxiUO?=
 =?us-ascii?Q?laF/SP70HoFTM+t1FuM7+tX8Ap1X7AXanrWaosGFVrFMVFAksXvrDgBl9UjP?=
 =?us-ascii?Q?Ft5PBnasdh513fx3y1i0fr3Sks/VyQAjEfOVGDLgu1ZnqDZFu6qDw0EaAIDy?=
 =?us-ascii?Q?TQWVcroM0W7tt98YsHb5RFlNpSTxP0ggG8mzsX1ojet3wM9H8mud/tJce2QN?=
 =?us-ascii?Q?JvHMub9C/3sq/tdcQdtMHkE4yynWIhOTAhPp24YzHKn/0+C2jkdYl1En90Iw?=
 =?us-ascii?Q?xkSsUtV24Q65F5MlAqcS90Fb082yjSgHFZndAVBeNB8dk8dpkteI/aUUQfHM?=
 =?us-ascii?Q?+8895YVSDI4BgsAxz+iw+huztgiqTKwcDNwiDjs5NHBd8gs0k09NG1WNZqys?=
 =?us-ascii?Q?Dcc44K5kIfd3CrVLJExtxDvzxXMZlx0tW3wi7VJ4XRn2Fi3JV2V9aRR0Ta8L?=
 =?us-ascii?Q?vjueD0cKCsbWQzqTOTBnO8j1ZBARSQtBUPAo5ODHEgQK8RwtB3s2wPENvhsg?=
 =?us-ascii?Q?TJsecCI6D9dD5fInD+9SbDY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prodrive-technologies.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB5524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec4039e-3a9f-46f2-6a84-08db1a332cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 08:58:49.8984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 612607c9-5af7-4e7f-8976-faf1ae77be60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9cyc+rSMXDGJi04W+au1IrJuT0JDG4e4GOACUJfyGfBLAnFTfnttoy1afL08zhYxuwXYaDVWAQxtav6ABqebxfNPpVx3i5f8AEVdSfSzsVlIkWQPvA/qpJAAtRf/VIo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6906
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 27/02/2023 20:44, Paul Geurts wrote:
>> The b53 Ethernet driver now has support for the BCM53134 device.
>> This means the driver has a new compatible device, which is now also doc=
umented
>>=20
>> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
>> ---
>>  Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 1 +
>
>Please use scripts/get_maintainers.pl to get a list of necessary people
>and lists to CC.  It might happen, that command when run on an older
>kernel, gives you outdated entries.  Therefore please be sure you base
>your patches on recent Linux kernel.
>
I did do this, but my git send-email was not working properly and only the =
CC to
my own email worked. I forwarded the mail to this mailing list using outloo=
k.

I will fix my mail server settings and resubmit the patches to the proper p=
ersons.
These patches can therefore be ignored. Sorry for wasting your time.

Thanks for the feedback on the patches though. I will process them before r=
esubmitting.
>
>You literally skipped everyone...
>
>Best regards,
>Krzysztof
