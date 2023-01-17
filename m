Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E19866E644
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjAQSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjAQShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:37:54 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCFE302BD;
        Tue, 17 Jan 2023 10:08:38 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id jr10so20585443qtb.7;
        Tue, 17 Jan 2023 10:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mNtUwk8pZ+4ME/1vifRLekNO13Wg5Zu56Lt21b5zZ/E=;
        b=NUkTrZoP7W+dbV5M8TQ8QZ6EJ7AeGCEJe1YDCK4M3eOtriQU0VMF0jrTQfZKZ04nX3
         tObhhl6SQ2s5vYRuVz0gifyjTCXvFFqjWl+foeDKQjIJ1LSYJjYBhUE1xbKZtrcLqo2Z
         WLSR545diQKAiZhOEwCRqYEnywadjsPloZrSJW1WjO9wH7ptol5kfIBGQT2J6Z+oPcUq
         e5bKJNMfyBEPGKCPfLlc5LXIRFHEPjarEbVgrNua0YSVPStVGuCH2Ws6+4vRqOqHIOeR
         oKWk5W/o7VnUE7D8rQpa5OwRaV6ErauCSQr0Tq2X2N6redlnD2o1Cs9bxxQz1s0511XO
         CYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNtUwk8pZ+4ME/1vifRLekNO13Wg5Zu56Lt21b5zZ/E=;
        b=ZgPhYhv5ojWf06JPhu+SzYaYXr1rEa7yVPVCPuxf6wwbJ7T6YANfkmk1tCwIaWAsqd
         0RrkWIkuFkwdoxUnukAUCO4n29fKxF+Tf9IMOgyTgkL0w6OfJEGWU1j3pU9H1kOkPf/X
         jwS0OBPYVFQfdeDSjiQzrlIYaTiepiKhGC8hb8jIXMDme4sttpWVuJO5/G4pIWSx8SlX
         alnYjSY7AyXqrPaHaSpECAYcKUz+0/F5VxmO/EJ1MYB+oaIkoTSqevRveq52BwuVokmB
         VtFbVmV4YHJK1BWESh8gHvzFvnvKJ/ieVybLUCS3sO83QUqVl95dxkqWRHerNHDV0Cpk
         i7JQ==
X-Gm-Message-State: AFqh2kr0NEAefj1jd6dwJTo0Or9YQNulbkfRXc0aUjvFeddP2hPiDBho
        6/mTQ3lDDVFzjvx4a79+wF9VR5EFdyByTkTdBcM=
X-Google-Smtp-Source: AMrXdXvNpef78aF7A4F+6Aj+fH25NTbcazp1VYsDIP18+HyLQeo70AF3aJANwdtMB6J/E6tCNsz6V29gc0SCtxWin7k=
X-Received: by 2002:a05:622a:5c8c:b0:3b6:30c5:6d26 with SMTP id
 ge12-20020a05622a5c8c00b003b630c56d26mr188562qtb.429.1673978917903; Tue, 17
 Jan 2023 10:08:37 -0800 (PST)
MIME-Version: 1.0
References: <Y8bARLuFubMVILIN@smile.fi.intel.com> <20230117161659.31232-1-bpappas@pappasbrent.com>
In-Reply-To: <20230117161659.31232-1-bpappas@pappasbrent.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Jan 2023 20:08:01 +0200
Message-ID: <CAHp75VcxaSXeMNmkPoMnA+zjp+JWmHp5aE+2yPhXaqxMC6QWEQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: atomisp: pci: Replace bytes macros with functions
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     andy@kernel.org, ailus@linux.intel.com, error27@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 6:17 PM Brent Pappas <bpappas@pappasbrent.com> wrote:
>
> Thank you for the advice Andy.
> I took a look in overflow.h and found the size_mul function, I assume this
> is what I should be using to prevent accidental overflow.
> I also removed the inline keyword from the function definitions because
> Dan (error27@gmail.com) recommended that I do so in reply to an earlier
> patch I submitted.

Now you need to properly form a commit message. What you have done
above is good for the comment (goes near to changelog).

...

> +static size_t fpntbl_bytes(const struct ia_css_binary *binary)
> +{
> +       return size_mul(sizeof(char),
> +                       size_mul(binary->in_frame_info.res.height,
> +                                binary->in_frame_info.padded_width));

I recommend using array_size() and array3_size() rather than open coding them.

> +}

...

> +       return size_mul(sizeof(unsigned short),

> +                               size_mul(binary->sctbl_height,
> +                                        size_mul(binary->sctbl_aligned_width_per_color,
> +                                                 IA_CSS_SC_NUM_COLORS)));

array3_size()

and so on.

-- 
With Best Regards,
Andy Shevchenko
