Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90836CB445
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjC1Csi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1Csg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:48:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA241FC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 19:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679971715; x=1711507715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O5FEuFnWV3zgP98fquJenvH4XN93x8tSR6XPxky5ttI=;
  b=k34OWeymxzEgUEUgQM5aM1NYSL7rKEA6/NwdQwJUM2/X+k329ZrNIaZq
   4RJ0VbeB1bSa0hjLdaMBCYVzjv2lYOQJq9DpGkRsEBTXkRdeDNqRSOE2G
   nQgSXfKxukXuJ0tytXhE/nt4+Z5tbYC2NcRo+kGcskJM7670CDXnDVKV7
   vtDFnz8tsRv61QQSxc42VYHtzteFFzRlCBWLlSFs9MlQu65OXqsQhMcGH
   FJzqkCJQp9ic1Szn0+M9GO+gTq0/nyJVgKT1fhq0dbOig8e9N+nGfqz+i
   G8t4EW2b/oQME23NMiBCTKQCSH6XkdW3GM/1GE/z1LeHe7xjeEc0bL57M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342038263"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="342038263"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:48:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="633854430"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="633854430"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2023 19:48:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:48:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 19:48:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 19:48:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN3wxyLeRXIXcRr3+BAt7zejSzoPSzwONog8tNcm7MSb00qo5zLVPCsg9POdi/XFIXVeoK4kKHm8lNx5QbqNHvz4k4D7gpAVBwy/X4BWALz8vIjE8pLb6kpUbNY1cz+XRsx+KgqiWT9NrpA1nDonararU3MKDuRjsFhda9LPMN8FxJC/+DtKITs/jv11un+xslnUo79MXJSNyshm9V1/NdvNbrM16I0i3GzKfN8andkFTyXvZXIhbjIXiykui3+jn5sKS3Fc8k8OzwVmxjJ+6i6+zzoMmoECdZcQL6DG4lwqZty01AFK4yxmpF6PNigk9hvRpWiv7hn823mQYSBZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87Zk3Oh6WuQxbW6hHFs2My6jS3PBXYRPy0sBmDojk7E=;
 b=SI4Xbhb0Si85Veqa7WQvR2E2yB35wQVzTAR3k+4p3ArqX/5t38zjBEgPAAwVG2M0nH2jd+iuBcztieQ4drJ2ZucXLL3j7DCk1xdw2+K0ldbOrZ8c64jrmKdd7tQOt2nm9rmFc7RAwTLxrhZGAduthEDI4gy4hATyvlqZoWXiX/DEDvvDEa3UpFJLJLU0QZQaJDINF+ngfollKCC+vxFc5q1Ft98AkS+so+MMgHu73Y+MOZG+w7cUrwtrIe10MD/ySwy969v68hP4b4tx2k5Qs5uNsXIJZ/RfMbfYvT9R+oBEwndoxWkeEkJ3WfLDNh7mMl05L/8OfIfnw0mGS3PBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB8262.namprd11.prod.outlook.com (2603:10b6:806:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 02:48:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6222.032; Tue, 28 Mar 2023
 02:48:32 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Topic: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAALsACAANbagIAAyRsAgAqMnjCABPKxgIAANdgAgAAeawCAAPG3IIAAOI6AgAR7m+CAAGybAIAFfrUg
Date:   Tue, 28 Mar 2023 02:48:31 +0000
Message-ID: <BN9PR11MB52760914939B62A61E5309858C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZAn7uC9UweiNdGkJ@nvidia.com> <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com> <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <BN9PR11MB527663094F21D3DCF8A3038C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZB23WJu2BEH0yC/y@nvidia.com>
In-Reply-To: <ZB23WJu2BEH0yC/y@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB8262:EE_
x-ms-office365-filtering-correlation-id: 968ba193-4d53-4df9-ab53-08db2f36eafa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPqGt4HPkNVJ7v3yun1sjelzdthvRMXTZSGnmfwJCNdMNJHIWARv7j5vS0LFXoyy7z6C3rtESaLII3vfJnmUwhALIZe0aGvlwLnYId6sFOolYLVqv+/UuRkZFwXc0IcgvM7oUQPWtPkk8/1RX3XZqtOHtQx8efL33/Ul++xWRfDpZHocmm5h1KpHMRUjTX35yJoR6neCqIO01h4qZYX6ZHNMoamor6lxZere6txUTiWWJvuaKHrXYMYV3/vKWQozW9XzwTzR7onqsEKg1qWR2PNiwUf5ji6RFNwjnMkfKfb/S0hzjS9dk4MjdRg8Qj6kSsxZVy8fCI6W3iO58oSRPssijdJpgLN+cz6CQjPkU9uKkNv3dY2ZhhNUpGIvUnbDDx7ab179a4Eexm2kk4UCCwWemu6XPrgYe/AmRp/RjkhibIR8hvvcfz6P6ki/YEBffnmbq9J7W6xxd90U9Fo4Dnof9QtTiMYXe1lMdh/PBSKXAhzM3hcEoPH3G/wyTbGWlWunZth/PqYKSSy8otDJl6G2ilCNakSS/BaqrKJN3XbuxXLwT0RYFs6yhcALRkMYJ33ew5Xk8jOEiQCK7dmauq2h2bSJXMKxJWj5y3lEUtf4lUKeP37KbKn2rbNNJjDc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(26005)(6506007)(9686003)(83380400001)(186003)(71200400001)(316002)(54906003)(7696005)(41300700001)(76116006)(66946007)(66446008)(66476007)(4326008)(8676002)(66556008)(64756008)(6916009)(52536014)(8936002)(2906002)(122000001)(5660300002)(7416002)(38100700002)(82960400001)(38070700005)(33656002)(86362001)(478600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?De6jGahot4bPmIV4odhpdzr960fK7wbGQtj/tUgF7z08SBZ7wnd6mqRQmTR1?=
 =?us-ascii?Q?wFn+BQyIu8kP6rhvhdQUW/XCDoEIQuBV2IPtB+BeMw0u1Ulv0Lt5uaAd4Xb0?=
 =?us-ascii?Q?WJXV3HImGjB3C86NfON5Rvl7b+Z7bWeo+pFXiqU2KxviBh5UDTxMPqUUy1mT?=
 =?us-ascii?Q?7nGvoG7F4BmeR5lk23tevfWDlR5AfyhQu9CPE/8R+EzuOdFjvFFSaEaYeYws?=
 =?us-ascii?Q?Ts1ASzRhG1Ul652M5lWzFqtU9oC7YAh4cWybAYyb6+oJ8ywP0NwDw4tkM7x3?=
 =?us-ascii?Q?QexC/IkW38GC8QvdpihFFPsMk9P1pPdgykGnpyJn8JyCMTAWuG/IhutcRrf3?=
 =?us-ascii?Q?p8WhOXihT7NaE0YYotcY0WmIoQkxWeTrC9EzoPDAmeqCWDqa/wXWhanM/YwR?=
 =?us-ascii?Q?EZByhkht0lqUg1Y2MYYZpo6XlDJBgWZN+7mZiquHmcPUDMs61quZxDeUwmmr?=
 =?us-ascii?Q?9KWI/Ih9iEn6CTXOe1tsvwucsM6XMqp3q/M9VhvZfsrm5CYB4VjC+gES/2uU?=
 =?us-ascii?Q?KevhJl38uIMFTt/Q54aMrFRhkjZAuqp6S3gx3RGwKkhP3EMNlosB/xB7Iik9?=
 =?us-ascii?Q?8+yP2wlCDCO+G+7vH+Lpd9myc6qL+MBP+jfTY0plPYRIVr+zSP790CavVhqF?=
 =?us-ascii?Q?VakpX+epdOn51CxBy5XI7ahYZC0xtNcJda2AxGR6FyOSRNT7JCzTGDnHC53s?=
 =?us-ascii?Q?emAIf4MUQG9VoJisk3HnHNfbTkrzzpCzKOyZCdoBjO2aUGWNEbPJP0w6pn3R?=
 =?us-ascii?Q?AXVoWfqWtyjTUmE5IX80Zn6biyd+VaNaaSB976FJEagVqIbFytQVWw5jp+lu?=
 =?us-ascii?Q?39/bqkNEhl47sy5kBn756KLHXKGqQrf+8ozQbzNY5AZy3czhIxAQAJVrGrQj?=
 =?us-ascii?Q?BpV6g4ZDJPMyaMFAAqmCBelOT3GEoFS5fc/6HFPIN62TcgeyuWN1yNsqLwRz?=
 =?us-ascii?Q?nd3ovxWcbGQCbc9iInsGjU5x+A0VP51S8h53m3ChFosd6igvfiQZ2n4gGMCT?=
 =?us-ascii?Q?OfOBTVI8fLBuZNnx0gdQh4Z/MudXI5xVRdn4YsJuFH6LCNeQUnmvfzRxdg2K?=
 =?us-ascii?Q?fKwuVCL9l+9fs8BQojmgt02iTcEBcGB8AtGwyzXwLbuqhQELk+xjWbAUO+Lq?=
 =?us-ascii?Q?PElz8d7fLM5nqoUg36brvNU9J+XlZ4Wj+XQ7fnLm0hgSIKCH4PX6GXbQViQT?=
 =?us-ascii?Q?Q/UsY5dPtjInF/gf7T0lnGTcUAo+KJkbz6HLTmfOUnIdadkOFeXDvUNaxPaa?=
 =?us-ascii?Q?o90Klq0H7e2Oolw6FxTt21MQ7kvpYF//FZoRyPb3xqQeinUh9KyFwlzUs7qa?=
 =?us-ascii?Q?Vw3z9q2ptFFCwYiLw6xMj88omGwlJjUQa1hOKxpcGWAx7HM6QD/xhncqeJfq?=
 =?us-ascii?Q?9CqcJx58jdW8lL0sfoWIFlP28DRpm8qsI8Z5deqtG2IexheKRsp1iEeS56e4?=
 =?us-ascii?Q?UJt3PhiS6sC7/Vr5hRBREmoOX0NwexsWlAgVjRsMFo0uwXKmaP6/tbwnXqBr?=
 =?us-ascii?Q?wsRvmFVzAN5Ddf2RX62+vO0/X3EFY7HlitYG7/VReHy5SSz49adCHjNLT8ta?=
 =?us-ascii?Q?srj5CmIwF9liCsGlaoQLkKdLkGAlu4PQLtYlfWlt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ba193-4d53-4df9-ab53-08db2f36eafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 02:48:31.9965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USKQpROO9GRyv9L86DTSRdj1HTqJYJPjunfcHFDnnPAzLH2CxgjSOaeQwmNpwQK1wjGkOAYP0vFGCRLP0rVS9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8262
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 24, 2023 10:45 PM
>=20
> > But still the main open for in-kernel short-path is what would be the
> > framework to move part of vIOMMU emulation into the kernel. If this
> > can be done cleanly then it's better than vhost-iommu which lacks
> > behind significantly regarding to advanced features. But if it cannot
> > be done cleanly leaving each vendor move random emulation logic
> > into the kernel then vhost-iommu sounds more friendly to the kernel
> >  though lots of work remains to fill the feature gap.
>=20
> I assume there are reasonable ways to hook the kernel to kvm, vhost
> does it. I've never looked at it. At worst we need to factor some of
> the vhost code into some library to allow it.
>=20
> We want a kernel thread to wakeup on a doorbell ring basically.
>=20

kvm supports ioeventfd for the doorbell purpose.

Aside from that I'm not sure which part of vhost can be generalized
to be used by other vIOMMU. it's a in-memory ring structure plus
doorbell so it's easy to fit in the kernel.

But emulated vIOMMUs are typically MMIO-based ring structure
which requires 1) kvm provides a synchronous ioeventfd for MMIO
based head/tail emulation; 2) userspace vIOMMU shares its virtual
register page with the kernel which can then update virtual tail/head
registers w/o exiting to the userspace; 3) the kernel thread can
selectively exit to userspace for cmds which it cannot directly handle.

Those require a new framework to establish.
