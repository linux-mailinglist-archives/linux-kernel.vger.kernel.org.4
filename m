Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8989C6340E1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiKVQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiKVQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:06:55 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD5C266B;
        Tue, 22 Nov 2022 08:06:53 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id cl5so25444523wrb.9;
        Tue, 22 Nov 2022 08:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZbcLc1NbGI1l/6+xkDi6hPkSMpf2+osKsmf8F3UIjE=;
        b=LCAPKLYWy0dhVyuIq+iK/LWvJaCX8mYkUgi+Q41DQscfJHn8cGkcVGgi9NSWMkbRH4
         pGisczbWhz9o/4XJyA8xM9YGJSHuF50Qow+nDACZfJBLmLg/b0958oEwXRIRdEMG1fnL
         HVh7a5QJm21LR6HAi4SDA5+eYH6vEoPCp/jCWRJXkLQzsUSkTzYAaxUxmIL6r9jcD4Tl
         z4xPxxP1jWfsRpMVrH67zReB/S2kfZTins4DFH8k4eSiJusUa8eDEM3TBgceVwcEJlzR
         BhhPFxKagG8uglWBZc5FJu1zotcEmI+KnZsEa29dvaFWY44wZVTCwudqE2TzDdezMSfW
         Otuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZbcLc1NbGI1l/6+xkDi6hPkSMpf2+osKsmf8F3UIjE=;
        b=PdhqS567wvmHbXg0abanrYp0P9dPUZwyKvc7C9UiMtNzdXVH9S4RFjlrrYE67/nNq1
         vzLm64tUxY+0Tpn0bY2Z1sb6Uap4aG+jMgeTFfzRCIfb+GY72peclr0Ruyjs3rSv+X+J
         pXrrqtosy4TSLD8hHj2UE0LAGAqhEQrLXyQ9QrM6geAEn3u/vwrejVWZOrpYef8S3vu2
         yLPNkc8+/Cgxx6Zam8Y7zyah+Rpke+ZFs/a/+2XJMp1RcZxIVYsAESbgqcrCAxw3lQFX
         kD6r6M5V8w+5Roe+TAXyrdZZCPeRDm3cZhUJWHDS4gm8RI4eZMIejLXluupm+W+dkGWX
         KrRA==
X-Gm-Message-State: ANoB5pnvHFrmgA5vjFy43Q1S2I6ZcAe8zCcfY90mNoFYvO2Wu3JP86Ft
        nyoOHhSrhtoSWIZvo0ke4O8=
X-Google-Smtp-Source: AA0mqf6q95ydA4o3WRI6W+Zm3qAD1Y8jZSn4otxBzjVGODu/y8GD4h5KA+8YMBGH6dZhyw2bGHzRag==
X-Received: by 2002:adf:f612:0:b0:22e:5d66:dc5d with SMTP id t18-20020adff612000000b0022e5d66dc5dmr8876203wrp.175.1669133212263;
        Tue, 22 Nov 2022 08:06:52 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b00236c1f2cecesm16870029wrs.81.2022.11.22.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 08:06:51 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v3 1/2] usb: serial: add support for CH348
Date:   Tue, 22 Nov 2022 17:06:50 +0100
Message-ID: <8903614.NSr7dpRq1j@archbook>
In-Reply-To: <20221114073736.672194-2-clabbe@baylibre.com>
References: <20221114073736.672194-1-clabbe@baylibre.com> <20221114073736.672194-2-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 14. November 2022 08:37:35 CET Corentin Labbe wrote:
> The CH348 is an USB octo port serial adapter.
> This patch adds support for it.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/usb/serial/Kconfig  |   9 +
>  drivers/usb/serial/Makefile |   1 +
>  drivers/usb/serial/ch348.c  | 739 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 749 insertions(+)
>  create mode 100644 drivers/usb/serial/ch348.c
> 

Hello,

Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Tested this on one port at 1.5mbaud/3.3V on a little board I
designed myself, thank you very much for upstreaming this!

I'll try to test more ports connected at the same time in the
coming days, but right now it looks like everything is working
as it should.

Regards,
Nicolas Frattaroli


