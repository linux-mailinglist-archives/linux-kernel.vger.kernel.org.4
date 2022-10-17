Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC17D6007C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiJQHce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiJQHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:32:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2555A825
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:32:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n9so8082730wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYqZK+X+7VfhbaYZefIoSgPrXW7TEIiQfQ+tjE4nhzk=;
        b=gL2CgpENxhTdZN/Vp/P8v/E9XEi4u/3smkfJa/e3A3O3MEkHOccoDj5G2yk7jGyax0
         5ktA7yQYK9bHcwx54e0ggnb6fIOmpyTeLkRBv9YEjQjhFVfIgQmXhf+OOrMCwSlEZSuY
         aZyRXdaElHCs7ugZV5vM3OwGnqly8JwcXDBYpaI6ubM4YDyZld67bouNIrtl78w2VRS3
         kJ697+7kZuQNfcNWMogjtM5ohqmYhU2lJtdNd6Sz9Uq9admH55OVs23t3UviAJey4I5a
         WpyfhjkZj24lkm7C0k/6bRghCcer+8nlhpK6IM0DamRc5OaM28+4u0LFx+sNdxVUI0ag
         0v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYqZK+X+7VfhbaYZefIoSgPrXW7TEIiQfQ+tjE4nhzk=;
        b=S23rZV2wQ5AxiiC33qF2+N2LsINqg1zhoqreiJJ7kgs2oSkzHobjj1cE6V+w1OvLE8
         0D6C7gPfpRabJM51hAwOdhtTp+9A+3cOCRbpwEodL3swfTsPeIY7h/jITd2k5Etf4+2d
         SAXFGJ//5teyhMPD0uUgVz6nbcdT5F/BxEePuKook/K27N7ze1DvUP92oBUwLotH2Y4N
         y1E/wadJitszpfQKzwDcQ7y0CV4e0YvfNs6k8fG5+uV2njMlj5skpMd/C4EAVUPKUliO
         2703yd8RlCI2EqJ8nKwCFhkZd+PyXkk3y5xITc/E/7YDxK+ZUZO4l32Sbqny1XCNJ3E1
         7lWQ==
X-Gm-Message-State: ACrzQf2wGKLPVD93H2AY9KWOJJdHt+RGY8vwxifIbr0xjuszRdCGB3yJ
        nv56+C2Bv/K1uTAWby4IZ8+mVQ==
X-Google-Smtp-Source: AMsMyM6MqpLTz8nOC4oZ3Dvxr7F+0FYg/5vf5pL0CtCBmLRo39eVBK7qfmLPr/rGD1XlesqAU4UmyA==
X-Received: by 2002:a05:600c:6885:b0:3c2:9da1:5034 with SMTP id fn5-20020a05600c688500b003c29da15034mr6319611wmb.38.1665991949097;
        Mon, 17 Oct 2022 00:32:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9? ([2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9])
        by smtp.googlemail.com with ESMTPSA id n4-20020adf8b04000000b00231893bfdc7sm8145027wra.2.2022.10.17.00.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 00:32:28 -0700 (PDT)
Message-ID: <a1eaa937-dcfe-52d0-954b-3aaecedc1aa6@linaro.org>
Date:   Mon, 17 Oct 2022 09:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: Fix the debug print message
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, amitk@kernel.org
Cc:     bb@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010034126.3550-1-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221010034126.3550-1-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 05:41, Keerthy wrote:
> The debug print message to check the workaround applicability is inverted.
> Fix the same.
> 
> Fixes: ffcb2fc86eb7 ("thermal: k3_j72xx_bandgap: Add the bandgap driver support")
> Reported-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---

Applied, thanks

BTW, Kheerty, if you have time is it possible to convert the 
k3_bandgap.c with the pre-computed factors like the k3_j72xx_bandgap.c, 
so both can be merged ?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
