Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B27711171
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbjEYQzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbjEYQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:54:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00DF194;
        Thu, 25 May 2023 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685033686; x=1716569686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dMjcxi5MqGvW2P64zIOPx/bQQgz++jfLnRDugO1/Bag=;
  b=YO5yBN/szn/c2SHAjpGYBSLHYv2uOg1eJztNh6Qezq6beJaD5NbWMlUz
   QmpMlVUR4EAj0Mfk5sg+OP6l2S4WBYfpxa4mInB8pp4dO4tfzX9dnMkSN
   hLyIdAGySLLGC68VoRiH0Y+D1UuPwakb0sCZ2nbMaKRlMiBOPn6G5j1CR
   WbcdlgKUkEleG1UbRVW+PGnRXKVipf73QlntVBJ1/LKAmzE5JzUVwG4nC
   U5uhp5xwsm6/InuNNoz3yJNoyZzFw4TYEhFy6afW+wnOdiDGbI4/re9cg
   FTIuo3TkuQ/Slr1664lRY4xaTZ6dPUY4uUKVpuMFEFnJX3/gh2tLMSc+a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="357197667"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="357197667"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 09:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="735604693"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="735604693"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 25 May 2023 09:54:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 09:54:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 09:54:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 09:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvpHEvp8legVk9KazTdI0TK1rNAWcn9wOM7ZWx4piBnRlFeh4zVOPlCFuZdVouYzcFgzpW222L3Nx9+PRNPn1RodKjIEchuFjfwlF9rbSJ/oviRwvPgZQC99qvXc3euFbt6fAZUKVh0f7XsOMZWRsdqka6073H2y7yiu2UrUU7kI+R6yKMjM33+ZgtKYkimx2tcNxlOODCmhiuhWdINBFdswir9UCpga9krSx+ryelIdrX/34ZASiXlA+XUCFtdyOcqGnpk5x77uvt2V4k+3H5ef2GgEtc0M7sKIr294Z6MeaGsGQDPXgJF/rSE4pMvHzU3y4Ok9+HBTlyk1ygKlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJDPKpPIr+irEZEFOEmIYkFNbkewQC5drSF1P9Nq4Gc=;
 b=OE3pSvp2/YYEpvTRaBAt1oXjLTBBXxNo36TgRwVL0yYMnn/scBHil8JZ+yRf8m2dFk3VAcBtVj0uxOaghOSeNXlwEyr/nlKbEtStBe7jio09UIr9BGFkDVHKcW1d1ri6uUV6mHLk8G79T8vyiVjE+JUMtr5PteqBi2AEimEIbYsbcDZl2KGvKyz+o/xoRx4Wp8PizRKCvn5rT3AVFZaLPJyJTAXK0HCo672SH18ZYfMlGw/sxmJQkESFkl0xaRNfUzBKaUu00F5i5Txg74KLntARAOfEkWPepE3QgqXKIjzBFOquBiiLQQiBHGxhNrVCMN+J6rMpR8s+xfYs2GzlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH0PR11MB5627.namprd11.prod.outlook.com (2603:10b6:510:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 16:54:38 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%3]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 16:54:37 +0000
Date:   Thu, 25 May 2023 09:54:33 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <song@kernel.org>,
        <lucas.de.marchi@gmail.com>, <christophe.leroy@csgroup.eu>,
        <peterz@infradead.org>, <rppt@kernel.org>, <dave@stgolabs.net>,
        <willy@infradead.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <dave.hansen@linux.intel.com>, <colin.i.king@gmail.com>,
        <jim.cromie@gmail.com>, <catalin.marinas@arm.com>,
        <jbaron@akamai.com>, <rick.p.edgecombe@intel.com>,
        <yujie.liu@intel.com>, <david@redhat.com>, <tglx@linutronix.de>,
        <hch@lst.de>, <patches@lists.linux.dev>,
        <linux-modules@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <prarit@redhat.com>, <torvalds@linux-foundation.org>,
        <lennart@poettering.net>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <fd2jkkgi5j2wakpaip3jbmj2b66s2euv2wwosade5h73nqi77r@4t4pdpyeemwv>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH0PR11MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 574af3bf-0145-4609-90c1-08db5d40b93b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWWsoE+UD7BzC7cMA2dsDGiy/15gMM5GptpXPWXItIT018eP0QaMtJE0CORx6WF4aA7STymYuU6lShOmDp2OcB1FKMRqp+xmGE/nMamheIQLpSRRNltvbcgfBE10c8BFrf5Bvd8PdosvUNBvet1RMz6T7kYWwGePBKWj4aAjw/aa3maTcB/B8S0Mk6/HXtWJ2ScvjlXIi7nYjhpN6ILhIsTrI3G2n79Ia8FX604jI7NpyRinEI4opW+o9uujnJA3cS0XTtRTEsi91P943z7W6B/I7ZwqC6jVs9v91XU3cRi2vn8g58IG10Ur9x6xOmoDrqc45uO//pyjKpuiVdJQts0yKb2vIDvCbx6Ab16IHWeJUCSKRpHkUFWGcGn9urCrWKqPwtlc98EZ4OILt3uJF5dmzJw6vG06CqNGkHS0Lc0LyXZl2loRxFAwibPDy0719dEZedlhYgRCjBhN2jA8jL4npbH/DtWqdE8FQ+YHeJ5ImSFwNsOO+KUTiYCu1BtbF0Gp1tWlXnp3S6E4Q7JQdHKKws2xFcUPsEDpClwG6ZaFFtCl6ACxFWzXvC0md04t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199021)(316002)(33716001)(478600001)(66556008)(66476007)(66946007)(6916009)(4326008)(6666004)(82960400001)(38100700002)(6486002)(41300700001)(8676002)(86362001)(5660300002)(8936002)(7416002)(186003)(6512007)(9686003)(6506007)(26005)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QgjI4l7dOQ+ZMeaodi966RX0xH+dV7H9t1Ph8EMi2C3gNE1SRqlINx17Epxh?=
 =?us-ascii?Q?RTpn8Gf0sr7RZi429eCqGuaxsIFWIwdQx8CZcdXmReponnHjnaRAnsrbYNPH?=
 =?us-ascii?Q?vKs3k5aJjGeH5g3AZYGfdEFeFIK1un1wUuG9EMcXs7OV761r07xUnxnV3uAz?=
 =?us-ascii?Q?7h4A5qV/2pAXTZ2df+Qitoe3HL99HrAkpLMbW7AWV2D5JJWJDUq2pWpBPA3t?=
 =?us-ascii?Q?AFlR9vLZgUWmj3KARD0wx0TEgpNJub61NNhGNNEgAe/YUGOsT7Vynz3eEXOo?=
 =?us-ascii?Q?+BErCI8xomT78FnFaPe5GrAJCta2MVBALvZwl6wOBjwp+gGfwgLMjDuxMKb/?=
 =?us-ascii?Q?aWckSgObcBc82kkf/UiDdIw8UCorG55wcYaa2nM1pPQPMjNZgJOnKC8kGR0D?=
 =?us-ascii?Q?/kMFUGtN2NQF7HsIf3xGTGepYkpFTiTSRdFXFODXzNm1gMI+hvpnawpquwb+?=
 =?us-ascii?Q?8dsZe+OLf5NueAhYXcDgnVqnLLfbNX92GDPm9uihm3302XQGfjnmWnn1WySK?=
 =?us-ascii?Q?0XVPzSJlFxEeQETxdUb/7JSgVjN6nK7xVSDsjsxoV6qKW+XcjbfwAKdayvgU?=
 =?us-ascii?Q?JFuTlGLxYN1BHkO1MOIGWlvzPVMe7MTBkGRMyEINexXjvRb+1SItmCGeRXxV?=
 =?us-ascii?Q?1Jqs+6QhN6anFJ3+huQ7Z+9l438omMWkXZOYr0QlF3LpH4kv555kyrcMGVqf?=
 =?us-ascii?Q?bA5CFl6WCqp4xazEh1AmHN17LGK4G/ia9/SQVmAcO6p2neu1IT6WYHwH4tvY?=
 =?us-ascii?Q?sAt+Y2snFi0bLM1yH+8w8XQPz/wS1Fc9Ipf/3ODWGEW9QqVerS6YsW0J3oAJ?=
 =?us-ascii?Q?IfvyTXVo435iDBH8Uo1DbQfgt/FS2d1GILDLyptY82Fs+81foCIbMdjd6p9A?=
 =?us-ascii?Q?zNXzrq3tQvbDgfkZkaBUVZTUgYrAQLHDEUs8gNrs3lfq2uW/I1t1+Ih+2cda?=
 =?us-ascii?Q?dFkx+xgiScveSoLfhX8WEDSkw35YqLxoDl5CkiCqN1ZqmLcG0iTKzEZwFYCt?=
 =?us-ascii?Q?fWSU57FPizjoVLfttv2RJP0f/0jrL0XhIbx/HANpfQG0S0Z2w0LvOfr1CVER?=
 =?us-ascii?Q?81bXhqzoJgF1UfU6FAGtrpkWAiBF9CyBdeVhnRdzsYzmqz9LLecyKRC58qgA?=
 =?us-ascii?Q?CI6tGuqy7CiuXRFbrXS/DCgOeotsfj3K7CUJAgtTau6fi/O5grp8ED+r4pxn?=
 =?us-ascii?Q?TvOtqPBNL68kYSmdQalEzxqXCnqgkVy+ZCNQvWlvdiE/x23FIJ1rZtBOVXZR?=
 =?us-ascii?Q?/pSXCMYiZXTZt/qHWXcJ5YMXD+CxFsxIV6C6HJTWeDFVdVMEOkkM7je7Uml1?=
 =?us-ascii?Q?BQWNwGuZqDiIim4bbEH6sVauFeevNtMK57Q1HmlbxgIqSq9H3MsP/cOESK9X?=
 =?us-ascii?Q?Vzd8NUgtL0m9rFFff6Eyao2pr+pejTC4H4KUAWY2oVEnoT94bVIVbO3a0xfA?=
 =?us-ascii?Q?Xh5fRG47yqKVuUbb51w1sKfzsOXJpTFdKX3cosxz1aCk4s9zGmA1ycMe3mZc?=
 =?us-ascii?Q?15fGdKqPzuvCG6B4WoqZPkefO+KKnJD1zyA/2JLkIEooSITZnp4my3ydYyDr?=
 =?us-ascii?Q?P2hyBmU11lDLfb+Xq4SysEp/9kPGIhPnD+HwJ4p6F6eKkKNNdBjxAlJUUl9p?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 574af3bf-0145-4609-90c1-08db5d40b93b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:54:37.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KabrB1jtHIoArAUJPNO+bwn+9ZSssbfjaa9IvfgDXjjbey9ioHBJEqeias57qWSscS5+rQx8yIjusE9wC8iiI2ksLWHOKsgEl7NQjqPX5A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5627
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

On Thu, May 25, 2023 at 01:40:32PM +0200, Petr Pavlu wrote:
>On 5/24/23 23:36, Luis Chamberlain wrote:
>> Add support to use the new kread_uniq_fd() to avoid duplicate kernel
>> reads on modules. At the cost of about ~945 bytes to your kernel size,
>> enabling this on a 255 CPU x86_64 qemu guest this saves about ~1.8 GiB
>> of memory during boot which would otherwise be free'd, and reduces boot
>> time by about ~11 seconds.
>>
>> Userspace loads modules through finit_module(), this in turn will
>> use vmalloc space up to 3 times:
>>
>>   a) The kernel_read_file() call
>>   b) Optional module decompression
>>   c) Our final copy of the module
>>
>> Commit 064f4536d139 ("module: avoid allocation if module is already
>> present and ready") shows a graph of the amount of vmalloc space
>> observed allocated but freed for duplicate module request which end
>> up in the trash bin. Since there is a linear relationship with the
>> number of CPUs eventually this will bite us and you end up not being
>> able to boot. That commit put a stop gap for c) but to avoid the
>> vmalloc() space wasted on a) and b) we need to detect duplicates
>> earlier.
>>
>> We could just have userspace fix this, but as reviewed at LSFMM 2023
>> this year in Vancouver, fixing this in userspace can be complex and we
>> also can't know when userpace is fixed. Fixing this in kernel turned
>> out to be easy with the inode and with a simple kconfig option we can
>> let users / distros decide if this full stop gap is worthy to enable.
>
>kmod normally uses finit_module() only if a module is not compressed,
>otherwise it decompresses it first and then invokes init_module().

that is for historical reasons, because the kernel didn't support to
uncompress the module by itself.

>
>Looking at Fedora and openSUSE Tumbleweed, they compress kernel modules
>with xz and zstd, respectively. They also have their kernels built
>without any CONFIG_MODULE_COMPRESS_{GZIP,XZ,ZSTD} options.
>
>It means that these and similarly organized distributions end up using
>init_module(), and adding complexity to optimize finit_module() wouldn't
>actually help in their case.

true, but the change in kmod should be trivial now that the kernel has
the proper support in place and the algorithms support match the ones
kmod has.  I will take a look at switching the logic around to just pass
the fd to the kernel so it can also deduplicate the requests.

thanks for the reminder,

Lucas De Marchi

>
>-- Petr
