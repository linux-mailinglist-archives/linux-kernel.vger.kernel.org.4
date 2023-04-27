Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D936F037D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbjD0JjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243001AbjD0JjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:39:03 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA852684;
        Thu, 27 Apr 2023 02:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCo+Zd5fWPVp9NgWsF0fhGk4cibvQ+IAsXyQtFXMiXKwoGg+D4Yht3zi+1rH2AXGKbRqSr0MpcoHu2D8vSMyOkGuwaJYIBsuB9QYKic2H/+vmIph0pa6DkAV32cqEDBQ5+dmdu9wBJ9kMheJAsvyFiUZ2b9vHHC1UsdjLxfzV+YZCOC7X8yx9JmZ8tNX/5X76z87sO7uzry/f0FpMd0qJNkpd3EtwIrrhR2SJwZII2wCczVNirb1oLKr+LFxJVtZZMK3jynCPIYY4hKJZBYKhCjszm5zHSRowtRsprDTOw2dZY4NS6vsGDPqtP1Gs5ZPQJvMQxj6STf8/8fHQX4Hfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzdcrPUJxbzKmtqlxUg9lFX9t3J7w7EtDyVdyfDF0f0=;
 b=fzRqTbaK1GgB1gJP3HWasIGVdIVPH/h0oRFp6y542YzhEEbw2cBpY6JH09JvlZLUam32JVmG17riytYgK/clHhCQes+AdWHsGvXRj/BJGgYezZH0sXrdkaObqfvjzsVNrEFBJT1KG1mW96COmu6zgmu1Rm/4fsPxbmn3/MoUhjZ1y+CTokHEvwUPdB7FJi7AY+V/dOqafeFonLfX+VW8Uk5BrQIt51SHvcj85q+QlvHWubsghbFs1GyKZjy85YP0P1b9gDLGxQxlEQKJjOvWTwd7zc3YVoz2CdeDvQ/rhEDAIy7AUTCfVxZYirit+42NCuKu610yNh9wivGujdOC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzdcrPUJxbzKmtqlxUg9lFX9t3J7w7EtDyVdyfDF0f0=;
 b=IuoUPrZvuGSR/7aqDKgaP1nKZITAiUZLe/8/96GRj1GUkIwA7aWbLeslGUObLlSpn4KhYAMYcD4PfX7jeOYk6LfxAbbZnwCHOJfO9a8MH1BJU/Ez3VyhUUF0Aq7MGIgBWVsNYCLNpaCVZsWu2O6yWy2oZ5bcgHnCPbhQ1ae3N+q+e+JwKZlcdSNhZ+NjhIFy6fHQpCxWBkIDEf/7fAhpNHTCmJsYWiH6aw1gHOdXz3xOTB3EK8KrQDd0d/k4fEJW7StDubyZweqqFQr9+kNFf/ecum20A4qTCtqPWZ8AMnicHrCMGU7YGV8bzeL6NpqSqZCr/Th6LZbbx1RiaA/xDw==
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::22)
 by PAXPR10MB5613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Thu, 27 Apr
 2023 09:38:59 +0000
Received: from AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cfee:a2b0:879d:f8a1]) by AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cfee:a2b0:879d:f8a1%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 09:38:59 +0000
From:   "Bouska, Zdenek" <zdenek.bouska@siemens.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Topic: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Thread-Index: AQHZeDcurMHHnME6s0CFTE/AvBQiT68+HAKAgACwhUQ=
Date:   Thu, 27 Apr 2023 09:38:59 +0000
Message-ID: <AS1PR10MB5675F26ADC112F008B52F195EB6A9@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <87pm7qxrg6.ffs@tglx>
In-Reply-To: <87pm7qxrg6.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-27T09:38:57.511Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5675:EE_|PAXPR10MB5613:EE_
x-ms-office365-filtering-correlation-id: f85ebe53-f54c-4a7c-ee42-08db47033ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owk8r/PDfxKpmBwfvSOzWq+ZfkwksBTiQSIwrGeDm8IFXbQ9ZokyOfuKuHsrjWZ1knSu9o08o3kkxTqV+WkawZ+ME0BY5Xmzu+ZzaZS7EQ4CTjyxfbQ00aW33KeFbejI5wrkYXMEQaJilNetjnRleHw0RPiY3Py0tKY1+LTOybNNtG0Eip21Lv1O6MhxcFR9KfZaL5F7peRgNke9pTLq0t5TYouATCubQ5Omz6K7lgCSHGabBuNJy4LcgOWobhy7p1BLtB/DbowMOj9dlCj2TdyKAepLpalD2ekafCV+gAlMCxEyzhscLThCQHCcUtgi7yzWFqW9mzv3OAJhpPK9p9GRO/dT/RjtplbmNMLN+ZTKOCU16FuUnTcUjqJlxcoh3APRLX1N290C6yvOkE32/CDb/2TXuF29FobRcKPBVdfW7uRmN2JvoM1YRPIZK3ILAUwDZEU7XqbTCOGVFsIiVhOaKfmsCWlrVEqvSTvm5BCjjQhkgSZfdAOSCuizGX6q2Zs/lrkSIR8lfFwZyhoUOKoOgk7SSMNnDs+TgwhdcTWp9l+3HK4Qu/xwPqpKd1A1U48RNM0AN9RoTAA8XRiCyX43l33ImeHou9UfuiJDE2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(8936002)(8676002)(38100700002)(86362001)(64756008)(316002)(4326008)(66446008)(66946007)(41300700001)(82960400001)(66476007)(66556008)(55016003)(38070700005)(9686003)(5660300002)(52536014)(2906002)(4744005)(6506007)(186003)(33656002)(966005)(7696005)(110136005)(91956017)(122000001)(76116006)(54906003)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?D+XvFweK61IfCGaSQmPtR0129ruzOSkb1VMszIzTFRM9cAHPqSrvIdhEPN?=
 =?iso-8859-2?Q?++0DjB30WA0zRiYOtnXXaR98DEwrJVaPJKMK/0+RGb2w0HNjO9sOhfkAwV?=
 =?iso-8859-2?Q?C0Uc9gDII1jDvBSt4CFZPdFKsdovpMR9fdsc9wr2fcMzoH1xSi3jzag+S7?=
 =?iso-8859-2?Q?QrRhGpoEpLKYTqqZ/0m69Zro6OUxeSv5EFqnA5d/r7LAzNuvSqTBGnEDVn?=
 =?iso-8859-2?Q?R2jBX1hnFJ6qlImxSnoV16/zzJK2GCYJtdL4W/AfJHBDgX6l8Z5vsK5uUj?=
 =?iso-8859-2?Q?/lqTfu3a9nvuXXCL03chkTr25hsuRMwFZFD0gEmyGVm5HF2DLm3NchhApS?=
 =?iso-8859-2?Q?8VaOi2l0oiszgMTza2gsAhKHA2hscG9X1oFQfmxGiQQdSiLuianHnYCRhI?=
 =?iso-8859-2?Q?Cb2kx63vKv3JwKbZFsvmFBSzE4T1yXVLmiAtRavxQDcFGLuRfcnnps8Xvd?=
 =?iso-8859-2?Q?5ADhD4wQKQzKRXb53tnwQ1BSR/UGApLfqIiuBbD2QugxaeJLPqC4tdhxFP?=
 =?iso-8859-2?Q?CH7i/8KI+8C6tcltyMY26Lpb/kDmghC18Q++zBGLPisc5mOzQ6hd0BcS2E?=
 =?iso-8859-2?Q?Lti/Go5iGseC7zGCk71lk6lZXSJCj109aCstatrPFL7J9ZC/8Bc4eyighT?=
 =?iso-8859-2?Q?h/Tkry6S94JSkZQEjFxmnwsty5Cyoh8rP6rKro2AxaUmd22MWRybXQrfUz?=
 =?iso-8859-2?Q?mwv0yIlYECCpNaNkIh4+4jes8ssq7wUA1O1IOZTm0E7WQx1OMvpErgSyJU?=
 =?iso-8859-2?Q?p40SgrLCwAhb3iMo8yomjaSWH5YYIqTBvFUTf6xIXHPRN4h5ddq3ZEgN9F?=
 =?iso-8859-2?Q?7xxxzaPkl5NjdKFhE9/gkxfAfCQa0WfvHq8iXnT3oqG+q9vTniwfdX5zgK?=
 =?iso-8859-2?Q?rOHXxU96SvdC2V00D2/rpxidaVl5LgCmpXzCNYsafazdwD193xCgNSuu6F?=
 =?iso-8859-2?Q?r+kn0b5YcVwoG4keTGrr4zHm/0OxOqchsHA3MJW51I7jbQbaCWO5k3hwp3?=
 =?iso-8859-2?Q?IPfcLeT4SPV6XfJAvUK+UivrwMRIAFXnv8bhg2BUmkYjgRIfWF+l9Ol+HO?=
 =?iso-8859-2?Q?6SoiRKuvQmOYfdXg5ZtI8Q/x1pT5TReaE/Fswd83fJWQMWW8ZxyKW1HZxx?=
 =?iso-8859-2?Q?jMdiqzKSB0mFGFNdxlDhrphIh90WEGwgSSmX2ZNyx0N/mMFBqiJGsEogj7?=
 =?iso-8859-2?Q?yTYPhbnwCwDJtZMlSuP+N2laRmjf/mFOm38Or8K62CXxk+E4UJfoS/GjS3?=
 =?iso-8859-2?Q?S1Y3Dmb8TO7NP/oxjueWsUwykH6F13pRAyUMIgX/ZyVJJmvNOv+QpcWc0I?=
 =?iso-8859-2?Q?MpKI8Blr1th8Ldx1Jg5dZQ5FtrK2VXAwdNDJF4MR6NWE3AzFw3nZknGG5z?=
 =?iso-8859-2?Q?6ZcTWQ2VuLrEZ6+9WfRWThYj7UUct1sN7oUv7Qc4Ewv9gjh9KQibaTtXqq?=
 =?iso-8859-2?Q?J4aNgqNEl6SK1gpQml1FXsavWti3bOLsnAbSCSPpKMbONgKTJI2pCL6zmE?=
 =?iso-8859-2?Q?JuEylonQZGU0x1mG9xZuLhHNhvpnY9Ef87VkQ43fv8KHUKkg8t8IPNEtmh?=
 =?iso-8859-2?Q?wmOLyr9KMo5DRkWr0gNLpF6ACq9RcF2o33SbYQlc1C0qU4kqMo+K6LOU5A?=
 =?iso-8859-2?Q?agHKOztzfFCDqytnGkDHz0hwFYruMUPhL6Ms1h1rSdn2Sc8A3enQtp1PLo?=
 =?iso-8859-2?Q?0JbuDlk+klRla9VpH18=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f85ebe53-f54c-4a7c-ee42-08db47033ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 09:38:59.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPJpVLpx5vyaFkEfdIXBVyDCAzJHeBU/ossZ4qR0zkwnVt5QsVl+kPmdxKPVT54XgQQ9WPYiWi1shyIy1hGK4ZZw6Pnwcdzaua8XHXojO54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5613
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is this interrupt handling specific? Just because it's the place=0A=
> where you observed it?=0A=
Yes.=0A=
=0A=
> So if that helps, then this needs to be addressed globaly and not with=0A=
> some crude hack in the interrupt handling code.=0A=
I just wrote, what helps for me. I didn't mean it as a proposal for merge.=
=0A=
Sorry for confusion.=0A=
=0A=
I tried using Will's cpu_relax() implementation [1] everywhere but I was no=
t =0A=
successful with that yet. ARM64's VDSO makes it complicating and even=0A=
if I left original cpu_relax() just in VDSO, Linux did not boot for me.=0A=
=0A=
Thank you all!=0A=
=0A=
[1] https://lore.kernel.org/lkml/20170728092831.GA24839@arm.com/=0A=
=0A=
Zdenek Bouska=0A=
=0A=
--=0A=
Siemens, s.r.o=0A=
Siemens Advanta Development=
