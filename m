Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD016C6879
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjCWMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCWMfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:35:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3921EFF6;
        Thu, 23 Mar 2023 05:35:49 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h31so12430418pgl.6;
        Thu, 23 Mar 2023 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679574949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sG86IN3Vdawja4OTBqoAaDLMM3BOtyeRil5sAAAYa64=;
        b=MCd2aKuMluyeMycgMxfOfXwDXdozXv1ihRZOW33fFiVruAoiAWtLyNGnl6cNTBPgXp
         i/P03egxQrgYgCdLv9Gej5SxaQQycqd8PvT0CJa7wc5TYm1qoQpwrbd/SDNK4Xnghi7v
         jEnCXO2veOSvRIuvRtE7hwuHw3mGKTnhZ++jMb9pmGpI8+m/T+qIztVMyOSYy9w69Xc3
         G95Haw4pQeXYCcuq6AG7yQmaVJ/dWmxeR2xcswmu4lQpp3RbUy96zmdHu4zXSI43t4JJ
         0/bGfxZYvQusQPql062GdE+wTJ4oYryyeTiDWIf1DxM45fdd5p2OuMrxplV+V2KSKk6H
         V0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679574949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sG86IN3Vdawja4OTBqoAaDLMM3BOtyeRil5sAAAYa64=;
        b=6N2wls2uNS/1r90brd8qaG2PpIgF39nISuvLfAmBCu99k7hl3Zq01WG5iPZCJ3IkE4
         YmIqXTRyspHgW6mrUQdtEsHx+DBapPskxkMmrhjQ0zhtUMhD9y1PgkrPI4p3LjkRzpB7
         1LXfbibxJPsjsdGHXKav7Dy+wDuhVowst83x1TBfIQ2eZyWar34bb/VxIJFKYo36eUOW
         BR2y3fdJGpl3uSHxyP413DHXwH9ywvnV8UsyyQsRCqAXMEjFCRD+J00hC+0J11E/B+XV
         zIPPYRMiuWxdKKS/ahAewKcHnG/QjuyOoolqgtNxBbTRrP5r9bBcV8HuUQ9FG0fcpW/H
         u/5w==
X-Gm-Message-State: AO0yUKXYd2V8d2y73wo9VTNC287jlmHvpqouwAhwL82D53ciZG0WPCnV
        nT62LWryyB7rzO0PUbRypJU=
X-Google-Smtp-Source: AK7set9BVqV8PjBMAXZJ191R5TCitQaa6ikl1gIzN0x3OiW36GBmgTQUJOqoJoSAPKIdMPo+We9ROA==
X-Received: by 2002:aa7:954a:0:b0:628:642:c533 with SMTP id w10-20020aa7954a000000b006280642c533mr7091222pfq.31.1679574949055;
        Thu, 23 Mar 2023 05:35:49 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-43.three.co.id. [116.206.12.43])
        by smtp.gmail.com with ESMTPSA id w4-20020a654104000000b0049f5da82b12sm11359254pgp.93.2023.03.23.05.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 05:35:48 -0700 (PDT)
Message-ID: <da9d9bca-23d5-aaa8-a815-5a9421c05a3d@gmail.com>
Date:   Thu, 23 Mar 2023 19:35:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] Documentation fixes for MT6370 RGB
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux MediaTek <linux-mediatek@lists.infradead.org>,
        Linux LEDs <linux-leds@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>
References: <20230319074903.13075-1-bagasdotme@gmail.com>
 <2b8667b5-ea54-2ef4-f069-a86acd28ecea@gmail.com>
 <20230323123156.GL2673958@google.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230323123156.GL2673958@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/23 19:31, Lee Jones wrote:
>> ping
> 
> a) Don't do that!
> 
> b) Especually don't do that 4 days after submission!
> 
> The usual expectation is 2 full weeks before submitting a [RESEND].
> 
> Mark Brown says it best:
> 
> "
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be addressed.
> 
> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there are
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.
> "
> 

Ah! I triggered the wrong message at the wrong time. Thanks anyway!

-- 
An old man doll... just what I always wanted! - Clara

