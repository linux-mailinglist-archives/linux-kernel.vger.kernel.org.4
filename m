Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41386B6FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCMGxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCMGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:53:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2F23312;
        Sun, 12 Mar 2023 23:53:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f14so4616410iow.5;
        Sun, 12 Mar 2023 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678690392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrhDq8EK0QZScFTe+Abz54ar9UkGFsTVlaBdo7wkZXc=;
        b=WRwIkO0MaPLsECMaML4XbPTHS1bhW6oO2l/OsPvAvFOjED+0XjcubuOI+plZ7fXcDL
         ePGK+TdSHWPEGjU+IaWlAIc8HAlYak9u028f49uPBepmcgG4fLh272L/gL5sUyQnqwMB
         6BG1zd3ilQc6cNWex8SjYLrhvw6XK/izVj3kKnKjpiTnyBn2DfKgjzRROXAsvq0e8jCb
         neMqreTyGhN2g4grphBnNlhxVWoThx1wr1eZ0FHin8gBmr/CnFxw6wr7q4aRqFgiQ4k+
         Dvw3fFmz4tUm04AqxM56N4/2q/WZWoS8PV87kxBckH2ZNTMpBgebsbTtPzP9QQSGWKww
         xEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678690392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrhDq8EK0QZScFTe+Abz54ar9UkGFsTVlaBdo7wkZXc=;
        b=jbJLy5W8zgTO5EBtKv75NCmSk59QwqbnMXjgc/arMNOSWe/ZTa9TGc/4hxUTNFYXB6
         o/wxYLoDdvb6pFxwIrN/GvDNM5ZkTwDKL9KFQfRCGuZcDkx0JD+qLxFry7Zl6xuIbAGh
         UA84UTkAoDdbxtP0B+8rqCJ33vj0cqdgAWC8USUe5O0PKuq8PT/curRJ//1AhunzXZMW
         k//aiPu+yzhdbKqKBVqKVAUgX+pUH7UDZBJu6W3GLLVwJNJM2vJmi1LSnDYhmCsGcJW4
         5iuB1BkopABh+irGwTo/PMYhJzoumkXtesxG8L2UoL9pzbyEd4esdHJibpd/rXUD3BOK
         hDbw==
X-Gm-Message-State: AO0yUKXOasMIZZRxBu++GMLd+qwyLC7Bvq5fCra4Hzho8A4Lve0DHHhK
        v/F1en7da5u6C8CUwcyG9Go=
X-Google-Smtp-Source: AK7set+lFi9QRrFZ2RoTcyUWlu0L2z5H2HHDSr4cvK42G+ygiV2hrykZP+e+PUjZjeiitYvirYCOPg==
X-Received: by 2002:a6b:dd04:0:b0:74c:c1ba:91fa with SMTP id f4-20020a6bdd04000000b0074cc1ba91famr6487829ioc.0.1678690392055;
        Sun, 12 Mar 2023 23:53:12 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id c25-20020a5d9399000000b0074c8295db0csm2328468iol.6.2023.03.12.23.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 23:53:11 -0700 (PDT)
Message-ID: <3f4efaa3-75cf-1cc3-faaa-e687ee051617@gmail.com>
Date:   Mon, 13 Mar 2023 01:53:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/5] dt-bindings: input: touchscreen: add bindings for
 focaltech,fts
Content-Language: en-US
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
 <20230312093249.1846993-2-joelselvaraj.oss@gmail.com>
 <c9db83e8-f87d-b94d-0c23-8114adb312e1@linaro.org>
 <02012975-8b4c-58ba-b002-d2983c0e1500@gmail.com>
 <4f864115-ef66-6940-c1c3-6b296de4cab5@linaro.org>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <4f864115-ef66-6940-c1c3-6b296de4cab5@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Krzysztof,

On 13/03/23 01:42, Krzysztof Kozlowski wrote:
> Downstream DTS is never a guideline on design of upstream bindings. They
> violate DT binding rules so many times so much, that I don't treat it as
> argument.
> 
> The property does not look board but device specific, so you should
> infer it from compatible.

Understood. Will do so in v2.

Thanks,
Joel
