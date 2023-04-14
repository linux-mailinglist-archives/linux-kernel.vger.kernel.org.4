Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A1E6E190E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDNAcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDNAcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:32:51 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E95040DF;
        Thu, 13 Apr 2023 17:32:44 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b8f2747f720so46738276.1;
        Thu, 13 Apr 2023 17:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681432363; x=1684024363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CGdlVq46sVxerRrJyPR6Hw6xFoW0TBSTctv7JapQRg=;
        b=qR4a5nkMAkVFebJolVQiremQTD2+SPK4CC0w0t6azUj87XqnzhjoLJtmmhsk1230Aw
         dHraUQEStovib43iN3YZmyvMPWj463YwMD4jjWFFMGFAS8LQkvG24368nDZzk5jFRCHb
         R5mw84cGECBbooLprcMYBSVtu2S2dZ+1S5z+zOlCeXLAMszYNSX6ep9DpQMf+/5MwSey
         0wVxK7KxWMlzD4B2qH0dmFlJosP886zsK/QVNTaubh1a7nO6K5c2z5FuhytHWs/920i+
         NDwtgaTNmUoYvog2sC6GG9Qhtrgjj/rjeuh9n8CTkf1ISEt51D0kNK1yOA74XYJYCi0w
         uo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681432363; x=1684024363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CGdlVq46sVxerRrJyPR6Hw6xFoW0TBSTctv7JapQRg=;
        b=AnttiXLlytIlCZqoVvpPQV+mThP7Qgy/hFp4DW89eOmV8p6r2nkL3KV3dxW/v68O7J
         AbYyEALcPUm48hgKURn475Zhl8Glnkv0XR7M2qQe4hGUu/LBCsA9f5xcBarY+AKa08UJ
         v78Spvp4VuCkRIWkvgLAt9wsW12YMDFvRuHaY2W+tIfcyoAA4OuBcy9sjesfrW587LSo
         7pXdVmhICNwQEbP6T9ryBqlJUXd0mhFF8B5Ggpbon+BVYjy0uSOkNreIwMyQxODwhsrz
         FCNpns+fkZeH/Rrl5jdXvB+UvMQAWL0BgGyKl5oD74ALAdCBR/bXCoc8T8Z+SWKNxGJu
         1LUg==
X-Gm-Message-State: AAQBX9djC1ESOhw8eRIuM3+4h7X78Mhn1PEB5X1LEDuYvrz1Q+JsaBs/
        tgkjTfXbI43UDnzKtfy6GdY=
X-Google-Smtp-Source: AKy350aNylrfgRaTqO3yEpdezoBLRWATQW1ddy4Mnp/FNa+VamT6TL7xF7Iw5fXCtGYhO5gPMOmd6w==
X-Received: by 2002:a25:ce53:0:b0:b8f:347c:7bb9 with SMTP id x80-20020a25ce53000000b00b8f347c7bb9mr568982ybe.2.1681432363509;
        Thu, 13 Apr 2023 17:32:43 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id r17-20020a25d511000000b00b8c09fd88ffsm788612ybe.30.2023.04.13.17.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 17:32:43 -0700 (PDT)
Message-ID: <b89c39af-da87-8138-9899-fb631ebe76e1@gmail.com>
Date:   Thu, 13 Apr 2023 19:32:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 1/5] dt-bindings: input: touchscreen: add bindings for
 focaltech,fts5452
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
 <20230410160200.57261-2-joelselvaraj.oss@gmail.com>
 <f9552bb6-ea73-93b4-f15d-d5d7c326c708@linaro.org>
Content-Language: en-US
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <f9552bb6-ea73-93b4-f15d-d5d7c326c708@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Kozlowski,

Konrad Dybcio suggested to use interrupts-extended instead interrupts.
So in my WIP v3, I have updated it in the dts and bindings example.
However, I am confused if I should replace the "interrupts" with
"interrupts-extended" property in the schema too? I see a lot of schemas
specifying "interrupts", with examples using "interrupts" or
"interrupts-extended". At the same time, I see some specifying both
"interrupts" and "interrupts-extended" (like one of these two) and very
few others specify only "interrupts-extended" in the schema. Which is
the currently recommended way to do this?

In between, the interrupt property should be a required property as the
driver will not function without an interrupt. I will fix that in v3.

Thanks,
Joel Selvaraj
