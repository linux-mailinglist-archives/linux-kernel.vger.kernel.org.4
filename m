Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AD5E9790
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 02:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiIZAru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 20:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiIZArr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 20:47:47 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB722B3C;
        Sun, 25 Sep 2022 17:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsZ7XEBix3+PbbcR9hDuxWjSgf5Bxb7OobIJ/fErqDDQ/8gBvveLOJRqWCI3iayq5bKBr29XePZHi2BUcraeTWuukymLCRx6f2/CKL4wajiBSdFfrJ0Cogf1PW51117K8I2Cxn/eY5pflRrmprK8LR7SWp8VtHwKoYVg7Mg/zh3Lb7XtMbvUoAY+ytT8/GA3cyEdin1Xg6jut7jFzrxar+qWHsFsUMCWEo/ly6bgJnqsRzzTE2DnHc5CPW0X/WQqM0OQAiZSBH1DtNmVZqbJNxJToIas6HF5zXFRfc85LGvuWvYya8ix4TV7QGc/sMp7X4DVRUzO/1FmZ8qs1FWvcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgNvnCsJJbw+sWUs7Qr/0qib8Ci1Tk7S5ZQ8XkDG5dk=;
 b=hxmsZep5ZAs75aCum8dbfXPs4tlFm4iVb9EPewJODSoWyDDZgUsUce01LX6R5aWq/l2AXohH+6soNy+FE9F7UJHwTPGqOHCzWibSgqajGbEvnUuD4RdEFL4UmrBgR4Q5+DHWyjjCtnv+o50WheL+rPKIfog478Va1oNzEW1dRJYglgnOIZJt8VTJkgvQif6ADG5genTgFG6TU22HQ8CsKVzcNuV89sN3CR39aY8JUjnJoQ5c5Z5Pz60N0YwsVcHy82V5Du1x3oT90D/NDl41DVXAGAONQefuwnmLMNjc1mGy273mWXUdvLsVG3aak1WY8HapPDCEQQoJ8rZPfMvJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgNvnCsJJbw+sWUs7Qr/0qib8Ci1Tk7S5ZQ8XkDG5dk=;
 b=q4/dhXlI0Zo1qcSi1Y3FohgWBhCJWieeP/vvYmVRjfhzghFfcrDHgQsylJe1XMEkQmfFT5DiEP1Us6wyUsWnzwf2BzWU+NiaK35gJR6ufSpOeyKwK5eowitXm+mzUDHaftH/ggcf1GHcaka7PC6oh+v2h8XjhZHnj78Qwn/M7UI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 00:47:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.024; Mon, 26 Sep 2022
 00:47:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: RE: [PATCH v8 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Thread-Topic: [PATCH v8 0/4] remoteproc: restructure the remoteproc VirtIO
 device
Thread-Index: AQHYuUJ7PUmHIPxwNE++nUAZwqhxoq3puwPQgABZd4CAAuH/gIAEGWIQ
Date:   Mon, 26 Sep 2022 00:47:38 +0000
Message-ID: <DU0PR04MB94170FD9934AE9C624A9A0E388529@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220826115232.2163130-1-arnaud.pouliquen@foss.st.com>
 <DU0PR04MB9417BE00D9CA0185660A4EB9884F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <3a197588-fa74-acce-d17c-a2c2556b1fe1@foss.st.com>
 <a449a357-467f-972a-ca88-220b773157a9@foss.st.com>
In-Reply-To: <a449a357-467f-972a-ca88-220b773157a9@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7659:EE_
x-ms-office365-filtering-correlation-id: bf588ae4-de93-4f99-7821-08da9f58b63c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1V8ZZlBY2R2ArhSVps9ULptEiimSBMhnNqR+4hvMTBCPIYLQwzGN0n2mCrVWSyHHydg3aJFziViBz7ddB1K92hlJFwJkB40gBwVS0XOpUdff6CptOKs3J+PX1VTvF789KCWxuwQR+dmU3QuG3bOUSD9aMXREg5WFQkFtzqAEfq+GlAv+Gmx4BrlFrDFY/n8f6WR2nKF0M3O+fGIJtbFNX84DbvTldo4n/nEk2d/f6wT3PSyqYoL2lgqmRkGSzOlr2mpwFu8l+1uZSD7mOe7Yuz+th3mi7yG3QesVkVSy9S4lalUlMUlcTfwu+kcx6A0A5Iz3gGh1yT8OHU/G6oW2dM5QRCTHgvHI58JLKgFb6DsiHvvbFyofQpVmZpJrNDagcfHILgxwZhp7a2sJ/OgFrb+QjXCgXiyV+oZ2Uke5v/Dg9F8KT+qwUOWTgGZ5NPDARUAgtyuXi18DlG0MsB5tuDv0NoT+v1VvP4zNweezKdp0NVmru//IH03Fb0TZNgmPakwVCMWD1aIX/e2NANySQhRowxwsU4kn07L80Ywx11aXJubJzG4zHWz0lP6LrOiFvIlrQvx14Ds3qpZvcsYq2qahU/XUqmz/2Q7H+ZT4xPOE+MTeWmavy3aKXljluuyxmi8vpnXXAEemGMbZRfSh3yWjhaXM+KBy1YhBDbghCUtUjSlj+yq4uid42sD1hDRNxgV87eeYjFSDOB7tX2x1Q2yMvKti7g0u0w5Dn9XazR06np8wihmBTdDdJgMXpwwXNoSN5T19fjIv67cVCu+u9QlYYHOdX0sFDUHo4TCl+NSbBhWPmbg5OHHFmD/lrcTAWpNQ6yEoPmUTU25q0re0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199015)(110136005)(478600001)(45080400002)(54906003)(316002)(86362001)(71200400001)(76116006)(8676002)(55016003)(966005)(4326008)(66946007)(64756008)(66446008)(66476007)(66556008)(52536014)(26005)(9686003)(7416002)(7696005)(6506007)(5660300002)(8936002)(83380400001)(30864003)(38070700005)(41300700001)(44832011)(53546011)(33656002)(186003)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b3O0zEu7WXDHZa4mLOhKTct62VjPtPo56e+hsjvS3Wv6re7fOStZp02m8Sva?=
 =?us-ascii?Q?say+N78S+htco8YF/ySCgsRtXCc9/lEktVBFLKwEbQ8/sMjB2NRb8yzp/sFI?=
 =?us-ascii?Q?4xmTMAeqj53xDbD6MG9DdoVeRphZajXVmkGiGsI3Wiyk/F9ekDdqL+cWFkxU?=
 =?us-ascii?Q?BfbIgkUDa+K2LwQEirsdYWUC4WpDpWBWB4XRWbWnXmA0rG+LnML94TQCnEoK?=
 =?us-ascii?Q?P25uZWipWzNSPbHwqiy2zjU1dQOAhCOq9u/rhHcnvbhNp4jJyXJPO9AEs79q?=
 =?us-ascii?Q?HeRLnH4u2WdjnYjZPM0WaPfLJ1ajj3CO/l3Zl8gIThaRv5kJIXWwbmrD/UM1?=
 =?us-ascii?Q?G7LOgsVg90mPrIqbWU/jB/N77KUDUv7db93AWwnEuFmK+OYnwYRInvheI057?=
 =?us-ascii?Q?iNLdZzafVMhBHPnH/x9pMEvcwgBO6XEKeUvbZtkrbcpFrJJ8QpLu3h1gSTy6?=
 =?us-ascii?Q?ueznbhvHNT/rNZgFSlODJGeXPWtd77F9BOfytr+vquY2kI4Domves4JkkJOS?=
 =?us-ascii?Q?4WASJp1s4wU4c8o4mpNE1koFOOmXpwzzgBSkUK0OzX2sc354FKLdzvT5JAMI?=
 =?us-ascii?Q?c9SLUJvdO/Awd381X/iipEMvpo7hb9o609/gf240VZKuhwgjHVq5y5c2gCm3?=
 =?us-ascii?Q?ZJepa3eIyUcYCdlUk/OAogwPsdzyd78imF/03sU2R6uwwQYCONk+yN8jV/Hu?=
 =?us-ascii?Q?L3WeWANdh3abHdxtYSSOcqaXnp/zT9TdT1B5aQbDQv8jNVZvF4jM4UiMF5E/?=
 =?us-ascii?Q?JyGtm5ygm99OSRCq/yPWcUBN179ism1GwCdX75/gnh1XTVKubOr5bpQ2mwS7?=
 =?us-ascii?Q?tBoXV6TRDcCSeCJ8gtTOnzItW4r5mYJ0zd49/CMZvmyiozMCWkn82yQ+2HsR?=
 =?us-ascii?Q?NFgUL81fvs57B2i1sjY6DXMzA48f0ive+ikma3GqtQaEAXf9l60V+270iyG+?=
 =?us-ascii?Q?okW3jjGnEWbOPEgSh8V/9cy5En2/dxa5A85u3QJ0/Nh/UPq5LOTibVfLhOZS?=
 =?us-ascii?Q?iplIQn843mDwFjJJFxVh1nnNvzVVVeQm7FWH+oEWZYsjrG6AwnyXsbCRucsT?=
 =?us-ascii?Q?10QBB/2nHxUztDDzaoyMHyj4M8LrNIMPKtVC0CrfyWpG58fDQRH3+jaoo5XR?=
 =?us-ascii?Q?3hDtqWtG0klEbcSvKp4ls17ZSiZPqvPP9VAZZhiVgZrK7V3sn21gPrDLNp9+?=
 =?us-ascii?Q?p/0gMvB8DHlOTxcL5Lkamk5YPPNIP0Rveyf5U3FcPkBPAtjgmVMLCLBD7MZQ?=
 =?us-ascii?Q?tTMz/YbpRonzjSnhOFhK7ROFyLmkUjDZL4BW6N5KWiFee0ZVEQhaYBVgdsJM?=
 =?us-ascii?Q?e8PzNDqRZAtXwIFrqFLlT0QCVtE0Ll3jEREJ7kzPyVYom0XXe3n+rpQE13+z?=
 =?us-ascii?Q?dlRb4P05kJqd1PLdBfy5Tr1x19A+j7xseFe8Ica063uAOdut0aRo1EQ9j3gs?=
 =?us-ascii?Q?JztDELJHHEmFWmvMYYoQB/+RuSugIJWRQXqzTVJk8EcpUWAzdlML/xrdVMIR?=
 =?us-ascii?Q?6LAHD+Srl18mYZHN8RiKYMIrUNruM7nW3yED7WfNCfobz1Fe6H2kk1nspQUg?=
 =?us-ascii?Q?C13MIjR4Ff8hORTO+wI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf588ae4-de93-4f99-7821-08da9f58b63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 00:47:38.9231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zar/fKcb0cRCtnQj/yDJ5gowebrIQXMT49frLuS21VRDj28VqbWcxYuqkI844k7xLg8Z5SeP5UBhnaJLImKExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v8 0/4] remoteproc: restructure the remoteproc VirtIO
> device
>=20
> Hi Peng,
>=20
> On 9/21/22 16:07, Arnaud POULIQUEN wrote:
> > Hi Peng,
> >
> > On 9/21/22 10:54, Peng Fan wrote:
> >> Hi Arnaud,
> >>
> >>> Subject: [PATCH v8 0/4] remoteproc: restructure the remoteproc
> >>> VirtIO device
> >>
> >> Sorry to get in at this late time, just try to catch up.
> >> Not reviewing comments, just have a question, Does remote core
> >> firmware requires changes to use this new feature?
> >
> > For this series, it is not.
> > For the whole work, it should not, but it will probably depend on the
> > evolutions related to the reviews and requirements that will come.
> >
> >> Does your 4 branches listed below still work with linux-6.x?
> >
> > I have to rebase them. Today my github branches are based on v5.18.rc1
> > I plan to do this end of this week or next week.
> >
> >> Could the multiple vdev still share same mbox channel?
> >
> > Yes I'm trying to keep the legacy support of the mailbox in the
> > remoteproc platform driver.
> > If no mailbox is declared in the virtio subnode it calls the
> > rproc->ops->kick
> >
> >>
> >> I not own i.MX remote core firmware development, so if no need
> >> firmware change, I would like give a try and see how it works.
> >
> > Great! That would be nice to have your feedback.
> > Mailbox management is one point, I'm also ineterested in having
> > feedback on the memory regions management I will ping you when my
> work
> > will be rebased on 6.0
>=20
> My github branches have been rebased on top of thre
> rproc_next(1d7b61c06dc3)
>=20
> As a first step you should be able to rebase on my step4-virtio-mailboxes=
[1]
> without any update of your driver. If I did my dev well, I kept the
> compatibility with the legacy.

Thanks for the quick action. I will give a try on i.MX, and see how it work=
s,
but I may not respond quick.

Thanks,
Peng.

>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Farnopo%2Flinux%2Fcommits%2Fstep4-virtio-
> mailboxes&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C50e9c0e75117
> 4c09328808da9d4bab9b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C637995245590228209%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&amp;sdata=3DJbwa0aPM4aoR8H1cyTLFKw4lK9VUcCyHwzkleVsnkRc
> %3D&amp;reserved=3D0
>=20
> Regards,
> Arnaud
>=20
> >
> > Thanks,
> > Arnaud
> >
> >>
> >> Thanks,
> >> Peng.
> >>
> >>>
> >>> 1) Update from V7 [1]:
> >>>
> >>> - rebase on rproc-next branch [2], commit 729c16326b7f ("remoteproc:
> >>> imx_dsp_rproc: fix argument 2 of rproc_mem_entry_init")
> >>>   The updates take into account the integration of the
> >>>   commit 1404acbb7f68 ("remoteproc: Fix dma_mem leak after
> >>> rproc_shutdown")
> >>> - add Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> according to reviews on V7
> >>>
> >>>
> >>> [1]
> >>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.
> >>>
> org%2Flkml%2F2022%2F7%2F13%2F663&amp;data=3D05%7C01%7Cpeng.fan%
> >>>
> 40nxp.com%7Ce0e5200d739a48e7439508da87599d14%7C686ea1d3bc2b4c
> >>>
> 6fa92cd99c5c301635%7C0%7C0%7C637971116202643149%7CUnknown%7C
> >>>
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> >>>
> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D77pEuwAI7Lh61hx1%2B
> >>> Hs79Cu0G5KOa6mzQ0PnTC5r8Xk%3D&amp;reserved=3D0
> >>> [2]
> >>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> >>>
> t.ke%2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C50e9c0e751174c
> 093288
> >>>
> 08da9d4bab9b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637
> 9952455
> >>>
> 90228209%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> iV2luMzI
> >>>
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DbF
> M3T6bY1c
> >>> p%2FvyRyZo6mdXGeN7%2BTCMfcmeY3OFpksWA%3D&amp;reserved=3D0
> >>>
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fremoteproc%2Flinux.g
> >>> it%2Flog%2F%3Fh%3Dfor-
> >>>
> next&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ce0e5200d739a48e7
> >>>
> 439508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> >>>
> C637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> >>>
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> >>>
> C%7C&amp;sdata=3DiWUSzKkN9BpHwqbO62awIcyVf9PXcftcdt2kytWVR78%3D
> >>> &amp;reserved=3D0
> >>>
> >>> 2) Patchset description:
> >>>
> >>> This series is a part of the work initiated a long time ago in the
> >>> series
> >>> "remoteproc: Decorelate virtio from core"[3]
> >>>
> >>> Objective of the work:
> >>> - Update the remoteproc VirtIO device creation (use platform device)
> >>> - Allow to declare remoteproc VirtIO device in DT
> >>>     - declare resources associated to a remote proc VirtIO
> >>>     - declare a list of VirtIO supported by the platform.
> >>> - Prepare the enhancement to more VirtIO devices (e.g I2C, audio,
> video, ...).
> >>>   For instance be able to declare a I2C device in a virtio-i2C node.
> >>> - Keep the legacy working!
> >>> - Try to improve the picture about concerns reported by Christoph
> >>> Hellwing [4][5]
> >>>
> >>> [3]
> >>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.
> >>>
> org%2Flkml%2F2020%2F4%2F16%2F1817&amp;data=3D05%7C01%7Cpeng.fan
> >>> %40nxp.com%7Ce0e5200d739a48e7439508da87599d14%7C686ea1d3b
> c2b4
> >>>
> c6fa92cd99c5c301635%7C0%7C0%7C637971116202643149%7CUnknown%7
> >>>
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> >>>
> iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DoPWSfUweLdhUFK5X9
> >>> 2YcGHem8s%2Bfelcr%2FHx9JAlKG%2BI%3D&amp;reserved=3D0
> >>> [4]
> >>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.
> >>>
> org%2Flkml%2F2021%2F6%2F23%2F607&amp;data=3D05%7C01%7Cpeng.fan%
> >>>
> 40nxp.com%7Ce0e5200d739a48e7439508da87599d14%7C686ea1d3bc2b4c
> >>>
> 6fa92cd99c5c301635%7C0%7C0%7C637971116202643149%7CUnknown%7C
> >>>
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> >>>
> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DHPpnlaykes8R1Kz1dEN
> >>> nirEHkDNr7JvRs%2FcsaDPuLdI%3D&amp;reserved=3D0
> >>> [5]
> >>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> >>> tc
> >>> hwork.kernel.org%2Fproject%2Flinux-
> >>>
> remoteproc%2Fpatch%2FAOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E
> >>> %40cp7-web-
> >>>
> 042.plabs.ch%2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ce0e520
> >>>
> 0d739a48e7439508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> >>>
> 7C0%7C0%7C637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> >>>
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> >>>
> 3000%7C%7C%7C&amp;sdata=3DGtNruefDreOoogL%2BlntAC7GBfk6E1Goq4j%
> >>> 2BYXt36RdI%3D&amp;reserved=3D0
> >>>
> >>> In term of device tree this would result in such hierarchy (stm32mp1
> >>> example with 2 virtio RPMSG):
> >>>
> >>> 	m4_rproc: m4@10000000 {
> >>> 		compatible =3D "st,stm32mp1-m4";
> >>> 		reg =3D <0x10000000 0x40000>,
> >>> 		      <0x30000000 0x40000>,
> >>> 		      <0x38000000 0x10000>;
> >>>         memory-region =3D <&retram>, <&mcuram>,<&mcuram2>;
> >>>         mboxes =3D <&ipcc 2>, <&ipcc 3>;
> >>>         mbox-names =3D "shutdown", "detach";
> >>>         status =3D "okay";
> >>>
> >>>         #address-cells =3D <1>;
> >>>         #size-cells =3D <0>;
> >>>
> >>>         vdev@0 {
> >>> 		compatible =3D "rproc-virtio";
> >>> 		reg =3D <0>;
> >>> 		virtio,id =3D <7>;  /* RPMSG */
> >>> 		memory-region =3D <&vdev0vring0>, <&vdev0vring1>,
> <&vdev0buffer>;
> >>> 		mboxes =3D <&ipcc 0>, <&ipcc 1>;
> >>> 		mbox-names =3D "vq0", "vq1";
> >>> 		status =3D "okay";
> >>>         };
> >>>
> >>>         vdev@1 {
> >>> 		compatible =3D "rproc-virtio";
> >>> 		reg =3D <1>;
> >>> 		virtio,id =3D <7>;  /*RPMSG */
> >>> 		memory-region =3D <&vdev1vring0>, <&vdev1vring1>,
> <&vdev1buffer>;
> >>> 		mboxes =3D <&ipcc 4>, <&ipcc 5>;
> >>> 		mbox-names =3D "vq0", "vq1";
> >>> 		status =3D "okay";
> >>>         };
> >>> };
> >>>
> >>> I have divided the work in 4 steps to simplify the review, This
> >>> series implements only the step 1:
> >>> step 1: Redefine the remoteproc VirtIO device as a platform device
> >>>   - migrate rvdev management in remoteproc virtio.c,
> >>>   - create a remotproc virtio config ( can be disabled for platform
> >>> that not use VirtIO IPC.
> >>> step 2: Add possibility to declare and probe a VirtIO sub node
> >>>   - VirtIO bindings declaration,
> >>>   - multi DT VirtIO devices support,
> >>>   - introduction of a remote proc virtio bind device mechanism , =3D>
> >>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> >>> thu
> >>> b.com%2Farnopo%2Flinux%2Fcommits%2Fstep2-virtio-in-
> >>>
> DT&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ce0e5200d739a48e74
> >>>
> 39508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> >>>
> 637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> >>>
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> >>> %7C&amp;sdata=3DXtF%2FQnml3QXFL7rgqST1Z2FotUzoj%2FD57WfiuAVM
> nr8
> >>> %3D&amp;reserved=3D0
> >>> step 3: Add memory declaration in VirtIO subnode =3D>
> >>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> >>> thu
> >>> b.com%2Farnopo%2Flinux%2Fcommits%2Fstep3-virtio-
> >>>
> memories&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ce0e5200d739
> >>>
> a48e7439508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> >>>
> C0%7C637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> >>>
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> >>>
> 7C%7C%7C&amp;sdata=3D6gq28c6a1TJ%2FdkvokcEjgy6FKQcKTXSz%2BNAbJPo
> >>> mjac%3D&amp;reserved=3D0
> >>> step 4: Add mailbox declaration in VirtIO subnode =3D>
> >>>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> >>> thu
> >>> b.com%2Farnopo%2Flinux%2Fcommits%2Fstep4-virtio-
> >>>
> mailboxes&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Ce0e5200d739
> >>>
> a48e7439508da87599d14%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> >>>
> C0%7C637971116202643149%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> >>>
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> >>>
> 7C%7C%7C&amp;sdata=3Dwfy2euuOPoMmBMIH3BOsGcsEYGSTWsDaRr7ENN
> >>> QCK70%3D&amp;reserved=3D0
> >>>
> >>> Arnaud Pouliquen (4):
> >>>   remoteproc: core: Introduce rproc_rvdev_add_device function
> >>>   remoteproc: core: Introduce rproc_add_rvdev function
> >>>   remoteproc: Move rproc_vdev management to remoteproc_virtio.c
> >>>   remoteproc: virtio: Create platform device for the
> >>> remoteproc_virtio
> >>>
> >>>  drivers/remoteproc/remoteproc_core.c     | 154 +++---------------
> >>>  drivers/remoteproc/remoteproc_internal.h |  23 ++-
> >>>  drivers/remoteproc/remoteproc_virtio.c   | 189
> ++++++++++++++++++++---
> >>>  include/linux/remoteproc.h               |   6 +-
> >>>  4 files changed, 210 insertions(+), 162 deletions(-)
> >>>
> >>> --
> >>> 2.24.3
> >>
