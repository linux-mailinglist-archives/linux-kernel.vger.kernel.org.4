Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5843687D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjBBMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjBBMVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:21:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0D4719BD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:21:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3610230wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 04:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVnSNVLkirZsOOObippIbZpPHleUf0e9ALdESsHrof8=;
        b=X4SauV9pfzQyRwWA4Res88+GNk8Xtwyd1WbWCrEu26RllMSrfRF3mFlAtqOWyPsmW7
         1J+6s0V9bJ9GAsx6/TCDeM2v2o0KyqV35fMXpj9jiSnOoAS5H8mYKPBAzXFaZkjCX2ox
         BlKhVlg33sIZlU1NjR9kjG4Y7KhFuXkjjncO6RtFfCmht3S/WdI/B9LujvNe11kqxYbF
         3H/PdkoqbcU6gHEG8sBS9EuGb582wMk1UOKTffkxGrQfKjBL45M7IEhEfhDr2tB7irC5
         r58DPr0FKrhwYMwADpdEXEGdONm7Ht25MxmUU969BTeMm10oSKZpaBZqjx1Eb4nK/zPt
         RNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVnSNVLkirZsOOObippIbZpPHleUf0e9ALdESsHrof8=;
        b=xXdn2lP5ft7i6GJzllI22fXlE8xvsOvb9/I2cEBxSuAVulEb7HNgi81qYyeXVOKbNo
         jQoYREJh6lkVu+CYIgZUbpG351UvvQmU+qMiEtZGEhhv45ToK2oTBg2u4HCKldMuOld/
         v7Pu4NIbfonqBSpjwdzoaaaZuEqMLsu35qCwxZdUMfn/8eEFSZEzbCVdGe/wuE8D64Ri
         WZRHFXfJ0r1Y9nl5ZkqR0Cot2ucyUS1dJWfCnMuFSDvFjdwYZOuD4LWTxCmjl+KzsH7b
         D5XgTofkeV+vW2AFxsgPDSf9cECWw+3Rb5kNB0wqSlPOnli6kq+VozROWp+j1uTLqSZX
         XSyw==
X-Gm-Message-State: AO0yUKVUbdi3bKlr8V8nKa81wcFqNjJSSWtHUDz1IqpvZXSH+sfdhQz2
        EXffGXnKEkfyQOELLQhGcSx5NQ==
X-Google-Smtp-Source: AK7set9WJgJis6imdCs93B5K6NXjwk3h+rbbbfDsad+kqWlyUv7u3ip81PwxkuOb/FNsWPRiheFahA==
X-Received: by 2002:a1c:f603:0:b0:3df:dea7:8ec with SMTP id w3-20020a1cf603000000b003dfdea708ecmr1445503wmc.20.1675340472474;
        Thu, 02 Feb 2023 04:21:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r38-20020a05600c322600b003dd7edcc960sm4312412wmp.45.2023.02.02.04.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:21:12 -0800 (PST)
Message-ID: <6c423a53-2df0-4802-099e-c0de6ac7b60b@linaro.org>
Date:   Thu, 2 Feb 2023 13:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 18/23] memory: tegra124-emc: fix interconnect registration
 race
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
References: <20230201101559.15529-1-johan+linaro@kernel.org>
 <20230201101559.15529-19-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201101559.15529-19-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 11:15, Johan Hovold wrote:
> The current interconnect provider registration interface is inherently
> racy as nodes are not added until the after adding the provider. This
> can specifically cause racing DT lookups to fail.
> 
> Switch to using the new API where the provider is not registered until
> after it has been fully initialised.
> 
> Fixes: 380def2d4cf2 ("memory: tegra124: Support interconnect framework")
> Cc: stable@vger.kernel.org      # 5.12
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

