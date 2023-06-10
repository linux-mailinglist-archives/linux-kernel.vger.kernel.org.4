Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01F272A873
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjFJC3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjFJC3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:29:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25088272A;
        Fri,  9 Jun 2023 19:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686364149; x=1717900149;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GbsZUpacphKkDIiC4ZC1ADmrYQReg8kA6+3BiK5kf20=;
  b=YwM7jUQtrdefoCNnOSZuU9s0EIYixrJ+5b8AZZaf40VSOQyXes6WJQsF
   A8xuakx9UYtknpVmv01MMK7DYZhwvKuEUR//stkHwbfk2345cNcYTFCle
   ua+cUoANNB+d46aNwjehKztzgNSTMsD0YMd6Bsk9NlWYC95WH4cqMApUh
   qJg1Ih7i0PdkcdspMUwqvKq6gIfaGqBiDze8JzyuNxLpAcRWbWooqcAub
   B5MpIUUhqzsS1YjHaNP+yUTIGg9eASVZxMLCxdFgVr+voFyUdFqAQXK8s
   6ezp0n5C2s9Zlnwcu8wN2R7Kjsc9gUVViSME6chfKMgHHfryuqzZhC8uq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337360627"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="337360627"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 19:29:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710550323"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="710550323"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2023 19:29:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 19:29:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 19:29:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 19:29:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkhEDlQYAHogEXpZCY1UyI/J7mOzTWYto24a7dycO7anb4dVsHbSv+Rfz8SwNV8L7NS0B2JV5r+Wgl/3MFvk3H+8yvEPT8aR+a6+1LuGx9LwYStXmWOlEkVM24eDWGzxRk3+f8QiXgOyxvjMEJV5sGdTuO81QM9lu03ZZlQGmNIrzuCFX0Oo7XAcnTK3NMqi3U4LX7B/TLYAO6JPOpX68i5uz9MvIZr5MiQRFSUKWNTbIlg6rCdRguanqKgtjnUdvqPJ0XNfLjMJt2nSPOjfU95zx9cKvAxbwOZIDhl6z8jPA1UNa6NrQCVeFQUXs47c0apIBfrNHnSN1SXZCZnG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX6+gSBcQw9uR30z1BmhXyU74+FMSw3rZBYLCiFP7TY=;
 b=GvnJNX/0O5adqbWWLiCi1i3yGEHMJR0kS/+Ch8+QqzBMln1iDydt3DTUsbPIi3bfgyOlTiX5PfEWYB7+i6FuJp8Cd6mxpw3DJ3FQ8Loqz4u/ySi4DW8Hvi9QMR7Gw/onrGMyblz4Y/LRFestCnQIBRPTnTutMp6XmM9gkItOsB0TimHp0FkPDXw7n8g4JH93VaFprMsOllOnIiLnauEuOxHSKf2P4h34qITEGDl6D1Y0Utgkuz12JWLWQtnjumykY9Pv3LaUhB81P0sMQRdw+/LtECtiP8IenQDDjQ5SjLj6S7u1/J10r7N0HqPdkzc1lQu1bT9w9atW7NkH211kTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sat, 10 Jun
 2023 02:29:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 02:29:08 +0000
Date:   Fri, 9 Jun 2023 19:29:04 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 14/26] cxl/pci: Store the endpoint's Component
 Register mappings in struct cxl_dev_state
Message-ID: <6483dff08a742_e067a2942b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-15-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-15-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:a03:338::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8462ea-b2b2-4a70-526f-08db695a780a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7vgng7saBay+J2B8UMcjj3Vh+vCTtGSUpZlF43NMbXE6UjqJ4DQJqDdlLEJr0VUxWAV/PoW6OTUKbUi9QJAC8QbBVhkDKjKbCaziOOOByXrRGY3ziu/dhwtkeSOwe+nV9c3WX7j1M4bzttC/qsouCbfjPrzC2XoHsi0dhll5f1tvles11GmlXpTisLPdVdBNf9FK5KJ7WVarl8RCwFTry+8xsrh8N+2nVO1/3VxEPu0cRu4kA71Fl1BubJbk7hQB7k9ANKOf0ssngvRpssWQUwC2S5OJTyQR/LeebYiHabogXsGnbzoXt9MxaDmCsqZb3AurWZyxJ/Mivd2SU0ZHNBGcIjZp3tC2Jiae2G2B5Bcf3YJrFRNnyxC61uFv58tReAIAiPG+0kE/ojexUb563YdMJJWz7oTHV3XXk+B9JxG0XtzNGqT8f0tSquibDKHBAyjlKkaTC+ZAExY4oGCaIb98U25CX27fVWZM/KBAPMGVirV29nf7P1I2/okPSOz6VxnRr/b69moCcfRvGmtauSwBhIP2iqy9WE39XUJiSl4xbNm/wd+KRBfQnfHznkX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(26005)(9686003)(6506007)(6512007)(4326008)(66946007)(66476007)(66556008)(6486002)(6666004)(186003)(316002)(478600001)(4744005)(2906002)(5660300002)(8676002)(8936002)(82960400001)(86362001)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mvn77XSvY/KL6lWMXCXIASObW+FWC8uvO3FUFerIaDQ8hGTHkmjfC9Hxx8K1?=
 =?us-ascii?Q?pArdd/aBScCiM5Thr/UkAM1PcRajaKurSlWiEsgy/M/XqXMUybiH6RLh3Juf?=
 =?us-ascii?Q?y5pgD6SpuikJMouTfuwxkA7qUqTQpgt+M3WEuWvVZQ0ObYueM8VGaXHJPiyk?=
 =?us-ascii?Q?uhS+gSNoYcb2VpDwlPY4UjrmL/nUzho6YZC9uARSwo1e2ptIcokb4hWIHbNP?=
 =?us-ascii?Q?DqcwQSn4sdpfJ+cfAa/B/3tEcJdFJJzCgmpjx7jEcTZ7svbS3u7aJ9v+wjpb?=
 =?us-ascii?Q?Za7j1knxGWUpAPb6Hbq0ftyxyjwa5LSlIc2VHOzlRdSqNJS04UYyF4aOPh4M?=
 =?us-ascii?Q?1Qg1XudHxlNSU9WDi95Pgum7b/WTcg9QTs/MS4iK0juZAD6p1VH6/BlZsExM?=
 =?us-ascii?Q?daZk7I+kD0feWLlRmS6OoEMhCCQdJUB4BacsYcOD5VQKdqolD+iq8isazzXk?=
 =?us-ascii?Q?JvKZ9Yz8m3w7hGdUgDolwU9C/Is+WT1UWuqcq8n0GtYBTttRqXHKKbItgixl?=
 =?us-ascii?Q?BVui3vEM3v5NeJQpw5dw070P3CbJxEBMn4U5rgE0dMqLcXMptqmNWKQrZjlI?=
 =?us-ascii?Q?9nYGRkOLuy/oIXJkloEHZ49DXG76piSWuJL+3DICU4s+LnGz48zMIEv7SA21?=
 =?us-ascii?Q?LkOiCpu3kcHZn2NUgDqx6VBc16m4PgtRQqIvJDtGX3NlIqb6wftNX+byIfO7?=
 =?us-ascii?Q?snplO6kR0ffg0t8s8O5UGbh7e37msj8NsAl2A99FiH1xOMPfdg3k+Au4pP9I?=
 =?us-ascii?Q?UJpt8kOL0QcvMzyEAYmOcdKT9zffSfEF26M7+tUrYlCKEYjcEzUG94xukg6G?=
 =?us-ascii?Q?XBNbsGius35j2zXUZHMSh8FlrH0IjTplaSnaTEyUzX+AoEYdZOu7SWsQD1Dj?=
 =?us-ascii?Q?kou9i8y6nZBvUV9yV6jCWmx0CKHnlq7pBYmC51W94c1pzbpB154eJX0EGezd?=
 =?us-ascii?Q?dgDYjJq6bUPeigRh9i6ZacEMGoHntuoyOHdHePbRJ00fA25x+5UPWdMzpOYM?=
 =?us-ascii?Q?vYQvszCm73BqtjxcCFYFYvUOeZYyxJTfPf+FoF/MMst6xJMZrGqrnKtC3ywc?=
 =?us-ascii?Q?l5ZbNSODg80MjF5VTsO/KA7Mjujq5/RedUZljlmR7w3HaHQij0/u3jWzNZVD?=
 =?us-ascii?Q?BK8LGmo096hXvhXtuLcKkSf6C4WGr7kwWSCdUBYAbYi3BCjJAfZZKm2ddl0C?=
 =?us-ascii?Q?T4m0veImSa0haiJRyJq2fvJWyLeXbEcQSI2gxoZ3TFqBbnFzp8C5j4L/oAfD?=
 =?us-ascii?Q?6ajItEOSgOfV5V2lboRaUOOYyeWlZTcVwuSx1Wf1rNKZLFmYegAbevGViuPc?=
 =?us-ascii?Q?7aiTaUHgHs8tciDgAUOiLGKj3f/r+LznR/rqN77/StPYeXzwzozw1pLCw9AZ?=
 =?us-ascii?Q?dGO6YhEX6T9v1jOD/O6+sjN3qubaRqcyRQwTI6ro5nqJwiFoLs1qq8AtEyt7?=
 =?us-ascii?Q?pWD5jeKqR7N/3KMA+3cugvZM+XAvLguQKQbLIXstiRsGhzSiiHK+vta/p9VT?=
 =?us-ascii?Q?rTBAO7dxvUbDwc5uh4cWBuXzM3sqIWhB5fmZeuBSAjNFz15SxkbmkdB5HUef?=
 =?us-ascii?Q?4Wqrez/YEYAS/qVH324WShgb/YTCP37cWKj6IGDlcltLEH6CE+O46gli3O3e?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8462ea-b2b2-4a70-526f-08db695a780a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 02:29:08.7528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2RdafP6NRiROSC3kT89arnaMqqgiV0ozMJeiOc+sG4Y0Gs7aiFbnXIHueGKuSSLFl5UKrPh56zmCOLk9S+ixgFeO8+k0R/BZF7xJKgzcYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Same as for ports and dports, also store the endpoint's Component
> Register mappings, use struct cxl_dev_state for that.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This really feels like it should fold in the removal of
cxlds->component_reg_phys in the same patch. I do not see any reason for
cxlds->component_reg_phys and cxlds->comp_map to coexist in the history.
