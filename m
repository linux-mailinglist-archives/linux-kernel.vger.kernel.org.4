Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E95B67C472
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 07:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjAZGP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 01:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZGP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 01:15:56 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87CD22DF1;
        Wed, 25 Jan 2023 22:15:54 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i17so284166ils.11;
        Wed, 25 Jan 2023 22:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OqilOyvr7lrBfOGjon2uUQjq6EGIVQX2EF3eR1kL4o=;
        b=gHUF4N2221SYUz0ke31LjgoQAjsFdiOk6J0VgXsWdprGliqlxbpksN8Eke4ere3I5B
         89NShOESyxBDh/EH0q+LtT43g+WqulqvnTj7QuI+x0dM+FT1iiYh8SXtg+wu4MqWkSJV
         9LqAt9AKaebqwrYN83u5o6IsrSo1rxRjCvWjSRse6wzPzmbQw6B7W6a0IpmfjjTkbFRd
         lPhR6YDa/PlBpyZxkDA7OvArCCiY8zYjtukBEIYSOOKoxJyUndVOo7xzFC4wxfJnoIXc
         a7R+O2rMSwDmxm6D9f80FNd1A/oLzej9WAlqDoFsYC4+KuwSo9ILGQK3pCHjTqk+6LqR
         rctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OqilOyvr7lrBfOGjon2uUQjq6EGIVQX2EF3eR1kL4o=;
        b=MwPSMkNXTJrMexLsriECOZq4Iju9Hd5aS7PYBMzJtaRZQWRhFgxmrbZ5BeX9Zkt3dl
         h5mhWsdVPafJPQvYf3VtxnwhzdOkm63Mg7JtdbcoHaGjwSYQp0E8EAyE/N8eB4crNhcj
         aRoYzRm89sDgjt7A/Lajt199XznFTxS4gi1qoHt3i3g5VhWCmf/yUVchBCIzHjk6rl8v
         SipcLmY+qkAd50/3ijxLPBvkonqOBfAferSmAOpejeu+BDA2NPEItqnpTLHoNh2PzHl9
         tmFrBK4Pyq7TA2gJXzXFUidts9CmrcWrGSUZlJERrO8eya4rZPL44tWMz8Qo81RhkCLm
         pcEg==
X-Gm-Message-State: AFqh2kqEdbs4uWojuNMr72zcTj55MuxjyVMiUL1JuyH7E/e6Qfq4spxI
        WdfpXnk2OTu17QZuBg9VJqM=
X-Google-Smtp-Source: AMrXdXsr0FhK2Qjh7EWxKJ243S4NK1pfZa6RJr4LmjL3HMGpaVjfZLHPAqACXh5nZ0hcp8NusFfFGA==
X-Received: by 2002:a92:9501:0:b0:30e:f03e:a76e with SMTP id y1-20020a929501000000b0030ef03ea76emr4185951ilh.2.1674713754120;
        Wed, 25 Jan 2023 22:15:54 -0800 (PST)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id r5-20020a92c505000000b0030dc75aaf48sm129645ilg.47.2023.01.25.22.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 22:15:53 -0800 (PST)
Message-ID: <b47b5a49-6e68-c827-a88e-f61fb85521c8@gmail.com>
Date:   Thu, 26 Jan 2023 00:15:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-xiaomi-beryllium-tianma: Add
 reserved memory region
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        phone-devel <phone-devel@vger.kernel.org>
References: <20230124183257.1525376-1-amit.pundir@linaro.org>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <20230124183257.1525376-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit Pundir,

I have a Poco F1 (EBBG) variant and I can confirm that the framebuffer
address is same for the EBBG variant too.

I did a quick check by running the following command based on this link[1]:

xiber:~$ strings /dev/disk/by-partlabel/xbl_a | grep "Display Reserved"

0x9D400000, 0x02400000, "Display Reserved",  AddMem, MEM_RES,
SYS_MEM_CAP, Reserv, WRITE_BACK_XN

So I think it's safe to move this to sdm845-xiaomi-beryllium-common.dtsi

Regards,
Joel Selvaraj

[1]
https://wiki.postmarketos.org/wiki/SDM845_Mainlining#Find_the_framebuffer_address




On 24/01/23 12:32, Amit Pundir wrote:
> Put cont splash memory region under the reserved-memory as
> confirmed by the downstream code for Tianma variant as well.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> This change should probably go in sdm845-xiaomi-beryllium-common but
> I don't have EBBG variant's downstream code nor the device to test.
> 
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts      | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> index 8e176111e599..47cbf725b0e3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> @@ -7,6 +7,14 @@
>  / {
>  	model = "Xiaomi Pocophone F1 (Tianma)";
>  	compatible = "xiaomi,beryllium", "qcom,sdm845";
> +
> +	reserved-memory {
> +		/* Cont splash region set up by the bootloader */
> +		cont_splash_mem: framebuffer@9d400000 {
> +			reg = <0x0 0x9d400000 0x0 0x2400000>;
> +			no-map;
> +		};
> +	};
>  };
>  
>  &display_panel {
