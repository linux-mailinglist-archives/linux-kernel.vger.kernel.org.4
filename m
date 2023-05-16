Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C07045D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjEPHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEPHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:11:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44B2685
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:11:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50db7f0a1b4so12964631a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684221090; x=1686813090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+Auv8E+HskKPatCeQ4Zy3AM+1pg6Bk2PDh6BtnaU6U=;
        b=SCPVjEzshhV3FWaN8VjTqRZmBFVk7/SXDJi0/XS7eIhOOjr6GOTF+DQ3PoiKzeVJTC
         pb/gqyVniiVXi/1JzEsZGRcicHJSiXir3zv2ufalTNcPjBKF2EUo5adMAtWQAfVS7j5k
         S/+d587qRNuuCNXT93+n8NkUmOEHDI0+phuaX7NtsIeROVDxqD+ZRaqJyqSUJEVAFcfa
         vTctnwLNEPeEDH6UjVooeQ98FyNyssf0UAIyhSyC+21On2P3wvDgV7hc3dQWwhrl1KX/
         p1ow3eOT6H6u+ZFK9xTzFL7f5icVAvci4Byh5gjS2zLtrkbc+N8hzLOD3wnuIF20Dw1i
         0+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221090; x=1686813090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Auv8E+HskKPatCeQ4Zy3AM+1pg6Bk2PDh6BtnaU6U=;
        b=EHSvGwxn/kAdHTmXl+xI8Ht/jC41KJP1DzsoMIRbQ+kUlqW+vYkDrZm791UaI3e2i2
         a9FWzrA2Y8i0h+Z+JDuBO1lbEUgIiKhUBun5sKx+ugFdpei1rPOW63OO7TuLc2uNp09/
         O1L1R1tLB0DbhE9Gtpsxvnnc26cQoYpefelZRPvHUz2RAjLu689vny0MqOzI3rlznuAO
         lp2N3EsrG/fhn13080MTCllLiieZwyZlRq994mHhh/hOLrwqLLIQjyoUpUu3i0Y5OPla
         8cHaRH/XHS7LUIelmoMeAZ9PuSWQuTEAySyT6plKQ8ckLctp2D55URJw3v4yl1Mqcp7e
         GXPA==
X-Gm-Message-State: AC+VfDy+KJYNgaEKimvM3vtJlJbGl3Ig+F2D3kI4CAsvs/mP5T8OJV4Y
        j7OFLypkv0dNxW8JlGlD90oDEA==
X-Google-Smtp-Source: ACHHUZ5iEkrsHZJprV/AzC4QvLvL4pCIUA/UCBmK4RG2h99c9sQDrSGl6W3y3HjmBqVGAGhoZsdN5A==
X-Received: by 2002:aa7:c60c:0:b0:50b:d755:8acc with SMTP id h12-20020aa7c60c000000b0050bd7558accmr27268407edq.34.1684221090288;
        Tue, 16 May 2023 00:11:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7c98b000000b0050bce352dc5sm7802047edt.85.2023.05.16.00.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:11:29 -0700 (PDT)
Message-ID: <95f257ae-0b9d-a002-7074-a476fbc5bc98@linaro.org>
Date:   Tue, 16 May 2023 09:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND,PATCH 3/3] arm64: dts: qcom: sm8250-xiaomi-elish: remove
 redundant empty line
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230516062657.28616-1-lujianhua000@gmail.com>
 <20230516062657.28616-3-lujianhua000@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230516062657.28616-3-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 08:26, Jianhua Lu wrote:
> Remove a redundant empty line introduced by
>   commit 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")

So you resent my patches just to add a comment? Not even as a dependency
of something? Please, no.

> 
> Fixes: 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")

It's not a bug. Drop fixes tag.


Best regards,
Krzysztof

