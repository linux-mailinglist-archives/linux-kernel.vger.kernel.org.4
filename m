Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FEE6DE250
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDKRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjDKRSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:18:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F245B9E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:18:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id gb34so22419816ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681233483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpssHSu0iQZDS2WC/50LtdsFsMbbTEiBHjgiM5n2m9c=;
        b=hvBwJ4ByAhuZOwsW79t/L3lDNhzVvYiLWGEuroL03/8qlF/8V5VbT0pGxhC8yDpdPx
         QdzMJ6obU3zmUJ9Y/FgKtkMsi5pe7IXv7B5lP170ZojTJmszVF/TxheKx0aOtwWnBpd0
         B8bJOqC4Y3iRgXF4hOZ+YYoiBLtPey6uN5Pt15G61oNFkjmAYUfe5wCTk/dV7CqaXArs
         WE5za/U8AfIhgsqvsuvXeThgRV6hdJry6TXx/cL1CBn8QKJ1BJOV1JZXQKdzF9oVpOQq
         BS+Im2xPuxGc9jTdpXstj1xJ2iZtF2Z6uEDsZ71yuqhEOADkNxIpcMcnk1W63fGnAX7P
         ewsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpssHSu0iQZDS2WC/50LtdsFsMbbTEiBHjgiM5n2m9c=;
        b=TNyRfUDxSvHstSjGHoLamLdS2d6F9V+prZfVJCD/mJC1ZwsRqHCgOW427gYVvfUAMh
         vOR1lY3dTe+4/9vgPEJhYG65a1/SvUqJZ53DLopv7cBmjAQTjdi8K7LCCtDc0hpVIXsS
         VOxZZk/aawtXOpgk5WY0ieA8n65bflj7uCw/aTcoFiKrUM7Re2as5kbn/TyFnyMucvFc
         Sc1bb4nyD/JInU2Tafe4nBb9Iex+cNE8UCFux44l42IPEi2ys21D4E+J5AO5v561Tnt2
         Mp/XPHDgv7aZKOHeZQPrfZOo5r8o7FSSNsKNyXPslaTWL9VEBxf9B0N8H0w9BFK46CKb
         PvEw==
X-Gm-Message-State: AAQBX9f93jmCBrFMw8Pe2jP+ECnSZWD79OflBgmEzCEFXxBhhJqcnUdq
        KvuzZ7TMXcVjl0m8uvYUqa1u/A==
X-Google-Smtp-Source: AKy350YnWDZZn6uDDUqMvUzF5lNn4WuJ5XqJMnTlKLbIs77fYr9eM51P/PeL2IRm+eodSlnbjhn2GA==
X-Received: by 2002:a17:906:4ed9:b0:94a:939d:1eda with SMTP id i25-20020a1709064ed900b0094a939d1edamr5941640ejv.10.1681233483566;
        Tue, 11 Apr 2023 10:18:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f1da:c117:3657:c8a? ([2a02:810d:15c0:828:f1da:c117:3657:c8a])
        by smtp.gmail.com with ESMTPSA id wy6-20020a170906fe0600b009231714b3d4sm6356630ejb.151.2023.04.11.10.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:18:02 -0700 (PDT)
Message-ID: <85d61b1a-2017-cab5-8a6c-71714aecb455@linaro.org>
Date:   Tue, 11 Apr 2023 19:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: firmware: arm,scmi: support parameter
 passing in smc/hvc
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
 <20230410182058.8949-2-quic_nkela@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410182058.8949-2-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 20:20, Nikunj Kela wrote:
> Currently, smc/hvc calls are made with smc-id only. The parameters are
> all set to zeros. This patch defines two optional device tree bindings,
> that can be used to pass parameters in smc/hvc calls.
> 
> This is useful when multiple scmi instances are used with common smc-id.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>

Since you sent v2 before our discussion finished, let me answer here:
this does not look like property for DT. Do not send new patches without
giving reviewers chance to respond.

Best regards,
Krzysztof

