Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F147335BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbjFPQRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345367AbjFPQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:16:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFD335A4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686932092; x=1718468092;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YPQeOoloaHjA8mjQgrsszejTB3/tF2lOCBeg+YMqB1w=;
  b=gmwcqCkzxotuCc19Z8ZQGeObj0e0yfuKeAvGzdwRYNmqzieMM2LB+Oyz
   M3gYKvagjpJ9W0yDbLsUBAXdnOaK7D+Iodapyp4JlcytWKKC6i5hRkqH/
   gxIlWbT4STeIeh0mDYPpw1UHskeJFcsXSFDYuPo9UseseuPZ9OA3Ec41V
   mteyArcCUViQQtwDFcOSxgQQi+mlwoLU2ItUcv6alqlZL0NzBozcW0dgA
   TrRD25PItmCrk+k6YI/ZyeYjUXXs6d4p1xqjo5bUxaixx8XKcpC5+LM9R
   YistERjCWTijSk/tLDvlwHvKL6XmjTghbsPS7C0XdsrNyigHe3SaVSobi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359261068"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="359261068"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="690298653"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="690298653"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 16 Jun 2023 09:14:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 09:14:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 09:14:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 09:14:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLhP6PNC1+zzVNF2ipw8RBOax+baHbhz1DZRutOb343nY1oPORa1OSgkJUi7egSyHPlz5aIl3UdJVJ90NbZ0Zry5bmvMq1o8qPsdl4HALrUS0DB5FjTSt7HcX/fYBrlW9gHjtWgI8i8aRxxTgJLwyTmWBa8tgElumr/myXpE89Fs8jpkD9Y1PnRW4whShabqe9RJB8CRBBUzqXTpV9oe14Yulr1zWemYWdJVwP+ycZAnmwgGrwSOfwxg5I9i2UOqf68Qm1k0MY/Uc3lkb7ECUUiNt2x/R73IuiBOcX/YE0EHbNxgzLYKv9I3C/IYEa5pRnQr67BZRdkaosUdiSYTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2odGeW563ErbnmDuvbDvQ/2vk1UkH7zMWAoQI7t4OTw=;
 b=R0WH6nULxyboOUbqYNP9G+D7EUZOiMcsEVO8SP8mCXuEAcgo2UX0mkheqeByUmM0qpXqvUfxvNtJiIbQtwGI/pifao2CdACxQJBVgsVuBOriK6nWcMRfCNOzxydX0lS9HaBsJxFuyCJYNpL7TA06xbgIz3QrwfjNbIn4dE6XREA5tiVQubb+NkV3q+QbCCkdbhRIEFguMCErxUYKsZXCfR7v5ouso2HtQRc6mVFanAJ0kxpa1sm2MFYHj2VmEXEWKJGiYetcw90MMvZCOfu6H0WIJoIScudreu1z1xe7Qnq4btKn8LxJsEWJ5ptAqdeBxthlYb2aveixt4CkcnDsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY5PR11MB6210.namprd11.prod.outlook.com (2603:10b6:930:26::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 16:14:47 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 16:14:46 +0000
Message-ID: <6d81a3a7-9b00-d00c-1786-0238d35310e1@intel.com>
Date:   Fri, 16 Jun 2023 09:14:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH] nvdimm: make security_show static
To:     Ben Dooks <ben.dooks@codethink.co.uk>, <nvdimm@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>
References: <20230616160925.17687-1-ben.dooks@codethink.co.uk>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230616160925.17687-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY5PR11MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: f473486d-d447-4f13-704f-08db6e84ccfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BaWqgvA4OwArHtGnKRhxDF99xBkR1SnIEIG7SB30/1jbhFn43jECmme03RHFc21d7jrRSODMPQWzRbBPkKtppEEwS4VH1ayLmn03NlztgrW6C+N7yV51e4kBzN7vSYl+CTEFni84I/D+5/4lv41A87h+GIPKEXzQQ/zCM361jqr7lOuxUrcwMkp0LJXbPmPYCG53TzCPUyOm2mA3VZqRAqozHTGs728X30DNstRzaD2BzeosCulnPPqqDYtdvTxVGTAfo+QfKS8zAkagVc0mPprrq7uLrO7Uxh3apgQsou6LvJaqPMYUtdNXzk84IRRwqj0tgMmnBayYFZkp+nIgG0JnD9on3NZTlD191I4w3mkmeg/Kwse6ZZ4ogq9w/XJLklWieh2/wNm27Mr75k/NOhmLlzc4qwIvVX6qkpcv9EkafwNkAMAxe8cKq5jYbbV0WX0/P9QE3DNmLIJsoKFSQ/ubMqwA7op/Qt7cHMGhpv70CNa4IFBD4su95sJtC1EjiJ63PhOgeHOpUNoL0hB0KfTk6az2fCIhcMB55Pq2cJG6tMhbtoTLC+wzONI4z3XrskcIqeephzcdYUUbYOIEs+xy2u1UDEqlKXh93dAuF2pmbRwgiVJeLgLKQpJpUdxQD2uQsSGGQxj2UAA771jrIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(5660300002)(82960400001)(2616005)(38100700002)(53546011)(83380400001)(186003)(2906002)(15650500001)(6506007)(6512007)(107886003)(44832011)(26005)(478600001)(66476007)(6666004)(66556008)(8936002)(316002)(6486002)(66946007)(8676002)(41300700001)(86362001)(31696002)(36756003)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODlzSVFVQS9pZDJhZUZDUFBVTVI1d1FqWjZra0JyT05ZOG9STVdKWVg3ZjZw?=
 =?utf-8?B?UGg2RGNvbm51cHd4OE1sVU84NWR6OE8xbFRYWlY4MHFqaXdvajRXdGdrM0ZT?=
 =?utf-8?B?QjdOUXFPalpzOGluUjV5THlKNHE0eEhDNzJaalErZnJ6TkNXTjNrK2VocFhH?=
 =?utf-8?B?QlkxdGY0ekl4TjBYYldqU3NOa2dRa21jS2oyNlFsZ1d5Zm9CSWpqSjVQZnlN?=
 =?utf-8?B?S0ZkdkdXTkZzV3piOFpJOFpaZ0dRK3dJRTkzWkpuaWxwZzg0SVM2UVJrc1di?=
 =?utf-8?B?d1RGcjJyTENnemZyaG9mWVRjYnlJSUZYNEZ5RWx1c3BKZ2c0eWlob2grTmto?=
 =?utf-8?B?Qy9PaHJKTWQyQ0xTdUdWd1VGUm5QTmhFc0QxKzVxaUVqZ3lWNTFmdFBmcWJT?=
 =?utf-8?B?UllOL2cxeFY5cGxiSS9qYmZsNC9DZ2VxeXQ3VXhhZGdDYmppb1p1T1M1ZzhZ?=
 =?utf-8?B?RnRkdjZDS0JXRXc5c2xwRjJlUVdwOXdrc3JubW1aQnVFdXdOQ05ONS9GTFcz?=
 =?utf-8?B?YitrOHJzN25Rd204NkdUN0hOMDhnVmZWd0crVEtaNkJJRWZIbDE1ZnhENVVh?=
 =?utf-8?B?dTkwZ0NET0ovcG5IZGU2Z09CMCtDN0ROalJqV3V3QkJBTnBGeHZVR0ZTRk9n?=
 =?utf-8?B?L1NxS203QmFaN0xxK1BtTmNIbEwwNERpMmVGb2NqNUthOVJSQXh6QkUyQjNp?=
 =?utf-8?B?U1FBU2NNV0lRK0ZVMnNJWE9CNEVpM0VUbncvcCttY2hpZTNXWWxrL0RtcFA0?=
 =?utf-8?B?LzJzMzk3R3NFWCszbi9wVkMxenBDOXhLcHI5bXdNWkorQmRkbzEvZmNaVDF4?=
 =?utf-8?B?RkZMa3BiSHhQejJoWE5lNHlQd05BSVBEUlZjRjdYQXJoMkhuRGsrbVV0UU9G?=
 =?utf-8?B?bnhKU1lKT1BUSWVPV2FVME5pWFJUWW9WTm82aWZDWHZlMEE1TmhJU0JrWDI0?=
 =?utf-8?B?emxTR2cxKzRuNUh6QmFXc1FybXZmQVRSWWw4V0paNDQwbXFiMlBENm5rVm1G?=
 =?utf-8?B?NURZNFZQY1dzL2hkQ244SkxuemhmRk5xVmpWSXhGOHJGQ3JCek10VmRSQU85?=
 =?utf-8?B?QXdJSHQ4RVhpTUtmS0ErWVRjSDFlN0VZcnJTcVA5UmNCMEh6ZlBtT3VCdmFG?=
 =?utf-8?B?MkZ6R3R4eEtZVmNJdkRSZGd1K1daTGVqaURERTZhVUNYdDBpYklGTzh0MnBx?=
 =?utf-8?B?YXZNWkliWTRManFzdVZjd1B0OTFXeWRkSU1PRERpZlZPMExOYTR2cWYramtL?=
 =?utf-8?B?cDRmRWNSNjJQYUJGd0kvLzBFTFovQWo5K2lNV0txUTJTVlRlNDhnL2lYbnlE?=
 =?utf-8?B?VTkzcHlNeS9YV3lWYjRnVW9uTkM1d1pBSWVuWnFYUG9lWm5JcnBrNmlKM1h3?=
 =?utf-8?B?b0liK2lUOWduWEtQK3czQnI1dmlpYXRhNFlObDVacDNBNkhQUnQ4VDR1bVJp?=
 =?utf-8?B?Z1dYQi9wTTU4V3FOYjFjYUpxZEtYSHJIYklxenEwTmhUN0JRdndwa0Q2eGJi?=
 =?utf-8?B?K3ptT0hNcG9IZVd2SXdSWHdVblk2UUlIQ1pwWGhFQUo5VlRZdFM4VVlhY0E1?=
 =?utf-8?B?WCszOVJsRzNmMFA3NDhTanh4UWJNNjkxUTVLelhVckJmaEtvcjJ2NDRvS3hz?=
 =?utf-8?B?Lzl4Y1NRUXJvenN6TFRIcksvQi9ST05TQjM0cDdTclY4U3cxV0duMnpqbE91?=
 =?utf-8?B?dUJ1bzhJUHVPYzkyeWpzcE9sZlhWeUhKNGQ2QjgwN0x0VitUeHg0a3B4WHBQ?=
 =?utf-8?B?c2tqd1Z1bnJuYjdoRTJGVkZncTVDVWZ3YXBiVllJcUtKREl5TkIvK2hRWVU4?=
 =?utf-8?B?K0EvZzk0RklmTFFVTHFqaXlkbHR2RVVRVkdQL0lSYVFQWXQ0UGh4VDUrR2Vp?=
 =?utf-8?B?MWthWGt6QTdxWm5qQlJ0WEtlZTBHZVQyTWdjRlZ6elpKUTZ4TlNPNzBJaDRp?=
 =?utf-8?B?SGYzUnJBc081WVRKZnlhdHVUdFBUUFptayt3VUllYmt5aG1icCsvMC9Nb1Yy?=
 =?utf-8?B?RzJxSmZHUG5ySEV3dTZ4K0NOS1JEUnNTc3AxSHk5cXlJaFJCVnhYTkZRU0ZO?=
 =?utf-8?B?WkJndU9FSUhjWHZ6L2lyRFpzc2pUZnV3b2V0Zk5VaTF5VDJsaUlrdzBIRXZh?=
 =?utf-8?Q?5LvOm5HAjz3lWTXnj8pwfPRr0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f473486d-d447-4f13-704f-08db6e84ccfd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:14:45.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJFZwZq2dm8/FmlJhTi6QUpAT2pP/+rFOuBqbbjTui5LtkmHTm778KtfkDAkKeT33Zc+C9g0q7x+OEO6QVJthw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6210
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/23 09:09, Ben Dooks wrote:
> The security_show function is not used outsid of drivers/nvdimm/dimm_devs.c

s/outsid/outside/

> and the attribute it is for is also already static. Silence the sparse
> warning for this not being declared by making it static. Fixes:
> 
> drivers/nvdimm/dimm_devs.c:352:9: warning: symbol 'security_show' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/nvdimm/dimm_devs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index 957f7c3d17ba..1273873582be 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -349,8 +349,8 @@ static ssize_t available_slots_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(available_slots);
>   
> -ssize_t security_show(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> +static ssize_t security_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
>   {
>   	struct nvdimm *nvdimm = to_nvdimm(dev);
>   
