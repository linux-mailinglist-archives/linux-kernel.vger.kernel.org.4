Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ED85FE6C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJNCCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNCCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:02:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2BD183D85
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:02:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so5192426pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFZZy9pvaOE5FXP35cf1kMoA7/k/1JqmLQ8oHebi89Q=;
        b=vPBr428q2Qxd98OWgc+dKi3IH6tMaEpPpxEBqxTmjml9jPzswHRHD8rE5GQ7b7ouZT
         zmLZzcINK60zRtbjuHTcwFYMplDN4c21bAUzsseDBxoy34KkBbJkxAh/oBYonDENTLIp
         mL6xKiyxY69vcrausoP6lPdj6hym19RR0FTc49HmJmYwp28l44kabM7+o13QyImLWfhh
         nypq3ME2HywOpnH/gzrGcSIPcr1kpUEDkrs3tZn0eCj6jM2RwazxcX0LshmiTyWihioN
         XoYLXrDXXZQ/tx4nWciizrncH0jfQoqDKuBuXHNC5d+qJCg8z3N0OailkZ+pOsKoXyz2
         SiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFZZy9pvaOE5FXP35cf1kMoA7/k/1JqmLQ8oHebi89Q=;
        b=ITalZVJ5YG2d++9Lj3aSulmePpC2lznnq9V9XsiHCVoY+xgFK9IK85QWn1yH9fVAwB
         7n+7W7Y5tt3cy9nlH4GmJLeEmo3hwcA607ZnoMn1vD56nruzoGEA85LEC/cV1nO75eK2
         JoaAYZnvrrHPSTMn9lY3eeIMO+/6MtDgin/mzm3bt9E6aMbz0qPPP8qDMdyUGRAa9DW4
         OqbHDSwaIEv/gSnDdfzFhDdt9vrju8+IHrMzKCdNsMVrL4c7KP8yhmPZOeo6hIyFFp74
         yKQCP8mVxet59/JJFdP+DB+XyMrOtDveu+3A8TfC7Zg4J+EDAkMCoQGhu0Ha4F/pq6bc
         4/GQ==
X-Gm-Message-State: ACrzQf0AAgyj59cQelHQK0IBfKRD5p+wRYRUTL+o5wJzgjFapfeS7FOY
        xLVWP2Xojby3/oLFpHSTVKh36g==
X-Google-Smtp-Source: AMsMyM7Ja5O0XNSMgxgemytutS28PFlgbM3bAsCpJDnsaBsJOs4vGUTB/pxbKUcyuAD8gd47+OZDcQ==
X-Received: by 2002:a17:902:f7cf:b0:17f:9081:a3f7 with SMTP id h15-20020a170902f7cf00b0017f9081a3f7mr2629844plw.3.1665712935855;
        Thu, 13 Oct 2022 19:02:15 -0700 (PDT)
Received: from [10.4.165.47] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902684f00b001769e6d4fafsm497131pln.57.2022.10.13.19.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 19:02:15 -0700 (PDT)
Message-ID: <f0e91dbf-8379-f481-0009-1f19c79a610d@bytedance.com>
Date:   Fri, 14 Oct 2022 10:02:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, quic_pkondeti@quicinc.com,
        peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20221010104206.12184-1-zhouchengming@bytedance.com>
 <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
 <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com>
 <CAJuCfpET+B3X-uX2vDp-2yH-+OVxOu3YXL7JWZrPuoh22P+5SQ@mail.gmail.com>
 <dea56c22-ab5b-25e2-9819-cc598f9aad80@bytedance.com>
 <CAJuCfpFTDyR1V+JYOY_uN6Xg1Nip5b=9dzkwm-CNd8vMWaQQFQ@mail.gmail.com>
 <46c6e1cc-77d3-eac1-fa18-deed2bac4a0e@bytedance.com>
 <Y0g0UAAJMhPczNm/@cmpxchg.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Y0g0UAAJMhPczNm/@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/13 23:52, Johannes Weiner wrote:
> On Thu, Oct 13, 2022 at 07:06:55PM +0800, Chengming Zhou wrote:
>> Should I still need to copy groupc->tasks[] out for the current_cpu as you
>> suggested before?
> 
> It'd be my preference as well. This way the resched logic can be
> consolidated into a single block of comment + code at the end of the
> function.

Ok, will move these resched logic to the end of get_recent_times().

> 
>> @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>                              u32 *pchanged_states)
>>  {
>>         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
>> +       int current_cpu = raw_smp_processor_id();
>> +       bool reschedule;
>>         u64 now, state_start;
>>         enum psi_states s;
>>         unsigned int seq;
>> @@ -256,6 +258,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
>>                 memcpy(times, groupc->times, sizeof(groupc->times));
>>                 state_mask = groupc->state_mask;
>>                 state_start = groupc->state_start;
>> +               if (cpu == current_cpu)
>> +                       reschedule = groupc->tasks[NR_RUNNING] +
>> +                               groupc->tasks[NR_IOWAIT] +
>> +                               groupc->tasks[NR_MEMSTALL] > 1;
>>         } while (read_seqcount_retry(&groupc->seq, seq));
> 
> This also matches psi_show() and the poll worker. They don't currently
> use the flag, but it's somewhat fragile and confusing. Add a test for
> current_work() == &group->avgs_work?

Yes, only psi_avgs_work() use this to re-arm now, I will add this check next version.

Thanks.
