Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F766B2091
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCIJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCIJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:47:47 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B1D1AC0;
        Thu,  9 Mar 2023 01:47:38 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z5so1190028ljc.8;
        Thu, 09 Mar 2023 01:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678355256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKaZUBNgAYa02ZxPlAJw3n9xoYyo5mcp71gYUX2tL0I=;
        b=gzrSRgnhVUONxeY3cPePi09cWVIXNe51hrIgFNdXzODMmdFegfkdkE6TCjqEd4eiRg
         UnbqyeTZenJkJONC4PwLLWSdAEqKOCsPHcC+8joYWwy22Vm01Wqf6kFWrXWv9VHuhM1A
         iAay2wXvgfglraJFM2YgaBJNo5zLP8oUOUOSAQNlbm9EFVsx2ooMk0n5aNwULnTa7snn
         UH+1QJ7hrHvITKr9irqfooeUVP6QmpC1hlYKNodBqB7TONeieQrdKXlm8sCrrt+EchvH
         GTW1IKUw+Al7pIA2HpCa/CPuL1mZ6OEjx5qQzvdwVvPvqbG0VpFDBERIsYbvgILkeBb8
         mQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678355256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iKaZUBNgAYa02ZxPlAJw3n9xoYyo5mcp71gYUX2tL0I=;
        b=1EEt0VT8Iapq+JFIsuWQx3/e1Mgc1ZFEs5IVkEwglIqfna+yHy8mxCUusaUTILwSlD
         ugdes2yt2vYdArjEskw5VqsSbk0Q2nR7WsWpRP+Oa6Yg/hfHn5WyPEfuhVKckbQjH43U
         UOhMF3Ek7XrB1I9qr6ZBpWw8L815/AU+YtpvxeCJs0Ol9NveyhaWGOwU6LeMIcInKrDE
         klBOp2boT0KjMvu6WINLYqcFBxv82Psu4dStKGHBNaUwiAeLLErdrDOJ0FDVeawoPTpL
         C6e8BeXFu/Q18jRtdfsN1+6roAC8QOQZI8fddzayiKICpKqIl22fL6zBFAILlZSa1oZI
         ykqA==
X-Gm-Message-State: AO0yUKV7PYYRj249vysgf1UUN6is5BwhZl/uv3dftQttZsJnqdCxY2Cu
        3K8+2Rgaky1rz+SWHLUNCtk=
X-Google-Smtp-Source: AK7set9AS3WC1/pYkzMQbaWKTU2nZk/cwX2/PWrwElKyrnoF2PYhJkw0p3nQ7JAYwiJ5/BUsIPbXsw==
X-Received: by 2002:a2e:a58b:0:b0:294:7360:7966 with SMTP id m11-20020a2ea58b000000b0029473607966mr9763703ljp.30.1678355256274;
        Thu, 09 Mar 2023 01:47:36 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id w11-20020a05651c102b00b00293526a0c87sm2895414ljm.41.2023.03.09.01.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:47:35 -0800 (PST)
Message-ID: <12dd20c6-da12-b3fb-7723-fefe7bbe5bbc@gmail.com>
Date:   Thu, 9 Mar 2023 10:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] dt-bindings: nvmem: layouts: add fixed-layout
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230309093410.15214-1-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20230309093410.15214-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.03.2023 10:34, Rafał Miłecki wrote:
> With the introduction of NVMEM layouts I believe we should prefer and
> support describing all NVMEM devices content in the "nvmem-layout" node.
> Inluding fixed NVMEM cells (those with hardcoded offset & size).
> 
> This seems to be cleaner design and more explicit.
> 
> Introduce a binding allowing fixed NVMEM cells as a type of layout.

While this is obvious to me I should make it clear anyway:

We must not break backward compatibility. Old binding should remain
supported. We may want to deprecate old binding but we have to support
existing DT files.
