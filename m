Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD763748F76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGEU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGEU6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:58:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0116A1700;
        Wed,  5 Jul 2023 13:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688590695; x=1720126695;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h13UduK0QciNfa4N2gQgmMbc5tQyJpS+Ln87cIaoGfE=;
  b=A+9wZFr9CG2nosnq2latI+DTBHJ7pqKsswGSpTO8jqoG4CmJBStVFpPy
   mEjClqk+n8fgPNS6xN4/ScS+kYFWLN5ZOAl/22BVI+87tA3dW2lpTzvX6
   FM8c0fYzsHRkKJhe8TSyTsFqjzDZUQYeiaGJl8AO7xmJTmb/uWbMwjFv3
   OjZ5kqJ0IHLEiXJIf9gcbgX/VL0ybxhHfqsp5REL5zPzCOe2GNUSr1srL
   aylRlnmf8MNP2bi6XShnYrOo2Vgf0QtbjxMUPibFFXW1KTaFxbIDfBQDO
   MBiE4LLbelGr3yfYYXW8JnBE2NNeW640EZebz3h5e+fjnZG/63EZWx0lI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="449803534"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="449803534"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="863858903"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="863858903"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2023 13:58:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 13:58:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 13:58:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 13:58:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWaqCs9bornnwXmHP1/qQpXTv5lBJgsDPrW/OSiZeCoUhYHtKXyuN8EcTDNSnTlv0D1tIWn4HBHs5qCRFfV8M2GmnEn/V05x1G1N7oXeVL5/swDumnpYnaTK1MU4XePWRFzqhG/0CztTzEEfGaouBcDeaDSB0iav1pNDBFKiOfNxkM13+ucNCrNPX2Ug/LaopgvjU7/n6q/fN2PVS5m/oIENdN5VqqENdKkQGkvwbPBGpOT3HMVcGjD2ioDA1pG0LzbXJamAEsNSvcDwvv/SyUlqxLGXC09stAVnUNQ3ZgrnorL2R44G/74L1Cfeql74+C5Ns3aSOlG7WbV6awRHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbkiIs40hzwA2alxVNWLStpy++nShk0FWrIqhljOLjA=;
 b=a1RZa6eYUF6B8eB1hbacmrsELHGdBXvS4z5gR1XcjJ6mPu5x3xoSbMwHxk4JYND95472pNSiZ6TaeaaBQ1keTufDqw3gBrkivd0aPJk9XS5eKHEh0iohifcgojnJE2D+58DGUsWMB5wQOAFt3b9cosjCBx13lrgOw1wiUdduAbooTqtynQiZu6aE0l3xx4igOUIj8jjN6KI4KfflpOJkrHJvLcjp4/m1veisCxHQLn9TOomAslnSuhh6huog+Sxg7YPYksp/gBz36r13b9sumg9zLlabR+S2LO+aIY8iqhmR8+m95faFwcC9L1eETWC7BZX7HRFBo/s3Xl6LBBBTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 5 Jul
 2023 20:58:08 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::955a:2397:1402:c329%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 20:58:07 +0000
Date:   Wed, 5 Jul 2023 21:57:54 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <herbert@gondor.apana.org.au>, <agk@redhat.com>,
        <snitzer@kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        <qat-linux@intel.com>, <heinzm@redhat.com>,
        <meenakshi.aggarwal@nxp.com>, <horia.geanta@nxp.com>,
        <V.Sethi@nxp.com>, <pankaj.gupta@nxp.com>, <gaurav.jain@nxp.com>,
        <davem@davemloft.net>, <iuliana.prodan@nxp.com>,
        Fiona Trahe <fiona.trahe@intel.com>
Subject: Re: [PATCH 1/3] dm integrity: do not filter algos with
 CRYPTO_ALG_ALLOCATES_MEMORY
Message-ID: <ZKXZUl4VgZkMbOL0@gcabiddu-mobl1.ger.corp.intel.com>
References: <20230705164009.58351-1-giovanni.cabiddu@intel.com>
 <20230705164009.58351-2-giovanni.cabiddu@intel.com>
 <20230705201205.GA866@sol.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705201205.GA866@sol.localdomain>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|PH8PR11MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: bb114ed9-2d60-43ae-6774-08db7d9a8886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUWAHsxFod8/xpeZyedvSNByoTB9/9wmlcvwstOwhk2f7s8Wlz9FMBwemM8jJ1hoKvxiIKTNslrjzp+b2M7dS6938v6Yqbtz622VqRBqDguAjnc5A81/wU4Ykg4klLaQ4CxMr17oHkykNfd8KPz7YuQXoWuitfzs99GYbXQeARlxdmV085jWelXmjHTAIe48iILXhZ2DmvXqm1keaY0UOOJGmvm+eGgmyTpGMMXiGXDHaZMy2XP6lSGq2kMUZyQr5uen2j7O7bqnGlbNBKITzzQV1y6CWAxzZQSNye3q8Tk2OUnJOhJElowzaXAPARNAFsv9DCLa2xUxKP4WPYNGhFIT81qrG48Sp/rSUKUgAbyTBaueIvejn0EmCCiSEMDZGLNKhQS+EMj1FmVT92GSyOD0BPcr9Y7DAyOF5SQgORfqcJIpib5M0yYwxulXNthVhwaNwbSnd4G2WVWoFcj7LftpMTg3ZB+MUC1CTCY8zAviow4vG2W9/91Lkh1+lESwUZRUNpupRbFJzDWkecnC+mJE2O3knGU/qNkZiX37X1/CGMstqyshKn3rUUGHKL9J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(5660300002)(8936002)(7416002)(66946007)(6916009)(66556008)(66476007)(4326008)(316002)(478600001)(44832011)(8676002)(2906002)(41300700001)(86362001)(36916002)(6486002)(6666004)(26005)(6512007)(6506007)(186003)(107886003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AF8O9itqQb2xGU42YPgWnOI8wPzMencjFUXFcTMe9ZeOGd4PE6UyYEKxZ5p3?=
 =?us-ascii?Q?iBgW6ftDrLzYNOlua7SnQlCeve5NtWhsvPd+QwZA5oGTzzCXu3VuTDADes2M?=
 =?us-ascii?Q?yTlUAhQSkpuKi5WdWwYzvstD00jujiO2urm/qFg+mwUSfBidR4fGY0/Om/4z?=
 =?us-ascii?Q?iCfsu6/CFvxsAqxKyyk03NjT+H8Vw0UzrozEq8/BXk7uX70+sihuOUvwsIaf?=
 =?us-ascii?Q?30Bms+eBwjnet9OaWwK/CbTFyHTNRqdUjIF+4QB0C7nATh9cEGP/zfFaVOpO?=
 =?us-ascii?Q?/L+a9LhbLg47gSUKAT867LLbkMn8CrIUN/zMDI8ero1Yb8UaeniBvfxdHpOE?=
 =?us-ascii?Q?rbM9drRLCuwoKnzi1PtCNhGyMeCm6YN24cjHrsLY3KNOl1aBrg/umByCZ2Dd?=
 =?us-ascii?Q?UMlewTj9ysw55duVegRlepH5wACFgvctdFxZP/7ccoSK6SPKEX4n9n2QD0k2?=
 =?us-ascii?Q?63bBgzWox01Ol7QYQStnU2KT+snYM79fRQoSyGBPazeg/jsp2c6C2qgtRhi0?=
 =?us-ascii?Q?k9TFJvEWKLoiO2bt8Wxx4SPep1ydfu7J/p0+Lb3TtRAqKyZuy+3wlWeMkPo0?=
 =?us-ascii?Q?Fi0VRPCUriWrifMXQKAj6dTNmCrsxFjULwFWKcAHee5Un4viWvflrUjeMwj2?=
 =?us-ascii?Q?1Y7a79JTG3sLRTiW23EJ9LGOedFG9JC4IUwlnbnWIDdisl4Is7n2QUvU3kzo?=
 =?us-ascii?Q?3GhmqQ0VIazp+pQ5UR3wzz2PUTOO5EyYPZuixpqZPop6swdnOamuPKWZsQls?=
 =?us-ascii?Q?A7FGuht9NHA404pB/qhUA6JYceyrNoaheIFnVIFb1lR9h/I3WOGroNxbwAbU?=
 =?us-ascii?Q?4JPXF23/SP3xt/S5kCSBbDT94rtP6tjOjUmgutFFlnXboRw4727AdEUbq1ir?=
 =?us-ascii?Q?TiblUU+zc8iU0cITCtbSG3iMlTWN7IS1k1sY8tNQz+lxxOfOcAXPG2bXHytk?=
 =?us-ascii?Q?ihRVcnEqa5nKalYtuVWkLp42lDuJD8L8+xKDlyTWAY7beWE1+kUJ+cYsatlh?=
 =?us-ascii?Q?IAJg/w0smKtF20ppMwtbNAtNIUFBl83Ja+Zdwf7wwnzhuOrmYPMcD1ZH3cAj?=
 =?us-ascii?Q?fBOabRmOkaNnkpmyMOcaEUiFMQvRHuEKOqtrjfzfqt5dQZaJqbbM+AVMRh+M?=
 =?us-ascii?Q?jPFqrcLtwcrpo0uBfxGWec8+vwRQ7PsEVY8psxhBS7i0iE/oDXZyhpmnRkm2?=
 =?us-ascii?Q?YD7gJ/aUcBbfqcp9TYFYTq1SC822y9ZWBNyX0g5BVDPm1pF9lYAjSTOyA7I0?=
 =?us-ascii?Q?y6e8kVA/FyuB6o2DeKBp7kHfk6Lm56w+cUctwdtPHidI04cC4kds+iMdBbWB?=
 =?us-ascii?Q?NsuQJtBhtgJ7jLtj9j4fJKWfY2GcO3HjwvolWOKkzihV4sbzjeBbXsAUowtL?=
 =?us-ascii?Q?QKcZYTbSOhfsEODSj6hVfPsmJMkpI0z/wYyHQS0p30TDgy+H4mMppMYpz/9k?=
 =?us-ascii?Q?crAaJjJLCWTacKjW7xceeNTJktWV7E9G69zvu3a5ZTeapVy5vliawRdm/IVL?=
 =?us-ascii?Q?GQW2n1qxYLBgkpiE2ry+Cze7lqaghECSgJ6BPPdva2Wxw3QtjhAuowF5TEBz?=
 =?us-ascii?Q?XeZeHvMsI8RdbFFO4pdUh96EPFtG8ot30+j5PTBGa5R2RMlL2RM1aNK9p9Nu?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb114ed9-2d60-43ae-6774-08db7d9a8886
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 20:58:07.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kXYxw9Rf8UyNh4GKLq3QRUEFAIZtegL+bMRiZERUsOHEg0Ht+SWJvyG+CXceTqZdSmPGEbbCzuUstDzUMZGAy6oNT0RS55acs+/grW/MdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
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

Thanks Eric.

On Wed, Jul 05, 2023 at 01:12:05PM -0700, Eric Biggers wrote:
> On Wed, Jul 05, 2023 at 05:40:07PM +0100, Giovanni Cabiddu wrote:
> > The flag CRYPTO_ALG_ALLOCATES_MEMORY indicates that an algorithm might
> > allocate memory in the datapath and therefore sleep.
> > Dm-integrity is filtering out implementations of skcipher algorithms
> > that have this flag set. However, in the same function it does
> > allocations with GFP_KERNEL.
> 
> Which function is the above referring to?  The actual encryption/decryption
> happens in crypt_journal(), and I don't see any memory allocations there.
You are right. I was referring to create_journal() which is allocating
memory right before calling do_crypt().
However, I didn't consider crypt_journal() which might not be allocating
memory before calling do_crypt().

Then we are then back to square one. We need to check how many entries
are present in the scatterlists encrypted by crypt_journal() before
adjusting the meaning of !CRYPTO_ALG_ALLOCATES_MEMORY.

Regards,

-- 
Giovanni
