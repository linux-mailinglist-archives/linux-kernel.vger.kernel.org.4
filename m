Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6085D60FED0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiJ0RIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiJ0RIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:08:32 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517619C06E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666890510; bh=NABj78LeePnrWsmCJTSSxAi1lyBcW3GILO5vwBMEvwA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=e5C2aIxMwBdjdYXA8qHalbzfI0f7FyH9lZujIuq0/+ITJJhVR2vzFDFiwwqEq5IBYtO6S011KHIWsPr1sGRXZsvQpStre+loWCBd5Oy0ixr18Zuem1hoaZUlIthAdzvMPDZCGlglZQpEUoC7nieZCn5AztygW1ULLTAa8M3EsKKdgilvLBuJb9QEsrlgLO0dYJkhlfa+UPDwj5EgjbbWZrQ7IKEDCLZcMSVnmw0H8jSnN0OU+YbRfpoWNJn2BkSxFT+kQnAhw2dJ8M7k10dTVshMSJLASa0bm+99qL6BSq4VddskY79j614ddu5/cMwxoGoe7ZwI+CeAlsUYCW604w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666890510; bh=KrLsVCIRqbRdv6925kaYfs4lQGrvMznp8xg50hLYUbo=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qLXXtzC+sCXUHf3QaiIyedNPeFdeJMBzRpmyEG2HcuS0p6q/iDbOh6OrQMJsv/SvWr9gtX0IP47wjenhLYOp+jHAch4VCMjFrSZ0xlvYQzegS9iP72iegicYlIMWiaX2HJdCl1OV5SwNSk6Y/vPOaisBiVWDsNWNW4PV5Z4cu+3HTCwdg+rNZctgFckXaY9+za7Q/HMIGzv294pRAnGU9LL92vSrS+P2Ht+uqNXylurEhVqHLjlddrRK8lTy0DBRaYd5Xdg3LMfgV/HeS7vJhtJHJ5niq8yF8LIO3HnQHTNHQDSydRnOVQQhcyRRgPvbKasHall7DjKlXfzZAVvF8g==
X-YMail-OSG: r0DFjEQVM1kFGQukkXpApijNLYn9P7Qe8COXsFVjteQpo.iPmpknB2dAEblizze
 5dz6EiA7oVm3G54NJTSw1L42HeH6LYseBwHp6rO50D218phEjp9H9U_yKVWPFRctWG3kBYyoAa0k
 xV4Rg0FMjLRbcc5ZYOF2kJM2p0vs5yxs6zNe6URf2N0AIevgwpzdGY2nmy7ARp4EsGZupIOeAlmt
 c4TMLcs5DO7nveZF8lq09hL1FEj4iAyo2Vo_VNhCuYmbKQMrsLjvRJDuawhd0u.Vun.4vs0GTuch
 uLOtych93cKDHrzSfyfFsbl7h96BxLEDHlM2uAdbNjdtI_AlBd5ONAzFIvg3JEyf36fHJ.hhy3M1
 eOvx4hfm6vubVvWIlImmbA_L.x6poOWVYc9TkW5NtqEcSd1jOmqjyYPhBqikfUHfaMdegBVO7Vff
 GjY4xvGNkXreYTV1pjBClrruTi_w0oH0Wz7keo0XsWrtwNKYNCr6cRFj8XFGeVnuZnhPb9TQLvAv
 _5UNNNNhxsGane4nc3wLpuc.RsdXuMaUq2l4oupZ_MzaKxPf244yNF0Ju3gdTYoFgeDw.CAniq7b
 n2HRumHBlKB0yvQAH_ttxJvjhYi9dLhlxtz4buAZw1qtmxV6tcy6fDFdBZFP_QZLh5bd8ASLzTzl
 DoennPZ3D9_Sfx5YhDLe07nJWJ9UEcl4p_3fOHB3R6bXBwhlEB6ymyF2TCSpYBqkuuuzMflsXFmr
 QLz0ExnD508GPtv01vueCjI5LofYbNaXglzcQ2S1hbZg2Zoq5AqTClL1_ZUAS3TzL4gPKyD4SIdK
 u6hoW6pit0N_DQWnuRYM1PpHHTeSZDtLMfjfBQkMZBW9LVzPeQ53YOpAyOWSaDij47deriY389lS
 _gb0IBFFOWF.TTVS8oZakzB5jwuHYHwG3ClaJTQYSaqqobhZ41DeleKTtHnrVef8Mq1Juzw0mysd
 lxA_8RPF8g3jfy7QN7_GSVIIeufsgx9SI2o2AD3po_MC6roH3XuRKkdUHYb1oB5h_0vrkfKoxMS8
 RugiN5BTXiiqa7QXc2Sq6OAbdh8XXv75xT1E1KNPZlGj4a4nWqN_UfqEKV7wJTd1G9npc2OOIGbY
 XnPpTUul7OpQN3y0c76tdZbvuM.lDrWMd2KuAaeyHyTDdaad4GIPtQZYyz9UzDxfJx9HvJFGZ3AM
 bfumtVZXHkRL4Yh739B2ngmYaUK7V7oIFctpKIEc6L59CFdSv0VfrslTgFKLmzL8vlFIPgT2BtMf
 KFrW2_umFD7wYacDR.HC79t8kSDr4YGlt34kq2xRoyikit5FVRi_Mufy1fNMBGubjMKICVHLAQJt
 vk6zvb1ZM5w_Kxx0DbA2qCQhF.L81khb2HU0o2fFlDhqcrwOpLcAFHkVj14o0TSGaNs2GVJenDiV
 Mgna2ke6z0XQNJKtFhD1PExH.cTOj1SwRXjSbCAQVfzim17ewzOAByKYjyRTRB3cQUl5vOS0HJkD
 bOsnVlIjHjpQYq3bqhUAshpp0T_OLa7mbjhpr.GVz1q3QtUziO9PJoEuHrmlpeyJCuwE6bvXvD22
 RYtADw0kSdbZWgc2nB452byjydbmFB.DiBD57vOAP9iGMRPZ9Mck4hQ_e50DI_QO436.Tou1W9cf
 BVSQDTFQVB8s7xv6N2XQ_HCmtXF3KNFg5DMU4J8gmzuR.aKt6KQuDRW8VMmbxqrQbEU2c.xPJpze
 jHPvGIv3cBeJRN81YuDkMk7.k2rlqWrRoN2oaPk9iAWg29g8RW8IvL5cL2wy9YUBwfYszqfETT7P
 mQAUzyxBB6U6ffOGw9aderKDYGwLfZdye6zQPDgdyynvaEKhON0wjkeRn8nL0lh_wXfSABw06R5g
 wXYEhgzH7tWh7BnIqL6YA9kdPmj90xZYsXz8BBWj3s0YZLA.ik.9nrdxbPJC__AZbbs.fuXQkWEG
 ntSr9ueegsE4ShdvDbxW2HpeR_ipzOnot8uifM6urr4ZSrk58HOC_KubEbGDLcahY3kKbNfdE.6W
 XrX0dP7q23GekCsk8U9VFSYaTQ1eoC_0NPfN590nE_SDuJC0WQAQwEB8coaa7q9wwHwAmkI17cvo
 6TPLQdsa.XsZIuPr0d.2I202zhDiBmtFNAloO6AaZHgrm5SZSzOOaDXqXvnLV_loFUyG.FrX1Z8b
 waDZCDl_lILIv9U7f_iVnxr6kF3OMSxlU_Kk9ZQNNIaGA_PuhSvoCNOSBsoWnWYi.Uhs6h1vx0Y9
 iOCalOZpOWv2hddhmpQ4A16F6oAlFRqyXTQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Oct 2022 17:08:30 +0000
Received: by hermes--production-bf1-64dccd5d47-xwnrk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 49de2d6ebdd7a06deb67a493659f9368;
          Thu, 27 Oct 2022 17:08:26 +0000 (UTC)
Message-ID: <d545ef2a-5cc5-2848-e699-ff791d34d7c7@schaufler-ca.com>
Date:   Thu, 27 Oct 2022 10:08:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 4/8] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-5-casey@schaufler-ca.com> <Y1jNGMKfb+NUPrJS@kroah.com>
 <e3949b66-26fe-807e-a626-79ca78396e8a@schaufler-ca.com>
 <Y1olXIbTGx9NnthU@kroah.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Y1olXIbTGx9NnthU@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2022 11:29 PM, Greg KH wrote:
> On Wed, Oct 26, 2022 at 05:38:21PM -0700, Casey Schaufler wrote:
>> On 10/25/2022 11:00 PM, Greg KH wrote:
>>> On Tue, Oct 25, 2022 at 11:45:15AM -0700, Casey Schaufler wrote:
>>>> As LSMs are registered add their lsm_id pointers to a table.
>>>> This will be used later for attribute reporting.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>  include/linux/security.h | 17 +++++++++++++++++
>>>>  security/security.c      | 18 ++++++++++++++++++
>>>>  2 files changed, 35 insertions(+)
>>>>
>>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>>> index ca1b7109c0db..e1678594d983 100644
>>>> --- a/include/linux/security.h
>>>> +++ b/include/linux/security.h
>>>> @@ -138,6 +138,23 @@ enum lockdown_reason {
>>>>  
>>>>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>>>>  
>>>> +#define LSMID_ENTRIES ( \
>>>> +	1 + /* capabilities */ \
>>> No #define for capabilities?
>> Nope. There isn't one. CONFIG_SECURITY takes care of it.
>>
>>>> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
>>>> +	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
>>>> +
>>>> +extern int lsm_id;
>>> u64?
>> u32. I doubt we'll get more than 32K security modules.
> These should be bits, not values, right?

lsm_id is the count of security modules that are registered.
It seemed like a good name for the value at the time, but as
it's causing confusion I should probably change it.

> Wait, this magic entry value is going to change depeneding on what is,
> or is not, enabled.  How is that a stable user/kernel api at all?
>
> confused.

I'll clarify.

This patch isn't implementing an API, but is required by subsequent
patches that do. Does linux-api want to see patches that are in support
of APIs, or just those with actual API implementation?

Thank you.

> greg k-h
