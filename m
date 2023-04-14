Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFE6E1971
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDNBLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDNBLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:11:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71130F3;
        Thu, 13 Apr 2023 18:11:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 21so8715246plg.12;
        Thu, 13 Apr 2023 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681434710; x=1684026710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+r3aux4yucH9SfhX2QxRIhHkcAuFbVjbJD90j5NQDME=;
        b=LTiTK/swZV7NKEl/gDQ0Kwa8lG0QRiTNpM1bhk4UU41HQuNi9JvxoHuDzJapEkGiIc
         blCXwG1azwi7xwTxv9JdkUjPiaEHYdfrDPfkGAll4qwo8RzViZDWtaJ++2ZlZ57+6QfN
         l92H1aSvlNf55kdN/jJg3bSceXHk+7ExmBszbvjg9gV9W74dT6OjUgpGUlAY7eSnJR6N
         wjkOarxQXE6IucpxP+Y0m8+M9p47ONQS++51wdNvgMPVVCY1Jb/5tkzEboDUcxINpDtS
         W5vESFC/L20aEt0ijgh7o3pz8Qf26NJlWX9KSNOdal/6hNzQYpEfHmWRMfCty40vsYH5
         ns7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681434710; x=1684026710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+r3aux4yucH9SfhX2QxRIhHkcAuFbVjbJD90j5NQDME=;
        b=bkvJLZBgEtobCIfQaE/BF2tEJzAoDs4UN+Ha5rm6VdwDvh5rEy4G0sxlIsvwPhlOEA
         7Jr/p3ywuaaxNXhNQdJufG8U0XZbqmAB0QflHHyESVm2ewYJRe9RszAwDfUScvotocyL
         Kj5UPDAsOGIajvzHXl0oUfPdSO/Cnu3M9DVj87jZKdsYIPNrRedV2L+QRQ36cHuTE243
         c3Kx4tt1zuNIhcFG/RviJqGoxRVV2vlGPczu/v4yNDXrBkh7LrAoR7zuOUJTi0AE3r1u
         vOgSSPhUVrruZ0wk8Ek9QcMofoFIn/SAMoYKir3afhiHoI/ovuFzDXv6akBGCc5M4+zP
         p/Bg==
X-Gm-Message-State: AAQBX9enm73TV2EliM6D040mAAVa23T8hgzlFqw3bqbZn1+i9TEXwzaN
        EdYgcZ4eJdLtrjfDhdUMGko=
X-Google-Smtp-Source: AKy350alZnXk2cEN2Fxwx4ap7KVspTrFpi0rTKMdrKoiKVa0Y51FgzPgsfTKRY54nCDiY47kD8MhqQ==
X-Received: by 2002:a17:903:4281:b0:1a1:bf22:2b6e with SMTP id ju1-20020a170903428100b001a1bf222b6emr891939plb.43.1681434709602;
        Thu, 13 Apr 2023 18:11:49 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b0019f3cc463absm2074638plb.0.2023.04.13.18.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 18:11:49 -0700 (PDT)
Message-ID: <69b0aa3a-f5d2-8310-81ae-61d379db0d3b@gmail.com>
Date:   Fri, 14 Apr 2023 09:11:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 05/12] dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-6-ychuang570808@gmail.com>
 <d11b6acb-b072-9496-5ad6-0635357394f1@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <d11b6acb-b072-9496-5ad6-0635357394f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


On 2023/4/14 上午 12:47, Krzysztof Kozlowski wrote:
> On 12/04/2023 07:38, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add Nuvoton ma35d1 system registers compatible.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> What about the tag? Why did you ignore it?
>
> Also, wasn't this applied? Why do you resend (incorrect version)?
>
> Best regards,
> Krzysztof
>

When I was making this patchset, this patch was still not merged.
So I'm not sure if I should remove it.
This is just a resend with no updates. And I will remove this patch
in the next version as it was applied.
If possible, please add the following tags for this patch.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Lee Jones <lee@kernel.org>


Thank you,
Jacky Huang

