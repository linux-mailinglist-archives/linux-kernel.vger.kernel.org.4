Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E115672A122
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjFIRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIRVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:21:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F65D3C21
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:20:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75d4094f9baso187835785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686331247; x=1688923247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C0K1xdwndgBNW0YDQyyOi1RArcLQ78z0GGBNEc1ZEuU=;
        b=Q+YN33+MPZ/KyNwbxluflczPkuWx35ML7tjPBZNUGIhWCslVSXYFlR2Uy6h4TWzsQk
         XOnc7Qklt1V0GeEa9eqn/urSxdV8+zqBAvDlp2UHFZjUE5mRyK6E6Q0AnkNJDt2IYLV/
         Lv/z0GjSWJEHazJXPcI0QjtDI306iyTCpwFOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686331247; x=1688923247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0K1xdwndgBNW0YDQyyOi1RArcLQ78z0GGBNEc1ZEuU=;
        b=KAPbKPlgLQF1LZycvRzEgXhrZ+ch8vTYrevzLFDLDOJnk4g99PqOKQRbpLm5hsiQH7
         RMGuvaQGmWOlOIDE2CeoFU/GY3hHc6dlYthxifpBIEIxUZd6lco/4vkceRtRGxD/m0Fa
         pO8WUx7l61NKMh5sMWkyxJlhrkiW5W8jQKGY+NthiAgtkcl8QKpOmwIX7SlcuXwOywiC
         suD5dLBrrYzxZXRqRMLlJlor1UWKmZNxjSPpOcvkgWfHJq0CtBI6asGh/76qRCCB3PD8
         PVGe9Mj+WhrNeBfCWu09VfdWFkuoRrjRPKiE/GPXsxamfwaNSvavJVfbsYGzYjJF2EMV
         RT8w==
X-Gm-Message-State: AC+VfDxbe736nY6SpYcRBuHMTxwF2S/Pj5shlXnkaVI5v/a+rD3km8Yp
        +S92sZCWXQhdW1jnTC10UapT5Q==
X-Google-Smtp-Source: ACHHUZ52RAdB+pe19du5jItqsJmborh/2vTsnV+wXJQF86Z0hJtjAviEF6MYJXDNlIiMeQJ8HkSU0Q==
X-Received: by 2002:a05:620a:1d0a:b0:75d:a00a:1e1b with SMTP id dl10-20020a05620a1d0a00b0075da00a1e1bmr1862890qkb.6.1686331247266;
        Fri, 09 Jun 2023 10:20:47 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-132.dsl.bell.ca. [209.226.106.132])
        by smtp.gmail.com with ESMTPSA id o23-20020a05620a15d700b0075cdad9648dsm1174809qkm.25.2023.06.09.10.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:20:46 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:20:45 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     pr-tracker-bot@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [GIT PULL] gpio: fixes for v6.4-rc6
Message-ID: <20230609-trillion-imitate-f2914c@meerkat>
References: <20230609144613.210272-1-brgl@bgdev.pl>
 <168632880867.22652.10987437416013616928.pr-tracker-bot@kernel.org>
 <CAHk-=whVcTX2hJ9VrpooL1ft34oB5kyrRsziM7cH94d8RGA_7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whVcTX2hJ9VrpooL1ft34oB5kyrRsziM7cH94d8RGA_7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 09:43:37AM -0700, Linus Torvalds wrote:
> Hmm. I have no idea why you got duplicate replies from the
> pr-tracker-bot for the same pull request.
> 
> Konstantin?

Odd -- I thought I had dedupe logic in place to avoid the situation when the
same pull request is sent to multiple mailing lists, but apparently it failed:

msg 1: X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
msg 2: X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>

I'll double check what happened and fix.

-K
