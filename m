Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB097015AE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 11:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjEMJaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbjEMJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 05:30:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5319E30F1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:30:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso16031468a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683970206; x=1686562206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tf/jVShm8OKhDruQm6UaF2CMKT1mXrHKFx6jIfcxO+E=;
        b=rHsWj/wI0HwoVFP9wE0IwNzqD9z8CZDrfT4AIX1eLYoP2PNw8XnEKS2QUyW3is4oHU
         J+VEI6fS1ZPKah7lDoM3HbxG23NvYQl7e7oxQEe1pWfLANmaJaacuzWFC4AfRKBmPmm/
         kYKLgCsfXu+XyPfLyZROlL7eu5ZrYxfecTSmLAWZr5ThQR0Mdy4lUR5pHNX7yQoggAa2
         umAlajQIOOWzc1OBGYNgmsU7Dt9c6mUSup/uktfvnIHQdSSePR70wbsVY7n9pWRr1yD9
         xmndml1g3HNuI6iQK0qM3XBlu2j0pbBtPBMm6mvXF/57KqnAKJqKlhec20/7NO5m0svY
         jKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683970206; x=1686562206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tf/jVShm8OKhDruQm6UaF2CMKT1mXrHKFx6jIfcxO+E=;
        b=V38P4Atgwug5VkL6OTuNsKwCrBPqdZgqrY4ZFTVaxatdGOJbQkjlZkErcnli9qL27U
         tf9mcjAJzntYeBW+Pt5vrF/W/p02PM7561EOeD5ZnreyuMkbDreZLZLZveJL6/HZOga2
         XskruZRXZyzGR0uIKzgaue3fx3ZGGk/+rH7hwrQbZG46nRWRmElzr0pdvOg9QAEaBsuf
         OMC2l3Mx+klqYTgoW5FLyCoTMnegUNTvKllPXlnoT3fFILUUb20Ltc3aYmAo8RAo8BNZ
         U42UrI7hvjlGsAL1CyoOTfKrSVMudOR9dZUDlNJS5LpMwYtTJXquA9a7u1XuKAs4wI1K
         /BnA==
X-Gm-Message-State: AC+VfDwKVQH1D2iBg0sPHvDYPpo+eL5/f/JfEPNy2Yyze0LRmPiCocBg
        ovkYA+lfx53mziP7xhTyIaaRhBFtfGqd8RWc/f0v3A==
X-Google-Smtp-Source: ACHHUZ5Zv9HcaOPdcKW8nys8OhI05bvMIT5gdrDtKhkHCQn9f2FXqy/GhCojZ0KPmblldn1FfdrELg==
X-Received: by 2002:a05:6402:8d6:b0:50d:d98a:dd15 with SMTP id d22-20020a05640208d600b0050dd98add15mr8860326edz.38.1683970205845;
        Sat, 13 May 2023 02:30:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1d0:810a:586c:c5ba? ([2a02:810d:15c0:828:1d0:810a:586c:c5ba])
        by smtp.gmail.com with ESMTPSA id a17-20020aa7d751000000b0050d988bf956sm4826648eds.45.2023.05.13.02.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 02:30:05 -0700 (PDT)
Message-ID: <390eb72e-c6ff-fd93-bf8f-41f04dbe5baa@linaro.org>
Date:   Sat, 13 May 2023 11:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/10] Revert "arm64: dts: qcom: qdu1000: Add
 LLCC/system-cache-controller"
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-9-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122134.24339-9-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:21, Komal Bajaj wrote:
> This reverts commit 6209038f131fee84ff1536dc59864f54d06740f2.
> Reverting change as it was merged before corresponding driver side
> changes, resulting in incompatibility with the current implementation.
> Committing the revert now.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 12 ------------

This does not make much sense as separate commit. We do not drop drivers
to re-add them with bugs fixed. The same here - if the node is not
correct, just fix it instead of first removing and then re-adding.

Best regards,
Krzysztof

