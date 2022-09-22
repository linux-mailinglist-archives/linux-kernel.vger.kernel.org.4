Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3785E66EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiIVPVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiIVPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:21:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429BCF391D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:21:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q17so11377892lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=G2tn8FkiA4QtG75xuiqZmLv7ElA87FmtU3DNYDf0oEQ=;
        b=gvtOtWwbd6XN7lgeIP4TcEsuTjvhDaz6SCfI5YZ1QCOvoifx/6Tv9EwRay+ZlQlzuk
         uuFokyZYzwce10lvYBft9Za6AamLCeVayMeFL1NHuERDEzgzrvdV7272uRHACK7xR6cU
         gXh5SuFUCY+AscEmRfjHBGeJZvejJCBOQaw9+mySxDSy/sU5dqWaJ+e4yJAU90t5O5GD
         jjTMynCKnVYTgfyAjee+g+jHLgR/fYRZi8EjMJ5QWXUnkfNvc/fCzSTOjQCUqXOwDseg
         7lfcH2kck+YAkOhEVpoBEI5q+BHsHd7lWRR9KstIk+IymtgbGYdhO20XI2IUNjiyMgXU
         4h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G2tn8FkiA4QtG75xuiqZmLv7ElA87FmtU3DNYDf0oEQ=;
        b=H3lCg/RRMgQC8mFY8orDLkM+moQaUbDTsk4TBuF53IflTCHXEQQYSPRYmsbrJP3EC6
         XL9r1s9+0xiV1SzdA6LfleidTJycL6EMia3YaE0mv5XSeTXjxZyNUclMhX9aw6dAJmvw
         gWRYSJTIt637WJ2zdj/2fiwAl8BdILi61Chk/dDtLLJfk9sCHNeSvbSgUMijYBxHJr1p
         jExPsWouOPInWjd1s9sC2aQ6696Vnml8fwFto2fscHNd+6GuvaKxBrI1kIWKuFu0Bf+O
         djOAjI61qrEP2QfbzzhiRm3feMjPpm3WMrC+11LNbuhsXWi9x+qw/7uXiX3NtjkOs2Q1
         8rfg==
X-Gm-Message-State: ACrzQf1m+JSZoa0WQgI9HfRwOl5sfm+4N0UCutg3SKmAZxgtrdcvLxp4
        grZ6qbqG5l31d/xgTYgA9nwKdQ==
X-Google-Smtp-Source: AMsMyM4j9ZJPh60peGli03Ceol3vlKlTckxECwq4CxNGTazKeqt1QdZGVrjF+gHjFYIiAGq0IxbYng==
X-Received: by 2002:a2e:8e27:0:b0:26c:259:e4d2 with SMTP id r7-20020a2e8e27000000b0026c0259e4d2mr1357778ljk.215.1663860094410;
        Thu, 22 Sep 2022 08:21:34 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t13-20020ac24c0d000000b0048b064707ebsm985686lfq.103.2022.09.22.08.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:21:33 -0700 (PDT)
Message-ID: <825bb400-fc7e-8564-f8d3-d294114b1ba7@linaro.org>
Date:   Thu, 22 Sep 2022 17:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] dt-bindings: display/panel: Add Sony Tama TD4353
 JDI display panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220922135902.129760-1-konrad.dybcio@somainline.org>
 <02f44228-866a-f096-1e90-dfbd31660491@linaro.org>
 <e9d55a49-e3c6-a6b2-43e1-8e643dc49d58@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e9d55a49-e3c6-a6b2-43e1-8e643dc49d58@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 17:16, Konrad Dybcio wrote:
>>
>> How about bringing them closer to common GPIOs:
>> panel-reset-gpios
>> ?
>>
>>> +    description: Display panel reset pin
>>> +
>>> +  treset-gpios:
>>
>> touch-reset-gpios
>>
> I can do that. I will however wait with resending in case somebody has comments
> on the .c driver.

Sure, makes sense.

Best regards,
Krzysztof

