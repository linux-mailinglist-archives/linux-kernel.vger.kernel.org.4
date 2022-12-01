Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9905463E9FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 07:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLAGrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 01:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLAGq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 01:46:58 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A0854B3D;
        Wed, 30 Nov 2022 22:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669877217; x=1701413217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IdMVStX6zIVaYIm6/LoVGmk+klpA3IstThWHWWxYlO0=;
  b=SAb8kqzma/mmkZLLHDwMCQKsB5+/eLq7nzYLvIF7JKlAeZLM2AwAnx7o
   9A08i5futshxCim7Dmf4tR/xZMaeUJg7hyG+UCJtMvVHDuxgo5njeYZeX
   wMIrC4Zfc7RhYhQ763Xby2DQh1tygPB16MQ+NgVXAYYIJMi8uv5khOcdo
   vDTOKEBtUzxs53gBPkbl8s/6Md9FKWgjg/GRgr8xj4L/VnRu+HQd1oKrv
   B5Mu910KM8uChoMPmPXhf1mVBrO2F7Qj9tWO06O8LnLgtT60v/CEmfnBw
   ZnKqmFd2+N1D/WaYJF0Cz4h5UAh1PG5jPZwWX7/RO+ZbHjhFDafAMSv3c
   g==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665417600"; 
   d="scan'208";a="217626728"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2022 14:46:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwh5KtFcAEAIgKqps77/pc+PkQHGvNxSaqtsYKuohxe91K4v00lt60qx6IB8HG21YuN8j2A2ajCviGoubraUiNUG+0otB+YrurlPnvd91G9fwcJ630XSSz6uChG1JzfVAkH3R8V9JEhoRba4rqhSyjW3+b/5b3zUFyYPzk2QKNDsnobcwaDJXt0e3FsUH0QvLrans9TWn3V0+xmM4IEPFYnE+KUDHq75Fd3wAxDGtsOY7/FLXOMmdJLigOaNslc0wAo0FsbTxp7aPMufeni2qG78hY7ccQuuuBR2/y3v+wQonuXPAGXyS3W4Fs2zt2XVyJHwRwbEFI3NYIlW3Cc8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA+hYyykIyCCZhyO2D1cs7p2VKii3n6eCZdhlS0vv/0=;
 b=UZ+0oHBu+DEC3ZdYVNNuLtv3lV/liSMFSyt9RtUtTDBFjourHKU0VVnMGjbToLfpbQbLD7qAP7OmfamLrnNPnR+vXXgl+bfihIuvqPSTkRBwrDuEEm3nc6td7vkdTtGU3XjvI4R4hXBpWXd1JOkw0NjXAEcgGqWaVuH7OemwzZOltw6KTkCUUepkWtsNZtGJB/nKq9k3zJJRHRRbGrC7fqwMUTLuMqGHXa8JpDanxn4vh82KOXnHRBTECG/24uRgpvaglVhCCid1bMb4yq+MvStqGNcA3JhgaY5I4g8Wc7MahzkzHZ2weOE5SgnJtG9F7ZufmYJrRsnYNYJUYdB5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DA+hYyykIyCCZhyO2D1cs7p2VKii3n6eCZdhlS0vv/0=;
 b=MqWgNu7L3cfuziFtj6MDX7A9ttWIIrMRzPadfsQ2eHv1ayWX/QrFWB96CkuCxxbjSRec+kvffE7s3bkxOkK345Avzzkh/Ns9/x7qtnmKzjDm/M0TOzaKl0GR5waggBXhuOX7CTp13uYDc4/sh12TpLwecKpehwmut9xKG2gYEAA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH7PR04MB8523.namprd04.prod.outlook.com (2603:10b6:510:2b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 06:46:53 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 06:46:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <beanhuo@iokpp.de>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] ufs: ufs_bsg: Remove unnecessary length checkup
Thread-Topic: [PATCH v2 1/6] ufs: ufs_bsg: Remove unnecessary length checkup
Thread-Index: AQHY/S6eCfPHkPjLb0KE0d3ss1URxK5Yps0g
Date:   Thu, 1 Dec 2022 06:46:52 +0000
Message-ID: <DM6PR04MB65759E6D99477E462E3C6B57FC149@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
 <20221120222217.108492-2-beanhuo@iokpp.de>
In-Reply-To: <20221120222217.108492-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH7PR04MB8523:EE_
x-ms-office365-filtering-correlation-id: 305087e0-a214-4bce-d32f-08dad367d4aa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDx8orfKZQgDj8ombcaIh/m6jN7EzOVppIPVPr+/ar6tnOtT98KeqgfR/4EDt384+ect0mKj1/G+m7ZrzH6LWUfSZJFT8S/LpHDkUR2tkFoSSO2VjxhsDiXEYr9r4fyuQR5XtxIZOWxbhSLpBOa4JANKA4NTBK0XsThSfMP5yHsMXTNpOHAu7fkMx/NVCLUiYHWbZ1mvM4h5uoknG/zHmnY6GWzpT4XeRWdUa2CNaWzzbyxM6xSm3vRBD6H2/9v++lw9/95LSvA0uPj7ZOKgcnfVBJaUAG2jC/CbqLWC9NRO1Dmq+RXN4+sc7hAzzo9PT4ZIhkrKZ2rB3W1Wbuz3v/ZSvckb95rR9cccwJyCjusf/OQQYEhov026SIOdDgg4yk0NsjwQjJ4ll//vXPGKN0vO8WZ3FiJRk7jCvTTbcLhWVGvOsQgoijZjNqRIWrwdwRqp/JlEpNR6o5ESPDfSJpAVbiXyzb0irza2pgDbIMrUk6c1YA1V1YkO/LmPfGl7Kc9RDcxftYU9I4zIAkd+dc0C61iRx9agP1WCvTfpqKrFODYKnk7jtXDFOJQ5+Pxa9VPplP6EGKz2onIgo4iR36uKrV1zYbuwrsa0NvLaAagEFT5TBvZGOgWBivpQOQmZceJe7CiZNPC1WOsoyqY0QH2AaykGwBRvc0CJ91l75DbEuzAMxbYiq25MXB4qc0HBa3Aec/lemTAtcOlxuPRbnmZFlhhpxqCmNeu4JeEezic=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(186003)(54906003)(110136005)(316002)(478600001)(55016003)(82960400001)(921005)(38070700005)(33656002)(86362001)(122000001)(83380400001)(38100700002)(9686003)(7696005)(6506007)(26005)(7416002)(8936002)(41300700001)(71200400001)(52536014)(2906002)(8676002)(66446008)(64756008)(4326008)(66946007)(66556008)(66476007)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tgw5IbBzv0e8IL/xE14n/o0YDeEMZCzqmDNx57d2loyImUv2k+/uwRFcGn1J?=
 =?us-ascii?Q?rJjTMv+mYOKiCrs2qNwG0j/cAevEULzeyMHbwKKl2+iEUjhqPrSRQHo8MTUW?=
 =?us-ascii?Q?8V68e0D5QWo5mTh8SdsK4SbQWzj5LyO3829VCIusfKnbUAevYqJAOT3WyN3s?=
 =?us-ascii?Q?f7RDXcPl+A6fimPAIK6m30e5MxpWhPrJjjxVQjfCnDLBqQT87PCXzLptAkWP?=
 =?us-ascii?Q?XojateQMudc6DnN+ZfB+x5qSwDFm+18Jwcgi3J7XBWmy5oB3xCw1CuqZDv7Z?=
 =?us-ascii?Q?p5W1HCULyamr9xZ62bKSsB39Jz/8w+xVWisDpJv48F7QG9nQkMoEgSWkpnQw?=
 =?us-ascii?Q?dUi699HL81I39fT6OGJHja6ic8oC7dZFCL8eLNbX37JqJASadshxTZlS1JaO?=
 =?us-ascii?Q?ZtDiL0hm5lp7xMttMl4OPZUJINSKTY7c1ztStYg9o2tl3AITkuDfLMyg+BYJ?=
 =?us-ascii?Q?4MPWfMrkXR5QKkF958OUF2aRTYHlt+9UfSsYa/ZFG6k78lnmKlqhQg5OOwMr?=
 =?us-ascii?Q?uASy9+jhOB2WhcQT6sOAzmtKwMJZs2naxylk/Sl1opiexnNhKbVYo2DLAWXg?=
 =?us-ascii?Q?oVXmfAhX3qzPqoTy7H2jSp6Qy5PE6bjRKu6HM4UR2VfgU54BsJCijqbLLB/M?=
 =?us-ascii?Q?DWzsllJzr9ADOWSLOnso1Gc8G1JygekBsj2/maFw3vWvWy+KQ1DQIKn4qnOJ?=
 =?us-ascii?Q?bLhhF5657SDvw3p3eFe88Mz1Q4UgpU933nFRK0zIMyBTtQfI1/h8rmipHm2p?=
 =?us-ascii?Q?f+d2TL9xzoOF/Dh8uF9Fj1dfOJm2pWH/X5cNSpmnahMweS652i+CLigYWK7b?=
 =?us-ascii?Q?iZQH9FP8VSRa1ZVr/dVUDSXbO8qFd/MhTj1yfM7wZqfVLrLcxw0FuM3V58a4?=
 =?us-ascii?Q?JRUaNcUbYCp1iGQrNPnL2xBPABRq5uvVro/7VpuCLivt0rg7PgY/s+4Jwkhy?=
 =?us-ascii?Q?GxWlM+aR8hcSsOpl8SdcMWEk+yJewqUj8yXepSMx7auEtC6AK0tougyWteaj?=
 =?us-ascii?Q?dZp+7lx5CClUAf1mxZFFGABJ9nfRextq2E8lRbumWTtlt+0wECHfnMr/BWZb?=
 =?us-ascii?Q?kluYqLNd+zQqrrLO1mwwEdS+hFU6yd7IRXqKkL39s2lNVr8yQQc8gidM3AIS?=
 =?us-ascii?Q?9GEB24ggBIAH/6KgEXjGMlBbZN7k0uD8iFx26rgezvvspx/q0SVYUuKqaTCN?=
 =?us-ascii?Q?Nmmz8yMykMVmm7LFKsgSVbNXViWxihTbdiOKIRF66oWes6+5jLHG4rv2RZMo?=
 =?us-ascii?Q?14ndzarqPY2ex+u/HVZULW3GtbpwgOVafzOxYUjNeF91/8l+fm2SErgX9sBD?=
 =?us-ascii?Q?IfH+v/8wygxurJoBAOL/B6/Hxp210jCosr68wJ9XK7prchSC9AMWVoi55nlm?=
 =?us-ascii?Q?JQH5hPHqy/jovrQJ9AT2ulbLCFJznoAEReLwCXF768uKzgSj46VbYERDke6q?=
 =?us-ascii?Q?/4cj5XuMZ07mw6wZnP1/tDerqCBiThZT8kFHLXUfNWSCtacfKljpLkOpOX2a?=
 =?us-ascii?Q?MXzWj5FBNdiHekufjEtShzgceC6WMZZBUmZ0eGeU1KrBZ1La3Hbs4w6fiE7S?=
 =?us-ascii?Q?DVrguMXUOY6YD7PR1VjkG9tjLn5XGwHVZKbe3QJE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Fv/sgeuA1+qXpoH8ZbnDeJKLk+pIwfnkA70Q49o5mYgvk5Xp2F3Ofj+J8roo?=
 =?us-ascii?Q?cnPXg4PHP66l4fT6DIxcVadY/Gxrf/QyZYjWEMkfM9erFuMen4qoE8S81ZOz?=
 =?us-ascii?Q?oq13LswVOWemd1pURXejLxLig35XfkNknbngaYYXosaeMSVHq9OY8oYub0tQ?=
 =?us-ascii?Q?c6j6V7RLxtK1y07W3SWrpZ1eIP51G8wO5U1e2saI++bLSYz2rwkgxIPDls8V?=
 =?us-ascii?Q?cEGGtZuwwCzIjq6tUWmK5NuKUK9FjsgrMXipqwB4+hHHE7BcdlBTqW7C2Rti?=
 =?us-ascii?Q?Ae7S4MhwOprVkkhLAw04f5QKtLk3/p7scSHVCPCxEG3LboXwEvlomFwXIT+i?=
 =?us-ascii?Q?cyoDGvOWCgkcV82yStT7upy7WnNZ8NqaTjhCDMcgLICI/OaR7ZKPoHWKA5/W?=
 =?us-ascii?Q?V8keX40qDbgVsjGg2Q5koy0tKEiA702pwVMT76wd1bcLXDf82tDRi8xRhBXN?=
 =?us-ascii?Q?0f0gtIHH0se566KmHG8b18gbli5kQe2pUC/TLsRKByTShZ9S2Oqk2/+0zgY5?=
 =?us-ascii?Q?o8dglKxkPif+SBUvkFLwBXsgaUUM+nfvLVLYZOCYKiC6xo6K9RxCpUxL0qxA?=
 =?us-ascii?Q?JH9P5I9tFwCPWrhewDwuwmDdAu/+PcU/lrxaDBL1EmrZIRjwW+QANbbQ/SLw?=
 =?us-ascii?Q?xh5a14/uLZn7ttOnjY8ockToT6obL3/XpXW35+DhtBqfEFQp7kW8KXIuAgAr?=
 =?us-ascii?Q?m0mx1bFO8xX5OKpuHvR8K6AfRKJLyVFK4zvqAdgaMXKrM4BOGLPVydKy1rl/?=
 =?us-ascii?Q?9xoMqqeozRhQ6OSKFXv5LajOOEbFIt8jCqR7jDSxiU4yiBeTdFagkZ53q/1j?=
 =?us-ascii?Q?kDA/qY9glR2c+Lx/WR9ez3oaIriUhqNO+jzHu40vShpF5AL4Sd3EJ+IxFk4M?=
 =?us-ascii?Q?xmS5okRAaTN80tafHJEMA4I3ll8oz7c3tkjeQwNUn7a75MXmBAnKGKb8vOYA?=
 =?us-ascii?Q?ho7ahJKT7O5wXkT9Q+ijJWVReO3EInNfmrmso0f1YpOT0sLt2U2925BKVcWY?=
 =?us-ascii?Q?1ifWyTrgdqDvWwUY8hNcZM+6sPZzh8lfv3zuJrbvdhmfCisrlatM1o7/0n6q?=
 =?us-ascii?Q?wmiMb0WWJot16pYmYCN1WL4p+RYHYKmDSziE6iTrmQxzK3tixKXCW/7qvw/5?=
 =?us-ascii?Q?nn1eb0Y9Pi1gC0AtRJ+uUnd0e7TOcGdLpeAy9V9z1upoA0Gb5r2udF11pE39?=
 =?us-ascii?Q?dYNJp5Bzwqp1mcH7y5MLJfpKLWDvD0WNPioRuc+BX1pAG8IhEALVezX3CYnm?=
 =?us-ascii?Q?ngGYAe7603tptJj+Z6gC/QHQwZaQ8vksQT1ifRzxgg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305087e0-a214-4bce-d32f-08dad367d4aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 06:46:52.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JACYjjtRsnfVsCy4VjG2QDlBLkqRTKDncJTbcVs5XbFb9/mkkX6yiwG2MV27KbT0BKuofmauRvO6LKlRV/7Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8523
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> Remove checks on job->request_len and job->reply_len because The followin=
g
> msgcode checks will rule out malicious requests.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
Acked-by: Avri Altman <avri.altman@wdc.com>


> ---
>  drivers/ufs/core/ufs_bsg.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
>=20
> diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c inde=
x
> b99e3f3dc4ef..9ac8204f1ee6 100644
> --- a/drivers/ufs/core/ufs_bsg.c
> +++ b/drivers/ufs/core/ufs_bsg.c
> @@ -30,21 +30,6 @@ static int ufs_bsg_get_query_desc_size(struct ufs_hba
> *hba, int *desc_len,
>         return 0;
>  }
>=20
> -static int ufs_bsg_verify_query_size(struct ufs_hba *hba,
> -                                    unsigned int request_len,
> -                                    unsigned int reply_len)
> -{
> -       int min_req_len =3D sizeof(struct ufs_bsg_request);
> -       int min_rsp_len =3D sizeof(struct ufs_bsg_reply);
> -
> -       if (min_req_len > request_len || min_rsp_len > reply_len) {
> -               dev_err(hba->dev, "not enough space assigned\n");
> -               return -EINVAL;
> -       }
> -
> -       return 0;
> -}
> -
>  static int ufs_bsg_alloc_desc_buffer(struct ufs_hba *hba, struct bsg_job=
 *job,
>                                      uint8_t **desc_buff, int *desc_len,
>                                      enum query_opcode desc_op) @@ -88,8 =
+73,6 @@
> static int ufs_bsg_request(struct bsg_job *job)
>         struct ufs_bsg_request *bsg_request =3D job->request;
>         struct ufs_bsg_reply *bsg_reply =3D job->reply;
>         struct ufs_hba *hba =3D shost_priv(dev_to_shost(job->dev->parent)=
);
> -       unsigned int req_len =3D job->request_len;
> -       unsigned int reply_len =3D job->reply_len;
>         struct uic_command uc =3D {};
>         int msgcode;
>         uint8_t *desc_buff =3D NULL;
> @@ -97,10 +80,6 @@ static int ufs_bsg_request(struct bsg_job *job)
>         enum query_opcode desc_op =3D UPIU_QUERY_OPCODE_NOP;
>         int ret;
>=20
> -       ret =3D ufs_bsg_verify_query_size(hba, req_len, reply_len);
> -       if (ret)
> -               goto out;
> -
>         bsg_reply->reply_payload_rcv_len =3D 0;
>=20
>         ufshcd_rpm_get_sync(hba);
> --
> 2.25.1

