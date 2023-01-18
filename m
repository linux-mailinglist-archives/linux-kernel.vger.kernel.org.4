Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879F467223D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjARP6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjARP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:58:02 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C54A4FC22;
        Wed, 18 Jan 2023 07:54:22 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id p96so11951752qvp.13;
        Wed, 18 Jan 2023 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp/FF/OlNcvD2TDo83pV39FfZ/33m8fmuUNBlmKGb1A=;
        b=lnETeaMUTNuDwBg/aRYZXHd9v8+aK6tgbqCGA8aM9w0TW39275mAI+th2srtPCybxj
         uf+W4QaUEenDlDJzsp8ezJ7AwY2cCFf2moaeoIloh/++r384Rl6d6Rp+dNh9oEQM46QL
         BFHM77xNS1E+zqFrfG5CrxsrJVGqwZreaRRjV99hUWgc9wPUMKMpLFQlkCG250ACnNMi
         r126XRMLt4Wsv2KO8KYZESE/D9MGFIgltQFuABSV7sOky1DxCogZv8holEs8dhEgHMF5
         JPJnbJRsQj4P73gLnn6Y4vFaMYf8UrCCs7EersAss0MvjY/S3wdE6Y8Eagi2g2Evf7A9
         1Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dp/FF/OlNcvD2TDo83pV39FfZ/33m8fmuUNBlmKGb1A=;
        b=iCvQ7Evp6UEbgQp1zNf+33+GzGwauwOC2tL/0r9/7McA/qTdqJbox5rschs3h5HdR9
         AuwK7KCreiReVBIlBReijiERssQrAKYECZVRRnClDJ9EJnZ7ErkSo6b4qHWx3bQJSqpc
         CFirGHsXudhVGcQbDK3hy6lzTSWqAP+p2vRB5iFbLnpk3DeOE930xtQQC0jS0wIMxk4B
         LbqAon/s1p72FpIe6RzPgOrmOtz+bp9aICSnWqEz8z2icFFUrQ3R8QxHcxzvQWwuTIYT
         h8Wr5mr6vxyfEoyHIUZLQp7+YwHCg5uCosl3mYVZV89BVMBKeqJyus6oO76LHny2Na00
         fB6A==
X-Gm-Message-State: AFqh2ko+7mK0z0SdKnE3bqJ+lXEaSexyNZk9XFtvtAe6x1r1A3qCOJZK
        bpFenuHjFkhhJ545vT/ZLlTKGo9m6X/XcHJX3Jo=
X-Google-Smtp-Source: AMrXdXuyrdQ92kiDwWynQkXu3LhRr0aTzZX68EoFvg/xNQF0bdBeBJK4b3kzt1XggPD5xzBnMIVoL1vugEhWI7rq8/8=
X-Received: by 2002:a0c:b208:0:b0:534:3c7d:97fc with SMTP id
 x8-20020a0cb208000000b005343c7d97fcmr429300qvd.11.1674057261293; Wed, 18 Jan
 2023 07:54:21 -0800 (PST)
MIME-Version: 1.0
References: <Y8gImBdR6YpEKZEb@kadam> <20230118151656.20558-1-bpappas@pappasbrent.com>
In-Reply-To: <20230118151656.20558-1-bpappas@pappasbrent.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jan 2023 17:53:45 +0200
Message-ID: <CAHp75VcxvPZOZpGMSQXkCFv+WekHckMJkympfdR0ih72AjjkNw@mail.gmail.com>
Subject: Re: [PATCH v5] media: atomisp: pci: Replace bytes macros with functions
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     error27@gmail.com, ailus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
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

On Wed, Jan 18, 2023 at 5:17 PM Brent Pappas <bpappas@pappasbrent.com> wrote:
>
> Replace the function-like macros FPNTBL_BYTES(), SCTBL_BYTES(), and
> MORPH_PLANE_BYTES() with functions to comply with Linux coding style
> standards.
> Replace multiplication with calls to array_size() and array3_size()
> to prevent accidental arithmetic overflow.

...

> +static size_t sctbl_bytes(const struct ia_css_binary *binary)
> +{
> +       return array_size(sizeof(unsigned short),

I would use size_mul() here, but either would work.

> +                                         array3_size(binary->sctbl_height,
> +                                                     binary->sctbl_aligned_width_per_color,
> +                                                                 IA_CSS_SC_NUM_COLORS));
> +}

...

Please, fix indentations and patch will be good enough, thank you!

-- 
With Best Regards,
Andy Shevchenko
