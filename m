Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146A9748C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGESjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjGESjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:39:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D20F130;
        Wed,  5 Jul 2023 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688582348; x=1720118348;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jD2MXyHvkQLREr5caJZ7BtQZULPxYK32eU72zL3mvoc=;
  b=gHGwzVaN+SGmGHg7S+Urk25+uWjGGvMxSfht0YfnJmUDHns0OJu6Ad13
   mh5ni9fhVapjQwqush3kJqAyfHAhuOUe1ecoXfJvFjq4WhRGjcL4PQri7
   fgDLdb8xwkd06KIUT+KXGG7c0qkmsna/QtGqoA19PfR5aI5VFa4ZC+Pbh
   vc/+kkdvBrTY/Wq7O7iiG8ilT4r1l+rj1WOq2kkWxajtWEv/taRAJvDnW
   W0QIyiOXBykkJ+PdnKOMFQb9TNlO6iipUn1JWQsceLy7hoMOpc1mWWQvK
   4y9+hLqAXsnDRbTVznG4QuE3naajSwjgVWEJ7MCd15BmT6d2bwJuLgd/y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366903255"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="366903255"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 11:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="1049810603"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="1049810603"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2023 11:38:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 11:38:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 11:38:46 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 11:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/UbfEf+Me7vRAK0nqvoYc1YCX8S2dflWnSRPcFiIkvXlNgu6brVi3AGRxpMdBWXxWg9Okl0zq2lfMIb7w3fj3uNwp9dutWotelSAUz7e7L7+c3e8M3j2rXkFOPVMbxY73UsdRUUC5vecJHu10iPDT1Bk56Z8lmr23i0DppiXW0UI6AFgHPvr5vDRG1D1sV21v0jzzDuxRFttY4s7qxUR7ZBnY8cjE3WaIiMVImoG+5nu3PsGaEEhdi6gRysLAl1YOgrZTIZASpv5NrDZ0Sm4nN/L3Wll65dZT6cqGJxRmoDmD1aqHl4yPFlVE9GrvTBjF0iJdB3YjnADWdFZuDvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9vzwaomcpcLCrH46xKMyfYsUDwSAfko3qwV7mLgjAM=;
 b=bOCOgGqb2UvtIdZ6JgcUBM6vC71rEDOMQ8PFo1qnhhxvruTQdiPicn8q6jyWG/Gh7F8o7tRMT3nX0mw1KJriSooiRAbFR7jUMd0jHWqy75/rzIKw5Z4T8BBVxsgetPSWYTnlyEWakg4F9SgDBvBetr0l3gegSbJ1CQfY8O+OBTOCDpbzmLWNkW8mVrSfZlaqh1figGX6bL4AT/AkanxT1aTz5Z8I0I9utQtqi1NKv4On6fyZQGoE68pijqnY/QONuRtV0KrbeLbQA7N4FCgnsawk9DrzGQMJYwKzyyrxiTGOHKKo5FXr2T85X4KUB9OLH5WwssS2N2up1mVC8+OqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 CY5PR11MB6113.namprd11.prod.outlook.com (2603:10b6:930:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 18:38:33 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 18:38:33 +0000
Date:   Wed, 5 Jul 2023 20:38:20 +0200
From:   Michal Kubiak <michal.kubiak@intel.com>
To:     Klaus Kudielka <klaus.kudielka@gmail.com>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: mvneta: fix txq_map in case of txq_number==1
Message-ID: <ZKW4jNOeAPbgniSF@localhost.localdomain>
References: <20230705053712.3914-1-klaus.kudielka@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705053712.3914-1-klaus.kudielka@gmail.com>
X-ClientProxiedBy: FR2P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::9) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|CY5PR11MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d62c07-2b2b-4254-9727-08db7d8708f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JjGk0fXhspvX+t+wPa0VW3SU753nC7Mq0NxjUPU9woBx7G1WQwXSMm7K8dj6bQnZ1WMgkL6jfY0hUVAzx6rgLLGujNIM+cIcgYcoX1aQl/V1WIPQC8HoezclcqV433h4yCv/JZ+sXYbBwix5KRie3WmNmNS23L1SHwvnRLlX4CtIzi55tzrnxOnBmRhyEIhFFMrJWcTZH9VSF5y6J//ikJS1odFQh5gfDjM+sr0JsKYm/sBianwvhehN1pwo+kf2FbhUQ/ZxYbAVvL2eC1gVeoaWFUG1pjwFa7Ory/klt4WIgsZDmLZwFllomqf0ILqASsqiqiJ/sQCEPYHr7t4yfCfponY8q6ILvDOKueOD19OmXFOfOLxTFcnnrzeJRnBtjAS1JLShEhXl40A0801REC1L+RlzMSz8lgCqLWqRQ+3NT+u+lPo0D5wHLn+VwsIvud/g2yu/ukxxgWW4YHc6HqQb9TrJQuLIywaMxI4vKi6TzAFGVJUyAswXIo7DheytOp5nstaX/xsv6OhvAOPsqtxhnhJ/KcV+CLzPPoBcPQxzcQEn4wC3plyTQpQGDyH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(66556008)(41300700001)(66946007)(54906003)(8936002)(5660300002)(316002)(6916009)(66476007)(6512007)(186003)(26005)(6506007)(9686003)(8676002)(4326008)(6666004)(478600001)(6486002)(2906002)(44832011)(4744005)(86362001)(38100700002)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szeKe9jou7kGhDm6XLn4oovYG1NDJydP0af9otEHb7UIbWuhfJ0O4dpyGoGH?=
 =?us-ascii?Q?wxq7MobYBflAJowcdkeUnWglThECCXyMi6z8gm9eLBIWTVd2f/pFNw+oi87p?=
 =?us-ascii?Q?autMOzWpxJXgUimBVUSN6KwYwQ15oA+NkhrLbLX+M1a+WvK5oXI7Yd1YdTQW?=
 =?us-ascii?Q?Xe56F8kUBJdjnFgfeYjo/+xFTxV6SppleRBDWy0UhR/zvC6dQ6cwP9FQS/Ii?=
 =?us-ascii?Q?033Y0d9J5Om9lMxoRRN68E1quHLRyYhqvHvYGsUDukt4/8CW5nmqUcz290hp?=
 =?us-ascii?Q?STBJH2UTRyfBCyQWVHiVQ7rBAXB0B9MVsvfVDggrwXQkDmYzv9ETogpOS1Dr?=
 =?us-ascii?Q?j/mByVfqE2U8UA0fxjezSAIAqDQx5u3boH5vGWxhTvvbvA7F8NXLCfdz5T9B?=
 =?us-ascii?Q?aB7KUhE6LIsTJtOqRD/Gp2MWa4aGD7SMmQ9iFeW9GBDEIExRVlPDDRgu09/c?=
 =?us-ascii?Q?qqeSua/fxn9DlwB1iyUYEVX5YX3mWF8thqwNTLzN9N7JJmRaKjBvNcKMUCPh?=
 =?us-ascii?Q?RL8pLc+KzRl7PXSNj29159vyZCkvixKtN4lJ1y2pJpTh81rf/cnXryY8HVxo?=
 =?us-ascii?Q?Ezf8gSoeGa1u/6G2VlGVlnE4vmy4UYnzdXvroiFQKTHOqWfGC+S3CwxS0299?=
 =?us-ascii?Q?69KHJT7w9IVSX57nWbLX38hgRSQOj8HUE5iFDcIJL3PJB3OyH3+5tW5tgrVY?=
 =?us-ascii?Q?fFSD4JRIaoFKBK6+UO2jdZ3DiB8GRhYu9feZ1/28oTPLfQiaQj2RNSO8JS1I?=
 =?us-ascii?Q?qPZYeouvzGQ9q+55pp/Di4KbGRsjopN5+4Sze2f2XyigtQuY7WrLr5J0cgux?=
 =?us-ascii?Q?4QLXb46e2yNCsJeTl2wrHGmC2rgDUWYwhQDuzrCOCmW6ySSHC5Jq/PS9m0uB?=
 =?us-ascii?Q?rARi/+bbfyBqtNyUhSTtmvdBqRenusjGTOKJvcLr/Di1nuzZ3vulzOcjF194?=
 =?us-ascii?Q?ljwUx4UVMwLU/XJXQzCkxN1sInf8ajJXyyr6OkBj6PSMzKYFmpl/RLAav9Ao?=
 =?us-ascii?Q?zvcnNtp/F9OwSzvNubMrl45cQ2dod48mnNIRC8X6fgYiBV7fM1iNhz9d+Mxv?=
 =?us-ascii?Q?RWo8j0NmCwFZrYnaxRh/2d49E5L3O21skF6UTyxWGVp9+DK6IlnjfkwoCZpY?=
 =?us-ascii?Q?fqKiIAxP3tWaYo0CSqV4zVXEiFx0z1gAZACdmJknYPEUoSddpU3XSxgvb3aW?=
 =?us-ascii?Q?beRfraDaqmNh3hbIDV0PB41IeaL0gw62ACsAkUq9ybn8qYnb5FGJBEQj/lo0?=
 =?us-ascii?Q?n/bOdV4SEpA4JqA2z54UstS4cZNEqbJFlFEkW+bUHypQWR5aYsQF8sKdksKV?=
 =?us-ascii?Q?BX+wkWzPsEAJMhCU7kgC0EE5AlB6PcCgMLlIUmLQ/jPS8e954GmUem+X6YgD?=
 =?us-ascii?Q?wNdQ1fekl9WqoJOz3hwR3+RJuzvYr9Hb5ERRkZgzODyurxps2zGJgIt8VLF1?=
 =?us-ascii?Q?4FpnQx6cxPc+4SDRRZpQQjC8ZCW/lzP5GDOB/QnKXPuqCnkpUhamJ0WXNATW?=
 =?us-ascii?Q?lBI6OR98bXyVeDSUjCNzwRV00xQDf834QNxAgZAMCFTqjhKCaUeeiQT/fIcq?=
 =?us-ascii?Q?bs9hJ0DUTz77tcMN2tYufR2OzF6SrY+Ps/mJWzhiXZWGBgK5GdbTVycLfOzk?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d62c07-2b2b-4254-9727-08db7d8708f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 18:38:32.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwM1CiEjRR4RuiHoYNKf5foLs/nddORYFgfdIkTUm/2yN1wCZLMdv3LctF/8D9rkQ0SELWXSEWj+49STiUZXdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6113
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

On Wed, Jul 05, 2023 at 07:37:12AM +0200, Klaus Kudielka wrote:
> If we boot with mvneta.txq_number=1, the txq_map is set incorrectly:
> MVNETA_CPU_TXQ_ACCESS(1) refers to TX queue 1, but only TX queue 0 is
> initialized. Fix this.
> 
> Fixes: 50bf8cb6fc9c ("net: mvneta: Configure XPS support")
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>

LGTM

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

