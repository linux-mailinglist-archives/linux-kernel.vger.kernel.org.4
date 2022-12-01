Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B9363EEB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiLALDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLALDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:03:08 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5C32D75D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:03:07 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f13so1922424lfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZPsJdX0DeKIWrtluUWX3HVvTrGo25QoDXGFCZw1PXk=;
        b=Iymxm2gwfFfqDxv99/Cvwgt5Tt86cvRAlbIcRFWVwq86La55pm/Wo85Vda8Abburiq
         +n3izNS6OKkWrKNxSR7d4nYTKkRisuxhy72xbJdZlPGyodm9rRlv79WAHcEZEQh5ODCF
         3bI2VKbSof5THgzSiG1M/osblrxsXxBEwbET9bJM1ToEZYibo54O/MKYhxPMwN2HTEMF
         xzxmqF6zfBPGlwF2GgpYW38omTN4zE/muv5xZer5SOacWpy09fPs11gsgRsHlzgKI4b6
         2CqKCMUboHskQm8xxv8fyveBOPHoYbQbYxdiFH/eY+rnKKTJ82CRWYT5YdyErzWM+iBc
         E1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZPsJdX0DeKIWrtluUWX3HVvTrGo25QoDXGFCZw1PXk=;
        b=AyebLAYr1EBroUcsx+6jvhsIi2VrBOBv5OZDnzjY3kZYEmS2j16mCH0zRkxkMJq7xK
         RUMot7ExvzNp84DYcSLrHvYiBUMBCsanokdKsY/Ra8BqeUQs7MxDGNpLsar7gxdMaZIF
         qCoWyYcdAg6CM8b/PO4uVmIhZNruLkDdenQokNo+1odjg6SPYTQa527Tye6/bfhmZsEs
         UAIDEkNbt99uX1UzPn/fjxhBAjfKYqyBJpoA8X8dm8wjVohzLu4wvgl30h7We3rfTS2d
         I7pqzd+HjTp0bGnkPbK6AS1SyEvj1K1kD0ntlnPHYNh6+uha5ho8fe1bItqOXONpN/Ai
         R4Fg==
X-Gm-Message-State: ANoB5pkGNnw/aw0Ou+VBmFABDzqGyKR9XasagvhzvHZ/yGvRM62dFToS
        C3xHJFA+s5vNylrXnVpqU+Lsmw==
X-Google-Smtp-Source: AA0mqf4rvnW0TD1qNBxou5BIbgpN6sDqmoCi83kGXJ7IydthJadNC0OxxCFRj4tbainX/imKqFlpAQ==
X-Received: by 2002:a05:6512:3a8a:b0:4b5:4888:4362 with SMTP id q10-20020a0565123a8a00b004b548884362mr244955lfu.176.1669892585363;
        Thu, 01 Dec 2022 03:03:05 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j22-20020a056512399600b004b49025f96dsm610425lfu.187.2022.12.01.03.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 03:03:03 -0800 (PST)
Message-ID: <be603b02-9357-431f-0f5a-069659bd6ce5@linaro.org>
Date:   Thu, 1 Dec 2022 12:03:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/9] dt-bindings: vendor-prefixes: add bouffalolab
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-5-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127132448.4034-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 14:24, Jisheng Zhang wrote:
> In the following commits, we will support bl808 SoC which is from
> Bouffalo Lab Technology (Nanjing) Co., Ltd.
> 
> Add bouffalolab vendor prefix binding.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Wrong order of commits. You cannot start using something before adding
its description. This should be the first patch in the set.

Best regards,
Krzysztof

