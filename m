Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B463B813
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiK2Ch4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbiK2Chv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:37:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7A512AE1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669689469; x=1701225469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E82gyarBCFsNNOtAxJWdi0iafr8keX5tzFsWVvap+YI=;
  b=EMCn5CAHLb75M0eENFvITCFu5xlhA/o5Gct45AJg50M/xx8l0K26QuPk
   xXTjV0VQt7EvcFNzs0BdlmjxskoGwGnqA8SN3ArknJv6r9PfJVlmTu8J8
   y+oE/uPHwIY2/pnGU8RX9UgO7M/VOfAQu8/4HLtxgiQs+DB5myA6CCky7
   0EMA1VEuAAhqa7nUoSjcZ4ryjoWrv7HZJY898QHulwxbS9dlDaVFAIjri
   RchuEl9OFRYFoZDwMK5Eq01JO2J1if3gWQbNtPe15YmN7XA7KZOVuuznd
   Jss6mgB+C8jTpf0VkPRbJTzcT1ymZtdAbTrWP6XSPuqmanhlOSjd1n3to
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="341921577"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="341921577"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 18:37:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="785873589"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="785873589"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2022 18:37:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 18:37:48 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 18:37:48 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 18:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj8qvcHirej2IyvHNjYeFoMe/zpFZrMydZdSN6erJpjksZlaBxH8MXDf0qp12wP8AW+0ZkGV4fEu26ZGS+U0jzKCohaHVdTr/fAomsSq044wkt0JuSTD0INUqcJM2J/76EhTBGdN2ALxHJQed9tHSgnheE0890HhtqjfKGrvFrI7KP+I3+hYyUQFoap3vOHWdeyBXDLBSC7hUoeMagdsgK1ZWmZcL/X2LXPFGZwkDbi8mKh3vUhnDGOKBfrC95xgIqa8YbHgXDknlfPt1QlCMAYUk7ZTfh3Np+LG3qYVd4NJCO5v0XtMx6fZPMHJFIsY1q4BdhBtCKlPdAVvebYHWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0zFsH1ugX0wPoQ+2hV0IBypL3PbgvRadm7a1mh4KVg=;
 b=nkyskFARNfAgY4JXsnLUe9l8bGWXR1PalKRbqX3ykI8kxEmV7hQHAHUllSGpI7zHbWuOSPWiqx3Q5qVj76nVUOWRV/yWJTIHXazLxvhbFDieJalGWnz+LB8ndsKebH5HWh+3OV2JBvkJmzsIwmPYLnF5D7VyCTix++es0Q10+625PCWF3oOxBF4poVcvex9jsmBZ1Vbo3xcjsUKfULreZCh2xBBJ89nFF7f6WfPSxbpzZ/L4gzJDLZ18Ro+nxPti5FEvBckI4uAUI4SPmPSeK4k3pJ87YUNqCFZzYoeG/TlqI1NK08DiG6hviBGqR3ufHvwUkNMGhwEPfRmlogZiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 02:37:46 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04%9]) with mapi id 15.20.5857.021; Tue, 29 Nov 2022
 02:37:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luo, Yuzhang" <yuzhang.luo@intel.com>
Subject: RE: [PATCH v2] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Thread-Topic: [PATCH v2] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Thread-Index: AQHZA0sDmZMJponTzEKZnMmF3PJ0y65VMCYg
Date:   Tue, 29 Nov 2022 02:37:45 +0000
Message-ID: <BL1PR11MB52716203AF9CC7CADDAC0B4D8C129@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20221128170410.3830605-1-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|IA0PR11MB7283:EE_
x-ms-office365-filtering-correlation-id: e78da6a3-7747-46c1-1411-08dad1b2b2f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q5jQWlzNGRAv5HQ/7LmHiG+PPjKfuF+D+HCN9aeXNLlsINZFCijJmLAMYA9Lz4wqK7Fis32eOkS3xi5INYOG2TVQ5IAzlpmUTzyvIwI5ycVFWH2rn1oJu1VPhtBdjfwmtu7Ai4mkpt5ohE04mPMmA7OglvNsNHfzJZjqs+6499+8PwnW6DXhvjt4/ARnR029watD2bea7yuTXy6nS7KNG+SvScwWvaAolAV+KKhHhBI6oZy0u2DITq5IBvJhE2OKprNRcPbUb17AqjSwu2tQyJhQSIQ7rO/X+SRPAD41YrgAtLsPTw6zJOwJ3VKVvPdceicUVJRCASw/yBmJm2BDXCbRGJ+RNEKVYfHD50ioffY8UUQeuZfmaBLgsslCOjNHc9k2vmtBfZ7mj/YedXQ+kqMMaaBYtI6Zbjkx0sHIvKKJSj1jflRTETG+6M88jbIBO7h+6dN5jrcovlxdNpjBQLD5TYlbvKbed3QmuM/h7f3mZqzGoR3K23Eu3m6yVrYY1oEK38C6CzR4cNjJycTdkLMQGUSgP8mZz0XShcE2ZeyIUB1lE8kqUtalPy3SZQzooXgqnJa9dOFM48XplLRaQiHEjXJFXJpdVrCD6PXqAK53cKIBLf0JJ/5UgcjYPnhVviQ55A37ZKkBFRnU9oE7Gqcpbu1fu3e/Ep2mzb2WdytyJC0+4zMsGe00fIR9/S9+w/S7Uv4DoxGuvQSPlvabvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199015)(38070700005)(55016003)(558084003)(33656002)(82960400001)(86362001)(316002)(110136005)(54906003)(478600001)(6506007)(2906002)(66476007)(66556008)(66946007)(8676002)(76116006)(64756008)(66446008)(4326008)(41300700001)(8936002)(5660300002)(52536014)(71200400001)(38100700002)(122000001)(7696005)(9686003)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2k308atOfyBkezdm5/m+G4Z5oxowR+ZcwKf9G8QaqmyWk3HS1qT5lqf9r+yU?=
 =?us-ascii?Q?Jmh6g33gVVXWKF0JMASrjbRzQcKgVNkUe8TgsHBy10x3HfbFVPEdDI8kCjOB?=
 =?us-ascii?Q?vC27JNn71sqn5OlOhWY089gPi0afdXQIpX/9nVviPC4agLKXb6RbFKy5sNIb?=
 =?us-ascii?Q?/updo08onGBecwVOj1lEGAqDECzGt5z2ps4ay5ljjG0bgUA+0+zr3pY07fS6?=
 =?us-ascii?Q?mH14tuBHBuQodcxTua2soVRmAShvxyjQnl/ihXh2b3BH9iEELRpwMrZtfYS5?=
 =?us-ascii?Q?MltozUKBpCCp253Zzdp/1sH/vvbFerzb4SNVY3sCkWFo/rKGZAVmXuKJxVa8?=
 =?us-ascii?Q?a3EUDvEc0RktE/Rhc5KjUv583cJK88mleWd3bwB+51v4NJzOGYVLPUdgyDIb?=
 =?us-ascii?Q?mHT/Yf5FfbGnqIOBBu8MriYMqkm926K4zakN+c17UiEFJWEJUKPPeUV/B/iL?=
 =?us-ascii?Q?KoTcr4Zvq8aFbttHdWV5j6VKKjaDzPEIrxYxVBQukb81kuGi74/meZZ3snFd?=
 =?us-ascii?Q?Kgk6vpDJk4HSQk1l5RFjmN/LO5S7IiuXzAuI8VFjj3xeOGDUIP+E49zGmFkp?=
 =?us-ascii?Q?wptX4tSkIGE+EZl5Vm3PC9iGrH323drxHhep5TjCHxQDWsxu2S38uqx5IpQW?=
 =?us-ascii?Q?ccLaNmNtx3AcphtbHaHqt9PSrUAPYXc2qehlbBoT3OY3H2tK/Na9gUdodSvA?=
 =?us-ascii?Q?yhj5E/CCe0frM30FpY9WUiakuHrrIZ+NqZkWDYy3P1/dUrW8COgIjCsR4lCI?=
 =?us-ascii?Q?EzilCT1hY4jYbZjmVqu9Z4yPsYExs/IUtdFBQjyTvf2ajh3x84u92zMa31ks?=
 =?us-ascii?Q?tk7R/i98dB6rcO5aB+n5r2eFK5/L37vODsVkKkTdNiazrqX1AuLqXL3LWRtc?=
 =?us-ascii?Q?yBsdJYO3db58WgEceYysfCTCUHWNjQFN/i8YZoesJoprBXrIeTDnaEpAuDIk?=
 =?us-ascii?Q?BLw8ALrdH4rnvXSD8U48qwBOHhLwh00jVqZgJBVX2xNtud8iK9bFb6NAdxaa?=
 =?us-ascii?Q?zyqQoZpsaLvaS6pARK5hfzcqKqxVCxMcSh5jWDpp3yl+J2jxQ3K57jiUQBxS?=
 =?us-ascii?Q?1EYGkT+LFK+/L8o1EPm4Q2VRzyemRvp8D2QoVSiWymxSe3x4n7Dlt2CJY9nE?=
 =?us-ascii?Q?bOwJ2Zb4HO7MWp6Fy3KJIrTb1sibePZ+YbVblWgOIS9mig7mcikk3JBhfhSj?=
 =?us-ascii?Q?B3cZ4ikqyp2N9HgPd8dXcY4MZWdL48BF+OktDP5+4a2m7SycmYG2Wg+Pbmx/?=
 =?us-ascii?Q?otuKK8Cbmx+bCSWyTTUxUWYIXoi0rOBlQ2j+wmy9/F6TLA4ZOTTlhg5SmPM5?=
 =?us-ascii?Q?9nF/QWs/EQ9oXvFm+Cagb683kkK2hFQh1/5ULt84WUs1yU08qPPT9nNlOFaN?=
 =?us-ascii?Q?Z8a/PYhEODAPlqaylFYx3s6nRMY7LftkhCp6F9nvMaqLzpJ2xGu9IhbJnzHX?=
 =?us-ascii?Q?IIyIDZv3vD3JT/EvPy/Ga0qcx9ni/n//IxUClZdRIFQlrR/fQO9B25gaA9PZ?=
 =?us-ascii?Q?yWHPPiFnRXfG51yesvoaQPbR+59b3RTFlMB/jCgxC8CPibqYDJn+pyuru9If?=
 =?us-ascii?Q?w+DzVc0GiyEgMO/IGctA6rLTbh3hWoSo21Q/Mso2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78da6a3-7747-46c1-1411-08dad1b2b2f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 02:37:46.2445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yv7GEvLEKj4+EIIEBoNtIDIsEqax0Flm320BaJt+2m5cw3Zmso/5BgWThpB1hDVT9W7EgI0IZW3dGP12e22XdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Tuesday, November 29, 2022 1:04 AM
>
> +void quirk_dev_tlb(struct device_domain_info *info, unsigned long addres=
s,
> +		   unsigned long mask, u32 pasid, u16 qdep)

quirk_extra_dtlb_flush()

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
