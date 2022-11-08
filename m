Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278F6621142
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiKHMqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiKHMqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:46:42 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FE95288E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:46:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id l12so9947495lfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ec4qBSZkRiXSLaWs7CwYWDreZtQ9OjryTN/TEu/9Uc=;
        b=EFACJzEA+ZYzeeFJrlOfvGYFj9+XMKM1DMV/pjLx4Fz1ohge68gODDobxmUbGHs+AF
         beD3cNOlxprwZF1/TKgrXzQAkZuEoWLqdKMiviTavQ78Tz6VK87GJuFFaSgeiiKyVAL9
         ZkeQeQa0QFi9jFdZVfa3yxLMFrpxL0HCldfObgsuMiTrd0iE7fl+5oAITyCZlKilaN7K
         K06eAo0SaIvotVAQ+kk82RKj5ltaNYVFIGilVrmuU2QZYZH7oImqDQaMFl1Q+wMEtGxh
         z6IdVZ4b9U3meddyjjgfDdJt7c+Jusv6BXwXDfWTMTKxFWrzkOYSdOUJT7jFD1f/xdGy
         4O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ec4qBSZkRiXSLaWs7CwYWDreZtQ9OjryTN/TEu/9Uc=;
        b=5p1Y6OvMZa/D61qCn/+oUhFg+O0dw16yasOlOQclQ/2JJhr+guB1m7opMOsBRRpZg+
         I7FWhOGfBN7haekTShQf1i7dY0viIbSqlOlOy8VgruK0dJSMn1rP8AOkrDaOt3RVlM07
         S2a+hqjcJBhhS0Vf8swHuNg+PPeXSuE/wtQID+SWllhyVg5FAQZDbg+MvfC9FJW457T6
         oUu0H1J6cUBmLBcjwnAwWph9eEPDz5oscyGLyDCbliUCVhBu5ku3bCtgssq+0YUK6pg4
         i2DVK/NaD+Tq+mOrFXkKn7sWWvRVwclE+zv7xi3rQu6fqc3Exyz+oLleJqjhEc0uJ9GR
         5oEg==
X-Gm-Message-State: ACrzQf3WxIHK/bt9GZQ3dAJNCWbWUMnBAgfaVcaTIAWbDWigafFLvT5s
        scXMun5wElWgEc6I3PCYUryKvw==
X-Google-Smtp-Source: AMsMyM4mBDv4HO3daS3jFbUT6KUf6TGTzBSDBCFvSnnC2MJTh7duW7vsuNT9IGMI0K111dDpylA/cA==
X-Received: by 2002:a05:6512:3d26:b0:4a2:a591:a45e with SMTP id d38-20020a0565123d2600b004a2a591a45emr21504975lfv.115.1667911599389;
        Tue, 08 Nov 2022 04:46:39 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id i14-20020a2ea22e000000b0026e8dd02eacsm1705056ljm.16.2022.11.08.04.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 04:46:38 -0800 (PST)
Message-ID: <eb2b7f21-5103-b30d-4a7b-bb4988f6024f@linaro.org>
Date:   Tue, 8 Nov 2022 13:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 1/4] arm64: dts: qcom: Update soundwire slave node
 names
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_rohkumar@quicinc.com, srinivas.kandagatla@linaro.org,
        dianders@chromium.org, swboyd@chromium.org, judyhsiao@chromium.org,
        alsa-devel@alsa-project.org, quic_rjendra@quicinc.com,
        konrad.dybcio@somainline.org, mka@chromium.org
Cc:     Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
References: <1667911156-19238-1-git-send-email-quic_srivasam@quicinc.com>
 <1667911156-19238-2-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1667911156-19238-2-git-send-email-quic_srivasam@quicinc.com>
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

On 08/11/2022 13:39, Srinivasa Rao Mandadapu wrote:
> Update soundwire slave nodes of WSA speaker to match with

s/slave/secondary/

> dt-bindings pattern properties regular expression.
> 
> This modifiction is required to avoid dtbs-check errors

s/modifiction/modification/

> occurred with qcom,soundwire.yaml.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>
> Signed-off-by: Ratna Deepthi Kudaravalli <quic_rkudarav@quicinc.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

