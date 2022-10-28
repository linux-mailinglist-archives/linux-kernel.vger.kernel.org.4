Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79AE610ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJ1G7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJ1G7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:59:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725A17E1A;
        Thu, 27 Oct 2022 23:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeCGOypCo05EkhfdEyBg/T44XpPj9AF5kDnuyJrciAxYes9g3zpoVS78sgjdgKaMSs+RKIsLerpUfdDa+hUIhOtVTvjRxPMC3pknqca2z9whyxFZIWv3RZkztb7KIJQSEzJ2NA6w1wNaZkYhBoYPkX/zvd6rk5TUC3Rp7WzV1ahGp1Zx8FnsnSbMkRLM9hrbNP3f4ZZSUFtfJdJr49b2DcW1A/h7k2DPhnqVLIcMVcPD5hll13bcKqXGkRbikEJ3Nis5P3l0K2ya6PAi1DSYbaLetnVJy2QuW7P5J1e/0l+yImTWvZz9OXdIxJaumiq6YVmHPKmZXYAB7eKdB15Lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGwHZSuTR8cuMA3fxjWkEx/lZYzZKnbslzP8rTriXoo=;
 b=T9LcSOKhAccz+bIZlCmZR5R9RoEpj6LamzetMKYzgCclRgXIdTkhPvM5h+ri4ctcdIknnht3hZcayzgs3q3fBry9Bii7xXx/iPdJ/HtaRRIwofuLtOoU1XKy2kDfWdMXPP8nf9c+vxBAjdITf5fNuLJZs0xzMvF5tfSaARxsXINrVTWYiaKP/w8LkEkSF7OX9up2jJKRfM5BNlbkl4y8kd6Pr9M0+YN7dQu2I9EqUq0pllb8bg1UMFWahtxq48FQR85zJIrP2XFOBHfdrfq7bXKZ/29YFtnRP5bjft50DWbFF89cMyRlSBytWZqQxQcSRPohPYtyYIi83nVHhJ3fQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGwHZSuTR8cuMA3fxjWkEx/lZYzZKnbslzP8rTriXoo=;
 b=EgW1koWmj5nPrUBzUzcyxFljpvWJkUzR6ag4Za+v3TQ0syShgMfJ6DzHilx6KJ+srcDPaGbqQ/OwxADpX+jpUql7IfUzmMzCVI5CkPm3Id4bbo1JM6QNFX+6MxXMCkorbeG5xKrL40pXLTI9xcS72BwKZvJFcVzkmqe+6R1mz028NqZ3w8XlsUPElmiEZQ1GuQglPnJ2tsmcxjr5cX7vn2XS2WTLC7B3uzz5zBoA5OB60Ad3uFqEaYfjRR4wFJJH08V7XWaTO2zcpTGyKdue/mGaQeZs2YwQMwqHk+I88Ho3NTcInTsmBnlrpaXC6L2Bog7zIFHObZgKtoH2fCtfEw==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by PSAPR06MB4264.apcprd06.prod.outlook.com (2603:1096:301:82::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 06:59:32 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::9ae1:4f06:2773:f8dc]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::9ae1:4f06:2773:f8dc%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 06:59:32 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Lei YU <yulei.sh@bytedance.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Henry Tian <tianxiaofeng@bytedance.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH] usb: gadget: aspeed: fix buffer overflow
Thread-Topic: [PATCH] usb: gadget: aspeed: fix buffer overflow
Thread-Index: AQHY543fG2IRDKPpjUCvaIBADhhwbq4jYB2A
Date:   Fri, 28 Oct 2022 06:59:31 +0000
Message-ID: <HK0PR06MB32022348EA65805C7109B7D080329@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20221024094853.2877441-1-yulei.sh@bytedance.com>
In-Reply-To: <20221024094853.2877441-1-yulei.sh@bytedance.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR06MB3202:EE_|PSAPR06MB4264:EE_
x-ms-office365-filtering-correlation-id: f197fd56-9262-44ff-e435-08dab8b1f708
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dDPKNRV+f3NdJ5+rryDTM5BIoltllZI0gRzBVglfdcTFr3afLW/Hop1kqQFfSrU/0VJph7Uziu3klQjaExQ1r+flFhUgMFQmYWyt+nagx+Zg52CpIq/9smT+GsdB68JWnRJqxD7MvvkoBIYrr8gNHsyK7ci4OL6NZE/4pcIo4WQlzTfzi3fI0ZP653DmfOWcD//IzHbWowEe2kIqYEBNDAqPSAfJdBcHkZXrDAmWMu9nJAyGtz3s0pcm/bP+3KeHzgKuKW3dTGIq3AdqQHwEJgKN5UaoB9XOB5ikp0TAd5PFBVdEJ52ufucomKsWyy9f+WKKNymh6G7za5hKuwiZdDSHzqkQ4QTnOR4drVgj4QjlmgQiJt2B3RjbE2L5OufjjevhVtdzOg9eUGHLcj0G/PaKVW/d2DrWTpuYTEzZ7ws8jW8AXijCMxX9zt61jQmjs2lSb5k5S362mdNgkoe0ka4XhKgde5MKypKMJ1bewQjgXoQzy116jblQu9GIKuENdIdST1jQnDp577vRdNbcINs4tPlO0K03XYAZacBLG1z6YKUyqZ1OQ+rRkSTeTJrsq8bPboVjz92dW/wjLprD86G77ajfxu92hV702ntiAi0zJiYBobb1SiGdmeHQNPyTSLavKZQ8dfnqwJCulbeGhkemJiY023pOxBvJcvwBOu23KnsW0WPlLUq77uR0XydXGYM0ItwqDtpO6xLrd1LY4Iy9Swbq7lYSt3bB0c/mnkWg7w1hNoQsSTGJ3KmwnzegqHB/k8oue/h/ftsc+CG8MGTmeSL28tjEVNxiDNYIGNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39840400004)(346002)(376002)(451199015)(26005)(107886003)(83380400001)(9686003)(478600001)(7696005)(66476007)(2906002)(38070700005)(6506007)(186003)(55016003)(7416002)(66556008)(66446008)(316002)(110136005)(71200400001)(66946007)(8936002)(41300700001)(4326008)(64756008)(5660300002)(76116006)(52536014)(8676002)(33656002)(86362001)(122000001)(921005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9NySRj4EjMYFq+qAudISBYVCLBSIRcT2+j1uFWtMq8WAAlFnVXA/uvrJNTBs?=
 =?us-ascii?Q?tQtCNayFxzmnEUEpcska34z04nKHzmTFAMvPFlNfNwhSUV/xQgpcnd0fcqTJ?=
 =?us-ascii?Q?/IPu2uWXPr6GeKLqM4REHpO3vGgSpqNV/+wjKGZFodp2TNtl4iGvTWkA81TW?=
 =?us-ascii?Q?jZDP/gzYSn3UASOnWW26BZPUZpVF0DeEyG0F+khfEJdpafkS4JgFpzO4X0GT?=
 =?us-ascii?Q?TvDKL4OfATyTywABa4KHuoXQVLYdBd9THHb7nhK27NzVwxs1x7nFPC+ZnRrH?=
 =?us-ascii?Q?lhGZJ/etHWincZUaUkUERkopWAovYgPwqcp5hQmxSc6eY/kOyymCdeV6m0ml?=
 =?us-ascii?Q?SAglK+9qWwtB4ySNEbnriEadK6uhnx6UBCLgMKCPHlp7GmGXm+xc1XPxUcMJ?=
 =?us-ascii?Q?Shn744W+gVMPsDmAscq07tDmMFUS6PwWrUaxgle+2piBYFn6Zfj3HSKYpcJn?=
 =?us-ascii?Q?p93+MdwRRG7EX1rFC50Wj6CpiBjk0kuup1501N7epplqPlKEzxb9g8ffBUg+?=
 =?us-ascii?Q?LioL6qLjhKIvgBmb0jgl5cLrsut1NiBxR0RA+6jP31dL96cu0ot2X39qYZ6A?=
 =?us-ascii?Q?EoHgp6mwGTUv0s9MDTIcS8CCUPb27Vf10JjEAhCFc7OLD2bRF/3wZPOgnyyU?=
 =?us-ascii?Q?GsMyitr0OP1JHHNNcsrSCf+yr0PTkEvGeq4R4Iqnp/Y2kQvbdLLxXTa/NNiE?=
 =?us-ascii?Q?+25/O0miz8tANkXZtF2wJCyLJTJf9ykl1UyRdVpBGFQ+HlQ5n1+9vq9X2HxP?=
 =?us-ascii?Q?HGdti0SOFmNkKX9hazcXDcnkvTPK59Vce6bYOrqeMljBCRUaovYLOQ+9rpY1?=
 =?us-ascii?Q?8e8c+kncvb2a1Kpc8S2sz8Vf0qyis80fSz7a5jozmk2VU6+9fH+ph16oYl/L?=
 =?us-ascii?Q?0nD3EpmaI9KHkG8+QgWdgLJaKj46epaRpDRrnk8ZXtjX8+1/liuDMPbmtbs0?=
 =?us-ascii?Q?D94CyuPUmqSbpLA33ULmpJDA3MNQdhJ/hiP1qvM34Z00Cf3iarfGYgL3vZk7?=
 =?us-ascii?Q?XZECsXkBgV4tBexLhduNyg2SNXDbVex0avXfUvkYM3qUUcMNluF2ZyJhcVhx?=
 =?us-ascii?Q?z62A4ZgAq9d+5FERQPDw85/XVfmfkdlc33MrYHA6R+vkwkpaoGaecxr4qlW1?=
 =?us-ascii?Q?0pHhFqOWIsa7D4xIwUn4X49y4hTwA9Aru08G8ySBV54Gim9n3h9EYguIEEK/?=
 =?us-ascii?Q?6pQ+b+jviCKWYRIQqdmOUgegvGFCrCYbYGQTQQQxML3VnrhcAug6lG8U7Qe9?=
 =?us-ascii?Q?57uY9LXB5HPHpbubZpQkghMB6PyD0c8r7btajf2JiWIMS6+yGJVHccP9Enj+?=
 =?us-ascii?Q?sErzc/Ho4rMIPvF2zO5ZyHqQ5EG6mvFyiWJIjkUCrUYJUcU+xv6nOIQT67I8?=
 =?us-ascii?Q?0MCLEj7iNlLiit/o26uM+5NBA2Wh94QYPms+/qgSYA5+ZakUnVMZkZp1/IcL?=
 =?us-ascii?Q?AshnnhzpPyxZY0t89DEzFK9N/yGK91s6kAgy+GUUP2E8zrFrmcE+ZaULQoZA?=
 =?us-ascii?Q?11X31pxLsyap0qfXQpwRUV1OpvpAuyUu9MEwJoFGd2QE93wMl1qCN6JEQIz0?=
 =?us-ascii?Q?8//ssvBOVk1S+vreESp+snVPo+YaUcjLWYz5bVfD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f197fd56-9262-44ff-e435-08dab8b1f708
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 06:59:31.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lti2eOTMJvCKGpFaiTgvmsvdV+m6lPK3aNCMgRWNcgQnhQwNiY7cSN7D51s8Ns3PHsp4xhTI94s2PXAXLtyrUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Henry Tian <tianxiaofeng@bytedance.com>
>=20
> In ast_vhub_epn_handle_ack() when the received data length exceeds the
> buffer, it does not check the case and just copies to req.buf and cause a=
 buffer
> overflow, kernel oops on this case.
>=20
> This issue could be reproduced on a BMC with an OS that enables the lan o=
ver
> USB:
> 1. In OS, enable the usb eth dev, verify it pings the BMC OK; 2. In OS, s=
et the
> usb dev mtu to 2000. (Default is 1500); 3. In OS, ping the BMC with `-s 2=
000`
> argument.
>=20
> The BMC kernel will get oops with below logs:
>=20
>     skbuff: skb_over_panic: text:8058e098 len:2048 put:2048
> head:84c678a0 data:84c678c2 tail:0x84c680c2 end:0x84c67f00 dev:usb0
>     ------------[ cut here ]------------
>     kernel BUG at net/core/skbuff.c:113!
>     Internal error: Oops - BUG: 0 [#1] ARM
>     CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.15.69-c9fb275-dirty-d1e579a #1
>     Hardware name: Generic DT based system
>     PC is at skb_panic+0x60/0x6c
>     LR is at irq_work_queue+0x6c/0x94
>=20
> Fix the issue by checking the length and set `-EOVERFLOW`.
>=20
> Tested: Verify the BMC kernel does not get oops in the above case, and th=
e usb
> ethernet gets RX packets errors instead.

Thanks for your feedback.
I tried to reproduce it on my side, and it cannot be reproduce it.
Here are my test sequences:
1. emulate one of the vhub port to usb ethernet through Linux gadget (ncm)
2. connect BMC vhub to Host
3. BMC & Host can ping each other (both usb eth dev default mtu is 1500)
4. Set BMC mtu to 1000 (Host OS cannot set usb eth dev mtu to 2000, it's ma=
xmtu is 1500)
5. ping BMC with `s -1500` argument from Host OS
6. BMC kernel no oops

I dumped the `req` related members in ast_vhub_epn_handle_ack() to see if w=
hether the received data length exceeds the buffer length.
In my case `req.length` is 16384 bytes, so it never exceeds it in this case=
.
I'm wondering what's the value of `req.length` in your test scenario? And h=
ow can I reproduce it?
Thanks

