Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B6561FB21
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiKGRVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiKGRVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:21:44 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F4323BEB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667841702; bh=/UE/psKhPsyGCQWSQPcxjEWXOwolrXg4iCtbFwanYWQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FmeL3fnIs9UnQrN2ttukgSu2vq+y9+gL1u4sRkbgNUCchkCeBhOfv8VpOkOrC/4uBprlbX3t5JlXDDVn7mcFcwN/Gc1pRhnwLCNl2tObfNSxdEj9VFAia09mKltJBgV7I5N+KAGfyzeMis9XV6oNFzYZLJiAqkW8LKscgXH2rYVW3KxdkgRQmuP4mmdngEAYJRiwZnXOSR05V5KC5f3++VKmDaUq5/0AawOQB5sx8N/mcsx07R80ldW/doSe4bzoaPsSHUDMfoUdEnqFJMu7RqIZulD1BXMSudKCBhRIxf2dwhPQKzMaWCEJJuUP6V7BTzmo1ywhesKftHo/cLSlww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667841702; bh=znhMOb14vc7MB5dKv3/FTq2eMgBU/w02OoJtTxbMeyE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fnek0YLjV+NbAEzv795siUglBXWYhr23HzpBdJzhDqKkAcJvWXuRBl+/gOX6d1oO/d+R457L8gAvfvJZmmmGq6Sk+cZI9wnazjhBwp90/BNyrAPzDluS103F65CN4hovs3QDvYRU1Fyba6vCx+ayhoVwk8CtwuQdyZX+t4xBwHynPqDtZa91PEKXX/AMxK3dDt04k2gyqMGiXuqzz8BL3U0oCxNhdOsN7K6GvFVEW28/UP/btudu2sgsayPAzbME++PZsmoHsf+uZwVn3dUbDf8MlppASb9G2Tpt6OcbZJhlF2fC0+jW58HtWshsHTHoxtJPEA+CxiV58jrSTLHORg==
X-YMail-OSG: tFa0tx0VM1n9MEMbLyoVaJUqHvgOKzNbc6dAh9siCnXSPI2rgapbgiWaYW04yzB
 _0dpEWO9cgGSJI0GTUMxaOu0h4G1KkbUWJMKClPtvavQEPy2dKG.nHFjPZdBrqv7q8aQT.R58pHK
 LCjboKkoO0x7BuDZQ.gbuYnzTbFn6FJihXkRkMMOzEll0kV.zLo8AzqsIla7vauRGiu_rPCkjvFz
 s5MovASyV3yOOUKkBUByDa.XtHTC7FmFpZ.d9Bn9mQyW3hGorhzypJ1I38x7FtcVLs1GynoskCLe
 uFENVmeYuZ3hTcGjg74jVZINv1RNjRidakroe3pC.A181FqItjTxMtSzV5VXqYohkOILFmUPv.w7
 yxCiPI.f6llTOeW7zonGB3orpCRuHaxTh0vBUzA4yUjKXse7wRGkqa4DgWWHt2PlFe76o4iKBO1G
 oQa8I2WbgPHw8oy6LdVN.88wJ7qMsT...5nvg9xoSwf5MCPUbn.L_mz5wuw9qhUjZnUoKXxMng_H
 Mh0eBTSjLCRbWzph7ncVYGxJYMk3zaOo9wSC4gtgR1ltZqhUdLgvi29e8pQrWW3G0CIr3sySzHmE
 DkEwdiYZysYAcliUhZrtLgUXPIj7Cz6AUGcn9lDxZ2Ihj3fM9QVlv9osVssHB6NMSuh1SeF_cEFI
 eCEMsNoKL_FEy9spnymQBxNkvNkgJj2FY6AHAPqjonjgfoK7AnXFfZrt.9Xws48cuu2FqSNwztaa
 tv7E3D9eTFwQAFM2kgc_CT2YgFccLGHHCl9tlVJdpYKmXMZmv_JEDOHwidzzQD.SRquc73pIMnnN
 9I.CLOdeYpk0HZl1ap4F6JNCPIynYdH4Y1tPGTdMCzkCQ24pZfjbTInAglpccvYJFfNey8np_k94
 s1jDMjX.rZjrkrY01wBKCt2CcaWbsOyQNSj97GsUdbm42.g7FzL3H67gQxJ45DHW.2yV.FrDVdb0
 We_1_ePtD1bvejgiTDuyxmq4v1WgBELKDxrtiym0wlDf4Rrt5kUBA8UWHW18GlbGxb2HR7bUYiJl
 c3wQMy6gGB_0.dN_b1aP_1JH9vMk_wr3q4XprW6Jbt6c2PDeLb6sbp82wMelsfU1JSePJTjx5yM1
 .0PoqQqejBFb2Wrse_RfpjMGpaNeEMR.ObCaPircdq9ATHE6JiEyDDL3PMwmdXXM9X5q718k5eZv
 BnZPI.GUEnohzJaeXiqcCzbCswjrq4IzeWMU3MSYqjfZjLCCcpdWart.dKAaQfnClAKMOeskCsFX
 HuYzL8OJeOio0GkigztfDcnKD8NG0JgFV8mALxSXwtvNiZcM2p2PhgvoR4ORjrtI5IIp6GrjIUpw
 Keu6TI5Z3GzOTv8tzbAOAKleT7X424bVTd.GuaOJ8wUWCLM5CPZ478jFA0GT6u0WPa7O20sua15u
 VDIgdSSLp6uS5gNMA7LP1pM7SG.RNHxLYLs3neZbS1c0DDz2YkT7YuixheBmIg_TQda9qIam2i0r
 YTZeCOtqEwtR2T6fU9eD6OBrVX8wWvrGY2M5surRt.PGXq9NQ0F9XaGqROwPY3dAL.0p7V._YNCX
 RWKOAmLGlW_3VtR8H4ZAN3vsWyPXfy0Z5REWkQJvVICDO0ugJvsdQ6XPIX6uEJ4W8KTxT2XxW57V
 CkuQ4q2c15WR_kzUMlc8Yxr.mjizqIqpOt6ZY013YARO61.pjpBMKBaFWxlIRPyr1ZOkaCTY1TSh
 ta6BTC.uE4ndlIUu3G12g64MXwCN9LLGv6FFhDmty2_89A_FPkX1xoqio_0m5rzL5NQ1jTOnPL3H
 5vWhavBuJRsjrkG16aY8_lL0fjvD4LyGfeRZUR35oQncHGDvE7g56AmkJqFx.5I.yYJrtXzAUpUl
 QucvyDFpm.cdrGJwhWAsMfOauyLhIhv0UdJ.Gl2Fgbqa8GaFG4I6mj5InTcs8hfcMYUHl_fMvXN.
 hwP8CKfaq3cs9.jVuyfv_hKd3tZk8ggx4YUn8B00uTnmOAqWW86QF5MdgYKRFelhCSLE3bDtgPga
 MH8gP0YsZTuJ44AdpL8MbqODzA.eLG.bijF4bs24xGKE3YU9w3JATydcxCpKWQPBgJG3cWNRFFEQ
 jx51EltEN44h6osy44c2ijRVrS8tvTNlHcIYE_jvoD0f8mHgNS_UgBzYdcG4BY0TjAfjWRJbyI.t
 6JCjvuD_JQvye3PWqoZm3AVcQ1EfV_3jGruQ39dQzBm5Ueh_n2u6Bv0XQFNCNdtGCuxfNEH23aXp
 1LytsaO_8phVk0LhNpFFyQ0zA13hqXpT_HmqLIj5Equ3X.kqMHtbb2PQRYf21xoJdJX09mFVWN21
 1x9DJkuI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 7 Nov 2022 17:21:42 +0000
Received: by hermes--production-bf1-5878955b5f-h4zdf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID df2a4f38052c5b1364b89cb806cd789f;
          Mon, 07 Nov 2022 17:21:38 +0000 (UTC)
Message-ID: <47483d3d-380a-36e9-0c7f-9becfc09a656@schaufler-ca.com>
Date:   Mon, 7 Nov 2022 09:21:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        casey@schaufler-ca.com
References: <20210222150608.808146-1-mic@digikod.net>
 <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
 <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com>
 <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
 <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com>
 <202210171111.21E3983165@keescook>
 <CAHC9VhTTKpesvjnc_233x+wG1BvXyup9nM4Dv2h1953zXAvU3A@mail.gmail.com>
 <202210172153.C65BF23D5E@keescook>
 <CAHC9VhSMLjzxyu0F82NZoea-q4yMgHeCZ0-TRcvxKks4WeKacQ@mail.gmail.com>
 <c7808c82-621e-c20d-bff3-03a66df5528a@digikod.net>
 <b0e100f9-146c-2709-3946-67bc06282b91@schaufler-ca.com>
 <955d9b89-3ca1-8c70-0c05-759febde4031@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <955d9b89-3ca1-8c70-0c05-759febde4031@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20826 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 4:35 AM, Mickaël Salaün wrote:
>
> On 04/11/2022 18:20, Casey Schaufler wrote:
>> On 11/4/2022 9:29 AM, Mickaël Salaün wrote:
>>>
>>> On 18/10/2022 21:31, Paul Moore wrote:
>>>> On Tue, Oct 18, 2022 at 1:55 AM Kees Cook <keescook@chromium.org>
>>>> wrote:
>>>>> On Mon, Oct 17, 2022 at 09:45:21PM -0400, Paul Moore wrote:
>>>
>>> [...]
>>>
>>>>>> We can have defaults, like we do know, but I'm in no hurry to remove
>>>>>> the ability to allow admins to change the ordering at boot time.
>>>>>
>>>>> My concern is with new LSMs vs the build system. A system builder
>>>>> will
>>>>> be prompted for a new CONFIG_SECURITY_SHINY, but won't be prompted
>>>>> about making changes to CONFIG_LSM to include it.
>>>>
>>>> I would argue that if an admin/builder doesn't understand what a shiny
>>>> new LSM does, they shouldn't be enabling that shiny new LSM.  Adding
>>>> new, potentially restrictive, controls to your kernel build without a
>>>> basic understanding of those controls is a recipe for disaster and I
>>>> try to avoid recommending disaster as a planned course of action :)
>>>
>>> It depends on what this shiny new LSMs do *by default*. In the case of
>>> Landlock, it do nothing unless a process does specific system calls
>>> (same as for most new kernel features: sysfs entries, syscall flags…).
>>> I guess this is the same for most LSMs.
>>
>> "By default" is somewhat ambiguous. Smack will always enforce its
>> basic policy. If files aren't labeled and the Smack process label
>> isn't explicitly set there won't be any problems. However, if files
>> have somehow gotten labels assigned and there are no rules defined
>> things can go sideways.
>
> Right, it should then mean without effect whatever kernel-mediated
> persistent data (e.g. FS's xattr), but I agree that the limit with an
> explicit configuration can be blurry. I guess we could explicitly mark
> LSMs with a property that specify if they consider safe (for the
> system) to be implicitly enabled without explicit run time configuration.

In the Smack example, the system would be "safe" from the standpoint
of system security policy. It might not "work", because the enforcement
could prevent expected access. There is no simple way to identify if an
LSM is going to need configuration, and can be counted on having it, at
initialization. It's up to the LSM to decide what to do if it isn't
properly initialized.

