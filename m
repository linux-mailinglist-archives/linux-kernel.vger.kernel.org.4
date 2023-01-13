Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AE3668F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjAMHw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjAMHwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:52:55 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3063391
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:52:53 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ss4so43133605ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hsW10UAQdG3igNdNi26Jys3iRtenHKlkdEyDQRN/BnQ=;
        b=ZebeW9H97F9fWhdeRZ9sF/CDFwFkrKI5aiO6Xr8jew7hqZRK2cZbZnkOw4K3ajQkU7
         XaD22IznntPJOHT8RzYQT/QvTDTPbLSbyfwDx3vD1cqC9NfQO8A/5oh66ndDtMmJRvu0
         C4H9lkD+B9DnNhmdPCONmsab1plYSVHB4DjVLr18T9mUwNAi8u1arHs/a/RQ+t6zN8gQ
         vWM5lQsCRsSEyyoO+6uzEYOTbWPYAZJ1ctfrQxZUcItWf41R33hbeBu1MluQmGBFHdjx
         0ulMHnnTUyoBBJmzOzJg5EXrF6+MjbbK67kqxRGBk7h5TM4YmwhxcfP7FNWxYJnmG8mx
         IZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsW10UAQdG3igNdNi26Jys3iRtenHKlkdEyDQRN/BnQ=;
        b=ANYBeF8FMkfkfTh5Eci1q+Q6hDz6vA0Fk6X+Q/A4BBVV9IQn9MG/BiP0LegUIoHqW2
         9Ofo1QG5OKe8Bq7g8PzDgDlc2KDswSM99xCDzBqB7H3HQ8pae6EptTrGZkiahwUapENF
         IrrQWOrvmt73gqupaWgYjylrq2zsmSC1Vvx/JoYxccMRn6bFCOT3hpCD4cVjiACc/Brc
         S69y7kwbV8phYs/S3EInJlOMaQdJBTT1u4m7YgEfKyyhPjMmhAmP+bJgXoaUA2d6ePt3
         wAh1iUNwaXIeCQBXXFuIaBi2u6ZcGOiBrZLUKiE01Noom/0DOTkg3FdlppclNzC46KSE
         Y8zQ==
X-Gm-Message-State: AFqh2krO0khNlu1GEaOD8To5+8CINwMQ0sN3cXT0jbfaheTXG8oynQkw
        ZUogm0vS3ly3jJ15xvl+WEGtARKtpTZVsA2P
X-Google-Smtp-Source: AMrXdXvFcFySV/UWF5uK5kT1Z9lr0NMGSrouHFEzaEhWrUju16eu55UjsDfLgGZD9zKT+xwn17ZPCQ==
X-Received: by 2002:a17:906:dfcd:b0:7ff:7876:9c5d with SMTP id jt13-20020a170906dfcd00b007ff78769c5dmr65956916ejc.62.1673596372469;
        Thu, 12 Jan 2023 23:52:52 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g18-20020a1709061c9200b007c1675d2626sm8373407ejh.96.2023.01.12.23.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:52:52 -0800 (PST)
Message-ID: <6f43e320-b533-e5fb-3886-1b6ccc7f9548@linaro.org>
Date:   Fri, 13 Jan 2023 08:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113073045.4008853-1-tanmay.shah@amd.com>
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

On 13/01/2023 08:30, Tanmay Shah wrote:
> This patch introduces bindings for TCM memory address space on AMD-xilinx
> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
> driver. This bindings will help in defining TCM in device-tree and
> make it's access platform agnostic and data-driven from the driver.
> 

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

Where is driver or DTS? Are you now adding a dead binding without users?

Best regards,
Krzysztof

