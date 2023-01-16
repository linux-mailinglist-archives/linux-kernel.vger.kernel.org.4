Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E748366B869
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjAPHtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjAPHsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:48:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C1CDCD;
        Sun, 15 Jan 2023 23:48:54 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vw16so2888548ejc.12;
        Sun, 15 Jan 2023 23:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BveKnQYzfJcfYlQlVBW6q1fKDAnDrjIUIsSQNVV8cbo=;
        b=L+wbY/8CkiQMynFh4aHwuT/QiZNNSTsIPyDk6a9CQKT+Mx+bJqEKS4kwbjjPSjK3tc
         k81mQxiztbOMfjMZkGyJRpfztHtwzn/bemOFUEj9/57t/MEHgAqq1dkZx9hMWTu8MHDr
         XAuh8PDmp14+8aV5qg3vuh/7oxaiNvHcHJOZB7WJs5VA3h1W00yyHnmo4bbCvAn1kPEA
         SXy23P13ideCM0ezwQsUESggMCqj6wGTOBO347OM/IOWi88LcDwfnTgqqS8nLSnUQcl2
         ne9JTarBsFi2ONedIWpRCqVIdZS7/DH94bRknR9W6F5q3zLSAWfIsJ2fr5dXBjG1jpMW
         yOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BveKnQYzfJcfYlQlVBW6q1fKDAnDrjIUIsSQNVV8cbo=;
        b=LuH4sHnRcirwl+T8KfDqIXPCyWCA7Mq0jwg069QUxDUcFX99MFcRjB4lXFI6ea5J3c
         +Dm/rs8L/hJNsLO3oioJHXVtks2h8EzicjOYhoVO3nKAX6iXbSH/BBoRhckwAO/CuQ8I
         iv1J5us5GQYKV6xlM7KEFmHfYZUQ6Riq5qNVOEIbnkOlzPVlX3ItwqVFLDvybj4gdPLQ
         fADXEcXAtiEwKhNFh+d0sE2YX5DV/9DfPIpp1z3iMOSVmm5eleZ3VMxpTkqJJonyK5qz
         tVBOkVgAnCVmr+SLuPTlGLyDZ7YsB1sjxlQ72kS1h5/35Qzg76K60TjNS65pA75l/FUy
         +MsA==
X-Gm-Message-State: AFqh2krpbUNsO2Tm0WmAWOpSvM78XZboT8SHX1wuIkI2k9Meg0GSTx05
        p6X2RYSt/BWAaZ9PKjag/+sikDH5dGDW3O5aMQA=
X-Google-Smtp-Source: AMrXdXvZ+4+4TqdhQem+0vftK+QhVXUdMvzHwjSomU60LrE+mLihUcd7+EyxUSKEj7onvODE+IekAc2eLZRriQqElUk=
X-Received: by 2002:a17:906:74ca:b0:84d:33bc:652a with SMTP id
 z10-20020a17090674ca00b0084d33bc652amr4195405ejl.68.1673855332653; Sun, 15
 Jan 2023 23:48:52 -0800 (PST)
MIME-Version: 1.0
References: <n-Xd5VZl4mxdBIPvH-LgdDqAi8N9cL3TiAQ6fKEOpXLKsyDAxcf9VWQZfnMobTdIXucJJ1U2B82W6KhoODwWr_n3d-V9YkDcV92AjzxMrys=@n8pjl.ca>
In-Reply-To: <n-Xd5VZl4mxdBIPvH-LgdDqAi8N9cL3TiAQ6fKEOpXLKsyDAxcf9VWQZfnMobTdIXucJJ1U2B82W6KhoODwWr_n3d-V9YkDcV92AjzxMrys=@n8pjl.ca>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 16 Jan 2023 08:48:41 +0100
Message-ID: <CAKXUXMwbkDgwMvB-CDyDbL7CS1eSn4P=87BqfWCyvCvP+SkQ8A@mail.gmail.com>
Subject: Re: [PATCH] pcmcia: avoid defines prefixed with CONFIG
To:     peter@n8pjl.ca
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
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

On Fri, Jan 13, 2023 at 4:30 PM Peter Lafreniere <peter@n8pjl.ca> wrote:
>
> Macros prefixed with "CONFIG_" should be relegated to Kconfig switches,
> so we should change the config state flags to avoid conflicts.
>
> This change affects only code readability, not function.
>

Peter,

If you are interested in doing more clean-up work in this area, please
let me know. I have a longer patch series of various changes that have
been partially submitted and have not been included yet and some
changes I have not sent yet, as they are really minor spelling fixes
in comments. Further, I have a list of known false positives from the
./scripts/checkkconfigsymbols.py warnings, which you can use to filter
out some of the warnings, and some experience on this script to find
what is more relevant to address first and what could go to the
low-priority TODO list (that just might disappear, as old code is
completely deleted).

I can share all that with you if you just give me a ping.

Best regards,

Lukas
