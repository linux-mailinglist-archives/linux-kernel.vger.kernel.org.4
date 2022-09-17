Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700905BB99C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIQQv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQQvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:51:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F2230541
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:51:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j16so13283259lfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JB7VcdZNOyYWQNZ1BkIcQmygtJWZ+h+MiYm8PghZbnY=;
        b=eXK/bv8SbOfAX2+3pTgVI4uBbg+TyXJJGmt5a5eTiXX6sSHYFX7A6PcKyrWwvLmQBe
         8ky2ydDfK8e9yres7dbONOG7Dp8hg9HMah5dfxz3gd1PQr7Lz7vwRrY9oHOFHSs5XRRi
         buCLfojYjmtQr0+1+XEIvwJCD7tOp5tjtHkncCIGzlkhmazPZfpzs3zcxBgYBCnIWZMu
         /szpakfe7J1MqXJQUp/S8GPBzCd5lpyxCe1U2cxQMXpst391wouSWDFDDeHiIYhOwz4H
         vEU11VhP6KiFqkMsJtfawSWRn1tBiXXFBngxoibZ5TdgH+c6Et1ufX9VQe4fDR9I8rY8
         epKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JB7VcdZNOyYWQNZ1BkIcQmygtJWZ+h+MiYm8PghZbnY=;
        b=twlqxB7dQbAjiMJGEU6D7hODyVUKIhMQSdncyEDCVFH76+V3hLQDBUxY+p7SPq/4Vt
         4MSuNxioJPzMrFxg3ih2hyklCuXnYj50QyZ5ETAyQf7Pt4kZcHorxkh6V4zd69yVGzNo
         DVjfLhcRr/np+gVbh38FEQERKIp28d+Y86XlbIVDAeMAJ2WnXIgkaW0e9cHb0Rh2uo1g
         YBfNXKf/ZOiXACSrE1A4H9X1kb//8kfqhImWXgFHWWBkNiVkikDXKJ68YBbFdeAEv/lU
         oM0wkXdTJCMJGNw1MeoHrT8MxhhRCb4WtEkIZLZ29BK+myHGBbUPnlz1b2nzsZ9P+5ru
         hCCw==
X-Gm-Message-State: ACrzQf2cSZRH5nMJwmkOEUORLk3pX0Rlf9c3ExL6TK1P/pkxFGPxh4+R
        UyljLV8mbKfWbCPVQrenl4PKBS3I4Q0+VI20
X-Google-Smtp-Source: AMsMyM7WYL6eLqW83RaG931NdCOAjenLqk87bLS8GSD1VDRAdlclqYyrJyYRSBYEobkwv3kYAq2Ijw==
X-Received: by 2002:a05:6512:c1:b0:497:acd3:10cf with SMTP id c1-20020a05651200c100b00497acd310cfmr3570118lfp.484.1663433481431;
        Sat, 17 Sep 2022 09:51:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z2-20020ac24182000000b004948497e07esm4199484lfh.15.2022.09.17.09.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:51:20 -0700 (PDT)
Message-ID: <0acc2a21-27c2-ec85-0335-263d70c24469@linaro.org>
Date:   Sat, 17 Sep 2022 17:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: timer: Add QEMU compatible strings
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, maz@kernel.org,
        mark.rutland@arm.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220916132959.1910374-1-jean-philippe@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916132959.1910374-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 14:30, Jean-Philippe Brucker wrote:
> QEMU uses both "arm,armv8-timer" and "arm,armv7-timer" as compatible
> string. Although it is unlikely that any guest relies on this, we can't
> be certain of that. Therefore, add these to the schema. Clean up the
> compatible list a little while at it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

I guess you wanted to say QEMU uses "arm,armv8-timer" followed by
"arm,armv7-timer", because otherwise I would understand it that either
that or that. Anyway, is it a valid (virtualized) hardware? Is ARMv8
timer really, really compatible with ARMv7 one?

I don't think we should document invalid setups out-of-tree, just
because they are there, and something like this was also expressed by Rob:
https://lore.kernel.org/all/20220518163255.GE3302100-robh@kernel.org/

Best regards,
Krzysztof
