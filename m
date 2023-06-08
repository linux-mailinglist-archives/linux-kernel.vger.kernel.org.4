Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5072891A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjFHT6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjFHT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:58:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EED2D55;
        Thu,  8 Jun 2023 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686254312; x=1717790312;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bIyWDGbAV7QalP5yYhM/t86DFotCuwWJqhN73koKZso=;
  b=O8X+IvXP+qJT1F8Pz3gkMJHX/6oofePvnJI4dxA9U9XQ6L7dyHieQne6
   xrPdaXv1pUARZwq3MqLMIEOkvZJSJMbSOOmkbnT8jCgRxkBefaMV83X+3
   eEPi3qOn1i/DfPz6WHWve9VYvp6/MqOuva8kGdtLH9T0Hc66KlkGFJEwo
   6appL/fl8aEXJhhmzVqQsV1/xf6aasu/is5VbqD54U9o5Bd67tWcE5p1i
   jq/H5vuU0n7dYVaxF3KU9kxk9ce/lxjOu2HsFINGszeoDlTCotbiaeMPp
   A7frLm6xiUayncGByfBOR056EKN49AZcnuYGfPJFx68RbfMApAQRin5nz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360773615"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="360773615"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 12:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="780023883"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="780023883"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2023 12:58:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 12:58:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 12:58:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 12:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaSffpqn77DK5FAV8CCesjfl4qZ9xpS0OJblqU5hcBJdg35DUnaViptumxoLkeAXAwCqLsTbblu9U7ZNJ4p6b68FU19stGPxM9hbsL62G0Fa3jBJKwqdJ+AYCniaZNTTZlBjyjHj6DyYxL8AwRkptvzXAfzcDzXXjB6K0z8/Q0Jbpaw+EV+BDZ43eOJMeBMuTjKCI62Rgd3NzAz1mcoQN95qBgMqpm1L7ShY8Uijnmpci0bpcyUVdwG/+jb463RFk4EExpTWpdzpsEfzxh8AzQlYYMC7Ccbi0/T4seEk/cFfdocuniH8orR3Tr1byk5StFjpe4ScuHuVwioVxaGsww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rckHAaHhBx255oDVugVzQMvmPm6MT2mqAvUmKoCN6gg=;
 b=WHvLwyo/qdyaxlfJk0huy3nffBFYvHfbTIZP2c3ztzL1dRO0e6yBKqNbSXmpJ1rg+08RD9H6rfSmDW6zS+nTj00/3FlvocKPbw7QiwxDhaCCL4eqjdtircnxQ8pEviSty+DjLr4Dig6ymkesFDetyDcTRYnDkm1N6DNqEFMhSg+3AqDWrLMZGW9FszBhvQJb1QjbYHRhVfQ1DktQd3kZom3OPGleZQBmeFEFJYUAC8eW3yUflKT3ebSM2OX09/8DY1r1Toeqry+UbrKKh5v8zMjf1c09ZP9d6LHU4HVphpXbNUFlMPad1siDnInRQIi3QrwFpzoFE++pHh8TET4kdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB8263.namprd11.prod.outlook.com (2603:10b6:806:26d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 19:58:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 19:58:05 +0000
Date:   Thu, 8 Jun 2023 12:57:58 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 06/26] cxl/pci: Refactor component register discovery
 for reuse
Message-ID: <648232c6cde47_1433ac2945d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-7-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-7-terry.bowman@amd.com>
X-ClientProxiedBy: MW4PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:303:16d::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: adf2bbda-7f78-46c0-01d6-08db685aac2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRUHvWTobo70isRQ0E/j3xLcsjklr2Ja6NOe6o+rjVU6BC5qGecm4tP8L5J8mGg+8vZ6yIUCJnQZTqXlDS2zRsw45B1jT1n7/yFE1OAT4fNWxUB/e8i+L5/WGU91NK+piWZGsXqBoYw3GjYZxizYwNZ7dh1KYInYhWy3II7dXNlxnWm/ucF+IG01YZ85oHu64SmInSP180/XDg5nguUfg08syPJ2Uq2Jc6yTEFWsMdhyv4y4GUl3x0ZHt8ZpQiFmb4JSh4J1+rPS3BheVQSx6r+gnUMeXOLwBNE+HB6/ynVsdqPY8b2+8btxD8xBhb0F1DVdTv1uaGgTVDda9q5FAa2/kKAvZXCwMcqvP6ps6M0yFWjaT3tkL4ZP368+4ZCZa6AOBdtFrup1FUnYmGZHOWA+Tr6HHqF1aD3z6+rZIreuyiC9eQO8C4Q7JFaojdwKwQsJwKom2a1euq1GfwV8pDKjvtlu6QXk/Y94KACxEp/dhqCaNiq5o1d6ax2FBozUqXQOZvVbBKuONDb+lX9EzBj/A4PbE6EaPLGQpKvjF85iqPJposogK/jJBI9k7HSI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(6506007)(6512007)(26005)(9686003)(38100700002)(83380400001)(41300700001)(6486002)(6666004)(186003)(478600001)(66476007)(316002)(4326008)(66946007)(82960400001)(66556008)(5660300002)(8936002)(4744005)(8676002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m5qhZ+A3FjhPwlBvs+YLr2tBE7gVFCu4CTvAv8sbb3G65VEvGy/IXtVNrNb8?=
 =?us-ascii?Q?FnPjDjytNymZ1s60/CcqRO7n0rvzpbbySmvZekTUjiLmqYV156jkoLRexX5s?=
 =?us-ascii?Q?gunlMp3Zo7/+UGuncZEijl2hMZgE73rpKsD+589o7PC2bkx0wcDGSQtpQurj?=
 =?us-ascii?Q?LFedKBYVkIHZfWioC+tSsqeccPmIQ40awneCKT6rZAOaTWD3KhI9Vj0w90rN?=
 =?us-ascii?Q?bXSFztWJTdq8eJ761klhnCedZY7bpYZhdnA3VMTY9n8DUbkViaQNmFJOz/xI?=
 =?us-ascii?Q?Hn6QHCWYjrANqXWNDjR8jlfgUiAAxoA1M0v7CvgH2tBArFoAw89KcLe0GhV7?=
 =?us-ascii?Q?4qwVKpF1USa6O68NrGqbtnYAy9bud55doRTK/lKZx96YAflCxFmwfPkrgFz3?=
 =?us-ascii?Q?Yw731qN1yw+a9kcAjYrbAQfS9+s5Mokxau3WzDmE64o3kg+TQGU4ITnhLoEK?=
 =?us-ascii?Q?fEFqEKZscE0puzHTp+7hZM3ykIBvFk4M8oVwGA+d+FKrVLpz6Jy5tRerKa7l?=
 =?us-ascii?Q?Vk5+o3kA6wnoA/+V+5HNEgpnfr9STWw8+yxw5OyYEiaUSC5ttJoG8IqbeWLy?=
 =?us-ascii?Q?yM0cWw9YJoPDLW5CJGAas5vZxKrhAVx5Y1rh4aClx3rL6i9LAqZ4JatnB+FO?=
 =?us-ascii?Q?+tt7H6g37VwuvuNXgHRg09p422R1B3r+4huJ6GRzR8cjq3nlP6Tl12N65FwL?=
 =?us-ascii?Q?Sf9xQM4yKLE7xfvD/c0lPvgTWcIXpnouRNNCrNvazRChy0R+fiTkEBiUKyYQ?=
 =?us-ascii?Q?WJic9q3q5l++nU/0Emu0lBW8t59OQxEqWF5+iFYjcGdeB1b8XQqF3Lgcxahu?=
 =?us-ascii?Q?MjFD+y33mUUKMg7hFF5lT35EufbZkaIrrKelwH4NjxYqpHvYnpVOMijpUOJU?=
 =?us-ascii?Q?2ngrzXltVPCZkeN7o9ZHF8fmr3YEmqKSMq6ziPSS5/KvaZwUYdxLBRd/cYmO?=
 =?us-ascii?Q?1oCxAvUaST8fQ4W11ChtaPvBBP+J8/DdUyh0de7O596788Jm+9sjD9HbzCpf?=
 =?us-ascii?Q?BMZpyjHw7AyUzD1WHB9mHEPpwvoJdbhB9Vsfa5oWT2EI2Ct0gJbND2ZiFss8?=
 =?us-ascii?Q?95MLaWclG7PzR0tyJ8h59LBO913KPR8DJYzSw01AMrBtCPdz2WPG8frgvx+I?=
 =?us-ascii?Q?GQBM+JjAmhN/HP1k2WQq3wZmhGrcZ55hNKso6zVYsporFVSXmGZuB1PmN4RD?=
 =?us-ascii?Q?hoUDc8IvMB7VkEBANv3XztCpZ1aN5tWKw6fwHHBRXltYJf3/8AWO0nSinRsh?=
 =?us-ascii?Q?HdnHi8y9TTofoUrGV2t1gMgP2/wmxJSKPiR30ECGOwtc296LRrkD3tcg8+SH?=
 =?us-ascii?Q?tW+fGce2t8vpHlv+VRbegYctf6/cYs9WC8Qg95gNLuofmY0ezfIKkvmPRo75?=
 =?us-ascii?Q?HOCD2fKffNH1G8hW2fFAAH/wU9lPyObc1n/5od+K0/A+0rL82AbOzWCBvx1y?=
 =?us-ascii?Q?mHEARbOYnW3fbykLFfyKPn5bmdOhLEV4b9Yrqtg8Du+sl7nQgbs0ooGkYF8n?=
 =?us-ascii?Q?2o5xDNn6CKPfuVqLsTfL9HZaEYw4c+53k3tCx/dlhr2J6K5SGGJdbK0yKpUB?=
 =?us-ascii?Q?nR4F0Wk/y6U+Oxoq63DeLHnl2y81WZEQ4dAiQNWsMUL0CmdL9V0XR5Ww6GHV?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adf2bbda-7f78-46c0-01d6-08db685aac2f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:58:05.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgNhUi29FEyFN8WTWubiDf4BVOmIE5o8K4XrEXosV3C6Q0A+G0g3+FYOFL1210lEv5/+GBFQswdh7PH0AUWDLr/wbqlXKo18+y1AiGwyIp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8263
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

Terry Bowman wrote:
> The endpoint implements component register setup code. Refactor it for
> reuse with RCRB, downstream port, and upstream port setup.
> 
> Move PCI specifics from cxl_setup_regs() into cxl_pci_setup_regs().
> 
> Move cxl_setup_regs() into cxl/core/regs.c and export it. This also
> includes supporting static functions cxl_map_registerblock(),
> cxl_unmap_register_block() and cxl_probe_regs().

Looks ok to me. I hit some minor conflicts rebasing it on changes
proposed earlier, but no other concerns from me.
