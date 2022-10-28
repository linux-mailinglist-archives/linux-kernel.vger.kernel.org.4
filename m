Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234C8610DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJ1Jyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiJ1JyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:54:24 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D841CCCEB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:53:33 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id z189so4000915vsb.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3cbP73NK3VqxMbuuPW7YHSHMiG90mZgEraKKVLg1W4c=;
        b=hkZK/MvkgdqjSO1l/UvJwJHNWSjUVI1cqm3jSwcg+iL8GvLt9/dVmMlh2mMmu8ouiZ
         qe403rhZBw3rwWZlCYphvoBCiE8oo3vJRLblnrnYQa24RtdCh1ajXiJcnmB6Kb2zX8Ht
         mRivBH25tITvo7Ls7SbnPeeryRKXc1Ds19usIcsI66OrO6j6zVBHAexAUDMbE4Mrd5wA
         PEYpx0xJPFGyLie5W5keu8a4FSh6pgvkroclg4LPbf1To4J+wCEh8x5DDck80BIWVO9y
         oVa0JV0YLgHY/ms7yEvmI8msdQY6N79+NVnQKQ1E835J4/3AiH3AXUwQpU2EBnkGyqQr
         srBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cbP73NK3VqxMbuuPW7YHSHMiG90mZgEraKKVLg1W4c=;
        b=qbLs33t6g18pPDj055Ja8gxH1YONeiia1Y4ueaNPbshvKqGDMj+rxf3OOtr4fvVSNQ
         HrRmWUPT+DRnI/sUEsevRftCdgLH7woFte713QMi25GgZInxwCxatFRrKWSHBNlBjAD+
         /Rmp3/LQsSQ3Fb7BMYhbSCYClW9BFqPXvAUM35+evrxP593aYoTfmiZXodfECMjwp8Iu
         L2ENRZbIVvrxZXjyuIwgQv8T79CKHAftzxlY7FH7OA3Sb9lZVuN7dmaBpgwVwx6BazVd
         uoPCLBWc007aAhPEuaBpIvZiwRgEBpiYgwMrizYx8OKJaEwSzCOtucNIr91utDCes7YM
         +EzQ==
X-Gm-Message-State: ACrzQf2OReThUmWcOHM/gQVWhRG/8/ZMCvrpjxYOgb+7N2dLZ/+SVr3l
        vFM3nFuUz1kbyrFqyck7CuX9jMwNwjNqh4HP5m5F53GDHZiSIw==
X-Google-Smtp-Source: AMsMyM4zJeL9wC1IjMA4Kc8Vd1g0zVAHzSJnFvf9uEZj1hfwKUDFgG02bFCAExx8LhkqLJRtvr6RFiFJKnYd68uORH8=
X-Received: by 2002:a67:c205:0:b0:3aa:1613:71fe with SMTP id
 i5-20020a67c205000000b003aa161371femr14680863vsj.57.1666950812704; Fri, 28
 Oct 2022 02:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221028051420.GA30073@rdm> <Y1tx8XjmR5QKV9lQ@kroah.com>
 <CAMk1CBOdgwnt3E7ByZMASv+O1WAmgKvsvMv5Gy9UNgg=kMBRJQ@mail.gmail.com> <Y1t2jffoLPxdOqJ3@kroah.com>
In-Reply-To: <Y1t2jffoLPxdOqJ3@kroah.com>
From:   jovial umwari <umwarijovial@gmail.com>
Date:   Fri, 28 Oct 2022 12:53:20 +0300
Message-ID: <CAMk1CBNe6RLybU3cFmp89iR4KrRoiMfGbsBO49WfOco3bDd5RA@mail.gmail.com>
Subject: Re: [PATCH] WARNING: Possible repeated word: 'very'
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the corrections
i am very sorry   for All these mistakes
i did not know

Best regards
Umwari Jovial

On Fri, 28 Oct 2022 at 09:27, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Fri, Oct 28, 2022 at 09:13:14AM +0300, jovial umwari wrote:
> > Thank you
> > working on it now
> >
> > Best Regards
> > Umwari Jovial
>
> As you spell your name this way in emails, please use the same format
> for your signed-off-by lines in your patches.
>
> thanks,
>
> greg k-h
