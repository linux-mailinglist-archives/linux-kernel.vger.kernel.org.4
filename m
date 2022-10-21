Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC939607CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiJUQwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiJUQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:52:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D45285B69
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:52:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w8so5814486edc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQh5FP9DB3wc1fQfh9jbPYlKU5VqWNTkcSZuo9ThymE=;
        b=CS3R3gSGufMKQGWnx9OeJ32OUq+LgqWSxg7OPFjztxMRmETVreIE1s3In/omRFI+A8
         thoe6T5fw3TJloHTLBrd+wcQfK/dzSXR8TXqsWUIre9/Ccp+Jr0H8GVILQIJKG7pzQpw
         /g1N6I+iKJsY92e8W/5p6VhTXqRDr0AOvE8fjIO7Pu1bZyde/AVYgAuDhZRDwTu2KU2k
         UdOgO0jtXqmwAW9VzaX884CDxCa0Rpq+EKRp4/Xiwd/7Re1xUMYdsinLSqIIhRnnfK/y
         huZX52FBUl63PvqMfUgziuvLhsp3ePJ/62tvyqk1597O3s3Yfw5NjFgcSNusSn94y2i5
         9b6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQh5FP9DB3wc1fQfh9jbPYlKU5VqWNTkcSZuo9ThymE=;
        b=sZOLPXoV4EIsSCCbLBpo/ey/knwaGwiTKB6EYykTkp5Rt9x4decTj8GRQ9TUFNXDwo
         jRq+vPLdSFlQBblcv5P6RWsmPJSeXTRFmmWTMzlMXz3KWM9Mll5SJdsVpzYQ49p+YHnk
         32kL9rZpZEsL/2PpZMdYXIfwKHAlDY58exEJD8raJi1zOnYGWTZ2RGDOZb3w3cy4TfZ9
         Hj1gen+uBx7NJK/Thr9gQlXFDcA51aQ/vSy4ni+/EtvV67IuZYSbMGAFxRsj73+pLJON
         0V4VB3wYcjj1QCPzU2yE7E+UtY40igQEhSa2OCwxvOcWT7X0QzecXbSkZ5gdGhoFt675
         rTQw==
X-Gm-Message-State: ACrzQf3xB/ty4olHk44khttsbq3rWDDJShUo7+FjDdX8B6A/pGSn9Nl9
        pRTKlNo7boUPnr/h6AK+WqakzEfbM1+PSw==
X-Google-Smtp-Source: AMsMyM59+pyQYWTtqgV0nUm3pf/fVmJ0UyOB4e7WmuRDL7NRA28WJUbF/0H9nYeWMQJaZFr8DKdqOw==
X-Received: by 2002:a17:907:a065:b0:78d:c5dd:45cf with SMTP id ia5-20020a170907a06500b0078dc5dd45cfmr16640572ejc.117.1666371124856;
        Fri, 21 Oct 2022 09:52:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:25b:e73e:85eb:ae6e? ([2a05:6e02:1041:c10:25b:e73e:85eb:ae6e])
        by smtp.googlemail.com with ESMTPSA id r11-20020a170906704b00b0073d9630cbafsm11865311ejj.126.2022.10.21.09.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 09:52:04 -0700 (PDT)
Message-ID: <22cf2e5c-6633-986e-6add-f579408f6c68@linaro.org>
Date:   Fri, 21 Oct 2022 18:52:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 2/5] drivers: thermal: tsens: Add support for combined
 interrupt
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Robert Marko <robimarko@gmail.com>
Cc:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        rafael@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220818220245.338396-1-robimarko@gmail.com>
 <20220818220245.338396-2-robimarko@gmail.com>
 <20221017190143.7fjwrlud6hamu3yr@builder.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221017190143.7fjwrlud6hamu3yr@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 21:01, Bjorn Andersson wrote:

[ ... ]

> 
> This should have () after the function name. Perhaps Daniel could add
> that as he picks the patch?

Applied and parenthesis added

> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> Regards,
> Bjorn
[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
