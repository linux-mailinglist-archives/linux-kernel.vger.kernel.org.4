Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261A3728920
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjFHUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFHUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:03:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A2B9;
        Thu,  8 Jun 2023 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686254580; x=1717790580;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jb3mwmlDHBRj1jBCqOuRjrIuG5pFZb413EEZmTWKyYg=;
  b=BLa9sD8K90LHhr4SOgElwKiodGr9poySX/BCpmK7wWAnkfDie50o4W0k
   Bh2jx7wQFVM0vJ8K17YOrPuX3LaSVMZAdqG1ZywOqe2wyc1GCO2+NedK3
   Px/We6RPtCzafQftFLNQ8Mhi3SnPuyZou8popSbEzVqylq4Y8H5qAxBjd
   s6+9FWLhzRKrlvjEhsOBtbhNm+r89ivkCubnGvorDeTycXVn+o+luN33g
   6os6ZTowohLgf1lfLO+y4deRkMyO1tM3eReGO2NkfLmB5PTQq+mPw5JbA
   IDxkTy3ZgsKEX+YYwwmjRwbu2z7qOzRU5sMuyD3cMP+HKgmsWAIdJrjbD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347064702"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="347064702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 13:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713233706"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="713233706"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 13:02:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 13:02:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 13:02:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 13:02:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZsgzeDauDkK0KYQUFRmhRMbsCFX84e96EynzXPfrNnRS06YIqt3MTzoUTu35SlVqSM5hfKGuV2o35KCUz4RJfvYQ4MjLT2wMfelRB4FcHJoeAGWByNam5YhgOOPrx9z3iXtYn1FK5GX1zUbzmdkvUI8m5320d46lPUa28AGQASBv5O6+B44ciFOsrAxk4UtyPrskDhITyUg3qGCp0WKQpMWTOW+GK3GurAxKNexloQqiv1Py8BP56VF9wpWSpzxmYUFxf7/PEfzdBSZXDWxrciw5bS1I/H3NLtWt8j/VoL4W97Anz9oXbKQg1WazrMpZ253qOBgYKZXV3alksbrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vceZPLCf47RpwnWtGDthArqPFGrdhFSB5jNaj/RH3vE=;
 b=fIwQ3tn7rJNLzwcAUXapjN/OLveTAZrfQWfeDgvNae6TYOwdL+Odrhw5/9PifQ81Haj4V9X/gXbuYaFICa25OJLCMqsNdWtwANM5GdROp7X1xMZVqxVXzQQUyS28mldVX22PJ+/dcite00FuY0xDVHvvLf1zvsXVEyPULwbIukeAIQXWeF5lhQNySE9bApJa0OxDXX+D44yKbIABs3QgKxlpGUoDuKrYEO2PFRWAQC0r++k29hD7Y6ti9EsNMRLLVuEjfWdLkrUCMLYqIKoUR+3djZA6g9mfocQmc7yRbfCgjJdHrEVKOe2fqw+KEVE1InuT/0a5xcjFd7R3NJF7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 20:02:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 20:02:49 +0000
Date:   Thu, 8 Jun 2023 13:02:45 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 07/26] cxl/acpi: Moving add_host_bridge_uport() around
Message-ID: <648233e5ea44e_1433ac29493@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-8-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-8-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 10249e0e-5a2a-449c-f246-08db685b55dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUTMV2QLceSwrtMpQm78A4idtCSyCTGqJhWTuHMWoJ8HWJm6J2d/iUZOGiccEjGmrwjj/TltidrJKQ34V/+lblM+1lzEH4VLOAaDtpiYn4NHcGKvLKd+prDJJzAfQUmYlnQOpS8nwSeLwAnGi28eE2786rzhUIKxfKinYXaetA+KZb/OTFzHLZmGzoEveH4qVKpnHkQiSgItwuJykXBt6zw1oFqKR2UtUQABydRQREEP+rGTbGIe6rpLRlzERiM+iBsdWXAygtbqQwqZUAT8ZyPWSJ5K0A5vnEKL2OMFX4jS/fg8JLA7aCNvuGY8oEKRQqcTmbRdqTU9a1iAilzGJnL52RK+zRrycD0ClG4Adt6a6+6QLE4rHn97d36zYHA+6J92f8ILOx+TrW3b/hoD9FVB63wFJid8CrSP69mgTlhw77650+7C7d6NS4JtgkPK/noFvnJsPTnfTaIiy7EGlR6M81Rl7asQ76TmO2TADbTRTyi7/QHJe9OqeDDIOQOrv1EIeWnEsOIxLFM+GYaNhLpd4guO+xk/FN7SDs/NY6Qy7f7N9XAxF7E9obMivMlP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(66946007)(66476007)(2906002)(478600001)(4326008)(8936002)(8676002)(4744005)(41300700001)(316002)(66556008)(5660300002)(6666004)(6486002)(6506007)(26005)(9686003)(6512007)(186003)(82960400001)(38100700002)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L2RNxu/q7ty9dQALLd54NYLnRPZOeejdF5SpV2U/EeKRGDDpsC8iHIRR8YH/?=
 =?us-ascii?Q?RQgf8hg8jW2bo6wn0E6ZQv4utJx6t1Gfrv3+nErzCxXkFmzOSfzpdl5MDDQ+?=
 =?us-ascii?Q?3SWW3HTI+Ee5wsVrOw3lO2xLima1TsonBRVg9rvCV4oxBgX8nMyfS9P4Z8Hq?=
 =?us-ascii?Q?LKOIfZCaMDQj3QtA3hbe7tilJ+uCUYEmtNtcdLxejbNrQeP5+DGz9fx5xZgw?=
 =?us-ascii?Q?T4iRYu2dbqzTGbXG1EAnJ8xSkzuH5zvMBeBsNQZlahQ0S/zbmfnc/3cjylvy?=
 =?us-ascii?Q?1RvYQJppXPyTWCR932H9BT8HVGaQsbSMWuPf42YQR4OfxOTPYedoPUgqVOAo?=
 =?us-ascii?Q?C9Dk7iWW+eV8+gXdzf8pCvVnexDeKuzfCE4RVQHteOGifH1ZI3prk1pNKe3u?=
 =?us-ascii?Q?ywFq6sK/Hpy3ht8EHeyk9/cVJL16mtRfDu3LYOfuuMy30TM8OKVpvgLDSDxC?=
 =?us-ascii?Q?em8IXCY3QI4sYhGCimlxH/Nr5Djy4fWfZG19do5LGjEJh7BzqsnYAET6UAjI?=
 =?us-ascii?Q?LWGh6imfElB5hPc4S3WZbnhUi9rh9IhGt7/cth7ZgYmlAjEcuEReQmR2VMfd?=
 =?us-ascii?Q?ZYXopuQh4GkYjfeGUZWiz39mbjdVCg77BKDbUT5UGVOBZeBRP646RRVpbQmk?=
 =?us-ascii?Q?6Qh23daL429GWB7Qx+29gDTJvCqlfjItPOSJfbmTsy0X/C/lKeC6mCopyV5l?=
 =?us-ascii?Q?QFVvTY5rvzL7tkiXXUZqrSxb2SjBxdn6mtE9OUwcHh53DsE/gMi1V7CmBo88?=
 =?us-ascii?Q?5Bj6rgMZupiZmZFRD+OjZHbIU9O45BISCmB4dJHu+mL3p/j2EmCgJgs0ZSxK?=
 =?us-ascii?Q?eR77REIZjq36/QQXXVTXKF5z6zPXrLATvNw9cT+bZCu2BHMDcPRIED6ZdOyo?=
 =?us-ascii?Q?KHnvyOy0Sgjup5HMoQhYpgngUsuzY6tws0T+oswMVG+trCAD+OzF9Gqtv5qt?=
 =?us-ascii?Q?/5A0ywhM3EnRGM6XowM3I1LVjqp9lUfVvMdSJLuUEBh4cp3BTJ9CoIE55bjS?=
 =?us-ascii?Q?GvOiP9H8+zxpfPiSH+7rGMHpyC8wCo0iWFvtmh82+TWlxp4/QQ6NLF4wH89Y?=
 =?us-ascii?Q?jz3fpicYgCwkrFBVAR74U9fmhXmdbskJbv6lp48xPUXzCskP+KN4tW7N1ibw?=
 =?us-ascii?Q?UdBZ7ZyO9HA8cr2EmK03iFUX/x4OLj1evqvGrnSKZ3a2MVkOjSXvVaBz2UnQ?=
 =?us-ascii?Q?fXLQnM9NvCXX91H4ALpoKPdE8j9tQFGU8Bq2XeYl+viOTY4EKTytKjo9mRoJ?=
 =?us-ascii?Q?g2A12yfstG1VewOMrSVyTePZxGwUj6K1XHUS8OqmUgmKbJkVHWq1OGYwq1rX?=
 =?us-ascii?Q?HV7UEYJOr9avvf3gJYreOqoe9btcMMMKt+TiInnJfaX0C9WskOlvf5P0eD+H?=
 =?us-ascii?Q?zZq9rb5BPQ32eauhHjILyzOD9Js+/IiZC3SepK8AT03tXYIFtQ168UvX4eXT?=
 =?us-ascii?Q?VFusm4AHTuuhHD81KgOLyJXGNu0dzZNgPdsdV+sFFWWUDjseVlI5QJdT2hrW?=
 =?us-ascii?Q?nn13E6wPD8bFzSh3HIS0/zOwtjqNagRHXjnDRr35qooxtCMGuJi8T5tBH/gD?=
 =?us-ascii?Q?piMdok6T09aSxoRMSPrw7poGuIfUZ1GFQ9VCmJFkesV8r4NOJGV3Hf3Hnou8?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10249e0e-5a2a-449c-f246-08db685b55dc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 20:02:49.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDshiKYrkzThmiZ0j71ojJvRYQ3KfFksS3amndA8oHQ9IRvWXw5zh05Q+rcWwwk9xhuxF1BGWcYS1d8ADCqAn/6d4ULOCoFnJegqgH7Kg0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor quibble with the gerund phrase and this not being clear about what
it is doing. Just say:

"cxl/acpi: Move add_host_bridge_uport() after cxl_get_chbs()"

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Just moving code to reorder functions to later share cxl_get_chbs()
> with add_host_bridge_uport().
> 
> This makes changes in the next patch visible. No other changes at all.

Other than subject line, looks good.
