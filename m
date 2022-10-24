Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA9160A9F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJXN0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiJXNYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:24:07 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020CD876A0;
        Mon, 24 Oct 2022 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666614627; x=1698150627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5KYVJ7mk0Bl3dFCz2+hygiaxkMw8eBJ02xRGUTXWekA=;
  b=mnue6OptkkaEeNxY36VB/a6P1ij2adlLS8kkZIppUhYZBsoNdye3txO/
   Rvgue46g0pliVDT1tHlU7x8c5T6FivZH3/e3oZ4KGvYMoWYwz7M2WJu79
   m3/xt76oNtWwV/9ml7GO2nE1xNjJxeURZmSSs4ZKD0tx8hTfDgwGhb2IN
   k37A2FlG7pxw13/I3sEpeDhctG0hBp1qrf2qYOZg1eFmbtz2NYAH96iKF
   4W3kqwlION8pK6rTYM/b8ZqIShHfadOyYYGq0vZfsOAJvUFbg8ilCAy4N
   MTJwZpWdBvMJf4o0j5Gh0+mW+s64diroMrpgt5tLoXZpuOtCxRmS3/KMU
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,209,1661788800"; 
   d="scan'208";a="214964870"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2022 20:25:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgOQhonrIEfT3GoZTolU6qBNFxYdagXKWa+Rtt+1LxxxWU0ZzK2Jsc6rmwdVJkWipeXX/vfjpXIl/BI1ANpG07u9lZvOx29EGSDNoYY4nHTiUh18dLzxKBNlk5LoEeLD66gt6IUPePSUT+wmbD8yP/kIHKdSRmkxkzhqhlTHHCX/AYDD87TsUsuibY01Uq6LgSFyIXxcgS2NDfooRJ0QSuEqRh3KY3QPMtpSMHookuMXEJ41dnaV4yXPxMvMD9auL47MvXK6KZGYEgmt8W12VcNx0g2u9H9t+RZkqM3dsKxWDLx/QEBdu7PMc97m+fTH/9gx4vRvOClJWBLIWXjafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KYVJ7mk0Bl3dFCz2+hygiaxkMw8eBJ02xRGUTXWekA=;
 b=VHX9fMhx1hvD4BawRpBUagFef//xTXjqysa1odcXkgy4y9cgVDBZNLuqicfsNpCXAOd2TmpLoVjO6/N9+bITDw1lQ7+dqAims0wm68+qvoCsw1VUG1fzg2LBJboR19Aq1dFxhH3IGRfTL5ElOzou0juE/SjXMC5CQzuxIBsYmc2V8MupxeEJLN+hjzwiehLJ/LMzAnjQ+KUJZaAFaDp6A1Nx+z0cpkX09oPy+ddOPccqdDhXbiFcaGW1DFDtGWOFgkTlvuZudxbHcyb8yMzzs+5mnxGp3b/OYwmOTMiOZVyS5Cq6vSZMAKp1oRzSfNjazsTIPDt7cskdUg84r1QHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KYVJ7mk0Bl3dFCz2+hygiaxkMw8eBJ02xRGUTXWekA=;
 b=EKrKR8qkvs85Fs1/+A2dhWQtAKLTCj4c9ZrwXwoTEiyTlNPQtkPL68LMfBrX4V5XM6Y+Oxi0Zkwvb8RF1h62jYa37ts7vb2vFIdj8LdjjjJgSVz0IvU+f0opVoBEttneVrr71zlXBjTRCbPfEUmh8OVjcZF29lv9KYAg55WNnY8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MWHPR0401MB3562.namprd04.prod.outlook.com (2603:10b6:301:80::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Mon, 24 Oct
 2022 12:24:58 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::cb5e:7ea3:2482:80f8%7]) with mapi id 15.20.5746.028; Mon, 24 Oct 2022
 12:24:58 +0000
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
Thread-Index: AQHY1/ID0O3xyFitDU+9c+6EHqQqRa3+RKaAgAE7cQCAANLyAIAAAgSAgAAKBoCAAAiJAIAApReAgABn/oCAACBvAIAcAj2A
Date:   Mon, 24 Oct 2022 12:24:57 +0000
Message-ID: <Y1aEGW2BtdIRJy7s@x1-carbon>
References: <YzwvpUUftX6Ziurt@x1-carbon>
 <cfa52b91-db81-a179-76c2-8a61266c099d@huawei.com>
 <27148ec5-d1ae-d9a2-1b00-a4c34d2da198@huawei.com>
 <Yz33FGwd3YvQUAqT@x1-carbon>
 <5db6a7bc-dfeb-76e1-6899-7041daa934cf@opensource.wdc.com>
 <Yz4BLTPkXqyjW4a4@x1-carbon>
 <64ab35a7-f1ff-92ee-890e-89a5aee935a4@opensource.wdc.com>
 <f190f19e-34b2-611c-1cf4-f8f34d12fe74@huawei.com>
 <Yz7qD+gpmI1bdw16@x1-carbon>
 <bc7d74dc-5aaa-1ad3-626f-df89955b1380@huawei.com>
In-Reply-To: <bc7d74dc-5aaa-1ad3-626f-df89955b1380@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MWHPR0401MB3562:EE_
x-ms-office365-filtering-correlation-id: 54f5c034-1c49-4dbd-b3db-08dab5bac3d2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1N/9ECB13nodWzROgimV3kfAliRbw5exDJ3AEyXfKnPSDv1jqChsvSfiMuKZ6fp2Ws5Xo/dxwuuyCpAujHeVDqVgQpVG2K4E4CcnEUZSJlFxww/YEtSiNyQVEw5fUaK3n1Wh40Q8fNyoKk0M+hC0NdmCQqdD5mgWCGEtcE5tYy5X+KGJ2x+e+D+YVJ3UAB/3hguF8ZC33y4MW3FfydmRcZwHDYhMEe2kEoEf8u6OFoCn1UWe3/cPTX7I87Ugj80+UplfYUiZBwM58LMlAdiH0ZTm+W8t8XZya7jFd2/dl03TQNV6OPkH0YrpcrQF9zEv1v7zJHRi2v+NsPOyG/LqMNT78fOT24Sw6dwV/fx++doZwhWf+8dcj/fUo3wtz3y64Su2TeUoJ6fAYTGtDpH9jDf7g62EGLtz5ApH2FV/bq3cnfyroB7XeUMNOLReAsRAtZ8p1vaLuqF6C7LXZrCnuNBo89qbvGljmmFqI4qbuxfXH9F/08t5AvO9ZW53jwnh4nPhCYVsDAo2cHkfPHFPBfNyM8rqN0qbXaFuT2d77wx+6REnPcIMIcO2YH1zik8GPzfPaQM3gqE5YSYptJkKtwjySwIDpkxNIMWHaZvYkj1Rx5mJeiF0QrBFdq5sr7s9WmEj5Rnva6dBUsqtq8WfBVKypqgoniCPUmUDn/N4onQk1avRyO4WCCqdWlrvfHDAWCR6xwDwPKZULBWONy3Pf7NoDunk5QcrMxouVM92q6caYPYwdXyFNM58EreM6eXaGWYcsMxwpth6mM9T0O9XgA9Loh748DAt1lfF5D1fDV0ZF3UnD1uUrVov/Pzdz0jlup9+x6FqPOPDgJG9dIx93g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(2906002)(8936002)(91956017)(66556008)(4326008)(8676002)(64756008)(66446008)(66946007)(76116006)(66476007)(41300700001)(478600001)(966005)(316002)(54906003)(6486002)(6916009)(5660300002)(33716001)(71200400001)(45080400002)(83380400001)(6506007)(186003)(82960400001)(26005)(86362001)(38100700002)(122000001)(38070700005)(6512007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Z+OBR5XZkoi+4d9Rb2z6FJC8uTW2hB9OAx3BF8MoQy5FsW1JNTpY7NgeMAn?=
 =?us-ascii?Q?zyaRx1zCtZDdPuN8sWDJWbBV5KEgR2D11QqVcYhjZhXQEAsHmryMSe9wSe3l?=
 =?us-ascii?Q?1m0RtWSMeIEmDam7IzPDf5maIZC16NF0jQ3JIaYu5nD17RM8j1SOK9/wBy0Y?=
 =?us-ascii?Q?XKbX+kfYCzEevPSwbVdXJL7Jea/eUVZD5ErQ7+cbT2ckajvgZAkOZxCkGza8?=
 =?us-ascii?Q?+PdWelTmLPIbm2qZOTR+5RMHT3pYKcoDYQ/Bw0+JEHIbuBGmoa4olyHwQ40L?=
 =?us-ascii?Q?yg6yPW9aDef2Ynj2GMKO9oaGVVBGpfinEPk2E+fjf8hRn5crS1U3mjilLt/Z?=
 =?us-ascii?Q?fzVHYXmBvYbQuC5qtjvCTVxSU7zdpqpCwgl4swYYEK0k8SMmgsInRkgrb1Sj?=
 =?us-ascii?Q?dk80wu6Ejj9c1quR7EB5CXrpmpsYXpMV0J/edzfsifb9kGufON15q6apw3Kb?=
 =?us-ascii?Q?oKKZ+pgVD43TlvHlPNz0xAaK2dxghFjyVC0cJQZpVWFunIPSmPkt4cWwFWLD?=
 =?us-ascii?Q?u9SWTpmM1eenTkKpF54RICXWRdsveR4weTqqNDL8CRY/e9Xysep58jlW/5FU?=
 =?us-ascii?Q?A4A7HDHbc+AXC0dZ3rJ073XIb7PCTc4Un6XbH/IFXiuvWlxkJnZuuSxX4OSu?=
 =?us-ascii?Q?VCSZsN83L2kFafQKS3eUiEX5owDQzgfUEFD9F1a16/0S7q0SMOtoZc0oQ4pJ?=
 =?us-ascii?Q?JIVfPycdAUVPU4yvpoLeedwnuZq9AJkDZFMncUz0haQF8bJYR6yhvHUtY2S0?=
 =?us-ascii?Q?xdDUXE5w81XTTCEVpgIFnndEFR6ZDSWfx7TRJL8UHcmqGnMdWtpb+9SSBPLh?=
 =?us-ascii?Q?jZjD1x9cQOT//Kk2nrDqmEre4TY+1lL4ruTvi8jk+Ey11Ofenl3dc8ZkuZwX?=
 =?us-ascii?Q?n8HHUBf1zBYaQ5fn2lX/TNQjEAkIcVQ2c2SRDyYN29YcitXeFygEuT/h0vPX?=
 =?us-ascii?Q?UFmhzaGs+HhCuKEaIBZh0ugvyI1yEfvdWHQ0Xs4H8Cu7vU2sFyr1j4B96jJQ?=
 =?us-ascii?Q?7ALG1t9rt2mH3BmLIx+iYqo5kUxSwKFWq3F7/mGrG4iPZuwY8bW/aqU0GKtK?=
 =?us-ascii?Q?ax+NMo5DLjK4IsfYCbL9KhTvAeuBPb7L6KHbpsU4N/bx1NNYpS3iAwSyRFeM?=
 =?us-ascii?Q?5PKo64FKGBHoyOW+2QXmLhO8tc4qp1VmRGILBt/gcgsjuTqvXuxV2afhvE6l?=
 =?us-ascii?Q?UpXiDH1l8C2aPkW+Hk1HWxV+IGag3rIhL74xJUDq93vKCYulPHZ4+mEA0j7M?=
 =?us-ascii?Q?EVkBxGnP8Qgoc+hTVrOUWzh0yjGU9MZUh7/Rf5v5pOfk2qNW8GETtd6U2SDP?=
 =?us-ascii?Q?Gc7DEV7ihKnq7pU5NZ3tVohFehPN40kHbUMaQOgNrBO2+W9BKpGbp2lZ3Lv0?=
 =?us-ascii?Q?e+jgds4qX2dxvT72OOSr6H85mXGIpuFQrY/UYOF1E5AD4zSJwxX/ffLxmtrA?=
 =?us-ascii?Q?+osbnAdWbD1znxM8XVfXtoJkOESjXKzvDM+A4cft5VHtleUe1DXF9gd7ya/O?=
 =?us-ascii?Q?QnjBKQo0Ed7R5i+77IuYlDT2JuOumSbwiashnVUWQpSM+eRiUWPAe8hxE/Bu?=
 =?us-ascii?Q?z7mdnmE2L5+9qBGtAJlSqIAQPyMp0xWIyiEt102D8kpEbnwZ/AP7NmbdBb3S?=
 =?us-ascii?Q?ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CD5D06FF7D1F7D45AD2B1371D8DA180C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f5c034-1c49-4dbd-b3db-08dab5bac3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 12:24:57.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOsSj3LLWaiRw02ghQqLOmki8dt1si4GFfCao9d90wgg2NJp2mgEsH24/pRgc1RLxXHzyid1PHFUrYpcvIC6HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0401MB3562
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 05:41:40PM +0100, John Garry wrote:
> > > >=20
> > > Yeah, it just looks to be the longstanding issue of using this card o=
n my
> > > arm64 machine - that is that I get IO timeouts quite regularly. I sho=
uld
> > > have mentioned that yesterday. This just seems to be a driver issue.
> > Out of curiosity, which arm64 SoC is this?
>=20
> HiSilicon hi1620 which contains a custom arm v8 implementation. Note that
> others have also seen the issue with this card on other arm implementatio=
ns.
>=20
> >=20
> > While it is very unlikely that this is your problem, but I've encounter=
ed
> > an issue on an ARM board before, where the PCIe controller was incorrec=
tly
> > configured in device tree, causing the controller to miss interrrupts,
> > which presented itself to the user as timeouts in the WiFi driver:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D97131f85c08e024df49480ed499aae8fb754067f
>=20
> Unlikely. Indeed, when I was checking this issue some time go, I found th=
at
> not only was there no completion interrupt but also no completion when I
> manually examine the completion ring buffer read and write pointers.
>=20
> Here's where I discuss this issue earlier a bit:
> https://lore.kernel.org/linux-scsi/PH0PR11MB511238B8FF7B44C375DDDFADEC519=
@PH0PR11MB5112.namprd11.prod.outlook.com/
>=20

Hello John,

For the record, I tested the pm80xx driver on a HoneyComb LX2 board
(an arm64 board using ACPI).

I tried v6.1-rc1 both with and without your series in $subject.

I couldn't see any issues.


What I tried:
-Running fio:
fio --name=3Dtest --filename=3D/dev/sdc --ioengine=3Dio_uring --rw=3Drandrw=
 --direct=3D1 --iodepth=3D32 --bs=3D1M
on three different HDDs simultaneously for 15+ minutes,
without any errors in fio or dmesg.

-Creating and mounting a btrfs volume, doing a huge dd to the filesystem
without issues.

-sg_sat_read_gplog -d --log=3D0x10 /dev/sda
which successfully returned the log.


It is worth mentioning that this arm64 board has reserved memory regions,
but does not yet have a firmware that supplies a IORT RMR (reserved memory
regions) revision E.d node, which means that in order to get this board to
boot successfully, we need to supply:
"arm-smmu.disable_bypass=3D0 iommu.passthrough=3D1"
on the kernel command line.

It could be worth trying the same on your arm64 machine, to see that also
makes the pm80xx driver play nice for you.


Kind regards,
Niklas=
