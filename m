Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CCA64BB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiLMRzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:55:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 118DF2314B;
        Tue, 13 Dec 2022 09:55:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3962F4;
        Tue, 13 Dec 2022 09:56:17 -0800 (PST)
Received: from [10.1.196.46] (eglon.cambridge.arm.com [10.1.196.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEECE3F73B;
        Tue, 13 Dec 2022 09:55:32 -0800 (PST)
Message-ID: <c02bdc4f-d209-1fd2-cf5f-b747e324bb2b@arm.com>
Date:   Tue, 13 Dec 2022 17:55:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
Content-Language: en-GB
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759206900.3281208.11975514088019160962.stgit@bmoger-ubuntu>
 <7ce5bcda-bb42-4166-ab7e-8a07b8fb28a7@arm.com>
 <MW3PR12MB45538A17F57BF80C21BB46C4951D9@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <MW3PR12MB45538A17F57BF80C21BB46C4951D9@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 08/12/2022 00:02, Moger, Babu wrote:
> [AMD Official Use Only - General]
>> -----Original Message-----
>> From: James Morse <james.morse@arm.com>
>> Sent: Wednesday, December 7, 2022 11:21 AM
>> To: Moger, Babu <Babu.Moger@amd.com>
>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>> <Sandipan.Das@amd.com>; tony.luck@intel.com; linux-doc@vger.kernel.org;
>> linux-kernel@vger.kernel.org; bagasdotme@gmail.com; eranian@google.com;
>> corbet@lwn.net; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
>> reinette.chatre@intel.com
>> Subject: Re: [PATCH v8 10/13] x86/resctrl: Add sysfs interface to write
>> mbm_total_bytes_config

>> On 04/11/2022 20:01, Babu Moger wrote:
>>> The current event configuration for mbm_total_bytes can be changed by
>>> the user by writing to the file
>>> /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
>>>
>>> The event configuration settings are domain specific and will affect
>>> all the CPUs in the domain.
>>>
>>> Following are the types of events supported:
>>>
>>> ====
>> ===========================================================
>>> Bits   Description
>>> ====
>> ===========================================================
>>> 6      Dirty Victims from the QOS domain to all types of memory
>>> 5      Reads to slow memory in the non-local NUMA domain
>>> 4      Reads to slow memory in the local NUMA domain
>>> 3      Non-temporal writes to non-local NUMA domain
>>> 2      Non-temporal writes to local NUMA domain
>>> 1      Reads to memory in the non-local NUMA domain
>>> 0      Reads to memory in the local NUMA domain
>>> ====
>> ===========================================================
>>>
>>> For example:
>>> To change the mbm_total_bytes to count only reads on domain 0, the
>>> bits 0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33).
>>> Run the command.
>>> 	$echo  0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>>
>>> To change the mbm_total_bytes to count all the slow memory reads on
>>> domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).
>>> Run the command.
>>> 	$echo  1=0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> index 18f9588a41cf..0cdccb69386e 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>> @@ -1505,6 +1505,133 @@ static int mbm_local_bytes_config_show(struct
>> kernfs_open_file *of,
>>>  	return 0;
>>>  }
>>>
>>> +static void mon_event_config_write(void *info) {
>>> +	struct mon_config_info *mon_info = info;
>>> +	u32 index;
>>> +
>>> +	index = mon_event_config_index_get(mon_info->evtid);
>>> +	if (index >= MAX_CONFIG_EVENTS) {
>>> +		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>>> +		return;
>>> +	}
>>> +	wrmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, 0);
>> }
>>> +
>>> +static int mbm_config_write(struct rdt_resource *r, struct rdt_domain *d,
>>> +			    u32 evtid, u32 val)
>>> +{
>>> +	struct mon_config_info mon_info = {0};
>>> +	int ret = 0;
>>> +
>>> +	rdt_last_cmd_clear();
>>> +
>>> +	/* mon_config cannot be more than the supported set of events */
>>> +	if (val > MAX_EVT_CONFIG_BITS) {
>>> +		rdt_last_cmd_puts("Invalid event configuration\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Read the current config value first. If both are same then
>>> +	 * we don't need to write it again.
>>> +	 */
>>> +	mon_info.evtid = evtid;
>>
>>> +	mondata_config_read(d, &mon_info);
>>
>> This reads the MSR on this CPU, which gets the result for this domain...
> 
> [1] No. This read happens at the target domain. 

Oops ... looks like I muddled that with mon_event_config_read().


> static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
> {
>         smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
> }

>>> +	if (mon_info.mon_config == val)
>>> +		goto write_exit;
>>> +
>>> +	mon_info.mon_config = val;
>>> +
>>> +	/*
>>> +	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in the
>>> +	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
>>> +	 * are scoped at the domain level. Writing any of these MSRs
>>> +	 * on one CPU is supposed to be observed by all CPUs in the
>>> +	 * domain. However, the hardware team recommends to update
>>> +	 * these MSRs on all the CPUs in the domain.
>>> +	 */
>>
>>> +	on_each_cpu_mask(&d->cpu_mask, mon_event_config_write,
>> &mon_info,
>>> +1);
>>
>> ... but here you IPI all the CPUs in the target domain to update them.

> [2] There have been some changes in this area recently. The requirement of writing the
> value on all the CPUs in the domain is not required anymore. I am working on verifying
> this right now.  If everything works, then I can do 
> smp_call_function_any(&d->cpu_mask, mon_event_config_write,  &mon_info, 1);
> 
> I will confirm this soon.

Okay, that makes my next question more confusing then ....


>> This means you unnecessarily IPI the CPUs in the target domain if they already
>> had this value, but the write syscall occurred on a domain that differs. This isn't
>> what you intended, but its benign.
>> More of a problem is: Won't this get skipped if the write syscall occurs on a
>> domain that happens to have the target configuration already?

> Do you still think this is a problem after my comment [1] above?  Or Am I missing something?

I'd muddled two similarly named functions. Sorry for the noise!

I think what you're left with is the question "What is the monitor config for CPUs that
were offline when it was last changed?". If its preserved by the CPU, then its some
unknown value, and needs to be made the same as the value user-space/the-domain currently
expects.

If there is only one config value for the domain (as your comment above suggests), then
nothing needs doing here.


>> Because you need the same value to be written on every CPU ... what happens
>> to CPUs that are offline when the configuration is changed? Do they keep their
>> previous value, or does it get reset?
> 
> The contents of this MSR register are held outside of all the cores.  If the value changes
> while a cpu is offline, and it reads it once it comes online, it will get the new value.

This fits with your new description of the value only needing to be written from one CPU
in the domain.


>> I think this is best solved with a percpu variable for the current value of the
>> MSR. You can then read it for CPUs in a remote domain, and only issue IPIs to
>> 'sync' the value if needed. You can then re-use the sync call in
>> resctrl_online_cpu() to set the MSR to whatever value it should currently be.
> 
> This may not be required with my comment 1 and 2 above.
> 
>>
>>
>>> +
>>> +	/*
>>> +	 * When an Event Configuration is changed, the bandwidth counters
>>> +	 * for all RMIDs and Events will be cleared by the hardware. The
>>> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>>> +	 * every RMID on the next read to any event for every RMID.
>>> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>>> +	 * cleared while it is tracked by the hardware. Clear the
>>> +	 * mbm_local and mbm_total counts for all the RMIDs.
>>> +	 */
>>> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
>>> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
>>> +
>>> +write_exit:
>>> +	return ret;
>>> +}
>>
>>
>>> +static int mon_config_parse(struct rdt_resource *r, char *tok, u32
>>> +evtid) {
>>> +	char *dom_str = NULL, *id_str;
>>> +	unsigned long dom_id, val;
>>> +	struct rdt_domain *d;
>>> +	int ret = 0;
>>> +
>>> +next:
>>> +	if (!tok || tok[0] == '\0')
>>> +		return 0;
>>> +
>>> +	/* Start processing the strings for each domain */
>>> +	dom_str = strim(strsep(&tok, ";"));
>>> +	id_str = strsep(&dom_str, "=");
>>> +
>>> +	if (!dom_str || kstrtoul(id_str, 10, &dom_id)) {
>>> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain id\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
>>> +		rdt_last_cmd_puts("Missing '=' or non-numeric event
>> configuration value\n");
>>> +		return -EINVAL;
>>> +	}
>>
>> This is parsing the same format strings as parse_line(). Is there any chance that
>> code could be re-used instead of duplicated? This way anything that is added to
>> the format (or bugs found!) only need supporting in once place.
> 
> I have checked on reusing the parse_line. The parse_line is specifically written for
> schemata.  We can't reuse parse_line without changing it completely.

I agree its a little more complicated than it looked at first. I might have a go at it
later...


Thanks,

James
