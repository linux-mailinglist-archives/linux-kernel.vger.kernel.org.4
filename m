Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FA65B8BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiINPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiINPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:21:35 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F22FFF0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:21:33 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g8so9901920iob.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8sVnRYf4lRZtHclJFM/PYgijezwVHsVwJUa/M1F9Nfw=;
        b=aU+pRvep+sXGVRr01+jPV7M1KGeUuIOdGm/7Imgv2e35rdbyXzmARUq1pX7NbUK31d
         P7JnZtuwOHE1Y3V+NSrCkrjcfy/IVgYVBkLzYROVFEJ2rN4QRKzlug+IhDRBgsnblfD/
         z6gvdEo890XqggiMeBDVIPT5KAcHLF/iLDo5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8sVnRYf4lRZtHclJFM/PYgijezwVHsVwJUa/M1F9Nfw=;
        b=Ytpbrwzh+E6KIouTNtNJU4YLNK82rP7hb4heJxafJALXHYIHkVevnmIXYwam6F5FPK
         0IjHFtUx1MpOd2f+IG2QGpw3PTvucKQSf4YU8NuWcsavOJkzR7L4xK1VQvZvUr9inEAf
         XUqvxlmfW/IGv0VbqvS+2KIbV5FrEWtrKti2eedl8HVnpkW4v6iq7tpuj5jmSVzRHDsx
         36lq0y9cZfwYmX76NSwPCpZ8JBN/Aguow31SJtcpYxmdZqBElPCkWMCXhCdMxxmIbxDI
         6/rXz6+XHTKG/DMuLInGk8wIv3Vr4A7CGsz5tsULSsLLGF2WN6vPSR8vpUH6Zlx4ofAW
         2VWA==
X-Gm-Message-State: ACgBeo3dd1J4honb28LljhGHNSpCR8fjizMemrGDAOlQpsRGn2V5Ib7L
        7gsYddDHVkHqmj2jPcSp59L/PTSnTDq6Dw==
X-Google-Smtp-Source: AA6agR7ktZkTisvN6WNIBpZ3HiypBbrnmif/y0CRvs7XSjPupkJN41LgalrFpXDDvRmF4qvsVCEyUg==
X-Received: by 2002:a02:90d2:0:b0:349:f259:a097 with SMTP id c18-20020a0290d2000000b00349f259a097mr19009697jag.141.1663168892500;
        Wed, 14 Sep 2022 08:21:32 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id cx22-20020a056638491600b00356744215f6sm7264816jab.47.2022.09.14.08.21.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 08:21:32 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i7so3560967ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:21:31 -0700 (PDT)
X-Received: by 2002:a02:9509:0:b0:349:b6cb:9745 with SMTP id
 y9-20020a029509000000b00349b6cb9745mr18869971jah.281.1663168880396; Wed, 14
 Sep 2022 08:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.5.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid> <YyFs5q67RYR2aAy7@black.fi.intel.com>
In-Reply-To: <YyFs5q67RYR2aAy7@black.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 14 Sep 2022 09:21:08 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CU2-YtOfGYXJq3c=-1ttyw=hKZvViOfWGAKkxXO1C5Gw@mail.gmail.com>
Message-ID: <CAHQZ30CU2-YtOfGYXJq3c=-1ttyw=hKZvViOfWGAKkxXO1C5Gw@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] gpiolib: acpi: Add wake_capable parameter to acpi_dev_gpio_irq_get_by
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "David S. Miller" <davem@davemloft.net>,
        David Thompson <davthompson@nvidia.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Lu Wei <luwei32@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:55 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Mon, Sep 12, 2022 at 04:13:09PM -0600, Raul E Rangel wrote:
> > +int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name,
> > +                          int index, int *wake_capable)
>
> Here too bool.

I've incorporated both of your suggestions. I instead added
`acpi_dev_gpio_irq_wake_get_by` as the basic function and left
`acpi_dev_gpio_irq_get_by` the same. THis way I don't have to update
any of the callers.
