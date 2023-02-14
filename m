Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A101696001
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjBNJ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjBNJ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:56:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C82C23DAA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:56:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso11089071wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xhE/sXFT5zjoa+FEV4/IoGQyQyppBawXrc+EF70yD4=;
        b=UmfRqpIDnQt+85LzpVkJK482ijjqzGSvYTMNQR6LpMTNHBk1HCBAiUwAK9njf0nnc7
         E0BK2MjOcP400fhUBfbvHcbH+28pzyw6gPxbfU/xWilcavzGznfYg2GdTggd5UMVc9qg
         QqfvrWTjorvLQ/dibRdZjCHQizRzpiIDV/7tdmHF41hQUIewTIkukYtjm153EY0HxSkH
         5hrfX6gNVd4mTLwHOOKrTPh6bZCb/WAMTfyq+X0y/rYSGpRbtiYeME0XGft3Jmz/3k6c
         5EsXb/yb/oMQjkMst5CAUMyUn/BUE4WOdVObB4aAOLa+qFv2x/pgdYIUZE1KB+Y3Os4k
         Jp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xhE/sXFT5zjoa+FEV4/IoGQyQyppBawXrc+EF70yD4=;
        b=sMDQdUocG+bscAYuelK8iqfmZdu7+czt/fQneP/YEQyjfM78SpZHtOPLk8QbjXL9MT
         AyOiSwge6sfb0wrADddn/jQ87dJmtbXYGi/Dr4+Fl7P+3+5D4kYpVcEKlVg7vuNQyvXY
         Mhh+XFEd8F9rQKChmye69rGlZBx+L1C/kqTtrbzM/kfhTA4ZmEC6WgrNWqkuim/wK2D7
         ETsop72gAAHi71UVWka9PWV3Pel2YU84ouLbgHrAe6OWlXOfbZ5PFd49kYfsrlzwots4
         9qn3czY5tPOoiOv7QtJ5l5jlW0S9gE442qsrbApnMZFm9Z6kRh+NLb/p9bqd/qQ3ahdR
         bxig==
X-Gm-Message-State: AO0yUKXunNWVf/46MlXiPzSosUaE6CCr0Pm4VZpzWaB7hYMzBTpw55uv
        VfPfwkbV7P3ThbExlHP7c8Yukg==
X-Google-Smtp-Source: AK7set9pX348V4vPhGbAyakzYHwkty9TII1zk/mV5abCHqQ3npK1d08AeZmkCT5+aFjYVTtU7Il+OQ==
X-Received: by 2002:a05:600c:a29e:b0:3dc:4318:d00d with SMTP id hu30-20020a05600ca29e00b003dc4318d00dmr1587750wmb.11.1676368602867;
        Tue, 14 Feb 2023 01:56:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s21-20020a1cf215000000b003e001119927sm19237471wmc.24.2023.02.14.01.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:56:42 -0800 (PST)
Message-ID: <34c4cd70-e6c2-86d8-3f7f-fda70718ae1e@linaro.org>
Date:   Tue, 14 Feb 2023 10:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] dt-bindings: power: qcom,rpmpd: Add SA8155P
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 10:54, Konrad Dybcio wrote:
> Add a compatible for SA8155P platforms and relevant defines to the
> include file.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

