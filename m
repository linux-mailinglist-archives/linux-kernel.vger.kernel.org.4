Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A34A6E3B40
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDPScR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjDPScM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:32:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADCA210D
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:32:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id c9so19766204ejz.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681669929; x=1684261929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkHuhYDvbdCOvZz3EZOv9s7JCqMnwT2ehYe9tW+hB2c=;
        b=lJHIQjGLglg10CR7YrWQEksL5owJYHniRJJxCge7kAz4nsrCAovsE455JaqvN8brv5
         SZjfPkIpu2FLm9ufz9PAe5aaN0T8BEmHE6VzCZYiEVFr5nFC8tnpYaVFwkZa2FN0HIRr
         499CC+lGs4QztOn8GZFP/wS0vbz/3xDpQWBEieKm1KFe+qkC35STEdsUSvAlfJZlOKZT
         +AP5aRV0iLAbGi/nLZAPBpy+BGOTX8z7B4+mKzXOGPUN7nGk7gfNz+ZOujo3T2pUudqs
         eZhKhcU3cOeAzWu3MDnOlxJFBHU80SWbXXEB+4SocrXUoU0zJd9Wn/QMQ95Hl/B+a96y
         Pltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669929; x=1684261929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkHuhYDvbdCOvZz3EZOv9s7JCqMnwT2ehYe9tW+hB2c=;
        b=b3nUOrIJ2+YLoWr4JXkPwLZwWZvyff96A5nD5eLCVpob8NLSScqRjTeEvlT/bc7x1v
         Tj+ppb88tyZV/7pM5UJSAV1aexmAHeSlGOMRUXdOukuTaE07JaCtQsBgRBcCGeK6fSQg
         ixV87Y0mZ132QhEajAsyAx0OvUkIXk//H5+pMr9S8/xm+FBqhpuzzRp4CRv/PfZ5q83A
         JojFBLJfcQGVkoWnkVVxIVdndB68NCVePag+6mDL8yuTFP4zJk6K4O3JTBYn/ynaF04g
         zLsmSfR4PNsZH5eJkGkiU7in0NrZZ5foeMadXuj2m8o/aecM+eScfGlf6RM0jfJiIOM+
         Mt0A==
X-Gm-Message-State: AAQBX9cPdnModXiha0modqGudfWgRcirDrveH99oLwH4AMyzal/MoeC6
        +i6sQY6vAUHT00OHi7++xjogGw==
X-Google-Smtp-Source: AKy350YzkY5FWr47E5pxqRH1fLpiNrNt1LhnrHitY5+bw4q9TPxq77fbrgfzf/3CIx30ao/jPTOgdg==
X-Received: by 2002:a17:906:354c:b0:94a:6343:7596 with SMTP id s12-20020a170906354c00b0094a63437596mr5459372eja.41.1681669929374;
        Sun, 16 Apr 2023 11:32:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f9e3:1d38:66a7:ae92? ([2a02:810d:15c0:828:f9e3:1d38:66a7:ae92])
        by smtp.gmail.com with ESMTPSA id k18-20020a17090632d200b0094f05fee9d3sm2956173ejk.211.2023.04.16.11.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:32:08 -0700 (PDT)
Message-ID: <19ceb0f6-1225-c8cb-1469-3d657e66d171@linaro.org>
Date:   Sun, 16 Apr 2023 20:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/9] regulator: rt5033: Change regulator names to
 lowercase
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1681646904.git.jahau@rocketmail.com>
 <d4218947e354aee45589acb1060ce41727a26750.1681646904.git.jahau@rocketmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d4218947e354aee45589acb1060ce41727a26750.1681646904.git.jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 14:44, Jakob Hauser wrote:
> Lowercase is preferred for node names.
> 

This will break all existing users. In-tree and out-of-tree. Where is
the binding update?

Best regards,
Krzysztof

