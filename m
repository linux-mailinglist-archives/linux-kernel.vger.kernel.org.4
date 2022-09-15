Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D115B9CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIOOYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIOOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:24:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2112.outbound.protection.outlook.com [40.107.113.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878E9CCC6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/MkP2Bos8QXNo0Q56159g2LNYHatm6HgBiCaku6Q9k7NOssaOrrfsedWU4PfotOP2hXAntCypoySBPUieOFFRkrZ/smxoZKKdQXNboajdm1O5U3pgpdinbZ8whKlWcJAjE8T19B2Y33M1g7H4bKl3NOATuorj7pzWtr6R0PJq3FId+l9WVTyVraG3KIj4OO19urn6ymkq0win0R+Dq/BYXLPCoTAqKnxCp64139hEnhiWB8REYm2vY3I3j8vQv2IEbzs7t3lIgPMg/x6p/tCPSB7DQDoprmJ4ObIOshCFqlipd3QNRb62btEYElZHLgrBhuXNtMZShAZBT89g4bcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfk/D0LThEiSHNctpwtHf+4Qhnj81TyIGFt7cM0Pk/Y=;
 b=MWvDTI2Kd3Pafh8JwJi+VnY0p6jleeXK/Sb7t4NmgBkRIy32vx+Xj9KybgLj/fwRgnF6zIjsLpOjadk5/MwBx3jh6wwVgZO4rfC3xDYDfO2NslWspbwTuIb7oikUkZa33pXAvDJrXqLmVubgq+wTelE4m5Vjyv6yHd+fY7KMPE6RPurGh4AoH+1qYmt3V185d/xbvEdBJ1n413xbu9LDM7iN1IxicTl0TqD8HT01m9ozGXpOD0V7jBtePT4oIkBeAyLWAPwI9vt63BpHv52wwurMNWjmNgDf7p9UT5c5s3AWradUwM2+M16GI0wK08W4FMW22b4zCtKAfyKFLzgdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfk/D0LThEiSHNctpwtHf+4Qhnj81TyIGFt7cM0Pk/Y=;
 b=K4sQo1WmND/xp4J/UGXvXbKr0sk8HWt6tqKUB+e6KFV9BUDs9DpIyVIlJH/THtpKv2zzX2T8F11nAE192dWjMmyoHv0FJ1MSpyjAIw3nK9WenjfWLmsymHOke+0Mh6OLGEeHp4tMW0aVoJ/uAKZ3JwqHwhhoqMv3JrV+eMCxrws=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by TYCPR01MB10149.jpnprd01.prod.outlook.com (2603:1096:400:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.14; Thu, 15 Sep
 2022 14:23:59 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::8f9:ba92:f5d1:6d44]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::8f9:ba92:f5d1:6d44%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:23:59 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Jens Hillenstedt <jens.hillenstedt@ise.de>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "lee@kernel.org" <lee@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: da9061: Fix Failed to set Two-Wire Bus Mode.
Thread-Topic: [PATCH] mfd: da9061: Fix Failed to set Two-Wire Bus Mode.
Thread-Index: AQHYyOSw79tXY0RY3UuVtiapOsO3oK3gixZA
Date:   Thu, 15 Sep 2022 14:23:59 +0000
Message-ID: <OS3PR01MB8460CAB09793AC79397D875BC2499@OS3PR01MB8460.jpnprd01.prod.outlook.com>
References: <20220915092004.168744-1-jens.hillenstedt@ise.de>
In-Reply-To: <20220915092004.168744-1-jens.hillenstedt@ise.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|TYCPR01MB10149:EE_
x-ms-office365-filtering-correlation-id: b9453459-7d80-495f-5a89-08da9725ee24
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7nsYliKXRX+tOxpX3c7881hTKF17A7lI3qLAtJXri0QdS93oJg+yUE64PjiRpX7URRFTa50HJKrCuaE7q494+fSZKtvxJYcwyC3TyZ7CtE0bU9O7U1RRomrTo7SXpx7odqytU+4MdwOC1jMV/JKYIFWFT67hfqTwoPNYyzCJ3HWhPmEs0m61+zK4oMCHln29y/8MPGyjEFwo910vZmdRrtGhtH1lk7OSdv+nJpQN9HmTFEhPOA0Gdm4Jrt64md6/B2wRGSXCM50xJQZNdZZ/02COFSYD3q1HA+VDWBe5C4Ou1cBJkuBob5gSZscvzZoE72PlNuOePLPzsZyGj5QLnj0PMGqEFRjVc851H9qnItEk/fvKKN75cueFbx0he01LlpAdfsNw5DrwPck7WfEJ2JHsI4EvMYBw/LrwHlc084nI2RtNuSR5uQTsgXlZJPwrmZxvCyJzLMgYOuNH3PSU8esoK/LU4Bf6q2H4ZVUy72akqWw6HQj+ddbeW6VlF+9TWAC0VEYLmt7640PDzqIMzE7GdanZeRYAM4RSYyuCh4ZVJ+kbQ9RhDy7irY8BNWBr7NH954ro1F29JU+gVUhOmFYMCPmHyur7s1bZt63PLGBLtYpuRBrpZFjhlCwfa95COovnTgPZvhx4OXKUv/kgx1d86p1WZdwLCnHxPVrh54ggxfduDJB9qzIZBGnkMbsqa2V7tHgE6D4DQiFK2r8fmLL9DCvfYS4QsRjIUx3L6ctiH7dhjP94jvgrjL6KqaEsSRVqfy5kRkP2p12EHPjg2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199015)(83380400001)(186003)(38070700005)(122000001)(38100700002)(52536014)(5660300002)(4326008)(2906002)(8676002)(8936002)(55016003)(66946007)(53546011)(66446008)(478600001)(9686003)(71200400001)(26005)(41300700001)(66556008)(6506007)(7696005)(66476007)(64756008)(316002)(110136005)(558084003)(76116006)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oPLDm9ZvH2J8ChBZNGQAafn1E4qfSpzLCwfVCSj/kHk5031qp+bMTJlN8Ntf?=
 =?us-ascii?Q?jUeMtu+RN7Xi7Gv6+Uj3CNdqJioFVyiWB+NEjbSsc1o6XITGk/CPH3uUcjPf?=
 =?us-ascii?Q?aGi8SzB8NsWtfU+OAygBoYVUHkiVYhI6Ebwcmy6kXdcBrGnEKqNk/rFSOkNz?=
 =?us-ascii?Q?tnJwOlDqdCVA9Rgg42+XxYYoKpRr1lmFFYzksnNnFjhGfxpG8more/M8ClA+?=
 =?us-ascii?Q?EB2bR/omylS77wxZmTDPpYEmbNMCVqHULDDs46HTsR4RwkGV7RCqluzBj7ju?=
 =?us-ascii?Q?EhhtKAncGz5sAXyILjcjAu06JJ05VpqACWbPaQTxgnVWYS1brYn/gGhl4DCu?=
 =?us-ascii?Q?dMs9eALOg473Kokvp8y2W81L49NRfrDX3/JmFsfzqb79gFzCKYW/XpceMa25?=
 =?us-ascii?Q?+lhSuFrI1cK30zq82tU8BbzSQkqbFXj4V3ZD+lv2ZadgxH1OMPv9gAy0rLFh?=
 =?us-ascii?Q?RBwFuqCfvio5VGULajGtEmR/BFZcuZcqAZ6tnLsBCA8nXOPVijOzs2komvkB?=
 =?us-ascii?Q?XpSIS2bOZ/JG6nei/emb+raAJZARd+Jc+3PXW8UN/CGXlUmXQgYSdYKYKVyC?=
 =?us-ascii?Q?AEDFa1LSonr92J78E0kfzx1aMqYrFeHSgey3+YB87SgAvMNilmC74ThfFEvH?=
 =?us-ascii?Q?pX8DPC0FykdaQp6lJTWPmG7J00Lv9wFzc8YHz6goTAOi03y4YgBxUvh0kWUd?=
 =?us-ascii?Q?Ka2r3Y+LDMQBzoOZxOBZdqVdMEqjkZ1osU37R9+4yWqobT8FcTrQIZupaZCI?=
 =?us-ascii?Q?pzBNuJHnp1YI61CLL4HdRFDa/BoLakDKsFgN3+kwwNIfUtGAmP8X05ZBxXaW?=
 =?us-ascii?Q?+XdwGxEsm6zp07msg4WDyejac+rMGwPZtHuMJfkEBgZSlPt9Hid6pwzgV+VR?=
 =?us-ascii?Q?GbWsNFKRUJQcMZfav75l3NgyRreCobzyfKheXlPQh52zO5koket4f5gwHcMB?=
 =?us-ascii?Q?cpIU9lD6Jo1vmHVCN4I8yWhEq9L7LYRV2JnrpHxmTVKFIOXbSgIpS86ofG85?=
 =?us-ascii?Q?9xvPQ4gdL53/BsfNrT3IlwSHbo0jXNrYQGuYXFP/jqSw25f78x186zgWJTR0?=
 =?us-ascii?Q?jAXOveMAFB3KZO65HqzygVh+SJs3RorC8evq7rAdpDBD+pN/t0XQxT+gi3Wd?=
 =?us-ascii?Q?Q0MixnQq9HWrqltwlqh5ldACPsM2BjtpJxaJJsJO3wbbthwZMk+wdxYWIliV?=
 =?us-ascii?Q?JEXTujREF1t06ZeD7mwr/z0himnmo+zqFle4sXdeM6K+eSm67GP+uxS7ycEB?=
 =?us-ascii?Q?RpQTPG4u10adg1eH2yPNaIUMqDB1GB4XQRvrEl1NhZhYYKSWjaetYRvBv1Le?=
 =?us-ascii?Q?G5wHjPlebhAHgrjr8b0wXuPwJpqBrll0KUUXnbtMrLL4SaoyZN8TRzYA3vLJ?=
 =?us-ascii?Q?/NxxhXZzE4H1p2QUGjoK0pKGonW5WAILfI+5DPSv0Dz8kRwb+a02qjMd1U8L?=
 =?us-ascii?Q?QL2owbGupawD7SPCWh0NWM35D1rMTqtl/5AB+0it8IfneWIRsMSHg0bV69st?=
 =?us-ascii?Q?QUKYtkxkbl3m5YbZAVvXavQQGBsJGDaSe3YUvkHgFF7VZHmnD45avFeGflXS?=
 =?us-ascii?Q?TJ1p1vwGYA5ejCDwVsvmojr0m5PRMCqp6W2sg9WndGB34QZBsrvOju8EwNfQ?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9453459-7d80-495f-5a89-08da9725ee24
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:23:59.0821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fBIkeKfYd80TGPfVBldMiMONPbxmY/kx2RA4nim5nfia8JwVb+bNNfE+LI2SDDr662KfFkkC4qG37eqRMvUT5qACtQB//LH85aXB2YU4Ugo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10149
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 September 2022 10:20 Jens Hillenstedt wrote:
>In da9062_i2c_probe() regmap_clear_bits() tries to access CONFIG_J registe=
r. As CONFIG_J is not present in da9061_aa_writeable_ranges[] probe of da90=
61 fails:

Thanks!
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>

