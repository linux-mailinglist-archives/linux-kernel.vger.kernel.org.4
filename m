Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8572E060
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbjFMLHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbjFMLHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:07:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1679F92;
        Tue, 13 Jun 2023 04:07:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f649db9b25so6514754e87.0;
        Tue, 13 Jun 2023 04:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686654467; x=1689246467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMLq5ZKnOotflytIe0mnOvtlGzHkJVwDm5cQgBrjDI4=;
        b=iCJ1+VBIcCa0IQhLHm5WTeNdJd0fHzpUwLgjc1ENNZgKyHY+j0ATlLbQRGYoyRYYyQ
         NvohUxbPcJCELP804PiZdA5OtlxXar4dJFcugYHdDqxd0gSUIIG0F6JyLw83nYu18ud7
         vhZOkZrGuJbDUyx9KCGiBXPaiSowTnG1tzdXlds7654aftB27aqxexqVRRc+vKPQenT8
         8JJHnZ5GGX5QZPsMS27KxSoS7KQyQ7tyk2WMuC2hgMmUrVojHyXU0YisyO7qEMVbxi94
         eh/oei01nm8v5HzqDhNQVqEIZcnCc3epO6XHf5pRkPqdqBotTlaXGS4vagRop/li4gM1
         IumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686654467; x=1689246467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMLq5ZKnOotflytIe0mnOvtlGzHkJVwDm5cQgBrjDI4=;
        b=WWkOGbdQRCpzFjl9+8rLZ+50jD7Jva7GsfOnvTGCO9T2gtsRdDeNrYo34HBLfVGwrT
         HTVt3a8AiREvdTL2LqkpDaNQEJ8lBRvuukSmRrU/lvau0PzczubemsgYzitQ/V8IhqNm
         fB2CZUD891kxUWYPrpJJJELBmJaiLKAfFFPeAT6j8tdQRMsIA7bOD7bKF4M42JJFWaS5
         Ti6OJ3BSsOYiUgYnotuMCi1qPgEMr55aAtSwRfQh/MaKN7/fJygzaCKrFJ5DlXmc9bW3
         bZYsmmeemREwdxSrP6SegN7R/C6N0MmVN/Zn90YDjOEE3mdTWjVqbTJeas8/UtmhrZ9f
         DvBA==
X-Gm-Message-State: AC+VfDxHoz3PYVSOmhnCOd7p5xlJm3c9DnK+h478DLGPbwKBbrJi/FNc
        GFNocHzeqdjSKfg8c3c0OUc=
X-Google-Smtp-Source: ACHHUZ43Wa1EdI+5u9WIpgfGyFc4fBnHPo2pGr+dBe96w8Shf3M7NUarBauQZ2f/MUqhV18d+uRwjg==
X-Received: by 2002:a19:655d:0:b0:4f0:181:5a14 with SMTP id c29-20020a19655d000000b004f001815a14mr6473731lfj.21.1686654467086;
        Tue, 13 Jun 2023 04:07:47 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2598f000000b004f138ecab11sm1764526lfn.24.2023.06.13.04.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:07:46 -0700 (PDT)
Message-ID: <81d81060-ad96-3376-f17c-792a3c12ba1d@gmail.com>
Date:   Tue, 13 Jun 2023 14:07:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 5/7] iio: accel: kionix-kx022a: Refactor driver and add
 chip_info structure
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
 <5c2bf9da15127e0c74bbbf71a44982e667b57e34.1686651032.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <5c2bf9da15127e0c74bbbf71a44982e667b57e34.1686651032.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 13:22, Mehdi Djait wrote:
> Add the chip_info structure to the driver's private data to hold all
> the device specific infos.
> Refactor the kx022a driver implementation to make it more generic and
> extensible.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

