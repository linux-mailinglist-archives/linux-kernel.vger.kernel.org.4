Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172DA6D1566
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjCaCAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCaCAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:00:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E734F1114A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:00:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y20so27077832lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680227999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/Cs9N+JBNHHC68UN10KBHftx7PWk935ziMWBy68/UU=;
        b=y0+11ekoozy7ddS70UYGrYRiSq7iKD1xpNu2FDf+w7oshkJ2IM8w3ZDTyT6z2B1B/D
         /YL9W6TpsTZxkzQZf8Dl6ETruZWpwEl3uDpNPUrV59JrKpfcveUkl4Gc/nOP+gclwixq
         Jn45mCC/ikg2SgbvS9NkqM2cRtk5bg9b7zhvNELZgXYLN3qcDcc6uOzduy+P3euMRqdX
         RaH24TLSJesNd+NACqpXz/HkHCeRyaEU1ynCrX33DZBsbC3uFj7fC4hti2cur/nSUM1S
         LSHsVSx7/tqOTOnKB5z5HVN6eD/2VIAUfmjQOhP7jDEE/D/QrZ03blr37AYwemCHpMi7
         xPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680227999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/Cs9N+JBNHHC68UN10KBHftx7PWk935ziMWBy68/UU=;
        b=Tel/kvYbJzyVBRAjNBWQ5Ro71IoXzuSuKC+X0FZWroMwW8ZU3ctBrVu8aCHZXpiGlB
         C+F39dlSeFpzOIWgL0uZ6CpTx7N80+VYg2cnZdaGFQxX3lCSKkVbq1Z4Nl6PTBnKS6v3
         4gjzCQCRBnhwMHs6PDl9YTT4Wxcg9/B3V0B6I/GMLkdKYWfHL9NEmvMW9Sir68DBKE4s
         GGia2SCVNT0i+vAXq/ZmEGkTgxpFS7hGo61WpPG7fXWbgj+7XfKyWqYme4IU+XawSK9H
         4n6ZWuDzvW/afbmTpkcd+7Mec4sVGIgj98CDfqJxYxT8GgWWYHvpwqq+IgfqQzKxCKHL
         Sntg==
X-Gm-Message-State: AAQBX9f2HDtjEUXvNS8Rz/x20KLRf8bLtSdSV9uOQ6XJlys9CdDj3QgR
        45ruhM0MirIE/990Y8homOTCjw==
X-Google-Smtp-Source: AKy350atLJ9EP2srAoTJvjirAAVV59z6TRpyvHABLEzzCXDLX1sakEK7UHARpa3ykAYY1IbpVGgZgA==
X-Received: by 2002:ac2:515e:0:b0:4e2:cb9:e266 with SMTP id q30-20020ac2515e000000b004e20cb9e266mr7130104lfd.50.1680227999049;
        Thu, 30 Mar 2023 18:59:59 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id x9-20020a19f609000000b004db51387ad6sm168515lfe.129.2023.03.30.18.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 18:59:58 -0700 (PDT)
Message-ID: <4ffea89c-7b8d-7a3a-4c8a-e5f4dfb9bbcf@linaro.org>
Date:   Fri, 31 Mar 2023 03:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/4] dts: arm64: qcom: sdm845-shift-axolotl: enable
 SLPI
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230330165322.118279-1-me@dylanvanassche.be>
 <20230330165322.118279-5-me@dylanvanassche.be>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230330165322.118279-5-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.2023 18:53, Dylan Van Assche wrote:
> Enable the SLPI DSP on the SHIFTPHONES SHIFT6mq phone with a
> Qualcomm SDM845 SoC.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index b54e304abf71..bd9571a258cf 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -572,6 +572,11 @@ &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&slpi_pas {
> +	firmware-name = "qcom/sdm845/axolotl/slpi.mbn";
> +	status = "okay";
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <0 4>, <81 4>;
>  
