Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841EA6CB60F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjC1F2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjC1F2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:28:03 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91B1BC6;
        Mon, 27 Mar 2023 22:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoKrrmqk7KkRUKQYhyP1+o8Ys5zwAW47xEi4LD+4KNLtEDMHXdBlg2ST74sEqH0PvTldqAsoIWwsm3faL0n4mF1qWI1NBMEA+LCLXQ+YILS+98eo5vPInNOPVs+vSmgkF0f0Gg8O8Q3jZW5zJu60navJR7J2O/PGfQxwvY0z94ZG4W7GRfCnnQUYb/2ufinF46+W+To5IMRubkwNJqLN0I2gAqq18nQzILNNs8nDSrC9vsVIetD3Yk+s/cUaR3LahuGhfba4fS44guQTGWo8Bc7Pn+4is3/Xnke45H+n2TTMFucaYKwnVxRTBjXxbwWbzft49gnJT/7cF/ztdZJ0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc0gEYtfNUAzbf2Grt1Clv4iqarOBcykW4UDU0ZarPU=;
 b=Twm8xfQ37UirLYP8CALGClgwCp8GdTNKKIcHj7L+4LFQo+Lgx3AATXEeDqUtROAUZDZ3ptO3MXy2GpSqYMWqx5jbBsNy62n9hK49nVXueFvt94s4uf4b0Us0blgJz1/iU25zkWW9+AyUA6wR8F8e2K4Ms9p2TO6Gs4PwbvEIUjIHuqjh+l/tuUlbNuQCOiZv+hjK1hPyhcyF58UgbGURSijKngNt/PJIw+/rHtC/NboSiTloNYLpcP+yec/g7Qqfntp03XY0WIOureN4um6ZOOspukXgis+NhzaAmiQXcZtsgHKYU7h45JV65YaBrYTgTPh26ehkIzTXF4AqldJpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc0gEYtfNUAzbf2Grt1Clv4iqarOBcykW4UDU0ZarPU=;
 b=OGVetmT8mX3LOhNK+AFpqzJtvcRmuHfgY9gVjdF2PMc5i86xVIBiSVuz/KSB/Se0ajJliyW3unDNhfdzID56+lJ8gQ8Ht2gZC5KT02cNb+TS4gldRAlQj/tX0/T+/D02Hhr9nm95WVzL1soE7nlvqwNJpmi+QgrS+JOV2POiLY1b1Ckyj2/vMKBHa4ZxnuXH91ouv0mF0QFSe49PGPJELhP+fKTlxN457OMwVcVJHk5OTuhlVzyuJBfWDoVcRnu3vjuy9MvmeQdO2tcBv1x7L7eqG16K9EIY/tSMPDF+UHtnZk+e5Eqy+CF551gZaLF586iFyS1wnJX0r+ESI52IaQ==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AS4PR10MB6111.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:583::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Tue, 28 Mar
 2023 05:27:59 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e0f:1c10:7da:515b]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e0f:1c10:7da:515b%7]) with mapi id 15.20.6222.010; Tue, 28 Mar 2023
 05:27:59 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2 1/3] tty: n_gsm: add ioctl for DLC specific parameter
 configuration
Thread-Topic: [PATCH v2 1/3] tty: n_gsm: add ioctl for DLC specific parameter
 configuration
Thread-Index: AdlhNbjCiy26sSI1TXWXW5/l/PqDvw==
Date:   Tue, 28 Mar 2023 05:27:59 +0000
Message-ID: <DB9PR10MB58810D7D5F76820DD19C686DE0889@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230315105354.6234-1-daniel.starke@siemens.com>
In-Reply-To: <20230315105354.6234-1-daniel.starke@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-03-28T05:27:57Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=b40170ce-d859-4195-82fc-f2fe79d95f84;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AS4PR10MB6111:EE_
x-ms-office365-filtering-correlation-id: b3d7c409-7e8e-4860-d104-08db2f4d31ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EVdqc/7c63XVGlgkGvAlh81/APNuDMW/xrz8Klw/91Pte2UcXfDNdpSQgPgMkbHXMlkWuyWjfL1yMRvUk+RW+lYj3fbybY3wfClZR8IdLEoO0UbULd8eOqyL4xGhfZaxaB94WeKUgXiVost78bu0Hi23mZReoP1mhA7vKSyocq3zd/o98FTufz1sDATRK4IWoA92qy4wc8ve4I4TaaPML0wq69fMHJQg/pD4/43yR8SnNy8bMHbMN1XtlMgrlekD2zLT/Z+rIcHjVpx6k4kda447rhfHIWqBgf9bLNgw64UvTtnOYNrHucbnwOsarqbxdQcYbiagEmOXLlOBvWEsCp7b0rL41I8i24FVDjKqH7P3T+J1N+sagviXGaIsZrDMFPCiIq5k5Q7CqbsN9LU9RD0QSJX6/F1XjUuUFhnTYoCfm9FGnk/n2UzB51ZgjG/496C/7FIeadwHiVi2BL0XDxasglqyn80MVt6dUd9Z+6nUDqSU9PANXhpJvVSRB6+OLNBcZ6D0xvPah4pCU/HMkQccHUGLdQ0feLDJbSUQduS4pZaW8O1hG7VRxNZt+ZYN1/JGOb8ErqVDxJtgz6r6w45RhnULQ/s6uX/p5+c1+/w4qMeeOtzKfSBqc1G2Xlp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(55016003)(186003)(83380400001)(9686003)(6506007)(41300700001)(8936002)(122000001)(5660300002)(2906002)(82960400001)(52536014)(66446008)(66556008)(66946007)(64756008)(66476007)(38100700002)(26005)(76116006)(33656002)(4326008)(38070700005)(8676002)(478600001)(86362001)(7696005)(316002)(558084003)(71200400001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8/ADdg3nH99vB4rDBwRPrywfjFkGSo5qjgMDlvK7WP6CwWUoyabExB3PcuNP?=
 =?us-ascii?Q?fLhEJSVgyz/1pwGrFak65gg9e0R8Hc0HoVkCElCtH2petdkzKee9HQMhs0aO?=
 =?us-ascii?Q?HRCWcUD5DYlWISQ/rl0PABP9OkQLiCRjPcLbYbeu8/qLuhNfyUqSmFYof+2P?=
 =?us-ascii?Q?oFS6DD+FulejNqROqBBgZ4VmSjckIQK5YzdB9/LZ6UGz6uSfrFTGJUqYN8dZ?=
 =?us-ascii?Q?ZGJ7g7gcoGUTMRh9tH+4jcD2K6fwtjHp8kcv2LV9N4DWiJiYAb4vWzKW9RbW?=
 =?us-ascii?Q?8RGBr0xTl5iGU4PF/xmszzb354xnphTrpXPi5c5bGfOHLxp6BLF6RpZT9mSy?=
 =?us-ascii?Q?xk6Wn6n1SJOsVlyKjnZgIroyjtJNavHkrS2cRqM5S5nlYxNEg8J4o325c08/?=
 =?us-ascii?Q?flVXX6trs4Z5gWvsjzILwEKso8wMJ2GL/1uwSOBqrglsc5AUz6ejJY9ww6R0?=
 =?us-ascii?Q?Kk826XVmfocXpAktnJTeEiQgsq1svzG7YdWpyeGmgi00xtz8HhY2JSLjrcTx?=
 =?us-ascii?Q?91d4luRMdIzi7Sl3+sys/8iCZ8ZP367wnJPNvluTw2YIhHqnsJlfV6gtWYOw?=
 =?us-ascii?Q?7mRhYKSa5sjIw32JNjjjLzs5qulsjBbXkI9GsPB8CPmu5ZPtSxzVZ7NkDK6k?=
 =?us-ascii?Q?OfvkfWV0j2vifBFWefvE373PapU8n+Ex78PdpyOpjPIKjNPnchwN3TyXC7/W?=
 =?us-ascii?Q?Ot6Jp3pz5ztzzm2fXEks3hMGOm9uhwBCcPX8J0RlFnTGD0AfVKg8qwPp/ZZD?=
 =?us-ascii?Q?5aPcJcX6vY1VUAQAr4QF58dvF/IqLj1J1jeW2eFteU5Wjh/PRSLepNgKJuq5?=
 =?us-ascii?Q?6ED9i/eYRtXkMgo08IvEo67XHvMZthBCg6718bKi2V5W9KnoatMh61GtfHsl?=
 =?us-ascii?Q?KAmK7pfQI/HUK+LPIjk1ah5XTxvTLihywsP1kQWRgXyGe/3pI60IJzkRh1eM?=
 =?us-ascii?Q?ZNDZxNuMpAmVBScMiNDT7DT6d+++Vfh9Kzq+yQ884E/fTx5UdRwVjtojkx80?=
 =?us-ascii?Q?XaZGxutVtIZizhjn/tz+bnO28wXrFX2LsD+u9ZkYn3VFznxGfot1EBRfb6wu?=
 =?us-ascii?Q?g5rMWlboBdU3DedzeWUiMQr7ZEM+RiRxirJVePyaua5HGlGtmHIXJH7FBEP/?=
 =?us-ascii?Q?t5gkLSYojCueg5z6yo5gZSBIq1q1qo116VA0pcnu0eoFHWuMP+5G8fSZ2fgf?=
 =?us-ascii?Q?K7Pm8VQLsChj3U6X8Qm2VLDzSRpko/Kb9CoBK6rR21fROdK395nqxGonH9OU?=
 =?us-ascii?Q?9fPXfMVrH4u9fyLW9uv0Rp3ARaGN6U0/i95oscb1ET9r4nStewcis6pHL+jq?=
 =?us-ascii?Q?RpZLtuvlUEmjJE32TR6PMhMp6dJQar+Af2wHBYJ5wow0s51ejQi1KU5LhCmB?=
 =?us-ascii?Q?JhvFboU/mEvDGmyUaqtyY36KU2bW0aXpxMJDO/c/F+0vlsZiyH4xSsN9qSR8?=
 =?us-ascii?Q?+3DNJuLJoOovrgK2/poH94UhphXSri8BEcxayfK3kImD9d6Mk4FSAGAxSBmi?=
 =?us-ascii?Q?Z8BCPXHYeHyZq9JkihVbg/aM1lX37WKrUzpYfRYeiS8Hk99VpuIpwk3yfZPE?=
 =?us-ascii?Q?WRzbb9Df9AXPb1xKP6xooCwNlXBRvxT5L4LrAKOs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d7c409-7e8e-4860-d104-08db2f4d31ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 05:27:59.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWFV2qtLV8GfufVWY2ESpyCuxRbRxNMtvhkz4DEdAaIb6Nd5p8sWrK2NUslHgSAPG3LQTaUp7I1deXBsclu5rqQHFoIT8E5KkrpE3V6eRcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6111
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any blocking point which prevents this patch series from being
merged?

Best regards,
Daniel Starke
