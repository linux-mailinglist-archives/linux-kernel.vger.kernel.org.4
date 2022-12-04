Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4F2641D34
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLDNWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 08:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLDNWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 08:22:52 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812010061;
        Sun,  4 Dec 2022 05:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670160170; x=1701696170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T41rA1X96fU57TlO2JNeyWNcsMvFEEPV8IgdV55dl00=;
  b=j5QWGBnb2BCv1VTTgN75O/D8rn0hXt2/E6Cm/KepAjbYpkMwI50MNypH
   mrVBaeyzVvApepXvsAVamgN07XsjK9qsJzPS6jyrB4K5ghr1iEGZIrtGW
   c9bHzD7zhzOlZjokHXOhZkwUuReXiDN2dwYjvgY4N6A8/cfgpyKf8U3wx
   y5sUvK5BHFLmUWTdObGIsEhEwH5Iib25SSWLJNfIHXB8kcqYXckX2ooVo
   lbCEr2hCUbAr8cQVMmihSUmDyFTbInqE0eLcEQHLMhnEhtiDRKK8PzPuq
   jQCLfwMOrSEQwEjV9qBkfEnmLgkhN0hC9Qmr6yM+wdb0izxKjOU9EuuFY
   w==;
X-IronPort-AV: E=Sophos;i="5.96,217,1665417600"; 
   d="scan'208";a="329950447"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2022 21:22:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjt8owU2GAeq90JbFCscY7+N7pvqrx1advNxOlj3z+MwGI9/00XxL9yD7y/F+U3TkfuO/3R3BdI9FFSzOmOkxEzCGvRLfEQFwC5vrp+TEKWOsHjIX6qLtlR74dPkn5f3/7FUw5OPTGzyrW5ugFF9Cs40nNqjkcNw7b/TmTIhkPh5i6bGHDSTv4FP0tAawo9CJfak5dJ2Ja0n1uGcp3ULluN4XtO6DPR3riQUx2H4Ftl1RsKPHMaZfc3PydkfZQIrWMRSoX+lgdujMGuh/Pz1ch79JGcTfkvG9yrgF9ok+ZrvWVvbaPrW3ou1V4OoPYrktuPCthA1TNJtsy+CyIIqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEJEpBlU5N4JiPLEMmwKzM3KJ3Oxu67zFL4aXb7mRGo=;
 b=XImup7mByTGPaszQHZbFt6yFAXwihVxkj7Cd/7UYQhrn1vg1SmYLxAYk1uXZ38rrbIlJO7FEfNHjRVRzCAWgt/+d0qrsAzbL0zmQW5gJWCIi6z3CphQ/XlY27nHXSZQMyQ7sTHKi8fijxocO3hlVABZgIGSLAlA7L0OP7figYt088qqKZzfgO98bnT6sCHYfotpXt5U26KjQuShSbR7Jns8cKIJ3nivng+rFs+jvbyNPj6G4YkSy4F0k7zo8XUYgd+NcxQx3NipOKEpp6YeJigkKc96yiStHi/pZOwQqcuSsAM0K/3m5RJp+m9MLMELnzuq9uj73wMOHaxrpJLhj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEJEpBlU5N4JiPLEMmwKzM3KJ3Oxu67zFL4aXb7mRGo=;
 b=aMAvi68VZZibcVcOdX4MGd2NCV30yPYPHvzBm3XnIuEbHoSzHAQsgk4xrpktsuqJ6/1Ra7WaqJ+wpx1CLrn12YhaBvAwiVhyUuMxJb7iGgPmwOdXgSIinrFVNACxd9LfSWaUkeWacWCsv/GGhb/PEJFEHx2SyUlevY0/WTKqhfk=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by BYAPR04MB5703.namprd04.prod.outlook.com (2603:10b6:a03:101::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Sun, 4 Dec
 2022 13:22:44 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::a038:ff31:3aac:992e]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::a038:ff31:3aac:992e%6]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 13:22:44 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/4] ufs: core: Always read the descriptors with max
 length
Thread-Topic: [PATCH v4 0/4] ufs: core: Always read the descriptors with max
 length
Thread-Index: AQHZAlj7k4GN9YfaUkugDTmI0A5hTK5dwfHg
Date:   Sun, 4 Dec 2022 13:22:43 +0000
Message-ID: <BY5PR04MB6327A3C457A16BDFC5C13ADAED199@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
In-Reply-To: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|BYAPR04MB5703:EE_
x-ms-office365-filtering-correlation-id: f225e2d4-f68c-4848-258a-08dad5faa0a5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMucA+26POtwtvFQj11bqoLR337eSCUtrhz/lwdME8VeV7noGLiwgzYzm5B0GmeyEq35ZkYHCYZFrkfkGgsJ3OXutiD1Va0AknCdcnGzu+R0XEb6AfgHwmGpK2srtbtTuR1+AWfkrcye3w1rog2556v4S2OWqJ6LaDx+VcaiqMraFzykh32k/DzTrgWgTKDYIal19jFoAmEfa/REuqH6Wp/T0YevRxX4g0MXAf8P/c2uWDKIfzinrrORVxxgDk3lb7W/AB+/yMdhoSBoT9VeyUeoQ/z9Qse1GC7qE2C3T8ATg7qiOS4+G71fOm+S8v0eagSJHhZ6pLYsTkCcl9TvdEuQLxsQ3J+E3wZUu1HVxCj61RYu4tbSL+4tQnQAh4V5+WhBQljbFI1w3ncXdCapLQok0pNtTo6vvLUNtPfCMXpHQQwJJ3buEDB/tLqOcgrZQBNbTcZo6dIcyGpsziGfQK3XUzPP0ErnjTQwj8pvBCPZGulMeCW9U39N2EHzWgM/AhIAvgVxMVvsRd8aNx404AtWGThv6es2Sj6Nvba4TG1G2cAQZD66Xxgff6ZAuttUimJnCy2sOT+F5gRtwBcpp44IRIqEcomq0uUpSZD6WR8JXXTkgHaW25+RyxI4su0mTOxRPZ7S5JuX5Xl6msFU7BUP+ZnN4jdXVjcRs9qfUfCJUeyduDoI6/Y7z9AC0n9fdfIPYWjKGh7JmOaiJH3aDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(136003)(39850400004)(451199015)(52536014)(110136005)(41300700001)(66946007)(8676002)(76116006)(4326008)(2906002)(66476007)(66556008)(64756008)(66446008)(316002)(54906003)(53546011)(186003)(9686003)(478600001)(38070700005)(55016003)(7696005)(6506007)(26005)(71200400001)(83380400001)(82960400001)(122000001)(5660300002)(8936002)(33656002)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zdcb2G+2v/FIf+CU89cSBbJpxzwhVBCsuNeJc8YpgRuU5/rgz+LdBuB+URDE?=
 =?us-ascii?Q?3RyyAqYATtRhgZ940IZaatF57AlfqtseRjEy+nv3jfBZ88SZAHzw8KYsbiix?=
 =?us-ascii?Q?SX3pIvWeQ+bSSKa8oW1N6J1PWmudksMXcrCLYMh34PdcRimhl/w0l3Vtc4fw?=
 =?us-ascii?Q?Vsg4So6LBcoWpuOebG67XuxlOD35TEHteXlrYyC/S9AwCT1E69yrXc1diEGy?=
 =?us-ascii?Q?7yXCIqXnJ6BTAlriQeG5q3CIh2CQZ0dF8DzvY9zV0WpjonpVJOigi23dqiYJ?=
 =?us-ascii?Q?Pp5+tH86/L9m7QQ7VWUaz0pWMZ0pnnfYB849bQNUIhD57+NnfxUG+VliZ38p?=
 =?us-ascii?Q?+wm9zFzNSlMpXHv5Wpu8BMPvNeyjNiqv/d4Z4Wfk5UPBBJG8JFGyUmHkibo3?=
 =?us-ascii?Q?6CScNRs557OUBJpGbfhRI8YyZLTqYTp4lmSGwbag3uSH4vUXM7/oV0lYCpGk?=
 =?us-ascii?Q?KGtOMt1r2Ceqebc0DhbpCARAxjyWXqbKuI4Enr5tAXQAEbSXxXCyGO0PBSWs?=
 =?us-ascii?Q?BWQnDmmh1bKuL2siMIdqIh5qK6IZd7y5J8IvHqvc8iDwMHKMgOIsyMAjv+0o?=
 =?us-ascii?Q?lXfZmx2wpsYEh+zU7UXCILUrx4UYtvDNGK5Qt8JGOgjWpupZ23DS2lWWCD5K?=
 =?us-ascii?Q?jLuwSzvDyl/j4IaxmT0T/YxmNr/3q4B2yu+ywdanyauIwYz39nrx8PrZra4o?=
 =?us-ascii?Q?7ZnZUNBt36Io6QSGAzW0ZJcmYzBuh2PSX4XwQQaBzkWJVR0OvSUCsvJ99OvZ?=
 =?us-ascii?Q?B5FQN+hrrphFMEib2frK/OwwJCnXPJdHl1r6RzR1kYbtPeYClbNATiPOA4c9?=
 =?us-ascii?Q?FGh72TtOUKImmcH9lNxAZxFA8amWH64bQka7FZLJh1XhYxmaRxJPAyxp6ttt?=
 =?us-ascii?Q?Y9jEWTrjjlPW0zXy3wPMlE/d8W49Jyubq0q5FYcGJstQ/ZdJgDaWUV+/ikk6?=
 =?us-ascii?Q?6jCa17DTMp/TWtcj7LDU7bnW8/oq+Qy61GNJV3uILwCGT2QYwj+KyBkJbkwy?=
 =?us-ascii?Q?vzwk6PjVC3wpkauOHOYJ+YVNu0BTyc64PhkzaTZkQ2kQGzMGLV/qFvKFgN4N?=
 =?us-ascii?Q?fkwns3RjXB6FY559CBhfleFmtV20IbYANfj3vgKFaMqbC0RRlN/JnpR+lSP8?=
 =?us-ascii?Q?/h9nTmvPN3Of7VgdcdMiAMP2T1ge0bhimMwjXRp7sqA9cp0A2vd/bn4WUV5i?=
 =?us-ascii?Q?AV17jcHSieURbA4+ZtHLTaGxMaVW+fsAP5Aa1saTyw1R5v1QGCTIiaprL14E?=
 =?us-ascii?Q?Z322T/Jvt/ktt9ngIb8u/pYMC71VoiE66zB/hDQUZoLq2GfDiNt/j1MboNA3?=
 =?us-ascii?Q?KeVruS35EiCbut9RkA8pqeqatl+25AuHBnGcACdrrTYzUf9YBRD/aK9vfIAK?=
 =?us-ascii?Q?Sejkfc3ANNknEA37hvdSiYAfuImULJyCJDrx8MHL4l+LXxC+lhXjoy8bpxqf?=
 =?us-ascii?Q?yKH9Z2mJigoIqLDZRqfD53A8Y3nfce3NYuKo93dpFJTd4Zyz2WRp8i6SDVap?=
 =?us-ascii?Q?McekURmx2enIHjyjWZCVj9kA96vT7FgndU8Lt3ZdzvOieOcanq5ZgAlN8ujA?=
 =?us-ascii?Q?kmx2CGFkbAJ7hvxHUikv95NC+DHpBEofBfmlsWt2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IUEu+NoYgVknYcbmbnJfibPRPhRm1s7V8L7TWDFtpw5lZF+idqN/71+QefddEI5SMb/71veRtWJJjj6IoxyhfgTiKcaOIWE2mUSJ5FEZIYPpKZnpY3ROUIjFmRjFquqU+ayUXVq8/u5uPAL4P0utqQsVSdal9LU6rI4Fhz9KVOUHOhRVHnUspyaQPAqMm/YK1SiJOXAGL+PZKEdTuGqeg51mcxbfXY31BL6fmIAQhGeD9qTG3pXUNEAgr9FwoPpNaislWrGO5+M27bHvPNWjdebam/FYJHwPzez1CbbDq8z/aEFFnPikJp/OtmfvF3hDK02pxX/uOmupaMXbV9gS5OxL0/Am4p6RKDxShdHQJRCDdxnWVyeXLhjYrEEaTUyHwcXifnJnNQMYHp+1OJNTV+IhkJy8KoCHIjWfKenilLrPiJbtxlAZdKpWdsNVDtb+RlwRNiHGmciR/6BwNsN6eweNX3Q5ww929TyWshbOzBac7tNGRZZ9imTmf6AuF9vJaTci6U0rWzNGD77Bq37qLgurcIPBQU4FWpQ9D13+A824zTTIfh5gPsTZ54ycotn6EYX8EA3Q+KWH6oiTb1jUbWjLZb3qRtjYBkZl4n9fXYBg+OzMDryWz965ThlusvJ9wC2OemjQVM+NauvJN8B6RrlgCGpzrnlNBp3uwWKhPAiKBgJTxi5Y/GHXZgvpquJapCf7xoR49qb9EvHcSGHapUqTylzvHdi2BjZ/wjeOJZmOsbT0N+fteyDCJsLCDsNi2xgytKgcLqDDLm0S2tUDrz/ClOkGewutZCxMckwLw6HJxQDTDFUYoQ56TmwunM0bco9/lzetJKpKpr1ku0sJPJVG8iduVHv7QiPfF6drORsuNO3dRxIMy6gpGFod/6rN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f225e2d4-f68c-4848-258a-08dad5faa0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 13:22:43.9428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqHfjfRhVWil3p017NpkbHV8inziAj9ysnYtT7zmqMMfKtuEx4LIq2FgD/ibPCBqktlTdTkn/Gi3sHgAh/VjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5703
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,=20

Gentle reminder

Regards
Arthur

> -----Original Message-----
> From: Arthur Simchaev <Arthur.Simchaev@wdc.com>
> Sent: Sunday, November 27, 2022 2:08 PM
> To: martin.petersen@oracle.com
> Cc: beanhuo@micron.com; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arthur Simchaev <Arthur.Simchaev@wdc.com>
> Subject: [PATCH v4 0/4] ufs: core: Always read the descriptors with max l=
ength
>=20
> v3--v4:
>   Add "Reviewed-by" to patch's commits
>   Use kzalloc instead of kmalloc in drivers/ufs/core/ufshcd.c - patch 2/4
>=20
> v2--v3:
>   Based on Bean's comments:
>   1)Use kzalloc instead of kmalloc in ufshcd_set_active_icc_lvl - patch 2=
/4
>   2)Delete  UFS_RPMB_UNIT definition - patch 2/4
>   3)Delete len description - patch 3/4
>=20
> v1--v2:
>   Fix argument warning in ufshpb.c
>=20
> Read any descriptor with a maximum size of QUERY_DESC_MAX_SIZE.
> According to the spec the device rerurns the actual size.
> Thus can improve code readability and save CPU cycles.
> While at it, cleanup few leftovers around the descriptor size parameter.
>=20
> Suggested-by: Bean Huo <beanhuo@micron.com>
>=20
> Arthur Simchaev (4):
>   ufs:core: Remove redundant wb check
>   ufs:core: Remove redundant desc_size variable from hba
>   ufs: core: Remove len parameter from ufshcd_set_active_icc_lvl
>   ufs: core: Remove ufshcd_map_desc_id_to_length function
>=20
>  drivers/ufs/core/ufs_bsg.c     |   7 +--
>  drivers/ufs/core/ufshcd-priv.h |   3 --
>  drivers/ufs/core/ufshcd.c      | 100 ++++++++++-------------------------=
------
>  drivers/ufs/core/ufshpb.c      |   5 +--
>  include/ufs/ufshcd.h           |   1 -
>  5 files changed, 26 insertions(+), 90 deletions(-)
>=20
> --
> 2.7.4

