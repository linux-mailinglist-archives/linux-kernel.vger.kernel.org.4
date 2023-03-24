Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340DC6C8829
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjCXWLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjCXWLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:11:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D9125AE;
        Fri, 24 Mar 2023 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679695857; x=1711231857;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=5RrxLTTjMon1jC1so4TQ+usCeafUHYmIyut5H1BgXhw=;
  b=eGgMNQT2X2UhLkZbOBH/xaTnl7e2eTYnV2bhoO5hsG4GzmuQwuNETKja
   1J6JGm9R22z1lcf+d4tmv6lPf2oXsVPS5RTzp8p8qJtDIcOxADEigYGHN
   AzmDxQOyyYcPTfGFJI82yI/rwihOY0HF25PtPDt3URC9+Amq/7Qgn2BKM
   OCMEPIw2DUB9VyWEVl284SjxjaglszNFlWhx2UQbPxhyVolFVNc9Ov0TB
   N8cj9jrVK12a4SvXBP8Ewf29AXGBeqpw/fFhF8lz3jnmskLsmb41orW87
   cZmGMD2Zfq6BzIkU2qSQJZ7rq0Gij74D2WNajvcK8nR1O50VU8Y1KukDf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="338617581"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="338617581"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="747314528"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="747314528"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 24 Mar 2023 15:10:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 15:10:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 15:10:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 15:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADayHUtKTyupvHfnPoFsf1P5JdYu84aKSIVWdHAZJkNCBRuqxlynSlzYwmBTKmPwvdu/Dx0EYGat2HFP+9vCsGoLGvGH222IaBACpn/9puYSxQ+B/KSuKWgGObdaPK0lQpx1OJzoW4WG/8PXHqBK1rxbI8bn+dyBOlIdhc95VJQ7eTGm3VdjzLTaxIIppBzo4K11b6P4DJTxZuE8I6c63dABwPkEtIxr8F3kPPKkUV8P5Rrp+5MV6KizOsoCmEle0NaqjBPoFAYA2MdCsU7IP2V9Fx2B1CF95BTOx5qYupqRdnYKsDW0z3xnd1bCRLpMemJ+jR9GCYwQgP8Q4x3+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlaKj5WFdGZ2Xq4JNKKdxuHgQmLyVaVrPrJ8O1me+HY=;
 b=XGDQGVL+go0qJ0aeYM//Kv/AeQ+ahmZyRAdT6ZhH0IpIxhei9+/TflMHOWQSSXAm1oPCYN3QjJbsZ3E4x6mDPW0YhbCYJ3J8BJuI8DU3Wykhwums1dWEg6WL8Zdwbd5uUk7Ec6bNHkWKZc2Lz6ykSOu+uyozZ+L9TSNkvpiKlTfGVRVQyCnbphztcyQ/639ewY+zUvrZptECwFp1xok9HPSOdwilLf1QWND3CX/ku8yirLdT/JElXwznZBG6kmiaiew4qTeS4gXEddYYXAeHBIs/D7ErSACPPrMWF88wzoEMYZjUY3GNzd7gyFRlNl3WUBOEZLnkoMZXzSKqEPDR7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6363.namprd11.prod.outlook.com (2603:10b6:208:3b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 22:10:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 22:10:52 +0000
Date:   Fri, 24 Mar 2023 15:10:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <ac100@lists.launchpad.net>, <linux-tegra@vger.kernel.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <outreachy@lists.linux.dev>
Subject: Re: [PATCH v4] Staging: nvec: Remove macro definition to_nvec_led
Message-ID: <641e1fe98339a_325e1f2941d@iweiny-mobl.notmuch>
References: <20230322054051.GA150453@sumitra.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230322054051.GA150453@sumitra.com>
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f77040-3280-4295-1e00-08db2cb4a1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEam2JazXElM8AmLKAre0oKErwYrwIqzIE6/o0ayKM8JLUCbmDZB6p9EhMYgR6B0vqvRH3/GOGnpI9+kQNcvQaRMGpES8ZjdhfnO8QYhV9slX10sscrtcnfsulq2y8uwhGOUyHjI9NcawCH7Ps9t2fZMeTyEnuu0kQcHV++VAJ9cA4s1yrtsN6xjrhCzNB0FpQrTvQa27ILY8V3bcaCACSceLwkpj7wNyUtRjBSkV3DgtA3b/w23hWkxjxmrSRZPffaj21cMYyqZ6LxO85oflN4qQXu/u/xSkgDCUagqwXGQoUoY4gmQhS9l3TgkwjDUNNyL+FzTnzZeq1tpHCvrFrJ9taLqbqc9t9aWfHi8UQ9wZt1Fh06Mnm8st0NUX/3bQeAje27SkwatmFHp6u+j/XHJR9SSoxl2S4E39xVRQTyQO378ofy2TSXVohPvLuDG8N8TejnKjLJl9nIX8H0zGsvb0M+aQMKCnAFt2fTOeJDnhNCJrlNaxYHORPlvIU3decxfMMPxXpB+PGhwKlAVkfWZUGIxd9jlwRnQx35pMEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(44832011)(110136005)(8936002)(478600001)(6666004)(186003)(5660300002)(82960400001)(2906002)(316002)(6486002)(38100700002)(26005)(6506007)(66946007)(41300700001)(66556008)(558084003)(6512007)(66476007)(9686003)(86362001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M7DyJ9Lfd9EpJxuClDAPtvXiM/wx56C8jKx5Tn9exB26M9NMedLKCyYHtI8p?=
 =?us-ascii?Q?70gVEHjhWuppf6KG9LjYcu0yMGHquMIDeYtMfqT93NB16mmfZuRGKBfucqoG?=
 =?us-ascii?Q?D2TpRt/PG7oY5KXD0NSOBk5whv5DBlhNEgDakrMTnWUc/bNj8qcZ3P/HnKBR?=
 =?us-ascii?Q?BlHOX62u/Kg3ko5HLyZl2uUjjIZMr3+QqVOHpDnmaD2KnW6BDCbA3Ama9CX0?=
 =?us-ascii?Q?FXcNlZbMZ/TpmZnm+dK3jmsNin4BwwszlwEzxS1qzUwOc07YAXEnakNNue0+?=
 =?us-ascii?Q?P8UGsqcVAixlTvlEz6p+KulmyM+cK8SJwiDejIGEWnRwpCqNR6FCIFX1uNA7?=
 =?us-ascii?Q?PL4kCP3rltAoeOAXNYWA00jPoQW7hJrhVXbjep6mVv6JRrSzfqpWTgpfPNfR?=
 =?us-ascii?Q?2XKyPv3VUlnLN+V0XDif0FffZyFmO4H7gnYfwoU0HJ8Yv3Ur8aKEoAkV85Ip?=
 =?us-ascii?Q?t5pLqanuuZZL138+6GipD3CR55u4vWJYYVzyGH4A1bW7qQwS5eGEndtb6T4I?=
 =?us-ascii?Q?0YzZ+nl9og3etylYosFBHDicK7c3nkmCQrNKLNzIHgrZn4LPAjrxiaeJTV1k?=
 =?us-ascii?Q?8zFs6XbwdJoy2MdZP9zSvJhrfeClFp5pUuzaIq3RoLyCCoSP9MI+UzAXPmOD?=
 =?us-ascii?Q?0++eoioNv9ICbKoz60egkYU+ZQAVxRXevqmY4R/wX77cdMJsRh+o6ohsVeK6?=
 =?us-ascii?Q?F+Ox3wjFSlwKKuJtBIEnDLYo1ZcmWGj02w3hsIhIHbLce9rwycBiFFBDRfOa?=
 =?us-ascii?Q?SMZ6dWcGoYbYEulTU675Ol7lI+PPK0FQs5tQd/1Q6eeH7aBC/2umS/V41hKC?=
 =?us-ascii?Q?On/CUGXCNkZYXoaRYfpah2mTOZrEwQtzoncMZ3Mh9PCllXaFDYvrI87MbBik?=
 =?us-ascii?Q?zAov6dGgxp9xYoJQrfs3fysNa3FfTRpRU4juS5yMNTKSOqw8cbfm7vHZIQNJ?=
 =?us-ascii?Q?anvyMlIdFBYoV0mAvAgbbVXs5cq3tC7JXp0Kxl9pJlrxTiae08leiDsXGFui?=
 =?us-ascii?Q?q+aqwA2ycm6ROrfWnSfu0SviYKFwyH/0EfLDfhU0ak/jtiVpZRzWCOkEfbhB?=
 =?us-ascii?Q?4whYl6y3rj8ij0F7QIsS20W+fzw0OP+vuTHCV/yp6yJ9XfhdXrO6c+eiXAPu?=
 =?us-ascii?Q?K2cLpGuI8tgasg0qGcNbonuma8pDNxLDNfjODfiy5Lludz8cFpqBfJDl/JaZ?=
 =?us-ascii?Q?vWvqQ4HlpfKw3yjdarjfmb6EDP9ILeMDdQg2jij/riwIHgwW69iWAzjOqbC+?=
 =?us-ascii?Q?S2xaLaSAPbKHEYtiOE95yDsAem3mhZtWa2PriReAGojsLR2oeCTXAwYIB4BD?=
 =?us-ascii?Q?OiABIghm39LSV2VqrAQvLu+0tTmC4oP3HkkehQn9TL3aYqwfu7Q2BtHsQMJ2?=
 =?us-ascii?Q?AsEyYd9+LJET6f/3wPsNr8SyTq8IIhVSzkl4XICS3J2dTgUvW3UlLegtMG10?=
 =?us-ascii?Q?67Nw/KEcTIeWh8PfnUd2Xg27xXc4669omnSfGhgmf1NDD/+6BhTTOpxcuRB5?=
 =?us-ascii?Q?GAofDfwphaj3knVBem+zJEXpj5zE2MHYsw/LrHcvgu6BnVRMDf3BVRpT2XQf?=
 =?us-ascii?Q?x2JxB8zCXp/bFuzKZ5tmL0dx9QkWLvAH8BS06Gwn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f77040-3280-4295-1e00-08db2cb4a1df
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:10:52.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZVHlcHfQ5P3pK/aSw4PeJ29PDNYQxouLT+oxaiFEbrVuqos6SQHk+zYTv2B+jdaBUVNCR1ybte6NTD08D1Wzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sumitra Sharma wrote:
> Remove definition 'to_nvec_led' because it is only used once.
> Rewrite the code directly in the calling function
> 'nvec_led_brightness_set'.
> 
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
