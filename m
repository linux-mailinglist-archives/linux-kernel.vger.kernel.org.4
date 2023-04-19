Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6816E7440
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjDSHpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 03:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjDSHoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:44:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433ABE5E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:44:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a5so22771545ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681890246; x=1684482246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5XcewxUaRmMB0bvB1yX5pcm0BRTmU/2QobJdamhHLzI=;
        b=s9t8iT4fCOHu/LapeRaWbJVmJR+7efkha/xWhrGHhJEbRA1lhRv4ac3kWalrn+FHro
         DlKYOvCn9lhgbYlWgB9Ts5Ra80MxkpN5QoyUmXJkqbDlhpNP3mh3GCxjXj1vzC1hYXB/
         wRPY1A++YFC4rwsjkXRmCGucJnzldcYqQ5FUDot+Shn69uV+NNwD7jKkLyDPgCwXpVUJ
         zBiOJ/B8qR25leLhvGSBIBqw2iWfxls2YHvhRtfThYNqpoGp3aahpXXEhx8AXGWAJAcn
         8vtt9E8rjGbPJMh0h/wPOBlwiUTEjEXNcXq0ccfEFI0gp558vnZjLx1e5YgBOdcACYu9
         bv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681890246; x=1684482246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XcewxUaRmMB0bvB1yX5pcm0BRTmU/2QobJdamhHLzI=;
        b=PTB++kmt60aKE53kgqTv81cx7+J87RzURWT/iR8q5d2uhchkZIs6p+2AVW+/afRrqu
         mR2KQsFTZlNcJtigVf8gmQotLhP8Hq+icCxDDOmmE2iTqTMLS94AVlNLxzvzUQNf48Kl
         WaMBADG4kxN4GzTjiIyXeN/bvRbShGgKNZzTlLCl/71Ap8hx3zIspxoSopuMVot4ZaCP
         /wduTi+iMrr7c+MWGsMgCGZzrgwKHiBoy7Z0+iTCAbtWshpuhy9pRGDDvaFCngmRIWqy
         QwqmJj79dEnsylZLJjT59YJqmti+fip5sN7WtHIVAziGBGBHAUaXcPnvvQFN28i8PVDR
         8rag==
X-Gm-Message-State: AAQBX9erXVcYRp3xawagC7k5CrnTiSRBfcxQkkGcTDUhug2FixWXAqAR
        5uZHg2baIGQDv39QRitADWn/pg==
X-Google-Smtp-Source: AKy350bt8NOHcrvpmK/4aLkRfTLaXW10/2pUREaJ9mSFZPdF/VW+TEqJienNXG5c2C7v75vd9lCnwg==
X-Received: by 2002:a17:907:3f0a:b0:94f:3eca:ab05 with SMTP id hq10-20020a1709073f0a00b0094f3ecaab05mr14230945ejc.59.1681890245736;
        Wed, 19 Apr 2023 00:44:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id p24-20020a170906615800b00923f05b2931sm9068632ejl.118.2023.04.19.00.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:44:05 -0700 (PDT)
Message-ID: <cb9b7b33-37e6-0ef8-148e-40658b62e391@linaro.org>
Date:   Wed, 19 Apr 2023 09:44:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/2] dt-bindings: sti: updates for STi platform
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
References: <20230213185633.15187-1-avolmat@me.com> <ZD78vycteFErVHsj@imac101>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZD78vycteFErVHsj@imac101>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 22:25, Alain Volmat wrote:
> Hi Rob,
> 
> gentle reminder, could you consider this serie of dt-bindings updates
> for the STi platform.

You got necessary reviews, no need to ping more. What do you expect more
from DT? This is not a patch for DT to pick up.

Best regards,
Krzysztof

