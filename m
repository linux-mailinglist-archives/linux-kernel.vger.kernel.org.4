Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C506377C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiKXLgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKXLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:36:08 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5923797AB8;
        Thu, 24 Nov 2022 03:36:07 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e15so892505qts.1;
        Thu, 24 Nov 2022 03:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R8BPplO7UlHzk5yo9FOzqotniwR7y6QrBugM8+AwrSQ=;
        b=LbypaNLt3I8EKendSm8Ba65FJIvtubs5gAuW3xGDHqOAfoeX1Hmk9OZI2F/7FEDdYx
         Qcc3c6HfKuCzbn6ji+HsvkUbLRLMpB5hP3nnKRBNPuUdJtrc28TJ6MLZH9f7o06NUlbi
         Hvl9kK7N9VGCdb5n6/VNxsXgF6XcfTmWZ3IMf0s4umGt194DCudkY16GlJeUmIXtrfqA
         lyvZ6pkAVWUXrom3u+RuIxme0er08h5UyHGiawIAMx1ydF7++Jz/R9JPMQINCUbBaKkP
         hD28P+tFhj5TfQr5dzL7iDwFXG9htX+S/N/B2n2nwUBKNMWJ4sdsMdeA7iGZakXSlKaJ
         jcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8BPplO7UlHzk5yo9FOzqotniwR7y6QrBugM8+AwrSQ=;
        b=LjX6oMfeW7HDkvIzS4OQ80xrgThmJEL6FcOxsAy8oKy8WMQDKbE6I96GeJKhCP5rGR
         1Q7y0fVUPOzdRSAjNICeBAde8AnlWUppn+vaK4XMvESQGPCh5s08CJF9kcbCXAsV5/gq
         B3VNS9qgByOuGlpRCVO1Kb5yc2cpoO8RpuemiyOzKb9YhRKa5w+YMoLwe6FcPWVlwZv2
         p+wc42vT9vX6d/qrG+crgWH20ByqEfz9Kw31I4tBVaP9djHK85jJKfsRnyUMxhdMTi/f
         b/UDzsJTWqXlbWe9VspZmKDKH0MuSBnu60yO9bTRpWpcNibyBVLTOqDVZTLu9qKzLddc
         0ucg==
X-Gm-Message-State: ANoB5pkaWF4B4dM/USstJ4dgv406w3oGmzHpEoMWEoVK+ZOWatIk0UMz
        SlIUWGfSQs7YzCqPeydnlHG/x1+0SaOPFUX+Wqg=
X-Google-Smtp-Source: AA0mqf7M/JAbmhM35ZrYv+M8CxU6vmyIv6WkHYgF71vj9U14wRfDHw8RbyhLhPBoGOyOO7XlkK+mIf89b1QuhD8s71c=
X-Received: by 2002:ac8:4cd1:0:b0:3a5:1940:a027 with SMTP id
 l17-20020ac84cd1000000b003a51940a027mr29417932qtv.195.1669289766424; Thu, 24
 Nov 2022 03:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20221124110718.3925934-1-sbinding@opensource.cirrus.com> <20221124110718.3925934-2-sbinding@opensource.cirrus.com>
In-Reply-To: <20221124110718.3925934-2-sbinding@opensource.cirrus.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 24 Nov 2022 13:35:30 +0200
Message-ID: <CAHp75VfUqkxyB7J8fbfQKCMaSa55q4zqt7btNb_n5E3-NWhQyg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] platform/x86: serial-multi-instantiate: Set fwnode
 for i2c
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
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

On Thu, Nov 24, 2022 at 1:07 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> This allows the i2c driver to obtain the ACPI_COMPANION.

As far as I get how it's done in the SPI case the real fix should lie
among i2c_acpi_new_device_by_fwnode(), right?

-- 
With Best Regards,
Andy Shevchenko
