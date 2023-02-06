Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C911468BAAA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBFKqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBFKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:46:41 -0500
Received: from smtpcmd0642.aruba.it (smtpcmd0642.aruba.it [62.149.156.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984D6E98
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:46:39 -0800 (PST)
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id Oz19pgLlpv78AOz19p7chI; Mon, 06 Feb 2023 11:46:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1675680396; bh=A4yP1CKLaZ8NLbdUTIw5ph3K/9y9Q3otLcga3VvQY4A=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=LsVR3CgfZXJ5WdQqk+XTtI1Il4WtOuzbPvjW+CdonUQZfJWWY7xK7p/r8+QAVB5qK
         Tm/kfuXL8DZtBOjhb5HJ8n02n/Ykhdy1m4o2B8i1SppUtYViTnz1/ARfqorzoN48CE
         C9a5GOxisj0PtKNmgOj0wBtLf/OfcKXMKx38jtffl92l0Ka7sLk+VfYE0WhQmXt6gG
         FAJimVhxpUSEwEr5keDL+TyTG6uYoUcJ+x6EJ+cwiIzFG2qzu+ThBRrAyWxkgHudsM
         pQ6Myv6DAq5QSE5Z7nM9ehH442Xuo+76Wf6DwWhttAdzJu3VeMuMCS/PPS7KjRsPib
         g64Be62toYAXg==
Message-ID: <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
Date:   Mon, 6 Feb 2023 11:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: PPS functionality for Intel Timed I/O
Content-Language: en-US
To:     "N, Pandith" <pandith.n@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
 <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOG4BnWq84EO12EY+RsEsyEGsiqNkTSAbOCuq9RGPdrbw6c0EaF129RCyslEzMiAy3X7vc80Ik/6r5fHIAzDx1LYqFq+OaSerRlQk61WZC65QKqlSMnk
 yNDnzOq5gttrUt20v0XKJqpG+qljV+95jktkKDhnHRQs6e2TXXWeEtnFeTyR3jHzKduDu36axZpxvOd49AlgM5rDLVjKLJZ6mGnkXS1gVP+e3yuQFV7Nkfu3
 vf2Pm7zE7RE8dDdmBZFQla8pMu0emlqaISa4Y6G3gbUNGO85cS3tuydqNoPn7AIgRZvLvk5VgW/VWM7fSlXRU7iS13PZttCQfHQeKHO/b54shY3Vfqg7buI5
 /1BHmAuBF+tiPOgO7V4aXAYGzxVKSRHvtBjpzEJRAKcxP1Qgo0DX9HmRBW46wTSd+QJaxWTx
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/23 11:16, N, Pandith wrote:
> Hi Rodolfo,

Hi

>> -----Original Message-----
>> From: Rodolfo Giometti <giometti@enneenne.com>
>> Sent: Monday, January 30, 2023 7:57 PM
>> To: N, Pandith <pandith.n@intel.com>
>> Cc: linux-kernel@vger.kernel.org; Sangannavar, Mallikarjunappa
>> <mallikarjunappa.sangannavar@intel.com>; D, Lakshmi Sowjanya
>> <lakshmi.sowjanya.d@intel.com>; T R, Thejesh Reddy
>> <thejesh.reddy.t.r@intel.com>; Hall, Christopher S
>> <christopher.s.hall@intel.com>
>> Subject: Re: PPS functionality for Intel Timed I/O

>> Within kernel sources PPS clients and PPS generators are placed into different
>> directories, so I suppose is better to deploy two different pieces of code.
>>
> We are planning to add a new PPS generator driver in drivers/pps/generators
> i) Can this driver use pps_register_source to register Intel Timed I/O device for pulse generation ?

Nope. This function is for pps clients only. PPS generators should generate 
their pulses according to system clock so they don't needed any registrations at 
all under PPS layer.

> ii) To start/stop pulse, we are planning to add additional sysfs attribute from our main driver.
> Something like : /sys/class/ppsX/enable_pin
> This is needed for users to start/stop pulse generation.

If you are still talking about PPS generators they have no entries under 
/sys/class/ppsX/ (just clients have). So you can add an entry under your driver 
to do so.

>> However pay attention to the fact that a PPS generator should be referred to
>> system's main clock and not to peripherals' clock.
>>
> We can sync with the system time for pulse generation.

Mmm... I'm not sure this is correct since PPS generators should generate their 
pulses according to system clock and not according to their internal clocks even 
if they are synced with the system clock.

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

