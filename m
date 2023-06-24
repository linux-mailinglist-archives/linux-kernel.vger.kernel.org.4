Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF473C5E5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjFXBml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 21:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjFXBmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 21:42:39 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06742727
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 18:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687570957; bh=HkrT9Fdmy+qWou3tHhwSEBWddayVUBpp9wbKnyKY8fU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=USWWTjdV3jh4b9pQettCYE2n5Og2UfFDStah6fb9LnKMZNqF2H+dXlbfMqR3bm1dBPl2ebvs6Hh2UKsLdwHp1GjPq63fGwFBmobZveEDfJcxZJAZAtMgYBsUtn2N5t8b2YWXDXtP6OTvIaP1ZYIz2lzKG4C07IErYvhW7ZMt7W1Hp6QInWAI5pRrzurrXDFMPAnVgzCgkIUE2WqmjGp7chB2Q0/SXJGOThgmKjnDHz90ixv3zgHubGn8TCcBa+yHFxl7vNr+47rORbUqpY7ksSpZtNu3kwTl0yZ79BnaTcMSEWZDPiGRXLya3gl27tAyagf6gaDSRj4LnKMvcqJmQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1687570957; bh=CeLCKH16mMqssmyEmAog7k2MNIax60ZTu+WhbtYdBAL=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HPI+poAHRUtanOx3K6HQUh5qvewgPXOa4HpACZlRhXj18p+wXoeu3ps8E1yINXx0/yseEjsPTrrm7tl2BNdeggiM9d3pYvsztGNGLGS2BQL8eyqbbn9YXzh0WQNfN1Zzzls8MMmKoDujzVc1Tk3mReKpfcOc7F6rfTMxd7YePNxFZdXPbZEbjBzjmYPcD7+kdc1eaQ000V+KPi4NK0Hog/u5m4dcQGA6HLUhGXSCiJKDFjODvBqCFmLn53SkjHmTuzrM6UT43bImewMKMdScVDjDpZY4LGOukhr/u2YCKdxSe3aE1AYRuRjuo+Tqj/XrfWLy/k7OEbrxMO/wTQXVMQ==
X-YMail-OSG: qW7rQtQVM1n7hsYNKm5Z_VF3GZbIFgBZE5U7QSf.1zruWqhSYFfT8ml5Q0d3fNb
 qJmO0YnXaC5tYNQkyj5..Uaj4hnWk8EEHKIWKYNeq7DwmwWNzMQMmh53jfuoKjozKqRKuSSdgebn
 uMaWeQl_x84e_4jLp93UJJcEkCR60SUz6iiZTo9wlJRZO5KtJe.bEAprtC2UPmG_zo1qZogamjYm
 I5_Mcp5CI3qcOKU3eBrFV9h7W5n46i_SoQRe6Ik5bY2HanPiT35pOKf0PEuXin2IsA5wHTPZUOdP
 f4Td13vBVL73frDYzJ17uQy1GwUP.YEkM6K0ovFMc8.gCwMi9ON5zCjO.vjorb7.8stSWwIQyWJg
 9HIaI2SCvlEEtBE6_s4KVPWA863pRglQzuwSE.yF1t4EBBp1BeOcHpr6Zcex5Ff_GftGcWq71w56
 rsBE020d7H60fSFEW4GDtrCtluEqzg94oVfIFFhTOS5bAOR6yJL1RC6mLImYzicDAOXYVopeYZVn
 CH64OnXrzE_QejkanhICKRiAH7daJY2Upk1X2fcwKxgOxjsCHLEZXuWwn.G6mbTnh.5QARCThNG7
 mQ_zxA.E_Vqwa6e8NFIGZX7urfLkZ8gkklEKCaL1vQVZpxANxzHBD2nn2R1dk3TEyPc0kHIq_elB
 82G0eoOQtbiO3jKLaXcWwnNAiDMMg_eLz_K73EPWfdlDpEoZFuENKz_OimAUoz997MUDEUbS8K.Q
 mtzvfQFbT4hYb9UL_pQ8hPpf6vvqz53WU.50aF2eCcUwOwlc7iJ9L9Ht0TUaLLzm_eOFdKPaKBdV
 _FnwaEGJbgkLkEfKv29P0KTIz1nb9mrOQKyO0xqmaGAVzNQEjWEi9sFTRvmL09cqK_kTrJ9nLi1U
 ZonTnCP5LGRsHzLp1.RLwt3d8VZbwYrfx_VI5x5Apxxz.qwDU7fmZC675mrMVPUkyFZ.YJgIEJUZ
 7f2L05U0l2AtO5mkxVMs_5MzbroyHdl8LEa7RNoyQRvCn8i5nqTRmOFYzTrIBsLaol7Yy_xES4Wn
 ULJITu8_X_VQvX7OzfaWNwb4i1EEJm7Vdq2OHBexBRtJqeO6eXNWfj4RxNT_16DFiCEFN_NXolgT
 Ia5KBcHM8GYowcFjE4277KMOBf1Oyb8zvBJuZzES4QMcrN8LqjAGzWXj2JZqOquD1bsgDcBEcL5k
 trH1GR2GiEKL6.ZAahsOPxUdWqah2j5FygyUKOuSMuLbAzp..PpUANUWD_dxCBsxVyynLKIFoqeq
 1V9taISaAQN9KwzfWaKypF.mjEZKfDI8voSNN3W5dXTE.6jw7DDzhdBks0.bPNTrjK_ECwdHGHt1
 .T_3zn_6TYjWBjn7p8FltV00icX7_ixda8oLX3VMuf3DwCs9IpUa7nnTrSQiThU_hTlDVeePCAqR
 POe.TEUK2t2AvJNUEl9XyXdbNu77CL6eXuVyEqr576n.TF9tdopNfOmr_YbGp7H8Db4m406EV7O4
 VhwkQd.pJ.1KeW28rRQvnk85QyMoNmAdxbscPf5Rmr.mjqqDatzUEKB.PkOTqQwstVSgbOUtdriR
 9VhInXUW3GTecIjYOh_FikwokytW4AB7mbX8swjSIMhDHjilPrs6FZNTOFCZB6hPHC_.2opFAjSs
 8g4k8ApZWGPvwL5KdQaXjOBmHLzTP1eG6RKcozwsumWAMWdmV55Zi5RGu0_JjefyN9HzdYaArHj1
 UzIa6XF1qJlrP_7xZtxrLZA_.CRKdA64JnT7GCLxPpyRjGnB6gsT5595iLW1BmY6H.aJ2BBhg56S
 976wwazaHHN2ZTM9AxvXadzSEL7..PCbaLqWyLh9QY5x0KyMd5WajJ1qOf1xgb3ALfP1HkPEQDkI
 .paif7kf7NNKeueZEwTCNx1W423V1JH9GIu67IhzjSO9TmrvlJpW3pQT.dhWP9QZduOLEJiM6Ok_
 IS2TXHp94_RhM4F6xYMf7Pmg6FVmgNS9kH0FJIdaZlGOYiBAAG7umC_nVqJ.eE2ZJr6QWWSzljIy
 Sw_t.DXXx9xVjAPaczrWIQ_CF16gtEh9gDwHtYE0oGY53EYeO1.O3S8WJCao1v5jEU1hfsGUj5bG
 GsWYotvzJ6WL5.oC0qTvbj24m5ZPIznSnIH.h5729oHSbATzV7KtOXSO_lolCwtA_oOvbUKTZ4WX
 yXPaIEABfl1KZh8mizgqqzQkGNMm1ieOxcfF3i12Fb4g6zPIG06niCHdFCSGCUCr2auow5msDFE3
 MfbZfbmJnTTQUCVCgfVLpCqOgk3EgXbaIBJFBnKhH8g7ajJt4L8b9ErT2mnkY.f6TZSL_V3weE.O
 vINmoIkDZZ.bn.N2Rrg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b1e5ffb0-6d22-4ed8-9be6-2d92a064b5c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 24 Jun 2023 01:42:37 +0000
Received: by hermes--production-bf1-54475bbfff-wwb88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c7030251031f4739a0ee64d6090003c6;
          Sat, 24 Jun 2023 01:42:32 +0000 (UTC)
Message-ID: <55ffce53-077c-1766-af83-594b788dbd99@schaufler-ca.com>
Date:   Fri, 23 Jun 2023 18:42:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v11 00/11] LSM: Three basic syscalls
Content-Language: en-US
To:     Jay Freyensee <why2jjj.linux@gmail.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230616165055.4705-1-casey.ref@schaufler-ca.com>
 <20230616165055.4705-1-casey@schaufler-ca.com>
 <403108b1-5600-bb5e-a0ad-6f802b4b296f@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <403108b1-5600-bb5e-a0ad-6f802b4b296f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21557 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/2023 6:10 PM, Jay Freyensee wrote:
>
> On 6/16/23 9:50 AM, Casey Schaufler wrote:
>> Add three system calls for the Linux Security Module ABI.
>>
>> lsm_get_self_attr() provides the security module specific attributes
>> that have previously been visible in the /proc/self/attr directory.
>> For each security module that uses the specified attribute on the
>> current process the system call will return an LSM identifier and
>> the value of the attribute. The LSM and attribute identifier values
>> are defined in include/uapi/linux/lsm.h
>>
>> LSM identifiers are simple integers and reflect the order in which
>> the LSM was added to the mainline kernel. This is a convention, not
>> a promise of the API. LSM identifiers below the value of 100 are
>> reserved for unspecified future uses. That could include information
>> about the security infrastructure itself, or about how multiple LSMs
>> might interact with each other.
>>
>> A new LSM hook security_getselfattr() is introduced to get the
>> required information from the security modules. This is similar
>> to the existing security_getprocattr() hook, but specifies the
>> format in which string data is returned and requires the module
>> to put the information into a userspace destination.
>>
>> lsm_set_self_attr() changes the specified LSM attribute. Only one
>> attribute can be changed at a time, and then only if the specified
>> security module allows the change.
>>
>> A new LSM hook security_setselfattr() is introduced to set the
>> required information in the security modules. This is similar
>> to the existing security_setprocattr() hook, but specifies the
>> format in which string data is presented and requires the module
>> to get the information from a userspace destination.
>>
>> lsm_list_modules() provides the LSM identifiers, in order, of the
>> security modules that are active on the system. This has been
>> available in the securityfs file /sys/kernel/security/lsm.
> Active or available?

Active. Security modules are registered during init time.
There isn't really a notion of "available" since you can't
enable or disable them dynamically.

>
> If I use landlock's documentation example:
>
> Jun 07 10:37:11 fedora kernel: LSM: initializing
> lsm=lockdown,capability,yama,integrity,selinux,bpf>
> Jun 07 10:37:11 fedora kernel: landlock: Up and running.
>
> My interpretation of the two log lines is the first line tells me
> landlock is available on the distro (fedora this case), but the second
> line tells me landlock is now active. Thus the lsm available list may
> be different than the lsm active list.

Your "available" list would depend on which modules are compiled in.
There is no explicit mechanism provided to get that list. There isn't
anything interesting you could do with it on a running system.

>
> So is lsm_list_modules() going to tell me just what lsm's are
> available in a distro for use, or is it going to tell me what lsm's
> are available _and_ active?

As documented, its going to tell you which are active.
You can infer that a module is available if it is active.
You cannot infer that a module isn't "available", that is,
isn't compiled in, if it isn't active.

>
> Thanks,
>
> Jay
>
