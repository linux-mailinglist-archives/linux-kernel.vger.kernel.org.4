Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7E6FDFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237261AbjEJOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbjEJOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 10:22:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925043C0B
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:22:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so48339615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683728573; x=1686320573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2etb/3I2MMTTEdePIkDu+D/ncnvNpSe07jedu4cHhMw=;
        b=XiJ3vEXc0eQhohhnvIRe7rSWcI77b7CFB4NaadQeej+vhgI/w9xWw/z7C37g75qvip
         +qFBvHW/Pg3dBtGVBKYnkqj6CWrWsehNqL40cu9FW24LMuR0/H+PHYef7/yPi9mm7oDK
         mNJqVGdnypP+bUh6Xxa4ObdFNUyOGLWhF4rF3F6yVQXd6B8rg6VUjkCFP56xZgM1nqxm
         GYcD87btvVdi7qZmArMs7znzNLGMZuUqsfjtTvcQIRVb1VeTj1LkmCAlcxWg7HkoFoZh
         vtOLvsF9/ner+VmNy7WpQ0ryMiPgXDHD5B41fCAngWrB2WgZedr8KhHQRMVfXYHIOBB3
         XtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728573; x=1686320573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2etb/3I2MMTTEdePIkDu+D/ncnvNpSe07jedu4cHhMw=;
        b=KqaHDazf0i1SW268KIt1DTzM+hh+mTVlaCS7grA4XZBYh6gO0CVflwANgrvfmNYDRZ
         O+H3ZCABnE80jfjZQzQoAHgUtGbfG2D4CRHz76UfOJCtY+Mblxif0fOwqMROGmdpEbwb
         HRQIE6Wn5ImXOLhRBL0gBYhHqjtHh7lHWqJDbI3t9jLxOwtVxm4mLwrAAHwcx5zm0wET
         aVSKQLNJOgDN1nnw5LgPl8DfgdvhxcJhPEHhopTAb1Xquo/qsuszGv+INH8tSOba2+eG
         91rzifoXGnG4ztvmj/HQeywz/tKyozXicbWbw9vU8kIR6+mOKoW1k7oaF53hiUAqcU5R
         x/LQ==
X-Gm-Message-State: AC+VfDy3P3P99+IcTR4WqD04F6AY0Z/mwwroI3T9jCND4bu3JP2j4Z+q
        8IG6DoWWRJMY0GyvZqKLNcK54g==
X-Google-Smtp-Source: ACHHUZ62HNQerWbsxoK3MwqdchiGC1yKERqEYCSw8RQj+Kyl8r7fDPUS6W9MOzl+5BvfE/Q4mrE2/Q==
X-Received: by 2002:a05:600c:3658:b0:3f4:2327:53c2 with SMTP id y24-20020a05600c365800b003f4232753c2mr8083597wmq.19.1683728572981;
        Wed, 10 May 2023 07:22:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id h9-20020a170906584900b0094e597f0e4dsm2705011ejs.121.2023.05.10.07.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:22:52 -0700 (PDT)
Message-ID: <08ebfa39-63b0-9db7-bd94-39a1822f3c7c@linaro.org>
Date:   Wed, 10 May 2023 16:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: interrupt-controller: sifive,plic: Sort
 compatible values
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <9cbf54da1ace03d7a45f28230fd99954d8c0d141.1683725029.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9cbf54da1ace03d7a45f28230fd99954d8c0d141.1683725029.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 15:26, Geert Uytterhoeven wrote:
> Restore alphabetical sort order of the supported SiFive-compatible
> values.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

