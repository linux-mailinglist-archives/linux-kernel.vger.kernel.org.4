Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C28D74B9B6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGGWwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGGWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:52:39 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44036B9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:52:38 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:47910)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qHuJW-00GDhM-90; Fri, 07 Jul 2023 16:52:34 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:34532 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qHuJV-00FYwO-6s; Fri, 07 Jul 2023 16:52:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>
References: <20230706052231.2183-1-xin3.li@intel.com>
        <87v8exgmot.fsf@email.froward.int.ebiederm.org>
        <SA1PR11MB67348D11385F584354AB84C3A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        <SA1PR11MB6734F3F72095C4D6B9C12C9BA82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        <87sf9zfx76.fsf@email.froward.int.ebiederm.org>
        <SA1PR11MB6734577080AC6734E305D735A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
Date:   Fri, 07 Jul 2023 17:51:49 -0500
In-Reply-To: <SA1PR11MB6734577080AC6734E305D735A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        (Xin3 Li's message of "Fri, 7 Jul 2023 22:17:36 +0000")
Message-ID: <87pm53e3ne.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qHuJV-00FYwO-6s;;;mid=<87pm53e3ne.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19QTPt1VjS7X1hGX42zlzX0I1GsKs+iLg4=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Li, Xin3" <xin3.li@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 499 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 15 (3.0%), b_tie_ro: 12 (2.5%), parse: 1.55
        (0.3%), extract_message_metadata: 15 (3.1%), get_uri_detail_list: 2.3
        (0.5%), tests_pri_-2000: 4.6 (0.9%), tests_pri_-1000: 2.5 (0.5%),
        tests_pri_-950: 1.44 (0.3%), tests_pri_-900: 1.21 (0.2%),
        tests_pri_-200: 1.06 (0.2%), tests_pri_-100: 6 (1.1%), tests_pri_-90:
        62 (12.5%), check_bayes: 60 (12.1%), b_tokenize: 9 (1.8%),
        b_tok_get_all: 10 (2.0%), b_comp_prob: 3.4 (0.7%), b_tok_touch_all: 32
        (6.5%), b_finish: 1.56 (0.3%), tests_pri_0: 316 (63.4%),
        check_dkim_signature: 0.60 (0.1%), check_dkim_adsp: 7 (1.4%),
        poll_dns_idle: 45 (9.1%), tests_pri_10: 3.6 (0.7%), tests_pri_500: 63
        (12.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Li, Xin3" <xin3.li@intel.com> writes:

>> Perhaps something like patch below to make it clear that we are
>> normalizing the segment values and forcing that normalization.
>
> "Normalizing" sounds a good term.
>
>> I am a bit confused why this code is not the same for ia32 and
>> ia32_emulation.  I would think the normalization at least should apply
>> to the 32bit case as well.
>> 
>> Eric
>> 
>> diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
>> index 9027fc088f97..e5f3978388fd 100644
>> --- a/arch/x86/kernel/signal_32.c
>> +++ b/arch/x86/kernel/signal_32.c
>> @@ -36,22 +36,47 @@
>>  #ifdef CONFIG_IA32_EMULATION
>>  #include <asm/ia32_unistd.h>
>> 
>> +static inline unsigned int normalize_seg_index(unsigned int index)
>
> normalize_usrseg_index?

Perhaps useg?  I think that is the abbreviation I have seen used
elsewhere.  I was trying to get things as close as I could to the
x86 documentation so people could figure out what is going on by
reading the documentation.

>> +{
>> +	/*
>> +	 * Convert the segment index into normalized form.
>> +	 *
>> +	 * For the indexes 0,1,2,3 always use the value of 0, as IRET
>> +	 * forces this form for the nul segment.
>> +	 *
>> +	 * Otherwise set both DPL bits to force it to be a userspace
>> +	 * ring 3 segment index.
>> +	 */
>> +	return (index < 3) ? 0 : index | 3;
>
> s/</<=
>
> no?

Yes.  My typo.

The patch was very much a suggestion on how we can perhaps write the
code to make it clearer what is happening.  Normalizing the segment
index values seems like what we have been intending to do all along.

In fact it might make sense for clarity to simply use the existing
"index | 3" logic in what I called normal_seg_index, and then just
update the normalization to add the null pointer case.

I was just spending a little time trying to make it so that the code
is readable.

> With this patch it looks that 1,2,3 are no longer valid selector values
> in Linux, which seems the right thing to do but I don't know if there is
> any side effect.

You have said that IRET always changes 1,2,3 to 0.  So I don't expect
the selector values of 1,2,3 will last very long.

If that is not the case I misunderstood, and we should consider doing
something else.

It bothers me that the existing code, and your code as well only
handles the normalization on x86_64 for ia32 mode.  Shouldn't
the same normalization logic apply in a 32bit kernel as well?
Scope creep I know but the fact the code does not match
seems concerning.

Eric


>> +}
>> +
>>  static inline void reload_segments(struct sigcontext_32 *sc)
>>  {
>> -	unsigned int cur;
>> +	unsigned int new, cur;
>> 
>> +	new = normalize_seg_index(sc->gs);
>>  	savesegment(gs, cur);
>> -	if ((sc->gs | 0x03) != cur)
>> -		load_gs_index(sc->gs | 0x03);
>> +	cur = normalize_seg_index(cur);
>> +	if (new != cur)
>> +		load_gs_index(new);
>> +
>> +	new = normalize_seg_index(sc->fs);
>>  	savesegment(fs, cur);
>> -	if ((sc->fs | 0x03) != cur)
>> -		loadsegment(fs, sc->fs | 0x03);
>> +	cur = normalize_seg_index(cur);
>> +	if (new != cur)
>> +		loadsegment(fs, new);
>> +
>> +	new = normalize_seg_index(sc->ds);
>>  	savesegment(ds, cur);
>> -	if ((sc->ds | 0x03) != cur)
>> -		loadsegment(ds, sc->ds | 0x03);
>> +	cur = normalize_seg_index(cur);
>> +	if (new != cur)
>> +		loadsegment(ds, new);
>> +
>> +	new = normalize_seg_index(sc->es);
>>  	savesegment(es, cur);
>> -	if ((sc->es | 0x03) != cur)
>> -		loadsegment(es, sc->es | 0x03);
>> +	cur = normalize_seg_index(cur);
>> +	if (new != cur)
>> +		loadsegment(es, new);
>>  }
>> 
>>  #define sigset32_t			compat_sigset_t
