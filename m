Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161D868F62C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjBHRyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjBHRyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:54:41 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3086AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:54:40 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b16so12498050ljr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BpljMohL8GLL9JNNZm5TNh7NQliOwfqEEgvKA1M8vPA=;
        b=iSJy452+yQNDkj/XRpSJtdvrqV4Nc9SHmDUlIPEMcI7FsTBkg180jQi1F8xp6YW1iB
         x+n5zVe4ua33Iptv3+3hIXXVPzCDMsaE+aiY5ZioYXS2QK7YcFrDLdAp2jdyqNCNAiuB
         jOEvyRlDxjvya+Oe6QZshDBs21k3QFl/D0kQ9C/WADLHUUR3m08hnMM5D5Fh2ivALyk/
         MfyowyYvxCwIcJkZ8wjZ8+6pip+4HEgfvld60+W6Z8mMTEGB2wvoc+UcpG17rGgizxEB
         3jdEH391M/2wSjYcYiPL4nNwuw3AUeWO4FlI+ZrKLIUg3rr1b9AQb/hWfziar7N1D7kJ
         2C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpljMohL8GLL9JNNZm5TNh7NQliOwfqEEgvKA1M8vPA=;
        b=2JOlJehuswqj0ZX79muy0/tJjnc2cFAvlx8SYEwLZt0MdFy+W84MUZnjwvFA3MnNie
         zQvMVVhdPmhxC/2E0fylfS9wj92VaBljRgFSXbnqhsK9W/R5/kVKQ6VWKSbq6Fl6RRt2
         M1r9yRFWIRBIf536R9t9KbiJUrPX7vW5mpZ41KCXEiN6PghKqSiYtO6Q+idugal+l41f
         Gw0wycfJvqRf/p3TklqQWdAijcc3fanxHsmcGR1nHn2ewrLTyWJBByr3qt3hyi9Ob+mI
         FYYp9Ao+pq4n/FAa1ea+DiJCOCduaBOZl1dlUdmgifGhfDWMjsm3MshtRgMZXNeR1HNv
         mjVQ==
X-Gm-Message-State: AO0yUKXKZNk9IC/sqw4f2dKu5ZBpHOPoaiWFs0a0z3/t5SgWu7og7inf
        tIuPBlKNQr8+qul7RohmbUecVVu0kTxqZua6
X-Google-Smtp-Source: AK7set/lK0dtz8rcHRt03yyNK2Vwc1Fz232Sf6dsRanegcNrGJ8x6yT7AAkYHUf260eQ8ib742Kj5Q==
X-Received: by 2002:adf:f212:0:b0:2c3:dbe0:58ea with SMTP id p18-20020adff212000000b002c3dbe058eamr8107790wro.47.1675877957261;
        Wed, 08 Feb 2023 09:39:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u10-20020adfdb8a000000b002bfb0c5527esm14273251wri.109.2023.02.08.09.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 09:39:16 -0800 (PST)
Message-ID: <30234963-33e5-e2d7-a6ef-112e89efbdd0@linaro.org>
Date:   Wed, 8 Feb 2023 18:39:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 02/18] ARM: s3c24xx: Use the right include
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Michael Walle <michael@walle.cc>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Keerthy <j-keerthy@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20230208173343.37582-1-andriy.shevchenko@linux.intel.com>
 <20230208173343.37582-3-andriy.shevchenko@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208173343.37582-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 18:33, Andy Shevchenko wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The file s3c64xx.c is including <linux/gpio.h> despite using no
> symbols from the file, however it needs it to implicitly bring in
> of_have_populated_dt() so include <linux/of.h> explicitly instead.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/arm/mach-s3c/s3c64xx.c | 2 +-

It's not s3c24xx anymore, so subject prefix:
ARM: s3c64xx:


Best regards,
Krzysztof

