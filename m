Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93DB609505
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJWRNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJWRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:13:11 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FC931FB4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666545189; bh=r9lExiutIMfUYxyih2ChMZmQXxsMgWS/STr2m9x1LgA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RsBSdMEms/ha5ANyfyaoN1RdqtFVXollzdrYJt1WanBIvgvN42c8g832zmM9Y10V0RpjVC/qiC/wWRP4aYGw9Bqnuev9ZiL9SawWnROoTs+m6flgoXNrj/dlfmURPdCMCgrCWfyhLInK9NbJijahIeww4u3GsBrcrEW3QVOfvk72G6P97jhtoNqKIrnSlDrwzQy/1OyR5VaSWE11+B22A0lB6eMrrJNVjBwc1wI+8dWv3c2m19u14W2Gb32QdHB9nRYNdm25PIFjFbj1ul5KBA44gCyNOCKJxn28wwfMUj4T4PfJdPNiyB/oFBQydCkR3pBc/i1AzQg+L3P/rg4BHA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666545189; bh=+p3ZnSwcgxy4h0eesj1r0rUz9ahdEqTxbVmE9pYDmqC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eRrjOXlm+HbcR/UyXjcCgXcukOMX5hqVPTLtXulFPDDBtPvVszRwV9uPZIqCeQnXERBq3WfJvxCgXpeppNpnb808r2X8DuaOCEAAo9NP/nPP73KooV4N9nLNlsgV4E3oiyk+vfUKRpRXF9hmsYI94PNr7FvaqAoBlR+2pWCOmUqEg6BBZCzpukTOnnaC0OO7y7/sHX6s8IIkFLfGwX2I+oAODDCtqC4QIz6mOwWRNef1ARwWR4qF76NuNBzM6Sg+tffvOfbf82O5RUUwyIqMq8xHPkitreUP0HM5DkrD9yUzXA1P2c36fjWAiokFDdoz9EdPtN4kQtkHqBQHzBWVvA==
X-YMail-OSG: fpW0G0oVM1ltKwsEW2ZQxF8m8XcJpDCkM3T0qJa_ZE2ezscGIVqIm6ji3Eq50hi
 G4bQqOQDHg1B.SqwA1Sy5Z7r8uZ8jpzulvaoBxKdk1VB6vh2xTJqdsCE6f0tU7YVUAzR5wNT6TEe
 uexnOOz7q5tENOyO5ss8LxRTU27qNR4BYqc4fboQhfSG2giC1VYQevYDQEH54rqLo_MvmXyWuhnx
 t5Cwq0AWAoH4cYtmK7ibbUzP98TqkzugBQ2cOufV_kVLlzPP1hKeQYf_CbpKsQwvtT9Jneqj1CoC
 jq1yiTnPdvwCroEjGwgozyIeka598mfeyRu1t4Z8OOSTJ4zXkqcwxT6wdnJ4F5sJqWQi_4jlaG71
 KNRMvpm0B.2SCgvU__enbGRq_mnSyITv_vgg0gYmQy_Qi.9aZZPBopyXmHTNmD.aY1WlY0xyOLso
 m_1HIg7IomYn_itAsjofdvSc9rHrPEhdg1jEWo7rZ6qRc2iJKT2eIy0HbS9V9Y7QMuDKKnADyJFo
 fB6FKCl9FbCZzb6ebtV.ITPBzRc4dfVWx1rLYpT8l_djitDQqbyCkAOJ6Mv2fSJxuR3vNCgc8zGT
 IQTeTAB0ubl99GFpGNxWMMTCo36qYG1167rTRuvIJNlVnci65331IfA7eWxeUwtpWaizj.2MqoAd
 ojiiTIAbObB2pxtAyU_YNqrEWfHjBKBj2tJ18.GI5S64gfa_zhUAJlKhFdltlQZTumtF9OULdU5f
 R1lWJlo0GG_IUGE9UiwHVYKqNOOGGTVkgJv0NItimy5bWmK3n6eguJdi8OZoJVLPpNaIiuRLRWht
 3JHQDW36UBUchhtWD2HUo4YBTug1UXhujlS_mEiuv9ByKsU9ye2A3VwPTIjU_cRsG2_HZKp4O3At
 IuJAx6tOJc0kAhjOllWXE_Kk47ieNxkYkGNht1BNTV4X6FGCQQAe05uXDaAVNp1n5RiHKe8IqhR9
 yTAzbZqBuY8egzLDdf2J2bKXrHOzhV1Zva04Sf.sf25bvavWY2BU1Osw7vrOlDKqv1MxP5bFXHMs
 x1m4.EXO5sRslC0iJUbe2x9SNJko93kLoXumFsJa9p0hu2Ou1wSdSsKfdadTzZ1bytYK09e6tWnA
 Cg7.atX_khe4W4wC7DM6uEICwdJX1gYTigWUTG_7VJneiY59QgjQgzm7TTsnw6c2yB6JisaW_cEH
 _37IDIaqYFn3k.eitUAzHrTcqcuVwApXWxW8e0oSyX__wJuhY1py1y2.FqdB6vnC.VMelbZT_9ky
 nJmkAHAhu7HqVGZCmqQtGslu10bOmIcaVoVhC0WMLkQ74vcO.EY6YKtl73yBeonbHDjv2KBAFZT0
 vgx_J3DtgE51C65YUCRwI5eJpQvn3w3q.c49Uy_SvYPhcbuoorkY4EuNt_RtVsdW5qnDBE8wtxRy
 s7cPaE6XwnDt7e2ji07SGfQb0z3Wat9ngjKdO6xVqQxkY1oEStwgRRfrNdnw0LGCT29cSOkmwbaM
 L52QylCR4j40tIyBkTZyUCSdMfMzsxlXc5peUpXGssQPGXAn0mMG95GG0LIcPkI0X1aT1ostl1.6
 6ncTfrAiao.i9A_z.70eFpd7p23XmHI5_9vVdmS7GB6pbjvSBDZFY_vRkFv4lFc9Lov.cW3PrVxd
 GFLGr9vb.d8xaB1U0tL0YvoppJgthMseEuCx09sZZI8dKn4t2wt6JDYcL_JbsgqdTxZwGWuVLafp
 SnvUKOl91r2dBDUphqkU2JQlBsOI1gYW2ML9BFAGzlcFZMT4lDq7P0h1gFFuBfSu9jd4O2ebLcF7
 ONKBEx9RDm11DrHqoJjYwhEpv8A4GgjsffrT0CvngbjGvnGedOgixoC9DpQI4YgKIvypzzqQUSYN
 9.kygyO9rc2FHWdr6GEHT4vRjrPVWrW_6qZap12g6idYyXBsUbYTZKgLYjO6jsNpVHUXZx38fNnp
 o59lnmoaJmEooJQ.UU92WaN1VZ6jjNY0RhWoNke4LUMFQ3hOOhiD.Cp.ssjYloQusp.7vOrEXs9j
 swdMJNeGUOsStblNn19mYbn3FmhDKviwpo8PhoInx88PFXfgtKCrcVuFRRKJRUWeTqXf7elL3xpf
 hRT5zim0qwlpHRFdalTKLS4M9G.yAhl7Kjivft82r1epyV.G4Q9Pe807gakxJ3PXl1_zu4peqYx1
 .A9InxnkxnzzCyTta_9OGnnKF1oxWYuYXKJZzn29tFD.J.OUL2oWG5sIis7o.BOu.fOHebrLFV51
 _iBIUvUJzRAwAMB67fl2Y5Ih4DncjgO3O
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sun, 23 Oct 2022 17:13:09 +0000
Received: by hermes--production-gq1-754cb59848-jk2dx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9e41f289b41449c896e30f1148424ab0;
          Sun, 23 Oct 2022 17:13:05 +0000 (UTC)
Message-ID: <753dfbe8-c68c-5e16-c4d0-1e14cd831c2e@schaufler-ca.com>
Date:   Sun, 23 Oct 2022 10:13:03 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <a130dc1f-a187-2957-25c1-974fb9c2569f@I-love.SAKURA.ne.jp>
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

On 10/23/2022 12:27 AM, Tetsuo Handa wrote:
> On 2022/10/21 8:42, Casey Schaufler wrote:
>> On 10/13/2022 3:04 AM, Tetsuo Handa wrote:
>>> On 2022/09/28 4:53, Casey Schaufler wrote:
>>>> @@ -483,6 +491,16 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>>>>  {
>>>>  	int i;
>>>>  
>>>> +	/*
>>>> +	 * A security module may call security_add_hooks() more
>>>> +	 * than once. Landlock is one such case.
>>>> +	 */
>>>> +	if (lsm_id == 0 || lsm_idlist[lsm_id - 1] != lsmid)
>>>> +		lsm_idlist[lsm_id++] = lsmid;
>>>> +
>>>> +	if (lsm_id > LSMID_ENTRIES)
>>>> +		panic("%s Too many LSMs registered.\n", __func__);
>>> I'm not happy with LSMID_ENTRIES. This is a way towards forever forbidding LKM-based LSMs.
>> I don't see any way given the locking issues that we're ever going to
>> mix built in security modules and loaded security modules on the same
>> hook lists. The SELinux module deletion code is sufficiently scary that
>> it is being removed. That does not mean that I think loadable modules
>> are impossible, I think it means that their management is going to have
>> to be separate, the same way the BPF programs are handled. The only way
>> that I see a unified hook list is for all the LSMs to be implemented as
>> loadable modules, and I can't see that happening in my lifetime.
> I'm not expecting for unloadable LSM modules.
> I'm expecting for loadable LSM modules.
>
> I'm not expecting to make all LSM modules to be implemented as loadable
> LSM modules, for some want to associate "security label" to everything
> (including processes which might start before the global init process starts)
> but others do not need to associate "security label" to everything.
>
>> I can see an LSM like BPF, as I mentioned before, that manages loaded
>> modules. Over the years I've seen several designs that might work. I'm
>> encouraged (and not a little bit frightened) by the success of the BPF
>> work.
> There can be LSM modules whose lifetime of hooks match the lifetime of
> a process which registered hooks for that process. In that case, being
> automatically unregistered upon process termination would be preferable.
>
> But there are LSM modules whose lifetime of hooks is irrelevant to a process
> which registered a hook for that process. In that case, we need a method for
> allowing registered hooks to remain even after that process terminated.
>
> Please don't think loadable LSM modules as something that require special
> handling. TOMOYO is an LSM module whose lifetime of hooks is irrelevant to
> a process which registered a hook for that process, but does not need to
> associate "security label" to everything. It has to be trivial to convert
> TOMOYO as a loadable LSM module.

I don't see that having a built-in version of TOMOYO and a loadable version
needs to be difficult. That's something that whoever creates the loadable
security module scheme is going to have to address. It will depend on the
details of the loadable module mechanism. I can't comment on how that will
work because I don't see loadable modules hitting the top of my queue.

>
>> Converting the array[LSMID_ENTRIES] implementation to a hlist like the
>> hooks have used would not be that big a project and I don't see that
>> making such a change would be a show-stopper for implementing loadable
>> modules. I think that a lot of other issues would be more significant.
> Defining constants for each LSM module (i.e. "LSM: Add an LSM identifier
> for external use") is the show-stopper for implementing loadable modules.

One possible way for loadable modules to work would be to have a built-in
module LSM_ID_MODLOADER which maintains its own list of module hooks.
The values returned from lsm_self_attr() would identify the this LSM
and the data value would have to identify the loaded module it refers to,
perhaps as "TOMOYO=XYZ" or "datastate=foobar". A flag LSM_ATTR_LOADED would
indicate that the attribute needed to be processed according to loadable
module attribute rules, whatever they might be.

So no, it's not a show stopper. Not any more than u32 secids are a showstopper
for process attributes it audit records. LSM IDs are inconvenient, and not my
first choice, but I'm not going to let that get in the way of getting this
code upstream.  

> We won't be able to accept whatever LSM modules to upstream, and we won't
> be able to enable whatever LSM modules in distributor kernels.

A built in module loader security module would address this issue.
Getting such a module accepted upstream is not going to be trivial,
but the BPF people seem to have managed it.

> LSM modules which cannot define a constant due to either "not accepted
> to upstream" or "not enabled by distributor kernels" will be forbidden.
> I expect that we assign a constant upon module registration (instead of
> API visible constants) if we require all LSM modules to have a constant.

Maybe the thing to do is rewrite TOMOYO in eBPF. If I wanted to have a
loadable security module I could either take ten years or so to get a
loadable module scheme upstream in addition to my module, or I could
write it in eBPF and use it the next day. I don't know enough about eBPF
programming to say if it has everything TOMOYO needs, but it sure looks
like an easier path if it does.

>> I will, on the other hand, listen to compelling arguments. It is not the
>> intention of this code to lock out loadable modules. If I thought it would
>> I would not have proposed it.
> This code is exactly for locking out loadable modules.

I hope that I have suggested viable (if not convenient) alternatives.
I suppose it is possible that locking out loadable modules is one
motivation behind the LSM ID scheme, but I really doubt it. And more
importantly, as I've outlined above, I can't be successful in locking
out loadable security modules. I don't even see it as an additional
complication.


