Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F9A7152F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjE3BUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjE3BUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:20:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED0B0;
        Mon, 29 May 2023 18:20:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso2786023b3a.2;
        Mon, 29 May 2023 18:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685409644; x=1688001644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeB1bn1Ql5+eICLY4RZmbNRSVw+MUH1bfVzmbTWRzaw=;
        b=kxaOaWbBY428vRJIztcvhlJfpi2EqM9xng1XqnaSI0/WeKxi7fcb1NgjlMfuAa3Y9I
         W8L3wak/i0x1zSmGAQyhHzboFI8y+RonApN7gT7VJJAfslrCZ9zxOCXAe8T7P46UeoRj
         i4H9UrUCTg+iJGIQCRL871Cv8QfTrqu6hheXHP95ezCqQ4mqINVtuje6nw3xxAlbgd1l
         pSZZCdAktY4d2j/+U+cRIpHt/Cuy+G8BupxStOiQ6mNDGVVOrtA/AdJoppfwyqSmaWCM
         4NyWrbB71NH+17razGhwvC0i7t4q5SsCI0BR4q04EwTyIXM+92Uu9gqLCDUvRctd2vDI
         DW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685409644; x=1688001644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeB1bn1Ql5+eICLY4RZmbNRSVw+MUH1bfVzmbTWRzaw=;
        b=WoNxoTuYo6bZqwXDu7OAmRE+kWy0HI9zZy03HQYKtFVBD2DEqjNKkyKPatBgSudN5Z
         h6LFQbNSO64sGxxkttMYXMNe0jVEvR5BosgSSe3incrV8XcGeC1Tw7sEI3QKPIfd4hNO
         cJQzaQt7IDyQFBN4+R2EY+DuWagfLInxbtZPcYxUSNRnR+6I48vUv6otkNoaxN/sRYOo
         FDRLN7E69CnzvYmEAWNVrgNxwdC1VN8dlMlRlpdv6iBKr2f0ITP6VukQHZu/HD8yfMPp
         WKS53XuLIeEEQEL3KhAw86PeNDBrS4lQAfrTLyXTaCGUuXdmMiQp+JFIF7d8Vj9ljtla
         3dSw==
X-Gm-Message-State: AC+VfDxGSuQCfK0jUzg1KT2JgHKxOOZ2KzvBBgkZwY+g4ZdX6HfmI5yQ
        cEYAKcTyOv/f92xUeMznc7Q=
X-Google-Smtp-Source: ACHHUZ7DdXmy6fDeXqOHbYEVSqFa35aqm0taGsyDqf5kW5W5EOM+zjEpxFGezYDOh/Nl8POn1X5Aqw==
X-Received: by 2002:a05:6a20:5483:b0:10b:2f5a:83af with SMTP id i3-20020a056a20548300b0010b2f5a83afmr860114pzk.16.1685409644530;
        Mon, 29 May 2023 18:20:44 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-46.three.co.id. [116.206.12.46])
        by smtp.gmail.com with ESMTPSA id w123-20020a636281000000b00528b78ddbcesm7683403pgb.70.2023.05.29.18.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 18:20:44 -0700 (PDT)
Message-ID: <f569e819-9391-0a52-fcda-24946687690d@gmail.com>
Date:   Tue, 30 May 2023 08:20:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] docs: split subtitle of Submitting patches
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rong Tao <rtoax@foxmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230425072644.868535-1-costa.shul@redhat.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230425072644.868535-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
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

On 4/25/23 14:26, Costa Shulyupin wrote:
> Motivation:
> 
> The original long page title in the left Content pane spans three lines:
> 
> Submitting patches: the essential
>   guide to getting your code into
>   the kernel
> 

I think it's OK to have that, if the title can't be further condensed.

> Issues:
> - It is not readable.
> - It further inflates already overpopulated Contents pane.
> 

table of contents?

> The solution:
> - Split the long title to title and subtitle.
> - Vertical bar '|' in Sphinx-doc introduces empty line to
>   make the subtitle closer to the title than to the following text.
> 

Nope.

The title (as a whole) is already descriptive enough for
describing the text.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

