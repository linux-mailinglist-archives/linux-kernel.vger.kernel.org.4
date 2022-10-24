Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F160AF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJXPee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiJXPeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:34:14 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A69525D;
        Mon, 24 Oct 2022 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666621285; x=1698157285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wsHBfX/ubdY9e768bhvVqCoUEwRn2o1v3S4qwOjspcA=;
  b=j/2bp+NpQ6WYsjL/CpRS4nErJvwr40CRcnwSxOrd7bgqWIboxhxWCvD/
   Ng3OZbnvxAwgThU/g1bQ9bFLB0oQfZZ5PSZ+Z3hQl5EtCL/eCF17sGUNw
   AsajbezAgUntdVV+wNWmMV1D3DJ1Z5W5MNWxZYIB12f4eiF2gXZepYTjT
   3OcmmcdM4qN9k2X9oMs7U7yNBQRrzVNw6mi7mi89JbLzGVkuHIZiYTTxc
   VHT82n8gvqysaH92k3sEcY/TrhLkTsJrZnq9MJIDyDirNFTEF9/FPYfTo
   ZBYhSeYEU5FnI2WA9qz0euTnpqn9WrihkGJAsbnTkJy8SawbxLWReUjsa
   g==;
X-IronPort-AV: E=Sophos;i="5.95,209,1661788800"; 
   d="scan'208";a="219756499"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 21:10:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HN9VjWDAZ8ErE/5JxP6VDD5gC/X5o1OTE2ZKb1z3BvHsq65ARzULERefMdFrEp2dMI9CaTwoc+nduuqUC5x3t6Z2bZg1QRLlu+4TlPSabL+CCbnrVwmM3D5nFLmZF55mQWeTuWSPQ1LLEp8CcCjTMKD22Ra5imDOZpH0VRihjMzjyn6PWM3lIou9Cq3tw5XKgEw9VyZYSBvzYy8HELgrsk7fJc9eWwU06F/ZfyFQH2SABF5QLGLS7sUKFgNncUFe+mX1V3DqP881dvFy4St0kdVpCf/x7Y2nCOnRRvc2YfWud8AkPvvcJsZ+zmHe8aGa0v2ut0757FauGiQcLuIQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsHBfX/ubdY9e768bhvVqCoUEwRn2o1v3S4qwOjspcA=;
 b=KVw0pzbGcI+pU5HbU5Qwnu0p1KPREmfLMFC4K37TuLepUnnTVOdtGUuSXO6F1YM4V+dj4WY91dGbZMQa70OV+RS8YuQwIEwUSsmpizDWxVKUMgjtUR5fum2+Wxd9n8rfJF3/ZDxizD/Wevvld+xjKYR6Gn4xs6vp47ktpBrlbhj5zAE1Ns8ISgvnhTj7Sn93+lBzezHQOP2Ouiw39SAQw4DqlMn545ODSLPMOY+MVPXgSE6KxCcn9zOBpTeOEq9RZgNfI6Ev9CRgs5ySUDipMvx6bItRdI8hW7gmye/GYFfnVB6uHFAmN55ddKtrwn2cSIj/XC+r2YM36Pb5ML+Rcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsHBfX/ubdY9e768bhvVqCoUEwRn2o1v3S4qwOjspcA=;
 b=WfWoiyFh+oHV8E8E7kf4vjLn2x3esWeBV/oznBawkWzSGG+wOdQdGSrf55JpN1ENbOQJ2aMZL8QqFHax04XgbDlVxnEI6gRVhfuy/wvacDD2Cictcb1oVQu/uzVfEAdAv6aEo0NEKOR3DFxmK9etyddvynoRK9wCaSCNbAMi5K4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN7PR04MB4386.namprd04.prod.outlook.com (2603:10b6:406:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 24 Oct
 2022 13:10:07 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5746.028; Mon, 24 Oct 2022
 13:10:07 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     John Garry <john.garry@huawei.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        yangxingui <yangxingui@huawei.com>,
        yanaijie <yanaijie@huawei.com>
Subject: Re: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Topic: [PATCH v5 0/7] libsas and drivers: NCQ error handling
Thread-Index: AQHY1/ID0O3xyFitDU+9c+6EHqQqRa3+RKaAgAE7cQCAANLyAIAAAgSAgAAKBoCAAAiJAIAApReAgABn/oCAACBvAIAcAj2AgAAFlQCAAAcIAA==
Date:   Mon, 24 Oct 2022 13:10:06 +0000
Message-ID: <Y1aOrlmp3IDMDLS1@x1-carbon>
References: <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
 <Yz4BLTPkXqyjW4a4@x1-carbon>
 <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
 <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
 <Yz7qD+gpmI1bdw16@x1-carbon>
 <bc7d74dc-5aaa-1ad3-626f-df89955b1380@huawei.com>
 <Y1aEGW2BtdIRJy7s@x1-carbon>
 <dc61408d-8fc7-ca29-d284-0c92c2e1828c@huawei.com>
In-Reply-To: <dc61408d-8fc7-ca29-d284-0c92c2e1828c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN7PR04MB4386:EE_
x-ms-office365-filtering-correlation-id: cd86fa98-d7e7-4e67-7814-08dab5c11283
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7/7WklvWJyMPUPbH7vZsXr7Zrecxms9VEGKPeVKI81MMww4W916qZYbvJ4c48ft09Dt0s74W1EWaJ0Cbd6HxQXtgjgvFpY5OU+NwyIyS4QpAHGz6tbt0QwIf2HqGtZeDC3wR4njBI/TH2EprDBe1XjL67hB9JFQtebkronk3ZPCXyCsDwH9Lo9JLh/IZy5JrMNXvVKEXcgNwTspivbts/H46V91sYBJE/f0tu+JN8YhjObmXsFlfXwl4IBlszrFeBP0nBycEIlpbaBRWEr9Mzxcj/bdb6nlNNkEl/sFgLLUijZSjpDfb8b3wDNgHNC8xFjTmRKt9TrHR+ToghfJeRdJpZ+XX8CYnOgxymz1wuIl/pjY/kOl0aESLiyEevvYAw8ULAPZphxYGa+Bzivy4t9uUf0KxHdnubf8oRs4is0XJmKqDB3XDTlpUQr4T7GgnUmQgHiZgD+QozCiG1hAogMr3f/3p3SrbA4bQh5YABIDoG0K95ehaj392H6xk/4smISXIfd7XUlpt5PvfyM0HfE4nncQs5p6huya9CeBis1kC6hzjWrRW3dA2x0QhGR333LitPkUItJqnfa00aANqZrHXIfKfC+P7zfKDc6R+QqgiNpHcGYh+Bgy+JPe3O+jHKV9YiAsGY+m+S6PtmL0CKngTsPCXm9O6vBfGPhGnOvzlUCmvNT3ZYeEA/NiyUso49nsIlRGh/9s7UL+Z5fXYerKJf0AeifKMMzfiNJZhrotjkyZVjkpLn7rLDYkZH8nkAKLUWQI1ViswmSTk5kfDl8BEk9VoeUVdEWAYx6fWWgM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(76116006)(41300700001)(38070700005)(83380400001)(186003)(122000001)(86362001)(38100700002)(5660300002)(8936002)(82960400001)(2906002)(64756008)(66476007)(66446008)(4326008)(8676002)(33716001)(66556008)(6506007)(91956017)(6512007)(316002)(9686003)(6486002)(66946007)(54906003)(6916009)(478600001)(966005)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4i6sHYtIABwgDoVgiVSzsBbx6L9fQB73m1HXLccjBSIgcqiZEvx09YILXhQG?=
 =?us-ascii?Q?1mxOK8/PXBngjKRoamEP1vtqqDTyrTNWkeQsjzc0YWUjafjQuqH9qWMPPhRr?=
 =?us-ascii?Q?9Si7CXGMYSdqA0UIDPnlqN8YWBspAApWZW5cTpmkTI6IgWEbxV7dju+uluPK?=
 =?us-ascii?Q?pO53mRs4Xo9ZmHXsBO/s/oKJ/sZvjhWhLZXMjAwhhXJ05PcoZEuXrkjnPmtO?=
 =?us-ascii?Q?dVb+WK85I5aoN8OyNLFDtGdjGCpOMVmp53RAfIhZQyig8OyHIjY/RBmLHm54?=
 =?us-ascii?Q?TeM9qm/WbFFqgwF50AJrGM1qT2g5A2taeipUPVEbiMdQkKOxyqiVPkQSa25z?=
 =?us-ascii?Q?8dChKReNE7PI3vgM/xq0U8EqYB9tvlQxxpp556C1LkaD6hiR7xAc6doXW1Zp?=
 =?us-ascii?Q?Nef5gGJItHNMUkYy6Q1Zi74FBD3GuW0EOjJHioj7qvgPdXtepwNbEjNJJIvP?=
 =?us-ascii?Q?izuDxgt/CTztkHb0/fl7Ab6+xQrrUs6D8YP3a+MDgtE3HADaM4eeRn918RiL?=
 =?us-ascii?Q?CuG/6RqkDzZisvt/6glajDSzWe+qEt9J11pf2xDbHQjQ0XudaA4CYM99h8L7?=
 =?us-ascii?Q?+mghP1VyCt+BlRK35MTlniGneGk/Gb/3gaedrVXZT+QncvxDf7nt/nYj6L8j?=
 =?us-ascii?Q?Ptrpni4dqwf1v3VVsxOuqp8jRK8aDtIrkJIeLXepptNniuxmnHslkXYH6Jl0?=
 =?us-ascii?Q?UyuQshk7MwgxQ6SwYswiJY9RRnyuS0qmaPt3gZJYnc+fG2KiKI/B8PB5+DLg?=
 =?us-ascii?Q?xw3e20YA2whgIGIil/6iYuSSQSTGdSnVq3wg8QrAPBrakSrA5PzBR+DcKsOp?=
 =?us-ascii?Q?rW4tXxKYJgdYp2nbHDfKmDasaSE88vnwuqCspg+e5LtT1B1yx20DhOa+/ybo?=
 =?us-ascii?Q?eAqAzoNoDgRHtGiVFOkaHVVpcBBqG8sQyy3dy4Y0UJmG7dwM8DLSw3RdZh/6?=
 =?us-ascii?Q?vB1+y7i4/mmpRCnYaTsIYRPQqzA5YrZYsQxGmiVPVAjZnnBWPvs/86whw94J?=
 =?us-ascii?Q?ud3J3/jj/VfzqtVgokkdwZXmgSvau2sc/jY8DCoM8Sa3gFoVMRlX6Y6pi/T+?=
 =?us-ascii?Q?BTyI3Nl7fvijO7bxJHN2Z1DUm+6z0wmXQQkHNuLNKSQyDDVDihPsdpR0CKO/?=
 =?us-ascii?Q?jpNp9/DMFCeX3LUP/T40CgDSva3kDHo34ak/gFAciu3yasUtIKJoINvYoGor?=
 =?us-ascii?Q?fli6VzpMe2H8mZ88gDUNAlBk6PlNkI6r7uUwgo3dTAYOp8GrgG0Lkq5b1bO8?=
 =?us-ascii?Q?7lYrZIbN+Xdz9G3+HxbOsTzwW2aMNZEZquxQA+0dv9629/jf/h1eE6aooTah?=
 =?us-ascii?Q?tHPFx0Wi1Wkw0sRvrj0vnZORxBSjhsWiy7xSCvRYvh4XZB/HvrYdXQQu7u91?=
 =?us-ascii?Q?jsy9nNKT1Pw+tmOw+lIyZFLUJsk+Yft/UgArlSGdVNhuwij2IF3intTrOIJH?=
 =?us-ascii?Q?JdqlKGjq3tFrqwb//vLvu3WCT9duZuuBi+nFLaToFxqYsWRtJdlx2TanMMqV?=
 =?us-ascii?Q?yYnVIH+zGfGkN8uhuD3zcnslCj0nY/pSiBHHkM5n1ku18AT/uxX9n2Rkx/jd?=
 =?us-ascii?Q?Mp24xjgVpOeRJvv7h5sVsfAI7Gn7NjlugLaWHwI2oYGKRSZCbbKOavxSIa4h?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <03BF6850DB1BB748B16996FF00074E6B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd86fa98-d7e7-4e67-7814-08dab5c11283
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 13:10:06.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WN6NgZL315J17viUOL/g+risIiQoR6FEm3Mk4FgGDj9X8O99Cn+259ATN6iYWnbO5unlgNA+ITDtJCGAaRYfMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4386
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:44:56PM +0100, John Garry wrote:
> Hi Niklas,
>=20
> >=20
> > For the record, I tested the pm80xx driver on a HoneyComb LX2 board
> > (an arm64 board using ACPI).
> >=20
> > I tried v6.1-rc1 both with and without your series in $subject.
> >=20
> > I couldn't see any issues.
>=20
> ok, thanks for the effort.
>=20
> >=20
> >=20
> > What I tried:
> > -Running fio:
> > fio --name=3Dtest --filename=3D/dev/sdc --ioengine=3Dio_uring --rw=3Dra=
ndrw --direct=3D1 --iodepth=3D32 --bs=3D1M
> > on three different HDDs simultaneously for 15+ minutes,
> > without any errors in fio or dmesg.
> >=20
> > -Creating and mounting a btrfs volume, doing a huge dd to the filesyste=
m
> > without issues.
> >=20
> > -sg_sat_read_gplog -d --log=3D0x10 /dev/sda
> > which successfully returned the log.
> >=20
> >=20
> > It is worth mentioning that this arm64 board has reserved memory region=
s,
> > but does not yet have a firmware that supplies a IORT RMR (reserved mem=
ory
> > regions) revision E.d node, which means that in order to get this board=
 to
> > boot successfully, we need to supply:
> > "arm-smmu.disable_bypass=3D0 iommu.passthrough=3D1"
> > on the kernel command line.
>=20
> hmmm... that's interesting. I can try again with the IOMMU turned off, bu=
t,
> as I recall, it did not make a difference before. I think that requiring
> reserved memory regions would totally bust the driver (if not present) wi=
th
> IOMMU enabled. As I recall, sas 3008 card would not work without RMR for =
us.

At least on the HoneyComb LX2,
running with "arm-smmu.disable_bypass=3D0 iommu.passthrough=3D1" gives a wo=
rking
system (and working pm80xx).

The ACPI IOMMU code that parses the ACPI IORT RMR revision E.d node
was first included in kernel v6.0:
https://lore.kernel.org/linux-iommu/20220615101044.1972-1-shameerali.koloth=
um.thodi@huawei.com/

However, the HoneyComb edk2-platforms code has not yet been updated to add
a ACPI IORT RMR revision E.d node.

Considering that it works with "arm-smmu.disable_bypass=3D0 iommu.passthrou=
gh=3D1",
I assume that the ACPI IORT RMR node basically just defines a number of
memory regions which the IOMMU should treat as "bypass", while all other
memory has to be re-mapped via the IOMMU as per usual.


Kind regards,
Niklas=
