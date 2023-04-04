Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956056D590C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjDDG6C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjDDG55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:57:57 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FC1268C;
        Mon,  3 Apr 2023 23:57:56 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id k17so37480901ybm.11;
        Mon, 03 Apr 2023 23:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680591475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMUOBSmsf+P2tOaipYQIbA2HBuBLhKgLLhCNUMVXeeQ=;
        b=EnFFn2G+3rlM+ZQHgSj3Zxqkiup86CYReZYWZdS/D6P6TN965SdsPL3pdSL8S3BlVU
         VtEnzqA1VaFZmIkRNfx0QeHsNM32EzI/T6yuqaFgIGuuAqoPIgjpcbMF7MMIP5UlU7J5
         I80cfDeSy4YCKLd1fW6FIIZRGA3mZyAMC/Jqc+yKTLM/xzIVlJMjHlyCd/9IwrHqdlD1
         Mx7A8EcngwXJ8PFNBcas0nUJfnYMDmumeXCDeF/gvsgCDDVCpzmvm/HEgW0bXCniLy3K
         RLUafcAABqeUvt335YGbPYunOnBpYJnSzeR0+SFYYfoTPesC+YNAXyP+vWooK2rUUGJp
         cFHA==
X-Gm-Message-State: AAQBX9eza2GAXNgni5bZ1cW1GPxb2Bw7Q0aQQ/5XksF5bjbFfTt7NQOo
        61wh1ETQZSoDVjru2gdWHD9lUaocFgZOSBmL
X-Google-Smtp-Source: AKy350bzNroqoM6p6OIScBnJ+x5iQHbmndWuVdR3KKamku3Hlc+g7fGOiBH+SW8BykY7B/j2dgGQKw==
X-Received: by 2002:a25:2641:0:b0:b72:e991:e29d with SMTP id m62-20020a252641000000b00b72e991e29dmr2284689ybm.15.1680591475469;
        Mon, 03 Apr 2023 23:57:55 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id b34-20020a25aea2000000b00b8692cfdfa6sm1783992ybj.27.2023.04.03.23.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 23:57:55 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id i6so37532389ybu.8;
        Mon, 03 Apr 2023 23:57:55 -0700 (PDT)
X-Received: by 2002:a25:ca4b:0:b0:b77:d2db:5f8f with SMTP id
 a72-20020a25ca4b000000b00b77d2db5f8fmr1190961ybg.12.1680591474911; Mon, 03
 Apr 2023 23:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q> <b38de7ff-3de1-cd4a-a532-66642aea587c@leemhuis.info>
In-Reply-To: <b38de7ff-3de1-cd4a-a532-66642aea587c@leemhuis.info>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Apr 2023 08:57:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX6OOHXCB9pw-iO+ajHVP6eJwzK8mUTE5N4AKRXdNj66w@mail.gmail.com>
Message-ID: <CAMuHMdX6OOHXCB9pw-iO+ajHVP6eJwzK8mUTE5N4AKRXdNj66w@mail.gmail.com>
Subject: Re: Introducing bugbot
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tools@linux.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 8:03 AM Thorsten Leemhuis <linux@leemhuis.info> wrote:
> On 03.04.23 23:45, Konstantin Ryabitsev wrote:
> > Per our discussion last fall, I've been working on a bridge between bugzilla
> > and public-inbox, which went live in the past few days. It's still a very
> > early release, but it can do the following:
>
> thx for working on this.

Thx indeed, looks nice!

> >    New bugs will be created in the Linux/Kernel component of Bugzilla, but
> >    they can then be reassigned to any other component. As long as they remain
> >    open, bugbot will continue tracking threads for new messages until either
> >    the bug is closed, or it has been over 30 days since any activity on the
> >    bug.
>
> 30 days from my experience sounds too short for me (but I have no hard
> numbers to back this up). I would have gone for 90 days, but I guess
> that would create too much load?

30 < release cycle (9..10 weeks) < 90, so 90 days sounds better to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
