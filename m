Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81666E7074
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 02:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjDSAca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 20:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjDSAc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 20:32:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB918269F;
        Tue, 18 Apr 2023 17:32:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2470271d9f9so1828494a91.2;
        Tue, 18 Apr 2023 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681864347; x=1684456347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6JBEBOkVfTEmObqcNEsEyY9FQjlw46Y62iwKC4AS1o=;
        b=EgBzzDeioDQmeDODO0ESCM2+hOKkVe5WFl8GLOkmwolTUPIsDapqz7/DdTZUrAj5SV
         wU0dcMZpz6N72RuBATOn42n+oR/ixlhALpIux7ldqjX0oz3/DRdO0q0Me9z0kEmNZNqI
         F0npW6jBiVL1c6rrMUyDGcLms98KTreROauoQwpxnV6ndCZaoIDDX5L7wg/OLEvBv+ia
         dW0BovnTpeqUA55sM7jJAs9smEwWip5n7oiU3hJxMcx2rUjxnq+GwYCrWt5wl/Zn3dWs
         gxklfAgGPqHJ+p8+N7AdESLbi0Ab69nRDYk+zDNSwigBj+9cU1r3nKUJCs8jH4i0zQsQ
         gw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681864347; x=1684456347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6JBEBOkVfTEmObqcNEsEyY9FQjlw46Y62iwKC4AS1o=;
        b=TQ+LNnHAlpHuGdsD8ZJbnnSzOktUFgUHwl0p2M2uXbEQaD8pRh5rHrMg5fhnverrAv
         +ubprPwkF4LEYPpdBDshdNRiKvXWw8Gxi0GziPolIEQ7nGg+RYrD8fC4txg0cmfMFTp0
         hn48EVz18Tvkl7MrvKvqYOTXlNGn3mgvd7Z5IhvGmGXS92dpnPOi2OU9fn9ZoQHwSg6P
         tFgPKYje6rj6TDC7a4PV3QDc36KaZjgaKPbNVgnbxMe1Ur4doq9FiKGVpoh930FIojYl
         tsw8VxV/rDHuWrPsAwDWGWMFH2DBxCbw3q6W2sExZPgrFIACm7nALV1VRC8vnQDm2cHN
         lmkQ==
X-Gm-Message-State: AAQBX9d5Atg5VKbS8/cS+3uGatoUId6/YAV6sQTL5MzKa8sOwQsYt8uA
        uKmRCWDu3kyoRThft52EJrJhos/90ak=
X-Google-Smtp-Source: AKy350Y8fUNfZALyHgpvZFVz6Fw2qMrCnDUy2F+p81FdRqt2ju7s2F5U/SWHfBoTbuz2ak8QPcCUpg==
X-Received: by 2002:a17:90b:3b52:b0:249:748b:a232 with SMTP id ot18-20020a17090b3b5200b00249748ba232mr1005004pjb.25.1681864347066;
        Tue, 18 Apr 2023 17:32:27 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902c1c900b001a065d3ea3bsm10169255plc.295.2023.04.18.17.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 17:32:26 -0700 (PDT)
Message-ID: <b1fb3fc4-9051-2545-a273-c05b1f9b143e@gmail.com>
Date:   Wed, 19 Apr 2023 08:32:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 09/12] clk: nuvoton: Add clock driver for ma35d1 clock
 controller
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-10-ychuang570808@gmail.com>
 <4f57a7ccc946d18be5eb9a47fa69e5f8.sboyd@kernel.org>
 <71f646cb-7114-0c78-493c-99bdb5217801@gmail.com>
 <f817937cfd494c3f619adda97ebd6346.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <f817937cfd494c3f619adda97ebd6346.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Stephen,


On 2023/4/19 上午 04:23, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-04-14 20:58:57)
>>>> diff --git a/drivers/clk/nuvoton/clk-ma35d1.h b/drivers/clk/nuvoton/clk-ma35d1.h
>>>> new file mode 100644
>>>> index 000000000000..28c60f081788
>>>> --- /dev/null
>>>> +++ b/drivers/clk/nuvoton/clk-ma35d1.h
>>>> @@ -0,0 +1,123 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (C) 2023 Nuvoton Technology Corp.
>>>> + * Author: Chi-Fang Li <cfli0@nuvoton.com>
>>>> + */
>>>> +
>>>> +#ifndef __DRV_CLK_NUVOTON_MA35D1_H
>>>> +#define __DRV_CLK_NUVOTON_MA35D1_H
>>> Is this header included in one C file? If so, remove the header file and
>>> put the contents in the C file.
>> Both clk-ma35d1.c and clk-ma35d1-pll.c include this header file.
>>
> Do they both use all the defines from it? Move as much as possible out
> of this header file and put them in the only C file that uses it.

Okay, I will try to eliminate the header file.


Best regards,
Jacky Huang

