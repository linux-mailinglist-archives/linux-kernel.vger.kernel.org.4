Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA176DBEB5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 07:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjDIFNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 01:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIFNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 01:13:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168663AB7;
        Sat,  8 Apr 2023 22:13:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c3so2392888pjg.1;
        Sat, 08 Apr 2023 22:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681017216; x=1683609216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRhfT/jJt56gQonvPXvx6IVAYr5d71sWEwaXQOdTWt0=;
        b=isiRT4JSi/nUXDJfYQyWktqVz8AQfSNpmeKeScWMXr8OIsOGpAGG4P9p0E0N1Ann/3
         pxBUknP/n1E/Z95Cep6IFmKkVcNPpYCvvy0XjUbCdM1hA8MWtWraRiM6vIz151sPx3Rc
         5VKPbB4PCzUBYQ3LAxJIBZ+uDCCMVnHKAD7uxoI1rqaBS4PqHRzZYCmqEkRenyOE7IiX
         KWq8gee0JSMDCmTo7o/m0zP/NiERRLXXKl/FWALL5u10f2MJ9tIoAmbmIJ5fBsBKPHXI
         W/F6Jvq/HZUQROhEDha4rbHmDSW55UZtWFgxpY/o7TweouuJQ5mo9yAsEjAMoHBIFUY5
         zrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681017216; x=1683609216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRhfT/jJt56gQonvPXvx6IVAYr5d71sWEwaXQOdTWt0=;
        b=fXIgFuCqcDOrtW0Y6HSQnGKqOaRkQXhUwVk6TMa3pqKaZ8FSAfk0PyyNMnBERKP8lo
         RHtrUQIkdaU4/BHbzEYzEYWBffRleuUyFBhFYegpUx7cn8VI5KrfA99VcTXLXEe5Lut/
         lMfqUi513XLQg8EUaqSALzYIA89zvR9l3AiSJtmr4lFy1IoNiHWrtBVLSm/gR9E7pT1R
         fVPmxD6GFYcQHKYKjBDzJON6WCSqgPOo0oPI9kCIqFve++X85O//27RrHbBTOm4Y4z5r
         VywtEtmPjQP1e6JKvShULHvMKVJzbhgeB1EMPDay6IwnS9YX4sRHe7fNtWXpvTZ9LXDz
         X/Lw==
X-Gm-Message-State: AAQBX9cjtqsCqRwjI8muBzYEkQKwrYIvwHlEYqeG7vG3FoH5DlaMuXBr
        KokJ/oNS58Hx6lJPs12BfLbwqIRTXu4=
X-Google-Smtp-Source: AKy350bjXZ6cnnsqNjdK1bVngXxF5K96JNo6lECfmQ6cO6XmA8K8KYeIGEzbDhRfSxCe/pVR7u2e5A==
X-Received: by 2002:a17:902:f0d2:b0:1a5:150f:8553 with SMTP id v18-20020a170902f0d200b001a5150f8553mr4097650pla.0.1681017216477;
        Sat, 08 Apr 2023 22:13:36 -0700 (PDT)
Received: from [192.168.1.39] (M014008005000.v4.enabler.ne.jp. [14.8.5.0])
        by smtp.gmail.com with ESMTPSA id jo18-20020a170903055200b0019a70a85e8fsm5294960plb.220.2023.04.08.22.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 22:13:36 -0700 (PDT)
Message-ID: <64b5504d-c81d-f77e-da67-c6d9e76aedd6@gmail.com>
Date:   Sun, 9 Apr 2023 14:13:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2
 appliance
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230223132502.2045-1-musashino.open@gmail.com>
 <20230223132502.2045-2-musashino.open@gmail.com> <Y/d7gjqQCKKXMHqj@lunn.ch>
 <7d4a218d-8b8a-5a1d-eff8-e154bfde69be@gmail.com> <87jzyn3dv9.fsf@BL-laptop>
Content-Language: en-US
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <87jzyn3dv9.fsf@BL-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gregory CLEMENT,

On 2023/04/08 0:34, Gregory CLEMENT wrote:
> Hello INAGAKI Hiroshi,
>
> do you plan to send a v2 soon based on the reviews you got ?

Yes, I'm planning to send the next series.
But I don't know the details about "documenting the board compatibles" 
suggested by Krzysztof Kozlowski and I don't know what to do for it, 
so I'm pausing this contribution...

>
> Or if you already sent it, I missed it, in this case could you resend it
> with me in CC ?
>
> Thanks,
>
> Gregory
>

Regards,
Hiroshi
