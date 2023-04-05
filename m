Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9EA6D7E24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbjDENzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjDENzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:55:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB5D1706
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:54:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5002e950e23so425252a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680702897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNwzqllpOhIXJDrmKgEGVXZ9A1+oCPDYJpWJknDn8gw=;
        b=D5v3TP5V2tZMZbEaoAxg/HlME9pRWlPhc5t26ZANYrhu67A2c738rEFUYvZGbQpWHf
         HH1jgThtqjaU7H79/uMTiWUtin5uLai0lqR0dOy86PeCgugjB5ybE8pAP+fucmzPeMB2
         4Fc+3XD7pif4zTmxVxnBPLIQAmjsGKiXStAciBPbC5giiC8Hgakq+wsOwMVsJQ0UEaSo
         c32ADPZidtH0er7rmu9GL3cOFd+zozPf1LHOq7yMIfpl6Lc1vbe79s9jHs+Om3Hjvik4
         2USheGmcD0nKU7G4W5COQ6sX/VsB9J0ZpxYYXLVxA/j4lgW6ZQoOln8Umt8U2UE55sNR
         pZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680702897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNwzqllpOhIXJDrmKgEGVXZ9A1+oCPDYJpWJknDn8gw=;
        b=JxPLLOu7JurNw0WcZ/GkOH+Z76hzEGOjO+NiRVbxBzNn+en7khBqL2m3AQDWsTbTD2
         ugoIZHTZP7sl0LDt+VvFL71gOwOsN/GPZMli6G0J2hhFtrY0EiSyu6Rq++FEGO5MDIgn
         O5gHp2XBQ5dLeM5Ndi/0S0cQlg8naOVH1bgHf8/bb9B/QfSPx4BoeAzRkcnR44ciUWr+
         zxk1gJMpKHr2Cnc0xjmczGojlhKXg6MLWza4w7bTCBLqGVVCTByhSc+xv2eS3jCuxbc8
         IbeBTvI4eFvyI32yTjQmi8WvYvx6q9HYU25+WiXz9ZOXeXRT5KxPMviPjN1EDJvYkF+f
         +hEA==
X-Gm-Message-State: AAQBX9c9fA7ZbkKpf+O3cTz5oRQFKM3ITGFvK6QTx18nRGmd1WlH5jwO
        Lw1AumcvI7fDcd+/qfYAg8UrwQ==
X-Google-Smtp-Source: AKy350ZJkw4cGGvlpzYnTrs6V+agNr6QqkmZAlOlP84F9g3Cgs6g5fHR3ftYghWJukJy6rU+ITl7xg==
X-Received: by 2002:a05:6402:496:b0:502:3ff4:4d76 with SMTP id k22-20020a056402049600b005023ff44d76mr1858152edv.27.1680702897006;
        Wed, 05 Apr 2023 06:54:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id e14-20020a50d4ce000000b004fadc041e13sm437798edj.42.2023.04.05.06.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 06:54:56 -0700 (PDT)
Message-ID: <e38658be-1a2a-bccb-3f30-18f1b031f71d@linaro.org>
Date:   Wed, 5 Apr 2023 15:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/10] memory: mtk-smi: mt8365: Add SMI Support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
 <20230207-iommu-support-v2-10-60d5fa00e4e5@baylibre.com>
 <9847bc48-c96c-3599-e876-bcf9ebf1522e@linaro.org>
 <CAFGrd9pBdaHLGUZHkaz2_XKafyX=dxu9UckQxrphg52EG=A1SQ@mail.gmail.com>
 <8fc3dd22-79df-32cb-c219-896eda8fa986@linaro.org>
 <fd24877a-5fae-5434-dc56-61ab35ccd820@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fd24877a-5fae-5434-dc56-61ab35ccd820@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 15:06, Alexandre Mergnat wrote:
> 
> On 05/04/2023 13:45, Krzysztof Kozlowski wrote:
>> On 05/04/2023 11:53, Alexandre Mergnat wrote:
>>> Ok, I will move the driver patch before the DTS patches in the next version.
>>>
>> Or do not send it together at all, which might solve your dependency
>> problem. According to your cover letter I cannot take the memory
>> controller bits, so I am waiting for dependencies to hit the mainline.
>> Alternatively I will need pull request with stable tag.
>>
> Ok, I prefer send the driver patch in another serie. That will solve the 
> dependency with the DTS a least.

What dependency? Why do you have dependencies between drivers and DTS?
That's a no-go.

Best regards,
Krzysztof

