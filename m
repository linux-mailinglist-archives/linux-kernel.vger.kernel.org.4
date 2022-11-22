Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C263380D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKVJLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiKVJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:11:29 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505883E080;
        Tue, 22 Nov 2022 01:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669108288; x=1700644288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ws82VtXZjRbSgry0N+HZRJh/aYKU3y+8h+QjPRjLH/0=;
  b=ht4v/T2viKv+FdU8HJUIk7UtUlcHjvto28nRjZ1a+eKSgcY2bMIKZF6Q
   7hwnfgao+Ntbbx5QJeq/1hwVq8MSg1yzT7xPdeGe6kmR8UkBuJSC164nv
   5rMwrQGBKFbfgX9Vck2LpLiOZ5lrn3xggVYiLQ73G0uztwSlpvxMexdlC
   iZ2/VgqUS3IV5w+GkfBPnANxH2ndb4TOquT/dbMKWyCNryekDCWS5J4FG
   elTylgiDj2ON9QWqHL1EAfjf73y1JMfQXsESEirB/rDRbdZJ69NpPbbKL
   2OPOBq6sNzAc/upVCoz9nlgnIqrfqsTkfgw23ylN5/2V5eCVCwwnAlYgK
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665417600"; 
   d="scan'208";a="328979075"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 17:11:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddNUsScUn+UrF2ovjskX/KyhwygmhRvotIvAGN+/F9Z0qZnnjyqV1O19YGs/oAfGTpuDe9+PBTCcqYVkffvcW2rP4aIjSCqu9z8XMsukibvl6jCq1u14BQgIOqGbD/XVWChrK1MYC2MAzGnQyL3ElYgqvWLs6xwp1eB+9aiA5XG7/Xa3T4W71eXpa4MH9yWG5bFeVCb3OWFdEW5ll9ZJTs/fXSgSSUB7JtfRCgfc3570xlpHZvYmoQymCcCaHubSVJ7Q9X7A4ttDgQ4qW/5dV6vCBVxoDWCCY05Z0GSR4l64RCBnIY4XUIaOKPWDmI/GPXE1YWasEi6rUGA1stWiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsbBIErCBOnc6VI+9Zoui17xzaGwwFys4lrkAKIDyn4=;
 b=bc2Jp+i7CgKRfq9Fpl7EU8EKxNapq5ON3RGpCn9g+QnnVNpsZhypw0l+3o9OThqz1mXwOXJavT+5TMWoJJ2sbCXYReXcbJJRbpUVf6ZhMNzc3TKorIsbFYbEI6TSoYNVFinc53j0hDwIjTx84e1VHULa+x3FAz+7bvKu51hklhTM2RXhfFbzjHSYOB3HV9356nJzSIECyLLzYtUQTA5FuL0IQWLbRDlAG5kkoC10ylnQ9hQpwLobV96a4sNuDiOy9Ypi+gJjW83nhZkKUayVDDnAdK0YBh/UXpQBLUyLD4IhFr9nSGfV28QkXmwD/4lH4Jciwrn2NEB5V/DE/m1ApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsbBIErCBOnc6VI+9Zoui17xzaGwwFys4lrkAKIDyn4=;
 b=ERnZ1Lan+3EChHxYrvUlZ4wgQu2AcZWwS0KyP1mrV9YSjIpGYUmhhU8Z7VipY3lEmoeIsJvrgtMMqplJ8R7aPnGTwrlCw3TAui9bweCg6VGBMrMBWTMH9KRpnwA5BlQZ7sjdtykHlOnRRP3iXEi/6Nh1MODpXFH+zZXWfMYW1rI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6749.namprd04.prod.outlook.com (2603:10b6:208:19e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Tue, 22 Nov 2022 09:11:23 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::1afa:ab74:ef51:1e72%3]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 09:11:22 +0000
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
Subject: RE: [PATCH v2 4/6] ufs: core: Advanced RPMB detection
Thread-Topic: [PATCH v2 4/6] ufs: core: Advanced RPMB detection
Thread-Index: AQHY/S6iEuB/JGeCyUWBz4Z1Mwdk3q5KqNYQ
Date:   Tue, 22 Nov 2022 09:11:22 +0000
Message-ID: <DM6PR04MB65756FCBE16EE778DBF86D2CFC0D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221120222217.108492-1-beanhuo@iokpp.de>
 <20221120222217.108492-5-beanhuo@iokpp.de>
In-Reply-To: <20221120222217.108492-5-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB6749:EE_
x-ms-office365-filtering-correlation-id: 10705ac0-e9be-4a81-b3f0-08dacc69869e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcT/HmlU9eJ9r2NTkDah7dRkrxcCHvy6eCxs9BhD5crikO6dJxQNh5mwOCACEzrL3QAaNuzCClmnrVkFohm3K5D/gIyPI3tiyRureNHQ+ho8PDclwoS+6ce19MI7rsxbOTpCzsdqMOWh75LKxIXGSUE9YiTKFVXoW/x6U4U2eO+ZpAxsoz4le0dg1XCkcvhSPi1a+eRl4i5Ed+QwWHrXzDjCeKnDC/xyFaThAC/4GLjN3oUP+11b8c4UGLhT2rhQGb0ZoIDp2Do++7SPxmNqJ5STbT2W/x/dDLQUzBEP0169JwVsM3XXspZbdOu0zg6xFj20j9wZF6MO209BEt1T8LSvlsqFzxQWCcPz7sgMEwPhG4PHjpH3bkK3YMx1JLbkfHOQFp0Tp5OHAXzwRKY8RkQ67WacLuZaabKnyRg0JcVFzuBTS1vLyBPQWaSh7NQWB662yAxYt4iWhnstc04jGAZ4AO1J7qmxRrNwNpF5qd6w/bzMMmvUJj+fcAYbQqUTiNtoVJNZYP45S7jhkwNU26QE45onquG5tYrX+hIfYwlEBSf2JfmOyEJpqQEw4nGrQuFpq1r9yUX5Ssm8gEb4iKGsxCjAGdPbxVZK9qxluvfcQxDurom/d0ZErw/IlQW/jB5Oa4MRhjRhPTR/9F1qcLsZ5Qh9ne+E3Q+9ASLDpJIIIWYV8J8S6uEkKflaEoeXyN3o3aMenUUI+ToKDmEDX1YT9bib5dNLyAAK0qyeTAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(2906002)(66476007)(64756008)(41300700001)(76116006)(66556008)(66946007)(66446008)(86362001)(82960400001)(33656002)(55016003)(38070700005)(110136005)(54906003)(7696005)(4326008)(122000001)(6506007)(5660300002)(921005)(38100700002)(71200400001)(8936002)(8676002)(4744005)(52536014)(478600001)(26005)(7416002)(316002)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ivVU4mUKlmlI6ei3Fi+k2YgXFOB//XQLs8STxH0xb5/xcujsSAPrkkRUPcu?=
 =?us-ascii?Q?NiDVgkxHV7JHhtZYLs5MHQx/PvN+yA8q1C38RUuQ3CcaNcJPVFcn+pd1DkfK?=
 =?us-ascii?Q?1Rzia7+4LpBHp5m8p5qk12W+DGBvpDmvL0miiF2YBRQJDf8peuL//vdM+FLg?=
 =?us-ascii?Q?gPM2DAasacMnrO3GkJ+jjphp9WObuwCr9WuNcTynbT0KRQmJ6KgVoi3m4B5P?=
 =?us-ascii?Q?7EVUg1icMkGaFgkJJ3r6HxqInvCQmnESmxmW/L0VV9nFxQ2GzGltQtGXQ/iZ?=
 =?us-ascii?Q?5mZK87m4IkNkifmVE6ZQz74wXP8AcnEEfJiNQqhwP0WaSw4ruO9jk4DgVSp8?=
 =?us-ascii?Q?O3jJiBWQIBlysANj9/NyINBw3EkQ5X2Np78mOaVAwGjRUSo0QiVWPXa3/uLe?=
 =?us-ascii?Q?+4A3YfRDEeq808Wx7SCLtUquL9oN5eTHFrZvGRl71dY5deF7pXcTIoVtMBSG?=
 =?us-ascii?Q?ynHoR8tTOGrDOwp9SI5H24Y69ZCjeJl3UCUyrT/IB3vPLcGHE4S428cmj0VA?=
 =?us-ascii?Q?8h1BJTJ9+y0fQBNKp8eIChpN629WNCjctZZP0+tFLoApIDiNp6B6xsQTIyxm?=
 =?us-ascii?Q?uDuGgcRnrwW2ivNhZXxIQGJSFnVq7Sf2GessIwOpw96GFkuENHtG1dDOpDgM?=
 =?us-ascii?Q?NkOcUEUycPQPNDpCGMZ5wDCi0P50CIxPB/vrhedJTg0qIzjpkYzkX3y4N2hB?=
 =?us-ascii?Q?kBTlbPoPbEf/nqGJR2c3zDgVBKJ5etfcDwDkuEJ3pW8PZOw4HKikYBrcxqNN?=
 =?us-ascii?Q?uEaCOZ/ac1Wel7t7NfppWyu6Qj03VVGTv22Z8Pid4ba6cw2L4Xkbn/edQ+G4?=
 =?us-ascii?Q?DqyzleVyXyi57s64v0fq2CNcByROi8ykLihPQY4fhwjgGycespUy3MVASlDN?=
 =?us-ascii?Q?0hpZ6u1xFVT8HxTQhpw3JWNsap0DZZIGM1l2nLooZrRUNDTKO7KRH9jzB/vz?=
 =?us-ascii?Q?tbTcsvBgr+bGy9sbXNMYXzWf3FxKjVSb+mkaZCKCWfF6kMUtCq3I6bPtm3dB?=
 =?us-ascii?Q?gYCuvxehFNfSTlT+VfjAi9IuLEA2UAj//3DZiMXpccNUIsti2J5YoXP4cOIH?=
 =?us-ascii?Q?6q/YfScvFogINntl7wIa5wyhMHRyVr2kgBx6xMONd5gYJUQifHxL1wlHox0X?=
 =?us-ascii?Q?MHG1Va2/hr3h1rMFUWQBBZvBoYznWu+fE91mwi+1hecyYbO7NSO/WMv3MwZi?=
 =?us-ascii?Q?IUA125PN+VZnp0Nn/Cy02iwsX9mcNtnSj2yNuugysHEf3qoIGPbmglBeyYEV?=
 =?us-ascii?Q?8SgNviB8OE0vphvOFNrKMZShAFAgmwbGZI+iXqcq4HzgfnCe1fDS691YhmhK?=
 =?us-ascii?Q?AKjLP6M6T1lktGvgtkOIOLps42dUk4w4h9ptgc91CNjUVh8HM7hLJ3+li9pj?=
 =?us-ascii?Q?6bfuhisWblXdR8b8AZiYtWOqMbv0V80fphD0yAQkTlleDeN7G3txczg8sful?=
 =?us-ascii?Q?zseM1bSPa7NkMpRz6LGRGApPcBTjjT0iK7opv8/CZPAQyeiGWE9kfgr21e0z?=
 =?us-ascii?Q?74B9bsFdfvp6zzS6IDsfhVUN4lNb9ZXHwPYiuKJ0HbbKA7Qc4yMsmAX7Zmhf?=
 =?us-ascii?Q?xq606EGBG7vfNt9oeSTy3gVetX3/dWzJ1/2AgKnk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JtgR49w937oa04CQrc5TTsAZtoG7n3Q7vRmAV8B4MyT+HQo4qmY8VZIkrEml?=
 =?us-ascii?Q?OGxg2uI2ufmDc+JntxERHxGb7C9RR9gxZ80DW22xp2AIl5OZkQQh1mEtw9W6?=
 =?us-ascii?Q?n3qXDZ1YANevrgUHshxaFV+9HTye/CVKNiYsUN00JEJRLsKHldmsThK8SVTJ?=
 =?us-ascii?Q?AdaAKR+Azdk8pkmKd6taQ6gaHj4Q/5EwO5NNZI7n1cyK3aGbGB9nVpIbf6Ru?=
 =?us-ascii?Q?hAJKMjDhtjjUSu8IQorUR9U9AB4rQupi+ddD3Pyd/iMg3fBQbDN6vD3MrSZN?=
 =?us-ascii?Q?FA2dBBqWfqUjG6UTQF1ZFkfcdecZRBffrUOHcrEYfLnh9DDDCoMvQO6aH1cx?=
 =?us-ascii?Q?IRxgv8NSb5q723Ha/xcgR+HAl6NcldcdnK6Zj2YrEpo93xeQNjdDgvbt4+2T?=
 =?us-ascii?Q?Rc8zkJrQ3aZNufVVo3ugLV6EvrEVRPTCbCC4e0qebmSH9HKLuky9ogVypQnI?=
 =?us-ascii?Q?9iLOUCIXt6UhmpI8aHlLUni5ODEXehlOcH3o284bWOd16g/ttozC0iJAiW3C?=
 =?us-ascii?Q?Fltwmx8V8HL1JNnD18L8MYnyscwBbYR/mBPEMnVy08dl7V5LfABNVipzvJ3n?=
 =?us-ascii?Q?byP65sdYUfC2Rzc4CQfR12MEM4D+mOesJIfXOTUi1ZDcRmHIFFl6Fx8RQPAy?=
 =?us-ascii?Q?tlwLbyU2g6dfHN7qCiXmppS4vzlcP/ZV+Ys5sdWCdmhYXGIJfTm5SrU42mcZ?=
 =?us-ascii?Q?TQu6FLNKmROSTlf8MZZtZ4We8vAr1citapS+WM16NblJeZP8yTsAkmV/dWxC?=
 =?us-ascii?Q?QhYAHJIUV6Gaq5KgYT++lzI+22IWW1UTcWMp9kjPgYp5DXbb5+a4maY7hZBe?=
 =?us-ascii?Q?bK0NF6XUeF2GYe0Cmc+bUITTPh5kTCmscMBYE4weUjizQJ2eeRNq7Y69dZqN?=
 =?us-ascii?Q?hpBt0pe23n15Rao9iFjdgHkdUGFUh3hAPV3DD2onkRaXSG7TLpz9mg1/zGEA?=
 =?us-ascii?Q?q6Tdmgt1a6Q9SYZurAl3n/+fWfXQO1Nj6xhu8+is1vCf7uleU7CDneOCBinN?=
 =?us-ascii?Q?ZJPsFTJtIdn54Ff7/PpgIpWbDem3P1bEwF52ADIYY7ntQ4vOWYpX6NqYGaFc?=
 =?us-ascii?Q?6qroTlXYW2CgOksUeBWzXfZEYyX8j/0n/RaMGiwYZ21Llhkk3danxv6GW+oe?=
 =?us-ascii?Q?zTurIRARpUx/D7RGZ1VrJoLERUODu3W2PqcgmAEXFeuD5jjvCiF1/BKOrxDr?=
 =?us-ascii?Q?xALhPw2RKYNPjg4aFcY03XPbrLsTWtZxXtATsSh7NOmyIZ3S7MgA3Im3Chtl?=
 =?us-ascii?Q?GtQnAK/3pWweWQnb1GgLTY9PWTVrLRplC+mFDr7NBg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10705ac0-e9be-4a81-b3f0-08dacc69869e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 09:11:22.8057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: juoDzYpDndtvA3f8nrY4acdGCyIE34z3IZNk+zxqd64M5/SM8NnMn0Lo0kXQMSUdGBWru0ypXdtG4wpl+rON+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6749
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bean Huo <beanhuo@micron.com>
>=20
> Check UFS Advanced RPMB LU enablement during ufshcd_lu_init().
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/ufs/core/ufshcd.c |  6 ++++++
>  include/ufs/ufs.h         | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> 1b252e6cf93f..311172578fd8 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -4956,6 +4956,12 @@ static void ufshcd_lu_init(struct ufs_hba *hba,
> struct scsi_device *sdev)
>             desc_buf[UNIT_DESC_PARAM_LU_WR_PROTECT] =3D=3D
> UFS_LU_POWER_ON_WP)
>                 hba->dev_info.is_lu_power_on_wp =3D true;
>=20
> +       /* In case of RPMB LU, check if advanced RPMB mode is enabled */
> +       if (desc_buf[UNIT_DESC_PARAM_UNIT_INDEX] =3D=3D
> UFS_UPIU_RPMB_WLUN &&
> +           desc_buf[RPMB_UNIT_DESC_PARAM_REGION_EN] & BIT(4))
If instead you use bit 10 in dExtendedUFSFeaturesSupport,
You wouldn't need to add the rpmb unit descriptor, just the appropriate bit=
.

Thanks,
Avri

