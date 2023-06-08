Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38C728AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjFHWJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjFHWJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:09:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACFB2113;
        Thu,  8 Jun 2023 15:09:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f6c6020cfbso8696611cf.2;
        Thu, 08 Jun 2023 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686262170; x=1688854170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hw4w0zezFowlPf8g3x94DsSmwyLFAcbPrA7V3afCmfY=;
        b=UgGSashF9ZqC6pdFn8TYsD4jZ86sk7OS3UuPdx4UvPpspAUR6kFnoZMNCCMl7Q3xpH
         uNciYR5H0fX6vRwq4ouRxlxMMHBpelQFGcWIzyXBU3I3VplA1013BnWrpWjBLVFsaonP
         2JKQzNv9sSSaUnCuaKPLjH4Swb7oHXOKIlcAPV6HZbjJTIV1zX0bJ6hndVJ03Je0j51Q
         CRa7qNh/rmZzC/FHi7TpgsC73A6Bd7dqTbG3ZIHiSdJKYmJkQdkYDztIu0s4Mh3zuT10
         c+d2llzw72XScb9al93Qjy8JxybkRp0Egw4QWrK7Y3+prk4IU1Q8Iss239yLNtvl+AeB
         Nk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686262170; x=1688854170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw4w0zezFowlPf8g3x94DsSmwyLFAcbPrA7V3afCmfY=;
        b=AHqPsO1UaRaIqEYP7Fe8j4X/eQvNUDFyDhfXQjpJ8n5efDLVZMvnf6nqAjD5K4hEQ1
         M9M+u6tEjz0wyo8ACFpadsJHdFwsliWS4HZ47WMvogXi17oyG48jv3JoXM6P8FmhCwuS
         /t68WB2Ji2xomC6loFfqepiNvxoQ2HRf9MaE5uP+ida5e+akiHMVafNGAx2ZDmen+pxg
         3ZVJ0TnTLUlNoSvI4zaZxh656tA/rrS+WQnId/kwaJGNNYXpFRr7xlatYTYehsv0z45R
         qfbz5WaywMDYJkUjhUjx7pN110E1WeXctiJj/Chs0VjKT7pZw2M1XSh4ErsJp8uMeZOr
         UP2w==
X-Gm-Message-State: AC+VfDwpzRfTH2voW3f5DcNHv7n7V2M3Wo8kAIWsCtAFosF96y8v3cC9
        /1K5Lz7lFIqw/gs9TzPHDR4=
X-Google-Smtp-Source: ACHHUZ6E/If+PwAxdP3DAbiFAE9BZGwMCAq6eowz+WqwaV/tSq0tZMOlmRyMc5zQaOJtzH8wbc5vlg==
X-Received: by 2002:a05:6214:1d0e:b0:623:638e:aa20 with SMTP id e14-20020a0562141d0e00b00623638eaa20mr3090784qvd.51.1686262170584;
        Thu, 08 Jun 2023 15:09:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c17-20020a0ce651000000b005dd8b9345b4sm699856qvn.76.2023.06.08.15.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 15:09:30 -0700 (PDT)
Message-ID: <5dc1fb31-a025-09e2-1d70-8edc64171a6e@gmail.com>
Date:   Thu, 8 Jun 2023 15:09:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] ARM: dts: bcm21664/23550: use CCU compatibles
 directly
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1685127525.git.stano.jakubek@gmail.com>
 <65c54bd4076d646623d2a2f518631435522dc628.1685127525.git.stano.jakubek@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <65c54bd4076d646623d2a2f518631435522dc628.1685127525.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 12:29, Stanislav Jakubek wrote:
> BCM21664 and BCM23550 DTs for some reason use constants from a header file
> for their CCU node compatibles. Change these to use the strings directly.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

The reason is to ensure the code and the DTS reference the same string, 
applied anyway.
-- 
Florian

