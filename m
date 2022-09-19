Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69C45BD0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiISP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiISP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:26:51 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04301181E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:26:48 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:37956)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oaIfW-005Wnj-Uy; Mon, 19 Sep 2022 09:26:46 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41790 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oaIfV-007gxH-R0; Mon, 19 Sep 2022 09:26:46 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
References: <87wnc1i2wo.fsf@email.froward.int.ebiederm.org>
        <cover.1660664258.git.legion@kernel.org>
        <63e9e1ff5f988108ceb663a2fbc23a137b0b4311.1660664258.git.legion@kernel.org>
Date:   Mon, 19 Sep 2022 10:26:39 -0500
In-Reply-To: <63e9e1ff5f988108ceb663a2fbc23a137b0b4311.1660664258.git.legion@kernel.org>
        (Alexey Gladkov's message of "Tue, 16 Aug 2022 17:42:43 +0200")
Message-ID: <87mtav2xn4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oaIfV-007gxH-R0;;;mid=<87mtav2xn4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19FeOvQODTe510BuET6C+7fmRqHaDsDDQw=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alexey Gladkov <legion@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 522 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.00
        (0.2%), extract_message_metadata: 4.2 (0.8%), get_uri_detail_list: 2.1
        (0.4%), tests_pri_-1000: 3.6 (0.7%), tests_pri_-950: 1.44 (0.3%),
        tests_pri_-900: 1.20 (0.2%), tests_pri_-90: 98 (18.8%), check_bayes:
        96 (18.3%), b_tokenize: 10 (2.0%), b_tok_get_all: 11 (2.0%),
        b_comp_prob: 2.9 (0.5%), b_tok_touch_all: 66 (12.6%), b_finish: 1.62
        (0.3%), tests_pri_0: 382 (73.2%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 1.05 (0.2%), tests_pri_10:
        2.5 (0.5%), tests_pri_500: 9 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 1/3] sysctl: Allow change system v ipc sysctls inside
 ipc namespace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Gladkov <legion@kernel.org> writes:

> Rootless containers are not allowed to modify kernel IPC parameters.
>
> All default limits are set to such high values that in fact there are no
> limits at all. All limits are not inherited and are initialized to
> default values when a new ipc_namespace is created.
>
> For new ipc_namespace:
>
> size_t       ipc_ns.shm_ctlmax = SHMMAX; // (ULONG_MAX - (1UL << 24))
> size_t       ipc_ns.shm_ctlall = SHMALL; // (ULONG_MAX - (1UL << 24))
> int          ipc_ns.shm_ctlmni = IPCMNI; // (1 << 15)
> int          ipc_ns.shm_rmid_forced = 0;
> unsigned int ipc_ns.msg_ctlmax = MSGMAX; // 8192
> unsigned int ipc_ns.msg_ctlmni = MSGMNI; // 32000
> unsigned int ipc_ns.msg_ctlmnb = MSGMNB; // 16384
>
> The shm_tot (total amount of shared pages) has also ceased to be
> global, it is located in ipc_namespace and is not inherited from
> anywhere.
>
> In such conditions, it cannot be said that these limits limit anything.
> The real limiter for them is cgroups.
>
> If we allow rootless containers to change these parameters, then it can
> only be reduced.

Manfred does that analysis sound correct to you?
Do you have any concerns about allowing the users who create the ipc
namespace to be able to set it's limits?

At a quick skim through everything Alex's analysis above appears
correct to me.

From 10,000 feet this patch looks good.  I do see a couple of nits
that should be fixed before we merge this into Linus's tree.


> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>  ipc/ipc_sysctl.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index ef313ecfb53a..87eb1b1e42fa 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -192,23 +192,47 @@ static int set_is_seen(struct ctl_table_set *set)
>  
>  static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
>  {
> -	int mode = table->mode;
> -
> -#ifdef CONFIG_CHECKPOINT_RESTORE
>  	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Historically that was the best we could do.  But now that we have
an ipc_set member in struct ipc_namespace you can use container_of
to compute this value.

For a permission check that is much safer.

> +#ifdef CONFIG_CHECKPOINT_RESTORE
>  	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
>  	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
>  	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
>  	    checkpoint_restore_ns_capable(ns->user_ns))
> -		mode = 0666;
> +		return 0666;
>  #endif
> -	return mode;
> +	if (ns->user_ns != &init_user_ns) {
> +		kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
> +		kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
> +
> +		if (uid_valid(ns_root_uid) && uid_eq(current_euid(), ns_root_uid))
> +			return table->mode >> 6;
> +
> +		if (gid_valid(ns_root_gid) && in_egroup_p(ns_root_gid))
> +			return table->mode >> 3;

From 10,000 fee this is fine.  But this has to interact with
test_perm in proc_systl.c.  So can you please do what
net_ctl_permissions does and replicate the chosen mode all through
the mode line.

Perhaps something like:

	kuid_t ns_root_uid;
	kgid_t ns_root_gid

	ipc_set_ownership(head, table, &ns_root_uid, &ns_root_gid);

#ifdef CONFIG_CHECKPOINT_RESTORE
	if (...)
        	mode = 0666;
        else
#endif        
        if (uid_eq(current_euid(), ns_root_uid))
		mode >>= 6;
        
        else if (uid_eq(in_group_p(ns_root_gid))
		mode >>= 3;

	mode &= 7;
        mode = (mode << 6) | (mode << 3) | mode;
        return mode;
        

If we always pass through the same logic there is the advantage that we
will always test it, and there is less room for bugs to slip through.

I added a couple of unnecessary simplifications in there that I just
saw as I was writing my example code.

Eric


> +	}
> +
> +	return table->mode;
> +}
> +
> +static void ipc_set_ownership(struct ctl_table_header *head,
> +			      struct ctl_table *table,
> +			      kuid_t *uid, kgid_t *gid)
> +{
> +	struct ipc_namespace *ns =
> +		container_of(head->set, struct ipc_namespace, ipc_set);
> +
> +	kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
> +	kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
> +
> +	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
> +	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
>  }
>  
>  static struct ctl_table_root set_root = {
>  	.lookup = set_lookup,
>  	.permissions = ipc_permissions,
> +	.set_ownership = ipc_set_ownership,
>  };
>  
>  bool setup_ipc_sysctls(struct ipc_namespace *ns)

I can't see anything wrong with your proposed ipc_set_ownership.

Eric

