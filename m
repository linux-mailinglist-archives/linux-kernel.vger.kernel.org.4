Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0DA5B34B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIIJ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIIJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:57:26 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E8756B9D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:57:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so1790635lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u7aduTgOOH7Vi3nm5rfU780nZtDIZnOq9fvJiq1R9uc=;
        b=od8YO3BT1yriV2d3emhOsBiTP9Oe76LCe72CimHpw3pdxrgE5IKGecU7VyOJR6z09k
         R49MJWjjlVAZ9j/+xdRJnt2RlKmnm9PCCSlCRbsDoEFKVDpLFzQDAy1NfgQoHXgrNlYq
         uqdnyiZvqfZojxmwVTDMkHL2Ej1EJW8/XWVKCi0d8sONHAqUsrTzqNcHbnwahoVids4Y
         Xnp3kwg/E07tp5e7lc65c7zu8/U3IwUY//vv86twbQ3Ii8g6IAutnSY7aflq2j/jZxht
         urXWf5FJnBziA8coTBOGZ5SXHzzkKUtnWbq/ILSGbXqsZiyI3DwkMUcg1gG6+bPC8BO3
         6DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u7aduTgOOH7Vi3nm5rfU780nZtDIZnOq9fvJiq1R9uc=;
        b=3B/q+Euxm04KFfAR6zTC6D3aUtirJkmQ9kO3lKx3TEGHrEYmNomS2cD7v3iCn5P1q6
         sLKZKA8zRcYcLar6yCqXqdjm0eJiUgyeS5VU/yw83hpzpCpisOubfFUPrxxQNSz3u7Dc
         EQM41h7Zp3PAfuFDL4bsc0BB7yZsT8GwAiCcFYpBHR0LcgfQOLwgoSyU124KvP2a8cid
         BoK2g78Cmu7B64dc/9iWL56Y0uIOGpeEo8vh4+WzQr22kLBf3OAwcvVFqUJXE/Sn7+mR
         E5V6RmBl8UOkxqc+2AM7KYFAbyrquScoxJNQs7fS/hh4faYriFufCKHcURTIjWgtyCUv
         0g5A==
X-Gm-Message-State: ACgBeo1OBpxbKrdlP+oxxO/3cMCzbUe5t3e3WHyPuV49XFrG3B/o5VXU
        ltUawvfIaqih0SBcdKwXPI2/7A==
X-Google-Smtp-Source: AA6agR6ziHKObfLRnfSr6gyf0IablfCN9O0q1y60wBOAoBcEMz99slEUVezesDaaEdpzuZSPE94Inw==
X-Received: by 2002:ac2:4c42:0:b0:497:9dfe:e870 with SMTP id o2-20020ac24c42000000b004979dfee870mr3949732lfk.184.1662717443681;
        Fri, 09 Sep 2022 02:57:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a2e93ce000000b0025e40eb9b3esm5270ljh.125.2022.09.09.02.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:57:23 -0700 (PDT)
Message-ID: <dc63bd52-edbf-d13b-86b3-db83bfd8b7e1@linaro.org>
Date:   Fri, 9 Sep 2022 11:57:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V7 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, Lee Jones <lee@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Orson Zhai <orsonzhai@gmail.com>,
        baolin.wang@linux.alibaba.com,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
References: <20220909073456.239668-1-gengcixi@gmail.com>
 <20220909073456.239668-2-gengcixi@gmail.com> <Yxr0+LJWWsF53dr2@google.com>
 <CAF12kFteDZLk-2PBufnuar43bgPzoxWsOjR0-zQ01ZqLyTCxQw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF12kFteDZLk-2PBufnuar43bgPzoxWsOjR0-zQ01ZqLyTCxQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 11:50, Cixi Geng wrote:
> Lee Jones <lee@kernel.org> 于2022年9月9日周五 16:10写道：
>>
>> On Fri, 09 Sep 2022, Cixi Geng wrote:
>>
>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>>
>>> Add bindings for Unisoc system global register which provide register map
>>> for clocks.
>>>
>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> ---
>>>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>>>  1 file changed, 68 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
>>
>> I'll take this when the clk driver changes are merged.
> this patch is depends on the clk dt-bingdings, which is already merged [1]

which is merged to different tree, so this one here cannot go via MFD
tree without cross-tree merges.

Anyway please respond to my comment.

> so the patch can be applied without wating the clk driver
> and the clk driver need merge this first
> 
> commitID （6a3a6c7ae0ef235faebf66bac56384dbd5f944dc）
> [1]. https://lore.kernel.org/all/20220711202740.198F4C34115@smtp.kernel.org/



Best regards,
Krzysztof
