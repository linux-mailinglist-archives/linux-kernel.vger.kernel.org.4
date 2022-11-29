Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1802563C70E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiK2SNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiK2SNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:13:16 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1ABDF53
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:13:15 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d8so10405648qki.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oxizSDtUrKGW9s75wfUhGFGOv1cbxYsbxzO0Bfc6NkI=;
        b=Eaz6vuCU7u00zWseDKdCYKMAVyDLlMsX995nhSluQCaJIl4kZ3Phky9xWJrvZSlDkX
         K//ngzfvIXB80SXU5z+0dquHREqnSOdDWMoxmy/DJ2gk1h70eQUC/xc5CmfoS2Rp9qFb
         cQwDvq6Rgx7Hdel50IMqDkWCaIoAjIqqZKJ8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxizSDtUrKGW9s75wfUhGFGOv1cbxYsbxzO0Bfc6NkI=;
        b=T8N3HqZYCA3hIoOfpmw+d7ZfRyk0ILVNmoV4v3Hi+ExbA1M61yHHB8Jd4rn2fXYQ0O
         65BEhxxl/3gWq5xhrSKBQidB5tGU/EvHViDog+2mvp28f4D3yCfbfsgdzXEG7hyuMLP1
         Gsm7BOqqsOa3P2LxBoksSLpt2xafmePIvDZw2teQTfTsCV7UPwkoltJOj6afaycYLijA
         SVJDLkfxBAVQXdaXihOOjiRbblnAVB7jlHBu6PzB8nNRlN/KrRutL0lyRXoGeG3lmtK0
         P6yLBNIp4sl/b2Ar42RUt1PVpsOGBBeuKL6wAU2N0Av8Jg54OaxEy21j8fiZsGwLoWUO
         EUgw==
X-Gm-Message-State: ANoB5pnBpcgOebTyGcnzPdEnql9k99yCf4VpYLHtz4EpyywD1LBoi/l7
        THB1XRr5E/lavKYGxlfCCS1o8cjo7mImAq2Kqg26lw==
X-Google-Smtp-Source: AA0mqf6Sx/sJ2/wuBlsiie3OPD5aPlMymeX4M0l+aBQxKXtQvnhP/H6W7D77zIgpkf39KgHmL0C10xO2/QupgenuriI=
X-Received: by 2002:a05:620a:2694:b0:6f6:b34a:5333 with SMTP id
 c20-20020a05620a269400b006f6b34a5333mr51687260qkp.1.1669745594753; Tue, 29
 Nov 2022 10:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid> <Y3cbswXxTKWhMjKT@google.com>
In-Reply-To: <Y3cbswXxTKWhMjKT@google.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Tue, 29 Nov 2022 11:13:04 -0700
Message-ID: <CANg-bXAxeL_N53umfeoYjAyDfw5EeHmcniZusPo+bb-BE1R4Ow@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] platform/chrome: cros_ec_uart: Add DT enumeration support
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -392,6 +393,12 @@ static int __maybe_unused cros_ec_uart_resume(struct device *dev)
> >  static SIMPLE_DEV_PM_OPS(cros_ec_uart_pm_ops, cros_ec_uart_suspend,
> >                        cros_ec_uart_resume);
> >
> > +static const struct of_device_id cros_ec_uart_of_match[] = {
> > +     { .compatible = "google,cros-ec-uart" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, cros_ec_uart_of_match);
>
> It would need a guard for checking CONFIG_OF.  Similar to what
> `cros_ec_uart_acpi_id` does.
>
> > @@ -405,6 +412,7 @@ static struct serdev_device_driver cros_ec_uart_driver = {
> >       .driver = {
> >               .name   = "cros-ec-uart",
> >               .acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
> > +             .of_match_table = cros_ec_uart_of_match,
>
> It would need be wrapped by `of_match_ptr()`.  Similar to what
> `ACPI_PTR()` does.

I'm not sure we want a guard in this case because we compile the kernel without
CONFIG_OF enabled for (most?) x86 platforms. Yet we still need the device
tree code to enumerate using the PRP0001 _HID method.
