Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098466107F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiJ1C0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiJ1C0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:26:05 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D6796A3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:26:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t25so2652387qkm.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbi8V7AsQnVUtQ5XrR4vi3xC9bPVohDqiYvGdlhyQu0=;
        b=juqIgPpKldQnDIIoJVVTZLcAMb5nwW62dHOUjsVCXF+gpgtPjMddGD9JvYdCy1eA5w
         DQaXxXykdKoAvzQM2WtXb0FdZPHEkjI9T6U6ooKKyS6i/uxeDPLllPxFhVASd+xQLsA5
         2u8LbBhuR3LWe2PNYzzEWdgdW7NJWorj7z7pJt5lq1CwWx3Sc/rEZYptSdcapJ7wK6WE
         NFI9PZ7Y8HBmJEut0gt2XprO/LLX9CqdCoLdozOwyoWTwz4Ns7oRnItwh3DUVgrltLEA
         jlhlU/TkZRa0KBEuOCFosuZvFUVJwJNED8m/pFk6FiP3EInWdIKgDVqIKGlm7Kre26lK
         Kkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbi8V7AsQnVUtQ5XrR4vi3xC9bPVohDqiYvGdlhyQu0=;
        b=KLjL799CtG+F5duJNx8TDaW06c1ANRsKjoQkfYcp0RX7SzGtseIGYGkicCIVnos0nw
         Hw9H9mfFnfwnlemDEXu8FuWeqPlObSMfL1T87+NXwbQo88//8qEKExvBbD7gqHVftsHC
         hQME159wRCpluk6J8o8INbIHTcPTNEnouwUNequn74GFUPeWL/iMKqrqTf3shJWzxZYs
         LwfvQq7RvPUpiHLqX/TXOSMw5BV2F5zLu4D+4TZmtKZlIvwHkLNOg6OVL55ftqD/Q953
         BxfGPWXZLgjq/9r+CvrUMx338Mv9eXeFLKZnrAsOddPWhFJzbxJ51CgNlQarrer545Bf
         xQ4w==
X-Gm-Message-State: ACrzQf0dLNlKfH861sjk0hmciLT/Pa9rQjeicWqTeZMwWkHm9+TgZ1wc
        BVNHqoPw3NCTUu64APMZY+dJFg==
X-Google-Smtp-Source: AMsMyM5+he+ps/mq3+Li/gbAiDHtAd6U+CvImSyZZ5iWAO30teShLv3uFPMOi8/Lra+Z0ofexszi6w==
X-Received: by 2002:a05:620a:28ce:b0:6cf:933c:40d3 with SMTP id l14-20020a05620a28ce00b006cf933c40d3mr35846484qkp.258.1666923962577;
        Thu, 27 Oct 2022 19:26:02 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id l15-20020ac84a8f000000b0035cd6a4ba3csm1745013qtq.39.2022.10.27.19.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 19:26:01 -0700 (PDT)
Message-ID: <56bc1673-25ab-832c-ea2d-56c1ade61221@linaro.org>
Date:   Thu, 27 Oct 2022 22:26:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 3/3] dt-bindings: clock: imx8mp: Remove unused
 IMX8MP_CLK_AUDIO_ROOT
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
References: <1666922026-6943-1-git-send-email-shengjiu.wang@nxp.com>
 <1666922026-6943-4-git-send-email-shengjiu.wang@nxp.com>
 <7fe4bf93-6b60-f1f7-d89f-8d7f75c9e58c@linaro.org>
 <CAA+D8AMTY=733JZujLrE2aG43=o-9JCg7VfOOq67rnxXKdn6PQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA+D8AMTY=733JZujLrE2aG43=o-9JCg7VfOOq67rnxXKdn6PQ@mail.gmail.com>
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

On 27/10/2022 22:20, Shengjiu Wang wrote:
> On Fri, Oct 28, 2022 at 10:17 AM Krzysztof Kozlowski <
> krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 27/10/2022 21:53, Shengjiu Wang wrote:
>>> Remove unused IMX8MP_CLK_AUDIO_ROOT which is replaced by
>>> IMX8MP_CLK_AUDIO_AHB_ROOT.
>>
>> You break users, so this should be a bit better explained.
>>
>> I do a search, but no one is using it...

The commit msg should explain the reason and it didn't. Also a reason
like "I did not find in Linux upstream a user" might not be enough. What
about U-boot? BSD? Other firmwares?

Best regards,
Krzysztof

