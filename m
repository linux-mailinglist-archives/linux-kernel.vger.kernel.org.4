Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B2A6B851A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCMWqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCMWqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:46:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FF661BD;
        Mon, 13 Mar 2023 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678747534; x=1710283534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ec3VZC6L3jb2hTJ8Vk2fD5nfk86yx2lLmL6ybDyQHn4=;
  b=atU/QJwSm1TicSiSSuT+H4mFb0tcsTFqiP+fTyDIly8dQHyiGGgynENH
   zdT5WgORJ5CJI+HkkV4QMou6ODFzMHgaQib/ermZkhZd5RPheTr/IeCFy
   efmFFusnfp/Wuu/xDU3Q5H5Z/r9uGb0+X+isHB8MGrbLcqw6Zg5/xmjrG
   mYumPQV6IZ7uV5i0zslZtNk442vCNK/GHkFnh3l81hl9lpQ94YpAgfmzt
   ukKRmTs0wi8fvqSNHaUUNREyE2ECpsBTHmc9rtjL5y8ktwl3Akox396t1
   ppvGlxv6hJjrlnNp4wkwGfB6iFtcjy5GL2fRxnvYL7vZQI36UfmjP7H44
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321129846"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="321129846"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="672085553"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="672085553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2023 15:44:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 15:44:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 15:44:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 15:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DATJSzBGgLZO9Ot984aYrYsLIRwU4t3DERCzYZqUEGzv4A4Ttwz3n8OPDJx9Shg48C9Szic94WwP7PRtifjUvPHWTNhhrm6p7lBG4NtqHrz7mI3cBlyH42KIyexmc3mVu38rLus5M87+VvM3x/cL3a5ulQtfyvAUJjN7j0g481c/IxWGQ/Hbx3ZnVFFpr7hUpCO9jNzBaK4yLwt6hAYHEjxMrOqA/ODy7XUFohRgZUKfUSG7nBujfcEqJBpYkuKsCUfTF6oHqj08kcjfsuPLkjruDYrMCL5xkxcxd0F7ng8Kf0QfAs0q3lzG9g+u21D7WmaFowGSbqQObUPk7bPyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiaXjeKtLEwIkW+ZuD3e05r/itmYm6sdOH3FUoee0fo=;
 b=Qq12G3C601nETXPKznxFU2Bh54ZqCZKRE09eN+7yDK7adnm8clCQu9rh02ANc1MaF/7S62IkSrgYLRLqdedNRQj9psl7bmWepf057jmHAXwpzJqRc/Ebh3doUfgymK+8AYNTTqxI6Hsh7SJ13K8+t9M7qlRyDzv4hv8WkF1v6pMo71xm3HjhMOs3lACoh5FTo5uNuePjmX5zEvu9Z5g2hoNikm7V9UCNMit5i7ebnp973i1bIvdHOABVtp6Uvh0/yBlYUoIqywExh6et1FqxRyyy3S0p98fov+LGxwUbFWOJw9KI9N2WNNymzqOhw2MjXt0OBKZQsYVvgCgGk91rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Mon, 13 Mar
 2023 22:44:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 22:44:20 +0000
Date:   Mon, 13 Mar 2023 15:44:16 -0700
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
Subject: Re: [PATCH v8 4/6] cxl/region: Provide region info to the cxl_poison
 trace event
Message-ID: <640fa740be63_22c07f2949e@iweiny-mobl.notmuch>
References: <cover.1678468593.git.alison.schofield@intel.com>
 <b5ba1187b04a18f49be9ebb91b699cfa8573eef2.1678468593.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5ba1187b04a18f49be9ebb91b699cfa8573eef2.1678468593.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e4733b-e559-4e7f-1a73-08db24147b89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzXp9jVeUF3cHFdYD7aS0w716sMcE+Ka+haQ31M5+0ybWQW1YqExA086CzOWRSiraZEv/bciq4rncNzbEfuar62MB8wd1n/H+pCdvEme2jAxBhl8KnZ11PHDdYEpiR4h9h0jMX+kgW7cstTkRjaqBBUGhEYhupDGBm9NJKR1/StCifwwpwAPfWkAezC/TudKQStsAZxW1ltd4nm4pcjaEgwYuJn1wiBJ/yH1/7FceCYtZmsfpbJB8+mCsjKMKgH9HdM5+52IAt6S/sFp0jZ9bmrBP9F5AZGvlfDUAoijVmzXK65Pxee4XMYvm3oCxlUTuf0JE9O5VDtYoAfd0mLlZKWo6e6Vboc21R4p/p5Tf1RladnNLg/w2/086L+72qmrhEN9ojr5HZeDLKJZ3b9lBYYyOUjcWX0mCtn7eiys1yUwFy4CqMooHJUwfErlmhwbRHAGC4gaz0cI6vs0nVNhO2lxrkoSTkYB5fN4nOsdAOK9LIgbBIX+g5YpNHRgWyJjPx0PxPL27MmupOyWMxbV+6X8Qcb0o56JIyrPwgUFhZZ+NfOSfQjF6jxxI3WZ03weEZawf4LOYI7MQ8c6IRQaKgD/4jN4NG4lbyDgsUzuZ9SaF//E1G2sDYVIfJYbkatjAxvrH9IiCgMpR6iXWQIrmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199018)(186003)(82960400001)(6486002)(478600001)(316002)(38100700002)(86362001)(110136005)(6506007)(6666004)(83380400001)(6512007)(41300700001)(26005)(9686003)(44832011)(8936002)(5660300002)(66946007)(4326008)(66476007)(2906002)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1ijNX3AnGcIo5/CjSBJM7cCKgEvSOmzIeyMkC9hkRSzbfBLV5WAqdjFrPcl?=
 =?us-ascii?Q?XYvO2A4pQQvpIRyg461k9/x3mRAgJ4EnBdKfvWbjY6tDlfqiLQlekvcxWeQe?=
 =?us-ascii?Q?PRoy/hPrvTCIC7iQcgOrHeUH9mrNk4+OCThf6H8VSLNBTSIdf1SQzTesySXB?=
 =?us-ascii?Q?m5UMCxbJtCzs47gtx/VXbl55jC2NZ4sSXPE5F3ueQz871x5nFvz96RtssVbP?=
 =?us-ascii?Q?d3GtFtCMXGwmItg7xZXgDuyUuSSsRREamvUHYjFCu+Yep4DiL80J9Wjy6fgi?=
 =?us-ascii?Q?buhuw/w+ZE4cie0yyZZuPW4qC+SdgWlo+MI76+3dy9F1qh2qewElYZ6jYY5j?=
 =?us-ascii?Q?59S8K9NROeKfrFs+uCwSkz2rQG9uQWvnbma2A9ElKDp7upU8nNsT/SPY52Zv?=
 =?us-ascii?Q?Wdl8cjUxAz+BYn3VwH1VANIQxXfi1R51SI364fUow56tSHnHbuVo7YHO2g8o?=
 =?us-ascii?Q?JCcOPKNuQI+fhf0uag1Iiwq1qYVBhWGUgua4Fl/F4LuF2AjOCLVT5Exww3sQ?=
 =?us-ascii?Q?6gvZ5U1AtV/9p2HSzhCr1Q/Fzud2HJQPOXzc1iuvnXiaz4btsNFZw/0EyVSp?=
 =?us-ascii?Q?aUZS2/3D7NwRoakGz4KPUzINmwVjpo8I8z5OGcV3/p8E6sdiQWgRKEr8O6Qs?=
 =?us-ascii?Q?9YnuYW+tWQ1mFv3AunQbgPS0+6RwG5gy8s/bTVT4L6Im9i+d0M3dinA6E4Ta?=
 =?us-ascii?Q?Bj9lit0yxhq67rRIKARJhdwcICk4bj8aGpxjUru6L4pBNRoegP1Tur/21N5T?=
 =?us-ascii?Q?hXsewfqKQHoGxOdCCeGyJi5d8Gjay7FcqhecqfQlfQpABIstynkqccmz8+Cw?=
 =?us-ascii?Q?8rr1Y1E5DfK9yAMPUrs24SyQvVSk0+K2Eiup1fhd2kMZzwSW49QSLnTYZys2?=
 =?us-ascii?Q?BhkEkQPPmz+7NMWKHzE3AMNxvEFKCrwgja7P8WpNEwCOthYm2umMFrBmzb31?=
 =?us-ascii?Q?c3ivWFakQKDHLydOOb1t+JT+SYNSp3JxycbswVemd7HiXUze+OqAXK2FfQyv?=
 =?us-ascii?Q?gXqIp02u5k4h3M8Cxloi2bQv8ElIPz7K1pGH0Ek2TyT8vLJ16WJsOGEwsC98?=
 =?us-ascii?Q?oOgWtwQcvfcILkT3T9P1nvIKjHglIbY6gTMJHItgkI4Z4pX4WU5XwAJLIaRh?=
 =?us-ascii?Q?YKnfZtcen2Os55ZmwWG1nG0xSDejXKqY18d3oytF+dZByPFftmHOMO0anh9l?=
 =?us-ascii?Q?8Lai0fb5BCs5vlV8ffPPyjLzMwY0msDkqy3XqVGVb0/J70md2ulZJJBHX5/t?=
 =?us-ascii?Q?kVMHbO6qz3jgfzTddB0mbcmI3pYAlK5gy3Wvzlbkx+NwoFX307z4wnCoBvNC?=
 =?us-ascii?Q?Zt87QCHCAvdcTvmpUfOrTocadNBXAoCv7v2Z0zDBs1dO1/ocpJc6CRf/9zGB?=
 =?us-ascii?Q?TiNNfCAvse6bDCRbQwJB7mEn7szJrWQKoWqfbbBePGpCg1Y1UnlEdWIkunYn?=
 =?us-ascii?Q?n2UXCoTbB86ZJo+tOlR6kjYYIua07/NlX/2wu+FtVowjM9TTHmNRqRiiBWGn?=
 =?us-ascii?Q?JQj434CU23TEL2JhKhBuVyiQ+1Q0DGheicxkZdOf2Hc49pAU4M5YMyX+XNoD?=
 =?us-ascii?Q?uybB19jlqTdJWm2zxqmrGCTsYW7p/ArvVJhw1D7X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e4733b-e559-4e7f-1a73-08db24147b89
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 22:44:19.7178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDq2X10A8zqnox8eFpgefTDowQtpKoAAyiXdr7u3LHkB3Nt3k2f20c+xoWYPCS4hZLagUSFr0XrNs27BM3APQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the poison
> address(es) logged in a cxl_poison trace event. Since the mapping
> of DPAs (device physical addresses) to a region can change, the
> kernel must provide this information at the time the poison list
> is read. The event informs user space that at event <timestamp>
> this <region> mapped to this <DPA>, which is poisoned.
> 
> The cxl_poison trace event is already wired up to log the region
> name and uuid if it receives param 'struct cxl_region'.
> 
> In order to provide that cxl_region, add another method for gathering
> poison - by committed endpoint decoder mappings. This method is only
> available with CONFIG_CXL_REGION and is only used if a region actually
> maps the memdev where poison is being read. After the poison list is
> read for all the mapped resources, poison is read for the unmapped
> resources, and those events are logged without the region info.
> 
> Mixed mode decoders are not currently supported in Linux. Add a debug
> message to the poison request path. That will serve as an alert that
> poison list retrieval needs to add support for mixed mode.
> 
> The default method remains: read the poison by memdev resource.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/core.h   |  5 ++
>  drivers/cxl/core/memdev.c | 17 ++++++-
>  drivers/cxl/core/region.c | 96 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index cde475e13216..4f507cb85926 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
>  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
>  int cxl_region_init(void);
>  void cxl_region_exit(void);
> +int cxl_get_poison_by_endpoint(struct device *dev, void *data);
>  #else
> +static inline int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> +{
> +	return 0;
> +}
>  static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ea996057815e..5e65818d2171 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -139,14 +139,29 @@ static ssize_t trigger_poison_list_store(struct device *dev,
>  					 const char *buf, size_t len)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_port *port;
>  	bool trigger;
>  	int rc;
>  
>  	if (kstrtobool(buf, &trigger) || !trigger)
>  		return -EINVAL;
>  
> +	port = dev_get_drvdata(&cxlmd->dev);
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
>  	down_read(&cxl_dpa_rwsem);
> -	rc = cxl_get_poison_by_memdev(cxlmd);
> +	if (port->commit_end == -1) {
> +		/* No regions mapped to this memdev */
> +		rc = cxl_get_poison_by_memdev(cxlmd);
> +	} else {
> +		/* Regions mapped, collect poison by endpoint */
> +		rc = device_for_each_child(&port->dev, port,
> +					   cxl_get_poison_by_endpoint);
> +		if (rc == 1)
> +			rc = 0;
> +	}
> +
>  	up_read(&cxl_dpa_rwsem);
>  
>  	return rc ? rc : len;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..1a558adfe32d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2213,6 +2213,102 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
>  
> +int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port = data;
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev *cxlmd;
> +	u64 offset, length;
> +	int rc = 0;
> +
> +	down_read(&cxl_dpa_rwsem);
> +
> +	if (!is_endpoint_decoder(dev))
> +		goto out;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		goto out;
> +
> +	/*
> +	 * Regions are only created with single mode decoders: pmem or ram.
> +	 * Linux does not currently support mixed mode decoders. This means
> +	 * that reading poison per endpoint decoder adheres to the spec
> +	 * requirement that poison reads of pmem and ram must be separated.
> +	 * CXL 3.0 Spec 8.2.9.8.4.1
> +	 *
> +	 * Watch for future support of mixed with a dev_dbg() msg.
> +	 */
> +	if (cxled->mode == CXL_DECODER_MIXED) {
> +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> +		goto out;
> +	}
> +
> +	cxlmd = cxled_to_memdev(cxled);
> +	if (cxled->skip) {
> +		offset = cxled->dpa_res->start - cxled->skip;
> +		length = cxled->skip;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +			rc = 0;
> +		if (rc)
> +			goto out;
> +	}
> +
> +	offset = cxled->dpa_res->start;
> +	length = cxled->dpa_res->end - offset + 1;
> +	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> +	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +		rc = 0;
> +	if (rc)
> +		goto out;
> +
> +	/* Iterate until commit_end is reached */
> +	if (cxled->cxld.id < port->commit_end)
> +		goto out;
> +
> +	/*
> +	 * Reach here with the last committed decoder only.
> +	 * Knowing that PMEM must always follow RAM, get poison
> +	 * for unmapped ranges based on the last decoder's mode:
> +	 *	ram: scan remains of ram range, then scan for pmem
> +	 *	pmem: scan remains of pmem range
> +	 */
> +	cxlds = cxlmd->cxlds;

I wonder if this is the best place to put this final logic vs in
trigger_poison_list_store()?

I see that you need that last cxled info...  So I think it is probably ok.
But it was odd trying to understand here.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +
> +	if (cxled->mode == CXL_DECODER_RAM) {
> +		offset = cxled->dpa_res->end + 1;
> +		length = resource_size(&cxlds->ram_res) - offset;
> +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +		if (rc == -EFAULT)
> +			rc = 0;
> +		if (rc)
> +			goto out;
> +	}
> +	if (cxled->mode == CXL_DECODER_PMEM) {
> +		offset = cxled->dpa_res->end + 1;
> +		length = resource_size(&cxlds->dpa_res) - offset;
> +		if (!length) {
> +			rc = 1;
> +			goto out;
> +		}
> +	} else if (resource_size(&cxlds->pmem_res)) {
> +		offset = cxlds->pmem_res.start;
> +		length = resource_size(&cxlds->pmem_res);
> +	} else {
> +		rc = 1;
> +		goto out;
> +	}
> +	/* Final get poison call. Return rc or 1 to stop iteration. */
> +	rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> +	if (!rc)
> +		rc = 1;
> +out:
> +	up_read(&cxl_dpa_rwsem);
> +	return rc;
> +}
> +
>  static struct lock_class_key cxl_pmem_region_key;
>  
>  static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> -- 
> 2.37.3
> 


