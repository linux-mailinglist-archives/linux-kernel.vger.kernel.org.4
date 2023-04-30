Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3CE6F286A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjD3KHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3KHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 06:07:10 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255D1994;
        Sun, 30 Apr 2023 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1682849229; x=1714385229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kJhGCYomscOv1Dc7WWz4XPIyolm51iJek2pYWutKmxg=;
  b=q7i7iJNYOeb1/c8E//CBtns3CwDsbnXcz8aiQogHdE8KYHIShAvfO2EU
   8iOk19pWXHydjUyTyhnERVof6R1f9aghsCocNFOuV45KPOd6ZbTqxudRo
   LURKSTEofzCOb4aJdksGvtFzJEzrPv2jgAYajpYWE3+n6kdalydHV2MHm
   atZ74XtIK6oMr978HYOcwTLZMkuVWi+g5J9WOnnYlty1UEqAQ+Ipty00P
   tpu1f02u5dO4QoKjwMKeOW5Jds4kk7+gs+fva8NlHnBjt1aYYWyg4N48r
   WmdAbE4tyIq/bRZZZL5MCST2zvomfPstL9RD/RvMwOQjgx1XoPt04zL/j
   g==;
X-IronPort-AV: E=Sophos;i="5.99,239,1677513600"; 
   d="scan'208";a="229625857"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2023 18:07:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC3MjS4Jvj8DTOgrBEVuHItwD4TowzpGeklf0JerQdDnu4cZzlIgYf5clCTCqPmING5LOcMjNhqx2Hzmq4P2p5bA0R07KDtQ1VvWVO/x4TETdXP/ZyPEBvVFnKacKhf4RZFbtHzCcqTcXbENywhh56AVVx1h7Kb0SveP6ArpEqOWC7bSBRlar2A5YXTiu5nxSxX3XrGkK4hcR4B0JbmrNoICXJsfpVwCcEWCCxmNrvhyPVxC6kh8LCsJVsjiVls0OqaxCki0bjsbH81pqTkY1JAnMX0ePnpM9Rw/KvtkveBaq0ZtJtAKeBO+tQ7QR/P2RdakP5RnB1gRfjmG242Pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGTJKIKlh40qWrBBZUIYDzfUtiaHenIspoeLRRAbijQ=;
 b=lq2FQ6wZM0D+vljVEbGwCN9Dv4mDDcmWKJIR50wOYb/if1+y39WbzGf0U/vMO6kTsjIHT24uo91w8EuqjHrY+dOPlhzl1lmXpEVrEzveC/LSHsKLE0koV6IT81J+FfRzOAfR5ytlfaRKc/R6X4UOugN/vHfWv36kk1jU8Gs0u3/h00iiNnh4yiNIqV0KtmSizbKQ/FLzsZoi1w5Bah8wknxdT2je2OprEpTeIu3PWc/Z209rI3DKnNRo+80+nPhjVFFSJXl9qkHF33J7AMZJehTIh3xmrbjn0Cipfj6h1Y4ABFmThRbOtobjnYuY8H4DwanMmHJ3l7JoHxhrwS9Mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGTJKIKlh40qWrBBZUIYDzfUtiaHenIspoeLRRAbijQ=;
 b=J6Gw1MlJQOpYE/B9d8J6bZIC3qKAMM442paobHwolqJh45OKkaRfWbBBjtl/BcVApAEctIYcdYJhPcz4901iBeWxSOio2pB5AJFI6G3A7zFA8cJ0+FBlr+HB13g5klv2OopLy/ElsBi2ruQA9MzbfXXdN8vwVogsxmm2wKoMU7w=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6298.namprd04.prod.outlook.com (2603:10b6:5:1ef::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.27; Sun, 30 Apr 2023 10:07:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6340.028; Sun, 30 Apr 2023
 10:07:06 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 1/2] nvme-rc: Cleanup fc ports in reverse
 order
Thread-Topic: [PATCH blktests v2 1/2] nvme-rc: Cleanup fc ports in reverse
 order
Thread-Index: AQHZe0uESVTiqdbLXU2l0HN/fMej6Q==
Date:   Sun, 30 Apr 2023 10:07:06 +0000
Message-ID: <2zcb7p4hgdeuj4wud3ztizodqt3lu44ktewusaxot5jn3ifrlx@x6hha62vjrqu>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-2-dwagner@suse.de>
 <a58b526d-2e29-6c4a-e277-b684f98636eb@grimberg.me>
In-Reply-To: <a58b526d-2e29-6c4a-e277-b684f98636eb@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6298:EE_
x-ms-office365-filtering-correlation-id: dfb1fbb7-22c8-4166-066e-08db4962a74f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJg4uKs71SGOR4QCLw155O5Ek352IBC+YO2icEEZ7LlSS0xri2eIsRCbpXZh+WkvU3AHEOZeTP6bYSuktgeAWalOqC2gNuZbw3afHSEoMaUXphHfi0D7ppfQa46ixpBcBVkZGD1/g8G88IzC0g7JOpIQW7EV4O+NfPQn29np9y/HagQM+eusrsrQt+xrVaStBeGTIt+qkbWqDH+/UgEhOEGZ60v8ZNCbt27RFcfT/CWp2dX4woHytvgnLhb2dJRl+c0L1Jc6vj3AXstzwLqFsD9Pjd/XbN4GvxL4CHUu2OAZuE/wTQ9c4p2pYlHFmed1dOkeWwtLn5quM4KAAJTJUh/if+o6kgslt2qf9Qi8UvT9qWMIA3t6e4rA4P7R/1x9q+iyokTuwqGvjYi9iyhQFhJwxL/cBMIfB3kWYe9ukMqDO8jpzhWS94X/Ruml86v2DMEHWR38JHCke7tNvgPW7x41+5fsEtzq2u6XFa9Nemj/voRPxye9d9tlojdXVX8F4W3zBEqWIy+hdCuSFTe2UlwZmI86H0x/qdt7xDlWpYVCbAfahNDziBM43z7n12tfjKA5ORh0wgk9PeDW4wn3YWedXn8QhC61L4JFAhhqFqr7JnyQYsUSgSQlhXwaMZrt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(33716001)(316002)(53546011)(9686003)(6512007)(6506007)(26005)(186003)(41300700001)(83380400001)(66446008)(66476007)(54906003)(64756008)(478600001)(91956017)(66556008)(66946007)(76116006)(4326008)(6486002)(71200400001)(6916009)(38100700002)(2906002)(82960400001)(122000001)(38070700005)(86362001)(5660300002)(8936002)(8676002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?abLuM3SgVC74SELvftKFiWHs+lbdtgYlN8vGfHo7mKC2+mwTZk17ivp466dE?=
 =?us-ascii?Q?WXFOhdADzRiFCDe1naX2HWfx6GYSsF9zEcjC9W0q6FX29dEkG4bJVa/svI+8?=
 =?us-ascii?Q?3++wAt5kv/0M6eImwPjLr1d/7H3oOYDiLfkIildXMRlTSguF8y3stkkfKyfZ?=
 =?us-ascii?Q?eU71A7SXzVOa1VM9kgr+sxUZMdF+xlCAv+G5ydzLnl7NJM7+d8qTri+WVIBf?=
 =?us-ascii?Q?x7LVzYjmNoPsAOkKlVHMCPGj1cPkPVT+O2n5ERI+3Qs8Ty2olP9WIx3LmqZD?=
 =?us-ascii?Q?NDpLgZXniHgA5a4C/yfG8uF1LjIGOJbUpb2drYuQfQfTJewfGzLZLauYaL7I?=
 =?us-ascii?Q?tGcFxLr59r0K+cAXuWKep70U2IJkJXRNn5ElZnUUef2b1/sDhB4dAf2bbrYk?=
 =?us-ascii?Q?ymhADYyuoNrnyUFkGjU3/rIjgtLT78hBU+mSmOsf4lfGkXrIZXZ7BPqnvfv9?=
 =?us-ascii?Q?FmV+oFMPIuzWOj9ScAsHFXEgzdHTlznZw82UTx85oH3q2VGJvPjfhKbzVPBE?=
 =?us-ascii?Q?A0mxrP2f2FyrWa9sBr1JgtLi7QWH3vfdkUSmU2wV8SkQ9+yZrFbxAyWC8OJS?=
 =?us-ascii?Q?1Vc8JgoBqb1FLcbwQUexU0+0P7TpKZy3727BWgZSn+wzY2H9dmd5qlasLZAF?=
 =?us-ascii?Q?JsaJQJ6Gsw3te17dEh2PjNJIBDQl9CDc20BoDY2L+rbM6sXKih2ljDZYvX0T?=
 =?us-ascii?Q?Txi3aLqmK1iQOTVuswwo3Q2U59kz/HEWyVrtqAfoRFg+yEwuj/SbPOdZH/Ks?=
 =?us-ascii?Q?9ViBwFkTT7tXYnu4gVRHn3MUEwc/SF5kIWfuuJjl/mSVzNKed0+1+ByFCzae?=
 =?us-ascii?Q?r2KmnMOdVxXILb7SPSIAsGXRmmnzHkVtzUqyNNuwkjNc6UaxelZ1LJKcCUa5?=
 =?us-ascii?Q?8SVScd5sN51BsfFzqPmOANFIsxnEekQCrEJH05IXc89O5hZyrK6tJNLQ/QJI?=
 =?us-ascii?Q?HJDl1tzqaPNT98DYKFpcbVLBO10aKIzvepl69QzhAbn1+Xc+IkNUs4h/h+rp?=
 =?us-ascii?Q?XO5rSDhoGRHU8rOBzIzC8S75JuFwPHybBUGS4QmgV9WesbfiKxygfCMj1HJu?=
 =?us-ascii?Q?WiJ0Hxm6lK+39xrMP3sf1YTnRcekVFywNy6XcCuIUSHvZ1WCLi7cJj73mnIG?=
 =?us-ascii?Q?NkbZn2SW8uPfFG+xIvUj9OtKqeyw4zdwVir4Roz8RcUlQqsti917U6Z/2v4d?=
 =?us-ascii?Q?4YG24a15AlfzUZnE8FoPya2M0px+XOTqpb71WlVYPXMBkfiZDwsIzmTdFOqV?=
 =?us-ascii?Q?d29/woVZn7dDkgq3wZQpnLJ//R08oP1KJZkjGOTBJxI20dLL9a3WCVJeTz+w?=
 =?us-ascii?Q?dh4rVXLUsdXfPSvHlP2R6vY4fgqY3KbYnzsDqVCb3Ti0yIzU0Kagg+tHDjkV?=
 =?us-ascii?Q?eYQke5sXD0V3P03rZwwuos3IGXrdFPdszjcCqySBvQx6pK7DvWH/ZayKaSlh?=
 =?us-ascii?Q?A7OVHGdSskqpdecfDuDkfI62YnEuk3duvsjYEnNckGczH2k0QgYD8I0mVv59?=
 =?us-ascii?Q?wu17yyHTBX9RCBlmZ+hQV5Z7JM8H9N8EtOdxWqvHbfk9phW+pZvhl0A5zxTy?=
 =?us-ascii?Q?iI8oY0qOqsUy20M+lT614uySybVzo6YNBSJI2vSYATH5idQwv/Rq8vN4tvAI?=
 =?us-ascii?Q?i/OeKzewx5UWwXsJUSWnEQs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E7726A3740443439B1682F5147D4D4E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VxiADP13gwIDaZ93ZvjPr6NyQVnxtUtDTul9iuhhuu2yvc8mwf7H0JevbtmM?=
 =?us-ascii?Q?f3PWQMdleXceDUmRk7B+V4K/ecthtQVKCX3Pj5MDMqY3ABeQ2WgYhszon/9u?=
 =?us-ascii?Q?Yayro3OgfECzEflK3FhjH42lRBM/Iz0qx0WMPCOOP4hFplSyVYAPUgBzaOEh?=
 =?us-ascii?Q?wIwVra1RQdqkceLj3FfrpTQJdfGyjbA8JZAki9lVaNIYBcDqdVVw811PX1bR?=
 =?us-ascii?Q?v7QjP7IvjXQ9eollNyrhQ97uNwaj6v7Usrar15Mdr7TLpY2qymZamdg2X5zP?=
 =?us-ascii?Q?SUi3r3MQzMr/zvZLGtXCNXxhSUY9ToSEjky4Dvk5ZSwDyYAUTaJuNpVTgivj?=
 =?us-ascii?Q?Ln7Fn86s7jRpf0EpHJIDo89L0OE5UaEmqAsDYh3U6C0LLStM1IeQkKo9NGa+?=
 =?us-ascii?Q?pjEUk9DtpwQVIreWg39vlyxc+6RbXoumU4Sb0yW0hh3kiePYChbbLh26bcwA?=
 =?us-ascii?Q?Ev5zf/utPQnuwugmPI7yDJTwYtrjPbVCUnXe7zgdvSGY7OeV34P8DU3AXFqQ?=
 =?us-ascii?Q?2BmkFvM83skRp2yv0VwqodABSctd374qxhOWdWDjGPVajtmsdxaGSvMhW+3b?=
 =?us-ascii?Q?tzPgJp9fNOo0pjqHaPiQHh/s4UdFvsV7jYcxFSJSQoCtCMo26OG+LogkcASG?=
 =?us-ascii?Q?tLMrGHSs4sloxq38nyVaFRSSbmMbR5Dstuuk/eLLQoqUYGCQ10JJ4rK/Zaqi?=
 =?us-ascii?Q?nki14x5TcEa39teywx0mY70N7WykdWZR8JGfNOaeg993soZL4Tj+1YB3KF0o?=
 =?us-ascii?Q?WC6zm4gosokAkFdG+cl+GRZHybxynC7vpQVRQ/SkOC7rcie7IwWnOHoImT6e?=
 =?us-ascii?Q?qBXwyWws4YuOBHEeDtcfNi+sRsD3GVBt3wh6PChLolIuXAiEb8dkUmg6XsiK?=
 =?us-ascii?Q?zmSnBxtHVL8gAOIDEleyTPk2N/SMVwWKfRsQLhiR88PmIXJBRfZBzlibx2JC?=
 =?us-ascii?Q?3NvsLjdGH6NcrJy+sXsJXQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb1fbb7-22c8-4166-066e-08db4962a74f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2023 10:07:06.5653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yLFzpYqiXgdpksOjwzgJZVDtP/ocjRgh7J0V1X5Eam3Zg14PTXxn8SGZ1JYLEG4PrqI8LBieOqh7tJVxzzIedSOLasjYJ7VVFNiW5iP+Las=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6298
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 19, 2023 / 12:41, Sagi Grimberg wrote:
>=20
>=20
> On 4/19/23 11:47, Daniel Wagner wrote:
> > We need to free the resources in the opposite order as we allocate them=
.
> >=20
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   tests/nvme/rc | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index b44239446dcf..ec0cc2d8d8cc 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -204,10 +204,10 @@ _cleanup_fcloop() {
> >   	local remote_wwnn=3D"${3:-$def_remote_wwnn}"
> >   	local remote_wwpn=3D"${4:-$def_remote_wwpn}"
> > -	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> > -			       "${remote_wwnn}" "${remote_wwpn}"
> >   	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
> >   	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
> > +	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
> > +			       "${remote_wwnn}" "${remote_wwpn}"
> >   }
> >   _cleanup_nvmet() {
>=20
> Does this fix a bug? if it does, than it should probably be documented
> that there is a driver bug because userspace teardown ordering should
> not trigger a driver bug.

I think this fixes a bug, and it can be a left work to add another new test
case. Daniel, what do you think?=
