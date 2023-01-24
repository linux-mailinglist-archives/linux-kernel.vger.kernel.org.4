Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC0679480
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjAXJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjAXJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:47:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD7C1258C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:47:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k16so10964272wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LQWReM02pk5ikJk5yBcPaS3tkIFvok/z2z0JtHvtopU=;
        b=qoyzSERFmFhyIyP6/heaKAHeE6FAy2+gEtxAebubzUKyJZRM3MM0NDPU/KfZGTx8ie
         BKfX4RGrNbCCa1MuFdpjUnbg4j4uOAbv3N2sm6KwWEaRE8P9BCwSp3iV6+wbUAwXZxYl
         Qb42xKL1IcUHQ+H5BUaYZD3FcLF1HRxwsJTTGSFDlIRT4HolpezC0+3s4dyK7xGpBqI3
         dVX5KrC5kb8koemtnwdrrbdGCyr1J9e8ESrI+v7oppxZnktRgVImp8BkTC6TS8UHMOlW
         ugPVYiVyTOdU+RcpOXVXsS2Xuk+7v+1stsaafH3K10nu4oonpyBJhPWYuuNFi03lUBGF
         SJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQWReM02pk5ikJk5yBcPaS3tkIFvok/z2z0JtHvtopU=;
        b=W1lmnRuGg2baaUhfiy+lOBOwZU2ExdHP2FNUi6oActDFLFfAsqYdfttpehaH4zSMGo
         Vdditwwh5oVnfdymfIv7wo3JPPgd71a0m729x/PnqAuXl5RsnD3TBgZ3Gb/zxjN83hh3
         QibPxE40qyCNHl6AiknyutJ2CTuEfp4efOptfwEsEzCKuFJpY+ipgQ6M1COcAy5T+LDH
         P1LE803ap8sCPnuCfgw9PBm5/UqGpIIGya8hvDCxoOqgMvp/VheV4Oc+IQwXMTEuyCvi
         l5Mp7a/K9fxFPh1YNK4Mu4hgb7QbWcQwH/X6vqD3vsORWuKXBMMPzY90+z/C0Sygyr6w
         MPHQ==
X-Gm-Message-State: AFqh2kqJbuUDFbul9qT0QwZV3aB3O7PlHeUXfHrLayGKNZLJmb0k793O
        omvaUxiKeeugSAQvc2ZsoboVjw==
X-Google-Smtp-Source: AMrXdXttI4ZJMWNbKF3dyf600VKGQhEjUfDrJ+febMWIRS9se2X2zpB56FswpqF3fUDGqYKOFkqjVQ==
X-Received: by 2002:a05:600c:35c1:b0:3d3:5319:b6d3 with SMTP id r1-20020a05600c35c100b003d35319b6d3mr27066611wmq.38.1674553669041;
        Tue, 24 Jan 2023 01:47:49 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id o25-20020a1c7519000000b003daf6e3bc2fsm1631899wmc.1.2023.01.24.01.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 01:47:48 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] input: cpcap-pwrbutton: remove initial kernel-doc notation
In-Reply-To: <20230113063831.16469-1-rdunlap@infradead.org>
References: <20230113063831.16469-1-rdunlap@infradead.org>
Date:   Tue, 24 Jan 2023 10:47:47 +0100
Message-ID: <875ycw2ri4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 22:38, Randy Dunlap <rdunlap@infradead.org> wrote:

> Change the beginning "/**" in the file to "/*" since it is not a
> kernel-doc comment. This prevents a kernel-doc warning:
>
> drivers/input/misc/cpcap-pwrbutton.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * CPCAP Power Button Input Driver
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/misc/cpcap-pwrbutton.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap-pwrbutton.c
> --- a/drivers/input/misc/cpcap-pwrbutton.c
> +++ b/drivers/input/misc/cpcap-pwrbutton.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * CPCAP Power Button Input Driver
>   *
>   * Copyright (C) 2017 Sebastian Reichel <sre@kernel.org>
