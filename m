Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF94B6D8F06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjDFGCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbjDFGCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:02:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0C45B8E;
        Wed,  5 Apr 2023 23:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S40zGG2clxY5hnRnOp0G4iwykiSGmnXoKWi8zPJYJIY1McWYm54Q3GvDIaadOXEd+gkRTkWxs3PPqdMGlNmjlPjlPx4J80Zq7S6EqqLe4yWsvtWXE+fssdWe9UL0TKwDOA3HA6QdzodO38U/0m/01EH7hg+xx3Zev9q6OkDBUrvKTCsWiRCiGySLiQjGzbAaiNlk78UTd0L38xEWopcno5LQmPKqRH4A4Ro+nwDkv+xLINGOnke7zmZAc8XqdlzVIlMu+1Oa2tcvRhdPbn9O2ITZIekO+Sf2tIjrD31/4XFNvDp3CUZ79btptbHfu3wGC7ir1PI23DQfW36XUt64ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbVnsg00lDRxh6pok1bJB134F3OtcMUTTiijT3Np11k=;
 b=LF61KATAW9U2joHIAZOTY+a5PGeu9EWl9++IHphsysmt3mcFkpP7gLmEijwQ/hd5OVVLhsnoZIuozu9q9q0WrUWUlJmqFE3phfcCU0a/GnQ3KTLKtMhf0L9FHF9hMoPVVh4Cr9yu3NG3fN0dMKOnp0+sBuoAnWXimMBGApyZgJp5yvHIvwaNw8XCNpFoinhdSYD13ONEq38I+d5808hh06VIyEsjt7KLVEwXuRhUidrIboQWf50Hb46D3b1Zen7538zoKni95VsL0IfsI10QbB7KNkgpTVBx0BJues+rVtLhK+BRjH4tgF6Ikh/J28eNOAVv/bwwlcrmBkU74TisQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbVnsg00lDRxh6pok1bJB134F3OtcMUTTiijT3Np11k=;
 b=DguwAJ+zGxjw4n2AwwG9qMGrCc6CMvmUmfB5HUjdAgr3c0IJzPDTy/8V0NGLb6SnLwFMY3LA+61rVq8PLRbhBbxqKfOSajXS/af3exwHUG43OUmFUQLjctzc9TsxdIuhqrfuqAj6X3gJLYD289zhoUijkFvQS5RzlALSlBIqe2jctkPnrtH/rM5rjLZc3CtzQVbdoql66K+DrIgFPmo04iNL/r+xKaUnCs/l/dPuTFl3x7x0J2Ak0Q1fUvPvxyS/j8IMRgjU00CW4azHu+fNpxjxaARTq33c+w8toEKK3kYFYtg0xSwO3+v6vP61HZVKVTngLmvOUAS1Rs+NcQZJpg==
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::18)
 by AS1PR10MB5165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 06:02:27 +0000
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a]) by AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a%9]) with mapi id 15.20.6277.028; Thu, 6 Apr 2023
 06:02:27 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 8/9] tty: n_gsm: add DLCI specific rx/tx statistics
Thread-Topic: [PATCH 8/9] tty: n_gsm: add DLCI specific rx/tx statistics
Thread-Index: AQHZZ570U2xLhGjQz0qrb7IO6krg+q8dy3xw
Date:   Thu, 6 Apr 2023 06:02:27 +0000
Message-ID: <AS4PR10MB58956DDD178D33EC6CA3A73EE0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
 <20230405054730.3850-8-daniel.starke@siemens.com>
 <6db04388-7f41-86b-a3f-29b2ccd9b51a@linux.intel.com>
In-Reply-To: <6db04388-7f41-86b-a3f-29b2ccd9b51a@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-06T06:02:26Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=ac20da5f-68a0-4244-bc91-206064d8fd3b;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5895:EE_|AS1PR10MB5165:EE_
x-ms-office365-filtering-correlation-id: 70ad68f1-58e0-4c58-aebc-08db36648033
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJGL2lH2HwEjdz95UD9LkGx6wXfXFuMObK7KulV3Gw7NtfnDKROlstfQCnHBYJTPwISobD8QD2s8CuN/jwEy+KYFwNDUEi4EpoPHvdB+kDfRQbjIrINdzo7TXHrVV0Aj3DSOBqe7jcFqkuLpUjH/UvxU0Q65LAp8bGsgD/QGKYUQU7ldwWn7szwd3DNCPLnP9JMcKUoKAKtrCCgBC4YWvnx4vBmlOifSUZYSzJZOmA7g/XI98CQtI7S/4gCnxG/kTQoSN2oKTb940lryvwvOTY/5ZtSESKtayqcQe078VTSBaAwrWymKBiDHWoottTSPkT6TA3ZXjPDYSgVBtlcDCpYGHchqVnRqC8JpOXd2piStmbnQbcE4YXshtzgWV3Ek0xMQEIk7tYKsYb8Kf3SXXLPSkV7uQW6SE8aL36CLG0JSZaGg8lKep0rG4LSlu25H/OMC+0qjDh0pTdxD3q2gfyQxnuSFSXA8nKPBrHdlmIcofrmjYn40AUBtlL/W/c80JgvvtDfpieAqd+iUwLVzkl3KFLDUkXGw0jgedBxAJ+edYtt6IX/3Dh/PNBfFGxc+5D1W14nvCBkz34NjP9Jimoj3XX33DBhQBvzcSr/nvzi3SYVj9avj0gxnetIJqHZh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(71200400001)(55016003)(2906002)(478600001)(38070700005)(7696005)(6506007)(54906003)(5660300002)(122000001)(41300700001)(4744005)(9686003)(8936002)(33656002)(26005)(186003)(86362001)(316002)(52536014)(82960400001)(6916009)(4326008)(8676002)(64756008)(66446008)(66556008)(66946007)(66476007)(76116006)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xTZdQEYaYNbgn8BlO8++JVRsGUldjedYXGEEmlk8tqyZnsaMWrF7Od28g4?=
 =?iso-8859-1?Q?33LP1zs+/mjNTmmplJlO6bT9UVA5l2RMd/T8DI9h2uBokqXwXcErrInpVG?=
 =?iso-8859-1?Q?dHZi3QhsdPJEcTIU5zFJ0Dp17NDavDaYDvm+A2oBa9c0jqLptcDzmVMAUa?=
 =?iso-8859-1?Q?wrW8ySW6Mh1h+BmbKucOFj4Zgnbz+UGpj106LMG1UyUWk3JqNmWLg6uHiD?=
 =?iso-8859-1?Q?V/vtzQp8bs8A5aqHYkCBGWf8UINDeUfqx1viz374Pcj8Ncl4e34mh3vZn6?=
 =?iso-8859-1?Q?d9XcmxUcV7F987lICPgct65c+aOtnXZFH8NjPuBLJce3nGuQLlhhgDubLr?=
 =?iso-8859-1?Q?mVGFtpGzB+IObHo1mxm+eNQ5F7XLqLmzGYE6Ye38J4WBJRrk957C0Mx96Q?=
 =?iso-8859-1?Q?Xvv4aavLRCOF6lZkExCuU0dFNYAPVtQ0I6Sc2Fwu19cYsBElf4TUcztcEV?=
 =?iso-8859-1?Q?7bYjMAAsjI2fK8hBuypSW6NlN6BTYkeBV/uhJC4lOJb4UqLa8Bx7nI/0yc?=
 =?iso-8859-1?Q?vQtGbRkV8r/wFNzmoREEk+pV0FYuO+60jvZYqwspfIIHfkx+rSC6j7n8VT?=
 =?iso-8859-1?Q?oKEC1+eUEfvrn7g3TqxgGBIYTTaw9o6a6z8E0e4gz1vZNqJg+dWs3sURmL?=
 =?iso-8859-1?Q?ms0uyRgcBo3387Y8yX1wYAEBIzP6pzbs4hQzs4DfTGeQZIX/H6hdZJuiun?=
 =?iso-8859-1?Q?LAO4AFCIUvBnDMgsMerx66Cn6KpnbUeE04pt6oUoNrPvnKWBnUevy0uK2q?=
 =?iso-8859-1?Q?CtTy0Z1WyfVBj2V8vw0tPIqFkneyYRENwt+4GIUvaxb2ms8suFHik2XKnT?=
 =?iso-8859-1?Q?QFwqieRyXY1qVGIAl95grt43oRfGTu9/VQgdoqgfXAHJ8/Pu5CxxuhgmvL?=
 =?iso-8859-1?Q?N8BpdPGUjcBAPnAwNw9Iw3G8zqPdOM9b/BGyW89xjuBTPjUSbiB/DCP/aq?=
 =?iso-8859-1?Q?zfxyqm2XtciXfLYzlHxx2Az10xEkDS8SUlACHUw7I7lyJWpfxiDSSnL7GI?=
 =?iso-8859-1?Q?oK9fLOM25nr2Su6oIMceIGYXBy+xWGQVmmXYFIJSm5HkPpZtouPb3dS+Ny?=
 =?iso-8859-1?Q?ztgRMEbXI3TKYCCEiDdqSE6AcLnqeE7s25PsZLTB88vmoAAzViNeY0wNTs?=
 =?iso-8859-1?Q?qMms1pLhoeCNlY+drxC0UpFXNtWx8Do+CypT3PS4EgbxYFklzX22+Xgr2c?=
 =?iso-8859-1?Q?oV4VR4oY1k8eWkMAdJ1JT0qC04ub89J0mRgCrirY94RhpMNMOQ7A2/3MyV?=
 =?iso-8859-1?Q?pNZGTdeR0s4aMAP7iZf+jo3SGYwgMw0UeKp0uUFkn+1q6PY+I3O3MqvNsH?=
 =?iso-8859-1?Q?usjgnf+KBVPycNQ3DNXJaY10CCbjBjFXLcGBw39YW87ayATIr/Iv4IUSqI?=
 =?iso-8859-1?Q?A7anMcXoJ4EUfTd/2b6JgKS0c36A+suQVbpEIjkIKxDQaz0KBSuSeg+R6N?=
 =?iso-8859-1?Q?r1GBtmhu3nR1nBYrOq8TkmoknZpL3dBxRV2qR4veaUisYNszAhh/A0iSPQ?=
 =?iso-8859-1?Q?8Uzn2UA7CTpM+KdpFH7446JXTON8GfmBtR+P9bjpBE3p7EjocHYd32lxsS?=
 =?iso-8859-1?Q?jT75j06fvqmprW+Gtdqm5zb3T3g3PofXDZ2pqQj7N0IQiTfd6ahNSKH4tb?=
 =?iso-8859-1?Q?MY5s+v3dCW2KppVSRFc7qCplkX51Ij+OaN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ad68f1-58e0-4c58-aebc-08db36648033
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 06:02:27.8453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWDNrG1WeNEhnKDYVfsnGrGpBLB/p33EXXP3lTyuWsjUnAE1MKKwT+x1PJnDYVM/dOuDWxm6b5PYfQtHl8aqr5y3+niFZUdQwOdqjtB1Za4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5165
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -1215,6 +1218,7 @@ static int gsm_dlci_data_output(struct gsm_mux *g=
sm, struct gsm_dlci *dlci)
> >  	tty_port_tty_wakeup(&dlci->port);
> > =20
> >  	__gsm_data_queue(dlci, msg);
> > +	dlci->tx +=3D len;
> >  	/* Bytes of data we used up */
> >  	return size;
> >  }
>=20
> Reading the function comments and your changelog, I'm left to wonder why=
=20
> gsm_dlci_data_output() is supposed to increment ->tx but=20
> gsm_dlci_data_output_framed() is not?

Thank you for pointing this out. I will add the part for
gsm_dlci_data_output_framed() it in the next version of this patch.

Best regards,
Daniel Starke
