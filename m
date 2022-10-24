Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F132460B5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiJXSfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiJXSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:35:11 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D63D29C3D2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666631718; bh=V9fLL5QwAxYqlbcmMxo+XAYwhtoUMFwYIDXZtcfQhVs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NH1cYbSZ5bV5j8uAM7pIUlXB6EKPE9XGT/Su5Vos8T1gGgHAgmhwAaUVFJCRIAGUuuscGvGuTUVPMbZYBXphDQWPUACNmUGal+wP7wuLdaFB3Pz8OwScyAZYgWp0FnAgMVW3lNDu1X3XOorARsWYHW3wrB2AKRX/4aQciFz6bZ+8GtQfGFmzLVGmY7s/TnXqdoWYJAVAHjrBKF+pYISFmeZq23jfrNJ0KDaGRm9pUBF1mD6K4w+e7sze7BDrut8HtsQ6Sok0jUNrnqv3HCkEQp/kqJAZTqkWAKJ42EpyeDYTOASAfWB8I9SUAHqNNMlCDfmp29f5QUqa7pK59a+sqw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666631718; bh=gNSqSdmKmKmoflDiIWR7EdHP4Yu8+Rzn9HZDSZGt00r=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fss/dOB2Ptggw1vsEueaqqTOFuYWgm2da1SCayIn8DDYQQpiMSG/gtRRz2d4amT6OSNQdpkS5/Tvs1k+aIxyhsnAcbelP87hf5WAueK+xcxr05V4yVFBFCKbFpV4mM/l3pfa76TQkKwqyHzsIEp6aDu/ZD5hIhQfReUh5qCuGU9hen5IrCEXCxZ0v9PcNaR7sEcMmKEoB63yfvFY7bD3Zgnuu3A2F9tECq/YoJYMSYMt2nqguKd1PlL76kLbyY5IiUO0Gh25DWEPCQIlQvqiphUf6BcIDQlwPoPgUg26afCL7xat742YQXmlD8MMtYvbwoAYR0IKKQVJmV8KDHxOPw==
X-YMail-OSG: J8HWP4UVM1nGpUS5AmxMkV4j73seysqQ98z.9Fj_8Et08JH6LbQRPtmdQKGiZ1e
 azuOvKeEKOESAAzK0MM1ttHWzE.PONfcFzmrSXnppiDZbLgOsPlXU7d1nEy6_bT8iSKZH.7klbWS
 Y5.Cef1lBjAG_PpwqGsqXqGsjnc42wwG_3jFIkvH8pYMtQ_5VI6qV.nbC7AorMWxE7JwUUuY86wo
 Pm9NBCpEn_QJFXeUdZx5jIVKUXllUxSMsiB9hWoocn8ARnhtSp_HGbPn.F4s9Nn_hGgZmN7QdUEV
 jlIY4ZFmn.ArZdgkSZxNDIEmHhp.gFSdSGc0hSHR1asjq7JrpOgXatwBwyzqOb8oIl0dW5SH3Gnl
 ZypFZgxyx43Bz4d5fh.oU3iuHVwgRJbJe83qNho7heTqYLAOH86I1ONy6M2i0Sisff1LNHYmDHBP
 P9ypCTEgWFtGHT2._xXGA847V29xTujiXPQm4QZsOfJ_b0egOAbmItA1bYL65HJr9jJv3z66EzwS
 TQSHf7b4rBiTjieIYIzbMw2f0MNtHLhAdObn8C.tDd1H5prC9te9ioqC4KOk0R.JfoChINvp0jS9
 HN_84Pze4R5joRW1vygiC7hSMLM5l.s3Kxr_.kmKiH8l7exOySK5XxVOcyiuVryimBqZNMjoEx37
 JZPZ1qS.B9Eg5aK9VJXC.E2JoOh.i5PWylVPkzNNB5WZddeLz7WgeyzZT7lTmSjsjfhgNVGHJ.cu
 d._alM4ZnMLNOOC6KA85AXG5mS7PjeS2fh5uey0k0kS6aMpfX5oVfxjRXzJRhdGiTwY8Tc_5BGIY
 y7auZcg2U7qbSZzVW6lyVNF_AafUFpQmw24FTQ0s7XBwm1v2Vfd8.ilB9_9FXifLLfmg_yxY8XfH
 yCTNUaXDhuVF69InwmgbIv1iFREbFcgeCZ3_G2BPEKmGK8Xz4BfiHgSMMp.nxveSizrm2EOWdAmi
 slSHNQEmaqjUDABnnUGh.cumzSo8pzAnEMzEfkOyDW76QOEGxxAgEPqNIYsbU5W306nCZqbR2R2g
 LNMZuAJ6qnpySW1iBnRc0JN8ylbseKumlMSgGCxfLmV0n9JHf2gyOVCrB6rLk1f2q5C7bET0Rzjg
 OpRgZPk6kV05aztcxFNQzyG_YMoS.R2oHDXTWjnwcpP6MZMQ.aDBwxSrJmCwduvvt.pnRoRd3WOA
 Fqxjxm5oEjHxo2suNuowV.uwNeVoUlrsVWJ9.R6knyZYxU7vmNgZaKD3TM6BzoXp3Plgajfl_hnE
 EBtil0RAgW21MbA1eMy97VTHQ4zsvQ7SXGjIwT1aGZpG5ZL5d53a5iA93_rZwQRawW.9p6ZZOUkk
 vsPPcsbSHzg6zFbtmYeFAm58MCxMMJ0U9t5ITpzEoSvuB.oUFsiGzbb1tW33C4vCTxRzjpoQXkby
 HT0K.vXh.1lIoAVt3j2Ai3WTJ1VLgfiVTfxFvKxd69W9Sfyn8K5EHYKNJZbQWS9Px98FM3lc8Ve2
 rNW41qVkbbsPsPY0hq3eD1AIAWhSKNcrttErO1DjUyI.pU5tndcyeiqdzPnv88q4RDGFWfjXOu00
 3omrSu1MPaxhWbnguQIpOXB0Q5Wr1IEWxfazH.Jjx2.GEU1hi9UdkJtjFxIPHa8MaGgeUb8ucNuD
 E489oePmKzxtnFYTKSOzYEnML91UNEzu7WNDB7xESmYEJQ.KJn8QtmiUUc7AaCNJrQPRi0aTwKLn
 XYlMuQomhoJ6H0l2bpmcUUkb64kq.SEtHsnO2JFbhYBv4kylw8VuV8M84rcohqdX.KuBYr8qj9k2
 EAgqTnmsPw2p5scYvn7D11xtYXll5cKS.IZkUVnrSdHPG689I0cB0o5oeWzJcceY4PzEQF3M7Xbx
 sH2TApw4C4UMe3yD90Aaqe7SeOsrgz8k.H2ZA3gWeTQevz33GFFoZoppS_JU5o4XxIevFtaAuZNr
 Z3.aWe60okEpKxgJw_PQQdfmS8AcLP0CPCCc03uhyn9XwJJFKPa9W98fQGZK55qY25bciaFyXbg_
 ZgwxVL_tPWZ97tFiK7vu_lEeLfGTluxnc7Qa.xOgCYilYgtCc0pd.SQz8PA7slCm_5NwN6dsysVd
 FkkY6NrqV1vVVd2jKx_ytzivZSVWEP.34aprmacSfAySBlFrbpalMa02mFwLmbgFBFv6SdG1qZeA
 7fQNIBMF5RrrES7BngWrLvCM4wY4QWwZWRAuYx2uTh5qtHO4Az3hlTEujSdjCWinE8Ggg6Ct06Db
 BvBD6dDmEAjt9HT0yo3cOO_D7FhErCxJQTeNizw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Oct 2022 17:15:18 +0000
Received: by hermes--production-gq1-754cb59848-jk2dx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a54f1d304324749febb897fb1b4f2d94;
          Mon, 24 Oct 2022 16:37:54 +0000 (UTC)
Message-ID: <7263e155-9024-0508-370c-72692901b326@schaufler-ca.com>
Date:   Mon, 24 Oct 2022 09:37:52 -0700
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
 <753dfbe8-c68c-5e16-c4d0-1e14cd831c2e@schaufler-ca.com>
 <55f27f99-3a2b-3482-6dc2-12203948dd35@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <55f27f99-3a2b-3482-6dc2-12203948dd35@I-love.SAKURA.ne.jp>
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

On 10/24/2022 8:13 AM, Tetsuo Handa wrote:
> On 2022/10/24 2:13, Casey Schaufler wrote:
>>> We won't be able to accept whatever LSM modules to upstream, and we won't
>>> be able to enable whatever LSM modules in distributor kernels.
>> A built in module loader security module would address this issue.
>> Getting such a module accepted upstream is not going to be trivial,
>> but the BPF people seem to have managed it.
> How can we guarantee that a built-in module loader security module is
> always built-in ?

You can't. That's up to the distribution. Just like BPF.

>  What I'm insisting is that "warrant the freedom to load
> loadable LSM modules without recompiling the whole kernel".

Since security modules are optional and the LSM infrastructure
itself is optional you can't ensure that any given kernel would
support a loadable security module.

> Sure, we can load LSM modules which were not built into distributor kernels
> if we can recompile the whole kernel". But give me a break, that's a stupid
> opinion for non-kernel developers. People won't replace distributor kernels
> with rebuilt kernels only for enabling LSM modules which were not built into
> distributor kernels.
>
> Quoting from https://lkml.kernel.org/r/7f9ffd77-a329-ab13-857b-f8e34b2bfc77@schaufler-ca.com
>
>   > I'm waiting to see what happens if eBPF security modules
>   > become popular. I can easily see distributions turning the BPF LSM off.
>
> Even if TOMOYO could be rewritten in eBPF (I don't think it is possible), how TOMOYO
> can be loaded into distributor kernels if distributions turn the BPF LSM off ?
>
>   > Before I go any further, I think that the loadable module manager LSM would be
>   > very hard to get upstream.
>
> Not only it will be very hard to get the loadable module manager LSM upstream,
> it will be also very hard to keep the loadable module manager LSM enabled in
> distributor kernels.

That is correct.

>
> Again, how can we guarantee that a built-in module loader security module is
> always built-in ?

Again, you can't. You can't guarantee that the LSM infrastructure is built in.

> What I'm insisting is that "warrant the freedom to load loadable LSM modules
> without recompiling the whole kernel".
>
> Adding EXPORT_SYMBOL_GPL(security_hook_heads) is the only way that can "allow
> LSM modules which distributors cannot support to be legally loaded".

I believe that I've identified an alternative. It isn't easy or cheap.

>
> Any fixed-sized array like lsm_idlist[LSMID_ENTRIES] that defines max capacity
> based on whether that LSM module is built-in will lock out loadable LSM modules.
> Thus, I'm not happy with LSMID_ENTRIES.
>
>
>
> On 2022/10/24 2:20, Casey Schaufler wrote:
>> On 10/23/2022 3:10 AM, Tetsuo Handa wrote:
>>> On 2022/10/23 16:27, Tetsuo Handa wrote:
>>>> On 2022/10/21 8:42, Casey Schaufler wrote:
>>>>> I will, on the other hand, listen to compelling arguments. It is not the
>>>>> intention of this code to lock out loadable modules. If I thought it would
>>>>> I would not have proposed it.
>>>> This code is exactly for locking out loadable modules.
>>>>
>>> Imagine a situation where two individuals independently develop their own
>>> web applications using the same identifier, and then their web applications
>>> started working together with other web applications using that identifier.
>>> When they published their web applications for public and wider use, a problem
>>> that both web applications are already using the same identifier arises.
>>> It is too late to reassign the identifier.
>>>
>>> The same trouble can happen with loadable LSM modules. Unless the upstream kernel
>>> behaves as if a DNS registerer that assigns a unique domainname for whatever web
>>> sites (regardless of whether a web site is for public or not), defining a permanent
>>> constant for LSM module is a way towards locking out loadable LSM modules. And it
>>> is well possible that a loadable LSM module wants to run on older kernels which
>>> do not have LSM id defined yet.
>>>
>>> This "define LSM id as userspace visible constant" is more dangerous than just
>>> reserving some space for future use. You are trying to control all IP addresses
>>> for the sake of only in-tree LSM modules. No, no, no, please don't do that...
>> It's really no more dangerous than using the LSM name. What if two developers
>> implement modules and both name it "belllapadula"? User space won't be able to
>> tell the difference if they base behavior on the module name. That's one thing
>> that a loadable module mechanism is going to need to address that a built-in
>> mechanism doesn't. 
> If the upstream kernel assigns an LSM id for all LSM modules including out-of-tree
> and/or private LSM modules (that's why I described that the upstream kernel behaves
> as if a DNS registerer), we can assign LSM id = 100 to "belllapadula" from A and
> LSM id = 101 to "belllapadula" from B, and both "belllapadula" modules can work
> without conflicts by using LSM id. Of course, this implies that we need to preserve
> unused space in lsm_idlist[LSMID_ENTRIES] etc. for such LSM modules (if we use
> fixed-sized array rather than a linked list).

Of course the upstream kernel isn't going to have LSM IDs for out-of-tree
security modules. That's one of many reasons loadable modules are going to
have to be treated differently from built-in modules, if they're allowed
at all.

