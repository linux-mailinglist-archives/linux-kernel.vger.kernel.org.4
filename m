Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB86D6AB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjDDRgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbjDDRgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:36:04 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852724216
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:35:38 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h3so5634811qtu.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680629736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R19pDDlxEBqwP4WCwxhzBg+mcLiYnMRVxRJpokPqHX4=;
        b=bUUDxGt4LptYFJ32xj1qDLwvla/b4T89Nyh/qXyxss01mkOHxqUPLYtggziGR9z5Q6
         rJsXskKlBIMEKAHdzj2dmQksxr7d2TO2h+CzeogS0ZwMrAQyNJQTF7RT1FoZX+KP0TOQ
         uzKO5NKOnFcc+uVbVv/maP6fZCujH372RBHTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680629736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R19pDDlxEBqwP4WCwxhzBg+mcLiYnMRVxRJpokPqHX4=;
        b=2wDMcA8TxyiaQb5au6KNuNjVeiEyWeB3Im6nMmK2wM92CpMUnYxl11CwLJfLAvQDtI
         yh/FbaJxI63Q68FdZUiijc7KcbBOGUxvFDESiwP6mm061bC2BdYCzJzxfTiiK+TIllGs
         Bmgqb3COCbBekg55LmLtCF5TWn9zTiBKKmtnU/SqeSRtXecwvtRmzUf3wKaO7G3f7Y+u
         RlVkKJi0nbYi4104HJSmBdHwZEN6hyip52ikKxvhwoqGAG8Ia15ULxTzKbjwx/u+6QWJ
         xmkFAy65jN/wrv/wQoLx1oIctINs7iZI1QRT4B1V3a92iIGQbQpS0si3tyzXpowvNu7B
         IjnQ==
X-Gm-Message-State: AAQBX9fZnkmgS1c2YaohkCTNLxiI/owWzE8FYGX1Zz60Gh6Kx4tpDa7N
        Xn2fS7TSpUxtCB72q3zG1LizqxAXNa90uyROukg=
X-Google-Smtp-Source: AKy350ajeyotBg9jvJBOVc1c8jIKI7pCvJuNqMmFFCwaJbU2MxjtKJDIHg1k8WCl321CX9d1PRQx/A==
X-Received: by 2002:a05:622a:110f:b0:3bd:1a4f:96b5 with SMTP id e15-20020a05622a110f00b003bd1a4f96b5mr307410qty.47.1680629736272;
        Tue, 04 Apr 2023 10:35:36 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-7.dsl.bell.ca. [209.226.106.7])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e011000000b00746b2ca65edsm3702859qkk.75.2023.04.04.10.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:35:35 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:35:34 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     workflows@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Introducing bugbot
Message-ID: <20230404-uncrown-detonate-8bc1ac@meerkat>
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
 <022e2ef8-2a94-3109-ab90-9ee980915887@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <022e2ef8-2a94-3109-ab90-9ee980915887@gmx.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 04:16:08PM +0000, Artem S. Tashkinov wrote:
> I love everything about what you've done except I've got a minor feature
> request for the kernel bugzilla and this new workflow specifically.

Great to hear.

> Let's have a bot which polls open bug reports every 3-6 months with this
> question:
> 
> "Is this still an issue in the current kernel? Please leave a comment or
> this bug report will be closed due to inactivity".

I plan to do it slightly differently -- there will be a "housekeeping" command
running daily that will auto-close bugs that haven't seen any activity for a
defined period (90 days, for example), with a message like:

"This bug is now closed due to inactivity. Please reopen if this issue is
still relevant with the latest kernel version."

> By doing this we could make the bugzilla a whole more relevant and effective
> tool instead of having a ton of bug reports no one cares about or can even
> confirm.
> 
> I would only exclude the bug reports of type "Enhancement".

I wouldn't, because these aren't bugs and shouldn't be filed in bugzilla. I
would just advise the person who opened the bug where they should send an
email with their ideas and then close with "RESOLVED/MOVED".

-K
