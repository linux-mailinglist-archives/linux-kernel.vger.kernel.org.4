Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D70699FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBPWsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjBPWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:48:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6EA4BE8D;
        Thu, 16 Feb 2023 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676587698; x=1708123698;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yJkjrZJkP+GtqTdUUSO3rUvQtdqsTMPCVn+RsFMfAA4=;
  b=QJKLn78lVftj3znf7oHQqyjX3dsocnhDlEW4vbSipJF1VoQ+kZ8MPrJ9
   vZZuip2WhlTGCqIHVg8jquNdMvHM9BJbYTjJvxMYeX5WJX7XZ2lLQV0el
   haVby3NviJ6D6W+5gOv0Gfe9q9QMi6+4cfjGEuvCi88JhNNPsn4zc0M/K
   howAt2LsDCUz+VohFKXvu8k4/cLtwP3kTMpI0F5SJsCudMvcpe8Sqk5yM
   VwLy3FZMoYjNNEJc3XDXsiPrcKKbiLkv6W2L4kTcx6WdUsur3lpITgEbg
   /QlTQ+uWlJuuyC0hZTatw2AE+gkvaylAjLZ/pqgryxMSwLTqgO098Y5LO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="394331153"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="394331153"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 14:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="672375493"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="672375493"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 16 Feb 2023 14:48:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 14:48:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 14:48:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 14:48:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3arWOM4LW6AT4yX9S/oebF4xFEiLkQx7hgnKzwhEO9kRLxCfiC4EZ9RAo3VNNDdjI0eS8bLltbqIFLBgPUuK39y6yzPRdOrOJJNZGhgHps0cpssi6uYu3ftLkIcgetdTnebmNe0uAisjDeW5UyjLowmWIi0XrpMcaMnt98iWj7EK+/KutqF3P8ivv6KuEUk6fn7xP2aMnZxyRVYNkh/y43X6CnN7A/lZE+YAGBRh/AWyZAJU5v/VOEEg7AuinEWpuH7wqMfedapVT5g11PzMxaRth41qUr/9AQyFEQTrY937w8nfc44LmpCjtrBAOlR6Mom6UlCDjX1VJbUNi8kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5h8njOuVEX33+n+nMa3tMId2MOQUmlRFC5Ljr6CtUJQ=;
 b=bdb7Qx9ru+HQudy1dD+jduolLW8QYkOnPfxkwOHMo7akMehQhwOgeK8rFTLi+tWUN93LZ3j5LNaHtzJ2HSI/I61FgN5AxxV2rx7PBuNm/r8ROBW2qYrI3JLs02wdoqHvlEmfFLneEnGd9OgUiIzBrmr2nYtFG5OWAlWDVU0NG9GYoK7k8tIJkU0BxObRneygsYSt+JcjJmHxaLBsjVjfZ5kF/RRspA3ziICM0rA/d2/GZXlzTpewkSRel40lwZSf29kNyoKRzrUQZoHI40tN6Gmn7Rb6tmG1sBNvXkfGaNWh395YJpEr9jbjyxZZYgOdvruMsHve0msVlyjUiDVseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 16 Feb
 2023 22:48:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 22:48:11 +0000
Date:   Thu, 16 Feb 2023 14:48:08 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [PATCH v2 0/3] cxl: Enhance trace point information
Message-ID: <63eeb2a8c9e3f_32d612941f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230208-cxl-event-names-v2-0-fca130c2c68b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230208-cxl-event-names-v2-0-fca130c2c68b@intel.com>
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: f142142e-0241-452e-af25-08db106fe17e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ily/a1baCpvYRlVe8L+i+GprKIghtR8SfFplczeXq6peOUKcv3cWMA8JLagSu+xZlMBZKrxAI0mY4+AsD95VIOP5zLNjrlC/qRFkzvyrxnTGHW8Dgis/IJNXbZ0TsxBWNkgp7zem18eUF9meL42lCLlmg+9eb2Sw8K2wx0Ik0/JkIjvNBG/HzaimhFrcpwF+qozLmeYBXckIL45q2RlnxLHwwhhGGqmNnPQjKNldCYC7+q0Ox1lwdjhyTi89+Jzx/yDKT7MrFdj/AdPvF//yYjpudxB4AVlCiY68tuOf5SPCCxX1Pm+9TusiLdGUEA7NfNHaS63jVCe44toZNRo4SMaSTTfFaMQI6bMswD2OzegWl1bKSQsQr+Gjmr5zwG/ZkdXJ5+DmiG2S+HrGKEhkrYueDFZArdV8bl4JCxVesHrV7qBfSeov+fH6eTH3QvVUqtzrD6zjSO5g6RZm2guFz/akorfExJnOL7sELhq/9goaVP87hilDwsw8KMvPFDloXS2lizJdkhQDK7+F3V9BfKDgQWdo2+0z/CNUZ1e1uA62+65cqMIsdyZ2Krh3DwrvPVUn1tP6FLcoaDqxe6SAKWKnxxfb7Man4iHHfTPcjZvzMyqxmF+8HYgDYYYYZNgI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199018)(66946007)(107886003)(6666004)(41300700001)(66476007)(6506007)(66556008)(8676002)(966005)(4326008)(83380400001)(82960400001)(86362001)(38100700002)(8936002)(186003)(6512007)(110136005)(9686003)(54906003)(478600001)(26005)(316002)(5660300002)(6486002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmih5SeT39SVHP+cSAOlxApKtOdLqfPNWVRGOI52yWgsGxJLnIg10X2lFrCI?=
 =?us-ascii?Q?jeu67RgTGRwlwttT2P/IHpjdKdI16+rG1Z46gDpT3OGTN2sttM1uNgBUkoVK?=
 =?us-ascii?Q?WHu9COK6pxP80yP3iEyLrEInt5hBuJlyPUz4N2QD8I4yGYW5+is3PonpvIr+?=
 =?us-ascii?Q?3H7wOqSk+aKHRxGpdJ0U7enT2MeEXNI/E//DciXhbfPeJza0KkxYnj2ZfRvn?=
 =?us-ascii?Q?NH5M9ag6L0wzelTmWaolMxZnulsb9QaxPAynbWydK6eJJKBIBGtMhByo23hA?=
 =?us-ascii?Q?uSr0CI7BqIHLougSPjaeRV1y3gyB0zVhE5km1P1XuOkXmbXFosUG1FvfSnGG?=
 =?us-ascii?Q?ffxT7QOF0j329ps87MqcWwSiJutXeVA/dUvcsLuBqLI+2kEWzQPcTOodyxkc?=
 =?us-ascii?Q?QTUZ1ohmMBqfM134+fKw8bfV1AB7MSaqRyYUdjew+C6f0fdLUWQWb2CsUJwl?=
 =?us-ascii?Q?kH8vAZjkpYZJFPCqh2RETq25D37LllbCGsDFhx7ALUz9OKS/iIwzBg8nhxHy?=
 =?us-ascii?Q?MbQTNjxOLf9dxpJEndrLesIfBIdZaH9B5xXJANG/K/qCpen+UHCidK5yiP2a?=
 =?us-ascii?Q?PhrVfPTUSaEgH82C17k4OrTljAMxqDzssOtr3sDmpKnqBg1kHv+HtJt4gvgw?=
 =?us-ascii?Q?Dfxv+levQZ+8RzikaYxNuW6wCehBpVXyEG067TsFL2dP1AckLRWODPafXk6X?=
 =?us-ascii?Q?G++Xays0NTDaTs59NJ9SgKCmUAP383+QaHRNJncJJsZXdSFeeNdMpcJlphIf?=
 =?us-ascii?Q?8bVC5IcfdEqcJ9fgqx4133r0L2rDKkdrksCMCTHJW0PuvxSqv4hkIvLwHNlL?=
 =?us-ascii?Q?zaugyf/bBhHzPBnEanmXFxhSLKApQWka7Ni0vlJbQNZOlYNH8dzvSBgKtK99?=
 =?us-ascii?Q?u3ypRkhB9ZX7fZAZiILytGUVFpcKJTuQPpOienYVPtxyyOx0GHbQafaGtgpb?=
 =?us-ascii?Q?14sb3Jqf9arg7t3aHirWfrt/Vwg62z30dBSFqQP58POjpcH7tk53DRmr21jF?=
 =?us-ascii?Q?COIqJD/9ggIDWQs99uL5tzzpY7GJst/kalZL5i0cmoKRq3HX7wsScbOl/KO8?=
 =?us-ascii?Q?FreYCXICo/4z6KC3xKn9+M8JFMJ9pbGOnFczS/caLucs93Oo8gPP5JpNilwm?=
 =?us-ascii?Q?LsUkPCGZQJFa6TPBwrPrMPY9U2+jSlfTLLnBwWqndene5utxDg5nfB7WdeFu?=
 =?us-ascii?Q?EcDLzDf80ppj8XWnVRxR7PKDBz5QO/9Fy84A64o5TzRVUzE2/rQlKHZk6e74?=
 =?us-ascii?Q?VlmJIkZ58HBUYxzjX1qCxhZLLMH4v2FSlBrPFbRtQUvVy0S7Xwv4wox6sa5Z?=
 =?us-ascii?Q?kCe2V1BEJ/ccq2EpU7Yg8Al2mgUTKlKLUTZvW/ECUKCb1oGuCbgTxfP1THHf?=
 =?us-ascii?Q?utRbity+gnZqD8VA7M7cRSo/SdAvljO0Ti4cWiGjqE+HlalceXaPBwiptNnG?=
 =?us-ascii?Q?fuXcGouuO7iYbhMTUdGGy99dwvJgbn5H6EGY0WHrCXlt1XPcOLFw6ASTM7iz?=
 =?us-ascii?Q?1o/6PF/Js/nZG31Cl2SmhTcNRZvoViub4n/NoPmVqtLKNH2IIBEpFU4AUCli?=
 =?us-ascii?Q?1YkgwzIFTvbGc52srsUTbqY2+rElGNQ8Pcj6wKcLtNQNMfo3GmYVhQXFHgGa?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f142142e-0241-452e-af25-08db106fe17e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 22:48:11.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZbevozvMxYOGG716E4RDEQ0vAfQOEyP4CVkggBONw6+GYIf9bJ3dJERGli3yfN8xZZXLwCxI0i06kgx68GctJ2RiTWDEDrINis9u/zayO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> Trace point definitions are reporting different linux devices for the
> same CXL hardware device.  Clean this up.  Add additional parent device
> and serial number to all the trace points for easier user space
> identification.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes in v2:
> - Dan: Add patch for serial number
> - Fix macro parameter isolation
> - Minor formatting change
> - Link to v1: https://lore.kernel.org/r/20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com
> 
> ---
> Ira Weiny (3):
>       cxl/trace: Standardize device information output
>       cxl/trace: Add host output to trace points
>       cxl/trace: Add serial number to trace points
> 
>  drivers/cxl/core/mbox.c  | 14 +++----
>  drivers/cxl/core/pci.c   |  8 +---
>  drivers/cxl/core/trace.h | 95 +++++++++++++++++++++++++++++-------------------
>  3 files changed, 66 insertions(+), 51 deletions(-)
> ---
> base-commit: b8b9ffced017528bcdd262730ab10bc5084c3bb4
> change-id: 20230208-cxl-event-names-9372fb72a607
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 

Looks good, applied.
