Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B8D63FE1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiLBC3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiLBC3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:29:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB8C86A7;
        Thu,  1 Dec 2022 18:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669948175; x=1701484175;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W65lF4i0guqgpOPoopkCtceSvzvQzMC7ZpSg3vS5noU=;
  b=TOpn8Hl0LFwuKbhzZSj9K3hLqd8vX0/VaoZP0JESjiPLfwsWFr0ZELdZ
   lsry/kUkuG7iaXil0sFzocjR7aKMjChbz7O8lXzq35cJNgwgD+K1Be36I
   qFVv60njNKoBexh2odlIWf4IyXiqUM/6L+DyGAAOTuBCtNicBYmTM8MZX
   HM/ICblDsU5+6SgqK+9JfjVmooEsfjoBrmXFszaBdnIVufFIDd1GNUpGd
   qFxBjfFgk0PldfU3BYzykpkQyqq5qE2XWGUus279OnNPuunzbFJMIRW02
   TbUyAWqTwkc70TbIVAWZEV9EJeIMbDI7IiEGks1q9MXr2/R7BVbTXiGUH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="402131760"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="402131760"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:29:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="675674239"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="675674239"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2022 18:29:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 18:29:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 18:29:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 18:29:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj4SVi9c6GWKjMFLH8Uso7V76Hh8HpN6YaC5pINYJvZdB2lzprkG1SHN3TXWpdbykKICDV8EEdVXf4uGbn7kz6tDw0PuKDpnutRUP9YxTTId10T168fIQX7ooVUK1nkIrmZgUnRL1eSGdxsdixmsHwYZEYwHExQ0UmeqlMEr/piix8/Hq4aWdNM/D9WcVhEP4e0ij4nNFmtyPIjypQaJr9RPaPJgJmLEZCP9jYlBpM2ftcy+eQJFn8pLOd+9DaKtg65JqWxHutitJl152th+vEd3AA4PFwFjPATPWs61n7YyALfckP47mMjWkqW8RokU/xzChVsDE2hMfEhZ3s6qKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzcV3ib/FmY+PvMtw2WIVirU+IM8eo6XCEMPqBF1920=;
 b=EaHAEjEFiAaMyDFqk1aw/mtx2uVQflGqa/0MIrJkyDxWyzpNyH0kUIKnLEn1RGW+94nFv1EqRWOXk6a1/Z0/R4ArMTe6jKFZZj2gn1eWRlG1nI+5k2FUIQ9O/Z14pf0QDdFwLFr+4ate3FGF9lKrxGwblSlfkLoEviMa9GNLwwFQMXDGqhQkQRkuzcJfbvVVD+9xmZBSv/i9D9CnEbOWX4kw3iMuJpnWlYMd9YsDURh+UFZov0QYk1qO5MjPHKVupcttjvlJYT9WEtBGEalXZEDO2fblyP3VFAxnkMgdM/K/AlWbyudP6NLBuUjRfKdPejmLTFo9UPKnE0PP7B5+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH8PR11MB7023.namprd11.prod.outlook.com
 (2603:10b6:510:221::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 02:29:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 02:29:23 +0000
Date:   Thu, 1 Dec 2022 18:29:20 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-4-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-4-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::11) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|PH8PR11MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef36c30-e8d9-4301-5d72-08dad40d060f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMLd8garnNdTPTTcD3o+b2Pvkf4rGYZd/vm2ZQFX9iZZuT/DHp8ud5eZv2wo3ozWeCwVr02ZX9fT9hCsatVdHbuOV6YXRP5hz6htDfyAvQsKJJfyLD13FIKqXhbJL5dJSeLrAZxjeZveYAPeVRyVuK12Z4MoXaTJJwi+xbiusX6FjujcAdU9dRKYxp1URZWUAGhm5Z4Gubh+oXx/XyJ9d6rwesNtUD32Lt8sFgIZlsvWCCvAkCWwNZTSKcQCFhRT89aptfv8jdMJIwk71Qzrl1huFVE3fxMeri1RomhQYXr09c4Z8enKrU0jnpNYnHmv2cebqQKVUCMCEHeDCC8g4+kZsKiETD2fDBvl8rZSwdPGjO5EHSIeXK2DgfHqGIRai8+RU0J0/E6eanCarp1I3WRggOQT2KCW8qrmpj46zu3g3Ll93lGxHMJ0h2EXPw2kbSMLFJDhrK7btxvodV7GmExp41PgSI51Gt6ZveRO8bdZ3HrY73idzLxX9bNbNHOzIAymGegrID+zK6n6kLKdd/m1FuxZRmeUh5Mc/3BI3N1V5WFdZPl+BOEpvU0CCZ+xFj9Pd0OROcGmZ4WK0Y9QJd9tOj7hu5cz/luoJc8cEZaQUJNoO2XN0ObmCuxJrD86iNr+lBXGuw29dTWjmgwjmL3i3EFud8S3b1QPF688BbMcL5O/wWmoq/QLZXmwZkKx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199015)(316002)(38100700002)(54906003)(82960400001)(66476007)(66556008)(8676002)(4326008)(66946007)(186003)(86362001)(6512007)(9686003)(26005)(83380400001)(6486002)(478600001)(6506007)(6200100001)(66899015)(2906002)(6862004)(8936002)(5660300002)(41300700001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Wtd+btYxxFYLPiII8ck/K8PGrocr4DQZfL1gF1201SUVxdtPvVY3pHHj6r1?=
 =?us-ascii?Q?7Sj+w1o+8LpZd4NOUVM0aiqSkctXANHH0walk+u0tbqyVg/58bVrahkSGMZv?=
 =?us-ascii?Q?HpRv/hqKpvDFlkPHORsyX24cqiTtWbYNAgsjh1BsVj6FwV3CUxfxPPQrCUZu?=
 =?us-ascii?Q?U6nDN3XF2QJLAQasnkOngWaO0Se580JsgXfZD7eOaQFedaA7vPLK7JtUrbGd?=
 =?us-ascii?Q?lGTO+J3sUkAxdugUJdXliddGhMj2vvaDIAT3j4zPgrs1Pqs7ROUWrNikqgVZ?=
 =?us-ascii?Q?TRjd0Ye512pnCZIolHjWHyTuCpQxv23IGCGUlqM6QG5TdoZG+C9pbraV17oO?=
 =?us-ascii?Q?43BDeA/LUggwddoxbZxVa1Sg+GAtSyfJ6wrk8K5VlTWu9DeanqK3hDGm7Vmy?=
 =?us-ascii?Q?CdWqQ4vXidCdJp1EloKGIpj7nilKF1qkqwLUku+1Z1u0+iJPDBIxRDjv7jCj?=
 =?us-ascii?Q?x+J9NY4qqeM44ruAgNwYx2RdHvvd7mR51CV8K1L/RuDmozpX3Pe07pwOsiRA?=
 =?us-ascii?Q?iELV5V8P3/McuaTbYYkRiFmAmw8KSzoqeGAfGBVr/hftcQi0y6bilE2oDHda?=
 =?us-ascii?Q?GJXwY9+bOF8JpXKKlBb874OyqmwXHVnmAPWALAhG0vQDCZoXkmfuxh5pDY0B?=
 =?us-ascii?Q?BDayggogefznru2Loj20g8nLaZ5gUWuPKBp/Y8ca1ZZAzRz7z+eQnviTTdWy?=
 =?us-ascii?Q?1uBXJnLpPYzbKUgyA1qVFjN/8DqK797vj7dmDP+zjUXTq6BjpyFkUUNhCC2A?=
 =?us-ascii?Q?KC9BDof1TeOYEOFhcu4W4eXx/Ezv7YtllONgKaI6zKL6P7BoaHE+sZhkNY6p?=
 =?us-ascii?Q?Ex/67lxEyinRLrwUNHY4e7PCX/46wS/JcCYJZrZ45pXGadsikFBCQBAuXpQp?=
 =?us-ascii?Q?bIyaIWZHiZSzhAGvn8PMDo5jwoda2kBm0sddfke5juLgrlRqLWGJyh9Omktt?=
 =?us-ascii?Q?bn9o77FWpzW1pxtwTGqPyB7roO6FnPKcYUT16stavwKWx01zDAANYBsbV8AD?=
 =?us-ascii?Q?AEJh9KhCbPKh1Rc4ZLKyAvKvHlqXPYTjHHURwAgt2xE8loXS2HYxUJzON8gf?=
 =?us-ascii?Q?fpJE5zkB+hr5U4Dnjx/Gm3RbYXN1eKe/hrDXHNRlGKaW4nF0s0t1jwv2Vkg9?=
 =?us-ascii?Q?F9Rd6rPSAWj0RWudWKq51FFELZTT5eHAShvHY0+u68Rrvh5noP9a8KwfAHe9?=
 =?us-ascii?Q?78Ak8WgTltwH3Tak38uK+n+P7Ap+gsqYORHJwhk/efeoHZydvLpLlOZwBrZv?=
 =?us-ascii?Q?TEdFAcEEdVm7FGGSZyYzOAHuKp5ETebw2K0GIN9u91SdS7KJb82iUfEQZksT?=
 =?us-ascii?Q?UgTzB+gmLc32iWJrMLcDjmYTiHeikifTccJIFS4knaUz4x0fk1xORDhbZuwW?=
 =?us-ascii?Q?/kfwr6znI92SY4n3hYgG7lTHsjfQTPw9vvv50v6fie8liBj4vKiHz59GCqDn?=
 =?us-ascii?Q?3vTZ2ZO/cUF8sb1L8L2JHiQEi5P9kq8Et6tKJKYPDhcK4iiopOJ7Mpa/LouN?=
 =?us-ascii?Q?eLVfDF1/VY3txEPui7MxwNgfc1Bl6TbjarfxnLov7RD8Fqq0msF5zTgNPf8T?=
 =?us-ascii?Q?xs02r0oHQVS1MtKzXBWE9oVOSPJKdf+pRZXmXUMYpVr8KYCHvojIszqVBEJ6?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef36c30-e8d9-4301-5d72-08dad40d060f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 02:29:22.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed98PsjiLloTZU8TfOCFtX96HB02F1x3xBoAr819UqLwi/7SxgOb0ZxschmxSAISW+E8M8P6xP9ohHpbMOtWk+6kef4hQIFzJKy4uAO9CRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7023
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> command.  After an event record is read it needs to be cleared from the
> event log.
> 
> Implement cxl_clear_event_record() to clear all record retrieved from
> the device.
> 
> Each record is cleared explicitly.  A clear all bit is specified but
> events could arrive between a get and any final clear all operation.
> This means events would be missed.
> Therefore each event is cleared specifically.

Note that the spec has a better reason for why Clear All has limited
usage:

"Clear All Events is only allowed when the Event Log has overflowed;
otherwise, the device shall return Invalid Input."

Will need to wait and see if we need that to keep pace with a device
with a high event frequency.

> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V1:
> 	Clear Event Record allows for u8 handles while Get Event Record
> 	allows for u16 records to be returned.  Based on Jonathan's
> 	feedback; allow for all event records to be handled in this
> 	clear.  Which means a double loop with potentially multiple
> 	Clear Event payloads being sent to clear all events sent.
> 
> Changes from RFC:
> 	Jonathan
> 		Clean up init of payload and use return code.
> 		Also report any error to clear the event.
> 		s/v3.0/rev 3.0
> ---
>  drivers/cxl/core/mbox.c      | 61 +++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h         | 14 +++++++++
>  include/uapi/linux/cxl_mem.h |  1 +
>  3 files changed, 69 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 70b681027a3d..076a3df0ba38 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -52,6 +52,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  #endif
>  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
>  	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(CLEAR_EVENT_RECORD, CXL_VARIABLE_PAYLOAD, 0, 0),
>  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
>  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
>  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> @@ -708,6 +709,42 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> +				  enum cxl_event_log_type log,
> +				  struct cxl_get_event_payload *get_pl,
> +				  u16 total)
> +{
> +	struct cxl_mbox_clear_event_payload payload = {
> +		.event_log = log,
> +	};
> +	int cnt;
> +
> +	/*
> +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> +	 * Record can return up to 0xffff records.
> +	 */
> +	for (cnt = 0; cnt < total; /* cnt incremented internally */) {
> +		u8 nr_recs = min_t(u8, (total - cnt),
> +				   CXL_CLEAR_EVENT_MAX_HANDLES);

This seems overly complicated. @total is a duplicate of
@get_pl->record_count, and the 2 loops feel like it could be cut
down to one.

> +		int i, rc;
> +
> +		for (i = 0; i < nr_recs; i++, cnt++) {
> +			payload.handle[i] = get_pl->records[cnt].hdr.handle;
> +			dev_dbg(cxlds->dev, "Event log '%s': Clearning %u\n",

While I do think this operation is a mix of clearing and cleaning event
records, I don't think "Clearning" is a word.

> +				cxl_event_log_type_str(log),
> +				le16_to_cpu(payload.handle[i]));
> +		}
> +		payload.nr_recs = nr_recs;
> +
> +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> +				       &payload, sizeof(payload), NULL, 0);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -732,13 +769,22 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  		}
>  
>  		nr_rec = le16_to_cpu(payload->record_count);
> -		if (trace_cxl_generic_event_enabled()) {
> +		if (nr_rec > 0) {
>  			int i;
>  
> -			for (i = 0; i < nr_rec; i++)
> -				trace_cxl_generic_event(dev_name(cxlds->dev),
> -							type,
> -							&payload->records[i]);
> +			if (trace_cxl_generic_event_enabled()) {

Again, trace_cxl_generic_event_enabled() injects some awkward
formatting here to micro-optimize looping. Any performance benefit this
code might offer is likely offset by the extra human effort to read it.

> +				for (i = 0; i < nr_rec; i++)
> +					trace_cxl_generic_event(dev_name(cxlds->dev),
> +								type,
> +								&payload->records[i]);
> +			}
> +
> +			rc = cxl_clear_event_record(cxlds, type, payload, nr_rec);
> +			if (rc) {
> +				dev_err(cxlds->dev, "Event log '%s': Failed to clear events : %d",
> +					cxl_event_log_type_str(type), rc);
> +				return;
> +			}
>  		}
>  
>  		if (trace_cxl_overflow_enabled() &&
> @@ -780,10 +826,11 @@ static struct cxl_get_event_payload *alloc_event_buf(struct cxl_dev_state *cxlds
>   * cxl_mem_get_event_records - Get Event Records from the device
>   * @cxlds: The device data for the operation
>   *
> - * Retrieve all event records available on the device and report them as trace
> - * events.
> + * Retrieve all event records available on the device, report them as trace
> + * events, and clear them.
>   *
>   * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> + * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
>   */
>  void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
>  {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 55d57f5a64bc..1ae9962c5a06 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -261,6 +261,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> +	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> @@ -396,6 +397,19 @@ static inline const char *cxl_event_log_type_str(enum cxl_event_log_type type)
>  	return "<unknown>";
>  }
>  
> +/*
> + * Clear Event Records input payload
> + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> + */
> +#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
> +struct cxl_mbox_clear_event_payload {
> +	u8 event_log;		/* enum cxl_event_log_type */
> +	u8 clear_flags;
> +	u8 nr_recs;
> +	u8 reserved[3];
> +	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
> +};
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 70459be5bdd4..7c1ad8062792 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -25,6 +25,7 @@
>  	___C(RAW, "Raw device command"),                                  \
>  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
>  	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
> +	___C(CLEAR_EVENT_RECORD, "Clear Event Record"),                   \
>  	___C(GET_FW_INFO, "Get FW Info"),                                 \
>  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
>  	___C(GET_LSA, "Get Label Storage Area"),                          \

Same, "yikes" / "must be at the end of the enum" feedback.
