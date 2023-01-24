Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66802679A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjAXNur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjAXNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:50:06 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95C86B5;
        Tue, 24 Jan 2023 05:47:45 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g10so11688113qvo.6;
        Tue, 24 Jan 2023 05:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vKu+X7MRgR2FTg0QgTNWRxmz7w2KtY/oNZEYxWU8Zuc=;
        b=TC6vcZFbRjvPPXm0r3VDaPyypkO+e+kXra1+nayA/TBUL2OKMhxYRD3J/iIseyUiL2
         Fom0ZX1DpKnEwq6o8H6DxwgXcQKVfbncOTrsOSj7v9vOHlJMil/OiV5zUCvID7xwjJuL
         DEXAoghUR7CkRwnQuF+DXIfVgJ5fZTkpNyWWEWHhTI4keMZ0bW7x0Ig9o5h/x2DmptMB
         ImOevEbidmmi6RrbMK/7sM/S4YINCPrDE5B2Q7NSbeVGMiRkM2sAi+fy0aR06jlkPnyR
         IfNPJPLxufakSdpWCIRFQjwc7M5ehjQazB08oHpPJdd6vZ4Ek3OKduMWEnwy6UKkLhSW
         spkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKu+X7MRgR2FTg0QgTNWRxmz7w2KtY/oNZEYxWU8Zuc=;
        b=fv28khJej1+0Ga4PSi1KfYwPah9dRZO/pXjaut2AyBwRbJg73f6kxNa51i/IvcWM2+
         i/DBVqw3T9olhDziBYQSJBbqTos2NSeJR4iKoYv+IgUUIF2CgSKwnHOrC5JrcEJS47/C
         ziWq8zYgBXAwSIVn6iNtwiPHpSKOETb/Ogsq+guwWv+bNxebUmc2hA/BP/OTwZt+JyOu
         imYe77E5z9nUuxGxfwMmRAyyzY5hFHOFtvf93XYLlia38iU47nEU069puwu18epKHyTt
         4NX5QlP0QmGhRhQJcr6i8m4CdQpCGj1V6ndK6pJtoI6/3MwgX7b0i7uhRFRO1KhrNnAi
         c7EQ==
X-Gm-Message-State: AFqh2kol/M9ozXhlU8cU+oRWsJpGUVI2uND4CcyBPsRLMGWJPujKCaSz
        GeBHpMmGS/PgkerTZEOD3fC8U51Gve4M3UpZNprIQPBL23k=
X-Google-Smtp-Source: AMrXdXvBkKxmqFCzpta9OqKuhEEMrodZBp4eN+q2UfwktUSEPkm+N1o86LPXAAmWqur8U5kWO/QwBXvFFaKbKlgJazA=
X-Received: by 2002:a0c:b208:0:b0:534:3c7d:97fc with SMTP id
 x8-20020a0cb208000000b005343c7d97fcmr1682251qvd.11.1674567997483; Tue, 24 Jan
 2023 05:46:37 -0800 (PST)
MIME-Version: 1.0
References: <20221007153323.1326-1-henning.schild@siemens.com>
 <Y8mv8PzL1UsP9gNh@google.com> <20230123214859.725cd1c3@md1za8fc.ad001.siemens.net>
 <CAHp75VfSHgdikX5=Qba62BwWofVf7gHhS2hq2OuBwHFz9riCWQ@mail.gmail.com> <20230124143514.1abf933f@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230124143514.1abf933f@md1za8fc.ad001.siemens.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Jan 2023 15:46:01 +0200
Message-ID: <CAHp75Vf5MAsiYKdmF2oQ2rNDjKUVW9nk5FjPhUcD3b-4r_u6yg@mail.gmail.com>
Subject: Re: [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the
 GPIO providing driver
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jan 24, 2023 at 3:35 PM Henning Schild
<henning.schild@siemens.com> wrote:
> Am Tue, 24 Jan 2023 11:46:34 +0200
> schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

...

> I would like to keep the number of files and CONFIG switches low, with
> a focus on the config switches. Every new CONFIG=y/m has to be
> requested in countless distros. So far i only dealt with debian where
> ubuntu might follow, did not check others with recent enough kernels ...
> like fedora if they have the SIMATIC stuff turned on or need to be
> asked to do so.

If you put the proper defaults, you can get good results without
torturing distro configurations.

See how 8250 has been splitting over the time, we have +~5 new Kconfig
options and their defaults are to keep the current behaviour without
the user needing to do anything in their configurations.

-- 
With Best Regards,
Andy Shevchenko
