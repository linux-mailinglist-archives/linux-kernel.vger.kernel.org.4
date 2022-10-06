Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA2E5F61DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJFHpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJFHpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:45:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8BED11E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:44:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a3so1390594wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vg5fdSt27nju1YMu90IaQhVCaYqVeP3Zg+AYyVq4Pjc=;
        b=PSc6ddZVvE790in4dRYAuLE0lPuvpcAx2b1za+kxfMbWpzp3LwLnmOqOPKnfuNulsn
         IC9ad3UrKRaztIHCztqH9a4/s8p9iFGdTcrDf8QjSNCLOphYliA2I/gzN7ImHCM9/vh7
         j4yOG2ZHccLYozuqez4EbJWsarkmHQHMbxUIlg45iO5ErS0C8VBxkc+3ZP+P2RmUFvH+
         WCHyW9UzUSHdGzh7+D9wGEcZKnhgl3pucs5CXjvIlJIA/tsCzJQ+WYazOj7S8fEtkcYJ
         nsw3UHh8GpAYBx2LhK344xNL0e2bRmYx8i0UsNc7SNup9rXXo9qBLElp3SRupMZYOtGs
         8zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg5fdSt27nju1YMu90IaQhVCaYqVeP3Zg+AYyVq4Pjc=;
        b=oF+pHX17BUpgzBkRUguGoCbZK+rxGdR2ar3G8HSpuRV7NNbtx2jMHljNYX/7aKzY1b
         6hp3YGTOtg4v+gX8LcZWo3un7oCfL7KESs2at+etqD2UbdytoWdtMQC6Jkp0/YF8p6AO
         1Y7n9ACTmHpO5e4EEcs5FKJ9Z8nUgA+f9Z8yFXhHKS5/QLBU4DxcGM8pqegTEcLnvymT
         LrcrUncAJQ/UO/25OeR6zeZiGDnuYlwGSWORibcGMrKE8VkIPc2SDWZfwF2SBD832ohd
         SY085hHQuEn2wLDbUMH4e+tqReHnhKAGzzSufYwZKiiuQ6R2zyaWaZy7ainhGRhXiSt0
         ayMw==
X-Gm-Message-State: ACrzQf1KCng5haIUXl2JXcbDl63nD1Q9qPOOrSBPVYAOiDz7tCWscgP3
        M66RTcAcRTXsU5d+3DwtSglmAA==
X-Google-Smtp-Source: AMsMyM6c3VcQe/nko6DkvyvFj6l25XRIFM2fyt+46cK+0EkLGtTUkO+EjLi3+vwckzGSwWe9WswpLg==
X-Received: by 2002:a05:6000:154a:b0:22a:b8eb:ba53 with SMTP id 10-20020a056000154a00b0022ab8ebba53mr2115976wry.594.1665042297819;
        Thu, 06 Oct 2022 00:44:57 -0700 (PDT)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id m24-20020adfa3d8000000b0022ae401e9e0sm17535879wrb.78.2022.10.06.00.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:44:57 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: dlink-dir685-touchkeys: Make array bl_data
 static const
In-Reply-To: <20221005154852.320056-1-colin.i.king@gmail.com>
References: <20221005154852.320056-1-colin.i.king@gmail.com>
Date:   Thu, 06 Oct 2022 09:44:56 +0200
Message-ID: <87a669o0p3.fsf@baylibre.com>
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

On Wed, Oct 05, 2022 at 16:48, Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only array bl_data on the stack but instead
> make it static const. Also makes the object code a little smaller.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/keyboard/dlink-dir685-touchkeys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/dlink-dir685-touchkeys.c b/drivers/input/keyboard/dlink-dir685-touchkeys.c
> index a69dcc3bd30c..7db7fb175869 100644
> --- a/drivers/input/keyboard/dlink-dir685-touchkeys.c
> +++ b/drivers/input/keyboard/dlink-dir685-touchkeys.c
> @@ -64,7 +64,7 @@ static int dir685_tk_probe(struct i2c_client *client,
>  {
>  	struct dir685_touchkeys *tk;
>  	struct device *dev = &client->dev;
> -	u8 bl_data[] = { 0xa7, 0x40 };
> +	static const u8 bl_data[] = { 0xa7, 0x40 };
>  	int err;
>  	int i;
>  
> -- 
> 2.37.3
