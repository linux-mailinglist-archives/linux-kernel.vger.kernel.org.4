Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5AA642C88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiLEQJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLEQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:09:06 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FADA1CFC6;
        Mon,  5 Dec 2022 08:09:05 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y135so10485941yby.12;
        Mon, 05 Dec 2022 08:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OaB3OQ0URDFHXxjcwHhCyd2CAPTUuyAJq3NmN97aOGw=;
        b=NsnK1UsAhHKkQnNGGN8UQkIhv7lgQpwMQAhtas/rsjSjePwq98T3s59Ht3FfWMGwrD
         Fx/jP34bmNxTanMHz4qb0UUS4kHNBASdRy4dpZ8QJPmVt4Zd6mjkOaqpkSHBOYHSul1e
         YdGVLxEC7bUaXgy3a2m9CL3TRFMeCsrIyCN8P7xJanjQCi2Xk4hR6EZhpNPNgmnreYGV
         P6jU8usu6lnG2V3GCJKj9J0JDE7m8xL+R/KKo7hJQyTB+zSwwKGnCFsF+yyrVpuGn/FV
         731ZbI328eUTR3u64a7gtzNuRpyG4RQhnCQESsnqA5hpncSLpe2QDTwqsReSeRLKP6kt
         9hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaB3OQ0URDFHXxjcwHhCyd2CAPTUuyAJq3NmN97aOGw=;
        b=OZZsCLsU0HmUkMu/NoRGSP+V/LZoDRplLlrakw6jZRw4GDok9wsofY9yJtotCvZeXC
         tt/5NTkLCGs4ReHtJsXVrl508YVSe79CzEMSw8J4Nuxsjk64XcdXdg2f4mOSOhBl6eJ1
         RM7CcUz3WmAiGvWK1WXoz3o3/pe/sAfcRcp+b6731fTp1i/IdTewAI2qAvQCejPUmS2O
         3D7ALUyPPr+Zr1z/9UxWtM1Swa7UmP7+j2VjEkn1zytVXhVhbY9FTje52eMJq7/+7I3T
         eYD0XXWHPYN0Mp1ATXhGTYF/56RkUyT8A64Zqyf3hdYj2lCkkrhtGYCYYzlC5bVYZoKc
         TGlA==
X-Gm-Message-State: ANoB5pkm5SF0BYwtsV6D8AkPh2JU3/mL3maQwD1bBHgdhMptIyULVFjD
        wFZL7unZaMlEUegGiX2l9lHnnaXpU69kCYnYv+4=
X-Google-Smtp-Source: AA0mqf76z/xCHPVEzDlCWMWnxbwgn5zTPtlVIz/8XQEs9QQlKsK2YQV0m3h/92Y/qUtWYeS7rlh/MYYQ7yGY2xQKyUI=
X-Received: by 2002:a25:ca58:0:b0:6f4:3ced:f7f8 with SMTP id
 a85-20020a25ca58000000b006f43cedf7f8mr41164333ybg.489.1670256544692; Mon, 05
 Dec 2022 08:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <20221201204814.2141401-1-carlos.bilbao@amd.com> <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
In-Reply-To: <a019a3f1-7ff1-15b2-d930-e1d722847e0c@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 5 Dec 2022 17:08:53 +0100
Message-ID: <CANiq72=ud1EB+jcKE=iudFSgKNcqd=8Xe-M0YgxikmUuQ+TjGA@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Integrate rustdoc into Rust documentation
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, corbet@lwn.net, konstantin@linuxfoundation.org
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

On Mon, Dec 5, 2022 at 2:06 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> So, this means "make htmldocs" will require kernel .config if CONFIG_RUST=y.
> I'm not sure this new requirement is acceptable for kernel documentation
> testers who just want to build kernel documentation.

If the worry is that "full tree testers" (or CIs in general) cannot
fully test the docs anymore without a config, that is definitely a
change, and one of the reasons why I initially didn't add it to
`htmldocs`.

However, full tree testers will need other changes anyway (at least
installing the Rust toolchain), even if there was no need for a
config. So it may be not too bad, and putting it in `htmldocs` means
not having to call another target in the CIs; and for humans, less
chance of forgetting etc.

(It is also why I wondered above about
`CONFIG_WARN_MISSING_DOCUMENTS`: if `Documentation/` intended to
require a config as a whole, then it would be fine. I assume that is
not the case, though, but not doing the sync is nevertheless a bit
confusing)

> By the way, is rustdoc's requirement of .config only for CONFIG_RUST?
> In other words, are contents of rustdoc affected by other config settings?
>
> If not, I think rustdoc can be generated regardless of config settings as
> far as necessary tools (rustc, bindgen, etc.) are available.

Yeah, at the moment the config affects what gets generated. However,
that may change in the future: there has been some movement around the
Rust features needed for this recently, so I want to try that approach
again (it would require some other changes, though).

Cheers,
Miguel
