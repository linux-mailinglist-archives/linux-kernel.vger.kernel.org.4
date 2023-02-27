Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF76A3A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjB0E2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0E2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:28:17 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23331113DB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:28:14 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 130so2792948pgg.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMvkWjZNPPFl1pl6IaXhWMOFP4oUQ7mx0SfykEhX4AQ=;
        b=a8nxOFzJthk2KULRQ7fJuTH1ykL4dpMUTRb8Yi8d+6LJ5GcWR7OB4odOLdot4sqkKj
         5JfbokevLgJZdOes29MK9qUlhRhuZlmLygzbMbqmnKohfPfQi+rVMiglPcpiDAbHaMwV
         opICb88ttD10bHt8A+nX51ok/xtztTqUyfZly2soKwIsHS4JF0gNz+7w23S/ACXwuKwx
         CgZsiWNwKHOh6rcZ/uIoQsvBy2PpP+AiNp9hHPLX9Ib4gMRJKfz2u7xbdTNJiS7+kU75
         vq0dCTsJ2ItUQRzaa1J+i1mxtZ+DTLflpfuTszmRcHRbkKvgl8FDRvAH+1xzWQ1xaZ5o
         Qo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMvkWjZNPPFl1pl6IaXhWMOFP4oUQ7mx0SfykEhX4AQ=;
        b=eaTJ6R8Ic5Jz8HvMqrpyUkL3Fc7OXTd2lMzNR+OfQ1BYde+pxXyNqoBbSGsV86V6Eh
         RT7qmpytauRaIJ9IjjHZJlvaLsFIm1L0i3OTLsvEHsRZblHpbzTSAfm1Ob0R23J/xbVE
         L+lfvknCzXgi9nK3qv23c/XnAi1HTBJ+2dOnbU+eawPuzdsJ5lmWCjfO0nFtQGQaeonp
         wmlb4/HPBXcT9eJHs8DyIy6iDP2XbaKAMM05VRp44O5fOVq/vvhDM7++UVYebNSCBqXt
         nQnOpf0qYuY8CCCRjGHqmSHaeHojeLoDoh75p0H9tygRPhY7XiNIK+iPt9VkXpaCbq+d
         vD1w==
X-Gm-Message-State: AO0yUKXhE7r30rx978PvONbJYzMcyiLLhGWl9f8HQNB/cAXsX3d4LqIk
        kDR0pvw+BFKDleoI7xfEtG4YVV49ZLAXxj73
X-Google-Smtp-Source: AK7set9GRzJ36aXs3VcwXq4IrdwM9TW62o8bs1MKgJLWEB7nYBiBcYlTgsuE9nvQM1DXtJiAr6coZQ==
X-Received: by 2002:aa7:9eda:0:b0:5a8:5e6d:28d7 with SMTP id r26-20020aa79eda000000b005a85e6d28d7mr18966817pfq.0.1677472093500;
        Sun, 26 Feb 2023 20:28:13 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id h26-20020aa786da000000b005e4c3e2022fsm3178721pfo.72.2023.02.26.20.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 20:28:12 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:58:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH] ARM: dts: spear320-hmi: correct STMPE GPIO compatible
Message-ID: <20230227042810.vki4khjrusnf2r4b@vireshk-i7>
References: <20230225162237.40242-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225162237.40242-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-23, 17:22, Krzysztof Kozlowski wrote:
> The compatible is st,stmpe-gpio.
> 
> Fixes: e2eb69183ec4 ("ARM: SPEAr320: DT: Add SPEAr 320 HMI board support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/spear320-hmi.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
> index 34503ac9c51c..721e5ee7b680 100644
> --- a/arch/arm/boot/dts/spear320-hmi.dts
> +++ b/arch/arm/boot/dts/spear320-hmi.dts
> @@ -241,7 +241,7 @@ stmpe811@41 {
>  					irq-trigger = <0x1>;
>  
>  					stmpegpio: stmpe-gpio {
> -						compatible = "stmpe,gpio";
> +						compatible = "st,stmpe-gpio";
>  						reg = <0>;
>  						gpio-controller;
>  						#gpio-cells = <2>;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
