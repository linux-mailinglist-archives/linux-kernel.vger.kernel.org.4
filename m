Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646AC6B7FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCMRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCMRzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:55:51 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F66A3802A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:55:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so51984211edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678730146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JlcrnhxuRd6rV69CEfffZDmaaf6zxlWaBbyK92fytus=;
        b=zrT7N+L4i1OOmHooCUtuKQxSOa3Hl/v/al9JW1jb/ccugW//3tZctpe8h8XqOLPVPd
         28FTmDGBe/txValWJ4yjwNiFKkBvn1KymKVGg/ybUJgLljp//aUkiRZ50xC7kl4Tbbbj
         aiXj4BhUOmS+nYtWQ9V3TMbGRJDLU9OTqUWEyvNLqXpbcdsbGJnsYaHtBcEbR1NxYFSh
         3TPQAbpAovUx1vfywwYojF4mNL5fHu7ax1zJ99q/wW1LOwJM2pkmAOPuzXjU+QLl044f
         3i19gjqQNSucPGQdcdgsl+/fuoVl0xUvb3nM2+ZYkuy0CI5+fnQwDijoTSmIFrC58wP+
         1Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678730146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlcrnhxuRd6rV69CEfffZDmaaf6zxlWaBbyK92fytus=;
        b=pkFSzlKO6/cgugJkhl4w5lo4xgA+8tdjbzwE6P4NpsS+x5dRZf97N6R2MHSYu30Hs+
         TVH5JHyKLO805Eog2KWR9XixoWjjhzkA3EdpUq9Hh4nCVNdFqJaxCt34vmwrDg4P0tP5
         ZTnOzKLFOqM9X6UwuUaX48VJH925FwBSIlkhFP5BypKuyk+WLSKr0zSRvO76IMG5Lecp
         /OC6/x3Jxylh+23IMdD5mxTnEgC5ae9abPnEn0DePvDdvcm8FGUxgiZcmcvSpgauMTkx
         FvyHvYHyKdbVpUGLn8ktkl1QeGtPLvQTmJQqj+NLW5iXl4mtzFNFeUmjqJnHpl/XU+jk
         sONw==
X-Gm-Message-State: AO0yUKXRgGDsobLo7HNJjJeoIypS6xN4AYEmim1Vl07sNvQJuw0BiR+G
        +p3KpuCkvWk1N34flyAPlqTg+g==
X-Google-Smtp-Source: AK7set+F+T0O61QUAlFi1WKTG8LwavM0EbkptZ54DncABKfzh7oDSD7DKJnsUeNG6kb6uO0yUhNKyQ==
X-Received: by 2002:a17:906:2843:b0:8b1:15ab:f4cd with SMTP id s3-20020a170906284300b008b115abf4cdmr31342450ejc.53.1678730146574;
        Mon, 13 Mar 2023 10:55:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:69db:4882:d071:27c4? ([2a02:810d:15c0:828:69db:4882:d071:27c4])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906718700b009289de993e2sm65306ejk.216.2023.03.13.10.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 10:55:46 -0700 (PDT)
Message-ID: <6c5045d9-4f4a-5018-3f3f-7746b08ab2b5@linaro.org>
Date:   Mon, 13 Mar 2023 18:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V3 2/6] dt-bindings: timestamp: Add Tegra234 support
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
References: <20230310190634.5053-1-dipenp@nvidia.com>
 <20230310190634.5053-3-dipenp@nvidia.com>
 <f6d9c84a-1c75-d9b4-59ed-39d6c5b310a9@linaro.org>
 <b4195142-6cfe-df3c-6edf-0c40b64ad02a@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b4195142-6cfe-df3c-6edf-0c40b64ad02a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 18:05, Dipen Patel wrote:
> On 3/12/23 8:47 AM, Krzysztof Kozlowski wrote:
>> On 10/03/2023 20:06, Dipen Patel wrote:
>>> Added timestamp provider support for the Tegra234 in devicetree
>>> bindings. In addition, it addresses review comments from the
>>> previous review round as follows:
>>> - Removes nvidia,slices property. This was not necessary as it
>>> is a constant value and can be hardcoded inside the driver code.
>>> - Adds nvidia,gpio-controller property. This simplifies how GTE driver
>>> retrieves GPIO controller instance, see below explanation.
>>>
>>> Without this property code would look like:
>>> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
>>> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
>>> 				   tegra_get_gpiochip_from_name);
>>> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
>>> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
>>> 				   tegra_get_gpiochip_from_name);
>>> else
>>> 	return -ENODEV;
>>>
>>> This means for every future addition of the compatible string, if else
>>> condition statements have to be expanded.
>>>
>>> With the property:
>>> gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
>>> ....
>>> hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);
>>>
>>> We haven't technically started making use of these bindings, so
>>> backwards-compatibility shouldn't be an issue yet.
>>
>> Unfortunately, I don't understand this statement. The
>> nvidia,tegra194-gte-aon with removed property is in a released kernel
>> v6.2. What does it mean "technically"? It's a released kernel thus it is
>> a released ABI.
> 
> There is no active user of that driver, so even if it breaks 6.2, it is fine
> as there is no one to complain about it.

How do you know? It's a released kernel, thus how can you ask millions
of people if they use it or not?

Best regards,
Krzysztof

