Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630DD6E0129
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjDLVtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDLVsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:48:55 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCAC7AAD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:48:54 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id fv6so962220qtb.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681336133; x=1683928133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXN+Y8z0sBhaT/hk/KaE/qukBJuYuOXB2JF4ebCC80c=;
        b=ApQt/vvU9OlwfbStYK6vQpUvUPs7kbbwWvaW+TI7mlJINWl7d4UaGg8dM+KYinnF/t
         nvifFBdM5F0Up55nAqc/ifhr8K3AB/68VfqSYnCRRHlL1KqHpXW/1wlX+JOVYGTQ+oBo
         DcMdOavDraEq+CXHyY58Gt/HBcSiwbK5v1si/YpvQNU8EcrkNgLayVXr8EcbfDgR4c60
         Iv3R2R+/oVQljm3gV23H3mEUdgpKV0b4giSE+tOcD9Pcy2fd2piZM+EojQo0RDQ4WFhV
         y3YO9RKR6+ST5HhWP5N9+Mgtf3SCGKaC0jB5knOhejhjouUwHFwjOCMw7rwpJhWh5YmW
         4TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336133; x=1683928133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXN+Y8z0sBhaT/hk/KaE/qukBJuYuOXB2JF4ebCC80c=;
        b=hyJEOz4DRCLqlHyhsh/mLL7ht5lGT5PM86U+El2IFMYMg65IC8fz3jdTdkGvMAWoLc
         q37NY3VHjtTs0Eyiaq/j5tPqHgs/EKHPrz2QVvH8cUsIeU0sSMGpyYui8rcBtQLs0ZOY
         bYui36AH60WmWlRoVtRrL2s+DCRD7FFNCqpEmB2fgY3/9dCB7ecnQ9Z24qod21f/2Shi
         3+/QZwbFo0yQBkeOYwjrbd6xXH5K+6PpCkdPCuW6egmnMSskbYcHseA65hB/tb8ZQCXQ
         WjgMq2vcprl7+/eSdm9QkSZsArWQ8ph93Xrla2e7679Ndod3/4Tni3iMfwKonO0fN777
         bwqA==
X-Gm-Message-State: AAQBX9e6y6QsGRK+rHbR3da+RrwCa1XSoSMbAMg16WW2IKRU0qLCEu3t
        4P0c6HuPidAwRg5/Bi43DEo=
X-Google-Smtp-Source: AKy350ZQbOIzJl8oWcF/bs8xXesve81tuszHPQjx96xheLSHXm/gSCcl5DgLtEGMWbE320oDCK0P3Q==
X-Received: by 2002:ac8:7d45:0:b0:3de:6d89:adb1 with SMTP id h5-20020ac87d45000000b003de6d89adb1mr6340347qtb.20.1681336133455;
        Wed, 12 Apr 2023 14:48:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b77-20020ae9eb50000000b0074ac9a6b163sm511564qkg.26.2023.04.12.14.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 14:48:52 -0700 (PDT)
Message-ID: <7a9ce430-a2af-587f-1598-5dcc43b20766@gmail.com>
Date:   Wed, 12 Apr 2023 14:48:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] ARM: compressed: Bump MALLOC_SIZE to 128 KiB
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <20230412212126.3966502-1-j.neuschaefer@gmx.net>
 <20230412212126.3966502-3-j.neuschaefer@gmx.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230412212126.3966502-3-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 14:21, Jonathan Neuschäfer wrote:
> The ZSTD compressor needs about 100 KiB.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

