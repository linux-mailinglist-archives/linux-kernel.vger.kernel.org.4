Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF65C64CC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiLNOVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:21:53 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13F15713
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:21:51 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id pe2so1312824qkn.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kDrd5LWHu7SFhoK3ArpQ6anU85veXsI/kgvQs+A5e0s=;
        b=Y0stoYgLBqwdB2wfw8i5WG0XwH8q4WpC0R3WC95a3HU5FR6ExkD5zOpapq6GvhZafk
         LF5+8T/VWA1jPogCgbpA9tGXlPMp9jRMRw3eriqhZHnoVU9hwtiKKzxCicyNsam/P6Md
         SH5u6Alnf9k7b1ltFtFu+kACfi/Y97aOwtDOvv240nRGMCg/ZO+P+40dGT9AmPhSg+Rz
         hEJmZDmeN+7l3dJcouQTjMv739GQ6cFnLOeXFt2X5QWEuaEwb6jW/L/1rc8eRQG71BdG
         pqtkg17czi1UHZ33baJAhxKlAI2Z9l2ANesGZd5g3e9Nph+k+/BqtEQDYMJX/vEOOfW+
         RNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDrd5LWHu7SFhoK3ArpQ6anU85veXsI/kgvQs+A5e0s=;
        b=VpEsfKSEsnDdN0d2l1m0kgx/1oNiYU4ECUl3kXv0p3AQcx8ZDezjAuuewMSj43Z7KD
         Vy7BlQdaea+MyilO20DpFc1IwfWQcPmEztHZOy3ej7dX0PLacEV24lQVC+GHMnWJH+t6
         YrNS2I1lNrAy1+DkFI/SriRPXc0K3RsQK16XrqecbZvUzghsWx50cMGrVpy7OnljKawv
         3EbCRi1Mg/N7R1Vpq/+zlzUELel+2gC0NuMKYSs84wRwTv3/p0yJmU9y726KCXDO3bmp
         TH7OcIKbbs+ezglPQ6W2mO7dQSeKxQSW00qItkwm14XL/7Z568Lb2k4WMsR4xGfe+YXR
         REKg==
X-Gm-Message-State: ANoB5pn9xheS6LK02lhUGhvwwSNet/0ZpiyIIwQRh44rjhY5y1N022Mr
        q5a67W91H3UZ6pAC2r2oVQkDkmxfkGKpJtedkudTYg==
X-Google-Smtp-Source: AA0mqf6KAwaKYBr3eFizClFEUVDbvXhmgdwDSVGVmV4rExDnWPo5F35b9e2GE0i2rqr+4oYY8Wxk9V8Ubghm5G45gPw=
X-Received: by 2002:a05:620a:222d:b0:6ff:ca94:e927 with SMTP id
 n13-20020a05620a222d00b006ffca94e927mr85027qkh.116.1671027710683; Wed, 14 Dec
 2022 06:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20221207112924.3602960-1-peternewman@google.com>
 <f58e6af2-aa16-9461-d40d-1e4e52ee6943@intel.com> <CALPaoCiB-vOuXJYkaLLsxSKHcjT55q1RSNBjhHUWmPL9rFdF8A@mail.gmail.com>
 <74cfd689-3c03-5f41-d01c-efab04ce4197@intel.com>
In-Reply-To: <74cfd689-3c03-5f41-d01c-efab04ce4197@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 14 Dec 2022 15:21:39 +0100
Message-ID: <CALPaoChbJNYBXvOwftSxApo_ca6BLC7Ej21cDAaKdj9LOJumxw@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        linux-kernel@vger.kernel.org, eranian@google.com,
        Babu Moger <Babu.Moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Thu, Dec 8, 2022 at 7:31 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> I think this can be cleaned up to make the code more clear. Notice the
> duplication of following snippet in __mon_event_count():
> rr->val += tval;
> return 0;
>
> I do not see any need to check the event id before doing the above. That
> leaves the bulk of the switch just needed for the rr->first handling that
> can be moved to resctrl_arch_reset_rmid().
>
> Something like:
>
> void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d, ...
> {
> ...
> struct arch_mbm_state *am;
> struct mbm_state *m;
> u64 val = 0;
> int ret;
>
> m = get_mbm_state(d, rmid, eventid); /* get_mbm_state() to be created */

Good call. When prototyping another change, I quickly found the need to
create this myself.

> if (m)
> memset(m, 0, sizeof(*m));

mbm_state is arch-independent, so I think putting it here would require
the MPAM version to copy this and for get_mbm_state() to be exported.

>
> am = get_arch_mbm_state(hw_dom, rmid, eventid);
> if (am) {
> memset(am, 0, sizeof(*am));
> /* Record any initial, non-zero count value. */
> ret = __rmid_read(rmid, eventid, &val);
> if (!ret)
> am->prev_msr = val;
> }
>
> }
>
> Having this would be helpful as reference to Babu's usage.

His usage looks a little different.

According to the comment in Babu's patch:

https://lore.kernel.org/lkml/166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu/

+ /*
+ * When an Event Configuration is changed, the bandwidth counters
+ * for all RMIDs and Events will be cleared by the hardware. The
+ * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
+ * every RMID on the next read to any event for every RMID.
+ * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
+ * cleared while it is tracked by the hardware. Clear the
+ * mbm_local and mbm_total counts for all the RMIDs.
+ */
+ resctrl_arch_reset_rmid_all(r, d);

If all the hardware counters are zeroed as the comment suggests, then
leaving am->prev_msr zero seems correct. __rmid_read() would likely
return an error anyways. The bug I was addressing was one of reusing
an RMID which had not been reset.

>
> Also please note that I changed the __rmid_read(). There is no need
> to require each __rmid_read() caller to test MSR bits for validity, that
> can be contained within __rmid_read().
>
> Something like below remains:
>
> static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> {
>
> ...
>
> if (rr->first) {
> resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
> return 0;
> }
>
> rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
> if (rr->err)
> return rr->err;
>
> rr->val += tval;
> return 0;
>
> }
>
> What do you think?

Looks much better. This function has been bothering me since the
refactor. I'll see how close I can get to this in the next patch.

Thanks!
-Peter
