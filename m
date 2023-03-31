Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED656D1CED
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjCaJtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjCaJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:48:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B1C20C37
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:47:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id br6so28101420lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680256040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnzWIFD7E+b4S3TZGTfN6jfs1uPbhSQEaRByhI1df+M=;
        b=HB+TVMnkqvB7O0R3MzfOeH12788Pp02xIqytld9w5q6ehalIpUQ4NIGCs4FoPNwGtw
         KjINmDIkY//lZWKGXkAW/6HxoxXWdC32DM4f1uzIesFTa8YPI+RAC1d3WOQUbqGx7nDV
         lTespHeb2N2brtIIpdtHFxWZN2OOzGN+9/NRxQ+6sQoqnIOdTwI1GHdLu/mnJvAKyz/E
         RohbWhLih537gFmaFLGYdHiPsS3Jb5lI2sbUbhvksGpoVbf/QRJvjloZzTcOf2OT99fP
         OS0ixUMKhOi6tHVFED7+FBbzZG3nbCGdfiqHc8K+fc+DtV1WkjcoGRqILKWRvhz9pV62
         ZRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnzWIFD7E+b4S3TZGTfN6jfs1uPbhSQEaRByhI1df+M=;
        b=dNx++2Ihl8SYFH+Tz2TYcw03hFYPIM4CpMZcssXMACywJaAlCTo+9YIJdoZIM/XlP/
         uS/+61o5juQf4DSIsIXziGr8iBgtANFcYk5dMHl2mphH+s2pbR8o7Ks3gtcB//EN34tb
         7Qw1wAbvEbn49jmqArs3ohq1GyrdbzcRZZWkQfBV3DIMRLde1N0RdxdwPzp1RVB7MEHc
         A6GjCzVNSoLdRmyywkvv31C1CzGH3Zed6YHPM7NcLVdiD+6Ebr0FXizfoLIytnytw8oh
         D7d3tz1GaRUFy+n8FHeUWKHZx2MYBzd9zSVzW/PuBr9OzEQie4zT3TaLgausqrks6b3m
         OuVw==
X-Gm-Message-State: AAQBX9eZKCQKgZ2LY69l2gBe7crLxtDdIFvxsUlDri8wOhC0mPc/5MJ2
        Jz/ENOvAAuy68Kmnss6ssZDosQ==
X-Google-Smtp-Source: AKy350axKhA1sEScCS2IqTPlAy7H3rF+ckndonIj5tM6RWPZCy4EAumflMTPJ5hdVeFx1W2N/KcT/A==
X-Received: by 2002:ac2:46e4:0:b0:4dd:995b:feaa with SMTP id q4-20020ac246e4000000b004dd995bfeaamr7880350lfo.24.1680256040470;
        Fri, 31 Mar 2023 02:47:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c25-20020ac244b9000000b004e9c983a007sm309559lfm.289.2023.03.31.02.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:47:20 -0700 (PDT)
Message-ID: <304ce3f0-81df-327c-8b42-2471a3a51e43@linaro.org>
Date:   Fri, 31 Mar 2023 11:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: maxim,max98371: Convert to DT schema
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Morishita?= <andremorishita@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        anish kumar <yesanishhere@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        daniel.baluta@nxp.com
References: <20230331020527.482991-1-andremorishita@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331020527.482991-1-andremorishita@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 04:05, André Morishita wrote:
> Convert the Maxim Integrated MAX98371 audio codec bindings to DT schema.
> 
> Signed-off-by: André Morishita <andremorishita@gmail.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        max98371: max98371@31 {

Generic node names, so: codec

And drop label (max98371:)

> +            compatible = "maxim,max98371";
> +            reg = <0x31>;

#sound-dai-cells = <0>;

> +        };
> +    };

Best regards,
Krzysztof

