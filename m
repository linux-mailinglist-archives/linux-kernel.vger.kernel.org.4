Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73883733812
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbjFPSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFPSZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:25:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DB9CD;
        Fri, 16 Jun 2023 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686939932; x=1718475932;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LfTw4OvM7zZWM4WKpAmUQW9DT3w1xVsc4LNSacDB/J0=;
  b=AFTZ9u8xz9W0QXuMmRJiwgAVlIhYMxyBCgFgS688s7ruqzJetFV2432P
   fD+G+qaeRm3i6oFh6MfsNpf7AGBm0uRM6yhBKi0VzBTZB0IJrfU0VYN7Y
   FS0gNUbXuxstymgWOD3F014mBIfSwpQHp85cBZ33xjqFxEI6UdZVZMreC
   57CIaueAykOT89MC11OkHA7LEPKZ7TW2GKqPnEVAkuOm6H0Fz62fC0+df
   p5x8WlFqZAmuFrJencBPlbC44NAr/tPOkPXS/okqKS+m2Z8rXlONSXFli
   yPzyv53aU+v59cVOyV/243CpJbJEkEZLlmg0yKy7x7cW2odCrLHQVO8eU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="359291689"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="359291689"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="663278305"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="663278305"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2023 11:25:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 11:25:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 11:25:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 11:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M06txCwYnnkxoy2AdjsAsLo5B42LeVpuEj3jJ2PrpBylPyXrwSlHckTkvQiy1HSBZtot74UHUkNacMHaXPHeInS5arNzfd1UGtzIxqPjR4IT7JyP4Rtqgeovou3nhCz0byh6D9gof95fLqH39/3gV231XO3/zBTpziiX9sPXdL/31KPgUw/lZ+DMDQqbOrmJa7Zg3s+uWnDoNL5/3IkZMopodfJuTnzggVegyuzSjR5Eb4OY2dq04Efs1YgtKPNWu5XHadTj298qpUTwU0UVHSZer+m0O2CfD4iFG3ItWtmCaBVc5GFTbamU1ckkv6EkhNipoL0ek+Idwkm1h9gOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfeVb7trzSaaTbEogoof7cXt9bYoA923heFwcWBTtas=;
 b=Qgz2a1lCXb4h1Hc9D2G1ANhDfBF37mANH4XvpfoPIFDgZLNxoh8OWHA2tv9kZf9h2Q6eqER5OuvHwcSSU77PPixU1iJJrXVQsc4weLQen/jB6J4ePv0nGg95EwJl8Mdbd6oXf+mP07GDuJVGIElacrW03IiGqITZ9beN1VUoWiXryxKEaqRJI1qPDA9/S9nUyukobL2UW69v4U/W0eltqS0043MF+7k+/Gccz92s1jul6TZH08+DSlncBEKh6HEfG3bZC59kdoD2BNpDiR+RKMEbOC9MmPYnoT+JaIt4mh96UcU2lSqpkCucTqXCRfPwvfhG9qEBy0DVrT9uzE3yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB6719.namprd11.prod.outlook.com (2603:10b6:a03:478::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 18:25:26 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 18:25:26 +0000
Date:   Fri, 16 Jun 2023 11:25:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, <nvdimm@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] dax: include bus.h for definition of run_dax()
Message-ID: <648ca9102ec9a_1da39e294d@iweiny-mobl.notmuch>
References: <20230616161309.22387-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230616161309.22387-1-ben.dooks@codethink.co.uk>
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB6719:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b33137-0569-42dc-b423-08db6e970e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqCRi7aA47odfYWcW4LvljrW+b1Eln4VdAKBFUDpYlEtGWXwmvURn2B9qkgKfoQ4Iwx2cRCmo/uESMq89PBHSSDzUm2aCHSeNKq3jc01mFc8M1pU3WlRBMkfZmg9a0Nk+Hg6eZGxKrW8NJrzRkZIaTM1njB8fTBDU3R6V3pdxQGEkYrOsV98qiWhtRZ9EOWWfeSASZBcrNT4CgJOhwPRI3QZpmj6SEWP7u69DTKhTaGmZrHYE2Ng4Z43BBVwGke3uXRklXQxDVttXvSbF105yJ4LuZVeomcatHYk7Z7TPKkhhYXtOSpAQFACxaupMX6hB4bJTMHm6rDREroheyrxvYQvfnqlhvKXNY5W7DLwHPPmS6xQc+iPfEjCXGyRXpEDhuQDDJvu1CDnsPLdMuVb4bHAq7ixkvI0eU5EIzAb84wkZ+7vMRiBhYGxed2diY+SIZy23Hevv+ea7eNkRXIACjDbO11mBKJBcKwspTjfUZFikKZcDWt/d8MJNBRM3JUcnj6ewx7V7iGaaiGBJvIp1nbVjNYcTbyxDmfhc5sW1fNfBlMi+m1CdSfxtlPpLGcfpvB7ToQ+8LG7GTe45CVc4Nr+IkM1JvLTw2YF6X8InQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(8936002)(9686003)(6486002)(8676002)(6512007)(41300700001)(82960400001)(478600001)(4326008)(66946007)(38100700002)(66556008)(86362001)(66476007)(316002)(6666004)(83380400001)(44832011)(5660300002)(186003)(966005)(4744005)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWifi2Bc6ZwUJSOlljaPgj6ZkSdpxa8LSkNNqJWFbGGVuKWOrp55LTXOPbM/?=
 =?us-ascii?Q?XRDD+8cpRRzs0JejzcT6mOBgq55kEThFcp/GsjidP/8ntyWC6CNDKhce7SGw?=
 =?us-ascii?Q?qllpfcdjyY+AvQLDNhW7gkepBO7PW9oSNyjK6sOZNARK8EVYjJWZjpCIJgTw?=
 =?us-ascii?Q?Xe5wWBMAnPXqCwgShP5Hs/ipulzuyi8qd4Jk9Ue1mE0VjL2xBkulBn3Bznr0?=
 =?us-ascii?Q?B3VyyMl0Am9Vs/QZSoMD3umw/EwYSAj5GYvL2Pvxyoto8bm0dnCkDyKmJF3r?=
 =?us-ascii?Q?qQ2tfng9L44zVtnAYriBjrwwutxclI8Z6zw5XtSuSPP9q+YHd7YB3pInVMzZ?=
 =?us-ascii?Q?QysvihHFC5T0ucXCNMP4WkNujabL1aSQBUuk+LPaDM35Vf8ZTMN37l4tcosy?=
 =?us-ascii?Q?HhsxiYU7A8kiTxX7AUrcsC5qvZQ4JJmxgeHRum2XFvkToug+k9Zc+3HxGEEt?=
 =?us-ascii?Q?zobGXUrjgcXyj+YgggrBfH0CdEIpaE35Mc3OSY7O6BD+STYfjSFl8Y96TgDZ?=
 =?us-ascii?Q?jK4g6uuS6U0hrmpBF8RqniMCEqHtl9lQ/ErYY4I1uPVhU8T7wU4X3LjZdkby?=
 =?us-ascii?Q?0TJ1gGF0xhAOKydBaxb1iqWUy1uExbMmD01CO0ZnBacLpsMz6R3IEz6JYHQM?=
 =?us-ascii?Q?rQHKf1+HMADc6Y/6mk78r2DucxSS3k73FoFakWKP/SBOyoovwGWbEuLhBUFP?=
 =?us-ascii?Q?dKTFYt/KNLXypcX/kFZy2p4pTwnfw1ifxWo4oUY4PCM2CIMVJrOlIck7Y94F?=
 =?us-ascii?Q?zVbUZGAKw2KjKvwxwUMRWhV0aFFho8/mT+fPYxfG198QPqa7+LfeAiyryg34?=
 =?us-ascii?Q?BfZjBba/RhdXfCce3uMy+NpmXRdsxhXV73R4BmNbzFNpCt2yfvol5uFQcawY?=
 =?us-ascii?Q?lXgwyTyfmyX0KhP43rdlH7kWZFAdL4xI/ZK1bxX1WK5XZOEP0V8s2SE2e9po?=
 =?us-ascii?Q?R2ykwsx6qnDjSbVyumy59dfKVkAygGoW8WafrRAx4sMwGJK1MPAIz5PY9hO9?=
 =?us-ascii?Q?hB+m7EGfqzUVoTDtY6k3skSg1gI0SceDoeANu9kIz7ssGREXamBliJxMN4iF?=
 =?us-ascii?Q?85sQo0WzE9Ut7XdymB1RN/5fsgrIzavuVFqxvd7yFLiWMpA0UXWZMCwl1K/7?=
 =?us-ascii?Q?DuRLK512a5u2XjV1QnMgWPxo33VTKnnpSH8XrJrcpIFk7ZyJxyXR6UKHDa+j?=
 =?us-ascii?Q?nF/JeujObRl36P4vbQsUlQEoU+jBtbVZH+h7/doK6YVQxRW9G7wkJh7jfUtp?=
 =?us-ascii?Q?nqs9fsATmJ83Ba3Yv0dfxCLGBYk0CM3JO6WZ3hJwIcLwdvf7kjSI+ee79MOI?=
 =?us-ascii?Q?qMnJTsE+RWRX1R34lzQB0fHuvGI5x3wQ34l1e6cVWZQIjo1gNLTDHYmG4YM/?=
 =?us-ascii?Q?lEumejqb+4Rx6vKaQWCnqTUopl8h8PnuedEnlQCZq0FJtyqk+6klHwL5oMjh?=
 =?us-ascii?Q?jAtMfMrFJWIiO+khPncbS4SMXixt8c0gGbdhfXdQZNbb6pvzQDePvdsQpCtu?=
 =?us-ascii?Q?zTdf/U++Mqs49IDiZN29+EIZY9csPC3MBilkSxzmO9pj+VwfBQ8BNFt5NO4B?=
 =?us-ascii?Q?rLi8Q3KCubCONWgm+xk+bX4AxoYwPl3ZhIPzF2AjFdd0u1NmyQvGiH1TvG4H?=
 =?us-ascii?Q?KzE0iw7LMgzjQt+Z30ZQXqRZ9OIe5P4utl5XBaDkmJzn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b33137-0569-42dc-b423-08db6e970e15
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:25:26.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3y6oPAe+qWoaG/9g9RKLf0KQLFCUXmW+Y7jknprynI2SrzcjQwYDaeO0Ay9E0E7EI+O7KwUNSR5YFpzVWmLRPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6719
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

Ben Dooks wrote:
> The run_dax() prototype is defined in "bus.h" but drivers/dax/super.c
> does not include this. Include bus.h to silece the following sparse
> warning:
> 
> drivers/dax/super.c:337:6: warning: symbol 'run_dax' was not declared. Should it be static?

A different version of this fix has already been queued up.

https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/commit/?h=libnvdimm-fixes&id=2d5153526f929838b0912ded26862840f72745f4

Thank you anyway,
Ira
