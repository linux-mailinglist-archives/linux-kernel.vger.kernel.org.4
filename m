Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A2714CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjE2POl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjE2POj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:14:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36FBC4;
        Mon, 29 May 2023 08:14:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f623adec61so35139445e9.0;
        Mon, 29 May 2023 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685373277; x=1687965277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1KMg1Gh4zz7JnBw0046XM2DKaYNxDcHqxWVJX30Ru0=;
        b=Nh5o4eUQPvEkj8np21rWFW592NTi/HveYWx2/MbveBUkmHmO2cKIDGvAcQa0aX+cDw
         A0jCa4ioo+hFHvLfG1glTnwtJjTMP05sj5R75i/OFbkMvv9MA+qETGFpyU/vTQUeGVR6
         p7XWeX5xCLNclglpwxjBrLCPaDfRAu4LRC0nhGk3WSdgs8qAXK3lmxTxLeyKtXJhbsx8
         O/OYr2tuOEBQr1ydBX9lP8PjSmFRJLm8lptKzAiHaE80ryLS1pzEEMf1wSDnQgGBWxBs
         6uFcbKolwHZp330okeIrE3IJIx37a3PA8osXpdI4giCngUBK/9yG+Z7cSGQpM+nMosth
         kEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685373277; x=1687965277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1KMg1Gh4zz7JnBw0046XM2DKaYNxDcHqxWVJX30Ru0=;
        b=B6//5+Jsj4d5DiTlrALjn2Zl6ZZTaJT9978INr6UsG6l+fAlVHbn2641GXooKSTsm+
         akeO0Oc+zrLx4SFD/OtHq+nuRQ06OAhLWOp9sd4+rITvmEJrjviXMASyiAg+p/Oc1Doc
         y8PqC9aS0e8/WRJw5o4jkQ8ji2OEG5SbFIrQN57euYzlrSI8tV9EILIWqawXmIspJ8QM
         /DPjouZgYEcHrBEcQwAaR5HqfG9g6CRDdWVRkksDqiFYLsbxmEbx/ys+4jfZBHvj/vj/
         3cTDqvN3uanpCZ/ftYAFbQhYa/HN12i+RjvaKPxYgfFw2jieJHTAg3rMNMvQIyCpxnrf
         BqKg==
X-Gm-Message-State: AC+VfDzfFnlnV+hVPurYqBYHcKY6DRa9ntY6qpalJs2KTQG1moFmXibd
        VYbaEBX1qnvuh+vDo44EL4A=
X-Google-Smtp-Source: ACHHUZ6xoIrct99/EDij7HwB9El8wTsztw/AS5YvNdVtO4OP71ye5SlHvavzE7cclIWQG9ZWOc1kow==
X-Received: by 2002:adf:e592:0:b0:30a:dce8:f8b5 with SMTP id l18-20020adfe592000000b0030adce8f8b5mr9054514wrm.58.1685373277175;
        Mon, 29 May 2023 08:14:37 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000009100b00304adbeeabbsm217867wrx.99.2023.05.29.08.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:14:36 -0700 (PDT)
Message-ID: <063c425d-c6da-3e03-0f52-2cc9288ba4cb@gmail.com>
Date:   Mon, 29 May 2023 17:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: mt8195: Assign dp-intf
 aliases
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
 <20230424112523.1436926-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230424112523.1436926-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2023 13:25, AngeloGioacchino Del Regno wrote:
> Assign aliases for the primary and secondary dp-intf IP to properly
> and reliably enable DisplayPort functionality.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index a44aae4ab953..b03a42fe27a6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -24,6 +24,8 @@ / {
>   	#size-cells = <2>;
>   
>   	aliases {
> +		dp-intf0 = &dp_intf0;
> +		dp-intf1 = &dp_intf1;
>   		gce0 = &gce0;
>   		gce1 = &gce1;
>   		ethdr0 = &ethdr0;
