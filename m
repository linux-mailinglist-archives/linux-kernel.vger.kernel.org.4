Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C796D7087E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjERSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjERSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:38:39 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB4E44
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 11:38:38 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38250)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pziWL-00DkSF-Ep; Thu, 18 May 2023 12:38:37 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41956 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pziWK-00DKMU-8V; Thu, 18 May 2023 12:38:37 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Christian Brauner <brauner@kernel.org>, oleg@redhat.com,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com
References: <20230518000920.191583-1-michael.christie@oracle.com>
        <20230518000920.191583-6-michael.christie@oracle.com>
        <20230518-lokomotive-aufziehen-dbc432136b76@brauner>
        <81e1a94d-531a-2e43-baee-da4b35644e87@oracle.com>
Date:   Thu, 18 May 2023 13:38:29 -0500
In-Reply-To: <81e1a94d-531a-2e43-baee-da4b35644e87@oracle.com> (Mike
        Christie's message of "Thu, 18 May 2023 10:03:32 -0500")
Message-ID: <87ttw9fpsq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pziWK-00DKMU-8V;;;mid=<87ttw9fpsq.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/dXqWsNhfo08htcPvm8Hc3O6X+eIhc/TM=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Mike Christie <michael.christie@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 585 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.7 (0.8%), b_tie_ro: 3.3 (0.6%), parse: 1.07
        (0.2%), extract_message_metadata: 3.7 (0.6%), get_uri_detail_list:
        1.48 (0.3%), tests_pri_-2000: 3.2 (0.5%), tests_pri_-1000: 2.1 (0.4%),
        tests_pri_-950: 1.10 (0.2%), tests_pri_-900: 0.89 (0.2%),
        tests_pri_-200: 0.73 (0.1%), tests_pri_-100: 2.8 (0.5%),
        tests_pri_-90: 309 (52.9%), check_bayes: 308 (52.6%), b_tokenize: 4.8
        (0.8%), b_tok_get_all: 7 (1.2%), b_comp_prob: 1.67 (0.3%),
        b_tok_touch_all: 291 (49.8%), b_finish: 0.66 (0.1%), tests_pri_0: 239
        (40.9%), check_dkim_signature: 0.38 (0.1%), check_dkim_adsp: 2.7
        (0.5%), poll_dns_idle: 1.37 (0.2%), tests_pri_10: 1.81 (0.3%),
        tests_pri_500: 6 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 5/8] vhost: Add callback that stops new work and
 waits on running ones
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie <michael.christie@oracle.com> writes:

> On 5/18/23 9:18 AM, Christian Brauner wrote:
>>> @@ -352,12 +353,13 @@ static int vhost_worker(void *data)
>>>  		if (!node) {
>>>  			schedule();
>>>  			/*
>>> -			 * When we get a SIGKILL our release function will
>>> -			 * be called. That will stop new IOs from being queued
>>> -			 * and check for outstanding cmd responses. It will then
>>> -			 * call vhost_task_stop to exit us.
>>> +			 * When we get a SIGKILL we kick off a work to
>>> +			 * run the driver's helper to stop new work and
>>> +			 * handle completions. When they are done they will
>>> +			 * call vhost_task_stop to tell us to exit.
>>>  			 */
>>> -			vhost_task_get_signal();
>>> +			if (vhost_task_get_signal())
>>> +				schedule_work(&dev->destroy_worker);
>>>  		}
>> 
>> I'm pretty sure you still need to actually call exit here. Basically
>> mirror what's done in io_worker_exit() minus the io specific bits.
>
> We do call do_exit(). Once destory_worker has flushed the device and
> all outstanding IO has completed it call vhost_task_stop(). vhost_worker()
> above then breaks out of the loop and returns and vhost_task_fn() does
> do_exit().

I am not certain how you want to structure this but you really should
not call get_signal after it returns positive before you call do_exit.

You are in complete uncharted and untested waters calling get_signal
multiple times, when get_signal figures the proper response is to
call do_exit itself.

Eric

