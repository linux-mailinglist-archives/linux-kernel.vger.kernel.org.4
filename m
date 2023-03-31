Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DF96D1CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjCaJtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjCaJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:48:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A5EB61
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:47:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id br6so28102806lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680256070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+FVjc7Vr5u63Aky+QFc4CNm5/6VJEJaY0PE/oQ5V5Y=;
        b=ezQU1fwlthlnLkzOKfjJOlU8Vs5/eSnmr9Kp1S6uvV/QCN0zH9rfO/hE5raTnlebbz
         b25EcCa/+TCWFoGRjP+iRjdvnpbdE9nd+x5F6YWd2m/CK4a5+LdFtF9MbsNpgKQUgKSD
         2nW5MmV09cZ4wU5rIWYaP3uQJ/euxqQJ4ZTlsNxlPb7YVK6M0ip6KC6uApjtvLRrwAaH
         twUNIusSdJ929h36uDlk6TNck720rAkxa/pPqy1a+ATahXn7qOiVG20zFoiOJCSUgnU3
         twvqifPVC5JGcCdTqV1GjyLLQYer1PLjPvbgENYNu//RXfB5JnFrfzTwlBrbwN+dWYI0
         x9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680256070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+FVjc7Vr5u63Aky+QFc4CNm5/6VJEJaY0PE/oQ5V5Y=;
        b=Zgy45QRbjniPsQXd0JNO/I3WsBmlVorIkX7pA5mxHlpa3zmrrKZRg+C/GjHKdwLPoL
         kF/tjDgK6OtKMV0CnBrVv1HOQdEnT4Uwoz6o8sjZGKxEzprosCuCZvubfMmIkmwp0+oP
         2pVCCXDdoeWzg6bnGm4mdXlYBxgPtVF7MUSzuC18yRNG4p6Md39RXQ+YPiBH++2PpHeQ
         1tRoy0dC/heexgHvNfw565MZ3xhn05vRRX6hjJj/bzEJVTIEw5y7zVB8+DEeXWwYv1Eg
         MvJw6Ci55MXvYxOzITmKJ/JwbatM9/uvNA3WQaKQwF0rMUeVo5S2Q1MuhfWhFDpNX3C4
         E94g==
X-Gm-Message-State: AAQBX9ez7Gsi+qunLj5mUt5Bf68i2F1cIhOcBJtBAiaCvpb3AQ8QXHvJ
        3gYj6JePG8hr20G/wFE0Z/O7vg==
X-Google-Smtp-Source: AKy350Yfe7vvDbdX5/m31I+n1dQH9YM3t6uIDyBc+99lpi+x0QXmahT38KoUxCALt0/tRmw5I5ybGw==
X-Received: by 2002:a19:ad46:0:b0:4eb:1527:e29d with SMTP id s6-20020a19ad46000000b004eb1527e29dmr3764702lfd.52.1680256070447;
        Fri, 31 Mar 2023 02:47:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m14-20020a19520e000000b004cb1de3f487sm310397lfb.104.2023.03.31.02.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 02:47:50 -0700 (PDT)
Message-ID: <08c18374-5d1a-7407-07d3-151bc5ce2511@linaro.org>
Date:   Fri, 31 Mar 2023 11:47:49 +0200
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

Ahh, and missing ASoC subject prefix.

(which you can get for example with `git log --oneline --
DIRECTORY_OR_FILE` on the directory your patch is touching).



Best regards,
Krzysztof

