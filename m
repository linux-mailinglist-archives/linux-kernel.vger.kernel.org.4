Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042706D3B86
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjDCBgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDCBgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:36:36 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926345598
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 18:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUbZDy27U31EzULJMEgtVUOtSF92NNPVDwxg+NtFeWgasZakYr8Q0RZdJJNZD1vueZigQf/jYsier9FxXRFtNZqbbD+QTVh7H1+RA1442Md0bJry+1HOmyGgIguDNf0AFpb5ydcvzgswtRqhAm48U5qXa168tr/j+FjjbhIwWmDMKpwaA3fzvtmCiYD+D/UMOIFE8AXyp9nnqS0C5ZL0mY9+hHR1sovKa0K3cj071Tq6TsnpWCvYyTwPht7BcUTZIpPEMA1vkBLnL/Fmqqovu6jWMQqm92knIOYiVCrkn+lXb1xA2LUQKu3xYVNwAii/kjBFveTuE8K/ngA7yUL6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrLwaiJSUlm9DudzqsQDE36UM9bNcZJXAj0S8TIOBFU=;
 b=dV1FCPn3qaecJQAKdobtbZUXuqYNsr5LLliNdEhcX0YyTgqzc7E0+CpWo1F+XAW+zCvuFrTIRAmdmKt8HyP0InXR3rXJPXG8JYoV/NOw3ZdnXAPoAmw3qvz2Fz63tO2PAYMY+QHC0g8qgj7Iht1z3dO8pBZW8Oze3CTG2UnAihZ1JHSkE4DrI2jwqXkRDNsEKBlnewQ7zldJrcJ+7upLFlLjfKdz+eXsYru4R8+Fq+b7TiqS7Sij+QQmEA6kknoMvJDySY1Nk01AxuVULIzQ4ZAzEZVIBlxYDUvd1gigF7Dv0a/F9f21Kg7IxO8cwUBAlRavkeILDv11zB0uNhzlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrLwaiJSUlm9DudzqsQDE36UM9bNcZJXAj0S8TIOBFU=;
 b=M6yUpchV9FaHmwOHEfp0KHiCmm0rViA9wCeEnO/0u3BysYWZPt1DHE8vFVlvmktu3uBpeO459vkIzTMoRrFJFW5llLIfTvjlF0Nr1b0uoXKJi4AbdMQaIRlrM2IyniU8Y1DWhczFfHZIp3LB8W1Hz+hHKEDKz5mvmB6K5zax8Y0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB7048.eurprd04.prod.outlook.com (2603:10a6:20b:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 01:36:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 01:36:31 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: gic700 shareability question
Thread-Topic: gic700 shareability question
Thread-Index: Adlhc42Zc4r7rB9RSWC6TTy/JzkMQACRxD8AAIRnzKA=
Date:   Mon, 3 Apr 2023 01:36:31 +0000
Message-ID: <DU0PR04MB9417FCF524FA0BB9808B4E8088929@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB9417388F9BDD73080294FA8E88889@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <868rfdw797.wl-maz@kernel.org>
In-Reply-To: <868rfdw797.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM7PR04MB7048:EE_
x-ms-office365-filtering-correlation-id: cc8362ad-6587-4ebc-066d-08db33e3da16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+tiOa/Mo3xx7hw4wI6wqmaRbZThCT5Q9ph3PCLaOlVt02HFpUAi9m7gy9glYDFk2yykkuT28pZBvzsaCMklLJJOFlNiRVtwJpgnMY+nIlrNdUU7vVTpHm0tHqCdKfFPU5gQbCziL7MS/aZtoUfnrhfysx2WRosmGuo++8WVb2fVx+2c3uUcFgtF5ojymHx70dFnqkGQofAMBF7OWzHlzw2afe9aBWHD0iSguQuXVou9EUDmv0KUc3O81G4kHqfbncHDCJM2jvXRECVdjL1ZB/mnBaoUGwt4ZNJ0d/M3TZnaOXSAx747E+wWhvt8+th5oXzgeJwUDX5y1kvXFWK9DcODH6KACiHOhrFfS8HjfOFI08q5I9q0TBJhcsogKGaTs8xKsfo7fSozHtsRM1RrYQ1UNb2yfOb1LpGYfpOO4wkYKEWdksrP4kCcCL4lmPUvbzv/9MLxvsphZYyxCwJnoqj3p6hgY6P5Aq8szC4Bwa1KGz/XsrTqP18EK84wb/d4Mv/4zlpH5obESa1gnnf0IGlUOpgRRH2RuryFjCWpSm6NiH2f3lLCe6yQvUvEPm249LFxIpc3o4SbBkMZ7EDzK2sUzN3O58RPqEUqFRv/Rg8puzyIEW9WE16NtwN28eUh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(366004)(136003)(396003)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(7696005)(71200400001)(186003)(9686003)(6506007)(26005)(4326008)(8676002)(478600001)(76116006)(66556008)(66946007)(66476007)(64756008)(66446008)(41300700001)(5660300002)(38100700002)(122000001)(110136005)(316002)(44832011)(52536014)(8936002)(7116003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DjVFExZ0rbutam37rh8YFglt8l2zSEOQkrBkvV4wfjQgw59LX0Nxwee4jJKB?=
 =?us-ascii?Q?EE1gRTpFOWoV2IW+J2LAemjRTZrnQVkcXylZLiS488DMUNiNRdu4P0HQK9ws?=
 =?us-ascii?Q?9TPQ/XmeNHa5bM4cMDTvBo7oI/b1ucOawdU1iRnaBupf4e1XiKYmJ9mOgi8y?=
 =?us-ascii?Q?hoMuVbUofxVfCkrMJCulDDNW72QxUre5yBpjSyd4LIn7mfOZ9WuC9oSv0+8i?=
 =?us-ascii?Q?N9unjmvP6rPsS8NnYflmVLIjK0FVstuG5lLr5q8IpGoHQpUGCJMcRDtsdsKE?=
 =?us-ascii?Q?ATALgVhHVpHg6X25g0CMOb2G2lAOHR3SA6FW5lAr6GCN+L95VRyC9LdV29pX?=
 =?us-ascii?Q?rZSI15YiiZjFitQMrprvVXpiEAat6aORtfPm1og5kl6s6SFHUYv14AcHsjdd?=
 =?us-ascii?Q?sdjg42hCKDRF/l28cyd19+YD9FpVGVN3LeoGqXIUE1xI314efvHe5MOqIHIx?=
 =?us-ascii?Q?G2m6aqMvGqgLWUW5HkM9HfXjYL7aQxmCHRZDbJTQ1J4xJjfrKFHTQ94WqZQp?=
 =?us-ascii?Q?LiqGVplitUM1pKPT7HVQqVVa/10A2gzAZuUGiNmwHzJ/1myaycCHIufdjnuB?=
 =?us-ascii?Q?gS+QiKnoX97erQYHEOk4IVHWUGSCizCId83Fp1E6kmivbcZfRq45z/2yEh+L?=
 =?us-ascii?Q?bZD8RVw+mIShjqhPtLzyptw3dhxbUPFdfLCbHN/lT8i+C7eemFFjmXHi7shs?=
 =?us-ascii?Q?vMKTPnVh7wmSb714QsTNtsXQydunQWGekYi0HFhJEKbCvROr6I56Vqp3/ziO?=
 =?us-ascii?Q?6mJgHlz39fkMI2JETjzNN5jmj9w4sLWJMSJh9Ex6WQ5Bn7KXg5t+vh5JzR9X?=
 =?us-ascii?Q?IH5FWj+6lfUCMOL20ZNaN+GIJzuSTUi1QCmAZGc0j5Sw4Z5xtjzUbvARtPyc?=
 =?us-ascii?Q?WaOd2S6l7s3Vfhqn3gpHPajw145cLUoFEIFqVwWpJnL3U3ZzY+LzUQgtkjiB?=
 =?us-ascii?Q?qxnHo4fmQjRJyNFa1RSbbbBNKhaSvLzyxL/sUg2TSerybE/ORyJ+5DoflxQ1?=
 =?us-ascii?Q?CIWDaChDszTdB5eWoGcSrYfnc9GSFqG0kEjuW6ceO8RhPon8uuCHmfrCGDOU?=
 =?us-ascii?Q?avhUJiLSN/+/UYNxZMTDLuMBfHu+swIa4nmapzCpNc3K5NxmuhSKm752YUKC?=
 =?us-ascii?Q?cgduTH7NwNNhUD8gbHN+Tx4brNbGj3jN34LXx1hA1RqtKyHQrIBd0ySA3ZX5?=
 =?us-ascii?Q?I9v9HSRdFbpS5LIVsTngviQVtCwMsjxIPKL7t7zsTwitLYrTsSCjMOpOD5iL?=
 =?us-ascii?Q?i0Ifxr9ISD1+AZ3kUconkcuhqMFNw8U5Hf2F/Rz3UmwfPvxRmXMO2E2A+iLH?=
 =?us-ascii?Q?sCg29GSHqvBIFE4BIPai4MZQ5xL0sye/ponaPVtEmfTWZ/G2KdRntzgAT3Aq?=
 =?us-ascii?Q?mwR8eJxU3+Sq/8veH7RXGaKbtOOacl3bT0AgEQN0GcO03M0cXqrDKuRXMf/+?=
 =?us-ascii?Q?qd2VGpKIjXbGnO1k6LxFVW9+WjI7KR9CWySt2PToy4mmn4oua71d1WibAARB?=
 =?us-ascii?Q?q6YKqjQvhfDbiRpPhj+UFCWeU+TfL7t4HvQS4o9clKtoSSwIK2fk21XbMqHl?=
 =?us-ascii?Q?A4dRiiuICGJLHuyaYz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8362ad-6587-4ebc-066d-08db33e3da16
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 01:36:31.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbOucXvDeJ7I/XUPTTiZGSvsCXwKXstpsqwpQ104AegkShUnx5LbLC1hlsS65eV1F/1TH/1xk1BxN/kbWT/G7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> Subject: Re: gic700 shareability question
>=20
> + Lorenzo
>=20
> On Tue, 28 Mar 2023 13:48:19 +0100,
> Peng Fan <peng.fan@nxp.com> wrote:
> >
> > Hi Marc,
> >
> > We have an SoC that use GIC-700, but not support shareability,
>=20
> Define this. The IP does support shareability, but your integration doesn=
't?
>=20
> > Currently I just hack the code as below. Do you think it is feasible
> > to add firmware bindings such that these can be used to define the
> > correct shareability/cacheability instead of relying on the
> > programmability of the CBASER register?
> >
> > Saying with "broken-shareability", we just clear all the shareability
> > settings.
>=20
> This is the same thing as the Rockchip crap, so you are in good company.
>=20
> I've repeatedly stated that this needs to be handled:
>=20
> - either by describing the full system topology and describe what is
>   in the same inner-shareable domain as the CPUs, which needs to
>   encompass both DT and ACPI (starting with DT seems reasonable),
>=20

We will give a look on this. But honestly not have a good idea on how.

> - or as a SoC specific erratum, but not as a general "sh*t happened"
>   property.

I will ask the hardware team to create an errata.
>=20
> AFAIK, Lorenzo is looking into this.

Lorenzo, are you working on this?=20

Thanks,
Peng.
>=20
> 	M.
>=20
> --
> Without deviation from the norm, progress is not possible.
