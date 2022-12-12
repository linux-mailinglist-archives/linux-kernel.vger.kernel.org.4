Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB05264ABDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiLLX5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiLLX4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:56:51 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5417ABA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:56:49 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id 124so13036699vsv.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eHq3rzfk2qISOWZcDMGW7xUibVQqdvKPqxr9reQmboQ=;
        b=pDKP2uUmsBqeWXTxerK+YOE9qjhW+1jz+PE4oNk3YdSQ+UtNBA2IuzM5G9Vlki6fzU
         1it/Nswtychto2+R0hS+9taSaHS4g1fj8EPHGF+AZ81jPkiPWvYZXiQabN5FbbbUuiHP
         b6PYAEWitKQ9D1/HWqvAir3kfpfpmydaEI8HQSEBkv3rOY6lBXZ+aaIJkRtG3mDcOJaj
         7YzBHipfGnRzi+6dcCENw1mU0wF0uVgMYJyejq479Ol43iesXNF9uIhX3Wkf/DrTLJyn
         weH0yNkLEI4HOnSjqLAE6sT/FoIuZckGvDZMwyQcsl42tdg2nOTO4AUEefEAn9ttrVz5
         YHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHq3rzfk2qISOWZcDMGW7xUibVQqdvKPqxr9reQmboQ=;
        b=z6WjY/W7EtZGVHGqJwyNrXZojIPvm763NpWCUJk5KLlbVke0ayl9/8I+AjGkePsIDw
         h63zcOjRltZVP4udshaNUpqqTSDYVOJwIJ/I/cOehMFjT2fdsMkxg5Sl46kTffbllkIn
         2sxIbcMRqxhAjgtydV/672c2uFiLNOsA2faQQJkSDeRNVQe/4XAVPFb4l1C1skRTsJIL
         luPpoHMPpfSBOKHswhfoQ4SLHT9Pxnjc8rVxUkVYaKVlGfd+M1B5zGRA4KCSDSeK2lTW
         Y99FQbdA/KxopZUWWDaHEzTJuiO1l8IUtfFdij8Z1WECBjOSSpMnlTQVBSVBZs+MEHuh
         FR6A==
X-Gm-Message-State: ANoB5pm1pXM9a+do8RhdnSL7sILa49j9490klrWdfPrF5tu1Opy9bBzA
        uiIcjHE8qnyboQhfca+uZkL4bWi5ceAvZuUgSb946Q==
X-Google-Smtp-Source: AA0mqf4dBZXyoX6j/ZmTnXjFrY5NGk2XmW6TLGmDbTcIIGQE0W7Uk8mwXGjeIhvFxbPHecUXCVk6sha/2aVg5prqYUY=
X-Received: by 2002:a05:6102:308b:b0:3b2:f4e4:a865 with SMTP id
 l11-20020a056102308b00b003b2f4e4a865mr6174402vsb.71.1670889408635; Mon, 12
 Dec 2022 15:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20221208135327.01364529@canb.auug.org.au> <bff89220-df3a-a148-2ba4-6aad3874f322@canonical.com>
 <8e82905f-8bdf-05de-2e6a-d8b896d75910@linuxfoundation.org>
 <0e678eb2-455c-88f5-6732-2e8701ebb6e6@linuxfoundation.org>
 <9b21c055-4e1a-2c34-281c-39af7d73fe80@canonical.com> <fa9145fe-9815-900f-6dd0-bf80019a319e@linuxfoundation.org>
 <c4560ccd-fad4-ecb9-4d57-64d94b5ebf30@canonical.com> <a116990c-f544-9dce-0ee5-ab7fbe2601ca@linuxfoundation.org>
In-Reply-To: <a116990c-f544-9dce-0ee5-ab7fbe2601ca@linuxfoundation.org>
From:   David Gow <davidgow@google.com>
Date:   Tue, 13 Dec 2022 07:56:37 +0800
Message-ID: <CABVgOSk_ud=+3f0-T_Qx6vw34mUvba48=VbwkvN5dtX0z=DBsA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kunit-next tree with the apparmor tree
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>
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

On Tue, 13 Dec 2022 at 07:19, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 12/12/22 12:53, John Johansen wrote:
> > On 12/12/22 11:48, Shuah Khan wrote:
> >> On 12/12/22 12:20, John Johansen wrote:
> >>> On 12/12/22 10:03, Shuah Khan wrote:
> >>>> On 12/12/22 10:52, Shuah Khan wrote:
> >>>>> Hi David,
> >>>>>
> >>>>> On 12/8/22 13:10, John Johansen wrote:
> >>>>>> On 12/7/22 18:53, Stephen Rothwell wrote:
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> Today's linux-next merge of the kunit-next tree got a conflict in:
> >>>>>>>
> >>>>>>>    security/apparmor/policy_unpack.c
> >>>>>>>
> >>>>>>> between commits:
> >>>>>>>
> >>>>>>>    371e50a0b19f ("apparmor: make unpack_array return a trianary value")
> >>>>>>>    73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking trans_table")
> >>>>>>>    217af7e2f4de ("apparmor: refactor profile rules and attachments")
> >>>>>>> (and probably others)
> >>>>>>>
> >>>>>>> from the apparmor tree and commit:
> >>>>>>>
> >>>>>>>    2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
> >>>>>>>
> >>>>>>> from the kunit-next tree.
> >>>>>>>
> >>>>>>> This is somewhat of a mess ... pity there is not a shared branch (or
> >>>>>>> better routing if the patches).
> >>>>>>>
> >>>>>> sorry, there was a miscommunication/misunderstanding, probably all on me, I
> >>>>>> thought the kunit stuff that is conflicting here was going to merge next
> >>>>>> cycle.
> >>>>>>
> >>>>>
> >>>>
> >>>> How about I just drop the following for now and handle this in the next cycle?
> >>>
> >>> if you want, the other way to handle it is we coordinate our pull requests.
> >>> You go first. And then I will submit a little later in the week, with the
> >>> references to the merge conflict and a pointer to a branch with it resolved.
> >>> This isn't even a particularly tricky merge conflict, it just has the little
> >>> subtly around making sure the include symbols are conditional.
> >>>
> >>
> >> I assume Linus will not see any problems without your pull requests. In which
> >> case we can do this:
> >>
> >> - I send my pull request today
> >> - You can follow with yours with the fixes later on this week
> >>
> >
> > okay
> >
> >>> This doesn't affect me much as there is already another merge conflict with
> >>> the security tree that I need to deal with.
> >>>
> >>
> >>
> >>>> I think it might be least confusing option. Let me know. I can just do that
> >>>> and then send pull request in a day or tow once things settle down in next.
> >>>>
> >>>> 2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
> >>>>
> >>>
> >>> that is the other option. If you go that route I can help you do the rebase/merge
> >>> fix.
> >>>
> >>
> >> Let's go with your earlier suggestion.
> >>
> >
> > ack
> >
> >>> looking back at this, there wasn't anything explicit about this not going upstream
> >>> this cycle, I must have just assumed as the final version came about after rc7. So
> >>> my bad.
> >>>
> >>
> >> Right - I ended up taking this as it looked like a patch if included could
> >> enable other changes to follow without being blocked. Also rc8 was in plan.
> >>
> >
> > yeah, my bad
> >
>
> No worries. Sent pull request with a note about apparmor and our
> coordinated pull requests with you on the cc.
>
> thanks,
> -- Shuah
>

Thanks John, Shuah for sorting this out. I confess that I hadn't
noticed the conflict before proposing this for 6.2: in retrospect I
should've checked more carefully given the amount of churn in the
patch.

If we have to drop this patch and split the series, that's not a
problem: it's really just an example. But if the conflict's resolved,
that's even better.

Thanks again!

-- David
