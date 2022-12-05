Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186C1643802
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiLEWYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiLEWYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:24:20 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAC3B4B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 14:24:16 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id n184so16141410yba.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 14:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26JZLWDgNrzczDfh9mjgOtdg3XGCLUwKF6YgBctcQ9g=;
        b=OoqsWBlzyFjAHq6ezGJ6I4NMxATUWrPDUhEeWFdsF8xXFrVe5sLY5us4Vg0xd2TrUE
         kYPnVBTZf2sYfyebF6kvFQbes6RS5GP2erpmKD+n/F6aWi6k7ODI5FQQbLsVP2TtyaXC
         3i3UEcd1ivwaml9dDE4c9SopUa92VYzBIzsX1D9kc8A2zc4qDi8IGy/uvXI1T2xpy4cd
         349pNIZZMA4tuv7R5C755NL06TZh8faHxfBiI8ulJIrQE8AJ5/otw46ETZ9IO+LDWBEv
         CKmmT0Zmdu86G3lnu46blDq3/ayTd79TSzTYi9X6Gv5R1zTaeI0XzJvBLpBPHc7cPxTy
         Bb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26JZLWDgNrzczDfh9mjgOtdg3XGCLUwKF6YgBctcQ9g=;
        b=NxcZI8ueigJRZSeyst9otyCWd13ut9cfRA/ALF9lnHn5L6KUNt4HlH3ZrDry3gaz+5
         MfbY7+FVmQZ/KSBQExilMPPyaBfB7ujnghr5Lp4mQPxwOboq3O62y7rrRypY6bpUS7Cd
         GiQ9t72gMQMrIufzDXVJVp3gmuwjmb8BLva2SMCPvxUg+j6M2i1CzdYkscCNBQnCqfad
         6bYtjBzBe4Zzi6C1TU3sJ0/eL1UEHNTZ5rSd9Wuf22BVMntZ3DWUjbCCf3wCTTIwOFAv
         FXIoUyayx0yCVFtHUt8EvuxHa5fPpFUSrT0kcVrQr8M0ImQLTOBZxgdVovKkeAx1x10J
         mRmw==
X-Gm-Message-State: ANoB5pkb4xbbB9flfsveuBj2BRqJY8LEdTeoSIq4+nF+vcUSX4JMZGG6
        b6ykY7zo34f2O3lpih/y9jRGD5TcayQX0rax5uaN7Q==
X-Google-Smtp-Source: AA0mqf7OvyqoSrlMOqkJSWrbWFJX3HR5a/WC8bBY8jOJbgoisAHZRYp3vUx27/E2X5hlDCJT1KfRXlvpP4PlPjh4oqg=
X-Received: by 2002:a5b:7c7:0:b0:702:7a86:31e with SMTP id t7-20020a5b07c7000000b007027a86031emr2744513ybq.506.1670279055815;
 Mon, 05 Dec 2022 14:24:15 -0800 (PST)
MIME-Version: 1.0
References: <a989b3b798ecaf3b45f35160e30e605636d66a77.1669044086.git.geert+renesas@glider.be>
In-Reply-To: <a989b3b798ecaf3b45f35160e30e605636d66a77.1669044086.git.geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Dec 2022 23:24:04 +0100
Message-ID: <CACRpkdZPhKT=wjToSiY+iyXk2_WdBZ1hEvmNvQQLJPZGN==-xQ@mail.gmail.com>
Subject: Re: [PATCH] usb: USB_FOTG210 should depend on ARCH_GEMINI
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabian Vogt <fabian@ritter-vogt.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 4:22 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The Faraday Technology FOTG210 USB2 Dual Role Controller is only present
> on Cortina Systems Gemini SoCs.

As it turns out, this is not true. The TI nSpire uses this too, I should have
noted since the nSpire maintainer was patching the driver...
https://lore.kernel.org/linux-usb/20210324141115.9384-1-fabian@ritter-vogt.de/

Shall we revert it or just add another clause for the nSpire?

Yours,
Linus Walleij
