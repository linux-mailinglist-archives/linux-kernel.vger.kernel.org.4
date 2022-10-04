Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640EF5F4144
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJDLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:03:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476CE2A259
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bC+7OlPu12qai4+pmkhDTqVckIhUvBHBQx8h7ZQvyaje7nflrQi7xRQbbEBMfGR88i6vkR1/QNaTYuISoKI3kZCGyAgrDBQsGTvJZ77pJeVagEb4ahlnYtXn8WJ7PJuKMBQvJMcrFIIDTVo0XEpTXTtuYFLSZnLyDa1eIb7incpMG1vLT06TS4nYQpTCFbOpcUmFAzSqeUnSI9uMzoZ4b9e9Q7zMu7ASEVw5aJU5waqxhAD2VDFE9VCc+4MdFVUzBktuT+TbRVojnsWMeQeA4W0qCDY6cBvYovRCL+WS+rnN+zfEb+aV4/Al3AZE1mpNHt88DcNRPgGSfCz+jtL7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IokFddPdV7HIrzpIUoByLj6n+3o3hsSxVbuMkS/m+g4=;
 b=HfqDQeoCpl8AbFX8rWV/W9HRHx036dV7Xl889BXTYp1M9MFPTH9YK+x7YWSt9bMmrYax5H9avYwfGH1UzUeY/nGhPciNjscwG87Len5c2tKlfd0Y43hnK7H9iWht31lNjud/v+9Uv1HJUN93ufTGutYkLZ7Jqo7DJQ2mJaJNmXDsmQhF4+RKnOizEtcHZ8rEdHVQ3yPU9ElxTRDBpVFA3a4X3HacESdZD60xkjVmuGcXuUiA/90oI/9z83s7EkPWIamFB1QPnnB+bICS5bvhkv8eyjiMDIzbABZuhFpnIhcMx1XV0eG6X4MMrrmvoD/eEyroz/rv2o19AJuaezRUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IokFddPdV7HIrzpIUoByLj6n+3o3hsSxVbuMkS/m+g4=;
 b=qklSvkonYtZ6GCu9CnNlxwk66GMUmcUVT5zSU7o4S3/zKRbSCKyaudz3zRpuEKSmEQz6jfRm2wYNC1rCvn9SpI1gcuHcLukRxrpHK319c8GrWeJpnL01E7wnd5B6+O3pENZ2WQX+ROFi76za0+/tZRLOyX2wgdwrwbPdRKAJ/YinwddN6SmDp/Aq4NvwOIn1qHzymGAdAgV1VBtUVrJII087FqCTmBNarezgs5Mvv84PuHHD9kl7GYsZq3YQy30LxPxTm/R8pHDRhHUnZUN18Kbdn8M7r4TKwKVkWkH9iTJlIbZoDU3syK0eg2mr5rqMwppQjv5VRISAqXFNK3N17g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by AS8PR04MB8691.eurprd04.prod.outlook.com (2603:10a6:20b:42a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Tue, 4 Oct
 2022 11:03:05 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::2459:15ae:e6cb:218a%7]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 11:03:04 +0000
Message-ID: <623a323c-943b-8c69-f877-a0669b9672dc@suse.com>
Date:   Tue, 4 Oct 2022 13:03:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/3] xen/pv: refactor msr access functions to support
 safe and unsafe accesses
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20221004084335.2838-1-jgross@suse.com>
 <20221004084335.2838-3-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221004084335.2838-3-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::19) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|AS8PR04MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: a3811be0-1166-44c8-c4f9-08daa5f802e2
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmdfDVlhLgyv8R3Y788IlQDu9xRxyY9Nt+kyzLtg36Hb5onDE4j/D0TloXJMOL8wBKH3xV0af8YLWti6Y5WwUQzuZ0KpDfJG+EKSikvV6r7+MHKfMoMkoONbC9jfjBMGtMtAlDsJzIw8onYShYdQ33RNgMZjuFH8Wb5x9lcgkDmiEayEiJ26NsefA8rrS/cG8eszFkamhwdfn4DuA14rYgFjW0EdS2Tqg0fWTkfubRIBw6slzH3Xv6DwMP+MqqHZgfrOdI2jSz/QAOZ1UG+wW9RQjmMdfJf3GBll/tjWOvpY6wB7jVSaomQxAeCxPfpAeg0hojHfc3KfFd9Dl5S7izZcxYp9UWq6ZKwmr/fb2cm15YQDfnJ7BcCpNNVwvVQpkcVY+b4EGsvaSrMKNgkhRrC52OPfIYydsOMttsKt48NYK3yKxmCM4LvK3tIp/MzFDBWMkGJgh3+Tsh+AzZWgXU4V1aPqlO+EHfStUiTgecePqQpj5oS3IYX6UfMR3gY2fa7ALduc+iXUvdkV71z2+ACvyHYp1MCzxE67na6zZTr6YN+FKyu3k8XFsT2WHgCO4/NeKWmVSsn+7IElA3piSWDLty5YMgjYEUrV3yoZpTZEEPENRzfR11sI65AeWkfODbAJc0cFI14MHa/lMtatJ+WExGm+4/Lg7Jb0YKritAHpvDBifrzAFma9t/4hmJosLU3EJK0f1HA0VzbD2QEdQENI0YZpwYTPG6MkhUrmMZhAlEh5bq990HEdmBuC+v1UPrQyPAj4WI4Vb6oy35M9DuXhc8AyUv7ovUoh0JDzuxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(5660300002)(41300700001)(2906002)(8936002)(6862004)(31686004)(6506007)(53546011)(26005)(83380400001)(86362001)(478600001)(186003)(66556008)(66476007)(6512007)(8676002)(4326008)(66946007)(54906003)(36756003)(2616005)(31696002)(37006003)(6486002)(6636002)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZKZnlnVnlqVEM0TTc1dGxGdW5VWm4xRHI3cHJYTHplcnZDaDNUaFc3QWZa?=
 =?utf-8?B?aXRVVlo0Y2V4OFNTS0E0R0s5V25zbUNIc3BvRkxqOVU1dTNEaFF5cG5LSG5G?=
 =?utf-8?B?V0NVdmNkRCtVcU90NmRoOUpBc3ZIUUsrN1pZM0Y3OUlrU1pSa0RwSlJ1cVBK?=
 =?utf-8?B?STlhMUNOMEpNSSsweWY2WEM5SXVDNVZqbExVTWJjMENINDdLckpXZlN4N1pG?=
 =?utf-8?B?RkoxYnpxQm5VS0dGQ0s5VldjK21Ga1lscGE2RG81MmtSZElPR2IxcWl5WW1l?=
 =?utf-8?B?elVucUZSR0syazFRTzV5dTU5MzZUWFlabFVoUjgvTHFMR2Q4YXd0NDRKc0VN?=
 =?utf-8?B?bU5tbThwYkxrbHJSWWN5VFh3MDhEY3pLaHBhbEJQTjdZY3JGQ0JmTHpPTXpN?=
 =?utf-8?B?NzVGMkpmeTNhaDdyRGZBWU5HaGUrbkVNUTQrdGxhaUZpaEtLYWdndnBVbVk2?=
 =?utf-8?B?MC9GZWlrdnVIN0dSWUZZeklaTnJyQUkvbzNiNGtkNFJ0WENvZ3dkMThkdFBO?=
 =?utf-8?B?RFZnN0NvN3VHTGZBVSsrYnFHdDdPc3dNdzJjbkVUaU9vOWVSUnkwNnlscElG?=
 =?utf-8?B?N3ZOcWJpTnNYYTkxSXN4V1pzSlpLZmE2ZGVSVXhjTWJaTVU1UUd1WUlWSXh0?=
 =?utf-8?B?cmJuaTNwSHJWY2hhcmUwd05qOUdGcVVHZjQxWll3NFNvQnluSTArNE5hQjRl?=
 =?utf-8?B?RFVwUFBJQWlrYTl0Z1M0VWxEMkRYb2lhdVU1RU5qYVNjcExvVmNsckNjeXVK?=
 =?utf-8?B?eEorRTRLNVVIbGR3VE1JbzV4bUYwa3l2cS92NFRVejhZa0Jvb3ErZG5KaUxq?=
 =?utf-8?B?S1FTL0tDZFFwNTFLdG9FcU1tTWtyK00wazI2cFgxNEpFMnN5SklzVVFKRGFv?=
 =?utf-8?B?ZG1ZbWUvRFU0RDVHelYvc2RDZ0d6N2x3UlRldlFtN3hzT3J3NDNOa1RPdklx?=
 =?utf-8?B?ZU9mQXZIZUZOS2hjWjdMV3R5a000R0hvcm5sZmN4ODhqUE5YbTd2OXZEVDBn?=
 =?utf-8?B?Q3dqdUtvWGJVUUhhUjFRTi9VaGxXVWZ6aFNGS3NPUWtDUXVUSTlUaXVMN0ZN?=
 =?utf-8?B?Y05LYzE4SXkzREZWQURzVDJuTmtjRC9WcFpkYjQ5OThaRUJCNkw1L0pZK1dI?=
 =?utf-8?B?RldBTFk4UExaMDFSU2Z1TFNTbW1Yd1JBS2twV1I5cUs3eDVhM1BrbGVid2Nn?=
 =?utf-8?B?OHB0cU9nME8vU3kxSzZXOXozMnA2M0kzenRjRVNWck16dDlkU1drbjl3SlVh?=
 =?utf-8?B?Ynh3QXVuZUpxQitqcWJvL0NmWU5pQ1hITU8vdHhka3UvdEF0ZnFPeW1HNEwz?=
 =?utf-8?B?cmFGWkdGM1JySW5BY21mU3ovM3l3cWdFbGkyQlp5QlF0Y0d2RUliSUJhMm5X?=
 =?utf-8?B?cVQ0dktNUVdxVmFQM3BkL3ZXcG5FTjl2YjJCWFgzcFVzRVFkaGkvVDArR0Jp?=
 =?utf-8?B?TDI5QmJqNXYxc3FSYzhxemZzdDZTRVAyTnpZL2g4aUJiWDg0RWFZQUg0Mk56?=
 =?utf-8?B?U2lBYzlrVGF3VHU2eEJjdFNpNlcyQi9PYU03S0V1RXFWU2RyeGZtazR0QlRS?=
 =?utf-8?B?OFRzdDY3dFV0R3A5NE1tZ0lpV0FmbldpYVlzaTZFNmVHZ1UvcjNXa1l2aWpX?=
 =?utf-8?B?MXlFTS9mZFY3MnY1WU1MUXhZdEszYmFWU1RZaFR6cTRhNTNMZEF0dnBKNXU0?=
 =?utf-8?B?cHBnZ3RMdFltbVl2bE9vaFJ3Y3VIR0xxT3hFekU1VFovRk9OQUxMUDFnRjhP?=
 =?utf-8?B?MEozclRLT3hiQ20zWW5vN0RDdHA0V1ZOWVR6ZVlkWU83M1BQemR5dkRFaEx1?=
 =?utf-8?B?TjRyMnFpL0tKZGU1ZGorRVVrQmJYRHBxUWVZY1lkWFJVTStWb3RaU3h6Y3Er?=
 =?utf-8?B?NVVHWk9wQnovNEJyZGk0R2s0UllFbG9LMVVnQ2J1YmszNWpwM3o1aTNjRHd4?=
 =?utf-8?B?U09WVUludlpaU0crWEFDVGlDMkFxYWRwckZOK3dNKzNOcW9rRndjY25zSjlI?=
 =?utf-8?B?QUtsT3kxNXdwbUd2cFlLSERJeUtKQjF5WGhVMUU1Rmh6a2xueTVRMXlBeFhJ?=
 =?utf-8?B?UUh3UVZxMVlYbWoxNVNFMWtwbTNSZEozOW54dVIyWE9aRUdiaWptQitxOUVU?=
 =?utf-8?Q?M17EpFif5ogZFM0Sw+MM+3fCI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3811be0-1166-44c8-c4f9-08daa5f802e2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 11:03:04.7109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WNFMzrcc5FhF2Ph7miUS1i1pArGObud6UOUG+lsho6znCKO4Ktx6KGP/FF+NqpWSNT3Vw8mccZuIqeFMRMwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8691
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.2022 10:43, Juergen Gross wrote:
> Refactor and rename xen_read_msr_safe() and xen_write_msr_safe() to
> support both cases of MSR accesses, safe ones and potentially GP-fault
> generating ones.
> 
> This will prepare to no longer swallow GPs silently in xen_read_msr()
> and xen_write_msr().
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

Albeit ...

> @@ -933,23 +937,39 @@ static u64 xen_read_msr_safe(unsigned int msr, int *err)
>  	return val;
>  }
>  
> -static int xen_write_msr_safe(unsigned int msr, unsigned low, unsigned high)
> +static void set_seg(unsigned int which, unsigned int low, unsigned int high,
> +		    int *err)
>  {
> -	int ret;
> -	unsigned int which;
> -	u64 base;
> +	u64 base = ((u64)high << 32) | low;
> +
> +	if (HYPERVISOR_set_segment_base(which, base) == 0)
> +		return;
>  
> -	ret = 0;
> +	if (err)
> +		*err = -EIO;

... I don't see a good reason to override the error code handed to us
by the hypervisor here; I do realize though that this ...

> +	else
> +		WARN(1, "Xen set_segment_base(%u, %llx) failed\n", which, base);
> +}
>  
> +/*
> + * Support write_msr_safe() and write_msr() semantics.
> + * With err == NULL write_msr() semantics are selected.
> + * Supplying an err pointer requires err to be pre-initialized with 0.
> + */
> +static void xen_do_write_msr(unsigned int msr, unsigned int low,
> +			     unsigned int high, int *err)
> +{
>  	switch (msr) {
> -	case MSR_FS_BASE:		which = SEGBASE_FS; goto set;
> -	case MSR_KERNEL_GS_BASE:	which = SEGBASE_GS_USER; goto set;
> -	case MSR_GS_BASE:		which = SEGBASE_GS_KERNEL; goto set;
> -
> -	set:
> -		base = ((u64)high << 32) | low;
> -		if (HYPERVISOR_set_segment_base(which, base) != 0)
> -			ret = -EIO;

... was this way before.

Jan
