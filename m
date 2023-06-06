Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B4723622
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 06:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjFFESU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 00:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjFFESR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 00:18:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B05187;
        Mon,  5 Jun 2023 21:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686025096; x=1717561096;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n3YCE2NekWexwswEKL7gSJ9CXsZkQ0O0A13odkEPxp4=;
  b=lstWmdveSblFogr6sLzETEuAPuS5PKLdP29vFvKayXI9mri/g7Q6fFo+
   2bJgTjrC8xa5F/HFz7FXaaHQzllyt0RnLEYMKqZ2w0BqY0FJDYdXSV1vl
   k8KqvcRksYHUV5ZZkHRju3vRZqOGT7jm/xIHJZiozghwnCO5gdlkC94tS
   B3qga/kb0fdOnIUmiRgl24bxW+k6WHC/NP6+vgmqN7B2K7Z0tnXdYeFSe
   LPIsU5cE8zxBNQj6bYi4cK8+GLDEvThia5WBSqqVWxlY0WEkr54SVGCE3
   WlqwnwwFqUAAriY0HudW9n2orbDoAC09P0fb3/sRByb0iH4GED4f/l3OY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="354052382"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="354052382"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 21:18:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039025039"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="1039025039"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2023 21:18:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 21:18:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 21:18:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 21:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XowtzFxAnb9nxCwWi87NxJkYqwNdFC4ubOPpzSz3Y4tvuYxNUhgZSBMbrLQpe7+43HJzyd1vmkIrYrOdfXyfdmXIDChm+6zHaTmpx9FTwYqBSl/qECZmQ8U0j6fdPhEgqL2WxIJGsPBwdVoxjR3scAbIs00np4MAf7X8c1Mztc63+0hqmbjtt6T/L6GknPWKGPntHAFpX/xjM5Um/zD5DmoJxAZvwq70HOHsNT2xKlHGMfXduMo22bv1nYcSMJi6gvbSD0dbwPlJZO6m9vn0D4TN99p7NMO1/Jl9Vq9hewQTkH3IGvci+MXdhxSDfiyRy3tXXaazYQ3Viudg1g7O0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7/O49xeITvX6w5EZMZrUPUFap6IbtGUWM77jgzGO8s=;
 b=WrcX1CoUW2mMyIXgb/f+75Z/3eF4Z5UkbYMbTPwfsEgCjC6Fe2r1hUcAHNok0/buvH9g159PDvhnhWGKKHEMqBlumBzrJj/M7nY+X+i3wpxd3s0rXDLBmAOxlQdnTnnx8Uuq0ClnNyL/iRwv/7smZU/1ocuhxnhUYWLOT0oaZLj9ldkhJWbJZh9alUjoWIRQAkmrZnchkfgjdXrKbHSj9Q04EMbU8fwk0GPvkKINIfz4bDa2/rerBiw0Elf4Zkb7SEoTKrSl3FJVt9cG3EvcSJQnq8gaUdF+hlv+9KuCc+Jm9a01sj/lxvvuxYLfM3SlTPTx9xYkeWzHF8qrWKe4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by DM4PR11MB5518.namprd11.prod.outlook.com (2603:10b6:5:39a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 04:18:12 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a41b:1b6c:8306:7644%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 04:18:12 +0000
Message-ID: <0c32fc78-5755-09b8-4d2c-81101e33fdee@intel.com>
Date:   Mon, 5 Jun 2023 21:18:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 01/12] Documentation/x86: Document Key Locker
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <dm-devel@redhat.com>
CC:     <ebiggers@kernel.org>, <elliott@hpe.com>, <gmazyland@gmail.com>,
        <luto@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <mingo@kernel.org>,
        <x86@kernel.org>, <herbert@gondor.apana.org.au>, <ardb@kernel.org>,
        <dan.j.williams@intel.com>, <bernie.keany@intel.com>,
        <charishma1.gairuboyina@intel.com>,
        <lalithambika.krishnakumar@intel.com>, <nhuck@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20230603152227.12335-2-chang.seok.bae@intel.com>
 <32ffb593-c39c-c741-7b6f-6f1cbcb1d558@infradead.org>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <32ffb593-c39c-c741-7b6f-6f1cbcb1d558@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::24) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|DM4PR11MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 928138a0-dcd2-4476-8676-08db66450aac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlpH+S7yY6VXm3gAT2+Sbb/0VbEcqjWU8WaLy/fCRydGIzj3spyjERffY+tep8VB/x0oZGJn85/wv7Ke6LCt1MvG8KvYhBDv7Lk3Gh6/smvfdHhZp1UA0xN7kmhOm+W/gn+R2PHxfrU2/aDB7Wgk+w3ljQBwg0XJ+JZFJKn15ORcA8ASzkYtNi7ZxZIuPgQ7bnpx6u9/Bo+RLdFvBigVqFAi1Xlx7KcsRZPgzQXWlxdxMb2hya4RQmLwLhIOtP5b1KfSaBK0EMZYVccDq8D5FmF6iPYqm5IYJpPCg+5YYpRqA2UkXUM0MkNfofpzaAlNyiL+6I8h3bbmAb/TDjeKpXJ1SfkuQAqSthjkmDMWmI1v4uU1okfBHCU2UKoKEOTxKFj2zKzPEL82CMZXCQC9w2oB1BULaCBnw4NYtPi0nzp4CuGmttG4KQwi9WhSgoWZNY7cLh1Zb5mLohgL2qSDeAfrW4d2OyYR4Eo7Yx+q7JPvJlrb++bkVzWFklLURpyzxjd2yXATZQ8PcAZRFYYKn3g/Fx0/lXgjHTSU5pM+YX4vQemqh+SvLGRslZwBeruH7L1ODZV/Lm1qZbSIvsJj9vMVTWWZ2sIXyRTyUuspv9RQC1xNLUk6QTHJ4QUODGeeIWUY0LI57Axz3eixDGgGEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(186003)(26005)(6512007)(53546011)(2616005)(31686004)(83380400001)(7416002)(6486002)(36756003)(2906002)(4744005)(8676002)(8936002)(82960400001)(54906003)(478600001)(86362001)(5660300002)(31696002)(38100700002)(316002)(66476007)(41300700001)(4326008)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzlkSVZsRW1DOG1oU3NhRUFCS2Z6bGZRVSs5ZUllNkFEdEpBYXNQdFNtSXcw?=
 =?utf-8?B?dlJFdUR2R3ZkdnJVdnc1Ym5jUWJwNlBMU3ZUbE9Hd1ZuU3ZhM2lEeFJjeWh3?=
 =?utf-8?B?OU9FL2QzeWFGV1p2cmEyaTIvbWNJd3psVFdqYkQrWHAxRGkzZExvZ0lZT083?=
 =?utf-8?B?MEh4UTRiQm93b2ZhR0xMb3hiTG9oWWo1a2xiM0lVUFd2bHloTHdqS3htSkRv?=
 =?utf-8?B?ZkdyWjdSaHFyMTdJcDVQak1Pa0dacU1ZcWJaNEsyWVl6Y1JpWVBCMUh5SDdC?=
 =?utf-8?B?cmNTOGJIWE1wT2N0My90VzU1by9wRDB4M1IwYWlkMVdUOUM1ejdqd0J3MTV2?=
 =?utf-8?B?dFVwYldvamQrQnJvaFowamVjcFlFQWk3NjNxcTV3aExMcm5QdGcyYllqZzIw?=
 =?utf-8?B?czlZN3NVMnhSZXJGdDhORU1sdDlsTHpSV0pBaXVoUzNQWHhCNFgwbnFLM1Vt?=
 =?utf-8?B?bENZZDNNTFdibXg1RW1hdVNBNStxTlV2a0wzaVM5OU93OTU1amwrNXFySXRs?=
 =?utf-8?B?b2tta0hJNUtJR1JRREY5L1hhZkN3NjYwZEsxanYrdE9OcXJTaXJBYllIMjk2?=
 =?utf-8?B?dmVabEtUV3VoYTRYN0U5VldTaTlGeVZDZU5Sall3RHhoTWhuSldQcEdpMm9O?=
 =?utf-8?B?Tit2RXh4Ty94dVBKenhFWFNOZXBFWi9zakZKN1pjMG9Ra3RpdDY5bXkyMUpn?=
 =?utf-8?B?UFdESDBiQktyR1h6eHV4ZkxadjJCdnNHQ1VnSUhUUk1HOEplWVMvSG96TXdo?=
 =?utf-8?B?Uy9JaXZNM3l3ck9idlk0aURxMmhmZzhJYldmeitUYTBmRy9pYVpKaTJHV2Vi?=
 =?utf-8?B?aFp2UmdMMnYyL3hLMVVxOEx0VmhQRS9FVWIwLzFiU0lvZC9vTlNaaWdndmQz?=
 =?utf-8?B?VjQ4eGdMV1JKdlZwYUVtQkpJUWpCcnlOdkxKb0VlU3JBUDFHSE8vL0tGZFht?=
 =?utf-8?B?bGRzMjMzZGptbDZBUU5xRlpNWXdFeW4xbjJndWtxZWdscGxFMFdnR21LTkpX?=
 =?utf-8?B?RFBqY3E1dkpoVnZDQzJoSEFkTkNOMlhPbExsV0Z3Qm13UjFPakQrcGtFb2gv?=
 =?utf-8?B?RkxiU1QyUFhhNjlhNEF1aEtNQTB0K0U4ZEx0Z0xZYldKVzZMd3YzSUJXOGw1?=
 =?utf-8?B?M3MvWDVTcDdaOTBvM2FRUit6QUFnUEFMQnpNS3EvZWdRUXNkYmdhSFYrQ3lK?=
 =?utf-8?B?cUpCU3hmNnlqN3FnTEQ0N1QwS0FHeU5kTVJGbU5acVdsd2NFSU5TeVQ1dmtE?=
 =?utf-8?B?M3lwbW44bTR3bjNid3VqUmMvNWx0UUMxWWVsUGVOTXJtTWZEWjVhWndZRFh5?=
 =?utf-8?B?VFlqT3JOb29yVllCUFNZNy96cFBHWk12bm1hU3Y5dGd4aitZYWpESEtVcGc1?=
 =?utf-8?B?cWRJVmpvSnRDWXg4dWpBVGI3OW5ibDhOUkhmYjEzTnA2YWprN3ZzV2hib1ZB?=
 =?utf-8?B?aXFDVGJqeExSQ3VtUVdKbnRWOEcxYXBlUW1CMm5yOWFiRlRCMTRCWUE1Z3Fp?=
 =?utf-8?B?SXNleFVNRGRyRFpCQ3ZVY2NVK2RNRTRlRDkwQmp6aFEzUHFqdjVFeGdrRDJx?=
 =?utf-8?B?K3pqTStHaUh1TjRyM1Y5N0diNU9OaDhLaks1ZHE2MHpOUTZjVzlidS9JdHVT?=
 =?utf-8?B?VTVZTytNMytMWHFhaml6VlNpbTVpRFZCVFhJOWEwVytucVM4QUZuKzBuazRJ?=
 =?utf-8?B?MEJyTTA3ZWl4RzNycll2ZVNsTHF5UjBNVjFIYSswcEt4T1ZmYmgrMkhCSkNE?=
 =?utf-8?B?UFRvN1AxVVlmQm9PdWZXQWZ4Yy9FdFNRT0hyZE5MdWpWMVZObnlNTUpFMFpy?=
 =?utf-8?B?VG11T1NQc04wNGQ3OVkvN2hIcm1LbVlUaEVZU0ZZRys1UERpMmFTeW85L3Z2?=
 =?utf-8?B?akhPNXR1RGVQeEVGV044blZvTExEanJuNEFMWGZOVDg5dEdnamJKQ2huVkZ5?=
 =?utf-8?B?aGRWR3ZTNVB3VUxYbzRDS2NZV0xGYlhHbUlRRm5tM0NhMlJnY1N2QVdIUmx0?=
 =?utf-8?B?NkI1T25yS3djdmxLM210bW1JSjNGMXFBVDZaWFBmUHFQa2YwdWdmYXk0Q0FH?=
 =?utf-8?B?cEdCdGFjQXcvR2QvUzFvSVR0OFNoWkFSU3FNbWFRaUJYdEFkdkIrZW5nNlJR?=
 =?utf-8?B?VnFyWVFDUURxZURFTHdXczh4VDN4aHRFRFQzdjdmaXBxVHhUZjdYN1RmTUhV?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 928138a0-dcd2-4476-8676-08db66450aac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 04:18:12.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qS9EL/oh3Wz5fjILXR4yrRF46gEA70x4lDIeWiK91/bnmqBZ9G1rDXIIDKmdmyrXjLY9OXw+sgS0PfWgoafCABzXZGixD/chDpMUq5EWNbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5518
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

On 6/5/2023 7:17 PM, Randy Dunlap wrote:
> On 6/3/23 08:22, Chang S. Bae wrote:
>> +
>> +* AES-KL implements support for 128-bit and 256-bit keys, but there is no
>> +  AES-KL instruction to process an 192-bit key. The AES-KL cipher
>> +  implementation logs a warning message with a 192-bit key and then falls
>> +  back to AES-NI. So, this 192-bit key-size limitation is only documented,
> 
> Is it logged anywhere?  i.e., a kernel log message?

Yes, this is the relevant change in the last patch:

 > +static int aeskl_setkey(struct crypto_tfm *tfm, void *raw_ctx, const 
u8 *in_key,
 > +			unsigned int keylen)
 > +{
...
 > +	if (unlikely(keylen == AES_KEYSIZE_192)) {
 > +		pr_warn_once("AES-KL does not support 192-bit key. Use AES-NI.\n");
...
 > +}

Thanks,
Chang
