Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1197415E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF1P5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:57:03 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:51634 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjF1P5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:57:01 -0400
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-78358268d1bso1659239f.3;
        Wed, 28 Jun 2023 08:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967820; x=1690559820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9vjhtyrPzntszALkJYOS9anDbw7azywtjHfHluvC5Y=;
        b=La553Fu5dzwZZIKTKR/znoX7nSh5175fbD5cEPAdoxld5t6kSPFfdJCCkCop5bnRO4
         r0OC+aCJyjL7W0U6wcQcGtVQ7Wc6SGxyzCDUbzvUD+ojKP2sy3szpCJ8LzW35ysl5VBs
         lQu145jotC1X+ODiw8CJyUPuAR7MwzYY+W1l7iVpbeNNOc4ArwykmsZDnteL+i5Imk6l
         Bx3NIJUBMUNJq8ktP7aHyhWvZrda/NGmvK5V5dtLUCu0cwfqI7h1XG+2KNFmqe2+4n7F
         0Jef0m8+Kw0jvUyA+/3IK9cENDyhlgP7D5OVsboqlvx0CDsxggsnt9AhfEtVc4t/vGtZ
         SCsw==
X-Gm-Message-State: AC+VfDxYJojTTlH/e3wRY8fY6x/e/m3Qvu2j6jfilwUflP/3Kz27j0zE
        70UowV2IAwvfAB/KpLuGF5j3doejiw==
X-Google-Smtp-Source: ACHHUZ64GJSy6e4Pv/1ugB/LV0/Ouck7xZFFJ8siqL5xc7fp0UeLsbQMENBu18KcKlP3ZqY6x1t5kg==
X-Received: by 2002:a6b:fd13:0:b0:786:267e:bd4 with SMTP id c19-20020a6bfd13000000b00786267e0bd4mr1049163ioi.10.1687967819767;
        Wed, 28 Jun 2023 08:56:59 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v20-20020a6b5b14000000b007836c7e8dccsm1540597ioh.17.2023.06.28.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:56:58 -0700 (PDT)
Received: (nullmailer pid 544141 invoked by uid 1000);
        Wed, 28 Jun 2023 15:56:56 -0000
Date:   Wed, 28 Jun 2023 09:56:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v12 01/10] cpufreq: blacklist MSM8998 in
 cpufreq-dt-platdev
Message-ID: <20230628155656.GA542106-robh@kernel.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
 <20230217-topic-cpr3h-v12-1-1a4d050e1e67@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217-topic-cpr3h-v12-1-1a4d050e1e67@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:00:40PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add the MSM8998 to the blacklist since the CPU scaling is handled

s/blacklist/denylist/ or s/blacklist/blocklist/

> out of this.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index e2b20080de3a..adb3579a1fee 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -143,6 +143,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
> +	{ .compatible = "qcom,msm8998", },
>  	{ .compatible = "qcom,qcs404", },
>  	{ .compatible = "qcom,sa8155p" },
>  	{ .compatible = "qcom,sa8540p" },
> 
> -- 
> 2.41.0
> 
