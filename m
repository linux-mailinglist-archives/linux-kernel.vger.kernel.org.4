Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8998606536
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiJTQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJTQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:00:53 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B1E1A910A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666281651; bh=9QmrNtJTcgxNR1m3Z/rs+lNfaULYqDNjsU1Rc6F3/Yk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=r6EeNDWOT/JUgoR3ydzFdZ1r3ivCQ0z44IUitZrHZMeDLgtCoExzxGp2QZuTP4a1DU/Yww0Pgc9X0jPr0VLSN8LVjJmHUDeMd9Rn8PW7w2L/7+hAj7r3LY0kdzuK/Avh4mK8c2EMuw/QJOrVT1XKpJ6NHiLaBROD60SYKwV0sKwM6le3dGu5cIO9qOd3csK3DhCQ8pA9ywdcj9go9WEKvxA+YYx008L0haKa8liON8+Lb4kH9j4UR6c4rEMjvPI2BByLB/20TZUSY8mW+YweWQOtlOIAlKKfZ+MskbWBzNyvGXtwuxx5HTk1vJZQ8iRAAbP2sfgNiVnC1xaSFPe2Nw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666281651; bh=jK+eIxo+rBow1kYbX1XAINFAeIZEjKNpgpzN8wntyDI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iuAAe0LTkZOGp6f7rfxxQfHGcqZY5Hh6sSAZGEHyiUoTlAE6s/KgQDxxuBW1b4KaJniw73W8Z8rpmA/yUNuiTL56dHDBOzqNZusrcd5/Wt75JoT8cvcs+fhVxIi2k79dpQ2Ex64fi53pbBBqZ0oEurde9BRL3dRNBi2HjR7mnadpAI1NhLVqwrqtB+DgSu5t1ssMretTXXZi+vcRm0PpTDsnErEDo22whrX1rJs+hyPhm6utNsNVcJGiMf6DPtuQSfXTe+Tq3jVz5viR9F0Acx9iqvoO7h9KyEnNse1CECfTBSC4eStWKBpnWoGG+NAjyCUsO3CYNDlOU6cowGqlBw==
X-YMail-OSG: Gacy4u0VM1kIScte7IPolEBjaAASYXyaU7xSNXaf82RpwJojwZmfdhk6Qq7vNa8
 BYqHfP1IxPdD6v3URD8a1JQ61RuGl4Qb.9xzLIfZXZMrzAYAsKp_5R3kR.PQBlpqJnZAUAjLwCy5
 .GJr6V4thZAw1feD_ie3VYkCXvWmLecw5oec47CJi4wKJapY1yx7hMLIDv1jceNMDXmjdp4ZmY4G
 BMPKBKEFQJJwtIi2cvO2hE_zKZq89GLef6NNq3NSuv67Tjr16nHXE9KQYsev00Pk5WdiM8ZIjJtv
 j0sZ05Q_.I7kpi0OMgxIyTCll6EGi_6oOD1MBRfJ4W0yaLk5hM9WLRHDHhdfCupbCP9HoLXvbt_q
 nZWX9yJybbPc7WGXhH_pqYrgasttxsNhP2NfRTcecARqIIZPPYjky5Jq3LTcrnevv.hrcXLoUlVN
 jYxSrCdKOCEhL5Ll36hb1U3yAVfT2La8MZEodAKH2h5lQNmKE6DIRMG.o7tQqMa3j8dZma8O5.ck
 wmn2fgzOjzBDFba5xM3K2H1pCqeXVVmE0TisLzLohwAa1EDO3lJlnd9W6ePOoTZ4zAldzvvRbWo5
 2m..yKyhmI2OhRs3znhI7MZhzS0XocYSFcW2AuDJPJIdSssejP.wMp3MqilI.jTz6PkLGm8BBqQz
 xEgUcQeRUdWfw3duD_4H.4wLt2chpLULF5dpCL5wGNb1W1FFMoS5M1q8EHKWN1OpzaWz6XA4WPRP
 HdqkGNzHR0svemKTSj9hWS6f7ybOuk0Quet8p8ma8iXXMRHOWsilkz_7md8ZxslXcMH11GGj_r88
 fKUptGPaMQGz_PWiNtZSzgWo3TTOmaimcBIyxt.FQt6XCNoX5N_sZSWMtwdkxwXaSpq_IuMsAsW3
 pUmy4PrNyywfqSQahdmd1I.HZX7Cixld40LSdhMeN9bQsB3VhRbF8lAofkEh_4b7cRCMdAX01bbg
 DODVeLhEgi.T50aHidXrOJWkK.OMgi_fIdrxvN1PygK7hDepH0KDaJSoUkxNTYHfUihr1bocmEzR
 bB4xbjjEP50buS.WfMUBDZLGmBHMCMiTfJVylwoPzpLUiZywIDrsQTd4hqejqAk9Dv8Pji1LFkzj
 rd4RvlEZuUx4d4ghtrv_22EMGGsvOS7o6Y5IChFwI11NEBRerzBs.zDBWpj4kfDSqh8t7flcw6F1
 jjYjhA703x.E9yrivETO1M2MKOr0QF_VvyyR8iz_WiX8cF83EmB0dbwag9wfGonw2mR_iNTBMWDd
 fd2.sqX4larAyGNG27yr3cRI5QbPnNaSKUPfYnlKylNXL0Rr8KT1BPjx0jCEMWxZC57V9pI8GbS4
 jWa.RwwVzqUzlRKankP84SkatruNHIVwvqO9t6LWcZqgbEqj5MQd2LoQE7eq6IAz3B8kSuBX7vht
 1D_w7NL3q6HkEOwL2gCTCnkAuIApibbrK5hQ3O4vbvFQy22miE_fqobAmvgVAZ8oSzKgo11rzzvJ
 .8UTaJTYAgkWy1V4polpb6PYGN0A4Y_b14vmxe0oRhAf5TtHZfg6J8pcjMu8xTwqUTXgKviXX6DZ
 gWb5esxtZhM6Y9_TqDDUxGk67il12pOh6NHV4VqITqFSkDFw7nIbcnFWcFqPr5Te9sE69z.uU_0m
 2ejGiK6vskhHhDNSpc_xFwn6zEpabqZVbAoU_Oy8Lugjav7d4j7sHObpgoLl3_P7o8hniirZLxbX
 SG5GGDnUmjFNw4wSd3kXf6TVEyjG28ClmMwRDetQ4h_.PvK1Zbme1zHrQQRJX91LEe94zD4oxtB1
 5.ji83JG9s6R8zqFH_soV4Thxui8hEHG.uQ1I8eEg4._rY3_GXMrhjS56hjzn__cOhuy.bCUbA2r
 0C4K9IjWgQMvplCIL6xAj9p4EnH9B4DSwlDq8gELvDLJ2V58nN2NE.qGgMFJJKH9BoVM2fyyXN9R
 FEcpvUD.a8G9RyyrbWW_wuYl.JOdpDsmW7Gn1AA.JUXsAuVTcUYZE2C0FNyTogO9C_USdI_l_9Xe
 ygvkiRnO2cUpAibsK.a5Wg9C7PciC_yXoRA3Xvb8KuBhmpghiGlr2u4VZUiFyLR5ODZYsA3VpKHE
 do55h8lhXXFt3l_rQ4aRpYng74OksFvIhnXsL5uyyJNagaULNjMt8jY4Lh6hLh74LmD7o5l5iVsC
 5yva6YJT27PFxI7bH9JbvGrd1t.jfg.8jif_hr4UNjJ5hqq2TnhGZFBLs3VmJI6M75WtodkOk8DQ
 gCf9tWjtelIf7MLcJNsDrJnwsCJyxLOW7W6cNjOlTgw.zLwUvTy4sAWvO6KNTvpkWNP2geybiZ1P
 JtqWdV4.4tooWbvaKl0eUkBiQpQs-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 16:00:51 +0000
Received: by hermes--production-gq1-754cb59848-n5qk6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3b6e906b9ca7a255148941b46f673044;
          Thu, 20 Oct 2022 16:00:49 +0000 (UTC)
Message-ID: <41b7c231-1c97-2196-878b-92ad1778f11c@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 09:00:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <202210172153.C65BF23D5E@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2022 10:55 PM, Kees Cook wrote:
> On Mon, Oct 17, 2022 at 09:45:21PM -0400, Paul Moore wrote:
>> The code sorta cares about ordering, at least to the extent that the
>> LSMs will behave differently depending on the ordering, e.g. a LSM
> Right -- this is why I've been so uncomfortable with allowing
> arbitrarily reordering of the LSM list from lsm=. There are orderings we
> know work, and others may have undesirable side-effects. I'd much rather
> the kernel be specific about the order.
>
>> I personally would like to preserve the existing concept where "built"
>> does *not* equate to "enabled" by default.
> Yup, understood. I didn't think I was going to win over anyone on that
> one, but figured I'd just point it out again. ;)
>
>>> I *still* think there should be a way to leave ordering alone and have
>>> separate enable/disable control.
>> My current opinion is that enabling a LSM and specifying its place in
>> an ordered list are one in the same.  The way LSM stacking as
>> currently done almost requires the ability to specify an order if an
>> admin is trying to meet an security relevant operation visibility
>> goal.
> As in an admin wants to see selinux rejections instead of loadpin
> rejections for a blocked module loading?
>
> Hmmm. Is this a realistic need?

One of the security modules I hope to write someday will provide controls
based on multiple successful accesses to particular resources. The old
school example is a program that scans /tmp constantly. No one access will
be denied, but the fact that it does stat() on /tmp/foo a thousand times
a second is suspicious. If my system is running any of SELinux, Smack or
AppArmor I may get different results depending on whether it is loaded
before or after the "primary" module. The user may care which result is
obtained. In truth, the user may use the module both ways as a mechanism
to measure the effectiveness of the "primary" module.

The current set of new security modules is diverging from the MAC model
that LSM was invented to support. I don't see that restricting its use
to make the infrastructure easier to deal with (as much as I'd like to
do that from time to time) would be the Right Thing.

>
>> We can have defaults, like we do know, but I'm in no hurry to remove
>> the ability to allow admins to change the ordering at boot time.
> My concern is with new LSMs vs the build system. A system builder will
> be prompted for a new CONFIG_SECURITY_SHINY, but won't be prompted
> about making changes to CONFIG_LSM to include it.
>
> Even booting with "lsm.debug" isn't entirely helpful to helping someone
> construct the "lsm=" option they actually want... I guess I can fix that
> part, at least. :)
>
