Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474ED6E4F37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDQRan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDQRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:30:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9315E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:30:38 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-504ecfdf6b6so4901128a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681752637; x=1684344637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8ScjprxHugKxCMDypee7pkLVAF7MNtBoWTiiYUu5i8=;
        b=fAjmPXPYv9sxADFt01EubdSTwYf2OscBpAyhagekVSESJ2xTEu4S2bVMYolTiHTSNc
         2aL7jDdJWOJ5ETzULCZMsykLc/DpaKvlbnzM9h+TiUXr8XXZvAte9lAMZWPrXneCee3P
         4regSv4wtvskxI+QT7ss+aKyV4YlnpurQSiMF4v6Xe3Mftj4umJSKjz9/yPfVDDHw2cu
         PG5Q/FgW1roQXDT90kqEZ5e4lmj1HmGesFhuenQeTs99FALORnnCHzarZECMl1FSydc+
         cHqw0qioJ/nsj0aH8P3nJdcSwi08I9YUd8v1kP2JaQmYIOZ+vl5zj0Lh5OXEpbDvKD7u
         faUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681752637; x=1684344637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8ScjprxHugKxCMDypee7pkLVAF7MNtBoWTiiYUu5i8=;
        b=DKb0KJJ3IJAAjJRbR6C8sD6ktuA+ZC1QKX5Mtrvs0mTHXWahZ2ZeW4iykYpVEUjEfL
         KxuLa3+sA8T+wsj/dajOMa8gF/m+jZwQdisTrE2cr04AwY8antDzHRs+ly8DLg54Yr9E
         pDoboZjbhImji3AsWfCpW7FQywuorQpRgoWOgw+xz+VwdOLCwMnj3vIW+aLSFjNv5OS5
         eSugQWNYEAyzPl90MtZDI5zCYIE/a9QClv+lGMKpINh01BizRa52BvqDFnEfk459uXz8
         ZRLIyQoHBfoGHjpocgKcsOS5SOzU2yNnS1Ym2EEXc3DrVyTV+U+TjCjaKrGSvBTnzjLR
         YXHQ==
X-Gm-Message-State: AAQBX9fBQdIo0jgGEBpbGRR69KU86C3dVqYal9U1BD6qOSMnTXMqzJIY
        HZwFtzYUHTqm1vSpE+/aZ4L47Q==
X-Google-Smtp-Source: AKy350ayXgZG1crpJRLYvQIWlQU/hRPwltlRot+m5KtnYJtPu4J7sERlQH+W7BEMDoRJVrxr1lzZHA==
X-Received: by 2002:a50:ef01:0:b0:506:a770:ce9c with SMTP id m1-20020a50ef01000000b00506a770ce9cmr3266806eds.3.1681752637281;
        Mon, 17 Apr 2023 10:30:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:96aa:60eb:e021:6511? ([2a02:810d:15c0:828:96aa:60eb:e021:6511])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906314600b0094a82a236cbsm6862968eje.129.2023.04.17.10.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:30:36 -0700 (PDT)
Message-ID: <45907ab4-ad1d-b4ff-a5b5-40e9bfc44e8d@linaro.org>
Date:   Mon, 17 Apr 2023 19:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230417141453.919158-1-krzysztof.kozlowski@linaro.org>
 <20230417141453.919158-2-krzysztof.kozlowski@linaro.org>
 <20aa9662-9cbb-4fbe-b6ed-3a6ba33e820a@sirena.org.uk>
 <c294d672-c2fa-7468-f02d-18d5230a1d95@linaro.org>
 <5d753a8a-b979-43f6-a403-8a51f69bac29@sirena.org.uk>
 <752c2dc1-65a9-a74a-d9ce-7db5ddbea5f8@linaro.org>
 <80be967f-b831-4a73-8474-09bb96bd2c32@sirena.org.uk>
 <1cc83bad-55c2-46b5-ad70-cac160b842c1@linaro.org>
 <7da0f237-b4ba-4c66-8061-a14c09a1e7a5@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7da0f237-b4ba-4c66-8061-a14c09a1e7a5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 19:23, Mark Brown wrote:
> On Mon, Apr 17, 2023 at 06:32:07PM +0200, Krzysztof Kozlowski wrote:
> 
>> If you prefer, I can mention the message/EPROBE_DEFER difference in
>> commit msgs.
> 
> I know you prefer to maintain exacting standards in these areas.

I don't understand what do you mean here. Do you wish me to re-phrase
the commit msg or change something in the code?

Best regards,
Krzysztof

