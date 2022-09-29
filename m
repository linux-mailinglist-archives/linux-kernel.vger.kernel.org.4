Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744E95EF7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiI2OoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiI2OoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:44:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C432D13D63
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:44:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id s6so2574660lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LkSm2C56o8tzD3kdFz9Q2YFb7DwLBiu4clfDJbl3WmE=;
        b=t9DQlHsq4peMX5nFQVuP+vxQAPp4QbqlqnbBY0+/JvHu3ewoOoATFKVpR2AMYRLjTV
         BozrgV9yNKY8V8vXDs35S3zJD1S8KBd8hCSVSw5EEN1tI7yIx5OmQGrPk23fIVgZftD8
         md3CruqOqBUGUXEbopgNI/rho7z9DsI8k402PXgHxAd26opMxTiWgStbnT3rCcxtSPg1
         0Qq3L6NCZS04fbF4Xi4zkfScfCCKX5MFg59lYUuK3LdcmjQ/aazupohVqJs4iI/g6zZx
         sSnSxyA8F3wh+mAmuIDvHit+qNn4SezBrvQ49dPRwW9Bry2Ahg/anhe3CeHm3fp+UbPR
         TMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LkSm2C56o8tzD3kdFz9Q2YFb7DwLBiu4clfDJbl3WmE=;
        b=iJV2BS2WLRwxnDlGtQORn4vaL6Z+LwZvrAr/ap1lwbH8d3Bcyc0F9c36WQVu5cDvYW
         9hsOvURRDyZKMLWlLj+4UldCo8mJrb5yFiIzXqxFFcGSYXNGxpv53SPqVDVkNSzicJWY
         Clb2hqeYn8eMNiv4/MvI9+xzGhqRaNnUjPktvjc6sCepRkZTcqV07hYDAVSJNNlI6U9A
         Mvf1IXFAzn6Tty68eG1GAT6jUhPxlPAIdgQrTSOgckkUrdWma9bko2ofv5Px9pky9/iF
         5TJvyhZ+Fo7symxE/mlPLpZPWIy4sS5tzy/ZCUMT/f0QEPVBY3YpGPZv5d2FkAnL7IIX
         IB6Q==
X-Gm-Message-State: ACrzQf3bbePUOdoMhW0pCNtpINxDmIfpx258cG/DN6kh0LWx8iCK0ncH
        et5rRihQobfLJ2E5apTfFZRewQ==
X-Google-Smtp-Source: AMsMyM4A2Ji8bAd/eqHnyAOt7Yu02yXyV2POMDi/Exr3ksTpf9Rg8m5p0TiCMGNCeWUVS/EEqglGSA==
X-Received: by 2002:a05:6512:688:b0:498:fe57:b5f with SMTP id t8-20020a056512068800b00498fe570b5fmr1571633lfe.209.1664462654201;
        Thu, 29 Sep 2022 07:44:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m4-20020ac24ac4000000b0049313f77755sm525234lfp.213.2022.09.29.07.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 07:44:13 -0700 (PDT)
Message-ID: <c49ac105-f96f-fdc4-a629-fe34c85f557a@linaro.org>
Date:   Thu, 29 Sep 2022 16:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Update SNPS Phy params for
 SC7280
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1664462290-29869-1-git-send-email-quic_kriskura@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1664462290-29869-1-git-send-email-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 16:38, Krishna Kurapati wrote:
> Add SNPS HS Phy tuning parameters for herobrine variant of
> SC7280 devices.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

