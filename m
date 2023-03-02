Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6846A7D00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCBIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCBIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:44:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47000166C7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:44:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u9so15053935edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677746648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y465owWqNdZLbwA3F1DEzjK3aBGjSD5dSySmp00M9XI=;
        b=RXkVfzZ67BZ+ApfbnBwneXHfGQEIG3BqhEgoljXYcYAcyGV5S9aBmQV+vdfZvfae0c
         suhNvTXJ6ngQiOj20+8s5ZjkxG+6A+tCjQjVG/1Gb4ZT7d+3ufOyKRg1Mv+/c6Uz+REo
         ra4F+aNJLmwFZId8eI+j3lXGokA71SCKTFooweJ4D/HOU/OZP485xEWChrKZnHfNGHOj
         5k1BgyuKCllT9TykD14t3KCoV0m3dZZTZOIynO8d9+PBJvM11VNt5GGJEGsTQL2fRSbY
         KW9Xu/q+1xWPL53FZdudlojKlD6YIJYM56dwq846N9Up/9JM8Q0pxRN3J5nq7E68diif
         3kVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677746648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y465owWqNdZLbwA3F1DEzjK3aBGjSD5dSySmp00M9XI=;
        b=vsNHsk7rawNruPesjr3OhmSnipwgWFHbYAj8ZX/IiDXnK4TfP/C0LFPhgDSc1yS6tu
         4Or/b4Rp67BGAfFWHEYneY6PqrihIM7O/d/NvoW6mJwzvw1cvT4sXDK/BZ4yz4kwlAzu
         pGyFdvlVJ9dznMgWWpLkh7C8/fWvJ57pPfdO7gRwq/rGWb/O2GOQDy6HwZFw9s+rH+gI
         EOQxJSZWnM0RAEK4u2q7MBr36gW12GZTjF07j+cqAlixgH/XyHikLe9phL3kbCmyAiS5
         0lf6Y4RZ5JSptgfD0oPLl7PJBIE7KuAgoABNzt5FsC0fC77yWqEZJRO26jgZpE9zuX64
         QcPQ==
X-Gm-Message-State: AO0yUKXnbNRhtkMmI2WU4/4qVg2xP6LhPJsQtG1nNLgp6CP/VNPMELEw
        CQqvdJhAsJ/+WRnmRz+un4REZg==
X-Google-Smtp-Source: AK7set8nFwIF3nYwyIZP+B9XzlWd7wNfrNHZmhB3/l+R9te/JWOOsnJIANNZx9K87r6RQYhEt16qtA==
X-Received: by 2002:a17:906:d28a:b0:887:2248:efd5 with SMTP id ay10-20020a170906d28a00b008872248efd5mr8497891ejb.77.1677746647764;
        Thu, 02 Mar 2023 00:44:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n5-20020a5099c5000000b004ad15d5ef08sm6607326edb.58.2023.03.02.00.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 00:44:07 -0800 (PST)
Message-ID: <567ee41a-da6e-1e5f-8ae5-b3606a9a3227@linaro.org>
Date:   Thu, 2 Mar 2023 09:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/7] dt-bindings: phy: cadence-torrent: Add a separate
 compatible for TI J7200
Content-Language: en-US
To:     Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mparab@cadence.com, rogerq@kernel.org
References: <20230301131125.6084-1-sjakhade@cadence.com>
 <20230301131125.6084-7-sjakhade@cadence.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301131125.6084-7-sjakhade@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 14:11, Swapnil Jakhade wrote:
> TI J7200 uses Torrent SD0805 version which is a special version
> derived from SD0801 that has two internal reference clocks along
> with one external reference clock. Add a separate compatible for
> TI J7200 platforms.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index 711097e167bc..1906b6df6ebd 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -21,6 +21,7 @@ properties:
>      enum:
>        - cdns,torrent-phy
>        - ti,j721e-serdes-10g
> +      - ti,j7200-serdes-10g

Any reason why adding it without keeping the order?

Best regards,
Krzysztof

