Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B003B664CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjAJTjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjAJTj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:39:27 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D89B5D887
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673379563; bh=lGtMh9M4Dz/lYQ7NkDqxhoK7EZkneU9R6gELbtiYrQE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GHV8rWHor/5RPY5zJNGNgisWuOI6Upy8MaCcUIgvtOngqW0tkVjgD/+W+AG8bZ67xzYMFHm9wMRyv8ih+nlwQIYOmJRURbvOkxRT2N/uIe4MM3O1lENR4jZtVlUTpaM4p8KSYEGc+CDdpqKjU4qFQyWNvEraKGVPRxUh0/53GNpMfLW5IT/Av3LHWTpMvnLpd2haDBskxKv3az3IT7NajVqevcppWxb6yOnywe7A4kpCQFCJ4Q13Flx5nbJdlPwAK1RHgpK9qXEmbOIIgfXWDhnL4aYxkiGEJqs35A7lLbFw/WQvzax/aK2mKU8qo1bpyr6ZjQhqVXu8sA14UFSI/A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673379563; bh=iAoH4FnqY/aXHQBPu0/NKkVi1XMOmGPqkmlJuNir+n8=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=S0XcJq+fvP/nrPYs+jAgyT3S5KvANO+fMpEnd2haWgxN8Vo7wX+EcuXGr5W5nhN2N8UTOCNhrPss7JN+OX1OU/+VGyIUQlrwNNuEv6WTgWvdGYGg6xvBqriZHiBInM88FDqUz4ZdgB9dEi/vyYWunLdeGGThcvAk3L8jPmOSZfzVCQ/cBLnd0PrtquX17uaO/txLCbBW6Dj6BO/0eRPfwHHsYwyCZFLk9pbR/AD3kO1iI0WdwRzrId6Q9Xp2vt00ZQwJKf76/xQws6NW/fRSeEKnJkZQoJ6a0KzWvcl2lQUQdAN1WeGbKc6vgl7r29TWMswe1Kksxo90bEBEr0497w==
X-YMail-OSG: L5lYMZwVM1mFLoM41zsxdYeCSYQ7PUqUrg85Se_RgU_vMnqY_qCy4rTjIAzjS.W
 oCjAk94GxmIiGLgpXIPmCVaDwXs0SbB5yQsTqm2MH.sU_3pUfWHoOIj9oJnZhvAGdI_U.SV.ssfd
 UFEGTHYtePl6j4dNCaBAQpuifRbe47dO4PWCuGBT_fsNcNV.lvyTzbVKBoGF5dDQGkZnPVDLc0uz
 QQmMEO_s.DQKVJvxH9KXH93YQr5LsSTu.3HEvTDh.gJJMPPmASYpjecIFAlEY_4IsWZPb2wEs1HJ
 wXqkfuZNlbN8_rzVF7zyxvrjWDu0adq.tT7xrijNFbJrp4v60wge3cukMdf7jvnp5mHZh0w8WbQM
 M.iYOAEGd7inQYEKQe68R9YnJCGImjeVbh8fg4pOiHu8kuMR2mBGMaB94JhHyGgGuI9MARfckZL6
 hflQlJSq198Y7ZuVOof7v8AoTwtYqZ3xSF9axJ3QRK5suTXJpU48nGbuhye.Bhm2otqMiMEobnAC
 rlmrwF7ei_Cci.0EApLdp24N6W.lyLZMKYySglo.m__XQO2h_2TQNLyEz_QXB8tvIRlnck_k6wZh
 Eo6NhCzF_nW2rY9xLPx7MSlJHsSSNhMw_bl2XrOOxk_pX_xZ_iprqScAuosuzjsqRXRIPBIdnwrG
 9vBrcFWNuX29caWI4nmgxBpF97JX.AKnvABPPsX_BW0odSHjgQk9ETsaMy9KT0ayzx8qhJUZySyb
 QAJkZfTdI1j08UIFT2mnNjc2yFV3e4gAz5snCtkkC71d3BeCIhBO0dpLD3rZeTxXorZlDjsKaKdx
 USZaLToJFbT4aA2neJwj.bjbYTU6Ot3lTsjS_9Wen_XjRZXMBnqnv2JTfpw9ycYOpnkQlMXbXO4f
 ULqoPD2i0bZaMfp05uony5QlKYpbh3iTVbIf.sO.QpR.Aa_1TVJjadHvJ4VtFhOPJslZwSINW7Td
 xROAkC..R_h5SywYHh0Z98M2foR44t5heJ_Wrl7v0_PqBueqIf7.zfv7xN8SqY5hu.g3FxzKCpUh
 88eEOY9xlDN8LqjSFH2XHEGQNmzZTshBTEw5w2I5p34vykgm2W0VDLlQUIt0F0BNbGPL5TC5PUmm
 4KDgRf505sVK9QdlYwX6P02DlOWCNpqgSLh.jOHJGwO5QNj7MGwQh0LCJpb0.zS2wKV2yW0SKrIr
 yLSEOzF6Aanhn86rDBdgioX8QVPHNY3Ck1KDZZ7xGQgKlQs7GsJuosRM0RFXyPoTXketXT7t4LY8
 XBzVFRsUveAIksYH2SySocsHEMQ64i1c7I1zVi6ZRWeSgPEiTh6zYAS4uezMstmlaibKYKI3UHKQ
 LTGAe.ZkH8S1HNFsFW3ryY56H7fJlMvyk58OCIa_VdeT0NnYYADftdQ1UAT1vD1lWVDj8duwG2mQ
 mRO2IzB3eqZ_zj8p6PDch1CZOTCWmWg_X2oUVk11E13eu8NGWoF7Y27zNJ0PbluPAoEmgZrM7_q8
 0Vz18aPC8QAJhzrIuXZXDw.WeMSTRnG1UhJboCeGG1KOAMYGl7jHEViVkbgw0a_GfEoXH6By5y.3
 GMc0oi6.rWjIEjPQSnw8q6y.DH10vBEJ_vRw9zs3rUzJJrpvYiUzq8jscp2Q7gOsA9O7LFVU7ujr
 v93WNoPV3sv5yx5ZGHRp81qUrazovVr8qCzbOAHAoHSV9GHPTI.xSM3xvU3NThgD2wLsCfqTOHJF
 QUXGH7zy1vTTtajTZAuh_1Xyf53MmLGxT8pDTJOyaOHMTdD0QPf4PMS7N_lO4_Xjlo7cGuPg3hQo
 c_BQJn9BlV2XxWnGyscfaVLC2IhmBMHtErw0z1JevILOuoMNS012sVn_pd_jlucOKIAL62OKhYHE
 _uEvg.fJkU9SHdJ6E8NzgvQljrBOxl_D2tM_NuEUbKfy8dMUlC4MucsKd_xihC15lRoul0SLmNcE
 Txqf7LmJEH_XcPvf5sqGl8kRbQ4HcCAKGX4FVG._lbXfJFgAp9G9exufda65tmyudI4_zMczC8UC
 0.TYm8610RprQ2sVXB_LfgBhrjKxTBdkc9ruy8MvINGRR4NONDAVzWkwA5UWgeO1kuovHiIq9xdz
 saxai6fo8O4dF26yqOjroObJFACuLnXZPy7f1lPxMCCAfJD.J4nGakm3b21VsWslW4NpnBQ7wGfe
 t9RJYHe5.1D3klNvMnlkEfKA52zPuSoW2Nk0.JQR6yr28j59u618kamBHYZwturvfsnHzJAc83j_
 rNiUd4c9_qEpgDkzdhaL8nG_itm770pzDdHUcYUaAD.o96.r0tkPFU6NmkFO0U.9C
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Jan 2023 19:39:23 +0000
Received: by hermes--production-ne1-7b69748c4d-rglm6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f9fd3d24e27012a014b6cece016d21c9;
          Tue, 10 Jan 2023 19:39:18 +0000 (UTC)
Message-ID: <1c86783a-995f-21aa-91ab-1b58d50f149b@schaufler-ca.com>
Date:   Tue, 10 Jan 2023 11:39:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] security: binder: Add transfer_charge SElinux hook
Content-Language: en-US
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>,
        casey@schaufler-ca.com
References: <20230109213809.418135-1-tjmercier@google.com>
 <20230109213809.418135-5-tjmercier@google.com>
 <7e1610e7-c131-e162-be47-8983be7d9aec@schaufler-ca.com>
 <CABdmKX3BhNxdgF2dAuwPCPASe1raYYx6UUWRv0L5p3FxoU5MUw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CABdmKX3BhNxdgF2dAuwPCPASe1raYYx6UUWRv0L5p3FxoU5MUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20982 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/2023 4:30 PM, T.J. Mercier wrote:
> On Mon, Jan 9, 2023 at 2:28 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/9/2023 1:38 PM, T.J. Mercier wrote:
>>> Any process can cause a memory charge transfer to occur to any other
>>> process when transmitting a file descriptor through binder. This should
>>> only be possible for central allocator processes,
>> How is a "central allocator process" identified?
> Any process with the transfer_charge permission. On Android this is
> the graphics allocator HAL which would have this added to its policy.

OK. You're putting SELinux policy directly into the name of the LSM hook.

>
>> If I have a LSM that
>> is not SELinux (e.g. AppArmor, Smack) or no LSM at all, how can/should this
>> be enforced?
> Sorry, why would you be expecting enforcement with no LSM?

Because the LSM is supposed to be a set of *additional* restrictions.
If there are no restrictions when there's no LSM, you can't add to
existing restrictions. If binder works correctly without any restrictions
that's fine. It seems odd that you'd add SELinux restrictions if there
are no basic restrictions. If, on the other hand, binder doesn't have
native restrictions because it always assumes SELinux, it ought to have
a CONFIG dependency on SELinux.

None of which is really important.

>  Are you
> suggesting that this check should be different than the ones that
> already exist for Binder here?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/lsm_hook_defs.h#n29

This one seems just a little bit more like an implementation of
SELinux policy in the hook than some of the others. If there is no way
to identify the special process without SELinux policy it's going to
be really difficult for a different LSM to utilize the hook.

>
>> Why isn't binder enforcing this restriction itself?
> Binder has no direct knowledge of which process has been designated as
> an allocator / charge transferrer. That is defined externally by
> whoever configures the system.

So the attribute isn't a binder attribute, it's an SELinux attribute?
That isn't appropriate in the LSM interface, at least not explicitly.

>
>>>  so a new SELinux
>>> permission is added to restrict which processes are allowed to initiate
>>> these charge transfers.
>> Which is all perfectly reasonable if you have SELinux.
>>
>>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
>>> ---
>>>  drivers/android/binder.c            | 5 +++++
>>>  include/linux/lsm_hook_defs.h       | 2 ++
>>>  include/linux/lsm_hooks.h           | 6 ++++++
>>>  include/linux/security.h            | 2 ++
>>>  security/security.c                 | 6 ++++++
>>>  security/selinux/hooks.c            | 9 +++++++++
>>>  security/selinux/include/classmap.h | 2 +-
>>>  7 files changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>>> index 9830848c8d25..9063db04826d 100644
>>> --- a/drivers/android/binder.c
>>> +++ b/drivers/android/binder.c
>>> @@ -2279,6 +2279,11 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
>>>       if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
>>>               struct dma_buf *dmabuf;
>>>
>>> +             if (security_binder_transfer_charge(proc->cred, target_proc->cred)) {
>>> +                     ret = -EPERM;
>>> +                     goto err_security;
>>> +             }
>>> +
>>>               if (unlikely(!is_dma_buf_file(file))) {
>>>                       binder_user_error(
>>>                               "%d:%d got transaction with XFER_CHARGE for non-dmabuf fd, %d\n",
>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>>> index ed6cb2ac55fa..8db2a958557e 100644
>>> --- a/include/linux/lsm_hook_defs.h
>>> +++ b/include/linux/lsm_hook_defs.h
>>> @@ -33,6 +33,8 @@ LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
>>>        const struct cred *to)
>>>  LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>>>        const struct cred *to, struct file *file)
>>> +LSM_HOOK(int, 0, binder_transfer_charge, const struct cred *from,
>>> +      const struct cred *to)
>>>  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>>>        unsigned int mode)
>>>  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>> index 0a5ba81f7367..39c40c7bf519 100644
>>> --- a/include/linux/lsm_hooks.h
>>> +++ b/include/linux/lsm_hooks.h
>>> @@ -1385,6 +1385,12 @@
>>>   *   @file contains the struct file being transferred.
>>>   *   @to contains the struct cred for the receiving process.
>>>   *   Return 0 if permission is granted.
>>> + * @binder_transfer_charge:
>>> + *   Check whether @from is allowed to transfer the memory charge for a
>>> + *   buffer out of its cgroup to @to.
>>> + *   @from contains the struct cred for the sending process.
>>> + *   @to contains the struct cred for the receiving process.
>>> + *   Return 0 if permission is granted.
>>>   *
>>>   * @ptrace_access_check:
>>>   *   Check permission before allowing the current process to trace the
>>> diff --git a/include/linux/security.h b/include/linux/security.h
>>> index 5b67f208f7de..3b7472308430 100644
>>> --- a/include/linux/security.h
>>> +++ b/include/linux/security.h
>>> @@ -270,6 +270,8 @@ int security_binder_transfer_binder(const struct cred *from,
>>>                                   const struct cred *to);
>>>  int security_binder_transfer_file(const struct cred *from,
>>>                                 const struct cred *to, struct file *file);
>>> +int security_binder_transfer_charge(const struct cred *from,
>>> +                                 const struct cred *to);
>>>  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
>>>  int security_ptrace_traceme(struct task_struct *parent);
>>>  int security_capget(struct task_struct *target,
>>> diff --git a/security/security.c b/security/security.c
>>> index d1571900a8c7..97e1e74d1ff2 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -801,6 +801,12 @@ int security_binder_transfer_file(const struct cred *from,
>>>       return call_int_hook(binder_transfer_file, 0, from, to, file);
>>>  }
>>>
>>> +int security_binder_transfer_charge(const struct cred *from,
>>> +                                 const struct cred *to)
>>> +{
>>> +     return call_int_hook(binder_transfer_charge, 0, from, to);
>>> +}
>>> +
>>>  int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
>>>  {
>>>       return call_int_hook(ptrace_access_check, 0, child, mode);
>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 3c5be76a9199..823ef14924bd 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -2066,6 +2066,14 @@ static int selinux_binder_transfer_file(const struct cred *from,
>>>                           &ad);
>>>  }
>>>
>>> +static int selinux_binder_transfer_charge(const struct cred *from, const struct cred *to)
>>> +{
>>> +     return avc_has_perm(&selinux_state,
>>> +                         cred_sid(from), cred_sid(to),
>>> +                         SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
>>> +                         NULL);
>>> +}
>>> +
>>>  static int selinux_ptrace_access_check(struct task_struct *child,
>>>                                      unsigned int mode)
>>>  {
>>> @@ -7052,6 +7060,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>>       LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>>>       LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
>>>       LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
>>> +     LSM_HOOK_INIT(binder_transfer_charge, selinux_binder_transfer_charge),
>>>
>>>       LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
>>>       LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
>>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>>> index a3c380775d41..2eef180d10d7 100644
>>> --- a/security/selinux/include/classmap.h
>>> +++ b/security/selinux/include/classmap.h
>>> @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
>>>       { "tun_socket",
>>>         { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>>>       { "binder", { "impersonate", "call", "set_context_mgr", "transfer",
>>> -                   NULL } },
>>> +                   "transfer_charge", NULL } },
>>>       { "cap_userns",
>>>         { COMMON_CAP_PERMS, NULL } },
>>>       { "cap2_userns",
