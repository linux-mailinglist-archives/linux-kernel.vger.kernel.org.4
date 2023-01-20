Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFDA674E34
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjATHgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjATHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:36:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601C7DFAA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:36:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so3321848wmo.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5axdYVu58o3s3zmsftrGOY6t6CB9dpHYTgoOg/TRz4=;
        b=KaVjANoqb7UEcJvY6Fsl73zpg7CmDd/0krcM8AjESV+xo3tTXMI9S08Orxp8S4m0gG
         XtxkRC5pzH1EQhqUy3E9VrJdxAg2VIqSI0Qs7tY5SS69YnEcToKrcXeut/dHWBzLHssB
         TDV2A2qIumkolDqZ1M0ylxbsYcTD6pbYa+hmSYgRjr/u68FGQopz9enHnXUDmjcUrN87
         NDDyZ9WmSSk35hrdcT8gfJD83zR9qP7Wv8J1QvtUyynZuuZvIKgSaMvPt4IbO6tN+/YP
         N9PjyJala4QRuwypjzNlFvQ83pLnSiSLXNEHfJjMg2nexNCUkja39n66pb/YkyvfmKy/
         t7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5axdYVu58o3s3zmsftrGOY6t6CB9dpHYTgoOg/TRz4=;
        b=YQ2h8+MNLn4aG2GN7ZNDebK/3t9g/fBscwIT8YoKTt2/FO2zHB71C4ks/ADp1nvUjy
         C0Cw8vaM9ncIjRWsQM4aVjwjjr6b4OlaMNi8rXmH/gjK+i/XfK5ssZjOfTtytItyx+b6
         vNBqUg5RsL20UcjQcqEmZYxhae4h8HMusG3hjYcwVGqzFOAVr7V6MBmlze2j7avZJDDh
         xxZaIfXlL5xzk5Ey18ST3LUQep+IYjGnrU4XKLeUBod1xzl44n09IvFUi0dc+cnqj+MZ
         pF72JJz+1rL1gQhNlrtz9c7Y15n8x5dTtkyItUnBIfPW3R7HW3NhXn3WtF1nTqrHunbL
         05wQ==
X-Gm-Message-State: AFqh2krmtk5FILsr9A0cHyBCVX+F8SSA0fC5zvVifUkDehDOHHS3nJSL
        V8vfn/fsR7Uk83CKdspsVgFt3g==
X-Google-Smtp-Source: AMrXdXucwsswcxHKFL3jpo2bbXKj2FIMLnmDo/qr1qVJ91XluJbzcuID+FvFYaU4o6Td85ilZ/Px2w==
X-Received: by 2002:a05:600c:4e05:b0:3d3:5a4a:9103 with SMTP id b5-20020a05600c4e0500b003d35a4a9103mr12951660wmq.31.1674200186312;
        Thu, 19 Jan 2023 23:36:26 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m31-20020a05600c3b1f00b003dafadd2f77sm1536725wms.1.2023.01.19.23.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 23:36:25 -0800 (PST)
Message-ID: <bd24d493-fb6b-6260-85d8-725638b6ca2e@linaro.org>
Date:   Fri, 20 Jan 2023 08:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/3] arm: dts: exynos5420: Add a label to the DSI
 controller node
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230119185940.156558-1-markuss.broks@gmail.com>
 <20230119185940.156558-2-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119185940.156558-2-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 19:59, Markuss Broks wrote:
> Add a label to the DSI controller node so board device-trees
> could add subnodes.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

The patch on its own does not make any sense. We do not add labels just
because maybe they will or will not be used. Need to be squashed with
the user of this label.



Best regards,
Krzysztof

