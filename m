Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37867DA82
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjA0AOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjA0AOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:14:21 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDE773744
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:13:44 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id v81so1721321vkv.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6M6VUuC6y50LixS9iKRvLk/Cq8EVZpJ4ssnTur0XFiA=;
        b=A/C/sIIxRSvlhy361UQ4yePmn3IZBAadsgZem96O7/pPbkQeFhvWRNM1gzYZWZZ0qZ
         4tQYpIR0JPFkCY37d67tw5kLf1eig42EXByXsU/M0cKcu0zstbyHhSU5q+ymhy6K65eH
         KIJD96v2uAppSIbSVh1Rh4AQDiUgjg6XcRAnmqojM4zWobe/+jPeXveYV5hsQ/mKwPVL
         vB66iI5wbd9nNYuTeaEhXt8ND+qHrHmmPmpizPgsqm4uY3n0r0rsdVn7UdXWGlOdQjsE
         HvmvR/pJEHD7/iZHEYPu5Z63xLhjiKlP00FmkrVfmW4msRqCxhlpvhiBqCL8dY1M9Mcv
         GBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6M6VUuC6y50LixS9iKRvLk/Cq8EVZpJ4ssnTur0XFiA=;
        b=zyJ/E8XyZEh/V9L6Z5wn2yYQDBDocyT33UjEYHlJJjGlpoTsXuaDR/W1S8J1arYQBF
         67qg6QU698CsFrqFXCm5K3+OgqHy/yEo+6EZUSWFaG1XX7D11dGviTuAUcbs9rwEzc24
         BnkDRlp40tlvfARah7X5kopBqRT0uv5RSmFGKjq7DLSLTnJmgTvxwUcqPHxhP+bEFS0H
         IA+CL3vyoM/q/v+bh6k/3bmS2RnbwDjmBM6K00rDXG0xwxJ5LhQ6HaxgGNpGHADYwZvd
         tHwH4x2E1YJA/COxKf+HvoQxZfftEupERwC7Snta/UU+oEV/Izq90VkB6/kh3o7VtzWu
         0kew==
X-Gm-Message-State: AFqh2krDLwX6XF7r//i1Bqu7oIKkYsNcKUoAp18Pt1KxYSUdKRg2Qrey
        UnAN/BWV/z3M50XfqECCsCR5iZs44bc0yd0A6A7wu7Xoyojdb+q4bPU=
X-Google-Smtp-Source: AMrXdXtb4V7yorB4AQttA/hG3lP5Vd+4f4LvBL7XYdUZS+MI7VLnYkt/wMsnIvDVyiZEospxCwWUNymD9VuMZ8U4BiA=
X-Received: by 2002:a1f:d605:0:b0:3dd:fce2:8505 with SMTP id
 n5-20020a1fd605000000b003ddfce28505mr4823586vkg.40.1674778408640; Thu, 26 Jan
 2023 16:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20230125182311.2022303-1-bgardon@google.com> <20230125182311.2022303-3-bgardon@google.com>
 <CAHVum0ex4=X_iD_hKMQAkNVEcVzZSNUb_V0ApjPKxpCX+oFV6w@mail.gmail.com>
 <CANgfPd-7Yb05BYBW7TOg67qq=_vSXqrRQ_XF7WUfstQjXgyPww@mail.gmail.com>
 <CAHVum0eepF4wNp84eb2mY+Wyw0MGhyDuOu_81pvrYDbAWn2UXg@mail.gmail.com> <CANgfPd9kzBYe0C-aVnx3dbGH=MPoJrRkZ5zx=cqBzQnvH9sNQw@mail.gmail.com>
In-Reply-To: <CANgfPd9kzBYe0C-aVnx3dbGH=MPoJrRkZ5zx=cqBzQnvH9sNQw@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Thu, 26 Jan 2023 16:13:01 -0800
Message-ID: <CALzav=cobek+hQ530L2Y2Hsbh9J5Jn5yVEPqOwRe3J+KgRSchA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selftests: KVM: Add dirty logging page splitting test
To:     Ben Gardon <bgardon@google.com>
Cc:     Vipin Sharma <vipinsh@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ricardo Koller <ricarkol@google.com>
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

On Thu, Jan 26, 2023 at 3:12 PM Ben Gardon <bgardon@google.com> wrote:
>
> On Thu, Jan 26, 2023 at 3:04 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Thu, Jan 26, 2023 at 2:52 PM Ben Gardon <bgardon@google.com> wrote:
> > >
> > > On Thu, Jan 26, 2023 at 12:06 PM Vipin Sharma <vipinsh@google.com> wrote:
> > > >
> > > > On Wed, Jan 25, 2023 at 10:23 AM Ben Gardon <bgardon@google.com> wrote:
> > > >
> > > > > +static void run_vcpus_get_page_stats(struct kvm_vm *vm, struct kvm_page_stats *stats, const char *stage)
> > > > > +{
> > > > > +       int i;
> > > > > +
> > > > > +       iteration++;
> > > > > +       for (i = 0; i < VCPUS; i++) {
> > > > > +               while (READ_ONCE(vcpu_last_completed_iteration[i]) !=
> > > > > +                      iteration)
> > > > > +                       ;
> > > > > +       }
> > > > > +
> > > > > +       get_page_stats(vm, stats, stage);
> > > >
> > > > get_page_stats() is already called in run_test() explicitly for other
> > > > stats. I think it's better to split this function and make the flow
> > > > like:
> > > >
> > > > run_vcpus_till_iteration(iteration++);
> > > > get_page_stats(vm, &stats_populated, "populating memory");
> > > >
> > > > This makes it easy to follow run_test_till_iteration() and easy to see
> > > > where stats are collected. run_test_till_iteration() can also be a
> > > > library function used by other tests like dirty_log_perf_test
> > >
> > > Yeah, either way works. We can do it all in the run_tests function as
> > > I originally had or we can have the run vcpus and get stats in a
> > > helper as David suggested or we can separate run_vcpus and get_stats
> > > helpers as you're suggesting. I don't think it makes much of a
> > > difference.
> > > If you feel strongly I can send out another iteration of this test.
> > >
> >
> > I should have read David's comment and responded in that version.
> > No strong feelings. It is up to you.
>
> No worries, it probably would have been easier to track down if I had
> links in the cover letter. :)

I mostly wanted the loop to go in a helper and threw in the stats
without really thinking about it. Now that I see it I like Vipin's
idea of having the stats call separate.
