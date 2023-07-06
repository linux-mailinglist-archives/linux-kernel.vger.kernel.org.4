Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B407496D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGFHwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjGFHw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:52:29 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28301121
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FK3HRUsUZicDDV7e/DzMi8C/sIAkbibwIjh7pPhEEie4pSwERSI415EI6hj/YmRtCbpkBi5ijm4rxE427eoEvi5RKb897HT6uIu3A3iYiWXFGp5IiJBK1bLgGvfetUtU0v8nktfwf3T1yF5ub8yynxrz3l0LQarf+UnMBdSrfscOK6VWAU1xo5Juin5w+R2smNXl+VzHeMSOo8hwJrfyhbUYOak0WJmBgXrUKSKN5hhuDwSy/lNJMX1xkh+mhxGsD5MAQtq1q4cS/PJUFZLLqxnfphwNkHOCMytJiwaKFzXk4Udw649uSGBFeOLivJLbPnWX9dKvOzZazAHDnaoglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDTgkf0TqArHU2K65Fvmh4hBc0kg0NoaFQqi6DFak7A=;
 b=S8QSiS2pgoxUScadRaz6qUZuV12s2cpPC+dnHF7JeG+MHv/Tnwl5Qa0NeH2ynFYI9bkqiFIZ62zc4HoEYuynEUi3CkG3oMJ8qyw7hN1kJ0sYiUAShkWnOMEWZMgHVNSyGIM8+WwoA4MaWv5nM9+5UXbvLa2Daf02lOUY0pbwBb4xmv+NbjH3IVdFzwtOrD8krsIhboi4jJAa3LEtdLZhJXGKiW/NRCY2WtWJ7nMTHQGeLmJo1hiw8GcWEqwGJ6d7Q4Zkg/A2We/r99GRXyn4JlFaCBhk9BSYOjEY5QCaM5aMz1iRIVlcGLUh6gCwik1rJxUkSMjiMAhDfBg61oFX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDTgkf0TqArHU2K65Fvmh4hBc0kg0NoaFQqi6DFak7A=;
 b=LCws1IjwioCPu/ieSdSCb/T0Yrrm8TKqGSqdjnkazhEUBIWO1+cWO0XzGPr2SbBoIj6DnPk2TaYAEByFGgLguiQ3wbmUrKAivVdmAbgifK6Yz3Nn/bAmtvVRsPknUO306mzjqURuhXYEwe0eGbaPhOTq5/QIDSpfnILjqsQoAMs=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB11134.jpnprd01.prod.outlook.com (2603:1096:400:3d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:52:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:52:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     kernel test robot <lkp@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: RE: drivers/regulator/raa215300.c:42:12: sparse: sparse: symbol
 'xin_name' was not declared. Should it be static?
Thread-Topic: drivers/regulator/raa215300.c:42:12: sparse: sparse: symbol
 'xin_name' was not declared. Should it be static?
Thread-Index: AQHZr94+SYZHE8YigUyuYU/ChOcO1q+sXYjg
Date:   Thu, 6 Jul 2023 07:52:23 +0000
Message-ID: <OS0PR01MB5922483BE3B70DF77C6FACEC862CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <202307061555.Gx6hEBT4-lkp@intel.com>
In-Reply-To: <202307061555.Gx6hEBT4-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB11134:EE_
x-ms-office365-filtering-correlation-id: df6cad9c-f7ea-4bf5-ccd6-08db7df5eef4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPqC+jmJhxccAx9EsA3/nT3qMfJWfSWn6YkutPS79rNcGr4at+UGudogRvyIr+EP64FzQJ0BfXbThHfZYXshaeZCNmuTuj3MO0CIsqqPgNNDnVDP3wI1KMr4EnhwAs55BbLd9FLWp8YAe9/EqXWFZpQcIsukAExAl8YOv3Bc/oMXQ0DkAqPYcTAOXFMP+DstMp8+0E+ANRfxSZnV5EMt01cZbTD47g7KDL1LhTvtTS2xD10ei/P6AVKjsGTJQwT3zgSiZaKGgoDUoWPuMmUMAJNb4pfo0MQXlCS+yFDvhWmULfYxIHKZKbALqV6olQdJeH7FBKx1DDMl0z6Om2Nwo67Ph9xth6t+1xUBb7wA9RcNgb2xFBwlHPo+ozheS/Msth6ikqw1R6nnKyQP8DuwLGNbJzuUYod8S6uZmRbI2k2RNnFPXlvsk7aVhFUcUt/qt3nR80qErpWWyzRiTfB4C093lZiv5QnA4mBidrDXOYONwuSItCGE1IG9AYELZM922FHQAPW4E1+74aICP5arnrE6JuSmzUYx6sHFfcPyJ0rV9rAyYVplHwefaOMbR6nncrP0JOl0sQK0NhT0JXU651oIwPALU0SuELh89k3srlg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(66446008)(4326008)(6916009)(66476007)(64756008)(66556008)(76116006)(66946007)(9686003)(122000001)(38100700002)(186003)(38070700005)(86362001)(53546011)(6506007)(26005)(83380400001)(33656002)(966005)(45080400002)(478600001)(7696005)(55016003)(41300700001)(54906003)(8936002)(8676002)(316002)(71200400001)(5660300002)(2906002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mCC4L+h9S7elqJPIQE/aFuMev8vLWeCzST00Jdqgbc98jmR050X8n9Hg9vdk?=
 =?us-ascii?Q?GBJ7hhkeAp/VQWYFKX3d9wTmOOfw9LVIawNlkDqRNFwLOyXz269kmzGRZwuZ?=
 =?us-ascii?Q?YtwEZheo/aR9EpZudJNeGMXtPDYiQSgk0vWBVlFLfnTKezwA/XEoUij7tS7y?=
 =?us-ascii?Q?jUrQPq5P5uS93uD/fOBRJxmYt81B//JWrAyc8puZZfMQ+AjyOToxFMmyom8I?=
 =?us-ascii?Q?a1M/kffKfOEzKkSBHxDvYOAcJnFMH/mQgona5cGiziwoQgAsomSsEApA64wl?=
 =?us-ascii?Q?by//bObWM5F+OvLw1AL8BuvLpqXXaOMmGSqse3eQ6vr2zUOa9d7XUse1Du7w?=
 =?us-ascii?Q?yEK1885drQselJwDaajFh/ML4jun7fvBzAEVDhq9LRxKOVKp3uj8syKAsZMY?=
 =?us-ascii?Q?ILN1CsB7RVTf9DAo/DCGd+vOUqfj9NPzR71+sMUXsIA44XGSSfGIALZH0VlZ?=
 =?us-ascii?Q?7AkqQ+bjgw2olgDlGi8sfPCII2B+u58iGRRkqqrQO2npJkiTrxg4S8/5Xx9l?=
 =?us-ascii?Q?UG0JRHnmj8jHBjGXX8wz6wOUXUMpW8SI7ywsFZNeZZzQlnHUnhaCtwy0Hx6g?=
 =?us-ascii?Q?KCt9j+gX/HCuJ00YS1a2amS0z3TM88olR1GE5Z/xybKhPNe6aKfoFtwL3ayr?=
 =?us-ascii?Q?Vh/Ok1bdtpGGapyIV+EVepteWRP9TWnAuGQb7rU3oO0854G52CGOOp/Z3YaH?=
 =?us-ascii?Q?4FTWqJYoLWhC3mE1iQErwV/wlQsbhDGlh5YJgUlWcH00aM1bMvF/JNmE0Iyj?=
 =?us-ascii?Q?PNqkv+vB99AORgQThkKAmyJrOdUOqP6ZNedwUa0wIadV6JNoYpu576oojEsp?=
 =?us-ascii?Q?CaSAPXI3wN8/AWUvDYXUa58d50AbDX3jk2WWJ4EvioKJKx9vDhzG2PL2vzvX?=
 =?us-ascii?Q?ukjm3Eb7JggJLiQ/FjlL3rof7WFPZbXfm2+cYH368U658DWJ2Cur7hMyAF4a?=
 =?us-ascii?Q?ZYER6emH5Rzvb5tSHSJftHcEKtE9bUXcz6RRQ6dLj+AyMSQ+8Z3DKm5Cf/ZE?=
 =?us-ascii?Q?BnCLb5FYSGZWfJjf3OSGUDrsMyMBVj9LEIbCGtWQCPBWvP3CV/pB7W/au8l8?=
 =?us-ascii?Q?a5q8QRakp5DlkYXqtj2NmXDVL1O5cym8elnpyZa9v6+dk0r28q0K1W5621Mm?=
 =?us-ascii?Q?n48aG8DE9yLHAfUJHccykSnWsa1qY4WJbW4SnBJFPg/pdOprqqV1wk1oUV1m?=
 =?us-ascii?Q?SuvalweHNWOaYH8iGSUtjNabLgRZlcSwMkapCNM3LyuPS9jc/nGMhqra72dU?=
 =?us-ascii?Q?MTY2vZUH09lLJdSiHgDHvbNpXY56Pc2ahiRjeFHhpgmAxBHaDfu4DQC+nqkD?=
 =?us-ascii?Q?I7KG2/5yvPglRoEku+AohB8IQ4AQkVQIcSTLIWd7OkaYeXwmUHlwE1sTZ7RQ?=
 =?us-ascii?Q?iPwjL/quiCJ8xvnzLeJgPDf0D0fSGlKe0wDCiLO/li621jZyEv7TfqRhJgFS?=
 =?us-ascii?Q?hHtQwUIEAvi57EBIJuc7yu02XSzYG2dvL9CJA1H4leReGr+oSjMUGZI/ae8W?=
 =?us-ascii?Q?Lf3jFRFt/Gugj5DN6k/77A16NcTiz149tLhaj1XMg02bnIX3dmKyb+fj6hx9?=
 =?us-ascii?Q?K6APaPczB0yBie0DBAMtTS5M/bPIcZCgDA7FNRna?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6cad9c-f7ea-4bf5-ccd6-08db7df5eef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 07:52:23.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpHwajJJplDAgZWIquWZdCZfi5pc6RxIhHFvEq/WblEEIXwsYbJIrWhWzEbhRmCbGqCLulFev6KoR1QDoOV+tMsECLNQ5/T6ysAo4XKzO/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel test robot,

A patch[1] is already posted for fixing this issue
[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2023062910=
4200.102663-1-biju.das.jz@bp.renesas.com/

Cheers,
Biju

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Thursday, July 6, 2023 8:48 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: oe-kbuild-all@lists.linux.dev; linux-kernel@vger.kernel.org; Mark
> Brown <broonie@kernel.org>
> Subject: drivers/regulator/raa215300.c:42:12: sparse: sparse: symbol
> 'xin_name' was not declared. Should it be static?
>
> tree:
> https://git.ke/
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&data=
=3D
> 05%7C01%7Cbiju.das.jz%40bp.renesas.com%7Ce3f3ca7fb3df491ae9a608db7df5603
> 3%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638242265057971867%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> JXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D5JI%2BnSc2P4jtEtPt%2FqiNh%2F14plQuAs=
v
> nr5MnYKsI4u4%3D&reserved=3D0 master
> head:   c17414a273b81fe4e34e11d69fc30cc8b1431614
> commit: 7bce16630837c705f72e8fd53a11ae8c236236f4 regulator: Add Renesas
> PMIC RAA215300 driver
> date:   13 days ago
> config: i386-randconfig-i061-20230706
> (https://downl/
> oad.01.org%2F0day-ci%2Farchive%2F20230706%2F202307061555.Gx6hEBT4-
> lkp%40intel.com%2Fconfig&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7C=
e
> 3f3ca7fb3df491ae9a608db7df56033%7C53d82571da1947e49cb4625a166a4a2a%7C0%7
> C0%7C638242265057971867%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DOct%2F=
b
> Vber853uFXBq5djHVUhWfGgx%2Bslq%2F2eBZW%2FRy4%3D&reserved=3D0)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce:
> (https://downl/
> oad.01.org%2F0day-ci%2Farchive%2F20230706%2F202307061555.Gx6hEBT4-
> lkp%40intel.com%2Freproduce&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com=
%
> 7Ce3f3ca7fb3df491ae9a608db7df56033%7C53d82571da1947e49cb4625a166a4a2a%7C
> 0%7C0%7C638242265057971867%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DmLR=
4
> jlOOOebkI97gUy%2BhDTm26z0oqbwFh8kKXG1Gjwo%3D&reserved=3D0)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore/
> | .kernel.org%2Foe-kbuild-all%2F202307061555.Gx6hEBT4-lkp%40intel.com%2F
> | &data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7Ce3f3ca7fb3df491ae9a608=
d
> | b7df56033%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638242265057971
> | 867%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> | I6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dq8KGqKPKSdpT4ojrGtzna4=
o
> | 0nMVKF1s%2F7qoSwXprJ2o%3D&reserved=3D0
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/regulator/raa215300.c:42:12: sparse: sparse: symbol
> 'xin_name' was not declared. Should it be static?
>
> --
> 0-DAY CI Kernel Test Service
> https://github/
> .com%2Fintel%2Flkp-
> tests%2Fwiki&data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7Ce3f3ca7fb3df=
4
> 91ae9a608db7df56033%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6382422
> 65057971867%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3Dr8lSb3miJtyGUa2Cuz=
8
> 60cVTGlLU3Mhar3PJdRLUBSU%3D&reserved=3D0
