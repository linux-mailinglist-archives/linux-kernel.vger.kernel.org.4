Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A184F6E0E22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDMNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDMNKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:10:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D439A5E7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:10:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e16so923564wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681391403; x=1683983403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8N6ip/SnShUiZJF5PnJFMV/vQc20uO53++6OpcN1/8=;
        b=s3Eg9uan1DoxtbtbslKSXceYX4kqsbBi6+HU8vN1w/s+SHXOkICbkfHgmNnUBM3x08
         cGc1Nj/U513CWQssQPITRAM9YHkJeVBpozvGufSLd2rCKfSIxf4rV/z2aQAtKHwOEBsl
         l5Gw87E3zQwI+Nx19CgfHhkQtWczWb5Osga+tB+1QMFv7HSoZyLlpJoL4ImJ+V3PNMvw
         oHqtbZNaryITAan5febfkD6jWXY8wqMIA8J0SU/O0M1XfxHNrCdEHOetRQgo+5BWXtdg
         IDDx52+EVF9Es0z9RAMgRglZFYAKp4ov3Xh8QTwWgN7C+C/IM2m/gtrtQe3/YB/p3qIi
         oJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391403; x=1683983403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8N6ip/SnShUiZJF5PnJFMV/vQc20uO53++6OpcN1/8=;
        b=VnSO0cCT0NqkQWnzChldJ3nz4McmA9KtJO4gFzGu+lu+/EFi5wgNYTcqVI9ssqLMLP
         KEa8oeOtRKubCWASIiIw6OWtz0bRI7Q4w445Pd6mN7ka0B0ofrIMS15NWOe/VSGZeymn
         8Yzn7ITwtBATwpu2U7olCk3HfHb6/Q90Foh4kpdWvuTGySGZcbrS9OkeFu/Lm1YNOFDF
         QRupEnvoIFgqW+4AnblzMWutcrDGSa284mUq4gCeWz/lpngRJtmWhAcT6MtRSNTec7J0
         6Z3OzXQroa2ypB77LnK9hi9rkTPlCgW671SHCjcKMQaiyixiJBgid4kSQ93T6t3W7CBF
         W0gg==
X-Gm-Message-State: AAQBX9ex11DCaGqMU9lOo52nHlqCk4JKNP2nl5OW0ZyybG1m7Say0Cf8
        aaMegatOPMw6h3eHMwBLjwLTWA==
X-Google-Smtp-Source: AKy350ZQklHcW60c73SK81jWykcSOsZehAfT/yEjr6s3qv8cMOMqgIwNjHwWoYnv5tz2i2ZKRDA8Ew==
X-Received: by 2002:adf:fa49:0:b0:2e4:34b:92ad with SMTP id y9-20020adffa49000000b002e4034b92admr1568946wrr.64.1681391403556;
        Thu, 13 Apr 2023 06:10:03 -0700 (PDT)
Received: from [10.1.3.59] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d470c000000b002c70ce264bfsm1266955wrq.76.2023.04.13.06.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 06:10:03 -0700 (PDT)
Message-ID: <808c0fe9-2b39-1b98-31ea-a6ac46ed4cd2@baylibre.com>
Date:   Thu, 13 Apr 2023 15:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] ARM:unwind:fix unwind abort for uleb128 case
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Haibo Li <haibo.li@mediatek.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        xiaoming.yu@mediatek.com,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Alex Sverdlin <alexander.sverdlin@nokia.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, ardb@kernel.org,
        catalin.marinas@arm.com, a.anurag@samsung.com
References: <20230413073429.40050-1-haibo.li@mediatek.com>
 <CACRpkdb9sn25KdagSVmY5-XX+LypQdMEj=oBpnwOhYvS2Ny1xA@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <CACRpkdb9sn25KdagSVmY5-XX+LypQdMEj=oBpnwOhYvS2Ny1xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2023 09:39, Linus Walleij wrote:
> On Thu, Apr 13, 2023 at 9:34 AM Haibo Li<haibo.li@mediatek.com>  wrote:
> 
>> When unwind instruction is 0xb2,the subsequent instructions
>> are uleb128 bytes.
>> For now,it uses only the first uleb128 byte in code.
>>
>> For vsp increments of 0x204~0x400,use one uleb128 byte like below:
>> 0xc06a00e4 <unwind_test_work>: 0x80b27fac
>>    Compact model index: 0
>>    0xb2 0x7f vsp = vsp + 1024
>>    0xac      pop {r4, r5, r6, r7, r8, r14}
>>
>> For vsp increments larger than 0x400,use two uleb128 bytes like below:
>> 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
>>    Compact model index: 1
>>    0xb2 0x81 0x01 vsp = vsp + 1032
>>    0xac      pop {r4, r5, r6, r7, r8, r14}
>> The unwind works well since the decoded uleb128 byte is also 0x81.
>>
>> For vsp increments larger than 0x600,use two uleb128 bytes like below:
>> 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c
>>    Compact model index: 1
>>    0xb2 0x81 0x02 vsp = vsp + 1544
>>    0xac      pop {r4, r5, r6, r7, r8, r14}
>> In this case,the decoded uleb128 result is 0x101(vsp=0x204+(0x101<<2)).
>> While the uleb128 used in code is 0x81(vsp=0x204+(0x81<<2)).
>> The unwind aborts at this frame since it gets incorrect vsp.
>>
>> To fix this,add uleb128 decode to cover all the above case.
>>
>> Signed-off-by: Haibo Li<haibo.li@mediatek.com>
> Thanks Haibo,
> Reviewed-by: Linus Walleij<linus.walleij@linaro.org>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>


Regards,
Alexandre

