Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F03860951A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJWRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJWRUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:20:36 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFC5419C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666545633; bh=vuXOXFcelBEIncDKX1DYKg9y4Q1ZIH/5CLgUUH0vh9s=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=pxC+icWwZhP6itzMOJPjsuv2U1KFbbUuU0vOsRtixQFl3JrBVaPc9AuqSBq6ao7U2rTOCpkPB2iWJLjLAdDTDQx6l3m3HTpvl/pJJ+z9yKtpNCEBjFnojcqwoGN95i646BQc+Ib0a65a8E53kPRQD8CD1NBTAEoSrtvKRh1K+6rNy8em0+ByIqA232kbFKmC5fw2Tf7scof8isyRByn6dUNtp2lvmnl4dPqV8rZx9YuF5BAFRu+Hno/Ms4PnU1Av//m3kHGLrIjYW3uuXYp/g/E/u3ajVhuyC39IaZYb29qgCf7r3e3iO4QH11os17mZ52imxihGlLseh6lgCpFzmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666545633; bh=XfR9fBSvtmdmN4SsEMmqaigwB+UJyci1c32PTStZ8uG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MVve5IbNTIfzprNULYkfhBgLqTexv3ZE5xgUnRgtxX0rowky5qlwN9hc3uj6S2C/UULbrsfXc5qIBA2Lz3d9WI0OPwmtEpqWMsqFTsVOC1UZaOT9VJGFccWdMBi+OMGk5pnYB05r/MFSwSggXN2QqwCRAIlRWBVgxycl79sh5pB2AwbxfQKtkLWFnp3QqEZtQPq5MdwfanGM7X6zLqII8BC7Hd37KfSnzntUtDWdd43BXivk1RqnLudqylUE6ufW4locwen6okkMlSC7uwsxcU7AamnYTFIVKqcHGQILjJKUbxexo72mMytUFjPVLCkQZMIpTiBpLzDv0EMSe8lw2A==
X-YMail-OSG: fhSSWf4VM1mVpiouRtBKNmFf0UtfHQO0tCsULB51RPVeEB7pTQBBSBCAHNio3Vb
 yXqiebQIR4g8itBwgZjjw.58K1gTDsKOijXy0PIkSU6SjDQfppShUtHy_5yFQE.TY9DsDTtRwhkW
 2Nd3TTMUX8CDn.CHCKaV_TWc1pY1RyuxwkCKXhjyTIFOkpB24gE7EonJLQGjULcGct7iR5.FANB7
 NGU4_zAmYp1pVAFt9adeHRVqwTmqZRx1W0HQB_DLod0xi3VSxA8cle1zGKVqX_0buJpoee49doyh
 BhNsiphMFj.r.mntp_bc.2d.St90tuKe4tP8utyh_T0JjK6SjLS6QsI1QK1BGu_yb_5OUZxknga3
 t8J_ad9ozPgGDvPSHI9XhJ_o8JRNeOwU3WeHr9jYdLSaEe3Lpd6nhyy4btbs6tFmBXLkOzQAaXf2
 4xKXfnwCYegWs0HHK46urYizWB4I2tJE6e2M_1ifGPZiqULuikPffLT.yDdeNpSxz.KeQD55qR9S
 fzafz13okSThR9nk_d9XKVh5POF9nbpT_FFwEdr7sELZCKgFNV1h4WjyIXXn2GzpJGubHLqCjEBc
 ZUYir7NUYlJxalX8y3pveTqfGXotJBoSyAw2CrunDlMX4VPdu5b_3J5FPH06.hyVR5eoFNN0IPhu
 EjZGxvJkcQIV3shssO2J2HDl8dD1MbnFBLEx9yhNaTUAmo9CDPC_wr80cD4MnfJZpur_GzGiK2Im
 q6nTWNIvUl42cYElH5pJmZ8xkLjkzWgyoHDTFE5cc62ZptlNEyiW_EGue46l25oKXaSjKbfgHjsa
 MXsCWk5RVgs2RchCkPbKM7H9HtCeANR2xnXOJm0SGP0SNb3hlaLXVBvwg_kwXHVK78wrJCMNc9bK
 oI_fwjNXgwPcuUgYZarX3Vxmpd7VkPWEltT1I95LX7iq.csH5E9bheA_Qrdb6XP3k63upNc5hn_.
 IvOncug1yQVSWkwKy16Uo25WFVn1dW6OE_fcRWnKkV3_SGx7rR_oHf.zVVf4REkb1F2dm8ZsZEHt
 EsnjbGWoAxGQ2naKoksLOt22ZSNy4jm_2CXkVgkxAWKQy6LzzkCWitIna7JI8NlCmS0VZwTyvTLn
 tcJTjA_lQ1tIJa0.NrMlPB.3gRG_A2kfE02G21nfM8oP1qRWIzxs46mKwtZTbP3r.Igbby5WMTZW
 yGakmx9ePLjQw3aNvBSbpDUIlHCSjLKVdbeufJKNp7t2GktSjwWCyzjHW2PBTaCHlA9OOWJRKPRf
 RUNuXQ8CuJ_KY.v1yFT00t.GoNir.1jSJ08ch9oUXpRXNpRsoOEwWBNeEtlGhTBMnIobsd95dYZU
 lDddVeSiGqJf5i7IPBG_AHyBRdvq.GsWD7YysyVdXc5Su3h7G6kPvXz8E.Xhnyc.5bT7SVrukrsb
 cApNly46jyOvWjt.._YJsVktct3EtpkErBPN5oco8IFn2SQDrEVACQXc_PfGgQhxiQbpfPFT2oXf
 kGbP1Dko8zpY0nKZeX_6uM9MfoNZ7crmoddiySbze05l1PVYi0DEpHntqwqGz0oGwGkvI.MWFMp1
 ilc.PgCNwMkIoA6fLIWT5C7xmIawNruA3tuO4t_75KXbCFNpGMygiCZfLlYpE2FZ_MemJQiL.je4
 yJ3WwESVFaMybrYWl2mtWHNz_ciQU9folX2D48h9LrbT.eoP9GZBaK1oo4zPLOS2zzsGrvN6mpI.
 zVnp5B.WAxM8el7EibvJ918TFn1yfp9mXgdwxrEkkLcLppxU7VmImTSM6DypvqEavvOE0D1kGIqs
 rcODjMOug958Xj27XtxT61TUGzPSR8acM8AiBHcvIpfxS4wOMQLSrSsN30NGRKVWCVYGZc_3F6sS
 OJvmnxDLpUQ846k89NAtlrSXZbS0iT8DfS5H9p0e1pFZg7r3fjYZ2DVtZLZvnq7zVSzV8LA9q3Ec
 194ylFXWEgBUCe55gGvxcSVTPceVaf_oduc1doVnqnxywiR6LoKbtJ5Qk_CrcCezTztimvyDTP43
 qVsSffphJ3GRoZG3PD0Of6BVAsKq_GuL73V9vyHxEEeTKfifJwbHMe3Go1d7C3g2ePUnbztO43Zn
 H8ocaHsjhOkQujIcj4fvgTJ9eXL_IYzOrwLfwlcgjJPeyeEIPQio41woWQdPE0ed6iomfkpNQXg0
 sAPvI8ohs159nlbryFmRG9yWGphARJ2COiOSkEtK3PoARZSO8ZzaS2O0F5ICg8DWMkhoFt53L3yk
 2u.u8ATRNpIUuCdYe1tfTr9.REtkY4MXU4Ge53Il.jyyzJc74eju0XH1cb3earK.FsNlj9E1OuhK
 OZIUSFWvUTRmXZ8N29x5PwGOjPQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 23 Oct 2022 17:20:33 +0000
Received: by hermes--production-gq1-754cb59848-jk2dx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4212e99988c4a8add2e675927158d4c3;
          Sun, 23 Oct 2022 17:20:31 +0000 (UTC)
Message-ID: <1a92299f-2f0d-02d1-75ee-72de80e1a091@schaufler-ca.com>
Date:   Sun, 23 Oct 2022 10:20:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v38 04/39] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-5-casey@schaufler-ca.com>
 <9907d724-4668-cd50-7454-1a8ca86542b0@I-love.SAKURA.ne.jp>
 <f6b8ac05-6900-f57d-0daf-02d5ae53bc47@schaufler-ca.com>
 <a130dc1f-a187-2957-25c1-974fb9c2569f@I-love.SAKURA.ne.jp>
 <280c313e-c826-3b9c-a074-2ead3cf4107f@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <280c313e-c826-3b9c-a074-2ead3cf4107f@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2022 3:10 AM, Tetsuo Handa wrote:
> On 2022/10/23 16:27, Tetsuo Handa wrote:
>> On 2022/10/21 8:42, Casey Schaufler wrote:
>>> I will, on the other hand, listen to compelling arguments. It is not the
>>> intention of this code to lock out loadable modules. If I thought it would
>>> I would not have proposed it.
>> This code is exactly for locking out loadable modules.
>>
> Imagine a situation where two individuals independently develop their own
> web applications using the same identifier, and then their web applications
> started working together with other web applications using that identifier.
> When they published their web applications for public and wider use, a problem
> that both web applications are already using the same identifier arises.
> It is too late to reassign the identifier.
>
> The same trouble can happen with loadable LSM modules. Unless the upstream kernel
> behaves as if a DNS registerer that assigns a unique domainname for whatever web
> sites (regardless of whether a web site is for public or not), defining a permanent
> constant for LSM module is a way towards locking out loadable LSM modules. And it
> is well possible that a loadable LSM module wants to run on older kernels which
> do not have LSM id defined yet.
>
> This "define LSM id as userspace visible constant" is more dangerous than just
> reserving some space for future use. You are trying to control all IP addresses
> for the sake of only in-tree LSM modules. No, no, no, please don't do that...

It's really no more dangerous than using the LSM name. What if two developers
implement modules and both name it "belllapadula"? User space won't be able to
tell the difference if they base behavior on the module name. That's one thing
that a loadable module mechanism is going to need to address that a built-in
mechanism doesn't. 

