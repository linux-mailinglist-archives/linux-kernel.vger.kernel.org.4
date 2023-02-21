Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C864E69DAAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjBUGkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjBUGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:40:45 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC3E23842;
        Mon, 20 Feb 2023 22:40:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id ay9so3476479qtb.9;
        Mon, 20 Feb 2023 22:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtphWG8mjar6FBzUoxvyO95vbNktxFoV51fuM/VjW2k=;
        b=gAP5K75UCNv8MTFyCc20NLeoIae5pB1JNHI7y0vLkWDp3h8tdr/XrO1iva30aK/QIu
         74c0w5L8Rq9iTf7HIxgWKj0kB6ofiCp9HttnkLLndPn6PCDKlpXS3KGUaAiJlaSCZTw7
         R94SRYaXirwIjGcbYk9W5Dvs1GBb+MN2Ynczl7ShOwlF8ZkAmluSs5ORHCYQzcSy+pI8
         QobeLQ/kDL+pYSKBTVWPy4QjbbuDu6Z1/C3nYcDFkHtIjCa3KVtXnofg+a3nijJwLYYr
         XUiTEoxzH/u/1PUz+DBpoybGFp2TxxlkFJq8vT0fNDPACogpFhdbdYHmH0T/WH5VM5Ru
         Mxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtphWG8mjar6FBzUoxvyO95vbNktxFoV51fuM/VjW2k=;
        b=CXIsidvEUgXq8TuJhkiSQHlxlIzGChOfYPux7I8D9Uk7JwGw5eqlKRra5/mQnuzmvT
         vvfyQd7UtKwaOnpuvZm+MNC0CQGguwBWaPjEIybxMazs02OMqHQspXgwVH6KlOl6dnc4
         Iew8ZmzKEsMk+hO8UNQ5aSm/aD9hr4JjpcU9/uuAuPG3NAWa/YFlFuj9pF8HhkiVRbcf
         QNtkzhjE9P5sPJMTL6Ilsux+wA3Z9YYGri7SrDFaMR26y15yomZnxWR2OboyDrh5GhnX
         KZUpgWjvbQ5QGm3OVSUMFcfgvwZ19rf6IlBHigadPC6PE2jwFzOiLn+wCK+W8hm1ipns
         cR4g==
X-Gm-Message-State: AO0yUKUPTSWbCwphGoev1NMY2oPXMzIhQX3rIjj0azOnREZ3hs7T67Q9
        OSSU/iCN4zoarymTg+gAjnd9i8JZoXXcMQ==
X-Google-Smtp-Source: AK7set8y2Omc1I1QaWR0VQdWU6j8EBUXUauLFtuHv6i/6Nbe3hIiVJ74Z1ePcJmniR9tcvCr1QK1+A==
X-Received: by 2002:a05:622a:118a:b0:3b2:1003:37e5 with SMTP id m10-20020a05622a118a00b003b2100337e5mr6162788qtk.55.1676961642436;
        Mon, 20 Feb 2023 22:40:42 -0800 (PST)
Received: from ?IPV6:2600:4040:2025:5900:5493:aa3e:bfa4:8653? ([2600:4040:2025:5900:5493:aa3e:bfa4:8653])
        by smtp.gmail.com with ESMTPSA id fz9-20020a05622a5a8900b003b34650039bsm330286qtb.76.2023.02.20.22.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 22:40:41 -0800 (PST)
Message-ID: <4778cc0a-77ad-b28f-bbf5-6247d26f81b4@gmail.com>
Date:   Tue, 21 Feb 2023 01:40:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] ARM: msm8960: Rename cxo_board to cxo-board and
 add alias
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        david@ixit.cz, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20220808234723.5184-2-guptarud@gmail.com>
 <20220809000300.6384-1-guptarud@gmail.com> <YvQMyQLohqcc8Fug@ripper>
 <499c8b49-a09e-e775-3242-13d37a13877e@gmail.com>
 <20220829215443.dvc5xnmeqnhmxb2d@builder.lan>
Content-Language: en-US
From:   Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <20220829215443.dvc5xnmeqnhmxb2d@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


So I'm trying to add a cxo-board node to my dts, however the current 
implementation seems like it wants cxo_board. It was recommended a while 
ago that I refactor gcc-msm8960.c to be more like 
https://github.com/torvalds/linux/blob/master/drivers/clk/qcom/gcc-msm8996.c#L36 
. However, I have a couple of questions:

- The xo struct that I listed above is listed in another struct 
https://github.com/torvalds/linux/blob/master/drivers/clk/qcom/gcc-msm8996.c#L3408 
which is listed in the SoC desc struct 
https://github.com/torvalds/linux/blob/master/drivers/clk/qcom/gcc-msm8996.c#L3818 
. My question is that even though gcc-msm8960.c has an msm8960/apq8064 
desc struct, it doesn't have anything like gcc_msm8996_hws. How would I 
know what goes in a hypothetical gcc_(msm8960/apq8064)_hws struct? I'm 
assuming that all I need in the hw struct is the pxo and cxo listed here 
https://github.com/torvalds/linux/blob/master/drivers/clk/qcom/gcc-msm8960.c#L3727 
however I'm not 100% sure how to verify this. Would anything else go 
into a hypothetical gcc_(msm8960/apq8064)_hws struct?

- Is there documentation on how the gcc-<soc> files work? I'm still 
quite new to contributing to the Linux kernel and would like to learn 
more about the modern way to format these files and to learn more about 
how they work in general


Thanks,

Rudraksha

