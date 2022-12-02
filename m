Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1029E64102C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiLBVr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiLBVrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:47:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF6F1CF3;
        Fri,  2 Dec 2022 13:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670017643; x=1701553643;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7C+n4Zi9fGjhcisUAlxko+pia4zBpAbH0BBOXT4y8sE=;
  b=Wy/Zkfmpsde0DHkvsvjI86cu9IcL/P46726ggp/CHySF2kvniq+0Kp9i
   j6CMxr+ZunXfdnAKS7K4I6kdFI7KawLdMskmEPkp26+6zQ0SPU/iSRZO7
   hDxS7ZwgJ/JT6SStCa9EZMXDMVRG0Hw7HvX8Y1OasVoM8INEVq+hk8yMp
   AHQZZlOrRk8ZarVItpgLaVB8yW9xleqSeRKlEEZ/ng2DahIebu3f6oTNr
   VGqx5h6er1/5BjtVH1qYrp8hBYFiAvG48LPd83AmgDCNS6cpfYXL15m8t
   O0jCfGvF8euCESVkfCXN/0KBu5WejAaNhQ/bYpSndQ9ey1jPRSFCA1vJ2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="317198489"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="317198489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 13:47:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="595588038"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="595588038"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2022 13:47:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 13:47:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 13:47:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 13:47:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe+tSy3yBcq66GOupzwQRR2KqwyqUGSn1C5Zr92P9q+6DXkN7QWqbFcOTQMQ1iCBDZ6OJ02lqy669bedvBCbe//1lUAK7Gy1jW+IYSED7IEz23Zw0rTF8uVuLEz1CUbKkQ615J2guxOjeoqPxOdiYl05dxBvsQwL5/hmJI34Cq8ne0F0qrifxRzmFdNXcUqKtceY8TO7UADRz5pKdIsywNZeLP/7rZei7D8P1ljVK9awdVZxNtsvTAAZxSjQbMlKCCGbDeZ3fU2HEW+woMTEtkF91eWYbcK1oVViMMDvLF90oj0K5w7JjfCJmm8fpO8leod5YKhbFkn2XR2kaKpEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v975Sav4hnpDSKs2Y3XRAhkHVaLQI8i6ta9BTlFy0mQ=;
 b=YCjiJ4dVEVfywKXyWsJahW+R86VuERmh94cvMs7pN4HIku+Z+Aa1kLl3YRmVRNWk1MPNNmMSQcRcnzIPr54n/OFHlW4hRTnKGjttHt0cGM0dJM2KY+AJnF4BVifyzCxgEslN1ZIB6cfTTt1Im+WiQ6TlxiyfU7lLFhkZjNI5960MMFJaum3gpcdRHl6L1PgafITE+rASv6QHb+psdZ3GWwjI7IoKMuhJOP0Re2aBZAqMCcDZn92XMi+IBPMWjC7qHIQH0/WPy1kN4YCIucTb2E7ybbeaK1n2cav3W4DUxvJW8IMbSXGFdCxR5TNyR5JO+tAbsITIr4h6DjhnNQ284A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5011.namprd11.prod.outlook.com (2603:10b6:303:6d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 21:47:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 21:47:19 +0000
Date:   Fri, 2 Dec 2022 13:47:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 02/11] cxl/mem: Implement Get Event Records command
Message-ID: <Y4pyYvbaSF5DpFGG@iweiny-desk3>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-3-ira.weiny@intel.com>
 <6389573ff3b7e_3cbe029460@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6389573ff3b7e_3cbe029460@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 874c9d68-db2d-4852-0807-08dad4aec8fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE8+XlZlGlh0hb4Yh9j6UdCruTeMKGBpqYX/LWzWiLzYOEkP9/nEOw2QzmH89IK5MR8/uV5fjx4Y+vAielJs53C3jYjwWqptZB/T+mzUyu9rSpHncyDmAI+1Tw+71gMkEqA7O9wt4xWMxKuELmRAHub8wjMBWInlysIE1N3qWCLj2kBlbccGCWpl0qTp8tKUiF+72MWXtKiLwV1ePsPoH22Hg93P5Vsww2C3r759yCoYiM57/JwF5PwvqHwUeSoewLAzWN8UBar9H2ioN5bICd3nXJPNazNqQLqjAwm65C2SOSYT2Fp3ezjfYDKM1c1BgzmBrSMxjN0m7Pr+khPeNZphAim2ea9KIQRk+gxqJFlG3tMyKi3rsCo5TbAzEUanP16E/Chlijpkc0IezXtfZHfQdnByIPePC5eIuge+dIVhzY2Zql4E7Me+Uryy2e9MfVCRvwLrH6RA6+3ZOgTZ2ussjB8ku7EIe0zDL+JbHv4AONj3JAdG9elHuRyP2gij9zh2IYSWz69BRW7j4rzrMKGCpHpXKRr51TlDDDqpETxbu9grHZAZjsDbcjRn4Trl9KLpg520EjkCasGw4RLgeKkSPjD2P2GAdiMUiVutBv76eZwgjNxHiARkxDrV3q0WFwLXRWeUbfkGUn3eSOf08pnIaebYdRXWAXCSfKW2jINnmftJqYym4fD9ixJ7e1yiZNKf6jUGyCvxX89uDjvrR4KQN8hkqEGF5PaEbh191FU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(86362001)(6486002)(966005)(478600001)(186003)(6506007)(26005)(6666004)(4326008)(6512007)(44832011)(30864003)(6862004)(316002)(8676002)(8936002)(66476007)(41300700001)(5660300002)(54906003)(66556008)(66946007)(6636002)(82960400001)(38100700002)(2906002)(9686003)(33716001)(83380400001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5c3wMmPHBljPwc0IrwmZ4g+2DFsX6eG7ZQrXaY1CaAKHw0IPwCgQbGfZUVc?=
 =?us-ascii?Q?MF8ZKoo8SAHwzZRkm8sJpBi9J0A3fi0903YChsmXI48qXGXUxJtVx2LaQBcH?=
 =?us-ascii?Q?/oDas9Bb33epYNnHXftLfao0FzNfyxGfJkXQRbSW5LlpDKkj28xjpMAXbnWM?=
 =?us-ascii?Q?btB9EybAPg8vRXqYHjzb1DsV36PG2Hu7ehm8TLn4TlKTtO8chSAUWL4S8Vua?=
 =?us-ascii?Q?CdEuelxFoj7glRCwq4MIjaOwCsTW9XsVI9FhSw7vokSGUyIxhji8YBIjFWEW?=
 =?us-ascii?Q?dqNolscNY69YWANis/vpuswHToTj86EqV3Xt0mPwGk/VuaCRerIlrAPG6aew?=
 =?us-ascii?Q?CwujTo3BuCtBRemgW/cXUpnthLfG4cSmkUXRut1ilA6JN8zr2YyzZPu9sy2D?=
 =?us-ascii?Q?npdOY49o9OrEEi+Iu4oMot7Kqrbzu8buCQ1RTAzrK5mm5Wzh3EuJH4AqOecz?=
 =?us-ascii?Q?I9TEObflPJdKnlPWut6EA0KmxvPnY3hvuDB3W3mdHcJi89ZZ5vB9H4Lb8j+v?=
 =?us-ascii?Q?IPq4JcP+RDQrA5Qcydp1J88EGEwwkAExCbufoCkr0UELQPAduU6MocXlFWM2?=
 =?us-ascii?Q?oOpHqjmJt/rFVmpn/EcJEEJy5gehc7IpAa0TT1eir4qwCkGunKRCLBn/PGgP?=
 =?us-ascii?Q?TM23Go+AtNnVzCDyf9/iJ41IjzzOpZJWoZ7vyKw7Bjk7VPMqbWQqEI1MiYdW?=
 =?us-ascii?Q?bgTyeIMz+QAQZVZ5EcrhV5LZktpvSvIswV6PW+AX36GDDwpQwPGdK6Ei67RN?=
 =?us-ascii?Q?S1oF+0mbu4QAgTltAYkmXwKAYmvG8HQ4S/TiVjco3xZ/6DrEgZWa68g+2wjO?=
 =?us-ascii?Q?fMXct3wSA3TDXt7MlCfZdWD2iFIxcCfy9+27keMHjt63JpQr0QepsNtQMMRc?=
 =?us-ascii?Q?ygb2V4ajrT67Uxh2AvGC10ymbhZiTcBkGC7ooNDISYzXl8EVaTE+HQdLafwK?=
 =?us-ascii?Q?pPixTgH9iAtSVG1psu2jAWJZhBqX3l1ViF2jYJcSKXzjzMEtwhDX7v8hALsa?=
 =?us-ascii?Q?lqYMmkq0jiw/mV6Ow58Eh+TM9Nuibv8+wCxnwkZyQMbMAfjLFDtWBo/NE3Wg?=
 =?us-ascii?Q?+hPFbMlvgbz7WmrStKdjBDVTxayoCdvKjRplWSX0StnMqITHzyXcIJl0Mx6k?=
 =?us-ascii?Q?qVZTi5VFNafVM7+JXr5IDHwPR/AMsN5W9lxSFUQZ6icckizVY5BETuLZl1WV?=
 =?us-ascii?Q?HZknz6I9Qx+Iq5NXU00+fzaio1FySsJ3cZsfyBmyfB1cfE7yFjUoST1Aw+TX?=
 =?us-ascii?Q?Db9PE1wuv+IBdZEaJnZcOLdmtggWxJGYpsVTywb4ujqQlThWwPIzRunHo6oV?=
 =?us-ascii?Q?dt6FVjrjAENXKXxq18yC7hlYC0g78z/A0FiErlaGvzOmlUFW0N7sbizbefWv?=
 =?us-ascii?Q?jmbh75y76cmLLQ5wVF6Tyt46udHfuIawz1yZt3H1lSHKb/kN/6Ef2gMfLCmI?=
 =?us-ascii?Q?/qG1HzwskIjZuYwLMJGi+kxfiZgYzMbeIDXwO9rcljP15u8eaBgcZ6ZI5qzu?=
 =?us-ascii?Q?HNZUie9Rzf2iaOfGfSlHlPxyvb5RXQPbwBW2rSbuBCpBlpn6OFqjWpZYN50K?=
 =?us-ascii?Q?obtEpoQk2yEB2RA7k34+GLWO47/hEnQ5kxmSMBX3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 874c9d68-db2d-4852-0807-08dad4aec8fb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 21:47:18.9201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCfimUUv3cxEyF1iqCZgG5kfR9X0MgKm+Dzn+6TlB5PiB4OqbTCTwEtdx4A662aMmK3pMlp1DYQpiqC5uaY2fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5011
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 05:39:12PM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 

[snip]

> >  
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/cxl.h>
> > +
> >  #include "core.h"
> >  
> >  static bool cxl_raw_allow_all;
> > @@ -48,6 +51,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> >  	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
> >  #endif
> >  	CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
> > +	CXL_CMD(GET_EVENT_RECORD, 1, CXL_VARIABLE_PAYLOAD, 0),
> >  	CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
> >  	CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
> >  	CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> 
> Similar to this patch:
> 
> https://lore.kernel.org/linux-cxl/166993221008.1995348.11651567302609703175.stgit@dwillia2-xfh.jf.intel.com/
> 
> CXL_MEM_COMMAND_ID_GET_EVENT_RECORD, should be added to the "always
> kernel" / cxlds->exclusive_cmds mask.

Done for all the commands.  I'll rebase as well before sending this out.

> 
> > @@ -704,6 +708,106 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
> > +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > +				    enum cxl_event_log_type type)
> > +{
> > +	struct cxl_get_event_payload *payload;
> > +	u16 nr_rec;
> > +
> > +	mutex_lock(&cxlds->event_buf_lock);
> > +
> > +	payload = cxlds->event_buf;
> > +
> > +	do {
> > +		u8 log_type = type;
> > +		int rc;
> > +
> > +		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_EVENT_RECORD,
> > +				       &log_type, sizeof(log_type),
> > +				       payload, cxlds->payload_size);
> > +		if (rc) {
> > +			dev_err(cxlds->dev, "Event log '%s': Failed to query event records : %d",
> > +				cxl_event_log_type_str(type), rc);
> > +			goto unlock_buffer;
> > +		}
> > +
> > +		nr_rec = le16_to_cpu(payload->record_count);
> > +		if (trace_cxl_generic_event_enabled()) {
> 
> This feels like a premature micro-optimization as none of this code is
> fast path and it is dwarfed by the cost of executing the mailbox
> command. I started with trying to reduce the 80 column collision
> pressure, but then stepped back even further and asked, why?

Because Steven told me to.  :-(  I should have been smarter than that.

> 
> > +			int i;
> > +
> > +			for (i = 0; i < nr_rec; i++)
> > +				trace_cxl_generic_event(dev_name(cxlds->dev),
> > +							type,
> > +							&payload->records[i]);
> 
> As far as I can tell trace_cxl_generic_event() always expects a
> device-name as its first argument. So why not enforce that with
> type-safety?  I.e. I think trace_cxl_generic_event() should take a
> "struct device *", not a string unless it is really the case that any
> old string will do as the first argument to the trace event. Otherwise
> the trace point can do "__string(dev_name, dev_name(dev))", and mandate
> that callers pass devices.

From a trace point view 'any old string' will do.  There was nothing else the
trace needed from struct device so I skipped it.

[snip]

> > +
> > +/**
> > + * cxl_mem_get_event_records - Get Event Records from the device
> > + * @cxlds: The device data for the operation
> > + *
> > + * Retrieve all event records available on the device and report them as trace
> > + * events.
> > + *
> > + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> > + */
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds)
> > +{
> > +	u32 status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> > +
> > +	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> > +
> > +	if (!cxlds->event_buf) {
> > +		cxlds->event_buf = alloc_event_buf(cxlds);
> > +		if (WARN_ON_ONCE(!cxlds->event_buf))
> > +			return;
> > +	}
> 
> What's the point of having an event_buf_lock if event_buf is reallocated
> every call?

This is only called on start up.

> 
> Just allocate event_buf once at the beginning of time during init if the
> device supports event log retrieval, and fail the driver load if that
> allocation fails. No runtime WARN() for memory allocation.

It was.  I'll make that more clear in the next series.

> 
> I notice this patch does not clear events, I trust that comes later in
> the series, but I think it belongs here to make this patch a complete
> standalone thought.

Squashed.  But it does make for a large patch.  Which I'm not a fan of for
review.  Lucky that now we have a lot of review on the parts.

> 
> > +	if (status & CXLDEV_EVENT_STATUS_INFO)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> > +	if (status & CXLDEV_EVENT_STATUS_WARN)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> > +	if (status & CXLDEV_EVENT_STATUS_FAIL)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> > +	if (status & CXLDEV_EVENT_STATUS_FATAL)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> 
> This retrieval order should be flipped. If there is a FATAL pending I
> expect a monitor wants that first and would be happy to parse the INFO
> later. I would go so far as to say that if the INFO logger is looping
> and a FATAL comes in the driver should get that out first before going
> back for more INFO logs. That would mean executing Clear Events and
> looping through the logs by priority until all the status bits fall
> silent inside cxl_mem_get_records_log().

I'll flip them.  And determine if this is really what we want to do for the
irq.

The issue with the irq handling calling a single function which checks all
status is that we may end up with some odd interrupts doing nothing depending
on racing etc.

A buffer per log would eliminate this to some extent if the message numbers are
not shared.  I don't doubt that vendors are unlikely to burn more than 1
message number so the irq may indeed be shared and serialized anyway.

For simplicity I'll throw them all together.

> 
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> > +
> >  /**
> >   * cxl_mem_get_partition_info - Get partition info
> >   * @cxlds: The device data for the operation
> > @@ -846,6 +950,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> >  	}
> >  
> >  	mutex_init(&cxlds->mbox_mutex);
> > +	mutex_init(&cxlds->event_buf_lock);
> >  	cxlds->dev = dev;
> >  
> >  	return cxlds;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index f680450f0b16..d4baae74cd97 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -132,6 +132,13 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
> >  #define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
> >  #define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
> >  
> > +/* CXL 3.0 8.2.8.3.1 Event Status Register */
> > +#define CXLDEV_DEV_EVENT_STATUS_OFFSET		0x00
> > +#define CXLDEV_EVENT_STATUS_INFO		BIT(0)
> > +#define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> > +#define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> > +#define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> > +
> >  /* CXL 2.0 8.2.8.4 Mailbox Registers */
> >  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
> >  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index cd35f43fedd4..55d57f5a64bc 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -4,6 +4,7 @@
> >  #define __CXL_MEM_H__
> >  #include <uapi/linux/cxl_mem.h>
> >  #include <linux/cdev.h>
> > +#include <linux/uuid.h>
> >  #include "cxl.h"
> >  
> >  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> > @@ -250,12 +251,16 @@ struct cxl_dev_state {
> >  
> >  	bool msi_enabled;
> >  
> > +	struct cxl_get_event_payload *event_buf;
> > +	struct mutex event_buf_lock;
> > +
> 
> Missing kdoc.

Got it from Jonathan.

> 
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> >  
> >  enum cxl_opcode {
> >  	CXL_MBOX_OP_INVALID		= 0x0000,
> >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > @@ -325,6 +330,72 @@ struct cxl_mbox_identify {
> >  	u8 qos_telemetry_caps;
> >  } __packed;
> >  
> > +/*
> > + * Common Event Record Format
> > + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> > + */
> > +struct cxl_event_record_hdr {
> > +	uuid_t id;
> > +	u8 length;
> > +	u8 flags[3];
> > +	__le16 handle;
> > +	__le16 related_handle;
> > +	__le64 timestamp;
> > +	u8 maint_op_class;
> > +	u8 reserved[0xf];
> 
> Nit, but lets not copy the spec here and just make all the field sizes
> decimal. It even saves a character to write 15 instead of 0xf, and @flags
> is also decimal.

Ok.

> 
> > +} __packed;
> > +
> > +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> > +struct cxl_event_record_raw {
> > +	struct cxl_event_record_hdr hdr;
> > +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> > +} __packed;
> > +
> > +/*
> > + * Get Event Records output payload
> > + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> > + */
> > +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> > +#define CXL_GET_EVENT_FLAG_MORE_RECORDS		BIT(1)
> > +struct cxl_get_event_payload {
> > +	u8 flags;
> > +	u8 reserved1;
> > +	__le16 overflow_err_count;
> > +	__le64 first_overflow_timestamp;
> > +	__le64 last_overflow_timestamp;
> > +	__le16 record_count;
> > +	u8 reserved2[0xa];
> 
> Same nit.

Done.

[snip]

> > +
> > +/* This part must be outside protection */
> > +#undef TRACE_INCLUDE_FILE
> > +#define TRACE_INCLUDE_FILE cxl
> > +#include <trace/define_trace.h>
> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index c71021a2a9ed..70459be5bdd4 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -24,6 +24,7 @@
> >  	___C(IDENTIFY, "Identify Command"),                               \
> >  	___C(RAW, "Raw device command"),                                  \
> >  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
> > +	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
> >  	___C(GET_FW_INFO, "Get FW Info"),                                 \
> >  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
> >  	___C(GET_LSA, "Get Label Storage Area"),                          \
> 
> Yikes, no, this is an enum. New commands need to come at the end
> otherwise different kernels will disagree about the command numbering.

Ooops sorry about that.  I somehow thought these were tied to the command
values.

Thanks, Changed for all the commands,

> Likely needs a comment here alerting future devs about the ABI breakage
> danger here.

Additional patch added.

Ira
