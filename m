Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B2A643D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 07:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiLFGXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 01:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiLFGXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 01:23:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CE6275D7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:23:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a9so12996177pld.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GleLPoHu7UPOxwuHN42Ezfxj9Y7BgZ7LiWPwDVkLnAQ=;
        b=PYKPZBYgOZgiS9Y5pK+8SC/LMyQcEjdUbP7TGLkCQfa85csvX8kYwJpFomBXue3FjU
         cHQJPqh+B6UXBJjrakzLgDBjYIdwgOx3ub9wRFOs0KxmR+2tt5nqmYfsMJn2buWmaX9s
         PJLQQasyVhVdLvQ/5iUpJ5+ZEY4UdppBHI4vvGZJ1GqQMqeWm0OkqBf0tq6PclmC7+XF
         e0wZ1zw3R1+TaNU/kEzr/IZaMeQgI6rPmfW7IFP1AplxR6kyIdTZVIEIM3xPsbqpeWgF
         cYpZUIYcna++SC0/p4glWGB/2WIAKErvHFWQ5+lMeUJajoVQmYur/7VOafq4DVqjJgE+
         z+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GleLPoHu7UPOxwuHN42Ezfxj9Y7BgZ7LiWPwDVkLnAQ=;
        b=J2hAo5i8/8DAU+GDeTVDzJiZ+G7+38H/jf/fOxQz3MPbKGHorMiN78Lq/ct0MR7P8K
         5kR3e55bvZw4zg3yS7dkKEH+TsM1Nj2upD6GvfBB+e0N1xdhjuwVNGIYD2KQ5CytOvLo
         UqEYzu20n9atkeXCL7nRVrgZl4c9m16fH9gfldQQaqL5sl1VCs/ljB+LwuhAz5KfWjF3
         9ySFJW0QSjac99wX+22H019CA80nwSigGvMN4K5ShK18B8am7k+WlrvQTJ6b6FpdDJKC
         sdqi7H2k9elxhZN3clCwLQQOoDO1dOKxFTSElqDp4urNC45EubpIRXgw+QcqOdWgp8N1
         eKow==
X-Gm-Message-State: ANoB5pnAKWxrS7g7MAyB1INc/v2hVPc6sGa5tuq6oSQSAXvqi09pTX3T
        KQGsTyudfYcrT97TKLRaU9z01SxZmSm/79H8qrU=
X-Google-Smtp-Source: AA0mqf7UHhYkTfGgAwF4U5uexpOzLAGNZlh3eS6HPyC2dXQDONOxwI8LAKvS65t+7yH0d9l+zgqSfDfHbjyIYz0IN1U=
X-Received: by 2002:a17:903:3052:b0:189:651c:f023 with SMTP id
 u18-20020a170903305200b00189651cf023mr53229711pla.78.1670307831551; Mon, 05
 Dec 2022 22:23:51 -0800 (PST)
MIME-Version: 1.0
References: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
 <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com> <CAJNi4rOs-=xx5qV-hQQYgSLQCz_q3JuFxJEd+wpPaao8Ej26yQ@mail.gmail.com>
In-Reply-To: <CAJNi4rOs-=xx5qV-hQQYgSLQCz_q3JuFxJEd+wpPaao8Ej26yQ@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 6 Dec 2022 14:23:39 +0800
Message-ID: <CAJhGHyAVbCm6i7pTRDDXgdwS25d5O3uMCvKzyOcafRAdN-S7JQ@mail.gmail.com>
Subject: Re: work item still be scheduled to execute after destroy_workqueue?
To:     richard clark <richard.xnu.clark@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 6, 2022 at 12:35 PM richard clark
<richard.xnu.clark@gmail.com> wrote:

> >
> A WARN is definitely reasonable and has its benefits. Can I try to
> submit the patch and you're nice to review as maintainer?
>
> Thanks,
> Richard
> >

Sure, go ahead.

What's in my mind is that the following code is wrapped in a new function:

        mutex_lock(&wq->mutex);
        if (!wq->nr_drainers++)
                wq->flags |= __WQ_DRAINING;
        mutex_unlock(&wq->mutex);


and the new function replaces the open code drain_workqueue() and
is also called in destroy_workqueue() (before calling drain_workqueue()).


__WQ_DRAINING will cause the needed WARN on illegally queuing items on
destroyed workqueue.

Thanks
Lai
