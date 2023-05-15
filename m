Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D74702ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjEOKrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEOKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:47:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on061c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::61c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13655187;
        Mon, 15 May 2023 03:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnEZNTBPdu9aJ60QKq8rRBbdxnlDEo7gw+lkwqIXfsWZUzKD+hzcSocNtPEWz1tkccnFBi8A0mDbV+vDyXS2wgXId3oHQzp2O20bxZXokJrlj5TSr5ebLhf+lPSFBiquGfXwngL8D+ENalNVnRdwn4HslE7cGpDyskfSej0/0VcAFrUtmwTCUHafA90vszVEYm3xVX5K6siek/Y4KXZV6j185sue55ygoLdNDIRdcXQjJ/NJ5zV+lZJGfyhPA28W/y7Wcw8Dek/q98xVMP/CRyYRqKolx5QnzZneW62p+K5N4MJf90HX5rI+Ah8kO7xVrPxRyKJRm5Q8nu7GNbCYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmJRmLifupbtDO7tmYkDXABzeWlxNc9wHSgtO7tcXEc=;
 b=Mm/RF4XS5Xz+T9CZAvda7nXW8CHI7gmSZmWcmPFmhdgacwPpL3AT6dhTMttX/BFKeHTNn8lbdNu0Gs6gdMDXiTQJ0FJgBCqGkrxumP043YKtl3avW0w5WQiYZhJ2vHjB0Z/+lmHHeZ7zbUeM6wX1APL8Egz19WkhyakVdJ87LI+O+Gk55T7+Pv5kZAjQCoG3c5MG6quVafjW0vwIurhf3VZrcaiiBCd+OdF6K5a+V7gkGkuNon46JSFGLj1j8q3JmAsXIWajFk++ukYaxzEzivVlmuvzT2ppUSmGMhW2mwLHIK+yETVR/pznmyfnhSf+ZxJmb2S9mq0c84US9dV3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmJRmLifupbtDO7tmYkDXABzeWlxNc9wHSgtO7tcXEc=;
 b=vTsGJGYjpC9/sPVXleIAjMVRGBc1DPCmySf8VYnB43MkUewYg/angsM9FfOulV4GcUwbaOQxa7B447icaDb1Mo1ebQjTmtQtiU0ZZzTJuR9afGpvY6DsIMaJCm5IRMxm2+UuhCaMUzykpfhDA7RlhRmLPaagJw08lffZ3RLlkJsr4MZaixwBwrjYGDth8X9RRKV1bjmnNEs61a1cSagsZYs5EX1OCQ+3CelA3QqkD7MdGeqNlxo0OzDpTl4Epi+PpklJiDJPq4Yc0mIj6T9vB9cCv10SQseMG1i7O0aqG8EqO8FGxDehF4Tv+lKdCh14bhY9flACtNhZvYVro9cUwg==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS1PR10MB5506.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 10:47:08 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d737:1f7c:45cd:b05e]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d737:1f7c:45cd:b05e%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 10:47:08 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 8/8] tty: n_gsm: add DLCI specific rx/tx statistics
Thread-Topic: [PATCH v4 8/8] tty: n_gsm: add DLCI specific rx/tx statistics
Thread-Index: AQHZhYYYCLQ+YJBTN0q8qs3db4W44K9bKiPw
Date:   Mon, 15 May 2023 10:47:08 +0000
Message-ID: <DB9PR10MB5881A7A09725EAF8FDB5F35BE0789@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230426080315.7595-1-daniel.starke@siemens.com>
 <20230426080315.7595-8-daniel.starke@siemens.com>
 <2023051332-ethics-renounce-b61d@gregkh>
In-Reply-To: <2023051332-ethics-renounce-b61d@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-05-15T10:47:07Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=f94c7f80-351d-4b17-8bfa-51865c981a78;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AS1PR10MB5506:EE_
x-ms-office365-filtering-correlation-id: b679b824-03f5-4f43-3913-08db5531bb3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DM2xEW3Wqr/tCe893tlvoG9MJK3NzvhdePas12awLh2u0Pf1/JN+mrcWhaJ/igU4FD8eD/bh0kSMmr1HxFrlXxFZVIy0x0OOKK4BPxmruGVBwAutXxzn2xQjXjzlqDpE5Udnu49QkW0VIrNywh19h8Xsfr5+oaDJqglpCRx8fL9MX7sVkUrkNnkUadpdFI3DZVPvkyyRvDXAxiYIfMR1SnMN2PcAlKu8VA/WH+1btl3dkZKszvivFy9j0ZpAFbreLUU16TH8wLiqF+EHilLPmhCKIyqUC5LXjs+moX6u0yQAq7LnhXzBclp2LR6XZ9Yhf4qv4Dt6frob2U5MoOnxXNuuAMQcO0Xa55MLYr9I7z2PXiC/TyPB/31eKEzKUNqaUQsTpFRtAjCcKhkrECY5wD7nsdOV0DyuHNmEXmme2LUStcHM072v4IbacNDJXruqA7ZAVVBTtbIFjBsEeJNmpGMFhLYE4lnLKnQ/dmsCIDv3xYfJqe5qJbEryJEOpAYFcQkp3EaWYqAuNvr5pOMP+WawqnWefdL2mL/6oz2HT9e38A1PCwm2N8ZQoJVqNeVmwmDbBD5WS8vbG687uYboeepefORcjVm0rzYGxE8AhOc5L/nGfHqRp5zuj1GCEUFP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(66476007)(66556008)(64756008)(66946007)(66446008)(76116006)(55016003)(7696005)(26005)(6506007)(478600001)(5660300002)(54906003)(71200400001)(186003)(2906002)(52536014)(86362001)(8936002)(33656002)(8676002)(9686003)(4326008)(6916009)(316002)(38070700005)(41300700001)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mqL5A7o288awYHac6WGnrm2RXQWJZE9m2ecHUoPcfu5FA4flSgXYF2Mr1LbY?=
 =?us-ascii?Q?lOGryCo/o4gHluSoVqDJEMl7fSJDlxZhEapOwKKvl6DUcLGd/UDd1GTnnsZn?=
 =?us-ascii?Q?DSUX6jK8Y3qJm2k0lzAtze0RKMQwL5n1kj8TTAui0c/b3U9P0ETtnMV8PLn5?=
 =?us-ascii?Q?qnWddscnBudxRdwhdWds5n6yGOY6XbE/sRdnBlhREG/yWfU0aCThs1CuBRgR?=
 =?us-ascii?Q?65XrqVwtVdNphPQyAZBJO1euk6T/GPRtejUQLemMAGTF8TqyhYQUfSc1dLMi?=
 =?us-ascii?Q?/KJNAbUvgo20ie6cYK6S51aFr1fggvSYdraDfW0AvNxg4XfejZBcWUeG/UH0?=
 =?us-ascii?Q?KOcQuBHxW2R/Eahv1hVWxRUGiJDDugCRM9d/Oq9KXxMSOswvKMbA5GAd3WXI?=
 =?us-ascii?Q?4oB9y/xp/ULkQHqfV/U+evatSTiXux+qhI6sL/deDAhTA81gkYWcInAV2Eol?=
 =?us-ascii?Q?3d6/cmdpcxhsO0BFQbAWDTFOsXMGWRXkByv1VyhCZQ6XSf9LlKgK9QDykIJT?=
 =?us-ascii?Q?UG2Y8IcFHaFzjCtwO0lwrlUIYgarvxQ9UqUXR3nxsHFbgu1yU+q6lp6AFS9Q?=
 =?us-ascii?Q?fZEkZ1xFvBVK/0RCRBhVeRKsrpscOyadQJWOsU3zWqqNy1mWMknCv5GccRGN?=
 =?us-ascii?Q?cMjVEDOX1+bLVb5VNY8IgyZXPZSrzBp+HXEJTR2VO35ZAGNuzMFTD86tHI2O?=
 =?us-ascii?Q?OswL7kVYPixY2wH0HFwUbW1uKrjFuXuiYpebAL+SfvYiMVsQsemsbbEIYXAm?=
 =?us-ascii?Q?T6JQH0fwhnoRdBYfj2/EgAXNpmTaAX/bEFfod10cndhUFwzJvU44m703mMSC?=
 =?us-ascii?Q?84sTxMwlVcFjiXxX4EAT7fseFkixSKOAHS8/pvhIl2EIlQbH5Ra2AjtNlVP5?=
 =?us-ascii?Q?yst4fYGdo6w+ZAMuCPRluG5c9z1VKBLeiA0XWDxHLjYFVL8cPlW4HRZ5kN8q?=
 =?us-ascii?Q?bmQuqYDZsOkwSNYtDtBcKYdiKIaix5En/d9hFBRwXASjEq9p3Obd94AdsWb1?=
 =?us-ascii?Q?tuwi6lxPVWAf+QVATcfZGWix2zTndP75uEIrARbviLRb96r94SW6XBhB2iUJ?=
 =?us-ascii?Q?fctTMnIn3loraL7Byi1826uE5EDGHeU+TEtgkIwEPaUaQf4Gv3ZyBxm4C//p?=
 =?us-ascii?Q?Pit13kOGPhRGL5d1a/zVLC3Qgq5q5Wl0MWckoyKVG7zPc3bVeKcaH2N/TXOq?=
 =?us-ascii?Q?UvOQ/vQkCJK9vhuUfnSp8ALo9MTQlLl/WOUWZ15moR602xhbj/HlmkbOqCJO?=
 =?us-ascii?Q?PyK3gqC+s0YzwLdfQciXQUd7LSkJCi3mwhkvvKRPMm/M25Psq9LTDdjf4Mp0?=
 =?us-ascii?Q?Vf/FAoTVJb/5emh/hHRlcNPxmQRxJPFhP7RMcK6tNrpw1PIxSaCoZGfe2Td1?=
 =?us-ascii?Q?S7UGn9otR+YfPwQhf+AGH/ZxM+NXpi1h6lOAUR3n2pfwiC2t3mnraNroHf++?=
 =?us-ascii?Q?us1zG6PkqMmtFAFA3So+Bwr/Rn550OcqIQbABBTnq5aiTDB6/CeWBn0bWdfG?=
 =?us-ascii?Q?FAZ+15ht3yllZp+jhVf6pGpHB0jcfVu2HVgmw90DFltbpDMIBucvzMjuLknt?=
 =?us-ascii?Q?MytJX4Ww7KThCR9QQzpv0mPC0oV5cgdpjDFLPj/3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b679b824-03f5-4f43-3913-08db5531bb3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 10:47:08.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llz0lBGg3bkNWVSYXCmwgeHKqqXJ+6ex1W3OmIEY40DKdLtLPh9ZbW99T25k1YbWwx/GkWJ5D9d0ttFpx/WCLx6VVkDe6tZlNhlSLkkTWd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Daniel Starke <daniel.starke@siemens.com>
> >=20
> > Add counters for the number of data bytes received/transmitted per DLCI=
 in
> > for preparation for an upcoming patch which will expose these values to=
 the
> > user.
>=20
> As this is patch 8/8, "upcoming patch" makes no sense, sorry.  Please
> either drop this and add it as part of the series that provides this
> functionality, or add the functionality to the patch series as the next
> patch in it.

I will add the remaining two outstanding patches on my side to this patch
series. The functional addition which exposes these values to the user is
included there.

> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index 62bff4474b57..2e2e1dafcf40 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -186,6 +186,9 @@ struct gsm_dlci {
> >  	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
> >  	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
> >  	struct net_device *net; /* network interface, if created */
> > +	/* Statistics (not currently exposed) */
>=20
> No blank line before this?

I will add a blank line before this one.

>=20
> And why isn't this structure documented in kerneldoc to make it more
> obvious what is happening?

True, it would be better if this was the case. However, there was no such
cleanup of this internal structure yet and this is out of scope of this
patch/patch series. A future patch needs to fix this.


Best regards,
Daniel Starke
