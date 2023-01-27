Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF63267E5FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjA0NBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbjA0NBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:01:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD56AFF2D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:01:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso3399753wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMnVq+NB+1tK09uygEs6Fm8LZUyhtPlPvBLFWoCDRCQ=;
        b=ws+0uP49Ft1pY5oydosIOFN6CHCn3TOmSNw8mQRV+iFyah1TsBAYK73U8COOY8Kd4j
         IIWKZp9ldeOxCabhO77lDQ6J94RFmgFzpvm5mI6HA1Bfx9kXXaNDvtgkDIqitpfsqJEF
         gWXOhLqslYtdk/5Any2/uNel14uBAsGkok1ew1kKA0ZoL5hdMqbERI/Mm2AxyPenpUka
         lGq0oRiKmN1liBZF4M1WlrIMDAUr6NflveUlVWF5ZL+Eu6/mLv4QENn/tg0LxbvS5r4K
         seCTSKFHGEgN2uy1SRKS1QLPs6dZiKaJ7DWLE2L50sUGTttAt8CxOabVeXGcFbtg3L68
         NErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMnVq+NB+1tK09uygEs6Fm8LZUyhtPlPvBLFWoCDRCQ=;
        b=nI37O8fwk0QwglbPzLx9cPEsSYgQSq7vaBCaThf2rwe56aZNm1LXjiAGMUZupc1ud1
         WNLL9GorBRVwXGyWCCs0/W29JUQZjVi+BlweIscEavvyGvyoNW233/eZVW+0eXDpGhIs
         WB2wUc8fJi87iwLDG5uFRXaOXvKH0csN++2w3H5FwuTeWxiUJj82ceaNa5pqhbZNS/Z5
         5L7Q9BA1A/YyP0Q9HAwcwC5paqvyIXRswYO6jGlw5ekBXmpPxQJftdiBh89VsVIrwOjq
         oM3tqbtQHh2qMhQ/dNjshK0d8q+RR9gul7RdJyKrcQjve6Ew6mPgjhx0IDjcS4Kvl04X
         IBGA==
X-Gm-Message-State: AFqh2kqYN7ttmq6tZ2gK5NasTtj8xXhZplq+Y9i+4YURUqZO19LZJuJ1
        n4zIUh7b8W1jBWol2bs2o876Ig==
X-Google-Smtp-Source: AMrXdXv5XJDdHjgDNxyUzjBB+zeGRqweHYFXYuwkOkmbcFnD/EPUK7PVxWlSwcu5tk3ZHJLK2Qu+NQ==
X-Received: by 2002:a05:600c:1da6:b0:3da:107e:a1e6 with SMTP id p38-20020a05600c1da600b003da107ea1e6mr39486790wms.17.1674824475303;
        Fri, 27 Jan 2023 05:01:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c47c700b003dc3bbdf518sm1321433wmo.21.2023.01.27.05.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 05:01:14 -0800 (PST)
Message-ID: <468aef98-2bd7-03d5-0f83-dc58bc4738e9@linaro.org>
Date:   Fri, 27 Jan 2023 14:01:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/4] arm64: dts: meson: add support for BananaPi M2-Pro
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org
References: <20230127100236.3385154-1-christianshewitt@gmail.com>
 <20230127100236.3385154-5-christianshewitt@gmail.com>
 <a35f7f09-eb19-6cfc-2053-c6b340f10cbd@linaro.org>
 <356B9EBF-B9C4-4CB0-9F83-9E7A62F93F65@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <356B9EBF-B9C4-4CB0-9F83-9E7A62F93F65@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 11:19, Christian Hewitt wrote:
>> It's by default. Did any DTSI disable the sound node?
> 
> No. I’m simply transcribing from the original M5 dts (with edits to omit
> the audio jack bits) and the sound nodes of other Amlogic dts which have
> long included the same. 
> 
> Q. Do I need to remove it here? (sounds like a yes)

Yes

> Q. Do we need to exorcise/cleanup the same from all other meson dts?

Yes, please.

Best regards,
Krzysztof

