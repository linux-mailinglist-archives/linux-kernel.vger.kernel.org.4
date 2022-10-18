Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E756031D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJRRzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJRRzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:55:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1516D12AB7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666115704; x=1697651704;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9W18EzNa+BmdqF1wycmOkiPEjIACp1zp17T9nq6O8/o=;
  b=NrdhAmWWZpPwhSe97nPgXQ6/YU9BFcrHWUt6vG6C6I7+SxQfY2kQfcxm
   bVvnRLjsieebU4FPjl47kHPHFajaE0qwEE4i+ZEvWKq1CJgq814mq6uf4
   NNUuMXE89FyNH9e2smXxpNkVwslSYs9OeKQo9RHhQYwl1qN8hWba/fROt
   knZsejHhxnssTOdwysdfPqW+OehRqag4fIHtmsw9Ge3Y1Pi/FQRF6G+Qr
   2xY03ceNLWE5chW9zzTOtzeCVPmqLCUNBDKzZKgdsPPqGjv2WQw45p53g
   AhPKmXQj4mmG57K9THJblJtqwGQ8wwZqy4ypKhTFemwKLx6Q6mRgzWudh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307847055"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307847055"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 10:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="754162816"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="754162816"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 18 Oct 2022 10:55:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 10:55:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 10:55:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 10:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw0GvZwIlST+tGfkmlaGQ5dU+y5JeeyQrTfkJjd4uJelz97W4ToMNqfzZr39KexzQ813a7XGcWdoRRXz94/BtS10wF8j+H7+0hkykfgEmWWttmSjihKdcdWG+fjCJoHKFCh6W5rMIf7DoGFQjl1DO/ivYLGuG+8rEtKZ7YkKR8r2gF2LzRW9fNEhz12bW/zE/HLdkVG7Ut/Q23Lk5tYuUlS4Bvj0CCRt6wX3gtJ8bVPSsIR7R8ef+iSdmdT53OGPUYtpgO/dn30hMPuM+KX0OV4/cHb9vRve3kNHI48io5Pz6R1QvI6rmchvdvUKZC2TWvjwjMjbJ0V625uS2Kzu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKK3yFuNDRg4Wuau5/2XAGKkbYQcOcXFAHidPpHr22I=;
 b=foBiDP0qnEOUUNWWJL66F2+y8yGqTApOjEVlNM/b7H5qDCH9FbTSQMn7sqtiOsZO+K+ctHiu/PzIRDe98fktsaTlxspMJ2S1OD9TKUJQIFJBs9VPpUKHdnHzjXunRU0qEnfIOZRj5TJBwpEorN1g2KHjPIc4YP3//8UqjfMM7KUklWzY2Aw6pBhc949MLS8fyeGGZurpngXF0OUrQ8//N7HQA7YZRpJPEiVnjIKM33Id7Bw/7SCOzLnypMUyW2CuwMdbzjdV2Hon56NnnHy4EPU3nGiCnun3TneliUusKjxjZdnIWx4r26jPY01FO5AKt4oCJouof7x3m7kTG4A/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB6695.namprd11.prod.outlook.com
 (2603:10b6:a03:44e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 17:55:01 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 17:55:01 +0000
Date:   Tue, 18 Oct 2022 10:54:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <patches@lists.linux.dev>, Nathan Chancellor <nathan@kernel.org>
Subject: RE: [PATCH] mm/memremap: Mark folio_span_valid() as __maybe_unused
Message-ID: <634ee87229a37_6be129430@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018152645.3195108-1-nathan@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018152645.3195108-1-nathan@kernel.org>
X-ClientProxiedBy: BYAPR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::24) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e795933-45e7-446c-98df-08dab131e0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPjHpQ0REII8jLtuvXjA0RHxD/aCvJSu7X6VTnMmZ4yznFQQ81OFmshxZNo8yW5eYzYMRa9OueKSJI1k1FLsdJ9W+8vbyqSreCv5FL6KURT15nP0wnZgsdHOXYaJMUWoY7yPpzeTsNNVoR+TBmMl1JppL3WpcJIvSvymx7tpUzUCPH59OaA1L9IUiUNkDlwNEPN41FZOUxARfKxDHexulplb0ywpop3+5Kcb1xRZg2QtmRhbMilPISi6sZwM5oT86YtOq9QllXQc5NBs5eIlju4FeQTMXFp209frzozv0Bx4undgePkcgD3dQLE+Ix0760YvbpiGm58jCOjYn9Sv81B+iJ8BpJjE01lrZExEh/Rpx/QP3kZD9UjqJyZjfq94Sh+5dlMalxjNp/1kaopq2S9HHy2qE++QU7SJNrL8t5QWzzX4mD1gOVc5UGMjWsA2JHLzTtg1DsRU+//7ubQe1iG4qkFKg9MQdEdc6MRLyaDkqf02TWmaDgDsAmX9Z6czJCAbc0VRsbsJTztZNEVhacoyc89G4sFdx9KBblDIIv/DwcuZ3BVUiHyHj6RJjunZ5W9JBV/m9nrlYkWbbFuAEAci3K5g+HQ6ITMFj//bHGVimvjC8XKiuAReHD1nkydWFaofTI3LO/zfboB9LYbkMu7/mWlUJlgzq9pdkbUkc1okILXAQxhSdmNlo/QERb7/+4w+iVJKasE12PkXwQjifXDoy8FXnBI7b/oF+RuAI/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(82960400001)(86362001)(38100700002)(83380400001)(6666004)(66946007)(66476007)(316002)(110136005)(54906003)(8676002)(5660300002)(966005)(6486002)(2906002)(186003)(8936002)(66556008)(4326008)(9686003)(6506007)(478600001)(6512007)(41300700001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0JuR4NIrlJCuPLWHJmcM7y/NogaFBL1A+IFPnk0kBxFQFlYZYYOh3fwrFZdA?=
 =?us-ascii?Q?Y4a42tKkpfrFo0bC/iE8PT8ocpggIQEk/3rS4Zh1NAVIDMvdxpl6UTMDuNkV?=
 =?us-ascii?Q?hc/ViSQwulzwJCLxKtHRflkEWus7mnQlUeZS5PjDcFI3Rjfw3+MavUSPv/Z/?=
 =?us-ascii?Q?bXUCcDRHMbw5FRlknLiWHw7e3Zxv22fHweQsl/KdiPNsxmQrOKEPSUz6tCar?=
 =?us-ascii?Q?x+rGSWrovebqDzvU3Mos+Wh/25XJx1M86VlkwbFt11CuWzEi2hG53CZ+hUZ4?=
 =?us-ascii?Q?NigCPHx1+G5O6wE5t1u6a/doW1V6nNNEo1azjGj9lx7C92qlLKbTqQB+koSg?=
 =?us-ascii?Q?8g9RmpKOEQNJYpe348p/jVn71OrOvOu8ZpPpuV6DzCtpjtOAKJdjDZyb5NVu?=
 =?us-ascii?Q?gM8T8r402TVjDClIKvamdimPAw4zs0TFgrWcpfvRlcObamCrP1JwtmzJhGBv?=
 =?us-ascii?Q?05KgdkKjgjk0gZ8lxuR3a7+pywSocRD/eXzbHtOrqablrhDG8jslpm6YKGir?=
 =?us-ascii?Q?8/PWPLt61epsiLkRmxbUmoN+ZHdsWpv1TkACcFoSg97ICz1PyUT1+VhWg6vk?=
 =?us-ascii?Q?MHmHNs9c2MocAohLNf5lk0tldJWBxYMiWmZjgjy+xnx4cee6DC+Ki1cnqAAX?=
 =?us-ascii?Q?H0fDhSwIngYpCdsMG9jA90HFMbnrhdcc4hqurMnPNoz/q+EYvA92O6YMYaZ4?=
 =?us-ascii?Q?LY1iE/TDrhFF49RZ1sD9VMR7j0EpGyRxGYMvuutsx+nhasgmSdwMYKEn8oS/?=
 =?us-ascii?Q?xENw01Itky8tOuCz4x4XiNWq6zE7mUxMJVNr9FRR3w0G+w2jI9fmUqyPndH7?=
 =?us-ascii?Q?Gr6jK3oGaFuDmc8EATnxK/agU1624tX6vBQIOjQ4D5FGzHDZN58nBvQe2ua+?=
 =?us-ascii?Q?Pm+OB7EezkoNEJu4+2ypsEzJIFJI6M2i2zeSjaLN+1BmXTR5aE3ZxtwpqcE8?=
 =?us-ascii?Q?8Ga9zfchTWrxXYPFwiDgwXyK6cg3RfOOU/dTJ3N3VLuYO+UB5qs484ciQj/v?=
 =?us-ascii?Q?vVjybWJzL+tRI86lRYW/XdxuLwQd2abPLnZ+yVZlpUNy65GLjTXQHVq9+Ig/?=
 =?us-ascii?Q?oT6mPGNxmbqbKrYTcM5+7E3cmbtRPWgFunmItGgAA1Ihp6Yqz2/xlL14OYZx?=
 =?us-ascii?Q?k8lHvtKXrBVcEuL0d26OBR3sOjqtjMSYBfoNHvYrCbK/s3C8ffkdbmxuGNhA?=
 =?us-ascii?Q?BykmZwtVgHaB8WJdpD9C8X5quNcjN7XyrN558kgXrbTYAEKuS8sXUjBy8+XU?=
 =?us-ascii?Q?8wDKUPmMs9jP1mXjPgnhIasEbUqXoUTRsvnnf+OxOWL7CaR4EdVfLR4apgny?=
 =?us-ascii?Q?28lTBUjbkxS3lOlB2rS04tv3KGxPW/7CELtWIY6LSvwMzl51gugEWmm/4kTW?=
 =?us-ascii?Q?WwqJQXs3/WwIpj6pFKI0htM1lX7EaTrAWkx0Ai5frxpy9QpDjrXx+zYFyLta?=
 =?us-ascii?Q?2wVvycUBuNqtxn0AbcO8UOfMWg8OXDIBr6K9MUYhO0qYe6KmDkEKRDZxO1xo?=
 =?us-ascii?Q?7KF77StTo+rjGcKPSqqmgyAaIpgjEQYOWveMwEKBvaUGfnAm2nEGSdaBOFMW?=
 =?us-ascii?Q?3mZeiESif2QFG5zLtOTUXFzCz8BeMmhp1qKTy15aodMqQJz4+RrwwoGHOxXx?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e795933-45e7-446c-98df-08dab131e0ba
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 17:55:00.9591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN+jTToiz2MNEG7WZwPvLMkxjd1/WVbHPX1XHOk/3WhgVLLrMqtz6hSVUzMWNKKZvrP3tnlQKZgxcAoq8pZu/GurYb6osyZ33BUxyorsSd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor wrote:
> When building without CONFIG_DEBUG_VM, clang warns:
> 
>   mm/memremap.c:495:13: error: function 'folio_span_valid' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>   static bool folio_span_valid(struct dev_pagemap *pgmap, struct folio *folio,
>               ^
>   1 error generated.
> 
> folio_span_valid() is only used within a instance of VM_WARN_ON_ONCE(),
> which evaluates to BUILD_BUG_ON_INVALID() with CONFIG_DEBUG_VM=n, which
> ultimately resolves to sizeof(), which is fully resolved at compile
> time. Basically, the warning is flagging that folio_span_valid() is
> only used in a compile time context and will not be called at run time.
> 
> Since this is expected given the configuration, mark folio_span_valid()
> as __maybe_unused so that there is no warning.
> 
> Fixes: 07108d5bfeeb ("fsdax: introduce pgmap_request_folios()")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1739
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> I am aware the Fixes SHA is probably not stable but I figured I would
> include it anyways.

This fix looks good to me, but I assume commit-ids are not stable until
the patch moves from mm-unstable to mm-stable. Andrew, do I have that
right?
