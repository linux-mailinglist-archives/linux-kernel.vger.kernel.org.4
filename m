Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27470650A05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiLSKWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiLSKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:22:14 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E511099
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:22:13 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id k2so3524831qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=peFPU5G0uhvsdpy5rruoB5GWWtp6Vqfz5v7gtK/4+EQ=;
        b=EwQmoxNJ/b6/Qv1FyRK/bpo+IqkR5cX1I6Ty+VvsWRpFEP+0hApS0/W5wwl8cZ/Rnu
         eCbWqYD3jsKN5drRfFpaYEcttPA2ltT/bdi4jYuBpo69dcYS5isJQqCgcEJq3hZ+Mg55
         xbWT9kM3Xv/UWZqnr22beqysrQaYTLb+IOoAXsndfdacNxlvivTd7PDrpMP2f4PbZmAR
         VxPJJ1tSsTRx/Szwcw8efdXXk0xkIF6mkElQBzSrn5751sqilHAt96Mdl0CNyAC+S6l6
         tPkOaQMsxrv6Df4o3YN5KsBXWvaa/705vYa3EFlXru82n8EsZk5jnuqSERFtpQahiy3i
         2iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peFPU5G0uhvsdpy5rruoB5GWWtp6Vqfz5v7gtK/4+EQ=;
        b=F+7RIVw0Ov5+ttHsAb/va3st/hopDf9K+2856QoBA0qQcLfXiEszNo8DDb4qKe0Rtg
         e6C6RD7mKgKDbn1HBZFKT3kj8PeTbfzyLB+N96g4k8sgwLhY6LM5ZqvNrCfdPJcyH7l2
         1USqCzV/PraObasEI/ioQv8EYBjmbg35Pg70H0jUNaYaObjmxQBt7LpxVW6y/bMJ/f1v
         9pKPCbDpwZIzQot1yLAlFVdCFWnmXBu0gHClQE9aT6ZymeoeGUxBbkTt7bJ+/ZQ+kiJF
         hVTYGw4GJbFfirsQ2hMgK+fpB9xWgGMSKl3mp8654wfnXAtCIuCqE9p1H0bPpeFO/Nl6
         Vv3A==
X-Gm-Message-State: ANoB5pnoVbcr3TxL07S9Vr2iy+/iQx6NOnRvOdIsiF7S2ywySlmh47rC
        +H27RryMJ82uYuY5C9vZRVxIBAR+nYGmCXX7C9x26A==
X-Google-Smtp-Source: AA0mqf5m8Gh2Tl1mOvMGQFI2fTlkk358DcupsJ/CYK7j/u3aKsh1blMz7VATLFRhzNC9gYdwPvUz3FAZ1xClhFxmu7U=
X-Received: by 2002:a37:9546:0:b0:6fb:dbdb:94af with SMTP id
 x67-20020a379546000000b006fbdbdb94afmr80547190qkd.499.1671445332745; Mon, 19
 Dec 2022 02:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20221214114447.1935755-1-peternewman@google.com>
 <20221214114447.1935755-2-peternewman@google.com> <bbc57154-b7f5-4b9a-65ba-ca8dc0fe0dfe@intel.com>
 <CALPaoCgt+epHFO=O8B0LWfps0NjJ1RvwmfGey22XyamkUbm0hg@mail.gmail.com> <87a9df72-f15a-0cf6-566c-dd7522d40c4e@intel.com>
In-Reply-To: <87a9df72-f15a-0cf6-566c-dd7522d40c4e@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 19 Dec 2022 11:22:01 +0100
Message-ID: <CALPaoCi8hcFzNN9O9fS9Etri_KMdU32UU1tJsfeO1OxR-i1j7g@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] x86/resctrl: Fix task CLOSID/RMID update race
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, bp@alien8.de, derkling@google.com,
        eranian@google.com, hpa@zytor.com, james.morse@arm.com,
        jannh@google.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
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

On Fri, Dec 16, 2022 at 8:36 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 12/16/2022 2:26 AM, Peter Newman wrote:
> > However I can make a case that it's exploitable:
> >
> > "In a memory bandwidth-metered compute host, malicious jobs could
> > exploit this race to remain in a previous CLOSID or RMID in order to
> > dodge a class-of-service downgrade imposed by an admin or steal
> > bandwidth."
> >
>
> I am not comfortable with such high level speculation. For this
> exploit to work the malicious jobs needs to control scheduler decisions
> as well as time the exploit with the admin's decision to move the target task.

I imagined if the malicious job maintained a large pool of threads in
short sleep-loops, after it sees a drop in bandwidth, it can cue the
threads to measure their memory bandwidth to see if any got past the
CLOSID change.

I don't know whether having fast, unmetered bandwidth until the next
context switch is enough of a payoff to bother with this, though. Our
workloads have too many context switches for this to be worth very much,
so I'm fine with letting others decide how important this fix is to
them.

-Peter
