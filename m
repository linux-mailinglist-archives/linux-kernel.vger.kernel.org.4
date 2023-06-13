Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E20972E054
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbjFMLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbjFMLDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:03:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3C10D8;
        Tue, 13 Jun 2023 04:03:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3af7e3925so19758265ad.3;
        Tue, 13 Jun 2023 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686654197; x=1689246197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/V6eBeQnAmuvDoaAFDPt7SClZ1v7wsV/h5UJhyaPqU=;
        b=BWLUpzQWNs6DVuyX36vOIj88sUq+ThabI0PcNUhco5A6msRuOGGwEvhbxFMIzjNmOi
         RV5N9UpF2HsW7L6uu9TfhIfHZfLqMfBLnzXMvHtclte31xxIif1kLRXfhep7cf7E/KDt
         Rt06FQYTAM/Q3Hh2GErzY25OFBLcZ/H7Ob/KNGwhTxcZMN6N5SRGHh1MAfoLBcFeyCTD
         r5EZsk9vpPqp/r3N7Vw9ShgN8rrKAtakg8rumCEyDIvamkoIxWJSj6H/L+d7i5SzyJiw
         Pr7qJJdiytYrGqqWq+mKAXtoyg+Kyz8dUPgG8UaXuc3JlZ1PZRNTB3Bp9GcR4W6zRhoX
         J4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686654197; x=1689246197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/V6eBeQnAmuvDoaAFDPt7SClZ1v7wsV/h5UJhyaPqU=;
        b=aXrmIRhMd/ll2V0W+hGYCbzTLm+nMemVRAF2+L6VXVFghlJDSvTEDrbc1uaw7nGtZR
         7aXeXaae8ykPUGNbM6Ek4NzcrHZg6xU1CoB7ZvHr0j0uCk0McGBQo5dX2y/Ka4GgcG3O
         vGw2+CFvzFMGepwt8Roy9GLTH5dvVBGBgbmJPZ5gbjS4HK0REdmFxMLhpzNS3GtpJiV6
         u1s9eTIzBK2bqsfUyy/uCCRptgLU08oy22+7gkVyAOWr/4EG6TTulJoN8+O2a3iTxTqO
         hLOM4t0TF4Dbn+o9goBSmO9s2p9AFsHGMOq7AHbjLb+7zTgZt5W0vvCV/IWUAXTUq2an
         cBQw==
X-Gm-Message-State: AC+VfDyRYWfROEciDJsNK3KruJGTVG5xNiP0PKnCCsrvqizn8VUu293L
        ljUQL/noady+2FQmRLsblwk=
X-Google-Smtp-Source: ACHHUZ5GM4WjEbyTgWCo/Km2adsaMHvYGz62PNvK5V5tCldsltLQQRbQSPoISoqOliZgSJGlM1zfkA==
X-Received: by 2002:a17:902:9888:b0:1b1:bf4c:868a with SMTP id s8-20020a170902988800b001b1bf4c868amr8012570plp.42.1686654197321;
        Tue, 13 Jun 2023 04:03:17 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d68300b001b243a5a5e1sm3335009ply.298.2023.06.13.04.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:03:16 -0700 (PDT)
Message-ID: <0e40cbe6-0e88-b300-3507-5fa92eadb46d@gmail.com>
Date:   Tue, 13 Jun 2023 19:03:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/1] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, jirislaby@kernel.org, tmaimon77@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, arnd@arndb.de, soc@kernel.org,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230612025355.547871-1-ychuang570808@gmail.com>
 <20230612025355.547871-2-ychuang570808@gmail.com>
 <2023061325-distant-gaffe-8871@gregkh>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2023061325-distant-gaffe-8871@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,


On 2023/6/13 下午 06:29, Greg KH wrote:
> On Mon, Jun 12, 2023 at 02:53:55AM +0000, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>> It supports full-duplex communication, FIFO control, and
>> hardware flow control.
> You don't specify here what your tty device name is going to be, why?
>
> It's not written anywhere, is that intentional?
>
> Same for your tty major/minor, what numbers are you using that might
> also be in use by a different device in the system?
>
> thanks,
>
> greg k-h

I will add description about the tty name to the log.
In practical testing, we specified in the u-boot parameters
to use ttyNVT0 for the console, and it worked fine.

Best regards,
Jacky Huang
