Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9626902F6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBIJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBIJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:11:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D4783DE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:11:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y1so1078439wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kxvn5OMzyzBqETwPzu80u7hwe8zuuXrGX7TuXlP4qi0=;
        b=hdwCkAFjfCYSHKqw8+smBlNg4fCdRKpQTd4YEielegmV0s3MRAorwpnoPeMHJRHWHZ
         GSvgXupwKUkkicopfmiS+Mhm7bdK6XBHbi9bzTFk2R/ZzSb++inmoaePtx+UHfa6OMs7
         sOXNRKvNfjnJUQimFfTKrLj6FaEdGF3O+xWdLkEVZM227bDBXkECuoNcOQzzIuseQ3I3
         /UyOU1t2PmDa9FhOgyXYwE6+wn7rO01aREcZeah/2FK6ILNklzPOPZd24gaq7OWtqYS2
         aZJPCbLPFraHKUl8NkZtCXTY50WKCHbt5D0BYV0wu5NcvhmoLDLi5wzzA5EeBOo3fmRO
         YpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxvn5OMzyzBqETwPzu80u7hwe8zuuXrGX7TuXlP4qi0=;
        b=jIDSTAYLxUMNRkRTB9t6iMfErHg0kUCP2r/WvyBW5v4qziN2P0Yoam3GpRfp6ksLTB
         w/dYEb95Dh3xAaMtV53Ti8QuX++TPTUvUcIAvDg0cKxQS7pH9RVpQY6ypjMKY2/esdwL
         teS4Duh08yKA+1LYP0yiV6NtNRh7RAaM60/E5JQiQR3eEx58LpMmu14rcNrus1Hj0gSo
         0aKsC+x/7joscBa9vluuP9VC+8wk/VjNWMuECLpwQjUKI6lgfq3J/AukIAXW0UkLQHbQ
         Af5U6oTnoURa4ChZADPXms1tyJalkuW5tYgViWDvgBCcRn5dTFF9pAt70z+20D8xL+/q
         Nbfg==
X-Gm-Message-State: AO0yUKXCDic90UuKhFRyYYhIbbZTOVJLw6eix041URNe24K4K0Gt+i5W
        5XehAfXfMvSYsOBWqsW0fl2m4VHJkKpCHuno
X-Google-Smtp-Source: AK7set8552ZGuPTfdL9T1or1CEjqNNE+WiEnvbxdUuMToBkzo+xCAMUKemqN2e8NlMREeQahOvMNug==
X-Received: by 2002:a5d:6b4b:0:b0:2c3:ed18:2e96 with SMTP id x11-20020a5d6b4b000000b002c3ed182e96mr9711597wrw.13.1675933907856;
        Thu, 09 Feb 2023 01:11:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s11-20020adfeccb000000b002bfcc9d9607sm720564wro.68.2023.02.09.01.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 01:11:47 -0800 (PST)
Message-ID: <7ad7710b-2318-4c20-da2f-b0ee1a1a9cef@linaro.org>
Date:   Thu, 9 Feb 2023 10:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] dt-bindings: serial: snps-dw-apb-uart: add dma &
 dma-names properties
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230208171715.70862-1-conor@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208171715.70862-1-conor@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 18:17, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Commit 0c559bc8abfb ("dt-bindings: serial: restrict possible child node
> names") exposed the Allwinner D1 devicetrees as users of unevaluated
> properties, with a slew of similar warnings now appearing during
> dtbs_check:
> sun20i-d1-nezha.dtb: serial@2500400: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
> 
> Document the missing properties.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

