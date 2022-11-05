Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A535A61A652
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 01:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKEANM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 20:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKEANJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 20:13:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8902A941
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 17:12:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ud5so17219011ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 17:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vmDdnsiqYQ5dSYncDjsXtCDMJrfj6efGFHqiNmz/bqk=;
        b=L4DRslqslApE6ut9YMJBqzDCAjS7p6SG4y65vH7qYsavlM3CaPNMiOeK5KvemSMafd
         rbI+zGwuRSO2lM3Ow96+pz2Vr+h2stNgJ2+uWjnxpVrxuqYEBUPR/aDtfy9Zl6G2/W9k
         vyDojD0CBeosUD5imqmqM57XmiVRVpTNoJoXmlE7miXfWQSMz7/G0k261HZQXpDKWq3l
         kL8muVYHPoJuhK/Wr4D7uWaYc9SzxqnQbsKj/TCM8fC4GSveSbpbEfGb4Y3HmqDSnBGC
         f3X5KkGODEH1504eS3Bdo7wSM8prGxJLHdhx8pofeuA20YJ+lOeT9LVIAOhZCIH3l9Ba
         LWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmDdnsiqYQ5dSYncDjsXtCDMJrfj6efGFHqiNmz/bqk=;
        b=pHUm9kIKJa3R36CJtAIvYmpxSPX1rDzsl3Csx4YpcheiMxREPw6KzYEo5U0Rj74J51
         QJ89K1MwN5+t3dTRpt4GRSQUqGXummeb9zCm06XvJj8HNB/F5im4o8cVzjtW2pz/4NUY
         dEK+ErkkH2QKuDv/rOQVdTKBi8AjdQq9ed9pEyVTFPaO2MxgVd1AuJlAB34bsImUmzVP
         3oMbqJawUrV9ZN9bvsXJGsp21YzXaWZ5Ko3EeKcPdvOlh4OqGnQVp89zghfXmHJHuX/i
         pT7Pan56Dr+u3iLw90zAT8wEc8Bh/AMZWvQkbInMzFA8vuHeyMOy8l9oRwRhuLXkrYFJ
         JJrQ==
X-Gm-Message-State: ACrzQf1QPJizfuxT97qSaWCcsBR0XhfbWxnoSKy3UTOyQbn1DWIhNtMN
        00O4prYDkl6NXocWr7dB+zy9I+/PTvXF6oKyI0YlVw==
X-Google-Smtp-Source: AMsMyM7QDy0sVIicail7ccfx7jBBX30zxxyjoMCIqaGS22F9z1Ed8Q/ttEpjxfDsjRjlz3ljKRtR5VVnCYxnW/GZ25Y=
X-Received: by 2002:a17:907:25c7:b0:77b:c193:9230 with SMTP id
 ae7-20020a17090725c700b0077bc1939230mr36243331ejc.316.1667607177998; Fri, 04
 Nov 2022 17:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221103205010.3266865-1-joe@isovalent.com> <101ab00c-5fa7-c3ee-63bd-f235e7c4d398@gmail.com>
 <CADa=RyxodgJ+Wa3tiWxTntZoy7eSm_UkuzDBx9tCN=s_QnsDOw@mail.gmail.com> <87fseyqpso.fsf@meer.lwn.net>
In-Reply-To: <87fseyqpso.fsf@meer.lwn.net>
From:   Joe Stringer <joe@isovalent.com>
Date:   Fri, 4 Nov 2022 17:12:42 -0700
Message-ID: <CADa=RyweVGfq_qj6V+WLRhitEq2uNhj=YHQBqgmRpkjrhdMA6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: Add LRU internals description and graph
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 4:10 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Joe Stringer <joe@isovalent.com> writes:
>
> > Resending, this time without HTML.
> >
> > On Fri, Nov 4, 2022 at 2:31 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >>
> >> Shouldn't the table be written in reST table syntax instead?
> >
> > This table follows the syntax outlined in
> > https://docs.kernel.org/doc-guide/sphinx.html#list-tables . Is that
> > document not up to date?
>
> That document, right where you linked, says:
>
>         The list-table formats can be useful for tables that are not
>         easily laid out in the usual Sphinx ASCII-art formats. These
>         formats are nearly impossible for readers of the plain-text
>         documents to understand, though, and should be avoided in the
>         absence of a strong justification for their use.
>
> The list-table formats exist for a reason, and sometimes they can't
> really be avoided, but they do impose a heavy readability cost on the
> plain-text files.

Ah yikes, I just searched down for an example of how to sketch up a
table and followed the first example I saw. I guess this is more the
syntax you'd expect?

https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#tables

> > I'm happy to do this, but several of the diagram boxes will reference
> > terms like rotation, shrinking etc without explaining what they are. I
> > think it's a net negative to readability if this text is not included
> > with the diagram. If you think the commit formatting is a bit over the
> > top, I could maybe just remove the decoration and embed the content
> > directly in the doc? On my first attempt at sketching this up, it just
> > felt a bit weird for me to submit that text directly if Martin was the
> > author of the text. But I could figure something out for that if
> > that's the preferred approach.
>
> I don't quite understand this comment; I don't think anybody is asking
> you to take information out?  Just to use one of the other table formats
> if you can.

Sorry, I switched to a new email address and inadvertently enabled
HTML formatting, so my initial posting ended up rejected and my
re-post snipped the important part. This response was intended as a
response to the question around the formatting of the commit message
content:

> What about just writing the pointer ("See commit 3a08c2fd7634 ("bpf: LRU List")")
instead?

My thoughts were that the commit message describes the high level +
algorithm pretty well and that text compliments the diagram quite
well. But if there's some preferred processing I should perform on the
text to format it well in the docs, I can do that.

Cheers,
Joe
