Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFCA5B9308
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiIODYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIODYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:24:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0DF91D0B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663212255; x=1694748255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LVxAQw4mWZNVg9MCbFcpOMfEB9Oc0d47I2Jw+3QQZx8=;
  b=iy6Z+XMCxn4g1wKHqOFDy22tj9ZbA89VFrU1qqSlLrEWvjFH2WEO6zfr
   7H+16btqKlQ6c/aQHUtJX/yHugCeta9py5dVSNltk7d05JjDLJx2Op1qK
   vLp/Otdn7FsMyDohRlPOwqSTmT4ddr372XP2xtujYHUguN2J3VUGvgBVz
   1hxu7iKh6QQu290eJYBQpfDZW0fgSa35MuHtuAjwYW3ctnmN+fYw0zyFs
   HPtX6uqTY3n1uJYtsNU2DT2egkpc05KGQWdGqRWDpKGabZxb6gzhxq50P
   KLPCQ2lMK2LjFXKT884I2XLWwJQgHeoLgUzOkoGb5Jdm/8Z0mnqedbjDn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285641530"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="285641530"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 20:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="862169101"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2022 20:24:14 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 20:24:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 20:24:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 20:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK36cLeRerVVHQm77FTuZDa/Avq+5W17/R9zs/HOtV5qIZJhQHQ2oKpRpRJOSTsHYBAAdNV+td1pRRESnEINtIy8TQh9eWuK8c9BnxdVvAjKOq+3Y0TiGr/0ruW3OV3ffOuXtgvi8cWHde/c1Mvn6tEKIhhAypL5vWZD0RqQzBGtTprEMxNTE9YjpkPfzTpd7tZaG+pNCImtrFiXPrh1zvWHGsDHUaNnjYmbeMP90sVhscQmkbeEPjz7Pw8l6CdyqMbzb3oCD9Gz+t5+E6LnNsQMaRQrAvnwpghPKRiRkW8DK93KLWQUo7V8FbV10NSe5J//RKEx3NxxFlyDLvl9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVxAQw4mWZNVg9MCbFcpOMfEB9Oc0d47I2Jw+3QQZx8=;
 b=gLiVfZOkmUZum86OfhgIjyHsFEc4KhIQsbgqzI0OFNtTeCIOvmU0qxOM7t3unu4EvDGGjc3TlB8+ra0vtq0ZAFGr1aEwqvIGe1dBNUtovfyB4+iEUbE8wXmOJw9AmT7M9XmrrejdwHunsIxZLiHcFZt/bKlrRcSjgbtCRt5xOx11aqPv24qE3UJFQH2iXzeoBR8xGpiQtx0uPl5++SFbbk9A9R69kmxxaTkZfADDojNE/oE44XVDFPSKavbjeqj4Qb8FItR1c69/cdg3JsXjltf5Z9XLYMy3aa47772kP7Y6q6uLYn49czCZbaQeJDJ0GKbIvLkvj3ddp4sVCay5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 03:24:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 03:24:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] iommu/vt-d: Remove unnecessary SVA data accesses
 in page fault path
Thread-Topic: [PATCH v2 1/1] iommu/vt-d: Remove unnecessary SVA data accesses
 in page fault path
Thread-Index: AQHYx9i3HWlzMzYKfUWuja0EAVkSL63f1XfA
Date:   Thu, 15 Sep 2022 03:24:12 +0000
Message-ID: <BN9PR11MB527614562B2EC7694A7C838C8C499@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220914011821.400986-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220914011821.400986-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5770:EE_
x-ms-office365-filtering-correlation-id: 978f99f4-6c00-4d44-75c7-08da96c9c2ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8HclchBScyFn0CW+ms+4jStYIRi/KyUFF71bHLdH9+jVh27//POQx9KmTzneXd9izYOSZ43rxhSVbmr/9DBNiaQcqGD0I/VI2LGFlPeHRzYANxxpo1ISy74K4g6fA/2dn26ZpafkE5fQBigi401YNSAZQpAgV3G+GlhLgMxeU3CotZUgLTl2ubSmd4q4Ej/XiEfF+kkrZxGBjQzIkBfnyt+pDajzmvukVZcCUnVx41MSIQeqV4m9jhYWYFIJP5KZCi89UBcaCgjd9axKVINlO5jxyxvKj4UKxLJueLvj8AsXXHxAmxsLCet6MhphfmSaG/Ao+QfHHUdW1P58Geml9Xvncc630bz5QJDM2AQFm6g2fu4c1a+Tojwze1wn4j4S5qIINdUIJcHXiB2zB5DfDlWXMZLLMbRgPlHmKqzrf+1uvIVe/vCvTn/9asRE8bLXYJCP71dufezR/W5JCakAbl12eN6CRtjKRiJGdGuX+k02uJbC74tlcRbcCHnY0eF2q09c9XTO78+gMvcBxMXrEkV98bAhoOjTFv8uZLFcdBU3eXCPJ9ly17TOCy0LXt0CnA3tFZygXuFAmtA/GOkVpxYH8SY+DNi+FcT8rqMMxrbHLrk+5b44rlSA4Y9Twaw0DnwiYMuT4W+ufw1thooLoj0sGC8Ff5LUQdXyShRQuEQQZgF2teBuSWHDq35/sH35xdoJ9N5sdutXr/tYTe6DjrYZp6FL34sYpUFZaNEn9sLHuRVXuXeM62A5eMDqf7Y2dDUwsF9j8ENqr8+VsTCqeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(5660300002)(66446008)(316002)(55016003)(64756008)(66476007)(4326008)(66946007)(76116006)(8676002)(38070700005)(66556008)(33656002)(86362001)(4744005)(52536014)(2906002)(8936002)(38100700002)(122000001)(186003)(83380400001)(478600001)(54906003)(41300700001)(6506007)(26005)(71200400001)(7696005)(110136005)(82960400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tkFYMe5uaS5wLkOZYCb7khV1o9gPDRnQoOklaS590dY7/qGqD4rDf0oDprwp?=
 =?us-ascii?Q?xwF/Oq+T5cOAVAh9+zXAmgDb21S/N6IjE19mGmaaKz8GnVc/EcM9+0b+FFWz?=
 =?us-ascii?Q?HlbEthSGKM9Cg2/KPihx7PWIIzuqV12tReQLaI8kNAkPvY/Pua2VSre/2xic?=
 =?us-ascii?Q?pBx/9OTMQUEviCPmWd/al8O8xWu09UxVzBYB4ZqTSX184x5BdBMq6GFUA4cD?=
 =?us-ascii?Q?OhxauinpQgWHno/R9NkPnq6XNct8hUog2MfecGBnyyGgiytpWoX0w+9KGJet?=
 =?us-ascii?Q?qi2zqzzL5G2ZilXHr1JP4xAwhM0H7DOdKOMYixnCT4gHvar4WC7c74E/D2hy?=
 =?us-ascii?Q?wCl++OMdSI9smbwaBeijfLJmG6bnX7gRR+bh4C/3jSUeZ0RYzhPxXVpzyqou?=
 =?us-ascii?Q?ZQYaDCWHUFYDzSfgrPznv0nNtW7LTZHDIcWIj9/UBFAew/xd47IiIiVJ24v0?=
 =?us-ascii?Q?Mh8OySh3YZxwOcV/fkndoSdjK2xx0BwZfK2YyMb6z5IP/n0OFz1dFi5qAYyM?=
 =?us-ascii?Q?9QSLieQNJKEx+tJ+cIuLWed6SrpymH8oEjNYfzkFoCIY2rnWhE+M/eNSJaf7?=
 =?us-ascii?Q?ITi1Vk1J7vpNuhB9MoCD3GS0JIjHmEDXviJYZHdarX7yAU3E6VRax8rnPGNj?=
 =?us-ascii?Q?+SoB0kYEoTqMPYBJqTqF2PHLGeN6BXSxsRPQhDMop26RpWB477VfLDlMKnHN?=
 =?us-ascii?Q?4PXfNg7bXKhb8vrCvU3MC1Cn84Fls/K7ahBcxKoewjRjwPxQdfq8A73sKLTu?=
 =?us-ascii?Q?WiAhXpKk6KnQjG/uDkTDkyDNKyVmJlPrz52YOuXCvfJN+toI7xFvKw1XIhWD?=
 =?us-ascii?Q?sxiDxCFLfh4h7x+05gmbUMCchZ2gqP+4MlOzNT0ByOsjSHoIuyWRIK6lQj+K?=
 =?us-ascii?Q?/4qBqtjz4XXpQRaz2UTnsh7ileN6XzMane2EykwyZMk4wQAK858kEoV4QUky?=
 =?us-ascii?Q?OEDiT6O6Al0F6ps06U2DSXU9BzzpLuXBT96rBzpuwCYP3jBg1YkJkeRCxMHi?=
 =?us-ascii?Q?Pm73uP4PWOB8lkozo3UVg1DMPte6zpnIlUynHqIBC51SHbopK4vS/FgIMEj8?=
 =?us-ascii?Q?8Z78hcFfdFmW2g6zBVIKmba6tNWECiQs14rAQoAdJBp9fdkSTWJ7qbd1MB/J?=
 =?us-ascii?Q?gnTHJNhDd+x1YN9LgWGwVp8/BKoqpRhlDvXXjhcnZUtuFaw8QU7jIkGqiNDG?=
 =?us-ascii?Q?zpzw0RWvlWLKHXnsweEtmW6oZgIT2wFAmbAfZbYhjCz5c3UVQtlRxfLxAzZ6?=
 =?us-ascii?Q?S23Ok0xIX2H+l2XVUB/lwpM6gXeq20DXpdwX7mZ5KasquLhhCMvOoHFRI2XQ?=
 =?us-ascii?Q?Qha6acAnbagQPR4SBrKvjGeVOo45OJ6FcTQRqSPD+BgLgJRTB/OVPjByhtLN?=
 =?us-ascii?Q?oiGA5wUz5y9avwKcGXWbZimS4nruMBIfBvKMKXYRz9imjd6qJEmYYJ3T7gmo?=
 =?us-ascii?Q?ZKcvM395IkLE89YCRKi21x33ESnbJab2ohU95H9LrT/spI94H6GciMV/vbMQ?=
 =?us-ascii?Q?LgscXYhwtpHmunsBFHXXHtvtPTki1pnEovxkJIYJr7MEDkAu/E/vVbQCcrl9?=
 =?us-ascii?Q?BbQFvX/wjUmV6WdxaJgkIFmBtSBXWyin0qkbAUK9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978f99f4-6c00-4d44-75c7-08da96c9c2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 03:24:12.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGOibOmZtSnGVSJCVilFY54u1fkcL3hQI7f1N0xkSjYtY8gj3vuAyv5OXj9qJWfmjP2KRM9Ym8rdclkNH0ZB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, September 14, 2022 9:18 AM
>=20
> The existing I/O page fault handling code accesses the per-PASID SVA data
> structures. This is unnecessary and makes the fault handling code only
> suitable for SVA scenarios. This removes the SVA data accesses from the
> I/O page fault reporting and responding code, so that the fault handling
> code could be generic.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
