Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B125F624930
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiKJSQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiKJSQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:16:45 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB563FB9E;
        Thu, 10 Nov 2022 10:16:45 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z6so1400324qtv.5;
        Thu, 10 Nov 2022 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Z58AeNmEAdanH7tqm9VK4MJyz0UdkwvRESSSnvfEpM=;
        b=KAXLSE5a4V5UyLE5YM6SIkQBfZn/oVuUzWW2uhj5M57quPU28CfiN7PES3b5ZE1kVf
         QcGHBhKhRGGdGEo1R9P1o0oMD5NrRsqGZDGgdZhhaDmBa/BZFmODrAMz3WIds/eFGlhF
         jsB3VTddkTpROmNy9nQv88M3yVJ4HrITu4UJt+AlZYsZ/bWD0NP28/+3JvAkaB8pKEEi
         ddG8pykKIGcDat4d+1+qvvEi3s86NM7QeY0qRt/Xwy2I2h3e//PJ4FVBnTEjIUjmx3x8
         JOWPHrSm7l16JBMEfUUY4zmDkNBXeDY4lp4TPVu7mMl50dT4QIHqvYaPIM18mHAq2+fu
         sjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z58AeNmEAdanH7tqm9VK4MJyz0UdkwvRESSSnvfEpM=;
        b=7DBwdOxqrNxSXrDjz5ikTED53hj/qUoe4vxkFuZaAYMqCwETV18BN2uv0fyHs6IwXU
         JjQrb4sfmJ+NtXsbjI6MJwxuoSFhfEaIUdgdgJl2IbDtFT+RC4TDgesyEZcJ7/b5AKbz
         VGtOZzHIFRCqKx3HVESfFFB5KKts58IMb4880taUkRFjZ4PdUr5uC+d8OYH7LhUxc6Q3
         Ig9OqurOAEnKIMm6fhHiZB//cpIfZh85lxt8R4s9wr56G8Rsz6jOOnyunTS3UdpMzoE7
         Iw3FiOFaoTKPorWlXO0ZgxOCKqYOhpNvU2gGSrreEZ/cj2DTbUu7djhyV0zdhsCMQqwy
         a2oQ==
X-Gm-Message-State: ACrzQf309rxZhdHxQ7lclqi5Vj2YxtVdHlhw4PHf7pbbZ0OblzmTYIpm
        c8/co5SoCdsmbTLfAQ6Til8=
X-Google-Smtp-Source: AMsMyM6VS+5W7e6THCwLUKPHdeenKMZPByMDE7O71Tc9hZGg65Rp02R9T30RbYbmZ1D+AONQnKkiYA==
X-Received: by 2002:ac8:5d8a:0:b0:39c:d3a8:3f91 with SMTP id d10-20020ac85d8a000000b0039cd3a83f91mr52653557qtx.324.1668104204297;
        Thu, 10 Nov 2022 10:16:44 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fd7-20020a05622a4d0700b0039a372fbaa5sm11586504qtb.69.2022.11.10.10.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:16:43 -0800 (PST)
Message-ID: <a843cb62-ea72-74b6-589b-9db98477f169@gmail.com>
Date:   Thu, 10 Nov 2022 10:16:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/2] ARM: dts: bcm283x: Switch to firmware clocks for
 Pi0-3
To:     maxime@cerno.tech, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Dom Cobley <dom@raspberrypi.com>
References: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech>
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 06:17, maxime@cerno.tech wrote:
> Hi,
> 
> Over the years, the differences between the Pi0-3 and the Pi4 created a bunch
> of issues in the KMS driver that trace back to the policy differences between
> the clk-bcm2835 and clk-raspberrypi drivers.
> 
> Instead of piling hacks over hacks to work around those differences, let's just
> follow what downstream is doing and use the clk-raspberrypi for all the KMS
> related devices.
> 
> Let me know what you think,

Maxime, please fix your git configuration such that the author of the 
patches is:

Maxime Ripard <maxime@cerno.tech>

and not:

maxime@cerno.tech

which git am then translates into maxime@cerno.tech <maxime@cerno.tech>

causing the email vs. author checks to fail on my end (and then in 
linux-next).

Thanks!
-- 
Florian

