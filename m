Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734076A3E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjB0Jok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjB0Joi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:44:38 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325ADC170
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:44:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c18so3799325wmr.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGaVIlZ8ZJsD0GqhAHUel+POlXhxjkQzQtmaLMjdsx8=;
        b=nbR1UDp2OpNUh8taMmJH5xZiwO1jLhYkP7T8eTqYwz0bDb4Tx9mwbni1o32lg/xA0P
         cegt3w+TRnP6iT4i14eIYeJ1VTPOqSUT6tmVwrzqhwY8O2ulAkbGhVhg9tKTmSUY1uWR
         SW897yIMcoTUq5Yw98chAWXUFnflw/KWJO5HJDnd2DlTony+PPImZfH08b3cQshBf2YV
         ap0wrqzdvs0w1HlfdkVvHEEBnYF9LP2DWvDoqLrlAHMAd6q791KNnZ5MD4qe8d9XJK5x
         IF1EFRIsOWgtT8MI7jF7WS3ySRTVjP3imnN8Tt4biTWQ1dYwkrHahyLVPzjsVcaNOhub
         nMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGaVIlZ8ZJsD0GqhAHUel+POlXhxjkQzQtmaLMjdsx8=;
        b=o4LpfeLPs7J4/o86vWwbITFncptrxGehbpktCgRW29a7PsTHmFedznkxF1QzUpgbBA
         4QoJF0FyaorT5Aq4XGRbMrJp6UkggPTbs8bndUUWBHgn5wG5ck/PsqWdwBlwQV5Di3oa
         C+CBp/RBkn9itr7laAtNgHXu7L9dFSrQrOM7QrF67UR8cDVyYnkULALuOFzJrzMW1aQR
         ZcrdMVX5BZ9fGQ2OpUJIjo8r5p/wf3/JCOkIGJqQ/xgKML6aNSdfvo2jVisFQHW/Gz9d
         dzub+EDOTJx4wC/t05cfFA44kgnXt/2v7iemay2dOdyVByF2jRVPAttDyujVNjECihUE
         mlzg==
X-Gm-Message-State: AO0yUKV7xG04UYEs/e/YDipYJnjA2qrpNngbwp+5Y0NK0pt5IC1saay5
        RwgwgP8t6e3m3Wa1zvhtA/HP/e/UBvT/ZlLY
X-Google-Smtp-Source: AK7set9X7HIrcIY8+6kSrh3pQBfzos01jTap44nFyaRdS9zXol9FSXIS2vPNsfld0RzK00crEWxXSQ==
X-Received: by 2002:a05:600c:929:b0:3df:e6bb:768 with SMTP id m41-20020a05600c092900b003dfe6bb0768mr17650390wmp.24.1677491072647;
        Mon, 27 Feb 2023 01:44:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w13-20020adfd4cd000000b002c7066a6f77sm6440016wrk.31.2023.02.27.01.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 01:44:32 -0800 (PST)
Message-ID: <76e2daf5-0f04-ce02-7c16-1eff3576b3de@linaro.org>
Date:   Mon, 27 Feb 2023 10:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] nfc: fdp: add null check of devm_kmalloc_array in
 fdp_nci_i2c_read_device_properties
Content-Language: en-US
To:     void0red <void0red@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        simon.horman@corigine.com
References: <35ddd789-4dd9-3b87-3128-268905ec9a13@linaro.org>
 <20230227093037.907654-1-void0red@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227093037.907654-1-void0red@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 10:30, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
> 
> devm_kmalloc_array may fails, *fw_vsc_cfg might be null and cause
> out-of-bounds write in device_property_read_u8_array later.
> 
> Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
> v3 -> v2: remove useless prompt and blank lines between tags.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

