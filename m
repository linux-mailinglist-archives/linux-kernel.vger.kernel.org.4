Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FB6D3FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjDCJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:11:39 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA31D769B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUap5eICjn7rhGLwCJsyRPDOb8BHnnP8mlAEEd4GSZvT6ZMShjrmLzRfYoJIdamOiUAMXygTuj1NiWJY0ig1Ovm9Ay+TgYCGz8nEExxfiWWx/47znIKCY4loXbCldXP0ad0HiAVQNo/LcKLFjOfjp5SQQd8dlOdMGzgRyBCeDRuQjoaQkz0s3+hjicB8teX3n8TZmXG6VfBb9i02OCbbnLjq2ZA0fodo2NNCq5gc7FpOj076mTRk/ulFnnkEenugsFAkhk8/PkNfS5XdL9OPFyIfc+A28+3h3nkiyv6z8hFQ0XzvuE0W1r3maOyUc6JPFMb2OCygcveqsFtNYnAYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfTSvILqXi+5yjoboxODQfr9fm9lo6kFgQRtHhlk2r0=;
 b=Sl/++MvNNYyUiPatyIN15IFEgXkyAtR5RcPgJB9mGdJ0EQb9ZCitRloRO8aR8t+/tiAECUJkVbVKbrfmSePtfSC6FPyHGqus9yHcaXiwBmoC056MLb7Xfm6nbuZowlp/rwmLeApzXaBl6YMnhGIDpjEkgSBTHLCsaTihdMybEnKemC8jpx0tbOck0h+uKLPLYkOTTWAWZbI9NMc6rMxYva6U77kDjBHFZq3wBKfFDqvJ6Yr5D5yjB2dhQ/Cw+ftiEsLaZtAgnF9lLGWh6YlxEv+ZFSf5cUbTPU9TnOJ+9MVBtD8RVzJz8in71pZWtWgYK5GmTIKuBDaOTNST+9GYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfTSvILqXi+5yjoboxODQfr9fm9lo6kFgQRtHhlk2r0=;
 b=FcwhDgU0Xf8HDXnw/CAThcxHtLGPo7HAQ1uIvDuVHUqWQ6eWnU/7OJKPkZXqmn2n70Fsp90Tf9MeKSzYcUEWfITG3I/5Ufk81LApwlChv3uY307jtLr4NPBJJ5uE18cBN89ynWy3zVa2vis5WcK6lGpPHgEPCv/fug6C68WX428=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7829.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:11:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:11:33 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: gic700 shareability question
Thread-Topic: gic700 shareability question
Thread-Index: Adlhc42Zc4r7rB9RSWC6TTy/JzkMQACRxD8AAIRnzKAADqPRAAABUspw
Date:   Mon, 3 Apr 2023 09:11:33 +0000
Message-ID: <DU0PR04MB941748AA2A21C5FB384A7F4488929@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417388F9BDD73080294FA8E88889@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <868rfdw797.wl-maz@kernel.org>
 <DU0PR04MB9417FCF524FA0BB9808B4E8088929@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZCqPEjxDmI0/kruD@lpieralisi>
In-Reply-To: <ZCqPEjxDmI0/kruD@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB7829:EE_
x-ms-office365-filtering-correlation-id: 46cd0386-77cd-41dd-9696-08db34236ba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7fMjhcqVQ9JN8fMzSwrCIuAqM2VPcOySk01+zrkN3VRaUgDl/fvOU6gNjmsllOm3Nap4pYqVL4kMYFTe5U5qp2DIoUjdF4C46oLOwQNj3KYXfiuccOX7R6XjfEPENgnn/5CbsvKLMannoPa0/smrKXok+/Io2AE5tHQvmDuQJq8QqVBrhR8+jp1OHgooHvMUi1/omlxQCwI0fitMy7KZ3Kh/TtFZ8QTmxvyJlIRx8rQU34GOO62J4FStmIW2fsgJoFhrA8G5Q8jiuV0DJc6jAdqY/0DLrvxXfYZQyT7YpUKD0slC0q2+kJxj01pzhPVipVidDMm48s1kplknvqX/rq4Xa/zVv6K4W4MraQBbhuZvd92/raYU/DYjg7kyO5glbKcFCf1A5ouOLGs/efV5BtL3UkufRYQoN/1HxfzGWDSuOQFs/fRvrJIPk33h281V8WjrOMW5pv0CdCRV+8kA3j2W+Abm19F8YtGqWn9ZMshxwL04rcS/ub10OWtyp+HbvXqb8g8STk3QX+/JCKmce/NO9KdKYLJcymDgqZBHOXqbPO4HWgBSBBKjxi5DNSN8ie6XSyTKxOvvxDYvVTwHI4070u9//UE9clnm0cByMOxAnLJp3mPrHGRmdW3TOjZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(7696005)(71200400001)(186003)(9686003)(6506007)(26005)(4326008)(6916009)(8676002)(66946007)(76116006)(66556008)(66446008)(66476007)(64756008)(41300700001)(5660300002)(122000001)(38100700002)(54906003)(316002)(478600001)(44832011)(8936002)(7116003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wCJTxlNtpxNVZHKT2DX1azre8HatK/Y+fzilZZ66rugH3Xts7Yq2HlR3eSZ8?=
 =?us-ascii?Q?BBX25kW8UGpJD/TZVYgs22sF/n4KSs4uE3C/DWORDFT4adnAcbLR9rKMfIgd?=
 =?us-ascii?Q?9XD/JMXT3cdtVzPVX+byR2WUmPwKplo/DYkoLqQhAiXBP6fyAoZanWy6Zcdl?=
 =?us-ascii?Q?QZa4r6k2HWYm478/T4mONBCc3VNG1pHH9WS/HXRNZuPM6823LhjXGZqLcAr8?=
 =?us-ascii?Q?a0OtzKeI9GD7hpE86Ihau4X8ku7z88dtGCGuLWimSnudLdFEFPsRyq5A+oQ9?=
 =?us-ascii?Q?DLkMgMpuInE/MCWVTZg/vcf3S1yt/U5xVizMeTQwt9FH5rf34wRZJDrmjgXx?=
 =?us-ascii?Q?u68Kd3cwBNNKQ6rwARTTfCTrC5gyQF0ELrIsFNg7VZkSCvySeK/BdANQe5yl?=
 =?us-ascii?Q?RHt8VI3XaLvKWNiQo8dXj9pIVxsMClbiP3xgRTCy7G37jvaIiFMdjHzMPfh+?=
 =?us-ascii?Q?OLvpbfjdvmsvK0HSVCXdZDxDB6x5LkDvM0P0HZb4eNzHWw3//mxYbJPiVOCa?=
 =?us-ascii?Q?weU2DrhN1uXVDTMHh8gevM3e3ZgBh9PNMbbX+/maF351Y7dzJHhjxozUXObK?=
 =?us-ascii?Q?PIYf86oP3ewj7IwcMF6O2EhFBS3QQWoy+Geaf1wjQxXv5XhGqPcCCZNn1Qx9?=
 =?us-ascii?Q?HUMVD8QppnI4+vxFc9OgLheAbSz0mJL567OhlmtWt+FvXfDNE4Ci7KD+jGb8?=
 =?us-ascii?Q?wpDeGNKxyZJ17uyS2hW1zuglOoWvjuq/ouMHSoCwKbYYv5SSGK8m+PbEucoC?=
 =?us-ascii?Q?B1QYJMHIX/+tylcdRgvspnLDwQXcT6khVg8PkAEilmBbyRBnsu8XpyzslcVz?=
 =?us-ascii?Q?lTXTqnvwD0+TZvegQRuBLAjuUFW8RJtEdyV0HtHtNxd0pGWYCdoFJIjKUKiP?=
 =?us-ascii?Q?ST0k0I4nl9QLwJW9pfCGrRccMsILH980WqBOFL5Oe3tkgzx9o/u7AAl8NIUG?=
 =?us-ascii?Q?0o7R8BYe6+FA7nNe/xOV6aSnWwYG9j2QESQDr1NKLaymMiBbXPc2xGgD2U4o?=
 =?us-ascii?Q?lD4ZHYiJ2kZnBJNfTu1qSEAn0/jhICyCF3EqCd/E1FZhlvQVbLiNSZMQ/bpy?=
 =?us-ascii?Q?ZZpRLFr/vpCmuIYYuBgl1Afye0KO+k54OdH9hzD4e/JnzCr2kMe0RjK0WI4P?=
 =?us-ascii?Q?IBfsmIaBzN4A77Bric/OdJQHrcPP3EWlJxlct891Mkb8QlDTxs3E5t+/Rhol?=
 =?us-ascii?Q?wUq7e+B6g40/RqBTmdVEPbSq3NlAl05m0aGIoWKqGWiTRAxLoLtmUFk2MiVi?=
 =?us-ascii?Q?Jl0dYZDUWEIw4PEhE9OgkmRAXOQXLKNX3b1EsNz7AWHVzolG8jrr+NTO2iLS?=
 =?us-ascii?Q?ZKsMBbEgteBK5v4UCMY0B3FYF7h28PI95pMpIdL13SxaP+7V7MGBdki5wfFO?=
 =?us-ascii?Q?2zMFhc6hYmwHJtPve30knC2Scq4iPbPCwA72XkSTNY8HkAfHPtKklg+hJgHg?=
 =?us-ascii?Q?cuVWa1Q2MqtD47dhIaftmotbGDVbS1qOdmdPQ+LoqTUXMg96Dm0PAt1x2lyf?=
 =?us-ascii?Q?XR9dNK2RE1e7ORQiTocL1p3edUIlKBW23fbuMkNOLnbR8JR8FWux6Wh4p1SN?=
 =?us-ascii?Q?sLWQZ0UyXjTNj+0woQk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cd0386-77cd-41dd-9696-08db34236ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 09:11:33.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLL2MoRbz9eNTJ9iBnxR7s7QRXl3jjOtbxc5itW283AX48dP7yk/9mvEwi/0kozXRVzmvGszWHZlP4I+wXraVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7829
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: gic700 shareability question
>=20
> On Mon, Apr 03, 2023 at 01:36:31AM +0000, Peng Fan wrote:
> > Hi Marc,
> >
> > > Subject: Re: gic700 shareability question
> > >
> > > + Lorenzo
> > >
> > > On Tue, 28 Mar 2023 13:48:19 +0100,
> > > Peng Fan <peng.fan@nxp.com> wrote:
> > > >
> > > > Hi Marc,
> > > >
> > > > We have an SoC that use GIC-700, but not support shareability,
> > >
> > > Define this. The IP does support shareability, but your integration
> doesn't?
> > >
> > > > Currently I just hack the code as below. Do you think it is
> > > > feasible to add firmware bindings such that these can be used to
> > > > define the correct shareability/cacheability instead of relying on
> > > > the programmability of the CBASER register?
> > > >
> > > > Saying with "broken-shareability", we just clear all the
> > > > shareability settings.
> > >
> > > This is the same thing as the Rockchip crap, so you are in good compa=
ny.
> > >
> > > I've repeatedly stated that this needs to be handled:
> > >
> > > - either by describing the full system topology and describe what is
> > >   in the same inner-shareable domain as the CPUs, which needs to
> > >   encompass both DT and ACPI (starting with DT seems reasonable),
> > >
> >
> > We will give a look on this. But honestly not have a good idea on how.
>=20
> It is a longer term fix for the issue, we are looking into this.
>=20
> > > - or as a SoC specific erratum, but not as a general "sh*t happened"
> > >   property.
> >
> > I will ask the hardware team to create an errata.
> > >
> > > AFAIK, Lorenzo is looking into this.
> >
> > Lorenzo, are you working on this?
>=20
> Yes it is being worked on, that does not prevent though an errata
> workaround to be applied, firmware bindings definitions can take a while =
to
> sort out.

Sure, we need go with errata. Thanks for working on this.

Thanks,
Peng.
>=20
> Lorenzo
