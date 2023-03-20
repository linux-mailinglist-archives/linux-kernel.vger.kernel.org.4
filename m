Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BB6C198A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjCTPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjCTPeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:34:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379839CEF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:26:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so48203646edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679326018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHHguPDhFkpYDz8ZNdfdMQlBvAG2URdGcmqW2YS7VYE=;
        b=yiUKnB64JSAoB/lCQGGxxl3CR/i2PDUQAf81QIqcXgeRaN1qP5SegAF+WFa6Soh6Zs
         /6+MksIZGFr2p391qyaq4xnCcpEisqxKo9XbdoXm5LmoNiGIdBwoe2SwtVYZ0q9cb2IP
         sJ/nD6cExDlid/gNPaQYf+iIMwo4c8RBwSJP/xil0sToTfA23YXMmvxGo23L/rpywiDM
         bFwKZkLsWsETubNP2XrBtigKQ3fNgeYynzoJK1cBbesmxvFB5FQHk36qa6dCNLm+MPCo
         O65LOewwzlbqoRhhtNVZEB6TOVVUaCGc6gm+Ius7NOB64ASxrzoWJnUjvrcucvq6r5TK
         a58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326018;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHHguPDhFkpYDz8ZNdfdMQlBvAG2URdGcmqW2YS7VYE=;
        b=WTHVNJ2NeqngaOQQamOmwluP12CxmO6b+/Oj0KTF1CHPCXDOQ/Ue/Wqtj/vvcnqasb
         HBR649cbfQMBu+ph5HsWIf6IYQLBYI/H0/5rCYiwKfGhfm7TVDH0BhH5JFPueFA9+0ZL
         xIFlmVg1Zz0NC+XHXdvrVpL8abiet6A/ODYXIGwBBSDpWQZy0qGAYjyRdIMJCSjoN7SA
         D9KdFMgljGiX+jchlq/b7vJx+ofCVB5G0LEV+gCXkjE1WRpzk/xD5G4ny8U3PcAsHwGZ
         0yWxt90TdvEkPlLPRzmoqxbUvgx2/bWAxQoWbS+t1k2McSbiTx0xMnOO6x2mV6N8cUWw
         0DSg==
X-Gm-Message-State: AO0yUKXJTRudOoxA9YfYSEbfAMIZE/hcxLKpQsD3HUNvR+x/w55efAIp
        tUS2PIwV5KGFKLFZ6TbKjoU5VQ==
X-Google-Smtp-Source: AK7set9wGs3rArzBcZl8CjW5WlqEeVkxrEmwoQvtj2QU2U9uQcB2AohwH2HmKUCjRLPh+be1liFQmA==
X-Received: by 2002:a05:6402:4ca:b0:4ad:738b:6706 with SMTP id n10-20020a05640204ca00b004ad738b6706mr13843193edw.2.1679326017812;
        Mon, 20 Mar 2023 08:26:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id e27-20020a50a69b000000b004fb542dd8cdsm4990432edc.29.2023.03.20.08.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:26:57 -0700 (PDT)
Message-ID: <88e2ab14-aca0-21bd-5b34-0bd9849587ce@linaro.org>
Date:   Mon, 20 Mar 2023 16:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv1 1/7] dt-bindings: vendor-prefixes: add Inanbo
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20230317232355.1554980-1-sre@kernel.org>
 <20230317232355.1554980-2-sre@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317232355.1554980-2-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2023 00:23, Sebastian Reichel wrote:
> Shenzhen INANBO Electronic Technology Co., Ltd. manufacturers
> TFT/OLED LCD panels.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

