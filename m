Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1361195E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJ1Rhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1Rhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:37:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C620354A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:37:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so7497170wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kV7MmgRICexqZDA6XAEcNOU0nOiN/bt/4yb0+BmfSag=;
        b=n0HXNyNNgb8L2VChFAUYfXPFicNplKItk5SACKHVuPWpeT4s/6BeK3eYhhaFMWNDIK
         /4hDz0w3cTw8aQBYvZ7SeVvKWCCwQeheBJlYpxWmZ/aREopPexhUqtNL9L/9NKK/uZHF
         jC9QPVgWZymcb3YFZA+OyIes9I/31C02aCUph7DLSx4rpejEQqVA65y+cjTOxD/Y8hNQ
         gfPsxxOp+JNDvvy1I7jUSNyfrltalszW+OvXbddPUzU8C4QtfT+tCbLS3GpWvd00svJs
         PsM3YgXA8es/JfPgYj8HeUXMr3WcDEnaEnUHj0SH9OtU+/3hJa5IwzWotVyzA0p0ATlG
         90OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kV7MmgRICexqZDA6XAEcNOU0nOiN/bt/4yb0+BmfSag=;
        b=TpMqxfOkr9x80uz4H9MC1HNmuRPXyYlXZ/qnohcZ74vSPz24syMybCrMpK/MGk6ZsU
         US7ZVbiu5W3owP0AZrTKeQ/71iMhN9pX+cE86c5ncvDYm3ixvEqUoCzZXtRdIj2EZCTC
         mVEmqkjQ2BOgIH13GgEYeLdDZ0t1X9xXFtjb+OY86BLSKXwtyE33M8zKnGsq6WYkvSbR
         maiDxvqTcfRaaoAfZysmaJWCHswgriQ9PJ4sZl7g8CbygXyTHb2FINMgnm0fSq3/Uytr
         ptVo4yRI3/OL3qhdDffrzGJyx0fXXiSirEel+TBm4prC8XpqH+49WeAGsIlWhSD+kmF4
         KfMA==
X-Gm-Message-State: ACrzQf0hIFiGzSW8ALb8La0GTXB1KBOZoeon1OFXezcRF1XHftkf9oCs
        kuaJnhqr9+WpA/74XXKu0oss9u9ztfEsaZlGzS+Pfw==
X-Google-Smtp-Source: AMsMyM6r0OZ72MOueBEdYgdzX8Jy3UmVthkJtTnrV3tLfySk6NlYuJkc172vH7YxWl/wqUyzSmDPGIwADJL4tpgeGiU=
X-Received: by 2002:adf:e94a:0:b0:236:6f5a:e89b with SMTP id
 m10-20020adfe94a000000b002366f5ae89bmr282460wrn.451.1666978660361; Fri, 28
 Oct 2022 10:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221021211816.1525201-1-vipinsh@google.com> <20221021211816.1525201-6-vipinsh@google.com>
 <DS0PR11MB637351B52E5F8752E7DA16A4DC309@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y1lV0l4uDjXdKpkL@google.com> <DS0PR11MB6373E6CA4DDFFD47B64CB719DC339@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y1qqIgVdZi7qSUD0@google.com> <CAHVum0edLWu0fGMgs7n2v2Fu-XW5mXtAsJ2dtkWD=ZadbRi+hw@mail.gmail.com>
 <DS0PR11MB63735722DBD08190B849DD9DDC329@DS0PR11MB6373.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB63735722DBD08190B849DD9DDC329@DS0PR11MB6373.namprd11.prod.outlook.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Fri, 28 Oct 2022 10:37:04 -0700
Message-ID: <CAHVum0dXYxD1-90mwq2Q5YojoWPiomPWhAGsgFzC_fSB7qF4ew@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] KVM: selftests: Allowing running
 dirty_log_perf_test on specific CPUs
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "Christopherson,, Sean" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dmatlack@google.com" <dmatlack@google.com>,
        "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 7:11 PM Wang, Wei W <wei.w.wang@intel.com> wrote:
>
> On Friday, October 28, 2022 4:03 AM, Vipin Sharma wrote:
> > pthread_create() will internally call sched_setaffinity() syscall after creation of a
> > thread on a random CPU. So, from the performance side there is not much
> > difference between the two approaches.
>
> The main difference I see is that the vcpu could be created on one NUMA node by
> default initially and then gets pinned to another NUMA node.
>

pthread_create(..., &attr,...) calls clone and then
sched_setaffinity(). This is not different than calling
pthread_create(...,NULL,...) and then explicitly calling
sched_setaffinity() by a user. vCPU creation on one NUMA node and then
getting pinned to another NUMA node is equally probable in both
approaches.
