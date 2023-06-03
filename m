Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83E17213BF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 00:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjFCWzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 18:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFCWzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 18:55:11 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA45EF5;
        Sat,  3 Jun 2023 15:55:09 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-558b83a10b4so18374eaf.3;
        Sat, 03 Jun 2023 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685832909; x=1688424909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fuI6ZWZON+QgF+3I1az7d+efKHI5gI9Pw7Cr22g+4pc=;
        b=IhJGdVN3thgIPQMm49cDnlUnz9RkRyxcSaHKEkBdyutj53vcojSN+xD+kBcW/DdPc+
         VJQd/XjyXYT1KAfv5peQsuYZLSVeO4X2LI3o1YxB1BsWQX5ZPgyPTwIdNzzF+H8O2IHd
         B/0K9J3PBC1+L8XMDZXvqbOxBsF0FuYCoMdVs4f0OmpfyGA1FX0d/DduFniP6obAX9f7
         xeS/QTpu6zHzudVUaaUDbQx+J7OYvnUhs6tEvS4DRWyIrEKE7kTzWUqh8n3ZJqTlDrDv
         QqO9HJu7EXVIYIyJvQzWW9NaT+NxSaS59SeWM8p5OBxSxXvnl/rj7pDfJz4oE14RPMWf
         3W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685832909; x=1688424909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuI6ZWZON+QgF+3I1az7d+efKHI5gI9Pw7Cr22g+4pc=;
        b=JAM3cFv5BoxvEqgBYaLzkrt8hnbZCJ3Geum9KVYpdgfqA6L+k/sfvzrySm54syCxJ5
         TMpAUQb0EvhoYqcHcAWED3TFdur+wxlbZRZ7LughLBZ9WFYUfYZVHy8fkUBprB6G62lg
         p2ufzPlrXUjzee9ZM0+g/lJSCdRsk2mwOyTnYG0QaPKM280+EfqLVnXyLg7YFkaC3H3E
         GLtdXAn5HEYo++FcGwYLB+C07B7/2qX6iS2BKUFY7YcYWbA+xuSLiCoPE6h9t9lflVN7
         B6O7+w2fvbRaH/Mq6mA2tNNdWGyl26wF7EluTZdtKczflULR+6Dz5k+Rozw4pXvlSJ2k
         /Pew==
X-Gm-Message-State: AC+VfDwt+RXj88IDUVJTcukpbMibnRAuXGYprsHny5sjOE15Vfdn64cS
        dcpdpznUksAcaX4rz2PGu8U=
X-Google-Smtp-Source: ACHHUZ7tdwUaMHoS9+/NOk0hyav/ia+k72OEafdZ4KjYv7PNgzWfs8+mRrp9R9hrHmqCWQXYF/z+6w==
X-Received: by 2002:a4a:b90c:0:b0:558:b386:7a78 with SMTP id x12-20020a4ab90c000000b00558b3867a78mr553849ooo.5.1685832908929;
        Sat, 03 Jun 2023 15:55:08 -0700 (PDT)
Received: from madhu-kernel (99-145-207-128.lightspeed.austtx.sbcglobal.net. [99.145.207.128])
        by smtp.gmail.com with ESMTPSA id m4-20020a4aedc4000000b0055554a51353sm1825709ooh.1.2023.06.03.15.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 15:55:08 -0700 (PDT)
Date:   Sat, 3 Jun 2023 17:55:06 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     rdunlap@infradead.org, bagasdotme@gmail.com,
        ivan.orlov0322@gmail.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        skhan@linuxfoundation.org, Akira Yokosawa <akiyks@gmail.com>
Cc:     madhumithabiw@gmail.com
Subject: Re: Fwd: [PATCH] docs: Fix warning:Error in "code-block" directive
Message-ID: <20230603225506.GA306244@madhu-kernel>
References: <e69410c1-8632-354e-e6e0-ac16631f0566@infradead.org>
 <bf0dee59-20ce-27d6-5b6a-683525fc012e@gmail.com>
 <CAPNSgDiZiv6VJcX66DaQjHkLjd3ZxhkBcXzo7UU5LUD2hCx9Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNSgDiZiv6VJcX66DaQjHkLjd3ZxhkBcXzo7UU5LUD2hCx9Sw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 01:52:46PM -0500, Madhumitha Prabakaran wrote:
> Date: Sat, 3 Jun 2023 13:52:46 -0500
> From: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> To: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> Subject: Fwd: [PATCH] docs: Fix warning:Error in "code-block" directive
> 
> ---------- Forwarded message ---------
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Fri, 2 Jun 2023 at 23:04
> Subject: Re: [PATCH] docs: Fix warning:Error in "code-block" directive
> To: <rdunlap@infradead.org>
> Cc: <bagasdotme@gmail.com>, <ivan.orlov0322@gmail.com>, <lenb@kernel.org>, <
> linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>, <
> linux-kernel@vger.kernel.org>, <madhumithabiw@gmail.com>, <rafael@kernel.org>,
> <skhan@linuxfoundation.org>, Akira Yokosawa <akiyks@gmail.com>
> 
> 
> On Fri, 2 Jun 2023 18:41:46 -0700, Randy Dunlap wrote:
> > On 6/2/23 18:20, Bagas Sanjaya wrote:
> >> On Fri, Jun 02, 2023 at 04:51:02PM -0500, Madhumitha Prabakaran wrote:
> >>> Fix the error in "code-block" directive by providing the
> >>> argument as "text".
> >>>
> >>> <snipped> ...
> >>>  Result code:
> >>>  ------------
> >>>
> >>> -.. code-block::
> >>> +.. code-block:: text
> >>
> >> Nope.
> >>
> >> I don't see error you mention in this patch when making htmldocs on my
> >> computer (my setup is pretty standard: see
> >> Documentation/doc-guide/sphinx.rst). This patch is unneccessary, though,

I did executed "make htmldocs" on sphinx-build 1.8.5 and sphinx_2.4.4, which throws the warning but on executing the same on sphinx_7.1.0 - one 
can't see the warning

I skip the patch.

Thanks

> >> unless you have code snippets in some language (e.g. C, where passing
> >> language name to code-block:: syntax-highlight it). Result code outputs,
> >> on the other hand, are generic text with no definitive syntax, hence
> >> you can omit language name.
> >>
> >> Thanks.
> >
> >
> > I also don't see any such warnings so I don't see a need for this patch.
> > My wild guess is that some older version of Sphinx was being used.
> 

Yeah, your are right. 
On executing the make htmldocs, it clearly throws the warning
"WARNING: support for Sphinx < 2.4 will be removed soon"

My ignorance.

Thanks for pointing it.

> Right.
> 
> In Sphinx changelog, "Features added" for 2.0.0b1 [1] lists this:
> 
>     #1851: Allow to omit an argument for code-block directive. If omitted,
>     it follows highlight or highlight_language
> 
> [1]: https://www.sphinx-doc.org/en/master/changes.html#id1306
>

Thanks for the changelog reference and reasoning. 

Madhumitha
> Pre-2.0 Sphinx is now deprecated.
> See commit 31abfdda6527 ("docs: Deprecate use of Sphinx < 2.4.x").
> 
>         Thanks, Akira
> 
> >
> > --
> > ~Randy
