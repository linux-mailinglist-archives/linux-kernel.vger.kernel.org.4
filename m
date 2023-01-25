Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FFB67B9FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjAYS5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjAYS5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:57:04 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D30E9EFA;
        Wed, 25 Jan 2023 10:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674673021; x=1706209021;
  h=date:from:to:cc:message-id:references:in-reply-to:
   mime-version;
  bh=UN+7o7SXvBbY1kRJwp01/OEaLpmxaxXreQwPjyn74dg=;
  b=CYmx5WKo1j2advWsWfjdOZ7JVara4AERRAbDcMbhiKkzHIgFPFMoyPLv
   nlWQklP2A9V460GJygemokQCH7CBPShgrzDsl+nTJU4uN/5PsYyIYIpGp
   pP9TvOTWdY2KA8pa03E0tik48XG5oqgT63ed0weevG6+QxQoU6orJW9uI
   3QN2pGI7gO1xhywoDSOecKpJ/d0AbHulqfErZvZKJnkW9u615OF8bkuxL
   aWzJ97s/XsrzWHveIox57pfDl8bhjD3ro1IsDkwp1JBF8fxbQT69UfVaY
   VAKIjyocbsVk2iVNNQ3mfad/NRFvwNvhrAWdlmZ8ILpLWibTOftAB2tfN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306305935"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="306305935"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:57:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="731155536"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="731155536"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2023 10:57:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 10:57:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 10:57:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 10:56:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SewQbU3p3gOvlWJhHpH1BobT7/4GqqmVYm0pDALnh41ZdZUfLwvgtWGHY2GGeqnXzgi12Xtr7KuFzt+JEEu7//PT4AkpvwQdgwO4EMN3Fni/4PcIbmlN5odB/k0fH41ebDk30cvLHAAgLsKY2gh3elaRpbW6HWCXLbWXV3556NkcFv8fKnm3rTYAlSonLIEgaoLCHONoKGBrbAixsjtjwbcnuLXc62eKaMzUpqWHg7KXrcW8PE7SjIgoh/SsBIMN4lLmmb5ctRoNoLLP9/usViofeCoxPCvkmULCRf+HeCMBgpx1MoxcEjlqJEEnyYYf8ephz8MEBO7clxFWhkh/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cafSioaVDCcn0eyLWxlM9v4V1gN/E7zBHCckIKmaoec=;
 b=IGbXgx7eOTGJyljM4izt2pi3QbE+Ro8yib+xntJQq8P8yb5v+N4J5r/S6NPEDl2bA1zrzFtZweH/afK8kfXfITAG59q1EUKkKbKL8rDu7eHQ85BNG16MuHX8ofwY0/zp9IQPRIQ/fgBPHmeJJz0++PAgdrGKfMSkoVTE3jzkA0WzsmkKiKga4aOEd5s10KocxGFUpgz89N0qQEeBF01JSU8sajlNSdgqw33mIs9UJ0pwbesqMmp5xo1f50eCls+gI4hje/5L9SYlolIyPVWvo/2CPC0PhZYLQd58IUA+H3alzpMrgQBsv9O06q5SDpmVnw02IxUIHeDNv8kZjoW6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB6421.namprd11.prod.outlook.com (2603:10b6:8:c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 18:56:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Wed, 25 Jan 2023
 18:56:56 +0000
Date:   Wed, 25 Jan 2023 10:56:51 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <63d17b737f165_3930c294cc@iweiny-mobl.notmuch>
References: <cover.1674070170.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1674070170.git.alison.schofield@intel.com>
X-ClientProxiedBy: CY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:930:10::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbf9907-892b-485e-4ead-08daff05ee50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRk6bXQJIfppxyRYKwM3ESQ69Y8UPqcw+UvHiH4ho+I/z74ZPBQ4sAJYYMuwnkaFLr5Cht+5VD1IMSdXsdFbv7HCgg+w+Xy1kFU6NQerTWPset2pk32rBuDaKxyiiKiklI9/PJ5zyuqmIAtJrLZxcLcGArCQ8PEjtqxgET47ZNFtB3urQjVflDGkkENmF4hLC8fXztMqTniQb8Xgvz3loZ7Re9Pl1Seb1fwJ724+3zPvnYcylSMtn7CCWY6DprUCehoBBtjPkllxPrvWcoUsgOYOPrt/prmnVKXLDJrSlZRu8GzrwaR2UhVNim1Y5jD8dO7EKRPtlCLow4XYDj28FpFmtTNjqVfQogOdnI0WncyeNCgezJnsgrf9wJNx+x8dQjQe9WezxUyah+aYoxyBvFKuVlGmLuZ6QZUCIEyLg+8AnUxPZFJaomwhTwuXIK+Qr18aAZzh7AIVeYjrSo4hyuLYlAixpX6ajWbid+8IeaXDL9fmmiKxQQ/aNPC69yOw/NDPw8LEG0vN8gjPJxrhca/y4vqkW4srSZ6JswszTAV0gUZEmXkMV2tEC/kzF0jAYNai2tD88Q6AHkEsoGmJ9hjazV1CdzZzyFLPUjEitNp/CWJ7agMewIhNjJjKm5DvdtFP07R8pQc7/8MVk9XBZulQxftmxWB80f5BrvRgjYiGuq+x4N3zHe0lUzo/h6X+nuzPYGP2Il7l163bby+TLMiOoRqpazwQn/ivuxsQhPo9UXQzwxp9CBZlo54IDBLIVH2/gJss4X+GNgx0KQmwVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199018)(38100700002)(82960400001)(966005)(110136005)(6486002)(478600001)(66476007)(66556008)(316002)(2906002)(4326008)(41300700001)(86362001)(8936002)(44832011)(6506007)(83380400001)(6512007)(186003)(66946007)(6666004)(5660300002)(9686003)(26005)(25626002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?emzJhkIRCvlLQou2Qx1iKZlL1HZT+9goTEZDrlrFe5wQJ5bMKOAWvrdsOxKR?=
 =?us-ascii?Q?3cO7RgEf6YokC6rJrfF+ELP3FhIKOAEo1LvdaUTKMycErMwEQkfvF6ZOy+fW?=
 =?us-ascii?Q?i6/Hi8D9pW8P97b4X7F83QHwFI7ByYnkmRqXrGQxQ7mJOq69jobPZAkcdkfP?=
 =?us-ascii?Q?p4rXZ9RW9rIogV5ZiIL4XloHhNGBuYX6r0UcpfSZPLfGlpurznFxyYeioNlz?=
 =?us-ascii?Q?Wc7u9lHc70A2JkLxsnYhhDw9bHcfYBikoTAZQnmEie8vwZOKgYPM/l1PJyoK?=
 =?us-ascii?Q?2rEPeVY1QfNZe5EdInzfuwr52pki98OkwG5O0EIb2JPdToCQcDg2UKYXXpuo?=
 =?us-ascii?Q?Gwop12Vm9dIJaXdQaHOS6+qFF3+BNS02WP7aIwWD13CAhICZ3hbe6I9LoHs6?=
 =?us-ascii?Q?oUMLX0TXS8R+mf8eHb1POVfQMgfrN1EiJsjofQ3lni+u4CsAqFaOeZ4fIzk7?=
 =?us-ascii?Q?nooqAWYR/ZEl+p8j+VzgkA6O/2FoO5Z6Zpi4o4v5TaCQmPNyTZIHkOp2Ystr?=
 =?us-ascii?Q?Rexn/cvDW7yWHoQ8w3cB+gY80fB1GhjwLkHqiaM8cVZ3bCshGurisqG2s1qx?=
 =?us-ascii?Q?C75PjnXmXFDBT5xE+3UxQ80sn7JdNnAIJ7Bz2HJjIpInUV+WgZLZiDmciHY8?=
 =?us-ascii?Q?HXM01eK03Bsdiz+rMjDb5Jt6hL+4OjXVsXGnwtfYcrA6R8N+eiY6XnbEpAC8?=
 =?us-ascii?Q?n89RY4ZNQliK8/G1FkAk3Z6+2eN3621kg91kQLHtpx6Ic+VCJIi8hcUbS5iJ?=
 =?us-ascii?Q?VGC8M9dz1cyrYChytmK8AzJehd0ZOns4n01clE4uhlDlzpphN2tEXZ+/SGXn?=
 =?us-ascii?Q?Vh9j1lqYQidCk1aYXe6pYc+Fqwn8HAnGU+vSyGRNcK54PEUNDe5UrfzYjqo9?=
 =?us-ascii?Q?lGjtAcN5b6AWDrdf5gSEB6iqeZlVHzMZRjCbr7Ru4Jqw0jAIWYustvFmV4OP?=
 =?us-ascii?Q?kj2XJ3qhg8p8TOQuBH788nPu4lZ6K/ScXNAhOI2ZTHtIC41amxtwkaX8cw85?=
 =?us-ascii?Q?blUT8Abh/+6+KSR3Eh+UrNZLlr/YU3KN8BWscvgCvc/mGDVSD9YBBw+Z1NqQ?=
 =?us-ascii?Q?IqSe2PtFU2pLpxD68HrihI9Nin6B1V7G6bUzVJF9oLgeGZKgM8Prm0LCAwwN?=
 =?us-ascii?Q?rsr4+04X31WFK34Np/qIr6gpxMfp3vzzIdB/uIltLD8okBuGfASFUNMkT20U?=
 =?us-ascii?Q?GNMFAR63fsBvcc8wRYVuXavXQ+QYIJc/NHVGbfvLMCQtobdmPefsTU2M2jhC?=
 =?us-ascii?Q?0EyuLlpQ1vzntq9D823vmWtUYj8wbouO6RAze9Z387AVIruvuJhBuwU0OW5F?=
 =?us-ascii?Q?Whc/+fUpor/uOyXl0pnfl3JfK/BjMwWwWWR4xC8wp/5NRy5ZqsEPxOTN+PTS?=
 =?us-ascii?Q?e76hgarV2ygC5cKX3Cf5NRAw4qMC98p3F1exy/jbncVM0t2RfFpaD3uTNcy+?=
 =?us-ascii?Q?ihgM857i5bjFXxo4/A45j1IqABU265TlFcE5SwJFWmZ0v8Kr/ZyiRK9ZFDd1?=
 =?us-ascii?Q?qtZN1usLkFdf9b9/ME5XWS7l5qCi8+rw2+Q0PgcugB+ZQG3TkkUbdbMpJhKk?=
 =?us-ascii?Q?+ZjM/yj1vOQgtJtAUyES4P/yz/r9nKGjyK3fdP/z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbf9907-892b-485e-4ead-08daff05ee50
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:56:56.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Br46W31NncWuupCez8wKXegTN319RDPBTei/O80WiRFtoyK0mgBbxIrWU7pfQRpdAz8VobdM76H72Z96At1eqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6421
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Subject: [PATCH v5 0/5] CXL Poison List Retrieval & Tracing

The whole series looks good to me.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Changes in v5:
> - Rebase on cxl/next 
> - Use struct_size() to calc mbox cmd payload .min_out
> - s/INTERNAL/INJECTED mocked poison record source
> - Added Jonathan Reviewed-by tag on Patch 3
> 
> Link to v4:
> https://lore.kernel.org/linux-cxl/cover.1671135967.git.alison.schofield@intel.com/
> 
> Add support for retrieving device poison lists and store the returned
> error records as kernel trace events.
> 
> The handling of the poison list is guided by the CXL 3.0 Specification
> Section 8.2.9.8.4.1. [1] 
> 
> Example, triggered by memdev:
> $ echo 1 > /sys/bus/cxl/devices/mem3/trigger_poison_list
> cxl_poison: memdev=mem3 pcidev=cxl_mem.3 region= region_uuid=00000000-0000-0000-0000-000000000000 dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> 
> Example, triggered by region:
> $ echo 1 > /sys/bus/cxl/devices/region5/trigger_poison_list
> cxl_poison: memdev=mem0 pcidev=cxl_mem.0 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> 
> [1]: https://www.computeexpresslink.org/download-the-specification
> 
> Alison Schofield (5):
>   cxl/mbox: Add GET_POISON_LIST mailbox command
>   cxl/trace: Add TRACE support for CXL media-error records
>   cxl/memdev: Add trigger_poison_list sysfs attribute
>   cxl/region: Add trigger_poison_list sysfs attribute
>   tools/testing/cxl: Mock support for Get Poison List
> 
>  Documentation/ABI/testing/sysfs-bus-cxl | 28 +++++++++
>  drivers/cxl/core/mbox.c                 | 78 +++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               | 45 ++++++++++++++
>  drivers/cxl/core/region.c               | 33 ++++++++++
>  drivers/cxl/core/trace.h                | 83 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++++-
>  drivers/cxl/pci.c                       |  4 ++
>  tools/testing/cxl/test/mem.c            | 42 +++++++++++++
>  8 files changed, 381 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
> -- 
> 2.37.3
> 


