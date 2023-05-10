Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EA36FE560
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjEJUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbjEJUsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:48:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34FE49
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:48:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so5181109f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683751715; x=1686343715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n43MwqLS4K8T9pwUq7KF8hTU9/BSLcrxuagPObgT5dc=;
        b=Zpaqr/tx2vr019x7yN8DEGaVe53Uguq6ThlFfv3VAugkJZF+DKBWNwCUBgXBztsMWb
         9Tdx/1DbfpV4H8yoeYBXiTIKjuXtna/GOtzRcemwuuib3SYkyXeYYXZn48Bu5zMRUcK6
         YCukDQs4FCtOiScJExmHWsDWxzMMfsEM0Egqgtbzqa8PU9BiAlTVSe1xh+3bNOswNCeW
         yM3w44bvNPMYadf+qHXakuvMwM8o0txNdh+zOayTPTQcJB9fSWLkjcVWMoFm6vVBRjQM
         BQqJl1yZVWAkm/pLwerdMRH3ES7pRz34DOCoHh1YvjdEoVrLBPTn/PwXWSZkQsAzHP1q
         lgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751715; x=1686343715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n43MwqLS4K8T9pwUq7KF8hTU9/BSLcrxuagPObgT5dc=;
        b=HbeQk4+sRPW0G8Ryy0sQOd7OCPQSmzdY3eAsJpWMxm92GbqX074SUVmYRwt/Nzoa8V
         3IspsKDJrjepVMwgmag1C1pABw1/Be86nSP5mn9QfHCIf3dDyZJJWeHr0Qx90rF+PPNW
         /SDSjYv+bVobERkSLSxuQW6WyBex7TED0ppAl05sJTzOmeGKqTNqKtnm/3BKNcEnlMtq
         /qZg5ibG2nulu0LRwSrH5ZTXIwB3hkwOB15MX/ba7MZMS5LU5/ycUUXsxaGoLW+e6Yl8
         hCe8jDz9TWhNEFJHiMpwday2UhVNed8If7jREavUYzfqT1IK/kc0hqk6iwCfVy8MrZO2
         LCEQ==
X-Gm-Message-State: AC+VfDych44R2JvOW/7Db1udpOSBS/do0JEZQYc0rjF8DkOrDvBje7Fj
        /EI9L2MXwGqGSjr9p9HuKIZ7wdvHkMEIuRG1QbM=
X-Google-Smtp-Source: ACHHUZ6CRx6Wu/qo+p9j4JXZ3exYYnSNhA4Py1yqyalSBYL9a5fs8/gIegXSo3KRHlvl/X7X6wYOu0Dl2ja+mNZhAz4=
X-Received: by 2002:a5d:4004:0:b0:2c5:3cd2:b8e with SMTP id
 n4-20020a5d4004000000b002c53cd20b8emr13087692wrp.1.1683751714462; Wed, 10 May
 2023 13:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230509223036.3007500-1-azeemshaikh38@gmail.com> <CAHk-=wg7pwWiF4eWVTfFYkfAk_5YDHkmkgZ04cgXkNUO_9pR3A@mail.gmail.com>
In-Reply-To: <CAHk-=wg7pwWiF4eWVTfFYkfAk_5YDHkmkgZ04cgXkNUO_9pR3A@mail.gmail.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 10 May 2023 16:48:23 -0400
Message-ID: <CADmuW3VngW3ineOjUNLYQT1UXsW-s46HjLKx0H3JyexKMtUhQA@mail.gmail.com>
Subject: Re: kernfs: Prefer strscpy over strlcpy calls
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, security@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Absolutely not.
>
> This makes the whole exercise pointless.
>
> The reason to use strscpy() is to *avoid* doing the strlen() on the
> source, and limit things to the limited size.
>
> If you need to do the strlen(), then use strlcpy(). It's a broken
> interface, but creating this kind of horror wrapper that does the same
> thing as strlcpy() is worse than just using the regular version.
>
> So the strscpy() conversion should *only* be done if the caller
> doesn't care about the difference in return values (or done *together*
> with changing the caller to use the nicer strscpy() return value).
>
> It's also worth noting that 'strscpy()' not only returns a negative
> error value when the string doesn't fit - it will also possibly do the
> copy one word at a time, and may write extra zeroes at the end of the
> destination (all within the given size, of course).
>
> So strscpy() is _different_ from strlcpy(), and the conversion should
> not be done unless those differences are ok.

Thanks Linus, that helps clarify a lot. I traced the usage of these
functions across the kernel and plan to do direct replacement only
where it's safe (see thread here:
https://lore.kernel.org/all/CADmuW3XiYpGK7BessXJWjGnnxZti_3mawDSX7QPawsfmATxCng@mail.gmail.com/).
Let me know if that works for you.
