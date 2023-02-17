Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ABC69A55D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 06:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBQFwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 00:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQFwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:52:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024A498BF;
        Thu, 16 Feb 2023 21:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676613162; x=1708149162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZK8F0kS82a4kI1Cwwpj807IHvv/9h3YMBGn1RQYNlGA=;
  b=KbRudjWqWwpSEXnbXaIE4JuLzUv7wjneUi4k5qj9o5lCgGb5E9RiEO7u
   PKq0vOKjpBHN699l6TBJ+c/Ueq7HXRVV5sPPYI20Q8d52VxloEw85eg4b
   cXsJOoNY6bmNqjFGhxqUSFTt9qD1QuMZjtuBax8MAuGldohEr9sO2w4Rg
   6p4kCPKed2+st0Np2+awtoMCtAEWYOyfApgpI9LLhLfVJ8H4A9BlUT0o8
   iVqbei5RjZ4oCjbHCexuC6o7ryZ6Ics9sjwB9Kv4539FG5WBOsiaHd3+X
   CrcwllDvZck1x0tSaT5l/n/uByAWbGhY0UBf6PoZdBf3icjz4FvnoWWaR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="396592122"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="396592122"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 21:52:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="672483342"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="672483342"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 16 Feb 2023 21:52:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 21:52:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 21:52:41 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 21:52:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbHOKZAdfe430vH+eo7WiR65uXClUmuVmHvuK4YPZBOFpk696exOb6RHB6O+OloAI0CXDU8swUOW8GpgkyNQjChvYwir6EOuPCXkwKAZC3p/hzsdPh2w1uqh0LLsx/hTbk6ISYwESIASJw2zcO0YEQ5v1J3F2RAqPEWm/4khcR1UkrZkpnZyCEt+V7saUgTcINucf+On0T+okdhVd0DC6mxHQanWlSq/srT6s5HTI/t0CB/j9JlkCKPzk/pqlXjgqwPrVdAOrRxT3dAHuUUJwzONxxNsTYQ51H5jGh8+QuxkfMceCLzx1OMu2wkS81dnDglUasRLNVhC8Nym6j9/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCoX3heSuHn9thiboU2G3ev/rAMNzNlHCghBj8c5u2w=;
 b=QEPsaA6h8BMAwgQs39ciflqwpPWLG6/IazyU41lyys4CNX7LRVceBvf5CrfZuqN7nnvAIICS8Zs32DAelG2XMdgFM1rdxDUyK2N/wk8mA04LqVUDjkvjxzklSQ5kdFSryqmCYjU+SvTPWr/CGCPu64zUi4u/3E1vz5nx7kpWuU2e1Z/w0dETS3fT1q9Qpxv8rWzOlGgKt+1TupGXQSSeZ4yQJ/2x712GWDEMH0uejpM/UE8aYWhDhyQveNGTfkSLAOhvd9xllYNyD3GK4Zpg5VBannbgnkI0QDXE2vZOk2jNPeodd3je1TAyOxUypfnVTdkpqAYyzASnF6EjtlaVJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by BN9PR11MB5498.namprd11.prod.outlook.com (2603:10b6:408:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 05:52:39 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::8b8d:f936:4e17:13f6%4]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 05:52:39 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] media: pci: intel: ivsc: Add CSI submodule
Thread-Topic: [PATCH v2 1/3] media: pci: intel: ivsc: Add CSI submodule
Thread-Index: AQHZP1HqpZLwLlRt00ml9e7fRXtKOq7MO6AAgAG4EjCAACxFgIAAM1HwgADNUYCAA4fWgA==
Date:   Fri, 17 Feb 2023 05:52:38 +0000
Message-ID: <DM6PR11MB43164B18F9A1DBADA6B32BB08DA19@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20230213022347.2480307-1-wentong.wu@intel.com>
 <20230213034202.2926-1-hdanton@sina.com>
 <20230214083533.3410-1-hdanton@sina.com>
 <20230214235405.3587-1-hdanton@sina.com>
In-Reply-To: <20230214235405.3587-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|BN9PR11MB5498:EE_
x-ms-office365-filtering-correlation-id: fc41435d-1549-4d66-b6bf-08db10ab2d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7cRfAwsHq9R3hyKqbY8GwYLPEq2tlr3l7Nqj7rdFtigEvdZhdtdTQqwbUSfh9wjj/1cNCVgB4lUR3pM5KAeB0tRrQkQK+MfCoiiSYI5ne/TmG5aFTTmdeEtZ+1FANl0Ew45xKWN9uq2EbyY/l5uXGANgwSeFNdi+BBZWE/luJ1qCN9gRSYnA4pvplqD2cfN4ArZtTOzVAPSyI91y1V4Km4XLHehWCoOrNmadyVBgsUbPBaJWWalUcht8vW1/93hHh31leKlrv4KSmcnAuzj1sx3L0uIbj1IaV5lv+O8Dh86wKkMYnyVt4RvWrzAzRZKB2NbZ15lj5Jn04XMZ8oZ9RzcDdbCxZ9QaqrfFzBd4MOe6rWjBzmE70IOpxsQCHAFkvbHabUZghLnyLmfM2FsoYEuVdGiKYyNNwvSpZOdWJQQjmn+IJc+DHbWM/iRb4Ep9xu7bJuLdWbSWRb0tN1ELe6AKunZoRkEWxvJus7YgfdwTyT30yMzWv7v6CbgeEp6gCQiXPnCX9ERJt1e8C55b7NAbHHoSo+caR+wwagdNlZ+GsXfsZOq1d9Z6SFwrgSKnJI9uWxxlySLB9zh5n3oPcS+QR4U0a27NV6bVklLxx+IC5d/w1o+VkT0daAJqgPabwJX+I4m/gGJRtc/rDmsbBYjY2E1cwicWDYMz7uAlFxOPXs52EgNLIIRAM3thXe8hAMzZd982O7+3FvVJXdSmVMpLZtUiGW1gW2Hyayn1S48=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199018)(86362001)(66946007)(33656002)(38070700005)(82960400001)(122000001)(38100700002)(9686003)(52536014)(8936002)(66446008)(316002)(66476007)(64756008)(41300700001)(54906003)(5660300002)(8676002)(76116006)(4326008)(55016003)(2906002)(66556008)(83380400001)(478600001)(71200400001)(7696005)(6916009)(186003)(6506007)(26005)(299355004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wN2yelMAN84y0y79ZxmGiSKPJjGjKq6pMBJE53vZUhAgqMDztCq7o01Q4+H2?=
 =?us-ascii?Q?R9UlwMEI/YFmVA1QAFDx+qD//vsc8MIonV6YzUk1N43s7PhpLMMfr0OiH1+C?=
 =?us-ascii?Q?c/C0cksP2aSmfXitA02Kvgh7iydOhsf+R0wyNCcEf+JrOxMmN9Npc4NCRMey?=
 =?us-ascii?Q?BRPJMsY5acTL48UT/VRw8YRIoX46K6LoTASR1NAKbIEVqTMtg52L4CUrnXYW?=
 =?us-ascii?Q?3caqT5s8Paqf2xmE6gQHHd5oPR7/E34T4IlnNic7gpeYGvex9JK278h5glCz?=
 =?us-ascii?Q?fyRBjazX0dICqhBnM3HGuKN/vvV43xgna9WQLM1saEnazXUvXt6Smbqowxxc?=
 =?us-ascii?Q?LEXM9rqQC/S7PEI1R0+MYWUFv/kgnWvHYPl6igbG5IY0noZ+AgtVmFMJBD9q?=
 =?us-ascii?Q?LDP1f9izkD91mR+na3DGqjQIzaHJjOq8yuXIsr4oUiaLvHfttqXgkYtl9NxE?=
 =?us-ascii?Q?qbrkF8XiWwoYLf5G1iLbVk3z4os+G7rZ4UctAGIshPseHzrRjYq4f5ZS3Ai+?=
 =?us-ascii?Q?zCGCluelhbQDojny8C2/dsbPQ0KlcIEHilVB2vj6Q9LEJGAVypbuOpiaDu3Q?=
 =?us-ascii?Q?i/qxQKeDz7fRNE8Vo04+WBbTgMJM+USHm+N1j9WiOch/7CsaWG6EZk9d+6QT?=
 =?us-ascii?Q?itJURVCfTZ6/MAXLx6v4nWrs721jF16lxU5lZ+2wDoXgnSssftUugoI54Iuz?=
 =?us-ascii?Q?PFpMrLOxnhIkTuMTpvJhNBaEgjHxjVGXxMY2aPfsjfTvG67X2ub0XCJdVJFI?=
 =?us-ascii?Q?ke7OW98jMMdWQ0mpWi6OuCCEHRw3l/5kZ5Zv6zRfBbGznUo+g0McjdYV6UjV?=
 =?us-ascii?Q?z6K9XIHX7XIV9Z6V0FiFEhLJ75GtQr7SARco8CZwMlyOmO1PyLfeIygjuD3C?=
 =?us-ascii?Q?/mMWeX6pQKdOaVXNNblG8HNlDkfgXwtNZZKZ297nhMNLazLOPXsBXFsYHOmv?=
 =?us-ascii?Q?2Um3/HSJr9duGBSK11dj76uy3Bn92Q2KZT3AuUyhS+NEtvxhhmROveDLJUS6?=
 =?us-ascii?Q?vuNjXWysT4y4RdvAbmt/cDlNqb5iJrkQJS9W/uCQVfI//PhPc+qF66zpyWa9?=
 =?us-ascii?Q?xmk3+V85EqwHVnf4zHaH/znyQqmQfZ5XRJjkyc7Aq7CwXSFIe7knmFVoGTLo?=
 =?us-ascii?Q?gFxJRYj5gNkNXKk5CX/vnWdAmZeOZR1qjPM+EF/b+5kBOVP/w778YyKTOCHN?=
 =?us-ascii?Q?Pe8lmRGQ/97ctx/s92v0Gx3uy2/TGtaWhLaCxh7N9qeFDDC9XgOMqF5owGow?=
 =?us-ascii?Q?96R5jSbz/jHOYGCMc4dzbLUWs9y8NBmITiu/ZFQj/x2ZJ1VT0iK4vBjz+Q/9?=
 =?us-ascii?Q?alr+P1hEiQ36QYPvui1ETVQhVyjjDKxyNaC62b+kWwG/lOz+mUoorzQZnoR/?=
 =?us-ascii?Q?qr1VoLfm2K55rNQKuO6tjF9QQ7umZ87VAECWHLPmBlGMcgprZP2i7Mw9ilMq?=
 =?us-ascii?Q?k1tbhAAxgLKDAMmdD1U8zy76p4mHazL+FJFtk6Bkp39JZI9CKdhuxwoNUTNt?=
 =?us-ascii?Q?v0jwR82UvJsM5rU6b702JquT/u1YkjSCInAAXPX2hR31zAcQBEEm7BrIePYM?=
 =?us-ascii?Q?EigaLuACuHKBLIMPesQ/ibsYQwiGaOR7LlFhs6mX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc41435d-1549-4d66-b6bf-08db10ab2d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 05:52:38.8607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giegfU2InEAFjg9ssl04owonPs0FVzpvwbOFEcKoWQ9ClGZWJ1SEK+c1wogTpp2nWuuD2HGISCYUeFDMpYvKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5498
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hillf Danton <hdanton@sina.com>
> Sent: Wednesday, February 15, 2023 7:54 AM
>=20
> On Tue, 14 Feb 2023 12:40:12 +0000 Wentong Wu <wentong.wu@intel.com>
> > > -----Original Message-----
> > > From: Hillf Danton <hdanton@sina.com>
> > > Sent: Tuesday, February 14, 2023 4:36 PM
> > >=3D20
> > > On Tue, 14 Feb 2023 06:25:35 +0000 Wentong Wu <wentong.wu@intel.com>
> > > >
> > > > This allows new command(e.g. 'get status' command to check current
> > > > firmware=3D3D
> > > >  status) to be downloaded to firmware for debugging purpose in
> > > > case no resp=3D3D onse for current command though I have never saw =
this
> happen.
> > > > =3D3D20
> > >=3D20
> > > Thanks for your specification.
> > >=3D20
> > > Another question, is it likely for the wakeup to come after reinit
> > >becaus=3D
> > e of for
> > > instance timeout on the waiter side?
> >
> > Thanks, first I want to clarify why we have timeout here, in case
> > firmware =3D stuck somehow or IVSC device is removed suddenly, calling
> > thread can't be w=3D akeup if wait forever here.
>=20
> Fair enough on the waiter side.
> >
> > And firmware gets high priority to handle command and response, also
> > there =3D is timeout mechanism inside firmware, I think there will be
> > some problem wi=3D th firmware if driver gets command response after 5s
> > which will be captured=3D  by driver code(if (csi->cmd_response.cmd_id
> > !=3D3D cmd->cmd_id)) but I have =3D never saw this happen.
>=20
> The problem with firmware could be emulated by directly skipping the wait=
 for
> completion and returning ETIMEDOUT, in order to see what will happen if
> wakeup comes later than timeout.

Thanks, but what do you mean "emulated"?=20
