Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E356D1D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjCaKDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjCaKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:02:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AEF22EA4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:58:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i5so87622173eda.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680256623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4H+SCpNyTk7eZ1Jx5ghhVexUUtM7yLUPN8EpooXX/M=;
        b=hUovmKNZisr61xrxlb4+6KtmntMOhl0IMfd+DJEOXSfOsvuKb7sORlzRt+/ceXeYXn
         gPAucay7kSxn35/SKp+YHtwUloQLtpOo5di43ccGjIT7QAwQ17O58TEFidSJN+tKGUW+
         aJNRNXJbnu8rPOVXADq1ek0H1V9UEKWzG0UldpGta+GmpqOuFNFP5oYNPOwwNG8/RXUP
         cwxiveTD4mpcDr8tc3Vu0I4m7D7XV82eYwwh2ft5DkQAigFz452AnouqvkPop3d3dena
         zSrIiarCr+zaHd581SupL462xYP8GiWp7jQifLjVphVEQMxTO8ELL+lxmKhvr3Kq+TW3
         zU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4H+SCpNyTk7eZ1Jx5ghhVexUUtM7yLUPN8EpooXX/M=;
        b=EF/JbLSlhvbgxVlQOK1L8iHujxWJHkYHJ2Nt1YPf/Sn7tV+o0WF3sCikcOnsr8VWKM
         aIuU7fPdGcU4soAEMEjFbSyLS+WHUOoei2rQoU6DTi4I1pTNEzR6H/oyEfHQYvlubOWF
         9KSX8B1zebgihFp932sqw95jhSn6yLxe+9juVU4jAXYKGShDMFyjSdN9ClIc0ed8O81P
         3/T2bH8y+bBdrzE/KZZVT50mTAlLHYtts6cA0ncT7aUhvZ6YV6ZZfQhw8T2YiPwsmg0G
         Fqo9rSX5aQvDJOQWcmCkD/v9f3r1adqTY/V6A4Ra4UE6C6p+tsO8jWMy7W6PhcKdrKUS
         eFKg==
X-Gm-Message-State: AAQBX9fVCTECOtf/mXyNTIv4UBL5Cjrq8TZc9WIu+UyYViipQEGHS1Uj
        zXSlUhFj2itohBPvIMVhjve7OQ==
X-Google-Smtp-Source: AKy350bVjpNe+axO1RpW3WbS1yKuQF8XC3/Ty5b4nGHQ842OXSXLHDd90fAIc4I9S+uwldPn0fRXEg==
X-Received: by 2002:a17:906:5d03:b0:92f:495b:bc7c with SMTP id g3-20020a1709065d0300b0092f495bbc7cmr10004474ejt.23.1680256623575;
        Fri, 31 Mar 2023 02:57:03 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b0093341746105sm800904ejs.117.2023.03.31.02.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:57:03 -0700 (PDT)
Message-ID: <b286776b-f50d-e545-6b21-6dc3d90e6c90@linaro.org>
Date:   Fri, 31 Mar 2023 10:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/4] ARM: dts: at91: Set sst26vf064b SPI NOR flash at
 its maxumum frequency
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        claudiu.beznea@microchip.com
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230328101517.1595738-1-tudor.ambarus@linaro.org>
 <3fc2611e-3cd8-d9ae-5ff4-d33fda8c0099@microchip.com>
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <3fc2611e-3cd8-d9ae-5ff4-d33fda8c0099@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/23 19:53, Nicolas Ferre wrote:
> On 28/03/2023 at 12:15, Tudor Ambarus wrote:
>> Changes in v3: Update S-o-b tag to match author's email.
>> Changes in v2: update value of spi-cs-setup-ns as it was changed to u32
>> since the first proposal.
>> v1 at:
>> https://lore.kernel.org/linux-mtd/20221117105249.115649-1-tudor.ambarus@microchip.com/
>>
>> ---
>> SPI NOR flashes have specific cs-setup time requirements without which
>> they can't work at frequencies close to their maximum supported
>> frequency,
>> as they miss the first bits of the instruction command. Unrecognized
>> commands are ignored, thus the flash will be unresponsive. Introduce the
>> spi-cs-setup-ns property to allow spi devices to specify their cs setup
>> time.
> 
> Now that it's tested:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> to the whole series and I'll queue them on at91-dt branch and changed
> your email address when doing so.
> 
> Thanks for your patches Tudor, it's appreciated! Best regards,

My pleasure, I'm happy I could help. Cheers,
ta
