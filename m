Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E806050AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJSTpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJSTp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:45:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A518196E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:45:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a13so26854371edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lHVzxAW0Myx4BvpZDl6lwvfbUP44PRXuCP7MMtuAiVI=;
        b=UtBMIKtwURlu+AIhyKa0dRDfGrjTTRQUQjLQKZCSg+a4HRzP/xDzkNpttdD8LnaDkW
         33j5eV/qvBBYvkNvpjDxxrmkEo8zkm4/VFYuqD0EI9nCEVBXNkusFpVLRCtwgy23C5yZ
         ByUO0wq4znTjSoWjpz4060BWXA3+GRvrn1rKmeUn0emIF0PScyM6YvoQCDt/JNrTJO5M
         jGY+Y2+tascVx31Y2rIXMWlCJSga/JTnDtdfUCZYmTfKSgN3bWj6Tv0cnzLwjKgFjkZY
         XQxWCB3XfZMgBJnox325SSMNrusKjcssd2nVlRel9N31D2te9vTUFJiuv35HgBnO8TFj
         G+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHVzxAW0Myx4BvpZDl6lwvfbUP44PRXuCP7MMtuAiVI=;
        b=MsOvER/jtGAONIiHzDI00nVimCZjaZAmXVaIwivJIgSHLYrgKqegGEOYbGsc7P3kO2
         miaFgt2rEHoP7CgIlzl6Q7DqQB5qqMvsTjRdKFdVRcM52cIu3JN3gM8TT9PSzBqYJxMU
         XZqIvdXTpqIMu5vEgAazVWQfBSIfQi9XRtc8rq/NzRkevLusUsPI44AwEKma2Wsxpn+H
         0f3b5TRlyPJ0phefEQvVh3QRdhR/Weyi3JwvIQrEJX5M0lgEn/OLmTum4Z6R+mpI+pMa
         GuZqStQ96POXwkA2VFFnVQqgb95leaZIcLtBCz1RPA5GsPSFz1lmm/+RMjAi8slDTbpO
         7vFg==
X-Gm-Message-State: ACrzQf3hMQU20X/sI3Rgf4OZma3dm54P4MbY5VG3L3yTVz/JyIdc4S1Z
        uu8xRNImc2CGsnU6l/5wh8oN8cgnqktF4O9+iAWXlQ==
X-Google-Smtp-Source: AMsMyM4ZhycjOj/WBZK4NwF4b9M8cJ/tdMrZ7Nt1IHTmsjtVRIWgxrNd69fXQz1KvqaPafsm+3d24iWaVqaNRdrTgXk=
X-Received: by 2002:aa7:c98d:0:b0:45c:6451:320e with SMTP id
 c13-20020aa7c98d000000b0045c6451320emr9030375edt.172.1666208724418; Wed, 19
 Oct 2022 12:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221019144119.3848027-1-arnd@kernel.org> <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-12-arnd@kernel.org>
In-Reply-To: <20221019150410.3851944-12-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Oct 2022 21:45:13 +0200
Message-ID: <CACRpkdYA=Yev7NkCTZt7hUMTd1aXe-=HJE_VB=dTG9piR8HkXg@mail.gmail.com>
Subject: Re: [PATCH 12/17] ARM: footbridge: remove CATS
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:15 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Nobody seems to have a CATS machine any more, so remove
> it now, leaving only NetWinder and EBSA285.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

(IIRC the EBSA285 was the machine that David Rusling distributed
to a few Arm developers when he initiated OSS activities at Digital.)

Yours,
Linus Walleij
