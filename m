Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85EE5F8615
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJHQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJHQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:45:36 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07D731DDB
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 09:45:35 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l5so8782735oif.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ODoHg5S3SuWdWoJ04bn/rz8Q86Z7eQzXH4hoNj/6ZPg=;
        b=FVRUmZJ/JriUCZtTJOtMIMUHW51yML8vYpd3bRYsft2feuDeVyGOs8qBEUfdy3PSMZ
         /O+Fg0rQEcvU2DETmQIbPvzWQIxoit1mX6XJQqQ8coDBp9UqQauqMq8LggrzHs9OmXJS
         Wx68eO3avN3h0ddfR8njxb23yXD4PcEIrfM3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODoHg5S3SuWdWoJ04bn/rz8Q86Z7eQzXH4hoNj/6ZPg=;
        b=qNBOHjyZ0ROZhVL22flHVJc/OWxJXWSkM35dNuX4f6npfttDd5fj3RIKjIqwAsVVpg
         nZxfJpEVNQEmFZMDAScxE+ojEzi5x7+86e1pPerrfoquWGkgqiJtnevy4VMioXmumgbh
         aaNuMKtBGX22JCNsuFdMKmdy6XnKlPP/Bq6eiGWYODsc618Ol/Bzt0VFtWWQP/T/qM7f
         Mbsbvs3mopDK3V7srBj/t8thLOZQC6Sc8gdz5G0wJWyzjrfXOX2n5OGR/94QHcnsJk3f
         rP2pwCEUWePL4Jxo7XPBL+1/pcBnIU7rXWIYrpuUpt0CfG+nmesCCyuaS/bQJmd2dB4v
         Punw==
X-Gm-Message-State: ACrzQf3fA+Z+YzAZWzR/pC2wZYahGdbNnXXoNULC9UQnB+qYzybHYYEC
        2WWsTIQkrmMxFv/fMCJ9hsq5PjpUJUiq7Q==
X-Google-Smtp-Source: AMsMyM4FUBDf7T4mjpXOEN9cUC+HqEuGiMB90z/NZ7aPR7zIP0tIpGvuYBx+7703kgxVBtUc1Shdag==
X-Received: by 2002:a05:6808:1708:b0:351:728b:3a03 with SMTP id bc8-20020a056808170800b00351728b3a03mr5296924oib.275.1665247533926;
        Sat, 08 Oct 2022 09:45:33 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com. [209.85.160.49])
        by smtp.gmail.com with ESMTPSA id u19-20020a056870441300b0010d7242b623sm2865223oah.21.2022.10.08.09.45.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 09:45:33 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1324e7a1284so8593769fac.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 09:45:32 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr5350757oad.126.1665247532694; Sat, 08
 Oct 2022 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <Y0GZwkDwnak2ReTt@zx2c4.com> <20221008154700.404837-1-Jason@zx2c4.com>
In-Reply-To: <20221008154700.404837-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Oct 2022 09:45:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqN9EJ6zKXh21EQ2CV-B7_oDJKy73+yhRwtbNMWCzfVA@mail.gmail.com>
Message-ID: <CAHk-=wiqN9EJ6zKXh21EQ2CV-B7_oDJKy73+yhRwtbNMWCzfVA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mfd: syscon: Remove repetition of the regmap_get_val_endian()"
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     arnd@arndb.de, lee@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 8, 2022 at 8:47 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This reverts commit 72a95859728a7866522e6633818bebc1c2519b17. It broke
> reboots on big-endian MIPS and MIPS64 malta QEMU instances, which use
> the syscon driver. Little-endian is not effected, which means likely
> it's important to handle regmap_get_val_endian() in this function after
> all.

Hmm. The revert may indeed be the right thing to do, but we're still
early in the release process, so let's go through the channels.

I do note that commit 72a95859728a points to commit 0dbdb76c0ca8
("regmap: mmio: Parse endianness definitions from DT") as the reason
why it's not necessary any more, but that commit

 (a) doesn't seem to set config->val_format_endian (which somebody may
care about). It does set the operation pointers etc, but doesn't set
that field.

 (b) it uses regmap_get_val_endian(), which doesn't actually even look
at the OF properties unless config->val_format_endian is
REGMAP_ENDIAN_DEFAULT

so the code that commit 72a95859728a removed was actually quite a bit
different from the code in commit 0dbdb76c0ca8.

Maybe the problem is related to those semantic differences, and is
easy to fix for somebody who knows what the heck that stuff is doing.

And if not, please just send me the revert through the normal channels. Ok?

                    Linus
