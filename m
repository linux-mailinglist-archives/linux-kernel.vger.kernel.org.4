Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7110F7498BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGFJwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjGFJwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:52:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3DD1727;
        Thu,  6 Jul 2023 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688637134; x=1720173134;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TuaL61Rr1LwOCbAzGctfz83bu/4r7AGdAJsgKbZbnn0=;
  b=gUvxqzVV6pu5MDlFiM3Ng34OfO4+Vg8OdAeSlLov2zwp69031R/b9eAY
   psDJ7Jxo0H9vpkzRd4k0A4NllS9RSlo9dOkxU8lWtbShXYJDkd3LqBS1s
   NehlIQZKcPiOygPDZGfZKJlR+njcwp2miWXyQll/BxBGIhV+607kfBj2g
   BluYqoCVWNWrlN/bFs2JLDZJmDba6OfuD3OiSX0LjwRJaE7YfVo8fFfTV
   5Q9DvtqQp31FHR37emC9dGKogvJmP2IQNsCYrneJU9IekEWhca9WFiwhc
   J6XoTp29vg+vCjilSO6v2JkB+Iw3jZIg6EZ+3/8t2Mg4zZ23MLOPlV/Da
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="429603151"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="429603151"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:52:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="754706560"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="754706560"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 06 Jul 2023 02:52:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 02:52:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 02:52:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 02:52:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpAluPL3eftgS1UzRVVz2IiNVoOQbDPDocbq7CuMumw3N1Kuc5QLq2gindr867YgzjK+kHtqjSSCzfZMdGyK3vyKxl6ohq/NC3SZ56jlgbukuT+aFxWWLyWW9FXaKycLauLEmKkL6fgigG5BqciRSQEGTeyi4E+cn4lcfLrX4qt1fdZ+QA3wkkIrGBOZHK7wNPGuQ5itgPWYlqprfALurTdh86ehKKWbjMfaCSHzZU4+bynKdurtE2cvVjBpv1uIZA0u2goqcSlbOy72ji3EGkATSsSSpmMFTEK8ACRuDDm5tyTIwR41CUN19zSJSn6Ls2KSgxRvITHPms0Tt4uTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx0XQyvVlzL3ri4wiesV59Cc5nx/34Ccv/mCDej+CRU=;
 b=KmRNhVsUv5ZbKCaxvUSEF9I1Dw/ssA9J0z8z40Z0sxkBj3Jp/LmCWtQmEpiW/88wHcfeFbEZ+ngqFGQ/9C0ryxLKDaF1XDZUyhdETStH4czCxYaXSTh/+TPLqwM49a0EAUzHvOoeakozCQgPxKtdhR+vUBk4/rwkDlPWm4u2R3zZhcM89VbN+TR21oCUSLIf0vd/QPICTWgNknmu96ZKwF3eHlI2Dp0lThNfGjNl/UaLTbWl9F/Gvy9+g3bvvpE597Mycuy8bP2z/nqMeuwx0BCGFQO5+bBM4CmCGPcdb5EfbApK6U2c7BwjHQgaEDFhyEWEVw6YSvZcr3MZMl7Z1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 09:52:06 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 09:52:05 +0000
Date:   Thu, 6 Jul 2023 11:51:59 +0200
From:   Michal Kubiak <michal.kubiak@intel.com>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sbhatta@marvell.com>, <gakula@marvell.com>, <schalla@marvell.com>,
        <hkelam@marvell.com>
Subject: Re: [PATCH net v1] octeontx2-af: Promisc enable/disable through mbox
Message-ID: <ZKaOv6t8+9epGWra@localhost.localdomain>
References: <20230706042705.3235990-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230706042705.3235990-1-rkannoth@marvell.com>
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|BN9PR11MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 61770922-9df7-485d-2bf6-08db7e06a7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BelN5h5LgyTfspdnaZbuzztNV1EY+tCgTGMsCmceptNF9qud51Hxc36omtNjB6S4YWLKL9xKwmOTAhstJH9gaoSABAmtll9O6krrr5GxWhs3j/0OmVjw8O8duKvt13EeH4PRUut+b5gmWH3elc+dFygh4dyEE9vhfjh2c00vLvIhSNoPZElHkiM+rZ7GpiYWUe0vEa3MuSQWKaFIVDrZdL3AcLqb0Nnmo1s3jJrJt+VoNZWsPnXdD36hBpQRt904nNCfkAhrvQ05MquBgMCfaNDg7hUMN7j5C20/XthA5TOy/mBSMo1geZuaYmSLV74S3NqWAMwhfU8zeZFc9pP8B0WNTYLTv60+mq3mI7mf/qPZDmN7AZiNL12jyzPbC2xp3P1ro+QYhDivff9+On+YbgyLDgP4zoSHkNyi6eHjn76UR0oRhum9HuZhJ1+3BxOC/dv0cZ8yjMNlCVjd3tUHgkWVVbxAhR+KQtN2s/sB/eHFwJ3S7I1B2PRDpI5dYQGgWceL9x4eKVTTzoS9QfNqT6Bt8T/Fh8MCyQbkmxMKxgib68s7qNNoINZmK1I8R4mf2xDSQEf8QVzS3DOTG8JgAFFj4oz8kVjbxJ10h641zaM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(44832011)(4744005)(5660300002)(8676002)(8936002)(316002)(2906002)(83380400001)(7416002)(41300700001)(82960400001)(66556008)(4326008)(66476007)(66946007)(9686003)(6916009)(38100700002)(86362001)(186003)(6666004)(26005)(6506007)(478600001)(6512007)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/rq+7CZ3rNEIlotBboiX5edg01g3BnpafyMHUywwUhueZmt5pWwrTLFTP5MB?=
 =?us-ascii?Q?lR7KCDryS2a+34rDGYGOHvbaCvKn+ZvGNR2mFNqcSDNmo0x9PFzl/PSf3JKb?=
 =?us-ascii?Q?cFC9Xp2lFK0jBIBhUe5XufZxFr/ATKpzAhPAUqVK/LCNKoeDiTrqdKuu+Tm1?=
 =?us-ascii?Q?OK/D/pev0y140MDrjBcHufd2fWGo4UwiKgXjfvVBOJFQxR+dxshSY8SW8T33?=
 =?us-ascii?Q?wEfjhB9a/CpEDhZwK86gFh/csICe69TIJ0O0vuXJwmGNViAdZyXOy9Ko+W0a?=
 =?us-ascii?Q?cPjmkzBf9Rdztmh9zn35baKnR+aPMeUBI81AfEniqENksLtMdzCgFMlVew4D?=
 =?us-ascii?Q?FRBiewW0Yhyh8bM4EPecYHjfdTUdhcbhiBpqW1KeyKjJxPGIx4rT/GxZJmlx?=
 =?us-ascii?Q?5YxCDk+jq6ipEoIWXqRbxeaHCcrlto65KFlc9wBsDidBHbFxYoC5xTh8fou1?=
 =?us-ascii?Q?Wv2G8e4KTuNAljqHYdLdTu1fOjcj02duQhLdKzT6PqoJnfbqPC3iERY2Ljij?=
 =?us-ascii?Q?PESv2WXZHsgnwPyIfrERuS6uU2Nmx+3mPbTMvbZToJ399Hrdd1ZQ1lmCnh16?=
 =?us-ascii?Q?WEo1vrMaPtMuH6JewlLawURPewiNn4WgOZs6rS4tw6DA4rjQFfMFjgrsK+Z5?=
 =?us-ascii?Q?qVpvjI0pMT2iSQziAOnLMsz8KJq4CyRqSI3/Hq0QZL+yZFuNKwy9LCpxkSq1?=
 =?us-ascii?Q?jhv73oHVMxXw07/YITJqKOXXLOSnQhtG5BRD5qRtpYOINY8Ex8o3qAreIzuU?=
 =?us-ascii?Q?Gi44MO+fbfKj3oIaQclY9KMZ8DIgrTKDDWQ/ZLVg7+xUAkk66yuIRyeQCkA+?=
 =?us-ascii?Q?uGKDrsoDdt6cCZF+0tCkHyjbNfkPZvD+ftZeL98SvGMc4ZhblggIta0+PIFl?=
 =?us-ascii?Q?FaaqnQAia1tbJTGaEP+5+2CWfm1qajGV4YKmcrejt5fglnPgEWr9JF53EdxO?=
 =?us-ascii?Q?mKrTQ4dQLw/CHqEbP1puMxLvb/2alEKU+AyEpybOI5qNRrpxrvgnBz+wXfrN?=
 =?us-ascii?Q?i1xIYGMPHO/OM/BoWWSnJnDPKeUNAfUnSmw+UKYez6VAxKEdWNVfLxVlcG2d?=
 =?us-ascii?Q?dP4KuTOvTzMjXNqSEnygVETmSFA6jgcFIU1gWWyG+Fg2ASNONziz9Tq22kW9?=
 =?us-ascii?Q?LLF0OL8aCZWPTT1eobZQ4CjCGClR018t5t8XOpPhTFOD6PrT2wVScPJ3bS/A?=
 =?us-ascii?Q?M7sLbpkhOHsvTjxFcJbs/RqBdtfwnUBOHv/6qnL6LpkMyJAQCkDUD6DJsZE7?=
 =?us-ascii?Q?bBWv2m/vYmkGvL4hEYJzFqkSE1/cWz6Lr/ApxB7oEuUU3GZ0Tr0r6KT3XJZ0?=
 =?us-ascii?Q?a/BStkelDcdQZUuGmXX7jZz2Y61Q/ozIAdSNPOZrtMOAQjTuQqTxIOy40UbA?=
 =?us-ascii?Q?n8Rv41bYofS/DwL2dRVZuYDPIST3iJ/0281k8hoHBo9SjXyn9iSStqt/bweu?=
 =?us-ascii?Q?yP+oJftc13EavOpMPwrIp5cvYlYVRmYrBTc2ksvcQ1C/KYw4EyKZdviGbb6T?=
 =?us-ascii?Q?+jrNpa8I+gf5ok2Wy7tvrV8GDzLmbxaQTT7qYy4AZs7cjEAF7Tgl8u36Yez4?=
 =?us-ascii?Q?i71qoev0g2xeSlaOtCYxhCrFvED9uzlMYIu0tRGK8/buTb/4RLnJGMsgR0W5?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61770922-9df7-485d-2bf6-08db7e06a7ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:52:05.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhKpgOIwUrvWw+m2ZJzWRwbj+qgTu1jy3rKA+lXs9V0xS7zBatxTSSqdIIIS+y4QQpttZcZoox51cBgWgyv99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 09:57:05AM +0530, Ratheesh Kannoth wrote:
> In legacy silicon, promiscuous mode is only modified
> through CGX mbox messages. In CN10KB silicon, it is modified
> from CGX mbox and NIX. This breaks legacy application
> behaviour. Fix this by removing call from NIX.
> 
> Fixes: d6c9784baf59 ("octeontx2-af: Invoke exact match functions if supported")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> ChangeLog
> 
> v0 -> v1: Fix 80 lines checkpatch warnings

Thanks for fixing this!

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
