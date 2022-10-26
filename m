Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56EE60E6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiJZRqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiJZRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:46:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86109E68D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:46:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v1so27642046wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj1L80FtOs0orxn6X0gILkrdRQ/RKsXz+OjfG4weBgU=;
        b=SkWCXVbokO/TxRPqxKje1T/QC8x9Ff41ZLIvID19br18mOD3RE6NXQ8tcJFcZ7UhGi
         WN3KQClt7QBkDHfnkgxNgQ3AnKmAdyxoAPV0ukBnhqwFoExzMqB6dnZHfwSWfrbFvstN
         cV2PORxY9FYOQZ9xhOQ6S8OdQk2b960gFpZCLXMQmHttB0sPli6hkMAEd/FWboo6L0WA
         pWbgbIIUy8ELlEVQ47Z0CyA1pIW/F+QFGSfpFnZIbk+aNw6GM/DHhTADLATTdaWYMvUj
         W9trJMC/yS1Nd+kOTAch6CTIPaLQTzgiquxIX2br3qyrUrLsPl4EFb/W41hqTTQ1aDyU
         pMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rj1L80FtOs0orxn6X0gILkrdRQ/RKsXz+OjfG4weBgU=;
        b=1PkH0ACXOnIZGgU78RxwkpYlpgnPxXILDxxWQxtVlHr6X2AZNThXN7+1FVJL/0rB8g
         E608hhpXJIGMjkq9WMc7UiO+LU88+/u+/ncb3aDf0IfLPn8WJ10igvs3P/vqc69bJ7oy
         0YlTSJNARBAuFmWxxSITvnWYjAb47WUFowcdrUi7Bm5iVqHu7sn7oQoF63Adk2gP5+JF
         +/x9M2cQeNu0YPAFrFatrYYZEiGqoPrloVtcsdIdk3AiVRPjxRMUSfZu7DcKlPzigTto
         q3ZGsiRkn1bObpSFv4IiY38O7sDYWVtn3UTNBGCvuf8WytDZtcx1sYTF9cPXA6qLITpC
         u6cA==
X-Gm-Message-State: ACrzQf0KpMmi2JBQEWn+b10LZDgWeJADHN0w0C6WM0/3uBaXAAzpHs/F
        tIaHZFe9L7T1rSOw28ji1bumnWmD+FNFWyWUALRQmQ==
X-Google-Smtp-Source: AMsMyM5YqF503m1I9x7sFWZ3FLtFKocw1/ESvNCmY/TY+BfTWLh2dBnnNyl9YFt0PDusJmS2q2zWAE+9NvIiQ1uhtG0=
X-Received: by 2002:a5d:47a1:0:b0:236:6f4d:1db3 with SMTP id
 1-20020a5d47a1000000b002366f4d1db3mr12105289wrb.383.1666806365168; Wed, 26
 Oct 2022 10:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221021211816.1525201-1-vipinsh@google.com> <20221021211816.1525201-3-vipinsh@google.com>
 <DS0PR11MB63738A6EDEAFA2CC05BBE14CDC309@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Y1lMkVip4AYIMZiK@google.com>
In-Reply-To: <Y1lMkVip4AYIMZiK@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 26 Oct 2022 10:45:28 -0700
Message-ID: <CAHVum0d2irL8Jwo=uw2eBARuLjYaMtsP0E-wOG4tn2ba1PkA7Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] KVM: selftests: Put command line options in
 alphabetical order in dirty_log_perf_test
To:     Sean Christopherson <seanjc@google.com>
Cc:     "Wang, Wei W" <wei.w.wang@intel.com>,
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

On Wed, Oct 26, 2022 at 8:04 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Oct 26, 2022, Wang, Wei W wrote:
> > On Saturday, October 22, 2022 5:18 AM, Vipin Sharma wrote:
> > > There are 13 command line options and they are not in any order. Put them in
> > > alphabetical order to make it easy to add new options.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > > ---
> > >  .../selftests/kvm/dirty_log_perf_test.c       | 36 ++++++++++---------
> > >  1 file changed, 19 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > > b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > > index 56e08da3a87f..5bb6954b2358 100644
> > > --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > > +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> > > @@ -406,50 +406,52 @@ int main(int argc, char *argv[])
> > >
> > >     guest_modes_append_default();
> > >
> > > -   while ((opt = getopt(argc, argv, "eghi:p:m:nb:f:v:os:x:")) != -1) {
> > > +   while ((opt = getopt(argc, argv, "b:ef:ghi:m:nop:s:v:x:")) != -1) {
> > >             switch (opt) {
> > > +           case 'b':
> > > +                   guest_percpu_mem_size = parse_size(optarg);
> > > +                   break;
> >
> > "break" wasn't there.
> > This is kind of a functional change (i.e. bug fixing), and would be better to be
> > moved to patch 1.
>
> Ya, good catch.

diff is not very good in showing intuitive diff. "break" was there, it
just added "case 'o'" before it and didn't move break.

-               case 'b':
-                       guest_percpu_mem_size = parse_size(optarg);
+               case 'o':
+                       p.partition_vcpu_memory_access = false;
                        break;
