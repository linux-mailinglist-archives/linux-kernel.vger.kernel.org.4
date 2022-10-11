Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA75FBBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJKUGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJKUGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:06:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2639B866
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:06:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a24so1429793qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OrZY7gIg9zPCoylQJvUfFiRJxU0iGXU0m3H3P5gtWU=;
        b=rdtVBvQJThBQQslavzfRL0NGn0XKxFbgKLZ8RSgo9qc7wBNUI92ALfHucerU3cJXt+
         UDfO+inM11rDNfJXzrR4x4RVGVMVHXxZJwuEaNXaFX4mhqBvSMYGLyGlPFhsjGXH5Qe1
         EpbjmomZ91jXxh4E0wMQnbQo4Hs6QA/CegS1UEdXv05QjpxlnoO/3GLYKQ5jWucTXlU6
         Y0zEvG4i3Z/ybLqdam7zKZHcbpmcEuon7cVFPkpEEZv2uZlC3amiKPmSt2J3BDQk+WIY
         KL7rCUfDKFS3cR/K/uIcnUYwOESgMK8salvH0dTgZhag+L+1xMrCDbMAPFf1jjf98q/q
         gCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OrZY7gIg9zPCoylQJvUfFiRJxU0iGXU0m3H3P5gtWU=;
        b=dOnhQ+LgGE8tpHqjoKnHcXlUOKMh3sxDoe0SB4LFDWinoXd6HRQPzQt5iwxCfwJcWh
         JvuL9YJBiY8D7ZI+bTPzdhm9Ydtu2qzq8b2VRZLYpotU4hd9vF990lPo5BG1RdOKwO+I
         +N0lAohIBjWxsQT3BL6BYxDcoL/H7JiMIcY04sO8oa4+P/cVSuiArxFrxI727RlbgzIg
         luLiDRYGkFLLxaop1LtVKxu7mFIY4TVNjs1jn+PZoov5EECtA7IavO08Qexu4D87uQ57
         bv608UsTATLt5V2b3spngACVteYNw26cFBl8Ywlvt/iBLxGm5fUijmTJyDB4ualuGmSt
         JLvw==
X-Gm-Message-State: ACrzQf1cPEHmKc1xGKKcenpzlf0JUpz0KcGVZgJ+l2qzkijze7Fomfk1
        +N30UchfrhNlxhq9hvvjyvdPsCc6m9bjUA==
X-Google-Smtp-Source: AMsMyM5Pm5yBgd1Uwjmp6b6XGLhAMyZ5AKaOb/Se/KGbnqz5sobAkxFFaNthpw0yeaMeXrr6q80KTg==
X-Received: by 2002:a05:622a:389:b0:39c:bca4:587e with SMTP id j9-20020a05622a038900b0039cbca4587emr856599qtx.491.1665518763970;
        Tue, 11 Oct 2022 13:06:03 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id bn42-20020a05620a2aea00b006ee8874f5d8sm1418876qkb.28.2022.10.11.13.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 13:06:03 -0700 (PDT)
Message-ID: <c362aad4-e920-b5f1-d490-8256789b68cb@linaro.org>
Date:   Tue, 11 Oct 2022 16:06:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 5/5] MAINTAINERS: Add HPE SOC Drivers
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-6-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011185525.94210-6-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 14:55, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add the HPE GXP SOC Include files, yaml files, and driver files.

YAML is a format, you added before bindings, so just "bindings". And no
need to repeat files three times.

Best regards,
Krzysztof

