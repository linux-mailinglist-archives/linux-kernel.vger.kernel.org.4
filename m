Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED2606C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJUAUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJUAUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:20:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78450111B88;
        Thu, 20 Oct 2022 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666311617; x=1697847617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZUoGcmHMUDLO/8/ijj8+W2OAT8iZG9h/yVXFHlk8QJQ=;
  b=Qc7YDcBy1cMrTbqRlXSXSnrQBKwYw2l7rerQ2VJX5halPgDnTPjBCNvQ
   W9HdlXv/VqPHaF1hLjIjqNDri06fU71AyF4xXo8aamdWIr7Eo9rBPJiCa
   wSYGlVecO9RIEDbUht7aIzu5clJvkkrco30rjJoQMfi1vKHFx4tBjU32f
   FVowCNGtN2AZG0HutbLnhoIh0Moh8trImQ9g+PnUC/V8bgx1ffrkE6799
   X3QcCNeX9rx6IfQXOh5SI2zjePoeNGQBIvslTE/tZPZcnTN+OOJ8qhM11
   VhDIQPKkM/vqdVzuYO2XjvsTdYMO+XOq1PVwJlGXWkhO9umhCRcoVE8nv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305608227"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="305608227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 17:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="581247718"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="581247718"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2022 17:20:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:20:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 20 Oct 2022 17:20:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 20 Oct 2022 17:20:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhUWbhf6PyPP/Tf0mK5u0utp0Zbst5AIUACvzNxRtMYcH9Nwv3+RCkmu4S2EVjOsssro0lOliGWwi7vuRxl70e99NL1yfvqJn+4/v0itqIzs0sS1DrdeY1fJoKu8O6AxNrfNy9EHuISaPnzrlR4PrF8Oy1+vuKSibxVejF9jAJg4zXRN8IQaEsDa7hclZmrOg21AZFWz51ikE7Q/LARjgRCleiz02OQHNhpBDd+bUkxqjw/0R+OBdD37J0DHnU2Lld/zyOzDt6BthQJApSzFUwEQceYNQBSSIm+1QqaFtiCQJOZyZnpsXPwDNWDn+Dz8BG/8Z96CEN/Bzq6j14gH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUoGcmHMUDLO/8/ijj8+W2OAT8iZG9h/yVXFHlk8QJQ=;
 b=BUNJFxiEh+yafLG9VhpqhqjnSphP97fKU7Rd+2yF34TcZmLGe4fIwVDvZRwIRGPFnfKxjTZsqCYz9iGSs8PHRObNtSxDTsBSEYbC4goSsjg4+NT5Mt+RGtEAbYdhVv5n6LkqPTuv6WReKawRJ+2DOp/R59bac8MAqxN0LW6rC/WJDDM1bWTgtOI245xBgD6vwBYGmzNDE+q0EWPK5CTyG02iPgbMhSh6sADe0ye9POQ2A+QOctqt71oa5gPDsHQ3mFFpXbo8shP9XRb8I0jN5HxXLbm5+pTgS5PgcaMuCkUqFq1+LGxrM7p37u+QZH2yVMVc+dp7G1bHPMJcKp3RQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO1PR11MB5106.namprd11.prod.outlook.com
 (2603:10b6:303:93::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 00:20:14 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5723.034; Fri, 21 Oct
 2022 00:20:14 +0000
Date:   Thu, 20 Oct 2022 17:20:10 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v2 03/12] cxl: Unify debug messages when calling
 devm_cxl_add_port()
Message-ID: <6351e5ba56f96_4da3294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221018132341.76259-4-rrichter@amd.com>
X-ClientProxiedBy: BYAPR06CA0037.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CO1PR11MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: b9479143-a454-4262-c32c-08dab2fa0569
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSajXH9jdb98ZAh3iubMozaN1snvrj8T/glPT3yg9bGzwHskX41HAfKMfyM+w/RyeG2k5SzUrg6vXTBifFriUI1JhJziaTODcyYxFuUmtk9M1TO5SahFt/I0AFOG449e+HBQ/BpV7I7og2y9MEtKBJbP1OGTbS8SG1Cqb9H1xLCgEizK+5Y5ukg0fzhrPx0OyUpbzCfXjz5rV2RSSX3RNxl/tGmshFxXKbF/ks8I+nWqXCRLVXrf0l38Q1qAAVxPY2lwT9cgULgLWEr7GsPVxBwnKhFOY3/htxrmhD1sQi/TgoS53zcGTuZFGC31KFD1VHvV7qFTscsZ2lE1EYuTgPIyxGXkTbAQR6rdDPU2yt5HivxPnGy3weDlEwqAJDC0EVyZv1vOhtrW6u5bLwuKu5JieUNIXlp2AndKjG+ncqyFVy42hhgb+b757pdgZr2tiQLM6WXowFK2QlNxAmKOb1X4S5vtLF2zXyoiFYjllqfbhcFaFyn8nrOp5NJEEgq6zGUAmdW1DBuo+6tDrMlakcDbJ8XlX3DTyoqbjHacWichuq999kFS1LAHU/If6VJCpndCrbiIBzCPVKPr6upWTMBvTMDBR03fgUTQkBgdzzgHWuor3ckSkZsloMQjmVM+nBjXnSlWx1K2ILr3WxUhJc81+zajHmu5UfRdMIhoZFqx6vBjIuHH12DHELlMEjqa8NuQQzuB9lQkBA5UX5LfIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(86362001)(82960400001)(38100700002)(83380400001)(2906002)(15650500001)(6506007)(4744005)(5660300002)(9686003)(6512007)(186003)(26005)(316002)(6666004)(6486002)(54906003)(478600001)(110136005)(66556008)(8676002)(66476007)(66946007)(41300700001)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1lfZHf+Q+jkOADfWPyrKmtkM5cifzI33kE26oKPJiPy0cz1yzmy9LzTnZS22?=
 =?us-ascii?Q?jCN4cPInC9Bxf9dNqsRuQkKf9ME/4Il9s50jLOXDUBeNCM/vVSx8ZtbevCw7?=
 =?us-ascii?Q?yaBu0/Ff36iOCibBPMXu7i77eTVnYbcm4NK5/lmRBW3EOibh3rQ4IIqPuw8A?=
 =?us-ascii?Q?0s+bZU5RKJazgJHVcd3KBVv0I9IdWCOhc0DWNVd7smIpoNFCsQffwIHoIuJq?=
 =?us-ascii?Q?qNXD5JbHEp3KuWoXSIS09Qpn9nDJmt8CNr52/4O/L1HD9lGK5t7KTR/feErY?=
 =?us-ascii?Q?JYdHPfyLUUkU/pRq7uMogS5c+9wWGMhwA00PiaXMtThG5f/ZgO4RFSaOfqY+?=
 =?us-ascii?Q?zORh0VoITo7ejZb8OHwiRY/BAWDRfsM7DRfVxirQfKIg5WPJNQ+ugNNUtM4h?=
 =?us-ascii?Q?29quyyafjX2/iExZl6L8P3fXdw88LpsF5IVH0Hk8Samp3snYg3ZDAVYfduBc?=
 =?us-ascii?Q?EDm5W6iS1tC9uFlCjRUoDGTTytLV+bcmA5e6Bl+ivKXEST4LlGIQQYCyALz4?=
 =?us-ascii?Q?kZ3wiUfy9kug20RCMwyLuaq8o1v3DlJlXMOIFNPbW15OavOfnOw04U0yvvTh?=
 =?us-ascii?Q?2jFEDY5DpUxOxg1N029aIy3Ra/GdPVX7FMBZtCBnudNE18TJK3CJtAITDGBa?=
 =?us-ascii?Q?8KueiX/FNqoOTspnr6PcoDHrrDh1fRihWmXoCi5zC3L7cIeSjlUSPeN71EC3?=
 =?us-ascii?Q?IU7uIAG8u8l0aQzKT59dkwtBbZetiwOuQ/y0Q4KKtL95STtSVRUrJfJyMFRS?=
 =?us-ascii?Q?d9xWSLAwqRYErwyoxc3FjR50BQFe5atOzvp2WP46H9D1Qty7GMBn5Foa2teb?=
 =?us-ascii?Q?InA0/zttx7RLIBTH5MCNCiukXyZJFbshZqGFWJ9zMttKfRuqHZLyvkko8om7?=
 =?us-ascii?Q?3kwMhuHb9iXBwpXj8Nxvg9TTNy76ZTlL7lNtR34qbToGQw5a2B3KxI4WEddX?=
 =?us-ascii?Q?Ocq3Bjy/AtkCjarF4ZAaqYfLd0DKt3qd0rtNruw6yI8EeSJeQoESZsl6fi9H?=
 =?us-ascii?Q?OeVJQdc8jN/0t8HO0G/XoxwBaFJUZXnSXSlZ7aCH95yE0XEU4TwMfBEowSKb?=
 =?us-ascii?Q?0dl3lg+QVfGMjnmVnWY3eDmGfxUP04Da2orFJCgfbsxGS4Ro+yihbL83RZcX?=
 =?us-ascii?Q?a1JqpfR6dRlSGSEFBzbF5USV2L5DzRdGdut/MtsqBtyWJpe+YmHPUGckBSV5?=
 =?us-ascii?Q?kPDEKZms+Vbf7boSO6JjpFsH4NQ58YIDOF7Y46ClUkXN3J90KUr+H53SZVcK?=
 =?us-ascii?Q?bU8r7Xx6LltsQG52tJqe5kh+lgmvQmKIcF1WF/jGqlD0DWRFIGeYte+NKhsX?=
 =?us-ascii?Q?P+XnEyBq93RmkxjKAXl7E8PkV/dyMXgPmOs9vfP9p+lAwCTfgzjGApNQc5bR?=
 =?us-ascii?Q?QK61PkNMFJoihVTVt0yGNje4KtX4hOjWqZU8qh7nIHv7iw05DLcwkCXE0oj9?=
 =?us-ascii?Q?16wIFzMFemFGl8Ydst7nR4HC99FG9/tY0/hXQct4ICqw8gLFFC3nTg+Q5cGS?=
 =?us-ascii?Q?zLE/7N/6UtLbqF+8IphA1klCc+k3MGB4hncbhKSadXtX7mrkTHYgZDYBD6La?=
 =?us-ascii?Q?aeN7OOFrvUn1ehfzYEEFhFam+BQPCy4qEs1+HBGSm0UsP2OjcudFjk69s0Bg?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9479143-a454-4262-c32c-08dab2fa0569
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 00:20:14.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hVs0yHpyaV+Tbo6dKMZ0A6LIJwzWfRUR4NHzbQwF7A8lF9EXkzOa/3nDn/qCWzaO2ikR1k4Y8qKvU8tClAZ2E2yYEUSxwln3iPT+ID7B2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> CXL ports are added in a couple of code paths using devm_cxl_add_
> port(). Debug messages are individually generated, but are incomplete

Hmm, devm_cxl_add_port() got wrapped in a few places here. I fixed it up
locally, but maybe take a look at your word wrap to keep function
symbols unbroken in future changelogs.

> and inconsistent. Change this by moving its generation to devm_cxl_
> add_port(). This unifies the messages and reduces code duplication.
> Also, generate messages on failure. Use a __devm_cxl_add_port()
> wrapper to keep the readability of the error exits.

Otherwise looks good, applied for v6.2.
