Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541FB6C2C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCUIez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCUIeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:34:24 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E7559CB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:33:32 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5416b0ab0ecso267856457b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1679387611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KB6vuc81jSSkKnMxrZTvHvPKSRtY1MligJPcYjgonTw=;
        b=L854542Of25QQ3JVGYZn6a0AB9OOdy/B3vOuhkEK5OAKN4+xODvce3FBD1g8PSV1nD
         PqyMVQ8WlCcy63cRosAHpzwvRh3bckIgDVOVhlRww5TSKtt4WgapFm5Y9wgl41WSVTAd
         620aYogY8pRdmc8ttv103/JZ3il6bJWNu6kWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679387611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KB6vuc81jSSkKnMxrZTvHvPKSRtY1MligJPcYjgonTw=;
        b=Y2Fa/9oM6XFJcj+wwXTlc7DpqX6AJK+Qu1r+IX0KIw/Yd2fxPxHrtR0BuloZm7BCGK
         z+XFDhnfZPtHFQXv5BPZ5nkHsp/fpgHhNrs6FhtsoAzAVIF9tGA9GESIzob6ja0TvHQx
         +gqHnzr3P7mlu+6zmCZqDLlRIJrEigf1c9+AFPvowJhfDenmUfUXOzPIbL0bHOOvH34/
         iwwCLEaOYENqCFGd/5qBa8hGkpc6LbOlKcW8wA3vkyJt9kwM9TTCDmtzimPze5nWQqjv
         6b7oEvFfl/r2BM/r8Rq/QMOUUn4eZcAASJ6zERHs1cSkMW/r/RxoKSWrST8SJfmSutuY
         el5Q==
X-Gm-Message-State: AAQBX9dC1rhx1wts9ZykJqCjROaP22X2dB8ZFc/gwyRXCz+/XOPgyez/
        CMJ4+hpkJjsjzTNGOe4jdlt9nDi/a8jAJuVJhMxA4A==
X-Google-Smtp-Source: AKy350ayh3kL/5wMU+1FJfsQfBzUOLJnlM6KS2hGz9x37v9qA1HJCUgNxeaBqW+vqDU/KvLwNjxHef4Xv3FGx8lBXeY=
X-Received: by 2002:a81:af50:0:b0:541:85d2:af21 with SMTP id
 x16-20020a81af50000000b0054185d2af21mr582975ywj.5.1679387609813; Tue, 21 Mar
 2023 01:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230321033810.22017-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230321033810.22017-1-lukas.bulwahn@gmail.com>
From:   Daniel Palmer <daniel@thingy.jp>
Date:   Tue, 21 Mar 2023 17:33:19 +0900
Message-ID: <CAFr9PXmKsequA3V7QWC2fKQYZgaNRj+q3q=UOBLmg6wxYKiVYg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mstar: remove unused config MACH_MERCURY
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas

On Tue, 21 Mar 2023 at 12:38, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 312b62b6610c ("ARM: mstar: Add machine for MStar/Sigmastar Armv7
> SoCs") adds the config MACH_INFINITY and MACH_MERCURY. The MACH_INFINITY
> config is used in the gpio-msc313 driver, but the MACH_MERCURY config is
> never used to configure anything in the kernel tree.
>
> Remove the unused config MACH_MERCURY.

Because work is still on going to push that stuff.

nak from me.

Thanks,

Daniel
