Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7EA62387F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiKJA5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiKJA5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:57:15 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B27521834
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668041833; bh=sgfabkyNR6mX/ERtH/pUts6++dUJ+Ber6tLXSuSl/vQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fwne6qvwZNv7DJREdRzls3F9Q//Oj8aND0MvsnPNiNPtAEsQBH1eUzWO1pHcQBpQ4GxtQN258kKOEOspPcCmtCj8w/v9tDEyiUO2VAowep/KPtNk13HDyuGlHF4tkyXrGed1uXQRf0dHMF4j4MRNfW6Wy++Sf9YCqXXLHXyHq78HTKSyE9gs0EXP3zLyM7bbGuQmrWPRfer7q2ra2nJXpC0hVyZVSMg0E1qwB+2yB9I40apjst9DLcuC20SjQx9cJt2ctYUZAzzeq83t1emVS/MK52AC5Wq/vYOUzb791At/PvjSRbt2IfIVNyOSCNPSc9UVcWzS/kVKLnR5GBzZfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668041833; bh=t/tOBHTPdtISZyeAK1TZ6fFYLM9WdaZRpwDGE9y3tXQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PGFHs3j1g2xNcFfnUwHMwvi1wwNEzwGDoBurffthkTyPvx0gR3jNQQQVHIEXXwAZggD6TCCRzCUcCk2+f4K89+hlr7smDl0WyFS96ZSYoW43KLukslrD63GcPIOyezEh+cy0tVcNemnZnfm+ImAqVwbRldhttTQecw5urG3NBne0CDm5j5UCJ6NjxNN3K2d8UPyEjQnk2SQvsFueb+bQ9aZ+mxMZjTpjuyahCWZ35yonYRAVEUvtLTzxKzwVogSY8ekAj2QNvX2BkqtYEB3Jf7T+IjrxcTRfgYaIF73lPvCbdw2k4ykiwO6x+uShk0xrq2JUG1DBcPrr6mCu1mUr2A==
X-YMail-OSG: UxNJ9RUVM1lGG.pTki5KDNVEHnJzqZr5I0IxRQvTLEIm7k8CldvRs61lORrKeUy
 gjo2862aZiXIWA7GZfmEypOrPw6x7g1491zuXFyFdMGFNErkoS.21sMFpdN.p8VdGj_.zA8whMbF
 7tDab2GNvGP3a5F7oR165KmDAE3t0H4oWH6WcWoFThpJ7jUHvAvmK5yIH4Izb0bpJVVzT86NpbR6
 jGH3ji9m.HJJF_Qgf2sxq8DDFY0na6H2yhv1q1XsCnxi.xhxjFjqwDRvswQQwWggNh8Eor8zHoDM
 Cc56f5afrm1NrCj9FkFYh8WFHirKxsdwvxooDF5nBuARZDy__n8s_E21Wb1z5F9JR754pMbU_2WV
 qNk4l0.cSfMFkfjRFz6XHu5kXdVZm2aF9t.2wjsosxZ5Fxw2seKNBBZeyxuQVzADejzBfv1KsGVz
 Y54cKFn_yW4tbFl7vIL.1a2FLhU.CnRLasZZorkOGlR.nVPAGwxMSfTyF4F9Z6XJsb_4jjRFXGLJ
 eQTEzdCgD5iTXgcHDNuwT1Ojkb.nCP9ZXI_GaySs86ps4.f7LriniHvYtCe._z3XtyosKc4DYZrO
 ZTzwb5PIfZVUOC7SavihAExhm9g.HrkNBponcYQ8jiN2f2hycf6m9rrULVVJxt1v4DBOvriKGecF
 z2Rii4o4_PpGX0vBzSo3pJkff.EcX3yrkUjfgcQ.RPvvZzePhryxw5gNXVd6tzHFlSJ9ndF0R_gM
 JXxftgSGpYDwgQjDoOfWJRjzSX.vyQeAtfm76pVzhGI19afLxlY3irmGCA_euXxYEMbWGuLNefW6
 tTax8WXCt08SECNj5gTjATH1gzF_M3gWZM7ZQygjTiQTwAhRXUvlIxs3JzU2iCAwNbiaPl1pz6Hq
 ZUg.TLKbJEaBkV4kLWiktDR0nT7FoSCUaNp_kquKnsQH19pOkMxsK1vi.CWefv03e62H8BR9Iv8o
 2x5PhZvV.GlgAcILPyxRa7no7.qJueEMs.Yw2Va47tRBhYP22g67SuLmAnlEQcdpJ42t.LCcVy0X
 RnjRUdsYZBtxW2hVzYvN7nu9NHLdM_XUVXm6BJ7nU0oGn.s519_2BJiksx8FuhIOe2zCAu4O_XC_
 DrsBZTsIKfEsIAxb1eKzNn.sAJtqoVMnLfI_PP9s7c6d8OQlY3ADhyxIWnY4L4ZVceLbhvS1dxR6
 OvNJP4_e_esa.k.5_gpdy5wiNpC_47M9nix5m9a5YUq0PocDNXwEZrM_ZkZe4G5MeJV7yLlxOo2m
 aPbOdZg3xuJu8lfisokTCr_pC9i96s662dyQ7XhSv_.92UgWm0dCb9ft6UswZh6yzY6R83nT5.oX
 7xszCDvLgd_uKqvkPRIPLxcmBL_fwBqkXS88wD.7Nl_GYiQMZAIAI6cN4zCRFIbekP21uOIOxNfO
 b_KNqhOrWYONu3NzcnrtKv.vnq1UjcB_UqQeo0FoDbvg2fsRqFg47Ni4sS167BHfjtRAkEas9a30
 yq_ufN8VIhFII1wrGNwa54EB7eBG0iZItyx3LotNI7Cqr3Uk3eEt.3dLTzSD1mxq6Woab4ka8QtE
 GRNE0oqEdiChrDNLbl.zvNZ.ApAK6ckM.x0pMj3LR5_OTGvbuHpAqhlYbBm9EPsZ8LBfsT6d_o7s
 4uYmE0iZqLXaKFec0m8OJpB0HMlDOEr8baj1EH4f.Q6JUmpwicvLqiBryJIgBy8fquyMudCqilfr
 7KNv_Qtks5D.FymbC7yAftpzNkuLRy7GiSaGsxWy7l3Li3Vz9.dCJzd.7S390o6fczPXkZ71a_.R
 5_t5w0waIfpL23V75o7giNcTJzB02K3bmIUdQ8sSdDQFFtTxRxMF67ZSgm4hjsdtFwrBCoLi.su8
 7u9vM5qlLVwDq5mEG.j_P3WkJ07LPuntabW5GAM6_EFkuNMxcWt55dUn76pasyAKKHHM650xxVnw
 0NNjm1dL_P_vfhV01x0ExauevN.nsqpZMAImnvBMIAV97ATXyXGBH5ntzT6GxvAyptdo1Q4g_MvX
 TY8qJCtvxE6Xk5L2w9GtzmivA4VLAf3OPt_YemGqch72ysS5iie9E_xePToDTV8ZIP28lZW2kgiR
 yAR8uWpOpVAgP9ATVYYDk7RbgyWkoUWUYQce9JkaIobGFaj0VtD2907GPO_ejmix_phMBJijoD6.
 2yqdT2uM788kp8FjN.u_BAbRadj2J_rjro5yI.C6p_8gEgYzOB1PX2LnXo0.JGifscvtf0YBebL8
 NSR5Jz6sVAAPCZQLOYpH3WkocF_k-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Nov 2022 00:57:13 +0000
Received: by hermes--production-bf1-5878955b5f-686fw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f6d1717e5e77e52e6a2ebe2a1c83b12;
          Thu, 10 Nov 2022 00:57:07 +0000 (UTC)
Message-ID: <20cdb098-400e-25d0-f93e-98efb1095b68@schaufler-ca.com>
Date:   Wed, 9 Nov 2022 16:57:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com> <Y1jMeWl0oV4/2zyE@kroah.com>
 <5396ab1e-9b93-df33-ca49-58dc59459a76@schaufler-ca.com>
 <Y1olsHWnaEk6+b1L@kroah.com>
 <612c169c-2e11-13cf-9742-19714a247152@schaufler-ca.com>
 <CAHC9VhR8_aQFxBq4fG=q8FgVUEZAL6F_iSE9kFnO7Mf4tf52AQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR8_aQFxBq4fG=q8FgVUEZAL6F_iSE9kFnO7Mf4tf52AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20826 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2022 3:33 PM, Paul Moore wrote:
> On Fri, Oct 28, 2022 at 12:55 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/26/2022 11:31 PM, Greg KH wrote:
>>> On Wed, Oct 26, 2022 at 12:36:34PM -0700, Casey Schaufler wrote:
>>>>>> + *
>>>>>> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>>>>>> + * Copyright (C) Intel Corporation
>>>>> No date for Intel?
>>>> The latest guidance I have received is that Intel does not want a date.
>>> Ok, then I need to have an Intel lawyer sign off on a patch that does
>>> this in order to have that be their official statement.  Otherwise, it
>>> needs a date.
>> Seems I misunderstood something. The date will be there.
>>
>>>>>> + */
>>>>>> +
>>>>>> +#ifndef _UAPI_LINUX_LSM_H
>>>>>> +#define _UAPI_LINUX_LSM_H
>>>>>> +
>>>>>> +/*
>>>>>> + * ID values to identify security modules.
>>>>>> + * A system may use more than one security module.
>>>>>> + *
>>>>>> + * LSM_ID_XXX values 0 - 31 are reserved for future use
>>>>> Reserved for what?  Why?
>>>> You're not the first person to ask.
>>> And the answer is?
>> There hasn't been an argument for it beyond "just in case".
>> I can't see a rational reason to reserve specific numbers as
>> I don't see value in LSM ranges.
>>
>>>> I'll remove the reserved values for the next version.
>>> Because we asked it will be removed?
>> Because I don't have a good reason for including it and it
>> has been called into question. If a reviewer has a legitimate
>> case for reserved values they may be back.
> Sorry for the delay, I was away for a couple of weeks and limiting my
> patch review to bug fixes, critical stuff, etc. but normal service is
> resuming this week ...
>
> I was the one who originally added the note on reserved values in my
> original strawman proposal and I suspect Casey just carried that
> forward into his patches, so feel free to blame me.

Done!

>   My reason for
> doing so is rather simple, we're going to treat the ID as a 32-bit
> value so we have *plenty* of room (just the thought of supporting +4
> billion unique LSMs is comically insane), and I'd like to try and
> leave some space for yet-undetermined "special" things that we might
> need to convey in the LSM syscalls.  For example, this would allow us
> to convey additional information to userspace when an application
> asked for labeling information using one of these reserved LSM IDs;
> applications which did not know (or care) about the special ID would
> continue to function normally but augmented/new applications would be
> able to make sense of the additional information ... and we wouldn't
> have to add a new syscall to do it.

I don't see how

	#define LSM_ID_SPECIAL	2

is better than

	#define LSM_ID_SPECIAL	13

There's no reason to "group" LSM_ID values, nor have a range of them.
Really, I don't care one way or the other. I will bend to whatever will
is stronger.

> It's basically really cheap futureproofing with little downside (we
> can always reclaim it at a later date if really necessary).  I've done
> similar things on other projects and it has proven to be useful in a
> few, and in none of the cases has it proven to be a problem.
>
> --
> paul-moore.com
