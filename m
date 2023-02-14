Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B745A695F49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjBNJdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjBNJdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:33:40 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513626EB5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:33:33 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id by3so13626351wrb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfs+Q3/NCe1EQO+5Ft904kfT2AxcjZbiWamdz5bJvaY=;
        b=NBHd90XfEE+9tYmS2wB/jBXfk75s5nVkMimrJFGyXaOOIMZa0vkXAJOOHXF1u5XY9t
         xplGnNakc/TE5VfShtEHgvbB8At5wt8XtDhR7SuH29r0Y7aMzwZPloOMait+35FZHqie
         NYvksuYtcQdpbwfkMJ4o7bwaDzn2BZi9L9H6OQ9KmTRHLN/Oq26c1dD5rNv9ZEEbv2oX
         I1plKNd8RdeKsdQXmlEtI6hsz0cq8Lh0+aFPmuEBE1LWPiXx7qgQbYC49AhIaJJZj+sQ
         6BRubrd+kaochlSJDFS5OXlEnPM4V3JcargCwm5zMCrAq6ep0eOqWJcIPRi7r3D+NONd
         hsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfs+Q3/NCe1EQO+5Ft904kfT2AxcjZbiWamdz5bJvaY=;
        b=fMLVrvpuUqtdooWyBQZ3MdVgau1R25teS/DjcN+9eHivK/cZ6w4Hud6XhieMQ0J+hJ
         I3B5SINwOLPDzGUYv6p3SDgYo9PvrzfRZuRvtxPBJGES6gutOwrgicjixvIjMH+IVeLk
         yloNZiXqLg7rcv759Is9j83AEuKQofan8ARJ5Ux6s1i8cw9UjdXe6//NjRnwQRJc14Rg
         wpODaeMB8Q/7oEu1jWyrPHdnjls/do241zNJPvouzoPwwnRw/0PQltk4lu25URo05ria
         7MzVKUP35ZHfF9a4jDMBZFTQPPV5ihpaoFKPB5HJvp3cyR4aZY9HC1utWfq0VO3Oc+Oo
         Uyqg==
X-Gm-Message-State: AO0yUKW90GVoUvki+gIz5Wiq6ZFwPTNbyAz8xPFm0vxM0Vqqp8hJURaG
        wtIOci2jCTFLA1ds1JvGqPhbvA==
X-Google-Smtp-Source: AK7set+dVtdtCDNLgA5545ILg7PF/u84//tVlT2VUmHK0xnzko5rFmzjH7eBd7V/o9AYBTmJjQEE+g==
X-Received: by 2002:adf:f8c6:0:b0:2bf:95d0:fa5d with SMTP id f6-20020adff8c6000000b002bf95d0fa5dmr2093230wrq.9.1676367211857;
        Tue, 14 Feb 2023 01:33:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n6-20020adffe06000000b002c559843748sm4162918wrr.10.2023.02.14.01.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:33:31 -0800 (PST)
Message-ID: <7f2e556c-ee11-fe4e-f4d6-94c761f976d0@linaro.org>
Date:   Tue, 14 Feb 2023 10:33:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture
 dependent code
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
 <20230213200519.889503-4-sergio.paracuellos@gmail.com>
 <f105c7a8-8821-1e7b-af46-13a46971db63@linaro.org>
 <CAMhs-H_Cd9F+UWWe+dAA89r_huX_srtsgjh1qus93nGehQN1AQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H_Cd9F+UWWe+dAA89r_huX_srtsgjh1qus93nGehQN1AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 09:54, Sergio Paracuellos wrote:
>>>       return 0;
>>> @@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
>>>       if (!drvdata)
>>>               return -ENOMEM;
>>>
>>> +     drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
>>> +     if (IS_ERR(drvdata->sysc))
>>> +             return PTR_ERR(drvdata->sysc);
>>
>> This should be the backup/error path for original code using syscon
>> property. Looking up by compatible is really not portable/re-usable.
> 
> I can change the code in the way you are pointing out here but...
> Why is it not re-usable? Compatible is not supposed to be changed
> since in other cases the DTB ABI will be broken. I am totally lost
> about what is an ABI breakage, then.

How do you use it on other platform?

Best regards,
Krzysztof

