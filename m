Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB436E222F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjDNL3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDNL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:29:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73C3A5C8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:29:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u12so5236849lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681471754; x=1684063754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWMOFNhZFBaCur3ru43qQwSO+8mXScxW4tbBJS2cE/A=;
        b=oYBuqwJWQVpMwpUTwTDZ9Qa6p66drWViMrGaniTv1S1AP3jHIBGnlWkimsqeILy98V
         n15rGbxtJGVbSvmxQcRr6cOL8hqxUbgUoubB2FIl/ItIpm8d3UlJ+fTtDq/6eqhfWv2N
         T0M0SxjVaCKIfRVxfejmLHFjBjgirV0Y9F9icum2Dgv6g3MekFaNvSkYo/kBWQnLvouq
         sKrAKCgY5AwEL6XbvGnhJurDBviqdcTx74RKL+K2RK6f+EzjfzxKyQf6iyKvp9YXyucg
         kgFg/N3lbFVi+gPk+MC/K8LvmFpKMwgIZG2JD+pBkWsGumAKzdbbzfsoj+JymU7cB8So
         J6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471754; x=1684063754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWMOFNhZFBaCur3ru43qQwSO+8mXScxW4tbBJS2cE/A=;
        b=DTP9Vw1+pV5P9A5nGxK8wEVIVNwzrN9+j4vFLn4A4pVZhQ6DDivTpBE/XhSlXVr/6F
         +OC4gwfH52ildVVcD7rxf+pHf9QFQlcoW5FifvmllfV2CZImQMx8fIqqZI84PkCRBCpk
         ikUL49G0qRzPj44iMXDCmwgXrIA1TrEKJQNrJfjgLz+widnoSRrX9XnqouVW6rKCiRBX
         bd2ffuFAtgfp+eduaySyXhLZeDBVm5BIayZ2E8kP9ZUycTEY8wZE25XNQ699szx6mi4u
         TajBtJpHddq2rwFUdRE0xCr4+tTaMc83YnMi0UUuYJguUggvpCpZ3mJC1bBkUuAEdqp/
         Ng7A==
X-Gm-Message-State: AAQBX9cjdmYYt5bJaA5otmJzwHnpZVgnz6yLFGLYQs+AOb2aeSwTRjJF
        ey0qsP+rQUPX/mfFMmlpKITkSw==
X-Google-Smtp-Source: AKy350abyXpnMypjW1Qw0KSRVu6urSBAHcPXvpmZCemAGk/Qg8sQEVODxQOv+nF9K0yGoCCFbL/VAw==
X-Received: by 2002:ac2:48b5:0:b0:4eb:ddb:d03e with SMTP id u21-20020ac248b5000000b004eb0ddbd03emr1559524lfg.52.1681471754470;
        Fri, 14 Apr 2023 04:29:14 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id 13-20020ac25f0d000000b004ec8a7e5362sm763381lfq.101.2023.04.14.04.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:29:14 -0700 (PDT)
Message-ID: <af41069c-add8-f0bf-1180-3e5c4da9d9dd@linaro.org>
Date:   Fri, 14 Apr 2023 13:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 2/9] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-3-git-send-email-quic_srichara@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1681468167-11689-3-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.04.2023 12:29, Sricharan Ramabadhran wrote:
> Add support for the global clock controller found on IPQ5018
> based devices.
> 
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
[...]

> +		.name = "adss_pwm_clk_src",
> +		.parent_data = gcc_xo_gpll0,
> +		.num_parents = 2,
ARRAY_SIZE(), everywhere where you reference parent_data

[...]

> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. GCC IPQ5018 Driver");
> +MODULE_LICENSE("GPL v2");
"GPL"

Konrad
