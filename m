Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DA55BDED7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiITHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiITHwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:52:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955C4A475
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663660312; x=1695196312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/415FNVww0J6T6zwy84U7hMtUQkvnLB/1RnJeY1Aowc=;
  b=aSVRrRU0q3XdfQmLJQcna4VOssnhpWKMoVk+j/Tkgwr4Nf8j7+kxfwlW
   uK7XSEodnHxwcgVdkZwr0R8ZSwBjjL1Ht5ieSN9Wyjn2XQcnMhpjHDJMv
   4qZtB8abkKnCrC05p8rNI2ERKKP15tMzzrKsKZYRAryvo8gq9bbBgixG1
   qW7JuFhrkBLI/c+VM824LrPAprUo4kdBfzq3hGuzASpvtL+OObV+CiRRo
   KzsPQLUBFFuQVbbFd1YeYy3kX34Tdb2NEIqfaIfhl5jyb9AShFHY/inUq
   Dj5i8OLYIXPvHoZhHIT9+7krFR/C4SsSW1wWFo/xzbxnJBe3SMcrBcEhf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="325927073"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="325927073"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 00:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="569981122"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2022 00:51:52 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 00:51:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 00:51:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 00:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Odq4xm62+8DiLby/LqXwFNw8eqOjIeKA8MYA1jgE0Dq81kwYkqRsz/L8onQdM9VwrFgYt/6A3xmFDZUBfroQ1r6DsQZ8NHMxaO+KSP7u5qQA2XQtZzePU3hsIGZuxxkr5UO149J0fNwiLdJfiRyFkl1Ue3oGDUR/ZDbmLIWLXsfccPl+9Ga+bfOhvcDxP83eecIzFk8jGsAnwRkDtt/J7APysAMAyF00MJzgkzkHth+/ZBzx5zuzleXJ5GPYmafOWM5tZC0uCVq8r6MnrkPDc4k12BPJ9G44ij2m4nIAbUxY4q3xrhcdsd79EyK+h1TEiMyVlWkop7NLOhZyUegSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/415FNVww0J6T6zwy84U7hMtUQkvnLB/1RnJeY1Aowc=;
 b=cNT023cGYa3z6rFEl4wLFjxN/4Cx5XMHY196ud06bIMfDFAB/mtS1gAAkEt+L5DpgK9EFPjF4GcX91DQ4BfUEVq5L6MYw13pLv2loT9xBljiAaDbZtsnbbbxeGSpbc8Ufv6BTk7FHVfInMv9rw5pq8v7QGOoS2qY1nfRlE6ChJEG1/yIIjeN38hhx4Bc0bYppy8zD9OKA8pZz9SWlhJzuprRCl/fdVukM/JFngPTDanw7tqEOROj6AYrh3aMXIeezffflZxWSDnv2Vz4CojsAOH0eF3p2D5CY/xuSiU9IvKtTMgPX6shW1eOXNeJAcraEja7OIrA1ybWti2EbV982w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7101.namprd11.prod.outlook.com (2603:10b6:303:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 07:51:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 07:51:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Avoid unnecessary global DMA cache
 invalidation
Thread-Topic: [PATCH 2/2] iommu/vt-d: Avoid unnecessary global DMA cache
 invalidation
Thread-Index: AQHYy/F3FbzI9Jv2yUCl15h8lfYKJ63n86+w
Date:   Tue, 20 Sep 2022 07:51:42 +0000
Message-ID: <BN9PR11MB5276C0D13C6AED74242453F98C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220919062523.3438951-1-baolu.lu@linux.intel.com>
 <20220919062523.3438951-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220919062523.3438951-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7101:EE_
x-ms-office365-filtering-correlation-id: 794aba53-c567-4719-0ac4-08da9adcf581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kncg6TntnFIbFD5/b0n4kNbDh86oRZe8lkb7bQbYPDGhEGFtZIK0lEZa6vEyVNVDm0O4sKDLG1l6aYjC3z/7LF9uWgAhw9V9f/Dm0B7Bq9jccZYf8jJWJT2UOprOZGqT3NC2sVtSuA3cNvyDmU/r3xUmZhtvuzBkYjcSg+tYZxcD6pBtYrmZfaCSh8ecwqrIgPo1wYmJEYJDgAa4VvOfMIFifI0Eicr5OGZu9leCqM83Xn8iLzkSa4quW2gYzWHbiyuB7zYa1lbrHKbXXVQBf4HYs7pFveQLgF6FjcfwqRWj9T/J8P60XctLSeEGy6yZmMg7q8vIQAEQg9Ioz7Iabb2B/auEHlfUgmjXkXjhPN+0/DE/K0GPpdv5kn0UxlSETU66aqwrbz+75t3lREUwJ2aSzqcJUQlkl1TX3J2yBR6cOxV9uXmKVk0mXrwqzGsFoM+QnOipGo9ubuxKZecZoEjJlJNuztp/5OmUf0xRJw1nho/rPo5ciMu+XvHiolv5e0KtKL6k+XeHgNmzQDSkGEQ3Enm79P5Q4io6vPOLhvDoE5D4yRIsFFttdaJC80qof8IkLBVuJFNucVDk5HkQI0LFt7b14syVM4j3JOUeItKDZHLrz4uxlJ5R/FcZsFYPUEzsta1XR8dJOxQzAXYReFRW+WQY0FrHLv72rYetOpvj2AAt2A7t8vrWthKhssFQeP7xGEU9bUPIeC/0E/hoYPlM5xgMzEh5nOFfRgndwk8bmZCTN9SgW620WtlERUN4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(52536014)(316002)(83380400001)(4326008)(8676002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(38070700005)(86362001)(33656002)(2906002)(122000001)(38100700002)(4744005)(82960400001)(478600001)(71200400001)(55016003)(9686003)(26005)(54906003)(8936002)(186003)(5660300002)(110136005)(41300700001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a7bGRWmT6m+9LHBRMa3qTF4LIyH61KOSQRARZ5FhhS6g0lpzHUcelpdXVjgN?=
 =?us-ascii?Q?Oyi/YxhqCEfr3we8PJ0kTcq4wxxfCNULNfspOhRPK1Oa3HjbTTAmrEMwSUwo?=
 =?us-ascii?Q?fH/jMAxh0qnp/O9DgQRY5u8ZzUzgIcuZMkGoviHQhg6dfCY8V8GH4cuGoPKj?=
 =?us-ascii?Q?XPOj1nxmG/8pbzeRcMnFFuBch2Y1uyy1H+dk3M6hCfyjyyER0ZmLFYhMjWti?=
 =?us-ascii?Q?RUshzaygMjgWLWeY5vvhaPg/iolO5vxJceIBXt1S/taj/Jc5YJnhkLKeLSkF?=
 =?us-ascii?Q?/MtrdHoxKy6LYateUkNWLnrQ0FKsG/KzSJim22c5wI8X1ycD38X/KbWJzwPe?=
 =?us-ascii?Q?7RjttrvBI0M4f15F09+/DyXKQAUKXtgIAEX1NhsysCgTEML0vAOT50uj8xId?=
 =?us-ascii?Q?QUrCWrhY2e+sk9rsoqeeeSDwVItsmR5VmWSqB0mrnYl1FAGBeokEZiXdWWl4?=
 =?us-ascii?Q?qMnq/8Aq0vGt4ZOMTFRWyRjEi2qjBWilWxnvwKLCOsaCCmIa91f0ZrWGggLY?=
 =?us-ascii?Q?zJ8KiOtHWxp9Fai91F36npo3CeWEISs6/0pkiHjG7Ew5HCJwjvXWHJk65Skl?=
 =?us-ascii?Q?PTB6wsGUwd3ef6qp5uI8qtQw9bcDjQNlts3yKML4cgYOd5YMA9iDVmRJZq9+?=
 =?us-ascii?Q?lfSzPXyZNWUDgmBiAzDD2TtDVzxKpmsRXq5Z4jbhru0thylinTYJFuBCcwfQ?=
 =?us-ascii?Q?ZJr/sW2sxzfXxXRsQsLI1NN3GTm5k5l4jK/XrLgTV2ldB1uDMrOgCPQ3yF/L?=
 =?us-ascii?Q?UV0S7cUI/NLvYt9uS6d21k+H0vP562/omyTmrzyoaosG+5tFWXzA9TjUE+Dy?=
 =?us-ascii?Q?r5BrQhC+8RQVyCBHR+097KMl4jqJD2yu533B/R05QYKE9Jkae6ggVFYWq2eY?=
 =?us-ascii?Q?2cuHU8MsxIK54/8cOJGBpdx89Swc2hjYmUV+9oJAX/umZididyA8emwqBXOh?=
 =?us-ascii?Q?GWbK7MSYpmoT6sPrSe3oeRykAdMiopHVCpbAQknmmVcpLh62JoiypoAAZ3C/?=
 =?us-ascii?Q?9nAaQP1ACvEcoxtZfpNsavti2fJPUkL8oBV2z+tGWZzyaTEFiUexYkextD9N?=
 =?us-ascii?Q?kkWNXby8xnQGqj2rrs/SXWNQO2Y/Tp2nlW4GOV8hrowDDYsfpaxzsUNa0W2S?=
 =?us-ascii?Q?tY0zuB3KipxtXC1ht08O7xo1johyEENRbM6pSAi9UlUlsaK5PE37ArdO6s9c?=
 =?us-ascii?Q?znqahStFq980xPVnOIoZgOCY5IPjSzNDlpjC/Kamzc9x4wXPnfdsvZaq2c60?=
 =?us-ascii?Q?c1eJJ9Hl57uVFJACHxO0xN+ZVB+aUcGGcTR7LK16vaSsAXZaV0IaVgQ5/o3F?=
 =?us-ascii?Q?sIvMuhl3v6OZS4nVmDcI/jUcaApA3syr6A+CLO83rM/N8WXU6c5rGRaBkd7z?=
 =?us-ascii?Q?o9uptX2GyEDKi1S6U9zQhL4m9vh9St2Oi1P/UHi/6T/QCnlsAjiJ9FWUaypM?=
 =?us-ascii?Q?y2ymURKJtCd8KIjtKtjoyEzxLAy+j0p9VYn6zIYUK2GHESpRaYfqAkUBhViI?=
 =?us-ascii?Q?ge3SWwCSL6NYU1nkD8aJdA6zfT2Mg/QMeHVL97g1oQ8JlPNNhipHoEy8HDq7?=
 =?us-ascii?Q?NgYT/8CIRFx5UN9zU62+kX81qFvs7mqetWGO9H8x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794aba53-c567-4719-0ac4-08da9adcf581
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 07:51:42.8547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0UFki4/ojsXiuPjN7ARsmOgs4YVpa3OgJYq6wCE1CykoAB8MMN7KO3VOmin4rKcnZo1WEmY8sKUqhbJ6Lo7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7101
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, September 19, 2022 2:25 PM
>=20
> Some VT-d hardware implementations invalidate all DMA remapping
> hardware
> translation caches as part of SRTP flow. The VT-d spec adds a ESRTPS
> (Enhanced Set Root Table Pointer Support, section 11.4.2 in VT-d spec)
> capability bit to indicate this. With this bit set, software has no need
> to issue the global invalidation request.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
