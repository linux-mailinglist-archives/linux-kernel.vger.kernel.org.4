Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AEB5B2EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIIGYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIIGYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:24:38 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C47877654
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=jjp1w
        ngOuHnY57lF/I3HL0yq5Kq/yfCIC6eoXFKU2Nc=; b=A4P1IMT4I1sNz+2NduohJ
        S65cu/NTNEGdSqSQxkz8YViUMSfQmlqSz1NET5wOI/cEhKvpkbWaMTCFMeZm2wR3
        4n8BnO0kB+iMA/6xCqHY98Xc1XEqf++XCgwpwGzkc848LTiaky4Sx8C/unnVkgrK
        LorFv3lfsKBAIOys9nZpzc=
Received: from [172.20.12.189] (unknown [116.128.244.169])
        by smtp8 (Coremail) with SMTP id NORpCgCnqMSL2xpjzYG1BQ--.13881S2;
        Fri, 09 Sep 2022 14:22:04 +0800 (CST)
Message-ID: <320ceea3-efff-2bde-4704-5c654170daef@126.com>
Date:   Fri, 9 Sep 2022 14:22:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND] sched/topology: Add __init for init_defrootdomain
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     dietmar.eggemann@arm.com, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20220831093927.5904-1-huangbing775@126.com>
 <20220906203713.4b1a2bbb@gandalf.local.home>
From:   Bing Huang <huangbing775@126.com>
In-Reply-To: <20220906203713.4b1a2bbb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: NORpCgCnqMSL2xpjzYG1BQ--.13881S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1xKr1xKFy5JrWfXrW5ZFb_yoW3ZFg_uw
        17ury0kF4UWrs8try2gw1SgFykXa97KFs2k3yUKa47Gan7X3s5Ar9xWFyxJr97XryxtF9r
        Cwn0v3ZrJrWq9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1w0eJUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xkxd0w5elqwlixv6ij2wof0z/1tbijA13r1pEJRy4YwAAsl
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/22 08:37, Steven Rostedt wrote:
> On Wed, 31 Aug 2022 17:39:27 +0800
> Bing Huang <huangbing775@126.com> wrote:
>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index b0bf2287dd9d..cd761f1fc60c 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -883,7 +883,7 @@ struct root_domain {
>>   	struct perf_domain __rcu *pd;
>>   };
>>   
>> -extern void init_defrootdomain(void);
>> +extern void __init init_defrootdomain(void);
> Function prototypes in headers do not need annotations like __init.
>
> -- Steve
Thanks. I'll send the patch v2 soon.
>
>>   extern int sched_init_domains(const struct cpumask *cpu_map);
>>   extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
>>   extern void sched_get_rd(struct root_domain *rd);

