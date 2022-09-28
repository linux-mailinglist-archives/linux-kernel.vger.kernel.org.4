Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B345EDEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiI1O3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiI1O3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:29:02 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE19AB05B;
        Wed, 28 Sep 2022 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664375341; x=1695911341;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WMa5OwbYadgTJ1WnmOF9FSGDBHDtw6bkSL4zE2bq6HE=;
  b=Pv5UbuIjux4n+xKUMsL4tifRAZsUi+qhzyIeVHAmr5tntriF7Gjw7osk
   BBhH5mI73gki8bXP/kxc4pg2SrzomG0p1sTv/SLnHpbCTFpsojADoBO4E
   iRfIApEYXu2kzZ+K+tPPZNiuzXBANziszOxFLiUs/xsBaZERVDhQmFjVI
   dEOqTWT9F5CBGT5yDusDGZE6UMRGDNSiQBsWieBsw/Viz1DGvt4K0n6LQ
   HRzdCAgLBQLeV1LAaWV6iwIU+jDfDloR1M7iVCefLanei4xIXl0JqAsiV
   2J7oMo6W2Bsgv07iP0rQfqurT5Wsh97hsMgmXCCADnaDBvLinGc6JojIa
   w==;
X-IronPort-AV: E=Sophos;i="5.93,352,1654531200"; 
   d="scan'208";a="316776061"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 22:28:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8onm93nJHH0+PmZNvkT97JqbiK3L2QQ8Dj1cj4eSND/6wSK3MxHEFldJEihYwPUWNxVJYACAtuEOmoE3uvF+xLnPkSyWPzzDEo6G/UVnD62xxycOzz7xy5b8oVESOKVij433ew6O6YGUfmB6unK7ze0Es6Jzr6ZJPXx/zfHxlo+hwW7fUef+vgFP3juUHW/MYJ5X+W7LQi8gkBGuAwhZoQqtqlHGU34M7w9quT6TpZmg7SYqwhJ7Xh0ryJnEAa+/GyV4ISzOJDdJ4JY+A+mPGDC40WFVcfTO951XcNQ/hEwtIrm7ETf2SLkw5Cm3KgrfAEtUJ1w/y9VZ7PD7ja5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UD/puM5uGMrFjU9HnH7LjTXY/NOTWu92v87ok914qs=;
 b=VH7VQqRxp5t5CGmGe1T3q9h7zYHaS1IHtIwx+MN88CfURDXUFns8ZImh9uMRuJbc26iNQDtSDTj0P+qBPdIZEvZVrOjemwpGgXQMcO/99+iORJxs7+VnPlg5INmWuijSHNbJlJCZnqD8qYCOHMXcgoCmyk17xFjvDolzEF+OyXvxdRkX1aTRBl+vEtAr8oStRicyXCHLvtIpGISUQuFJeNXO5oEo6x4ZdDc6vMZAlVzJUCgeT65QPefX1I8mFU0QAvqYY/QWJpXAJd+zWry6KZsNRmJMT4iAuA8re8Bo2cNjihiYYHWS7fHnQV69IZksAmOBixNKLhwjVoAAh8ULTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UD/puM5uGMrFjU9HnH7LjTXY/NOTWu92v87ok914qs=;
 b=UCZQO5n+g0bk1ilvLYAY+8HCP1/kZEPTZgJMsyIGRv/4ffWwBgb3/SdTwMiOgwANzoqeyFFVsZu2L1Zhn1wEosSc8zLTZUG5M6TsxvdsOO3PgCkB450W6x5shNlnx0qVSlEbFulfGJG966wnR6w7+60kg7rLJcG1BYe+W5C5tdM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7098.namprd04.prod.outlook.com (2603:10b6:5:243::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 14:28:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 14:28:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     John Garry <john.garry@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "hare@suse.de" <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "ipylypiv@google.com" <ipylypiv@google.com>,
        "changyuanl@google.com" <changyuanl@google.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
Thread-Topic: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
Thread-Index: AQHY0zapIGo+Met9mEGqTMQhhuqFnw==
Date:   Wed, 28 Sep 2022 14:28:57 +0000
Message-ID: <PH0PR04MB741645FA3CC7BE2C24711F269B549@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
 <PH0PR04MB74164CE477846FFDB843D5419B549@PH0PR04MB7416.namprd04.prod.outlook.com>
 <99efb876-69b1-eb7c-dfa6-8ac621a25438@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB7098:EE_
x-ms-office365-filtering-correlation-id: bd0f7301-3fa7-4a21-fb8b-08daa15dc724
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rk1YoWX6U4Z5Ju92QCzxHVycZERsB5yOgcmPmOwKrF0H7o7bnIm02NV/+hMmBskh8087ZWFFvsbV5vuRn+3ZqJOaGmosHzpQIZBNsqCGKa5edLdN5WNoivjtlBc19AjZcMWh+D00OawdwJ2UqC389RKyAAibX2Gr5740t8GsHDpzKRY1LGKiHy4NjD6KsxzYRsOgx3LRv6hwHHHFeZ+CcJKJI4hcMVGcJ3nQRBhH0pX9BMs/Ec+crU5AysGAfgSMLvKaHTBHd3Nplb0cJPPfBiypCkKwEsoCPuKG5pwgWhejxR9uVreqRqS04GJT0mVjfcdUnTC6NZp6aGjvHZdkrZch4BnUHJxQ3GuJsXA++uZq3CAUoyS2J1aS+Q6JFWdDcs/HWsOQ4lv6lJwvRSba0EWBADiP9C15wb4ZEdh0TnqBMNI3xtH6p2fFwxD3iZwNN1HI5TgdyZbjh8PPXzQQK9lhN+tJ/HbOGH94gtta6TrVmOllrQ5QID0SItNQvimgtf/qLS94GaP4DWsAFRZwCTaYAnzvTWMQ4PZ9LTe46AJnzZIgQNNBKk3SAtC0lkhLwDDENpJ8HXB+O2fS/sQKXQcV09i9FGgQj4GClsypUf+Gzzfvs0CoRf8zI7WGPR333EI2XTqyVSEbiiXleJ2lVXWaWkDy1P16gdVa1swOqcNXt/JFRsg2VXVsJUaBIqYALNHifAXcnLdrzBuPfjBWA19T8in3mf8EZ3BPMIpiJYhN7FRtqOQe6y/Tq+IVgNr6VJ/ycZEYvnZYv2TtaucEdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199015)(66476007)(26005)(9686003)(186003)(478600001)(6506007)(7696005)(38100700002)(38070700005)(82960400001)(316002)(2906002)(83380400001)(53546011)(71200400001)(66446008)(33656002)(54906003)(6636002)(7416002)(8936002)(52536014)(110136005)(122000001)(5660300002)(41300700001)(91956017)(76116006)(66946007)(4326008)(8676002)(66556008)(64756008)(55016003)(4744005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wBoBHaEqExTCy8n3RHXEsbGVtBA8aJlrTZl3krddTL6HhPHoSgeWLPoCmzlQ?=
 =?us-ascii?Q?YvUij85gOoIzJ0OleVUDDWIAMAMx4sZgO71Usvbm02G7Kta9uukl02SbJCeb?=
 =?us-ascii?Q?FWlzIIJcniOFVdjfPy9ZEItLyj+Ukf6Zbh/uTzLxAZZUSR9WK/XkwG0I6h1O?=
 =?us-ascii?Q?YnpqMYNOw9732e+xYbAc+WiI9IRUlzgicY9+fsbwXWJLdWb+/4qpIBY2yXpu?=
 =?us-ascii?Q?wpPEy2qDGC7Tl4Qmdv35iEHY+bONeYdTVc+DA1PNzodBsyumu8aNb9PMDLfh?=
 =?us-ascii?Q?D9NsZ4nDVOtkN1eZu9nn6BBu2FYCKB1p4C0wYll7+33OoK1q9sZQD1kT22P+?=
 =?us-ascii?Q?Ev8pVd/G00m7sUf8PpwLJj4hd6RYN5+Hxydu2Ws7dHLYwLATzzfK2lTbqrKx?=
 =?us-ascii?Q?QT1TJIsbyMhAYeBVb9KSYlz0GxoOwWBkMJts2LdPjAU+HZpg7G+Vs5CEPxXG?=
 =?us-ascii?Q?OFnkCbgL8Ulsuh7uziGNFJzg1npKjPiTuFo9yo0Eyq/3IIpSNdj0WuRxoP9/?=
 =?us-ascii?Q?bDgoXvrGfzmLdxxO7Qqb4z6txa4NFv3hpScMBK0NrZvLrS9YN6G90iYODji6?=
 =?us-ascii?Q?H54C8YiCsnj3310Hxaq6udP8mryfg8OwPsLRD56sX5vMtu/+92IY0akOTtIl?=
 =?us-ascii?Q?cCsGrAlzuHD8ti7YHQw7RVDVPIvEYSYjtq1TLAGNminO4Ja6c9yopMWI0/3a?=
 =?us-ascii?Q?fkTTVFm0AnlVH7knyq/qSJKUXJFygCDhFC17wmCmhKqFLJTkFkyMFhZs+kSv?=
 =?us-ascii?Q?xi+w0lBEYOP9sYSfBmBGy3alTZ/ruIQVbwEPnyLy5i1BrWuG3VLFpNGQIkMV?=
 =?us-ascii?Q?opHCjtKmvqBMwzvNbAEC/gPtPLyFK/zdo3BBpiogy4BjX9d94Pa83HEuJ5Jh?=
 =?us-ascii?Q?z9lqroiOccKW0rJH6pEUiPmdA9kCL5oNdEVVzf1vofSkPKm26L9pQC3rSTu7?=
 =?us-ascii?Q?ibMrk2eZt7hBGbhxLGo20YZymBN/7RShPT40ZyT208zzaVKiejAEcGazMIPj?=
 =?us-ascii?Q?55dxpDWkINDervQ3CDQEFSI3Qyidoo4qxP5Ug7RNPXi8Ts9lHLdms5vRZPj9?=
 =?us-ascii?Q?XsQ4pQz5U3UB/MEruGoYtNfKcxzLRctwaB1GDRxDZfB5UtCCXcbAZv7mz9do?=
 =?us-ascii?Q?Qr8oMNsc+B8dYy1TRN4oN0q1WhdzU5mJVoHu1cCpUICMNoZ26ue/Xw/aUHwN?=
 =?us-ascii?Q?IwOYbcnDyIleRKB4zk9wtbEKYO8jMPHLESoeQ9LDMHH3vmb7r2a3qLHlWXMp?=
 =?us-ascii?Q?eGNGJWqGEBS2To3PnZfZX9MCHQHbNb09YKdlBFbvzuKual7LCBnLc0i1OUoW?=
 =?us-ascii?Q?ZY3ft949JNMP0OL9cm6er/kN0kJZdBhNpc/CMheb8XzdTv1CqSqfhkaIWfCm?=
 =?us-ascii?Q?0WKziNttCwJvyjQbQyeJAYEzytqAL98MpleJdgtaETIPxv53SG8nUsRKalvh?=
 =?us-ascii?Q?3sZXQRwkxtbg2tzpdv8LC+2B9oQ/V5Wp4F2fgC6upO+PFwhElA23R2tlVYij?=
 =?us-ascii?Q?tL2H130dHyu+vUCuHI+o6MML5XqTsLkpTshjC3orD0OeZbWXxAnFwqmV86Ev?=
 =?us-ascii?Q?GGgqU7HU46iZ6OOiJmVr9+gaYxFQnTntdfk47hoXeqiIIcYgIjrh6DPkYYmN?=
 =?us-ascii?Q?KZt55iHOdja/Pf18Suiuo0U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0f7301-3fa7-4a21-fb8b-08daa15dc724
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 14:28:57.0997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNFJC5EA+37Aukjwd7UtLrrXbz+U1NIiXBD8CPAizjs0fWH61MCzD8y4t8JSUN2++ZVCBYveuEjUIE+njj0NrGYvOufyMuyoT9gHiyXi3a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7098
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.22 15:56, John Garry wrote:=0A=
> On 28/09/2022 14:17, Johannes Thumshirn wrote:=0A=
>>> +static inline struct request *sas_task_find_rq(struct sas_task *task)=
=0A=
>>> +{=0A=
>>> +	struct scsi_cmnd *scmd;=0A=
>>> +=0A=
>>> +	if (!task || !task->uldd_task)=0A=
>>> +		return NULL;=0A=
>> Is anyone actually calling sas_task_find_rq with a NULL task?=0A=
> =0A=
> Yeah, unfortunately. An example - the only one I think - is in the =0A=
> pm8001 driver: pm8001_ccb_alloc() function which takes a task pointer =0A=
> which may be NULL, and this function calls sas_task_find_rq()=0A=
> =0A=
>> That doesn't make a lot of sense from an API POV for me, having=0A=
>> the only argument allowed to be NULL (and not being a *free()=0A=
>> kind of function).=0A=
> =0A=
> I suppose that I could change to only call sas_task_find_rq() for =0A=
> non-NULL sas_task pointers (and remove the task check).=0A=
=0A=
If this is done in only a few drivers I'd go that route TBH.=0A=
=0A=
AFAICS hishi sas doesn't call sas_task_find_rq with a NULL task,=0A=
so it's only pm8001=0A=
