Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224B160FCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiJ0QTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiJ0QSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:18:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D718E2AF;
        Thu, 27 Oct 2022 09:18:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x26so1343442qki.0;
        Thu, 27 Oct 2022 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xBCapLuegy5t6LeNmW/iLXMOnO1TWAslQw9kSN5ZQE=;
        b=cYNEY/42iuBJiY48wnREorcd6CF1qdMuC9l0BGaMTmIzJmOpZDj8jfi+mhojx+L1WS
         WS9YCcgihsE/BCTOIDugnV9OV0C81mkh3wDxHXkLH/0+MM8F1DurFp7nv0bikq1z2x7Q
         U8A26L+WFHPikV0tko+cWgsM1+y1lbCznEyld8C6KxyGlWVw/FG9hjFOb+YFuDHC/NJQ
         a7Z+ZVMtcfsS9jAtAftdj9n7HxjReB5/Yu+GJk4zx7gtt+mdT7cuLtT1mJssoyqgh8+Q
         wOjwGYR6pxp4StcnP/gSbq97kZ1bWdJgb8961jjbEMPz7/JDVRH4Qx29QBrbfWKss5rf
         /T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xBCapLuegy5t6LeNmW/iLXMOnO1TWAslQw9kSN5ZQE=;
        b=27mXMPKhxy6ogd3xYeWTls/a1DqRFUoJSXr/e4clMquAEStgyBLSZdiYkZafcOX/Tn
         wA2Fr1M0zKQszciHWxSvxfqYrBsN4IF0UdilQ8XvXdxKXmlM0y2eOI8uVyAUM7Hp5kig
         yu/s83ExvGsiPYPx4h1HdaS/1OHex8hHrLm6iHOYgZSvYjlR/4+JlhMkrh30RABs2pnh
         0+mr53qmbymH66b5e20oSKmt0rokXZ2J5xjVuXtZL8nHi5C2gOgp3iMYnYWmSc4/DTMy
         KIKGK6TUB5SHu/q78ECRWVM7j6veNUx47BuhkFP7auV1sBlXTggUG097JaMxSzaTJeQ2
         8SWw==
X-Gm-Message-State: ACrzQf1xBZ8pwfNracCKe8nNERD96yP6tsaUcgkNwRqf2XGaX/3SqZmX
        rbtFTr32HaitmMqTW3/xCBc=
X-Google-Smtp-Source: AMsMyM7y6pBhRWHyk3gEP/quq0Bt5hzt68CLUdXsusst9fyCc+DeqkZuiYXsme1R8nfvw0hHU/LDaw==
X-Received: by 2002:a37:40f:0:b0:6f8:e1c1:9630 with SMTP id 15-20020a37040f000000b006f8e1c19630mr7169903qke.710.1666887530696;
        Thu, 27 Oct 2022 09:18:50 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id c17-20020ac85a91000000b00342f8d4d0basm1089183qtc.43.2022.10.27.09.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 09:18:49 -0700 (PDT)
Message-ID: <7fbd1497-cc73-9cfb-7ce5-c86406dc1b04@gmail.com>
Date:   Thu, 27 Oct 2022 09:18:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 0/7] drm/vc4: Fix the core clock behaviour
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>, Ray Jui <rjui@broadcom.com>
References: <20220815-rpi-fix-4k-60-v5-0-fe9e7ac8b111@cerno.tech>
 <20221027145914.jv7krzw6fomffyai@houat>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221027145914.jv7krzw6fomffyai@houat>
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



On 10/27/2022 7:59 AM, Maxime Ripard wrote:
> Hi Florian,
> 
> On Thu, Oct 27, 2022 at 02:52:40PM +0200, Maxime Ripard wrote:
>> Hi,
>>
>> Those patches used to be part of a larger clock fixes series:
>> https://lore.kernel.org/linux-clk/20220715160014.2623107-1-maxime@cerno.tech/
>>
>> However, that series doesn't seem to be getting anywhere, so I've split out
>> these patches that fix a regression that has been there since 5.18 and that
>> prevents the 4k output from working on the RaspberryPi4.
>>
>> Hopefully, we will be able to merge those patches through the DRM tree to avoid
>> any further disruption.
> 
> I intend to get this through drm-misc, but you just gave your
> Reviewed-by on all the firmware patches but the first. Are you ok with
> this? If so, can I add your Acked-by?

I don't feel legitimate on any of those patches, but the firmware part 
is something that I can understand, gave you an Acked-by for patch #3, 
hopefully this allows you to merge through drm-misc now.
-- 
Florian
