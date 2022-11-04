Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23DC619E57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKDRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiKDRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:20:54 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com (sonic302-9.consmr.mail.bf2.yahoo.com [74.6.135.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D541983
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667582452; bh=yGHP8CNEp7ZdrjuU5VpjE7rkXxLS+Vk0aoGfMuJn1mk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=R0Cjkp3xSynhMVrY5vspghxOLYe2VQ60cLCIIOyrlhfICRoqAfONC4/LYefeyEt88KXbQ0lsouNjmMILiWDMKV6FDPkcC6zF9QjGOllHBfrhJ9yN0ozYkpZuTVZ+Bl8s3ogvePOzE6jAApU1BjdkdhXNUYDtME26/hCCGEvARpKQFhUnK+FAEhsFlKV84YBxdzSQ0FHYqxaGQEg2dY8foOv9N+GOZHD78KSxZ82kOdEP1ypMabZJNYR+Di18iJ9uR9U1twihcrfPMxFeCZd0ZzH8YmVK7q5TfOj3o813rPb5IORtcsDCPrrgkQRg8PhzcuvT0kGxlD7byO/RIkYBfQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667582452; bh=2XL/ED3W89vreNnnjdpxf95nq3/0fmtaawVcF62jQuy=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YDN8MZW/d9wnquWCIfKlIzS0hiWFHzIiZJ9U3dx/FLBWfBvW4sgxcUBWcSTtaWhS/nrx0L/AtZr9EsmFUq2WqqtM+8w2Y/XxwCWjBPVQjO5/q/cQPpRmnBqAitXFwz5wi33M8tRBk+SWOOnDY/JkzDHpidFE4MOeaZRp4qzPeIU0qcvavpIKe6NXzBQIdVnd1lyf6Zx1eW0jUhQOLijACf/34E9LU3U5Qslc156jI1QT5K2CA+ZphaOGCWmXxEz0qKJaSWieIVQRjTB3vKP+1lmCbsk6mNTBJl12K9kGg8IO2O8HBTf95oocGDfocJM2JSlYPjpA/42TW8fNNlmjFw==
X-YMail-OSG: sXTn8Q0VM1lcbMYqiFRnZ9uvSfa3nOe5Z4MlwI6SweBaZWHr2WUI.2uWbpGxHve
 SR8n3a1S7F_06AwwTY4g4Dhzp29RQZqwFKSZd.hxvrzza18.bWK.lklXx4bDwcDU4U67K8b3uaD9
 yjlS3v8GYidbaY1hBaEEkwJlNOoIfjIgryfkRY75rtbTW98GKqPpaBgBQ7UKhM14Hp9SzvqsPB7P
 7ZGpB8hAaA9AMsjmqjBl8woYPlpSFhvCQeWkxdyXD2l_1hdFwVgC_4nCxHG09mBGwM4t0vy33EL.
 h1U76fwadVMWD8ZLtFrUmZI6JiGlXMNmN3yzFffQCAYl6hFSED9dnmDvl14Yt65AIKLycSs.Ihnq
 hJr1QB.HhSbH1lwnqsvnvnURbsMJBHlbNVsh95uZT.BEVkpjegKeE4CGaBGHXihxtW7qAy.xoIfI
 MZSByLb.ffLgYywzqXJGyGWmxL3j4yXO0YXn9PxH9GYcoAJZrr4FVmfVhbTFN_Xu_fWXq1VTDPcK
 ph7wLvSN5WCJCsyHZUra1BLdWuppsfR_m0yCCjAZgb02XYQS3Sgje8U5H9ubTxnseN75kOjVmAsr
 wsnfoFyfLBTtYRZuGGurs9U11Ulkn4VC_KWTwkc6L5MP7gx8_ORdWC0zk9YE4Vp7UxCgDI8s4pd9
 QMuqcp2viGlqYvHrqm48thuQaOaBkolZhyiZHyiC7rqqmwN8bqrO.Ex88hrHg0dYu8mD2AinhHk_
 00GauVW5l.q_hf6Kp2rrTfE7Ys_07FSdlxfkFOFBqVGg7uCvEiNnt8PzKMqWQW6QImHbTiLy7fKh
 pkSlFULqLkjfXEXHd_zxmzaj3oi979M8kicO8D_Mz2uOZ9E8ZIu_ISTqw5AfcUST_p6pANj6jMfC
 lafLqM7E2MMPDxOMnOJBJ0d39OM0dHmVcIkJfMleC9K.CtioLY1WiZl323JQuIYjXuMFp48l8Rbl
 HNCawY12km45WmN4v8aFep2r6_r2bF3_Yv93J3E6az2vSPpk85nyPNAMHBP2UtU.QWxeEodGFa2T
 CXTgeRysnoR7_0xs.nwslAeTXHv2CElJb0NRgwKn5exDNpEY4gWQ6EITEPAhF8iX6Lbj_GTFn9Bc
 nUc_CZGHPmVqsOonfhHxabNoLmjjsKu7XkNaKoYZnMdOi0UO9AzYKO.1HbcJlZahLf.QDyyRbc9R
 aa1H.O0rHTz5IhGhZElyYG6avz09EFzUt1P2KWSIk9_0CLKxSDhCB2bbqp_qJ10vZKT9Wg0mKaZK
 MRgvZZ8OgYVu6yFzoxXtCFBWZbRJ1sRNDl0.wRbSChpXjyQPdPVQOzrFtf4joMlTetaObAUysC_w
 lcEWabgNgeFLiq70j0x1xjTkv6i8ZYaNrOvw_a6nx.1YRSHYIertrpzlAIAHqbxE6suRgHh6FsVx
 p.3UppHr35CwjCcwOqyC.T4QsRmPd5kmklSPV75n5dkZ90.mOL6vhP430svWnZzSgS3MKLBcTue8
 l8fkbcwd3GqYrr9VuwDpBB0HaOSy2nrH7oOEwsaChlrSdE.chksglRPzC0zvVK5T3Kmk8fxriE3n
 FJAKPm7G.MLnRcglg0D1TYPhRVjtG_9PvWifwSNq.8y5lmmdZomluE.aKlXeAMV_eUO7SubcLGiT
 zW09Y.l2h984bf6xnADEvHpTZ0Foe_UJBS1jSkHDwz5wFWddMikBDjRI5mH4JfyRnnnV3MOPwbVO
 KWx2EDZLDkAgDpCi86l_FMWukN0BGrKfDC40wnKlbUfRQNjLnyVXYirVUwQUzUM3po7V2bt_e6ph
 va_qdie9vNuGFP1Vlrd7YRQHduyb8lhMskRLlsTA0.Tv5weF79kCaTNHs.qGZMkW5xu5VfxWft1y
 7_UJhIji6ZaO8J7Yj4dlgeYbCaDrkxo2qlz3tRnkkm8F_mX7C_jFnUAGRLF5MikXM16ZVYv1GENG
 2I0zw7uHcrDW2GE7RNf.No2Zq6O7.0ujon7nsSjiti8TBu61mQRb_tR4m7_sBkGveQ0zBJTFBN.B
 uDonS8SsaraPI.IyrFtMz6ukhtGLX.3bljj2ioa3FRQvFSwr9z_4Qu9.WrKHK24bb5rGz44H6rfv
 INl15YIybb7kbQ2EHTfpdbx_lFeW5CbyFn8KCzJKulcvdqfKfm_Vw.uxSxTGyMK1LRDj8.AyoCQy
 tK8dwb8jh6l6EBuoI4JeeliN6l0KffC.Tt0NExitgPOU12WSxfsUwf4yOjZV_GePxEZc42rHqB1S
 RoU29lOzTrjeq_V82pNY.eDplwCY77wWJYfpdweHAeboy0UR4QAL9BYn1gag0CZoynkLZs90JzBD
 IjLjTR9fZkBul
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 4 Nov 2022 17:20:52 +0000
Received: by hermes--production-gq1-579bc4bddd-x7lwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7c91aa310f879d9840bf754b22beabf;
          Fri, 04 Nov 2022 17:20:46 +0000 (UTC)
Message-ID: <b0e100f9-146c-2709-3946-67bc06282b91@schaufler-ca.com>
Date:   Fri, 4 Nov 2022 10:20:44 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c7808c82-621e-c20d-bff3-03a66df5528a@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/2022 9:29 AM, Mickaël Salaün wrote:
>
> On 18/10/2022 21:31, Paul Moore wrote:
>> On Tue, Oct 18, 2022 at 1:55 AM Kees Cook <keescook@chromium.org> wrote:
>>> On Mon, Oct 17, 2022 at 09:45:21PM -0400, Paul Moore wrote:
>
> [...]
>
>>>> We can have defaults, like we do know, but I'm in no hurry to remove
>>>> the ability to allow admins to change the ordering at boot time.
>>>
>>> My concern is with new LSMs vs the build system. A system builder will
>>> be prompted for a new CONFIG_SECURITY_SHINY, but won't be prompted
>>> about making changes to CONFIG_LSM to include it.
>>
>> I would argue that if an admin/builder doesn't understand what a shiny
>> new LSM does, they shouldn't be enabling that shiny new LSM.  Adding
>> new, potentially restrictive, controls to your kernel build without a
>> basic understanding of those controls is a recipe for disaster and I
>> try to avoid recommending disaster as a planned course of action :)
>
> It depends on what this shiny new LSMs do *by default*. In the case of
> Landlock, it do nothing unless a process does specific system calls
> (same as for most new kernel features: sysfs entries, syscall flags…).
> I guess this is the same for most LSMs.

"By default" is somewhat ambiguous. Smack will always enforce its
basic policy. If files aren't labeled and the Smack process label
isn't explicitly set there won't be any problems. However, if files
have somehow gotten labels assigned and there are no rules defined
things can go sideways. 

