Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C06C3FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 02:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCVB01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 21:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCVB0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 21:26:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABC305E7;
        Tue, 21 Mar 2023 18:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679448381; x=1710984381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kki0ppJj4N1Srp4JWo2SF4/LDtaMNZkFS2aCzk3x97Q=;
  b=H7M6/NreciFSiWziSc7bIhKRQsJCK2KcAeSILr6Dc5Alr+RIjqKCSjND
   Kw6CXA2DAqlvxAvTGuc1K90i0b+6DFOyd/lA/qHNx8KLa7fCLf8xOb5id
   INQ9zhQmV1+ooyWmd2JBl2VNvsQ1Il3rNFpxbKYSQl+djZiGN52DQBiOV
   mqwsv8xa0+WcVsSZbcQl2g/5CytWvDGVMLRQ8bNmXkZp8SwaT0Gv2ijNj
   aFL95KMRqwmS5H3sOcvpn8mnJLVLBL823m66ClYUvozsBSfu/p+e6fr1Q
   FVfeHvUFY46xytyZ9mCAUDEyzJL1WCeagvScNwIhECxjMyEWx0HD31c7m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="341456265"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="341456265"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 18:26:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="659010338"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="659010338"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2023 18:26:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 18:26:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 18:26:20 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 18:26:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzV1Oz7M2/gN+yHcTgfNqrvXP0I4UvFYt0yoFtqi7eusxC89RGqtXKhU/h405/fO60FMj9I9o3vlMaDP8CTEX+4A7lNxvtNW/SgwJ21y1ZH6AmLzuNVUPa9qiL7EFa2lpgtSDQWgrVu0e68QpysBHbsTcDkg7O76Ara5RRaO+g2rBlt/RJ0q4DNAO7hP0vuLxURGB5qNRNiQHYgqFhTmAgiK+DdBvB0Z72t8vjvxnWiOcssBeyZv9IMvfrNNVAhyZ9511e6sLsG6RqRYbgWCZGX/b+7NIuAaPjPByvcl9FXfNa+ioFEmnmJHY2QJ7RW5FXiugP1nbWL+f5nCheGykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGM+/n9FWREY5Ik+m90pSVTMJUezNOGFYG5E8ZR1or8=;
 b=Iow5pQAPqZsig5z6AMhISIdYdtb9ff52hl0QjS27JOzFw8VJjEAeLWJtzvNo9EsY/Hjm+uVdn9WufzZbbJyhB54G9ecg5e777Pcd4Bl3Fp3gF2mXdvKCpCrOO3F9e6djXrqplQeDCDAVM9bdbll7mdT8Tj7yrHQLtWSBZnGIkEshLqV3oVX5xVQ3k4tjXDHL21cbsrVNFzn4n5drDp/3GK1c3iRVVv6dgjZ/iUoKEO5AM3MpIGgeSutyvdgXgsp/UORRIyaQr8Yk18Ar0rst8/mvTtR8xdAWaGPvypwvs13Yp77tNhadjbBqAFI/BiSytnmwAVd8C3CmZPeQR8A+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6179.namprd11.prod.outlook.com (2603:10b6:a03:45a::17)
 by CY8PR11MB7732.namprd11.prod.outlook.com (2603:10b6:930:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 01:26:18 +0000
Received: from SJ1PR11MB6179.namprd11.prod.outlook.com
 ([fe80::850a:d637:5760:4f53]) by SJ1PR11MB6179.namprd11.prod.outlook.com
 ([fe80::850a:d637:5760:4f53%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 01:26:17 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH v3 2/2] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Thread-Topic: [PATCH v3 2/2] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Thread-Index: AQHZW7Vs1kabwX3YRkO3YgGx1+Sbsq8FYZGAgAA8YgCAAGKaIA==
Date:   Wed, 22 Mar 2023 01:26:16 +0000
Message-ID: <SJ1PR11MB61797170867CD7B98CC68BEE89869@SJ1PR11MB6179.namprd11.prod.outlook.com>
References: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
 <20230321052337.26553-1-qiuxu.zhuo@intel.com>
 <20230321052337.26553-2-qiuxu.zhuo@intel.com>
 <20230321154751.hgeppd5v327juc36@offworld>
 <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
In-Reply-To: <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6179:EE_|CY8PR11MB7732:EE_
x-ms-office365-filtering-correlation-id: 4c84faa9-dc86-4868-8012-08db2a746ee8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYBLdOE1EhUAo4fMc6uEaVZpIBPOmFno/kBn3c9P7G4dHnlvjCV5lHKomRq0+h6IedpHP9fp6hZzQAgSehvkNbuSN7X23Lu+k34fpPoNdAyLBenuwhBvfX7IuuCzygsCRRbWY5big9qR3Qe7cf5IJR6hnUIEsYwmd2+ttNPMwO9byvK5OPwvwVCcz0o96lzBIf1zDcxzAEO127iE5ZrA1aozQUi/qm86sQdi8XHYAPfYDHBjrTaLBzcPjuFMFXGr7N4JraP3HFl0Lqg92iaawB1pS2itUctl5X3IYMcTFZovVPNRy95T732AbEV6H8J3Q33Jh0ZTg47Lfz83u5rYwD0kDRRYsjREJ65W4JVIGRa9teN7827RnSnfuW0gkJ41mfH58Q3YatMAN1PhViQ1f6FDpZSJlLQJtd+Va8/1sIWUA6PufO+PJHiH5BK3I9FATaSCJe4WmVWtI+hnFJRiFDP1178PlAVhg8c6dL5vC03naESxUwFfY2IW0xtqEk1rLUWfYDKct+sV/6KFcYK1nyttzJsctqH5pX1js84io8c8/ElO5nstaTiSCflmTa+yvj4CAhEIQiPxW5pGWdH0U/VoqmeQkMtbUL8J0AVOj+tzyWsizj6Wr8PyONziLJujVA1QXFLkXX6/ExzgvqBzJT4cvmKLnILSWnCmiI5mMrd4S78CDQgv+Fj9Qc3ZrA8P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199018)(478600001)(54906003)(86362001)(38070700005)(55016003)(38100700002)(66556008)(66476007)(122000001)(66946007)(41300700001)(76116006)(66446008)(8676002)(82960400001)(52536014)(64756008)(4326008)(4744005)(2906002)(5660300002)(110136005)(33656002)(71200400001)(9686003)(7416002)(7696005)(316002)(6506007)(966005)(26005)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DA89td8aNTL5SmMFx/du3PQWP827mSrTtyK5QwZwVLldh1iX+GsZv3HgepIQ?=
 =?us-ascii?Q?BARUYUCvTWe4dBj/VHHWBsYxlYH8ksyZ1qdpbNNiJkZ+HylbLeoLdYIUI/Dj?=
 =?us-ascii?Q?ruA/2cmQ+fVB8G+raImfTXJDoLZ+VkpIsm67l0CgW6zCL4xN0sRHdRIpjufJ?=
 =?us-ascii?Q?JkuZGMxb/+zH8e++uRUCbUU7jo50DVVsShtuh8PQvjFMTzz7SQibrKsk75Qo?=
 =?us-ascii?Q?HTZeq+AssWji7P5y6BtNbGPUHlTENhAL3FRz5mNqMbneYS2LDM/qOyqFyiGM?=
 =?us-ascii?Q?wSjuydVpxxE1scbRB5XFgAtfDEgUzD7ZkCyucpUbXroNO7jy4JB/ZDufTo07?=
 =?us-ascii?Q?7E2R+I2Gl7qP6tztbFlTeUb4eqNO7qVyxzp2ilGclMPFOUJSiYD7F3Pqtu/w?=
 =?us-ascii?Q?Cpsw2Dm0EHoLStXnh16etfvG7Mjndo07ZyYG4qgSwumMcfkVY+Y1k3kBRAgK?=
 =?us-ascii?Q?i27peZ9SKKVaarhH6603WTs2UyJXh8PxfUAgty7xhs3cNZm08hLcwX7s/3RR?=
 =?us-ascii?Q?uAPuhacg8IZLy1cMQQ/RfanYvdST2TXfhRf66fRayIhOYwJxLa5PSrmE7dRd?=
 =?us-ascii?Q?xaSrn+KBFNE1RPjXwGEXmxaKwf5gOJDtImhFSBrKTACsmOoS6rVZ1tWOQ4ue?=
 =?us-ascii?Q?leH5TgaLlNj7vYCEbs9bN+DeMq3QCD9fxrx7W8Xqtso0LvNG+g7YPHcrg6a7?=
 =?us-ascii?Q?IXDrxF3eCZhdJXqg2o9yuqcYIZAigfJFhKUek+gAeS0QkbnqdaC7XHJCnL6s?=
 =?us-ascii?Q?uUrY0HGbLfOvZrvyjI61TJhvhXOkYezJC9Gli1dhB/ozRah1bvAp6YPJ0Sox?=
 =?us-ascii?Q?+V8yFY1Q5Zm5gTkN8mAJSDzN6dNTilonLIIoboM+hwwWUX5OqGd+hL22RzHM?=
 =?us-ascii?Q?lGx9Zi3trmg7DBxE4QRM/Fpg1u4/BvggFdjlyYwpHsboWnrszLTrZgUVqk4X?=
 =?us-ascii?Q?+9ibp1V2Mva/tdbUlDf8H/u0gSMiHhD89siSCFC/Ld/wiPJDAVjBp4RTc4qK?=
 =?us-ascii?Q?3Od6+ibAyMVVvLOrrGeRgpkGzumQnqLhOM8Tc7lzxddj65Avte7edvzjaDuu?=
 =?us-ascii?Q?aYFyUv6iKXPhfpb5/FUTSFmalcnKfT12QMFJun3TKQZVuu0txsZQsMcU+7/2?=
 =?us-ascii?Q?9A6IWfzRlGSJZDG3r+/aRpF5qJAx5oYym1dNvLD/CIG9CWP/a0rNY7/v3ZcO?=
 =?us-ascii?Q?hrkaTqQGdCr0gPfpgQFh8xDHVtCqRIoVwKiy7z8CSqN2ZZ4CO6MWM2+5cdOe?=
 =?us-ascii?Q?AXUiPR3sO1Cip8ZhNtudF+cJZCs8baqMBKKPb8p8TpbzbGxT3KEFmOlAFYQ6?=
 =?us-ascii?Q?z6M3OSqwFIoHQ4h1DBIeQxmXeiBvdelBNU8PZR6jSv8S3SGDxAXSDf2K7StC?=
 =?us-ascii?Q?9TbUPHc/4tJfR6GXsALpqcVBu2i6w3zcbukeVel1XutF+t50b9+B5gbqK+hw?=
 =?us-ascii?Q?uM9GorI+ilU+gzh+hyzEWoCU8MWqhwJTEKh8Yb+vdvi/eg3aBFySGAFtVrET?=
 =?us-ascii?Q?ODuUF+s0OL6x7WpgM7/dJ6QV45bbsuSytq4CVMANU2Yvd8z7qQ12EnSuPWxk?=
 =?us-ascii?Q?+q/axLnLsmidSlzu5GrgoFxAL7Z2d2kD2TVaeIw8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c84faa9-dc86-4868-8012-08db2a746ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 01:26:16.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sE0arGSjjxyNhWCXKrzEYChQZnUCt61QsgGjpSrl31a/M4DntoNQET6BjFa2sU8NOsVjjhDBt1ctGN0WGYwA/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7732
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Paul E. McKenney <paulmck@kernel.org>
> [...]
> > > Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> >
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>=20
> Much better, thank you both!
>=20
> But unfortunately, these patches do not apply cleanly.  Qiuxu Zhuo, could
> you please forward port these to the -rcu "dev" branch [1]?
>=20

Hi Paul,

OK.=20
I'll be making v4 patches rebased on the top of the -rcu "dev" branch.
Thanks for letting me know more about the RCU patch workflow.

Also thank you Davidlohr Bueso and Joel for reviewing the patches.

- Qiuxu

> 						Thanx, Paul
>=20
> [1]
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.
> html
