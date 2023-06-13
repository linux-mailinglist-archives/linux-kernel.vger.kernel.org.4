Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D22972EB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjFMSiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjFMSiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:38:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969331BE3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:38:50 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso7266747e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686681529; x=1689273529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a89VMTqyEspTpjyQ7zK1ftWWdvdorC4yYQJtdmMcwvU=;
        b=p8lkC8hYztS5tbtUv4eTSX1Q/YWWOcC9jVU5uk5DrwJJsi6PxU8UoxB814xvU1bAS+
         /mwcRm27yNjogw0yXnXpDNHdxc4J8K/QDWaOSy8knlzP3rBn2nTouOgZheiuchx9pNjI
         ZpyoZCDJL37vl4JX6Y9m5xNpzkSQkkRccq+rmZ6ZGcRf2lNAc3nS5muW9PMfY7CQHEWG
         yFW0smbjBZzqRc1MGggR6kWGn6fH4AceOe32GM/rDFCoKV3c1ggq/RYpuP7ypf2qGPaU
         AV9YXPBOs2GaWc+j91qc66Frn67JLRdnj1EIQOz6JixSDJRPLxBLMpiIMcm0jG5Nz4rn
         OJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681529; x=1689273529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a89VMTqyEspTpjyQ7zK1ftWWdvdorC4yYQJtdmMcwvU=;
        b=fp+Y8OjPeQojGk6HRBIly4lqm8jjBRBG2bG6K8b88aoSosxt7Fay5b2KfX7oHQYJNh
         woe4TiRBZgIX2YTDD6fn190lzRPP5sJemqgVFGUcL282o8Bsu2niqPkj1jt4RQHFSxEN
         j4P8+9fKaLo/xF+DRXMQ7mjM9/TOEZszN4nvWF6EFEh5d4cCmw5BykT6f7Yz7WqTZ78M
         eeKIRI/GURs4Dub9y0q6hZMsa6HgvWNKRGqFkeXN3eiYpwTKG+hjdWvYOV+RtEwPnek1
         tIK0I16GTsfcgvwrCiwzc530KoLJWVQA9dxLdCg4yqOqiAVonOINfOfuHrfQ9SKLNzc2
         mGiw==
X-Gm-Message-State: AC+VfDySIOOH+RhzAI7ymYbaWP7YfBDNwTRPOqVg+9f6NFQO3GUqaNjZ
        JItDmpAKJVrX2EJ6HTJt7Nx8PQ==
X-Google-Smtp-Source: ACHHUZ5iOy5uyJJi0B7wnbCqhBu7oHmgqAQWyETEWMdbbXr0US0BIhR+WXPBoLmaj+xA7QnPABOrlA==
X-Received: by 2002:a19:5f0e:0:b0:4f4:d83e:4141 with SMTP id t14-20020a195f0e000000b004f4d83e4141mr7280091lfb.50.1686681528892;
        Tue, 13 Jun 2023 11:38:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l15-20020a170906a40f00b0097d9e2b5f9csm5567374ejz.170.2023.06.13.11.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:38:48 -0700 (PDT)
Message-ID: <7850feb6-a22a-1bb7-e7e8-7a6df3fe9199@linaro.org>
Date:   Tue, 13 Jun 2023 20:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
 to yaml
Content-Language: en-US
To:     Piyush Mehta <piyush.mehta@amd.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, siva.durga.prasad.paladugu@amd.com,
        git@amd.com
References: <20230613123048.2935502-1-piyush.mehta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230613123048.2935502-1-piyush.mehta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 14:30, Piyush Mehta wrote:
> Convert the binding to DT schema format. It also updates the
> reset-controller description.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

