Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17E600D99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiJQLTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJQLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:19:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6375F22B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:19:10 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1okO9F-0003cK-6C; Mon, 17 Oct 2022 13:19:09 +0200
Message-ID: <241af90a-4cec-9266-8fb0-3c69f9880b52@leemhuis.info>
Date:   Mon, 17 Oct 2022 13:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-gfx] alderlake crashes (random memory corruption?) with
 6.0 i915 / ucode related
Content-Language: en-US, de-DE
To:     Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
 <87a65usvgq.fsf@intel.com> <877d0ysv1e.fsf@intel.com>
 <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <717fb4ab-5225-884f-37f9-2032c265824e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666005550;ea53a1e5;
X-HE-SMSGID: 1okO9F-0003cK-6C
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 17.10.22 12:48, Hans de Goede wrote:
> On 10/17/22 10:39, Jani Nikula wrote:
>> On Mon, 17 Oct 2022, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>>> On Thu, 13 Oct 2022, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> With 6.0 the following WARN triggers:
>>>> drivers/gpu/drm/i915/display/intel_bios.c:477:
>>>>
>>>>         drm_WARN(&i915->drm, min_size == 0,
>>>>                  "Block %d min_size is zero\n", section_id);
>>>
>>> What's the value of section_id that gets printed?
>>
>> I'm guessing this is [1] fixed by commit d3a7051841f0 ("drm/i915/bios:
>> Use hardcoded fp_timing size for generating LFP data pointers") in
>> v6.1-rc1.
>>
>> I don't think this is the root cause for your issues, but I wonder if
>> you could try v6.1-rc1 or drm-tip and see if we've fixed the other stuff
>> already too?
> 
> 6.1-rc1 indeed does not trigger the drm_WARN and for now (couple of
> reboots, running for 5 minutes now) it seems stable. 6.0.0 usually
> crashed during boot (but not always).
> 
> Do you think it would be worthwhile to try 6.0.0 with d3a7051841f0 ?
> 
> Any other commits which I can try before I go down the bisect route ?
> 
> (I'm assuming this will also affect other users, so we really need
> to fix this for 6.0.x

+1

> before it starts hitting Arch + Fedora users)

FWIW, I heard both openSUSE Tumbleweed and Arch switched to 6.0.y in the
past few days already.

Ciao, Thorsten
