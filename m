Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33D9726FF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbjFGVD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjFGVDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:03:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E81270B;
        Wed,  7 Jun 2023 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686171756; x=1717707756;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=shu7J3pRb1KJNrTWmG9Ycxm9xvCgYRnff9B4XoA+VKI=;
  b=OzIAFPTh5zX1+4QlfRjCNgIjuATSFqRUntrRAg+wED8MvMdPIu4Ellhh
   JOOlyPfPi2U8mhrEH2/so1FKZoFRwZdyhPZwZkGwzFlOj1Aljyo0UM05G
   nov9UbDxo4Pktb9DTp+dmkq5Mdv/2WhhpZiWo4hdNOmR63WTvg0FW8hVk
   CUlD+N4rz8zpbsTPHlMZI2bv8Gs2mFHlvHbJsnQyKfT9jxB/umuK52No6
   mFIR4DUdD2x3kv3BSbaGp5xmFmrv+19XQh4TRf28lagQ3X6qiFIG+vyTz
   2VhPcdi9YYXhLV0doVFmV6SIS66Pa5QjIfqBdIwTTjrzhnc6oN49Fg4OY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="420669853"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="420669853"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 14:02:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774783492"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="774783492"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 14:02:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 14:02:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 14:02:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 14:02:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCIOMXsihgVCZnonLReSdbzk1HzY2pVgYx7O5eeXgyOm/HMHiF7xYayhLabd6LEcDWJFQtxLXhcDuWPF7AuVPIVXaYEzqdzBemJSD3OKhL1c/Dyo9X+zO2WfRKntld/vyKYygOfhXhu8DNuVKhgRJf/6NIsqftnGb0FkogiMBo7O+6kn+vrrNUQXb8qQ3U4emiB9WEKwBl91QhZN1B19nbchicLXeUGZ1mh8Itjv7EJdaZf4wdCSWxw7f1EXs9Iq+AaL8O8j5BQtws1UhEjOBA8MFzianSVg66skfUuGgaCuLcpgBOQcrBJxxRsgn0hGtY6Jfc37KREC8i1fm6hHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMT2NFa6oxGveX9HImZ/SYuI0qDgUM97BqJJwZgmOrk=;
 b=dnGf1EYR5UqjJsSvDXL3LY38C9jWzxgK2fj9tTQFV/oWvnS2Dr5cJ6W3qi1qEG1tY6k0WiKp/1qztJSAszOjAE6pxB5haS+jC2DO+sJnc7iG2gj6TmZGY0Zyk4A4MM3FK974p0oysQk2BeTA5CXjkats8X5pgrDZ1SvlLWUJ6wEVwGskrfSpKqpM5cwzy5ARLgGvxEgXkOsqly9Cz2csv60i4CQxq6wPXUasnGhg2CfefoRu2yhV4b/yznPlu6r1C4y6sGw2opl35avPUpoG+7iTyKHJE90QlO0ypy15Sp77o/Irlaj14ryDN5vS/ylW/vxJQJz5DcGyadxbdcFjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 7 Jun
 2023 21:02:16 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 21:02:16 +0000
Date:   Wed, 7 Jun 2023 14:02:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: duplicate patch in the pm tree
Message-ID: <6480f056d974_142af8294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607144120.01ce4655@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607144120.01ce4655@canb.auug.org.au>
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a47d90f-3d1a-4908-7b5a-08db679a793d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0trGUi9rZwwt5v0mOZSJNVBCdhg7UMm5dx3MbWzzQKasqKdl5Y1zbybVhWR6h0ndT8clEKXJS8On7A32CMK0Gcq1d5ZfYr36lWE41tjk5NWhrstzTeDUSxmhq2cZNy15AK3gJwTmzVBY4u3scd0Jo8T9e0ag+fVI5j+d39ooUD2VbG4bY3qEEBp2Hy0xXUUHNvjQXc6ATzvIscF2koE0tgInryauQP5vk0NhNat+Msvo1HjOHP911lWAD/cudWsNFi0WOA9dwjpEfp6U6ud763LCb27bcyKU5MFuYjAaeLOAuBC0o0PBq6v6CC83Ri2L042Yq+vfn22QwdMRVbUZISC9ZV/XRy+ybvTmJqFwE1K+bmeK2nVt+jTDOXSV7Xvp55ks2AwGKR6BslX5yH1TCFd70qyTmR/wHOogpzupRidjC96PUwWjtvqx8bMXUkjS66M4YL6naTa6W5ISxGF/oI+iCkuK0dirt3t3KusUeg4MgZDvfnDK1DxlB0FLrc1tc6OurID5eFgQlGh+3M2LmSQhCBmaFDrJ0hCAHqNcx5yKPzwh6YTSnsNA9G70D2K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(2906002)(4744005)(66946007)(66556008)(66476007)(478600001)(6512007)(8676002)(6486002)(6506007)(8936002)(54906003)(186003)(5660300002)(4326008)(316002)(41300700001)(9686003)(26005)(110136005)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wJalxBmQZ7Yy6f4W8pHfd4pTcCYBJbCZOd+4DN1qg/qi4sSUMChT0RZIL1WZ?=
 =?us-ascii?Q?z9yZ2xj+LNt3eUWvEfBpN1VQm6BtYN1Frwlfb4G/WdxpVvIBhYWLMReiVZdK?=
 =?us-ascii?Q?LVyaHCjgMRwVzvaZ9HQrdEFY6mM5t283HGIHSyq5e3CYrXE8DnSRG6nD2jwT?=
 =?us-ascii?Q?88WADg6qes7HzCCy0VS1hLQcbWSLgXWF5VhSd28s5lCV9lih3mK7dG9d+UQh?=
 =?us-ascii?Q?SIkIU1RkNCVdorrdlP95g2VJaX+GXksMN8o4MEA2FYMYZ+66CdA4NYNSqY7H?=
 =?us-ascii?Q?6MmeME613WeqzubZc0CuY7Fr9KGbADJtljXBoMQjyd48wAPy9Nhgc8vnXLth?=
 =?us-ascii?Q?WLCOykSQ0S9JsRplz9QLpkpUmVaAeRSfrGfA+rBmjyX263VoMNCwfKrJv3oE?=
 =?us-ascii?Q?1+YWkA2o9lLh09YipcTc1toJNFhgv7CxzsNn09Zc8jpi21fBE0o7/byPeMBD?=
 =?us-ascii?Q?DzBi+LgPcLh78jLrrZQhJegHKe+MHagFlXObpYaf1OTH/ExTkCyU0IveLa8n?=
 =?us-ascii?Q?gK6q0nDtROcKtja0K8SINR5C584wXlMk+bbjhYlXrUisxX0mByUROIndPJHk?=
 =?us-ascii?Q?4SQZ029d+b0xjIYVQIpbRlhMfE59z3hYqkzPC9FvXmucpSDdt3jDALns8MgB?=
 =?us-ascii?Q?rBdg+CTsKb+EmbRTYA1EA6EFaKBxDoFlFzjhDQrlcwSacNofRsfquyCKKN9b?=
 =?us-ascii?Q?DrZoqle+KFY393dQGgyPhZdFfP3xooqEf6eTYRnP2VCqa7j7TuhTn9EF1e5R?=
 =?us-ascii?Q?5ZaEKwEscOajdO1YTY+4F80zx4G1UM3LQPknK5oiyciJtf2lbuITslpy4O3H?=
 =?us-ascii?Q?3RgVw0SyNQuNM3OU5TFGlLmcwVX6LOYW77wNt0rWd6cIqt63E8mEoy5x79B+?=
 =?us-ascii?Q?NXQ6061lv5jKCTiJst8PgvfXoA5CnCq+rnVWwXch9xq+TNUtHe0TZyIfoTan?=
 =?us-ascii?Q?hzmM8mTpxs6enARRom80qFaz/mGTEVOdKVnh579HXUpVY39544JlpYcp8D22?=
 =?us-ascii?Q?LaXaRbXTiYxtmjECmsM2f5HAfhPccnDKiFPmp0HM3FUS7E6JuAjzf3vyS39R?=
 =?us-ascii?Q?0Sg4ZsS98E93pWP9jZ6mM9WySoLmIJVdHXxC2vJlSD31dXUjoBKb6l0v/hU6?=
 =?us-ascii?Q?G/oHqqFtSbDSJK535tHZlaWb/PgLlbpv02NwvahSIMsL5kdUaJVLgUvPm8zm?=
 =?us-ascii?Q?J0qn97XzT2K6aA9N6npLN4kTMm+GhB8L9v2tCUracPfnVr4RTKk9uUtZfvn+?=
 =?us-ascii?Q?YSDNjSe6B9gELi6V9gTqHVOTcCR8hdmbSbYdXdHZqtNy8Xwuxp17qAgadPJO?=
 =?us-ascii?Q?sdDegMyOlFRnfXY/Y81uuuo6D9GtZPexdePC63ubcEJEiPCD+w47vuzxZyEt?=
 =?us-ascii?Q?j6CS4aW6Cj3Jt758PImYMfnHmgZf0gM8DbO8bcLCHB17Rh9Lx3K4b++guyqy?=
 =?us-ascii?Q?tK7UIc3EjlXBbFPd6P6bcBqiE+gIfODwmK/dvz4QtyOonGYenZVztU3oZ4Lq?=
 =?us-ascii?Q?nCziT/reZ66PQKJ5ha1ldF6lj/uHNwcVUsBbnPcbMMy6ZojKJGgi/1nvfWJ3?=
 =?us-ascii?Q?4h7EwCu9XIbf8u9Q23U2/lHDMQ8KZ1U9L0/lD2Hae9RKRVJPj3rDpfIKejz+?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a47d90f-3d1a-4908-7b5a-08db679a793d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 21:02:16.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9ifH10Etv/EmunA5F1VCyDK8NTn1DxtLc0j6OyfBZ/9ipmMOhUGHpzATw+xyDvVx07/vPyet/gtPaL/FAOCp9veZ+igSDUaTpLz//eU9Lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in nvdimm-fixes tree as a different commit
> (but the same patch):
> 
>   8f0e8597a7fa ("ACPI: NFIT: Add declaration in a local header")
> 
> This is commit
> 
>   40d3f4a65a07 ("acpi: nfit: add declaration in a local header")
> 
> in the nvdimm-fixes tree.

I have now dropped this patch from nvdimm-fixes.
