Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9BD61184C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJ1Qz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJ1QzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:55:06 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D7C3ECE5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666976104; bh=USvzCPd0E6P3/NEsNOIQjiv0Sgmot1DiPjCpRG3MEgg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=kTgWczZBKKmTTCcrMWIKeczHqSL6W7ojknqxNLBS73o1kPh4tBjGbjI5sLIW+KJ7QxkdZ5Ig3qDJAjlBTcPHkXLiF15mvq0dGwnvvPAcsV5NDOySof5Vxa0t1qa1Oa4LnnTLGHJSmduQ+BidonuB0Qq5YtYxqJ5455E1Tx3ySKVIBQG1xQlczwQYlcmCMX5JFsWlxJzbrCNjdVgZZSRYx9QsqO4rvDQ+Esg6wARco9cJv1jpDgGa28uie5Uyzyzw9lit9+egt/sc04azueir7k/c8JHEk1FkP5M9o6hgY10lXkmt1Usl6kmVWgNVzfBr0vKuUDDeq+ORunqzBqnzuA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666976104; bh=7i1AeYfxky6U0ak/YwqMIr95KFFuFbV2XSjvKqZW6mj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZKs//0lgfSvtE5rgrTSoshrlo6yZhaG5pSpIVrbAPoF2+KxlK1wVo2f8I6Ceytx9O+8F5dSL7k4ByiVL3ByMJ4obk7xESCcMhmevQ2PPntfdRZj8a/NcvdQWPlYhCI2T26lqj3/CmS8gIQhhZJR7JuVCf/f6bjquTpbeuK8tcnJADqSfjsrk300hFYE+52d/JQY+kmlcz+HFZM8YGaFn1ND2yOOAPgtCuwun4qSKaQ6CjhgLmFI1eZQwqlWPFouy46VQkdWxKDnfkDzgC70HaZELCIX0BKyfvcT8o9zHJAC8h7zTi0YgVz9PGEFHPr2hHpoKRI4Zj4deMeMTO0H90w==
X-YMail-OSG: us23g6QVM1lciwlfpT8NDmeF.nnGodquVNNNkwa.BvxLZT_IDTjSOeyprR_KsQz
 1NsnHJIJ1j_N08ju4x9kWS5eTIHR3oF.1sRYEfbAYuz3TSuRGshgMndV3q4PboWqEI5B51dCMD4y
 lgZyAmyc7lgYkRJe1r9s8kxx7a267Yu2zzIy0NMShM0U0PVs5hYoJGgCsLiCEAvzRVno0L8h0p_E
 cThqNQgKugn4BuFk_mq8l.jXjhBxtn0yKJshBLbCPQ13UE_1aDhy.ubF2Ksl5gYc6NsmQrapKMrY
 pzy2.HQOYhdWbCs_aeepFMQbNq9UEf65TMCpE6ffzHJvgn2Gw0F6XFDKOhIBC0P8OE4XB.DptpeM
 c6eeOF7c23OpHjkhue099GazFbfgTjVk8cfP0xl4sVRrEsanygCaX2MZAMAZjWXoLMtP4C11s11l
 sk9SWq07t9.56bC5RIoAgMZYFui7gI3QOPsZzqP6gvww24bH5JqKX9oShJEiZs4MV6xDhpjYdTVS
 zKagFXKEfbfEMS5TTXa7ALNSVFe16NooPujXApeXHlsfbY4AJ14ZrM.a_RqpfUVZJCYPbTs77NhE
 BCKjqZCz.x0GxLodh3flsd4KAP85XyFsUuZn.QR8nGOHMa0grBrbcT63LaCQGe6KPwwLS0IIGYIO
 6Y_wRuvhBk6i_vzKq.wwvcIfEByK0JzGlN4.UfejkoslfRA44X4OxZfe8vgOwt.rL1TqJZDujHcE
 hvKxvwph_5LrmU4nzY.XImNaWpVLMpr4pgYtpZt1f.w_G.79Kkm3qBP4rWwrVo7VR2p3Arerhy1J
 iQmA03rWPiW0Hx8xNe0Lf6iIgD9hMmo.MgC6OZQPbvlZR9YIa3v2kl90o2Y9BHvlQr4vwh2c8nT7
 c87VyrWPIB68IBcoomeEEZtqukaguu8xIojPtIXYh.WRNL4d1ysvg3ijfFz6mh3ip4fvqVm3GtXR
 sdXpBrmvNyy9RMQ8jI9vNoQvhoR2ddvddc42hTLIhPhbNN6wDdGcEvCjcUz2dzvpyu.pFJDl7UnX
 .yzoP7k7wmnkBsknIJPm.5m7SCc0UrAttP.6ZHeEUjCldzPVmunFlEveSqji8OGfujlaK43SQMZS
 f2Y2SQA7.43_3el2xg_nE6KsSY7I4xuGo_NUO1EDc3hWPVkbPjatf9ut2vAfLzrF_6og92Q4Ag.h
 etdTCia89cG09c7MGhP_QT5voib4zKQ64ycOQM7RCT47YZab8fKn0CBwOnAgEwc811hyoUXi59Pu
 7sH86fLfRgF_I0KArHLIvOX19JN_oEZoKtEkj4l6Bx.eH6ba60N3rx71ovF2jjlCKO.fTgpacCSk
 7L_wH5IsFyHtOaOWfi8oAYZ.4c1BdyXX8GrUCm8Ob4o5IY7X.5ejkt.wTo9F9nGSMvmTRa6AxnVW
 J5DTFtjkLJrprkcUE_h555QIAOLEI8t9z1TGMF_hM4X4Pm0wESM8Au0o7NfBMougUGe53D3V6_.2
 r0A_T_8EjYGjkTc4VEoFifSBzq41yUwt6.svV8SL_rnvPKq2lg45kAGOQxcmj2P7xtYBsVmRqTvw
 tzZWgn1ROor._zbQ.LL0TY8c0s3hdetz2fkd6tsPbHhmTguU5d3Vy4T_jdxzvnqcQdDX4ytq2CHJ
 4qF6LCeTdT9ieuCYZIWQdUI4Vrf5Tsa_QSHCKLImoDTD3iQa2xqdXTZ4861sRv6wKOLIRPANvMAH
 SRnfz3EW4U909sRpfj7Qi_0E2_f9pRWvlrHY0S8z5iCD9GVLI5Cn5nLapEKb_swTN99uqUoeCH0c
 _iV.terwuSsH5EdaqPnLP5l0NFTxSJK_krrbh69qFHcE03nyAh08.xZTrPNntb40J2jGMeyUY.Pt
 _a2CyAFhyXXS5kPI1Qc9Ik3gNHSl_HXZAASowEleOhmyLmrZMCWMwOJV2vKiJ6IWN47H55Ve6RRd
 vHTBCSIK5PWBR78eaiIu9dcAkm2yl89Fs678I0arJgxKqjuqST_FC2wUY30xLAWD64T0_xo_5V8Y
 pIwf_0M5mSyDQ4vp1AhMoLjPG9pQVdr06lCVNS4cQybCErxd0pDP.MNY6W8kizsTpN3nxsFPGbVa
 fwJGYvgxRB8fYriccbDU7C_wAvf1afPMPe1uSybHGgSzeX.d9lo3F6Vj7_PV8OsjjFUNr8KYysYe
 KV1__ractVmc9OhvHasWVkP1KUeZT_Ixg3kyaubCPiBNpwtySSoCM3CEeoqUEdi3NOfhLWACZLF6
 9X5FyDLZXgWZncGIa.P5aTQFOj1vgMoKbVQXzkdM5VQrrnAJXeIOl51mOKEJlDJxrXC2T5mf1.Cz
 RdE3OLzSF
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Oct 2022 16:55:04 +0000
Received: by hermes--production-ne1-c47ffd5f5-8c2cz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a6c42424d120c2ce70fa3921ddc9a513;
          Fri, 28 Oct 2022 16:55:00 +0000 (UTC)
Message-ID: <612c169c-2e11-13cf-9742-19714a247152@schaufler-ca.com>
Date:   Fri, 28 Oct 2022 09:54:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com> <Y1jMeWl0oV4/2zyE@kroah.com>
 <5396ab1e-9b93-df33-ca49-58dc59459a76@schaufler-ca.com>
 <Y1olsHWnaEk6+b1L@kroah.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Y1olsHWnaEk6+b1L@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2022 11:31 PM, Greg KH wrote:
> On Wed, Oct 26, 2022 at 12:36:34PM -0700, Casey Schaufler wrote:
>>>> + *
>>>> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>>>> + * Copyright (C) Intel Corporation
>>> No date for Intel?
>> The latest guidance I have received is that Intel does not want a date.
> Ok, then I need to have an Intel lawyer sign off on a patch that does
> this in order to have that be their official statement.  Otherwise, it
> needs a date.

Seems I misunderstood something. The date will be there.

>>>> + */
>>>> +
>>>> +#ifndef _UAPI_LINUX_LSM_H
>>>> +#define _UAPI_LINUX_LSM_H
>>>> +
>>>> +/*
>>>> + * ID values to identify security modules.
>>>> + * A system may use more than one security module.
>>>> + *
>>>> + * LSM_ID_XXX values 0 - 31 are reserved for future use
>>> Reserved for what?  Why?
>> You're not the first person to ask.
> And the answer is?

There hasn't been an argument for it beyond "just in case".
I can't see a rational reason to reserve specific numbers as
I don't see value in LSM ranges.

>> I'll remove the reserved values for the next version.
> Because we asked it will be removed?

Because I don't have a good reason for including it and it
has been called into question. If a reviewer has a legitimate
case for reserved values they may be back.

> confused,
>
> greg k-h
