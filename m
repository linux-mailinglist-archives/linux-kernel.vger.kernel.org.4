Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E857D60D37D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiJYSWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 14:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiJYSV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:21:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0794DDD8B2;
        Tue, 25 Oct 2022 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666722119; x=1698258119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TDsSEHX7B0fOGYJ0P9Q6rdmAU44PeJJwtKtEivXPLdc=;
  b=Z9Y90hUK0E3492Y2xDF5D7SyEhLA/qe6K42F1jbJx+IpvfhHgOcHL/5L
   aKKnJ4GiRhhHT8BcAigxWp+4s/9XsjGXLaOziPROliytUsJ0W79K82Tyd
   5s4CurffG7LlQjwZg36ZR9bLDi1Hr/UmQwCAEM8UwQJ2BIfTfvBAWCq9x
   jdRa26cfy60oJTp00A/LeVzaJ4Wsl42p+Ddh2le+GLQIiD11GUsWkhB0T
   r+K1LGvkyBzGujY5ldkaY8fS78V2rhzZxxmBA7b2hhj8oTIARMJzL/8bP
   GaAxhIE9YkbnnzR7ewR/jk6lDUGMiPucmmhRRuVjFmrX+beBPcDEbCTqr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="309445681"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="309445681"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 11:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="695064382"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="695064382"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2022 11:21:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:21:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 11:21:49 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 11:21:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=db63pgOb9xDwhyEwnY2pu4TZfKVXZ1o3smQcon2garXJhM+j0VNrmjNaxOyCIxREEn9w137wMkdoyQIggX/5WQsbXfyEOHkutjB/37V8uC3nkc08FW0tvtZGiPuxXsreCCa7ZHuLZUfQ9Kk9J2YU49U1Qd/JDNkPEeLRcbb2RKNRi+0qr+vhAqnryrpoZaIeCBdv22tfg82N/fr4yDK13Gi3kqo6TLvwpRizg1/fqirqi2hAVdnhr0YvMXyUdXqXgyEtVfI+u5zNml2hTELdvT460HkWCXXr9ezDTquYz3JgkdI0pW4ZWKCNcijuZDBgpfBd8zNKmOPlNgrGpVoDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSTyAIXqJO0R/4z+owMdJdWKeSSGpWtEqb35Qq4IUus=;
 b=boqyMqTBpouXsn/BmhUuG466QjRCx3ObzSty1+PkmHOqkW2PuSJJvY8qTriarbr9Vp6esGOOAMo37M9DXPUGlJ+5syn/vb/A0Fg+41BfemeeP7IW47SaAJbTn83DJW2YKidjdI+VIgGUh98NxEh9QXug03NqkJrXnl80KVkxqWjs1Hamt7xeEx0P59Jt9evLV4slXy8IUb41sXKnSSdRijHpI6AhYHHr00eb87IXnis8/XsRLD9n7Ebrzjq5Zp+NQujbZia244K/tg6m5GKoeHmiKts9qVwsLGUL0QQ9TcqmNuyWBUJcwukoghvbarHIqTSZpOltCOl5RMhP8X+vQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB4990.namprd11.prod.outlook.com
 (2603:10b6:a03:2d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 18:21:46 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Tue, 25 Oct
 2022 18:21:46 +0000
Date:   Tue, 25 Oct 2022 11:21:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <Terry.Bowman@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: Re: [PATCH 2/5] cxl/pci: Discover and cache pointer to RCD dport's
 PCIe AER capability
Message-ID: <6358293722b51_4da329420@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-3-terry.bowman@amd.com>
 <6354648d9b004_141929463@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <a65a2259-9835-bb12-5856-8e695b194191@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a65a2259-9835-bb12-5856-8e695b194191@amd.com>
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB4990:EE_
X-MS-Office365-Filtering-Correlation-Id: e41d16c5-208b-4149-5f38-08dab6b5c66e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imBHrMV7T4rCwduBBD0GiCSMufDdXF++FxcRjeCRQJvXjK+8DN7yhAE5FauC1BWvkHkU8Eq3MnSekH6EbiKVgX8s8ORYuWVekwet63tm41epjcog3g5Cv29DZB6kaftlywadWTux18ypM+CZ43gGZQ4MZUmY9Oq8UaacKGQMkME/kUQlEwtIscrRPEPKLpCVo+BhcjLtuwcMvUWnhTfByRNlv/pKg8+r2q0O+xMMkgUPSL51uHO08UW5p7tGQE1Ef9UDy5IleYEJIa/vs2y+wsZjY4c+1Nykmq3JhaCIAJmmp4EySBHUdIcw0ea9PUlIN/E4zWrEtue+omBTpYVjgAB43Gtd+IGzTcSmkLRVOnP8w0bJVF1maPbc+MG9KJqIe05S2W17NfDcjku6FM8LLVMN4zKISOxciOdhSbKA4nTq7JwOVc28c23kol3Os75sqlk6P43UXyuu9RqvJX/dxrcVfhkRFudgnWanbdOi+M96DsmkthN+6KrT4XNt8KGj1uSyeyRJjKCmK667gD12FyOdl2nLmb9epg/NZPnlSUllW/xyjNRsyr0seP/+wsoRT/7ApHBrDX7lMj0niOnUUo105Pa3gjIMI3I2dse1LL4d+nxgDhf/2ZA2wXO/MPkqY8xIWVmNkFXpLGn59eHWGDjIKWeckrltvEvaIrJpGyJsZtdSEfTljMsH3bhE1RNlHuOK5q/cOrteIrccoWKNaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(38100700002)(82960400001)(41300700001)(4326008)(8676002)(6486002)(86362001)(83380400001)(186003)(478600001)(2906002)(6666004)(316002)(8936002)(7416002)(9686003)(5660300002)(66946007)(26005)(6506007)(6512007)(110136005)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wiQYKzAZ8jyt5iu7TI9HQBiaiHjb3G0QmiCYpFJuSq3qqi7wcp7DevbBn4iB?=
 =?us-ascii?Q?g3k9EjobXON7Zbo2zRLJOdUBiHExkatAdtkN77KQjeKJna7zFHGQ8Cc0Zn4L?=
 =?us-ascii?Q?Zg3DJW5qGKkaKLDqbGe5m0AdloAlB72W+WjnIKDj4OmAqSO6FlnqWyPzwqFo?=
 =?us-ascii?Q?5lqQO9iPV6sfBB7jV3Wn4HgY+S30Z8sMC6QuPXOKrtTmH5jKmHVwVEuteptR?=
 =?us-ascii?Q?J7Eq8wJAbrPR332T9Q8hJCQFwwjC+7YlyWQjSFrcMnSn+fbydyPszA+Lh3rN?=
 =?us-ascii?Q?FF/8QGdvgOPs1eGo1UOKT08VIcTJJg7hD/05PGehhwzutqL6+/yB4FNP1jiT?=
 =?us-ascii?Q?VIgmhGsGUJJOTklU273qcpZXd3e9ezWZoeL0UI7H3himJzAhgXCfaYuLd2mS?=
 =?us-ascii?Q?WGAFPzqPF625/Y17/pW+w1svttrOiyKKbYpHb2Kh2tlMeCKyiTKBDSg65rgV?=
 =?us-ascii?Q?3Ag4T6p8+UaeE1PrQ9g0FN4T+4WDlWsycTF7g/0uEIewPUlm/2NDGN6TLUbF?=
 =?us-ascii?Q?zT79Rrrs/9m2zKzHaLhs3+19gyfW6nstCDZm9Mdgi8P1eibGsnOM0nJclYPN?=
 =?us-ascii?Q?IWQc1yc3oFsMzVFaLqZIKWGQLjqYU5Jl/n7GfeEhhRf846pZ7j24r79TjADZ?=
 =?us-ascii?Q?0asXbeCGboGGYF7fNHzOt8Il5cLL8jmfGRhwpdE1FDQZWGr2PbGaKXs2YosD?=
 =?us-ascii?Q?J6nbkYIU1rK81baoaFzoCJEsBjWm6NzoGNuCXw9lorwlul4I0ClR5bKFb/Gw?=
 =?us-ascii?Q?J+e/G9dQdB1quMiIIqESGe6WK72LOK0QbR21/wbyLBerqi90dpzldhV8ty3S?=
 =?us-ascii?Q?yoLfJPXhL3LnnA9RY+QGvvJdEy20M9JLZjagfZ7q3m32AVYUUTMSBY67y5zB?=
 =?us-ascii?Q?ygCdhxi6dGEOw5UOjgXL5a7rqVSbYBK1yJTFm/mBmt+1IgADUinLBIAhyI38?=
 =?us-ascii?Q?/EaWRZcQuxg7GkHJcd20QTRFgOYt6sxoOrJNTzC/E8RjJoFYreH4Nru9mi1u?=
 =?us-ascii?Q?7zhDd7QM+ZfBr1UV+lh8J5RKC1KmPVGHwO9B0JxwM8X0KgxAREx3PrSMryJ7?=
 =?us-ascii?Q?KX84cr5CdJayUoepXVngaVvFOA3WhKUlVHAWjzJzk/jHC7Duo+9mcpoygEsl?=
 =?us-ascii?Q?kNu2vtmQdvTSS3CUNDZsD/yg0lYEpg6pua1stlhz2Dj+gfTgo+eM+Fg9mGW1?=
 =?us-ascii?Q?YWfbEdztrGkrb6crDPXOszFf6xK6RZUM+Pm2IsWG2ZoyASjBea6QIMmz5LGB?=
 =?us-ascii?Q?fNjEMZpwOa9kH9kbnRMK/CRd9Oyrxq1xkHBp4KlYHch6bYpl/HgZrWNxmdli?=
 =?us-ascii?Q?pFpvfveoyafeejB93nIOvqOluNNvH+EyD/i5CCguTya3BkFf8itsMSuzdlwc?=
 =?us-ascii?Q?qiyE3iye1iIMgAZDmDTcIHimAHuGXeJdtGNm4yGsA62uoANNJa2T0LjTjwZB?=
 =?us-ascii?Q?R7xxN8rBNLWyQ/fewBWKg8Ty+BY+ZtNcJb/NGlq3d8I5TNmira0lwDR8lM6u?=
 =?us-ascii?Q?gfG/Yf5vGnTy/utzeckRCzOxXyZg2cgohRXhnkKThVq/SNI1/4CU0iK1uBnA?=
 =?us-ascii?Q?JkcsKY2neT1AYZRJ/Qxcn2agdL43JSCSaNDLtw0GYJMplCEmB/6BlBAA0CNP?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e41d16c5-208b-4149-5f38-08dab6b5c66e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:21:46.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEnjPrLIU1pVV2qADRivK4eIPiJ1jZpZjsVNc/oZ8mflvXMkbzgVuLifz3IH/8h9AvoZyYVNpW71EIgACiUZWPcNsC7Nf8JDxYd0o59X5O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4990
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
[..]
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index f680450f0b16..b42f4759743b 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -499,12 +499,19 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
> >   * @port_id: unique hardware identifier for dport in decoder target list
> >   * @component_reg_phys: downstream port component registers
> >   * @port: reference to cxl_port that contains this downstream port
> > + * @is_rch: enable RCH vs VH enumeration (see CXL 3.0 9.11.8)
> >   */
> >  struct cxl_dport {
> >         struct device *dport;
> >         int port_id;
> >         resource_size_t component_reg_phys;
> >         struct cxl_port *port;
> > +       bool is_rch;
> > +};
> > +
> > +struct cxl_rch_dport {
> > +       struct cxl_dport dport;
> > +       resource_size_t rcrb_phys;
> >  };
> >  
> 
> The same is needed for uport as well, correct ?

Hmm, I don't think there are any 'struct cxl_port' instances that need
an RCH flag in the Linux CXL topology model.  That was the feedback /
realization that Dave and I came to while reviewing Robert's RCH series.
In the RCH case the ACPI0016 host-bridge houses a
root-complex-integrated endpoint that is a peer of the
downstream-PCI-root-ports in the bridge. The topology ends up looking
like this:

# cxl list -BEMPTu
{
  "bus":"root0",
  "provider":"ACPI.CXL",
  "nr_dports":1,
  "dports":[
    {
      "dport":"pci0000:38",
      "id":"0x31"
    }
  ],
  "endpoints:root0":[
    {
      "endpoint":"endpoint1",
      "host":"mem0",
      "depth":1,
      "memdev":{
        "memdev":"mem0",
        "pmem_size":0,
        "ram_size":"16.00 GiB (17.18 GB)",
        "serial":"0",
        "numa_node":0,
        "host":"0000:38:00.0"
      }
    }
  ]
}

Notice that the logical ACPI0017 (CXL root) device lists the ACPI0016
device (associated with pci0000:38) as a 'struct cxl_dport'. The
endpoint is then connected to that dport. There are no intervening
'struct cxl_port' instances between the root0 and endpoint1 like there
would be in the CXL VH case.

Now, the problem is that there is no viable object that can drive access
to the upstream port component registers. It may be the case that when
the cxl_port driver attaches to an endpoint port that the endpoint port
driver maps both the upstream and downstream hardware-port registers for
the purposes of conveying RAS information.

> >  /**
> > 
> > Then, when cxl_mem notices that the memdev is being produced by an
> > RCIEP, it can skip devm_cxl_enumerate_ports() and jump straight to
> > cxl_mem_find_port(). That will return this dport with the rcrb base
> > where cxl_mem can arrange the AER handling. Likely we will need some
> > notification mechanism to route Root Complex AER events to cxl_acpi,
> > cxl_pci, and/or cxl_mem to optionally add the CXL RAS data to the log.
> > 
> Isn't the notification mechanism through the AER interrupt processing? 
> I will have more related comments in patch 3/5.

In this case I was talking about notifying the cxl_mem driver and/or the
cxl_port driver that it needs to decorate an AER event with more
object-local information.
