Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9166633F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbjAIW2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbjAIW2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:28:49 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51C59FEA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673303327; bh=cwdWPJ+So2kLbU0cn5xgePzdjYgpj13UodhXvaaBwZ4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CkLsiS37ZSkJCnbr8aQPSpyhvYQTwAvuKOhZUc7uKKhEyBLwOVnj2Wmn+FunNiQABuMhWnyKDiHlH9mS34s3rcChjbjqlyZhzriMeMXPSw3XOgPsv/72jd7fcnQs0MhKcgSrKDR1x/JtLeanHJWvAxSEQLZa+AEWCiYUNINO3ZA/ZfGQY8Apg8OkCLbpx2ry5ETJp8JshwdugdJgl2i7QKuhr8H4LCu4ZL08g3JoCFQm0xTVlmm5G+CwBGgUYXafXWOTiGk78Cavlg1WC+LAEHYW38m7D706X+SdDK+/FtOS7N+WuB7U8Nk2Bj9xAUN8bkJY5G2YifjoWxZ54DFIKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1673303327; bh=wH6Nu+8bHDXsWlujPawaIA/wFeaq4z5ko+eHMiNqiUU=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=g413Sm7hVn0O/0jklOQ3Hk2bR8pafjHef2jI6LvVliE2s5NQBC29aGBd5zfd0lmAF+aetBJeYCgwgx3JhUCg35GhsrLXXUw2lbP8XOckPr5GUZO18jtMa2459ngLe7yTZdoXK9KFlq+04TnrDFd+my+TXZnfG4ST0+64BCPEUvEL5IF99s1tE6R+++fQm7laWgqMbCXe0u/abfnDvIzm4ifwT2kHeWojRp5HQKGpSr05SXHuCCwL/37eAJR9VkfZrBySXZah0jgkSXWjDoynjWU3Pn4D9SSrl0P/WLmMySiGX1byIoqNZmhOkwnUSR7bnq2UKnsbScuiizTTxFQH9w==
X-YMail-OSG: bvGHh8UVM1nSJGS2PG2BrhS36YIUUHYTWCQZBoM1hVbk702ZHnssJzOct90uFlv
 rjHsBUivm3a.PpIbZENndu3GX5iBUoAo91c8qmVn7.qhepIvnYKiP1nCklU8HjcK.pZie1f5O7mb
 .uwlYkm.2gCN.AG.sau23yDqX8eObuQgYRKdIX9K.6ojfF.hU6CHKU8a7sbN0FgEQh5PgC.SBQvA
 VEqtZ1pNDGcAomss.XNb1jKJWh7wBFzpxpNVHvFgIcqwd1bQZ0CbwcrRTqypmDFWPwc9XJSwtqFz
 2jeAynEtyY2BQF1_cvOcDyJYbxgxMhJlQOzCR9QZcxJt6.ckURFCDL_2_2wnbqgmZb8iCxRRTTdx
 RoceTjLeJGSug.er_VMhHfHPc8xHVW8fTkFI9Nj9PTF2ikeunWPQ2gqJlr.qgEd105PTc4LsKEob
 gxYf_yl9JZCf0riF_9GVw4UvcOnBperF4jn2wjhX8Ae7ZOG36HA_qSj58QxdLN9KLrTIgwSL.og2
 d7wbt_ZKmE00whDQos6C_OLxuxhptotZl18uGvYkCNC8Vj7igYJWVlb1VnjXpoZzQh9aM8LT87Xp
 aI7.e36jE7C9C0wTq1Qkg4Me5Vm514dqEYykMCFNXsX8lAMhqLQPVLEjKen_WIDxpWNKBkWrBfWy
 bIippg5a2ILe1JiOXGm1y4j6BrS6tDnpFOkmOHwcSQ9f4YmZKxyiAChO7zRPdC5U3W_BvtqFg4md
 WlCBDKuq0Vd4.kMKUB7AZG4sCARn_CrZgoGzDHm5KYgfLqIAxpmETe.QK8B3ZGZkz0fZ_nNUViUZ
 1AfSxd8ZCzQ6AdxFDshs.FgA2qjqOQx97.AkuqDli8AEAtUZXYVO69nZ6ocvqCQaRoDq0dl7i9ss
 ZdCBwfq0AMjeZ0lnGSQ04G6Y0EW8bZj2EjIKEW_W8ePnwMhs1ut._dBw1A9RE2fJofdqBV_BqHrS
 7UWsO.kJTUsyRpqXMru8abBurhwZJAcjf80lE5abPcvXtG9U8yWDTZsFy8KpOs1pbbyHU2jfbium
 aHbDEmy86D.UNlyYY_0EsImuOUuaxLwWr7655MTotJV_D9nGawUGCiDLLTvw3NadFPRwA76P14k7
 Ne.ea0CwreCe5xPL8UAWVlULP9Yh3lPlxs5vVjMvU3nGrRW.4GMofqEsl5HgLkKT40rjG7XIADYO
 H3fnWqbS7ar_BNOcBc2ooinXjuKIiPCDPUNbFgGLKv8RaHwQCulSEhzRgFa4dr0I_T4PEA6eqmEH
 kGmAV.668Gq7mRrXTUsya2CJJCaqYzLkyvK3lWhsnf2hU04zmGS8Tb8uPQuOQBa2f24aQCxjEcNy
 Jmfwp_1zs.atbWibTvU8Ux5.j_rcyvxRtGSP6YuqHQs5fj7M50H4Fl.wZhaltpZIzv8eUHGnUzSc
 DL15S0oNiPd7Jb.P9xkTEhLM..d.g9HUoPbst1nGLNf.kSp2I6pBEAMHRvfecuyguL7byfYdcwV_
 YMk4hfGqUxTw0KfTVsEjkpg5PhaaZpYgk5G5SwigT_.m3cmeNjIY2hof2J3rMXu_zBukH6LRSeaT
 q0YCWIK9SjM9kl6cJoCpzZRfvSzwXlt772MkcmnXEjOLYp4ve9ZFDtHvZlJYPmXp82KWS1Og9pO_
 Z4iakjHQUs_xYzyVOhN5S6ewcB2aOsoYFkXzlO0eSo.yxZdg6WT26Do9HdAyHB05P5FghJep61ho
 ehIbEbY2acV5_aFi4ZhM9zQ9PnZF7jmecjPI0BrOeU0vYTnpqNE_.optWICaQ4yuPytXr7YFDUi6
 82zRe.yo.ATjJyp_yoJwf2Gfi1FudHMPpNxUCOpIrwg.sApVg7_Z7Qq2lPVB2Y3Ig8UbwHdagaRm
 Tm8b4XwiB.OdZVi2KtQxI4__6iZ1fco9ZoST8YFRvqrrtCL2owpjN1YF0ZApSlpP0J4K2bCE2AJh
 9LUVJ7vdBqYqAc2f_JbWbEw_pQE_Pta_h63aFYP42rqODDXgTuVnnc2uK0LAxgvdjQBSBJgOeoUO
 Lq1kBgoWnOBjolaW3uWqXS7vHj4RmloU_FrURRE.csdh3vDb8neCYuqcYjH21.1yvqUQZplgiqET
 C7xX_HqKM8_r8UhfqL6JqkVDsRdxEfdKC2gkSksiYGgq6pNIbu3.rTlbaGjQtY7.ntLh6Q.9aBkk
 nL5.D_s5f7uklLsDfCbCcWa2D.93xPjanyp_y6UFx6MmTq4iOAQvH08KcB4TKZFRJ2vJp5MKDWcT
 Uh5dyNa61Xa5RPUAjUbPMJaWV0npRM6jbZjU87vJkmQh6B_jUeR5oJxAvl_9NMRvgt2kiP49ZPoj
 K
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 9 Jan 2023 22:28:47 +0000
Received: by hermes--production-bf1-5458f64d4-jvnkh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 214a75e596c68404ad838ad70f5d24dd;
          Mon, 09 Jan 2023 22:28:46 +0000 (UTC)
Message-ID: <7e1610e7-c131-e162-be47-8983be7d9aec@schaufler-ca.com>
Date:   Mon, 9 Jan 2023 14:28:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] security: binder: Add transfer_charge SElinux hook
Content-Language: en-US
To:     "T.J. Mercier" <tjmercier@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Eric Paris <eparis@parisplace.org>
Cc:     hannes@cmpxchg.org, daniel.vetter@ffwll.ch, android-mm@google.com,
        jstultz@google.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        casey@schaufler-ca.com
References: <20230109213809.418135-1-tjmercier@google.com>
 <20230109213809.418135-5-tjmercier@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230109213809.418135-5-tjmercier@google.com>
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

On 1/9/2023 1:38 PM, T.J. Mercier wrote:
> Any process can cause a memory charge transfer to occur to any other
> process when transmitting a file descriptor through binder. This should
> only be possible for central allocator processes,

How is a "central allocator process" identified? If I have a LSM that
is not SELinux (e.g. AppArmor, Smack) or no LSM at all, how can/should this
be enforced? Why isn't binder enforcing this restriction itself?

>  so a new SELinux
> permission is added to restrict which processes are allowed to initiate
> these charge transfers.

Which is all perfectly reasonable if you have SELinux.

>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> ---
>  drivers/android/binder.c            | 5 +++++
>  include/linux/lsm_hook_defs.h       | 2 ++
>  include/linux/lsm_hooks.h           | 6 ++++++
>  include/linux/security.h            | 2 ++
>  security/security.c                 | 6 ++++++
>  security/selinux/hooks.c            | 9 +++++++++
>  security/selinux/include/classmap.h | 2 +-
>  7 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 9830848c8d25..9063db04826d 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2279,6 +2279,11 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
>  	if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
>  		struct dma_buf *dmabuf;
>  
> +		if (security_binder_transfer_charge(proc->cred, target_proc->cred)) {
> +			ret = -EPERM;
> +			goto err_security;
> +		}
> +
>  		if (unlikely(!is_dma_buf_file(file))) {
>  			binder_user_error(
>  				"%d:%d got transaction with XFER_CHARGE for non-dmabuf fd, %d\n",
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index ed6cb2ac55fa..8db2a958557e 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -33,6 +33,8 @@ LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
>  	 const struct cred *to)
>  LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
>  	 const struct cred *to, struct file *file)
> +LSM_HOOK(int, 0, binder_transfer_charge, const struct cred *from,
> +	 const struct cred *to)
>  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
>  	 unsigned int mode)
>  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 0a5ba81f7367..39c40c7bf519 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1385,6 +1385,12 @@
>   *	@file contains the struct file being transferred.
>   *	@to contains the struct cred for the receiving process.
>   *	Return 0 if permission is granted.
> + * @binder_transfer_charge:
> + *	Check whether @from is allowed to transfer the memory charge for a
> + *	buffer out of its cgroup to @to.
> + *	@from contains the struct cred for the sending process.
> + *	@to contains the struct cred for the receiving process.
> + *	Return 0 if permission is granted.
>   *
>   * @ptrace_access_check:
>   *	Check permission before allowing the current process to trace the
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5b67f208f7de..3b7472308430 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -270,6 +270,8 @@ int security_binder_transfer_binder(const struct cred *from,
>  				    const struct cred *to);
>  int security_binder_transfer_file(const struct cred *from,
>  				  const struct cred *to, struct file *file);
> +int security_binder_transfer_charge(const struct cred *from,
> +				    const struct cred *to);
>  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
>  int security_ptrace_traceme(struct task_struct *parent);
>  int security_capget(struct task_struct *target,
> diff --git a/security/security.c b/security/security.c
> index d1571900a8c7..97e1e74d1ff2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -801,6 +801,12 @@ int security_binder_transfer_file(const struct cred *from,
>  	return call_int_hook(binder_transfer_file, 0, from, to, file);
>  }
>  
> +int security_binder_transfer_charge(const struct cred *from,
> +				    const struct cred *to)
> +{
> +	return call_int_hook(binder_transfer_charge, 0, from, to);
> +}
> +
>  int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
>  {
>  	return call_int_hook(ptrace_access_check, 0, child, mode);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3c5be76a9199..823ef14924bd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2066,6 +2066,14 @@ static int selinux_binder_transfer_file(const struct cred *from,
>  			    &ad);
>  }
>  
> +static int selinux_binder_transfer_charge(const struct cred *from, const struct cred *to)
> +{
> +	return avc_has_perm(&selinux_state,
> +			    cred_sid(from), cred_sid(to),
> +			    SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
> +			    NULL);
> +}
> +
>  static int selinux_ptrace_access_check(struct task_struct *child,
>  				       unsigned int mode)
>  {
> @@ -7052,6 +7060,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>  	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
>  	LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
> +	LSM_HOOK_INIT(binder_transfer_charge, selinux_binder_transfer_charge),
>  
>  	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index a3c380775d41..2eef180d10d7 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
>  	{ "tun_socket",
>  	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
>  	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
> -		      NULL } },
> +		      "transfer_charge", NULL } },
>  	{ "cap_userns",
>  	  { COMMON_CAP_PERMS, NULL } },
>  	{ "cap2_userns",
