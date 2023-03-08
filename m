Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C46B027D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCHJLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCHJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:11:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FB626878
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:11:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j11so43326589edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 01:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678266692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0oj0CL9BnYfLK0x4oHfSTBQkmbarC+Cjqy+nmwt32k=;
        b=m+2ObWsq3KZvPh3aNkl9jgASVbIpqkjqajI/6hkr+tPloWdmjmj8seF+Px2aK83De/
         r6vGzZGYt/MAc+xDBI8YHUf69PaLWKFPGlLlEqrnkPSADoaW3IEIfSxeKH2QG1RgHpRx
         AQJee+dnKflfnQJM3zqi2/13VvHwc5xPGvzyZMm8OZWETk0OFmDJPdO1I9IeB/SBqY3U
         OLSiW+5POHuS32oM5sBWwFG92uIRW1KZGcZ6ZFsTbwC3zG/hDlkwh53FG/iQG5ZrPkLu
         AeTq1N3dUceBt5mrWzxUu1x+mEU+UlidNQCW0TwWiYknmA0gLdC+r07fHjCg6KnOhpxq
         MNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0oj0CL9BnYfLK0x4oHfSTBQkmbarC+Cjqy+nmwt32k=;
        b=ScmYgGFcQ9N+NBWI7YZeoZ4u4G3QFuapYShvBUBvz/2696+vNIPo+ZsGrG0lhtTfVq
         xw7XHlfq6JyBWK1VcBX69CsGqQunUVICR9vCALyjAM+7wg/eqzVrH7QcB0J6Te+vw6FC
         bVTlCZebytaJFCQ+awL1DnaD87IA58NjDNz1J7B8HqP6DmW63t6HfnK9+x0DtMP8fBna
         2bfDCViP+9irhz2I4NzZgwNP30fwzQdB2l+6zxwQh4Vd2eTmqG/wDDeFVe0OPDpxLfYB
         OwyHf+5HZtAYvWfaww7F4vIohujytS7qr0KZQOrqfNUZRBMgjycisHrFAlcGikdoPeAs
         nNfA==
X-Gm-Message-State: AO0yUKV2myTfSkML4lykijbaO9TwAOdNrOlAWg3TXMrk+P1Sq0hIzCBf
        IDI/oBFF6EA3sKwDFRq52sUEurvtpNk+HG4O46o=
X-Google-Smtp-Source: AK7set8xfEE2t6/kA5+l3xnMif2Y54F6J/auVV+63fsbrgL+aso/6KzHSF5zoMep8m9pWUtcI1o4FQ==
X-Received: by 2002:a05:6402:b1c:b0:4bc:b40:108b with SMTP id bm28-20020a0564020b1c00b004bc0b40108bmr15775258edb.9.1678266692627;
        Wed, 08 Mar 2023 01:11:32 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:bba:fbfa:8aec:a133? ([2a02:810d:15c0:828:bba:fbfa:8aec:a133])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090657cf00b008eaf99be56esm7308458ejr.170.2023.03.08.01.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 01:11:32 -0800 (PST)
Message-ID: <190897d3-39b6-fb7c-dc18-dac580fadea6@linaro.org>
Date:   Wed, 8 Mar 2023 10:11:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20230308083759.11692-1-clamor95@gmail.com>
 <f1df5968-4322-3f67-3da8-c10ea50386a8@linaro.org>
 <CAPVz0n24odz4bxt8nRe08-UJFoaDSTGMAPfj2b2RBG+ZbwntfQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n24odz4bxt8nRe08-UJFoaDSTGMAPfj2b2RBG+ZbwntfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 09:58, Svyatoslav Ryhel wrote:
> I would love to, but max77663 uses max77686 rtc
> https://github.com/torvalds/linux/blob/master/drivers/mfd/max77620.c#L123
> how to handle this?

Don't top post.

Hm, so it seems max7763 is already documented via max77620. I missed
that. Add the new property to max77620, not to max77686 RTC. It does not
look like RTC's property, but the PMIC's.

Best regards,
Krzysztof

