Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5E663EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbjAJK4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbjAJK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:56:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D582FFDF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:55:59 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso6582637wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OK3dOcmC2316DPwk/bUPBybxOAI/IcJi2QhkVwXbWBQ=;
        b=nZlsw+sfh6c8LjeTUYnN+a0bFqxtxwL5DIC1kOnceyEajUUdBKmOdAPp88zSPW6qdj
         ftayDXefeigxCJcjVMr318t5v+tjJk3AJfoMXRlI7eE+j3K0LeX9j8FZ2BZccLnQcK31
         ZACE+rsR9AN56x7XIGi0jl8eNSwHFzVCbrEde+MMSYnHW6LjR9aRwoiX5Slv2mAFW+Zz
         5IYX42NjzePzX35hD+6v5I1tDHPFEVcbyLEhKcmj1lnDHiNgi56VLkamALYc0YRAWQmm
         IYK9nylq+1Tgegu10hGd5HndoGaMB4xCiGEHTSNwn7CtII9QhiY91lresH5LJ5Hmv0k7
         azkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OK3dOcmC2316DPwk/bUPBybxOAI/IcJi2QhkVwXbWBQ=;
        b=3drl8Hxqvlrxk9AS+J7EuGivunX768Wq4/u17FdvtzOUE1WMzzkhUnuDdzLfj9geQR
         LaQfznkz8c/fu6K+erZB+NyDdFiWeCrvJn/8nC9RsnkbrieU+yD+FcI6QS45oxCuU5yu
         NSOK3mVOuP9vm74/SGcEbdMDvs8JySx5TH8lOthiZirXGeIkGWqZ9qNMHFfVXON+Y4HE
         YzFnVfCXOrgtspt2eua2lRpcXmcPgOHIJ19kLds/zCap4eg07bev6utdczMrNMuQGylG
         vMH1YB8ZPENVVqElcv4ynBYtcbOOu9sxBj7qBElsWycCFdkRjKQXoOCFXpMhAa5GqL7p
         jagw==
X-Gm-Message-State: AFqh2kpFdY2swQquPWqjaiDo13A7H1tw5JRdo5yVuKhbmvbUxt9JYIOD
        Zi3hC8YrxN1c5OaLk6c9ZGphjg==
X-Google-Smtp-Source: AMrXdXsvtDeUTfyYuTmn8t01Vc4ryVxBqJidLl7ljjVRGz8E1/5LG2Szn2MIuKI+e+NR5mw5c8WdPw==
X-Received: by 2002:a05:600c:510b:b0:3d2:392e:905f with SMTP id o11-20020a05600c510b00b003d2392e905fmr49326298wms.24.1673348158158;
        Tue, 10 Jan 2023 02:55:58 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003d9862ec435sm2256445wms.20.2023.01.10.02.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:55:57 -0800 (PST)
Message-ID: <7d0f8886-4d7a-b05a-4ad3-6bcbbcddbcf3@linaro.org>
Date:   Tue, 10 Jan 2023 11:55:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND v3 2/4] dt-bindings: clock: qcom,sc7280-lpasscc: Add
 resets for audioreach
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
References: <1672849297-3116-1-git-send-email-quic_srivasam@quicinc.com>
 <1672849297-3116-3-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1672849297-3116-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 17:21, Srinivasa Rao Mandadapu wrote:
> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
> for audioreach based SC7280 platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml       | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

