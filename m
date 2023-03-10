Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235796B36DA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 07:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjCJGvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 01:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCJGv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:51:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00353F34D6;
        Thu,  9 Mar 2023 22:51:16 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t11so5363744lfr.1;
        Thu, 09 Mar 2023 22:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678431075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4u6uCpUbBngUSRyb6gEuJ2P6dc/+CCHVDEEw2CGgqYE=;
        b=GVfAFGtZLUGU8Cr5l+vAdhJvOIvLARMZwwN7mPv+hzJA93Rmxez8HvAnt3P0CcOGVW
         yMNZOvibCckbi3kuKrOW0EuhOt2yRHOxShErg0m6j0yrq8Yyh1bpWV9MsUnsCfA7xiEB
         1m0ShUR6poN9zcNjpx4PZZ4TD+fhzQtZ3RE6igE+W4+/7ErB6SCj+FTWZDUeQOI18Knl
         bZD3A8GhxjfZ6V+Hq6Ui8K8qXoCMm2V7Huc0YV6N3zlaEVob8Ov7URlW7g78MzrQCsJb
         dEJLlfYFiOvj6w9D6Kc1k8QvwAeTbnj9FR/aBJVa6GgFmXX3f7Z7H99wlyEpRpY9G57m
         2YuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678431075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4u6uCpUbBngUSRyb6gEuJ2P6dc/+CCHVDEEw2CGgqYE=;
        b=if+1db79ymGDogWiI8x467ArGdj7CoksVDfi2QjqCUaJ4p/VmQNwqdsrEug/GPG1q5
         aU+ZtQmjwxP7xKMJ7ZT6lmMGHqKdmywtDkBiMpB3ZSCziGRdPUTA1oV/U7oECKIbkzIv
         RUlvgVKaBBL4hn2J/Re7WaOFzRmv3MPwJcIvwEGT2bkTjcYkEBccLk9PjpzNYOgs/Ty1
         4rB+6fUiqhcNpCmthsLTGsb2FW3NX+iZW/K5B+jbiGEdwGOmM83WFbbIH79f38C8aNGU
         D81O2VHNczDEiSlRZkWl5zJA8RknylJ9b+M1uOEfk6WbAVoU89fipOQNIB/OZ4Y8dQM4
         IzgQ==
X-Gm-Message-State: AO0yUKUaeClXd2siFp8zbG2E2u1/prmibYJlpBEfRlRCoh5bgPbudwrI
        gvgVLzbhKeicwJKMcAV6wjrT/s1xHNBtUw==
X-Google-Smtp-Source: AK7set/715anJ0DnygLF68jBNXXpbzugoyMt12gpYvAr/ocyTnNbT8aIHSoutEDB4DA4TZDebO9Szw==
X-Received: by 2002:a05:6512:487:b0:4de:7a23:23e7 with SMTP id v7-20020a056512048700b004de7a2323e7mr6751015lfq.36.1678431075030;
        Thu, 09 Mar 2023 22:51:15 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id y18-20020ac255b2000000b004db51387ad6sm148020lfg.129.2023.03.09.22.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 22:51:14 -0800 (PST)
Message-ID: <7ca3ab00-5146-7d78-aa56-9c412fd415cb@gmail.com>
Date:   Fri, 10 Mar 2023 07:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH V2] dt-bindings: nvmem: layouts: add fixed-layout
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230309113936.20162-1-zajec5@gmail.com>
 <8478b23e903d5236500ef2f6f7edb88f@walle.cc>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <8478b23e903d5236500ef2f6f7edb88f@walle.cc>
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

On 9.03.2023 14:07, Michael Walle wrote:
> Am 2023-03-09 12:39, schrieb Rafał Miłecki:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> With the introduction of NVMEM layouts we should prefer and support
>> describing all NVMEM devices content in the "nvmem-layout" node. That
>> inludes using it for fixed NVMEM cells (those with hardcoded offset &
>> size).
>>
>> This seems to be cleaner design and more explicit.
>>
>> Introduce a binding allowing fixed NVMEM cells as a type of layout. To
>> avoid code duplication put shared part in the fixed-cell.yaml.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
> I don't feel comfortable to add an acked-by or reviewed-by here
> because I don't do much with dt-bindings myself, but this looks
> good to me.

Thank you!


>  From a device tree binding POV, could there be a
> 
> nvmem-layout@0 {
>    reg = <0>;
>    compatible = "layout1";
> };
> 
> nvmem-layout@1000 {
>    reg = <1000>;
>    compatible = "layout2";
> };
> 
> for partitioned eeproms for example?

Maybe. Could you send a patch adding such binding with a proper
explanation what devices need it, please? It's out of scope of this
patch.
