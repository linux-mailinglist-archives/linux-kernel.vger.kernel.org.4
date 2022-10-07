Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC75F7B52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJGQVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJGQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:21:36 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20A51162CB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:21:35 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 4so3996042iou.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bmvBkuHcwOAXYoDYmfwBtMyxuQtvpiJLtyYh5tQ/s5A=;
        b=j3Ov9hf8lMZiqWbzV4XN11vbQf8L2DUqgerztLf0RBS82hPuwJxr11/FXnmKYnVJg+
         XdOc8zDYo2KgSkKIIJwTTwAjc2F6jsmZQuC7hD2eJUPiJOPKdHzK9PBR+YagyKjivcLi
         5YUALaLvaibb3xin4mAf2VVpVcA0PvyGDzDoYLJ4lqfR+m50rQHvC8cg5eey3QfAIt8N
         M0anoEZYTfVSeWNzTBnpm2vOzbkEJE0aZ+KwV8Y1dkP0JjmCtnLbVcq+/LlDFEZKPGa5
         GCNZVSKVZX6UUqsHdJ3rVGoNSEBfBY+beSfGqJAHi8JhPeizHic1v93iM5J/lP187wTg
         6khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmvBkuHcwOAXYoDYmfwBtMyxuQtvpiJLtyYh5tQ/s5A=;
        b=kMGGiux/iTBc05WgLLIWpJGKb+FUmNmyu/VlGEWqgTSywXgavKHG3w58+vc+xfVYHI
         I7MqvqISZmz/4pN8I7ZhXpHN+EI0TDXlGpHQSw9Shk6WhFt7S76YRlEPjBH6vWPJ9nG7
         sqqC1Ja1DwkdK0aDc5X7AqbwBQkHraMxFuQz9BkM/5XcJmNzX+TLIhz3pINpzLll/4S2
         P4/ei88pGCSh9TJznxVjRYTtlWKEYRlVrDr7uudCCwY+itnJBV01tn2fT2bxY5sOQixN
         o3NUQ/5SP10o/OFX0ecs83Ms7Os7fgM0ZK0zIQFhHxgjew0NY2jqMvnQ6wT1KfHsmCxA
         2bNw==
X-Gm-Message-State: ACrzQf2hLafHjHOOzuys+t4rU2kWwNfv3yjq95XlUF5KXHfTdnWD2SEN
        5buivRfLeyUS3svMy5Oh/3hxaZiv91OgqH9nlWVm1g==
X-Google-Smtp-Source: AMsMyM7Z5/swTMRWL54BzQhIdeTL/VVlQj0Bmo4V5OqZpj7UGY7SOG/JhQD3mrfkLE5DpNIhC/DPwP3gu+umKgxjkwI=
X-Received: by 2002:a05:6638:40a3:b0:35a:3f2d:a21c with SMTP id
 m35-20020a05663840a300b0035a3f2da21cmr2918176jam.221.1665159694742; Fri, 07
 Oct 2022 09:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-7-gpiccoli@igalia.com>
 <202210061616.9C5054674A@keescook>
In-Reply-To: <202210061616.9C5054674A@keescook>
From:   Colin Cross <ccross@android.com>
Date:   Fri, 7 Oct 2022 09:21:23 -0700
Message-ID: <CAMbhsRS0iy5KRiEiheDccKGqm2rJhkV_NQUw7kSdOK4j4k-ELQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore infrastructure
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, anton@enomsg.org,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 4:22 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 06, 2022 at 07:42:10PM -0300, Guilherme G. Piccoli wrote:
> > Currently, this entry contains only the maintainers name. Add hereby
>
> This likely need a general refresh, too.
>
> Colin, you haven't sent anything pstore related since 2016. Please let
> me know if you'd like to stay listed here.

You can remove me.
