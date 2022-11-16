Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B386062B1F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKPDva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiKPDv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:51:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F159D64C1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668570688; x=1700106688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dRPbJCqAh/WLgJnJ2eQNOEHFHP5mTsDPx27XMEhUdNo=;
  b=Nd7RRqFcJz/bAfr9dGHrLoZlZ0Te0DbPLg+z5GBBtSwRaqKwrd5rWpa/
   hBCnnGOltNidaYkKzvkT0Jkf0d/sLatcKjZMS5HTkdv0mbeYD+u5BieOs
   xRtQAwzNFZUGGwNkOYwx2q7FFiTX7b8abwjUwvkFqBT03MbQNEHnbfLAF
   Mdy/0Y5udP2u3Fxz8818ngXYd6YOS5/ErWsUuj6oqQ88zzXmpONk0Pu/V
   GBdyUOY82GSdGRJzRsSlxRLID/aLG3fRiiQTDxT9MhYwc5yOh+kUrqzwy
   WFnTJAc3JGxHbRfsDSh9P3F7mF6PWHaqTfYy+H4BnWIP3VGDj1AZGZppl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="299968123"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="299968123"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 19:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="639197060"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="639197060"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 15 Nov 2022 19:51:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:51:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 19:51:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 19:51:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUhK/h8pTFV58X6upjGC9RjIb17Crl4owYnUrjVbUtKDtwlIeH+d3/DKfyDqCX4kgrn3ifLQfSrCT0dGH0pwc4pTZZ3ORHKdW3FM/X+TuUbsTP3fOzynNj7M1JvLBOkpoQvxSODUnVefefvBntuf53GkEXXyPyO8GnooEB8oHIXR36DTr8s+BgUYk8lorClS+UoTRc8fcNZ+5VPPxT7Y89F6Bdp8OMvB1pzMCZr9K6EuPzjzOCvamUCHgma04jwgAyvvX9Jv4VBT1fUwhhRSJ9BaquBN87EyH4Wpqd1q89QG4d2AEAQDOkCx/TyOZpjdGU0iNw+SpR4NH55IaDL1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRPbJCqAh/WLgJnJ2eQNOEHFHP5mTsDPx27XMEhUdNo=;
 b=R8wwsmxM6VoY2wyTUK50Sn3RQlidZLW1EXN846I/GiuMHbX7IkNX5w9FPP0zVm/dJtO9muH0PTe/036vCFVCk6835RxkrZ+xFYjyI/Q6e0CTXhvsJjiobii7OY4hiJvekUuSWFejZqeTmc9f4og1SaLWB+g6I5nVUeNkLLjxfTnEDkkOKcpvE7rjo+3vGusPoBHKlXFcAw1mm8BQWdupGhrbh9Y+JZnXXhxlh4K08GZpu/CTW58d/VsprJl3wimUM9pPLiLcPgCXimFUDpzogh8Xx0KvCUeyfJ9OeFcvEGpD6N7h4uylyeEw49HJYuUEXDxzRoYjV9TqyM3kb2GxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 03:51:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 03:51:06 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/7] iommu/vt-d: Add blocking domain support
Thread-Topic: [PATCH v3 3/7] iommu/vt-d: Add blocking domain support
Thread-Index: AQHY98sjsMdhx5wzoEGD5siG55yY+65A7a0A
Date:   Wed, 16 Nov 2022 03:51:06 +0000
Message-ID: <BN9PR11MB5276ADD365A3078D6DE9DD128C079@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-4-baolu.lu@linux.intel.com>
In-Reply-To: <20221114014049.3959-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4531:EE_
x-ms-office365-filtering-correlation-id: 688aaf90-d8c5-462f-dd24-08dac785ca7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9PWwTK4j1HfkM9ipByHQumHEz5AIAxfF6+fKGxGPfwJzTgDzhkqBFBZ/GPMnKIjJ9egfHSaRRSPG7Ksx/+hpHp4jtLCOPmBbjdjbOsfrln6DzoAV+rGSshHIkrRHlq1t0sQi23uHTD0Oeg28vDhsygla5EFueZha5iqZ8nodBU2wriTMtWuM/q+wGEuxS0cY8mToiFeS42/lyyMShdZuZnyVUDAzqYVtSKiHi/oEE6TRaaLG0YI4GCKBjOcoAcffkXdaGHLZjtYjSzb7p4Mm/dmR7n4z9zMBDIz1dMxvEiQiEu8ZFBo4++/LgFR+SdS61n6OGBmYedEsMGxPe7k9pFcjEJXmrjYjrkGXEOzfxKwSH63J63893CH8NAoyx0eXCw1KAcFcmagBuXv/Rlo0+CvEfKevyw/vp2hvw0z5rPprq0x8J0Wl5qnGNwIgC+mMFoc8maPQ1kzQGgqRxtAIl6QU4hnID+F5EOuk6FuaWGgnQdPGxWg8DSyljric1hpKfVkvgzSGae2k/ArOUqB7dDOBnSykuvBJ0lKe0NuBPERsFvr7H4sQDqWA/JCb0HXHsnUpCtMJLrT4E5slzOyNZBBoDfRfbU7cjjZNee4XjDRacoa8/zhGkZQw5u28fU0MwGuoOt+u7LNBcBdewxkB2Lm/G3xqOp8gzCE1G3mxi9K82Ze8+LKK8DkndJiSIwgfHnBKClirdOKC+zvAZw1xZRcpgLm4bAGh0z4F4rhDPG+ZP+Crlah6u620axAKXcPhmSnJGe6XM50wLvjqK1PNlQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199015)(4744005)(2906002)(5660300002)(71200400001)(41300700001)(110136005)(8676002)(66946007)(66476007)(66556008)(66446008)(76116006)(64756008)(316002)(4326008)(54906003)(86362001)(83380400001)(186003)(26005)(9686003)(6506007)(478600001)(52536014)(8936002)(7696005)(122000001)(33656002)(55016003)(38070700005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wW1QTn2d+oLER2mX6WFnwnDM7NVb5/yPjyM6rEa5XTUSpLJS/mxK2auIAx4o?=
 =?us-ascii?Q?V5q92cDqearFKHaausAKc0tMfBCneCnRMzMZIC3nHgJc4oVabey4lyjasJ3D?=
 =?us-ascii?Q?k93evoMl+QkwduXNRkNXQ3d4Jg5tqx0rXsRkTW04y7U3rsKheIdVLPT+hjRh?=
 =?us-ascii?Q?7cQ9mr0/IeMOnDwnGR5670qCW11hy6YSftGT3AIo0fYewSOM677ZmpHQnk+t?=
 =?us-ascii?Q?esYZJ1hwFX6icuXmFgd0JYnvb1ql2BEerIWaSXW39zQ4ZNsez/624GyeN+Im?=
 =?us-ascii?Q?e/dsUQo/ghuTvdXjLhXEm5IbxNIX8COx4K8gVs5HJa6jj4TZM1l4uBgL+v4e?=
 =?us-ascii?Q?NWgFVBm6omRnV1IqHfc0ElqSLg0cve8CdJYwJkXhxkA8P/fkuyk9gwlvoNI8?=
 =?us-ascii?Q?HdaaypO2u9vuUiRQJGrw2qRYBQaQrt3OjF8CD19omi0L2AUmL1nwk412Bp/S?=
 =?us-ascii?Q?JHcJsh600TD57iU1viG5i7kCp0hgK2sSMk7rSjRaDxnniGzsHeV/HWP6k2VN?=
 =?us-ascii?Q?0xWOBtHj5jM/Tpwtdli5YSWCQyVMs2ydvqfIydUO4a+lXjTgMEstuzi1SR9B?=
 =?us-ascii?Q?ma4brux3EmBubJ6zOuyr/UWdsR7TvTuUeU6t9rUSnHk4DocFvFpyho9+L0IB?=
 =?us-ascii?Q?Wug7Ocktz0ja/SFWgLDNJVo/q4uGKVOBltFZehYa1AOsN766514B70oxQBdR?=
 =?us-ascii?Q?O6bkS3n+oyh3590u6mrZeV2KqAlu8U5/xcyjixKReUDgV//DgER8rBXZTUpX?=
 =?us-ascii?Q?jBjA81ZQ9J1qS6ZuJ92J4LDWZSo+Tm84KJDgbNOwfxLDrKrZYOnL4oD7Eefo?=
 =?us-ascii?Q?FsJG2bP3TWJks5NhjpB+XTmbe6Y3L4IorckbUI6p9Q7hgmWvQmCdamhJ1glz?=
 =?us-ascii?Q?tWZWMlrIu8O+gAnAS1jADyAIXEf2g7bZJkntNd/9EmCMDlZ2NWQDJIxD8uLq?=
 =?us-ascii?Q?qLZnD+8+Z4Dl/ibWjHxNbEaF7a5AszxO9rWD9tj6JbKEil9ThgP7loCGAdGV?=
 =?us-ascii?Q?skcU+CfbJzoCAdKlSE6ahufKRDINxjYuDkOI/CPqn7PMxdxpPE2tIGkQw0j3?=
 =?us-ascii?Q?HbkaLr8bDiNlPV1ml7tJMzMTTbBvxil8Rpi/4jnq8s725d5OOzxoPrb8+3SO?=
 =?us-ascii?Q?UDQFcI90ZrDIcWwPW+b5mWJ8pjSLVAQWrYQCFVYtfhx11Q0GPZ5BnoExir7q?=
 =?us-ascii?Q?OPKq9i4ovDlGh8jYBPz9E5OyDraPm12qph1oodQRGvWty7J6CGIXMriP4Koj?=
 =?us-ascii?Q?OT80P3t8TaaHriYeMzlcz3ZwLF+BAFzgY74h8C1OCjwG6P2jOGeKk9aKPUO+?=
 =?us-ascii?Q?lUW921UVQt+JU6eC1PxRN8gS3Ja5uaNKskb263TCZqMD9B5ecsbCD6hK/dbg?=
 =?us-ascii?Q?dgMN00gj+gnTKXangUdp+wx1sKRZTK3gby5GybQU1ntxLwMBrGxROL/IIB44?=
 =?us-ascii?Q?b0PuwzGWTC1yQt+LL8/yF3d0w/SUr7KklLfRH87xs+FgrmiXgBIBerZGylwh?=
 =?us-ascii?Q?G/RrECLfCRNiHkANkFgUug3oQxVvV4krQecHEeUw0RydJIT8YCFa+BFVkdJ0?=
 =?us-ascii?Q?uzZCzJgv9xkHuZNei3Ue68f+vifWmAQz1b06KnGH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688aaf90-d8c5-462f-dd24-08dac785ca7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 03:51:06.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vc7PhtXS+rR0fRetde/tKd5Og5HWazr5Ohgqb9ZnbzOkqpY+eoPm4LFHcM8teicbozVp/dfsJFAnanc1J9yYiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, November 14, 2022 9:41 AM
>=20
> The Intel IOMMU hardwares support blocking DMA transactions by clearing
> the translation table entries. This implements a real blocking domain to
> avoid using an empty UNMANAGED domain. The detach_dev callback of the
> domain ops is not used in any path. Remove it to avoid dead code as well.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
