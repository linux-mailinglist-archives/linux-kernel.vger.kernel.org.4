Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78CC6BC73F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCPHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCPHc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:32:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA14DAD02D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:31:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cy23so3772535edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678951898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/93mrEeY6xwjN+aW9i3HMgTYVgvZthXEVo0SwOP9yz0=;
        b=pWvQL6UWdEsVn0ulz6eZaGaz45ZgR3UZxbpVFYQtqM8Of9CXK9uH/zzYubSBBfEqnD
         /+4oC1aSo7oxbFOSQouGKCez+2L20FDMGEKJEy7ZyoNL8oJAIG4KzEEEVtIQTBt4Az5c
         JiyMWYQPQNgoBVmO/vc2RoKN5gN+vPgiUsHXGwtrrLKsk4uv5GZJQjDxmlggd9rsU9Ms
         4B5K0+EI+UbcN9ZmaLzpM1CZNFcWW9pRA78YiglcmPzGEWI+DOZTuMzCwIIqpR/J5PwU
         g8w1SUtKE+p0BM64OIsrE7i+15Kf61qzYDSYOE/CReEw2dbmn3c6moDH7k2OmxMmDTnd
         spdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678951898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/93mrEeY6xwjN+aW9i3HMgTYVgvZthXEVo0SwOP9yz0=;
        b=wq029qWNiemPqwVgyST+M9kB6KZ3+uiRnHX2mUCjVxmI6kxQti2fQWRFbx5SO112ZE
         AdadifpjSCmkkSmcljlbMjgFx/NXYn/Xph8V4M03DAU/sWndrf7+fFLO2RwB2A4I55nf
         mAUhmnuD0IHb0iLC516QZuB2b3mtqUiSqpDNvI+rU17NtDAi22jp9hqzXeqCG7v1iEdL
         gZ/96J0vbVEvBcWeCPROURlrOQ8PLa5i3Iy/9/CJGMWq06CqqW8o3WOE3+Y8mup+Gd0+
         s+lUhrIN9q34ehLRI+wkyS9TAMwKReOPr9x9kbfrosWgKF5AbYrEuh07qbBeFghgt5Y0
         koMQ==
X-Gm-Message-State: AO0yUKULYjc5hEY76+PqH3XY0WXg6QGJT7NrxHJGqTgU2G58zeWwytwp
        yPlx9oImYexCBYxAXmX1lg8RUA==
X-Google-Smtp-Source: AK7set9Iw+FrqSDZZYHWOE0H7eBOAaW6XE7mWlnsadc2iqDDt4LlsPdRqsCuh/d+SOt0X7wDW8xm8Q==
X-Received: by 2002:aa7:c7cc:0:b0:4fd:298d:2f95 with SMTP id o12-20020aa7c7cc000000b004fd298d2f95mr5455545eds.26.1678951897931;
        Thu, 16 Mar 2023 00:31:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id v18-20020a509552000000b004fe924d16cfsm2938042eda.31.2023.03.16.00.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:31:37 -0700 (PDT)
Message-ID: <542d683b-0ad9-ec76-cf26-a817e3cb2e33@linaro.org>
Date:   Thu, 16 Mar 2023 08:31:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/15] dt-bindings: reset: nuvoton: add binding for ma35d1
 IP reset control
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-6-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315072902.9298-6-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
> between the reset controller and reset references in the dts.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>

Same problems as previous patch.

Best regards,
Krzysztof

