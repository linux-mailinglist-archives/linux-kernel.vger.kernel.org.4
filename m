Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD07653309
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiLUPPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiLUPPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:15:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3F22B35;
        Wed, 21 Dec 2022 07:15:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so2607776pjp.1;
        Wed, 21 Dec 2022 07:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jc5eDGVyhtibsn5U7Nyazut8bgaj8E3IqiFSQtZt3Go=;
        b=WMDx94ZMr8fHmkJdKn5N9JwmPyJn/vd7jux4NU3S/bIqCxxmrq+lQrn0cdIzXoGJyP
         TPA7TWL07kzis8M6TUWGXMk/HhNHCbrHObFgSW2qLMgVltgeJzFAOogHyXAbBp/ieaM7
         kTGk4d1HP7JiQ8g5RiXZ5QqQPxaETV8GOMfisvRq1hKa+CQnNWKLrM1aDUGgtTKPq/Wt
         Wzr3Thz8xPd3McGlNp25gS8UjO3UWpR2gVq49f0IIuGD/Wv7wKsv7hzugA/4YScXTj/x
         toDkxJqBeZFlGG1cxAg/uuzn4xYUeEldDJ2TAgA7zPeRESb7ggJSkKlWfQ93xd33yKxd
         bBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc5eDGVyhtibsn5U7Nyazut8bgaj8E3IqiFSQtZt3Go=;
        b=anWhUwQKhhqZnymnjLR1e+q4M+0hKCHQQo5LrGzklhQ62MFcUFA1A1UsSFzGqIOIoj
         tIR5QPbYF+DXzIT6OlJZF5FMBfgoBJ6LG/+b9O/n3aCyL9tJ8LvBj60TGr+8KiWMedfV
         RMsJIv+rh47Y09hwOJhuvazWsALoDoZuGOw3TtbjDBbtvJL0XAFzdIZZvymunSSFwH1v
         uBU4gG/UxbMUI2Qv9zOGfQzmj0AfxOkFkIGHlp8qIV+IRpu79x1CFncTjSs2Q3QQTMvQ
         dvcoJ6wJf1beRIwipd8gjbDWcQ7VdIpe7ZmhW8gOh5ibnG4UO1rUtp/oOfPX0xf2eTvo
         Pbnw==
X-Gm-Message-State: AFqh2kq1l2Mgaw367EVNV3JckVLbbDmJ5iSyi1AyK7KmO1uQA2xzx+vh
        IA1JU/8SBcG/x9LbSDreRymcJz5Fgq4tjuYI
X-Google-Smtp-Source: AMrXdXsZQBNI25Ae9BLGieRQCGxuijBT8Y+qKP1egliNdCifxno+Ad6aNK32701OvgBVXGMrXlN8YQ==
X-Received: by 2002:a17:902:74cc:b0:191:4149:27f6 with SMTP id f12-20020a17090274cc00b00191414927f6mr2602255plt.37.1671635735060;
        Wed, 21 Dec 2022 07:15:35 -0800 (PST)
Received: from Gentoo ([45.62.172.3])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b0018997f6fc88sm11608550plf.34.2022.12.21.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:15:34 -0800 (PST)
Date:   Wed, 21 Dec 2022 23:15:27 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RESEND] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Message-ID: <Y6MjDxxi8CunFLmM@Gentoo>
References: <20221221132428.702-1-lujianhua000@gmail.com>
 <4c37d74d-aaa2-242f-a25f-bf5f92d50756@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c37d74d-aaa2-242f-a25f-bf5f92d50756@linaro.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 04:03:44PM +0100, Krzysztof Kozlowski wrote:
> On 21/12/2022 14:24, Jianhua Lu wrote:
> > Add Kinetic KTZ8866 backlight binding documentation.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> 
> Do not resend. You need to fix everything, test and send a new patchset
> (entire) with the changelog.

Ok, I got it. I was just a bit confused about "Need to resend with proper
thread".
> 
> Best regards,
> Krzysztof
> 
