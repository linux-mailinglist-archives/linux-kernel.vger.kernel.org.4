Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3B6EA266
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjDUDgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDUDg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:36:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4B272C;
        Thu, 20 Apr 2023 20:36:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec9ccab8bbso1133937e87.2;
        Thu, 20 Apr 2023 20:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682048186; x=1684640186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8TNUub0/4AH0hGM/PjLlH8GSLkYNvyx9t8iPbGCbpFs=;
        b=UAPFUzUQyJx/7S5gVHGaKlqzAs3E1pbjFiFCwUvRnqKYgRkVPVAxAxq3h1wUZOTIKs
         sdrL5WeEVCYNQ/QRsqE7MdBgdtTXLtxiysE5Ef4G0H3Mr70jmVF3BoV63hxt30H29Svu
         /Vv27EFTfwEYbPrxQn1HpQ0Stmg+XbdOFxroV9a6i0ObXKRHx16pbJffS69JSf1RgCJN
         5w7PpS1DOK+dMkoNosrKoL6ZW3Iln6ULoiT9R5Y5hv86pUc/K7IYZMBSJQ5HJyiL/9DB
         rj6S44MohHDv9+UDGpLbI2/w4XU8b6bWaF5+dwoLUDayWv42jH1IcXbmkmAjrQ7Td0Xk
         P4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682048186; x=1684640186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TNUub0/4AH0hGM/PjLlH8GSLkYNvyx9t8iPbGCbpFs=;
        b=MPUz1nWjKiTTZcKmGFdLldufezCUbIFjFbbU2KRnrtYbkGoXJ4bXQT/rxCnek2Awr/
         RT2ggQvDSIYdLClWuBz5HHzMtRM2wS6gfr4iMc0yw/jc2KTkcaf9Fzr5JInEJ+otZ8hC
         nqTOs7JfCvYfqQ6LgHd9Co0IQ0Ni6sVvgxtrO0ezg4IKlFKi1BBR4jdQV8+bT5SMzVGl
         bEwi4fzTbjslWODAvnsY7uSVi4AWPXIbdlqcPIYjzY3orcoQmx/XMB4jhWuvGNw75r+7
         cvkOojNHRPB33TdcFBwUtevMFvtFLvvXyIoxO8m3j8Bt48bYGWDNC0YU22FweaIE7SH+
         TtvQ==
X-Gm-Message-State: AAQBX9fx4nHn0AkOhbJy4UriLTVEAWtMf6Jz7n7uArHWGXAEztVa5uJU
        3h5+z8eO5qSXnYo8D2mldVY4txwpMXU=
X-Google-Smtp-Source: AKy350aRN/2NU8E6owIwGpmiVpOkqeyKR/foJGda11DjrE3dEkamv+c+l1O2814+FF2+IrVPb0StiA==
X-Received: by 2002:a19:f703:0:b0:4ec:85f6:5bf3 with SMTP id z3-20020a19f703000000b004ec85f65bf3mr781044lfe.21.1682048185721;
        Thu, 20 Apr 2023 20:36:25 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id l8-20020a19c208000000b004cb24a027d2sm413621lfc.48.2023.04.20.20.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 20:36:25 -0700 (PDT)
Message-ID: <fbf40215-390b-bda9-c88e-2a45ddb6c070@gmail.com>
Date:   Fri, 21 Apr 2023 06:36:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: Add KX132-1211 accelerometer
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
 <68466b01b967efbdd1bf2de0747d35f28f94fddb.1682019544.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <68466b01b967efbdd1bf2de0747d35f28f94fddb.1682019544.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/23 23:22, Mehdi Djait wrote:
> Extend the kionix,kx022a.yaml file to support the kx132-1211 device
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

