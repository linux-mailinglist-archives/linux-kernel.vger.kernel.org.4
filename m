Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD46B3CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCJK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCJKz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:55:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB9F98F5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:55:31 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cw28so18826028edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678445728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC7hm2nRazRUAYiyrvvNyUIuBUW+XVoXe8jGjfF3+FI=;
        b=ydSatIflL9OJ7OfdnzsIrIarQk0QU6JeIdN1Eqrmiwlo8WzzX7xhbtdERYf4WIH09v
         ZuAuCfWbpcd9/dBQPOtHC1s8IouRZ+d3EtnEyf9vYIIPlx39EZjEAbEy9dWltCXOsIJ5
         C+xnNxjxQ250QIH6RHO8A97m+IjK3YRQVXu5KfKsOfO3PrfcOur2bFO2HaNALwXkQXtt
         HWZZb8jQZqzz+wrOZU7kABasDTd9VVZjUpWbsMSV0N7/meCRVAiuNQg0/D4kC/9KC8ya
         H0+eZXu1MnkdMoT4YSxJ9FRaE4yMaG/6DIMrKrQIfhViuYsUBy99YrkVjIdNVfhCrNWu
         DpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678445728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC7hm2nRazRUAYiyrvvNyUIuBUW+XVoXe8jGjfF3+FI=;
        b=IdiWuXF9NjUB+MDemQpNT1YZ/mP2+T1/D2TgjOevz2yLyoHJkJTvaRowwFcN4cnRAl
         4eKmBK6UHC+K/yf4/173LGtyE9eTLRGUxG11wYxCC5Akj3WRW2AsSs2RsJkRq880nFQU
         dB9gOUSaHppvzOiIeAzT4M+VGfclut4ZnzP2K9K/cGzF+lzbl1m2Bylo8m6hTfSb3B0R
         hmFpZwFS+Mku52Akfj6Sme/GUloMCezuZJsylk+qJyRvgZP/5RPGGpTVfwv/S+kkbuVE
         kU8f3gBJSkhDMGwBXFXzcTLSxhJkNzBLYupmKVTyDK1UZeX9eXJB+D7bdqsxfZ5Ie70a
         Lfag==
X-Gm-Message-State: AO0yUKUK0KrscKaci6vmUvh2sYil5Bb9dLmuYjH/YlVuO0H90WzbxTx0
        +0tzsbq2ayzPXRnQbf5GGSWt3Q==
X-Google-Smtp-Source: AK7set/GP3SmL+YTmqa3Ysong5dQ/XeLO92S+qA3OrI9jGY15/72iN5GdYBxWlCE4G3vI1e+t+U8Aw==
X-Received: by 2002:a17:906:b04e:b0:89e:8c3d:bb87 with SMTP id bj14-20020a170906b04e00b0089e8c3dbb87mr27304419ejb.71.1678445728064;
        Fri, 10 Mar 2023 02:55:28 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m9-20020a170906234900b008b95c1fe636sm800812eja.207.2023.03.10.02.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:55:27 -0800 (PST)
Message-ID: <2580b45b-5d66-d716-41f3-4050236e89c2@linaro.org>
Date:   Fri, 10 Mar 2023 10:55:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 09/20] nvmem: core: introduce NVMEM layouts
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
 <20230308153200.682248-10-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230308153200.682248-10-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/03/2023 15:31, Miquel Raynal wrote:
> +const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
> +					struct nvmem_layout *layout)
> +{
> +	struct device_node __maybe_unused *layout_np;
> +	const struct of_device_id *match;
> +
> +	layout_np = of_nvmem_layout_get_container(nvmem);
> +	match = of_match_node(layout->of_match_table, layout_np);
> +
> +	return match ? match->data : NULL;
> +}
> +EXPORT_SYMBOL_GPL(nvmem_layout_get_match_data);

who is the user of this function, in the current patchset I see none?

On the other hand interpretation of match data is pretty much driver 
specific i see no reason for this to be in core.

--srini
> +
