Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F670CEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjEVXrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 19:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjEVXau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 19:30:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E4107;
        Mon, 22 May 2023 16:30:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d2467d640so5661056b3a.1;
        Mon, 22 May 2023 16:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684798248; x=1687390248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xernQNKYRJpE9vFsjzMr/YTOObUVHtJwlSgWwo1QHTI=;
        b=rcXz+2D9jl6iGGL3/riEwfEdlU06CalNyJuIz0Has414j9PtiKoDsv/yFX87px58ai
         z0r5Nk5vbuB5TCH0ggsiUv77s/hVwZTnLXj5cvL++HnqGigNBbtPL86/RrrqKdwTd5vg
         OgPGoBgBOA0r+HPaZl0ddVCxz7T9/NJntCEVfyZTGbcZW4tow3nxTZLwI4sxG8RDxYXu
         gJm76mCp2dviyO0We/XiIvpzNU5g1xU5NCKJtVdurodlO1YQG9vFHtVmbyJZ83UbI8qy
         di0IPbr6dFBKusWqUfRkSckv9fzv/W9NiW+yubqE7+Bsc+oQw0HelNYtf7QPWC0NkaV5
         7e8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684798248; x=1687390248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xernQNKYRJpE9vFsjzMr/YTOObUVHtJwlSgWwo1QHTI=;
        b=IwC8FhW/xqXEfvGxqyoJPslvsziXWQIvfaranL2QcZz0tALd0rrwiehc6eHwdxg0r3
         n1HBHA/Ymgpbp4OsU5uu8++6Qbo5ArgjR6x7khV6jMkCHWZELfUwDFk6iuASjV3xPbYn
         EMD1nZql4nW/UcSj0LbQh+tIaQEx6zVt+4XBUXhXcQHySIXHwOme+buK7CwAFEOsfsTx
         iTGrWgVNorpRzVIRbDy4WPvBbVZqL4eXvAD/nKaWTPGbwwLz7XAvhJSaC1aGZ+NFE1v4
         TFn7pDsrL7NZdtYZCnEvhzhA879aT2FLkqVQkJfB+wuCkqH4oi7wpJZWaMGCI0H3yWUA
         AG9Q==
X-Gm-Message-State: AC+VfDyKJEZAIOMt8+2T5KwSbEW3eqR+TrtYgZibWXzOzIytYrdECVv0
        d+lOrzhqHVeLeFC4W5Gjq8w=
X-Google-Smtp-Source: ACHHUZ7Snm2NO338HrUo1drd9l7opKCnCEmCWIZDkjzYraCiiKM07FPvA95sdz4W4Po9obueAxQJaQ==
X-Received: by 2002:a05:6a00:2daa:b0:64d:746b:b4ec with SMTP id fb42-20020a056a002daa00b0064d746bb4ecmr4688640pfb.17.1684798248477;
        Mon, 22 May 2023 16:30:48 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:54fa:e8a7:76de:888d])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7874d000000b0063f2a5a59d1sm4615466pfo.190.2023.05.22.16.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 16:30:47 -0700 (PDT)
Date:   Mon, 22 May 2023 16:30:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: ensure timely release of driver-allocated resources
Message-ID: <ZGv7JLaDo3aPWKgV@google.com>
References: <ZFWarGkRAfPOmI6E@google.com>
 <ZFaeiwBp+5hUXk/j@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFaeiwBp+5hUXk/j@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 11:38:03AM -0700, Dmitry Torokhov wrote:
> On Fri, May 05, 2023 at 05:09:16PM -0700, Dmitry Torokhov wrote:
> > +	if (down_interruptible(&hdev->driver_input_lock))
> > +		return -EINTR;
> > +
> > +	 ret = __hid_device_probe(hdev);
> 
> There is an extra space snuck in before "ret", let me know if you want
> me to repost it (or if there are bigger concerns).

Gentle ping on this one...

-- 
Dmitry
