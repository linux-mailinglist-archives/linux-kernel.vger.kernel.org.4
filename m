Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2810E605659
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJTEfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJTEfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:35:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8AB15B100
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:35:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q1so18143137pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vaTJwOuEg93iQQbdS+3fyrSbZ2F6gvnRoRGn3vEwwlc=;
        b=fXLmBLGDsn3B1lcmX2rR2fnv1LRU+O9Z+KLUZE5v0P4rE+VHfpNukHXhWNOsPICWI8
         cE3IUw79W3w8yjrc+G0PYZdUZ6G2ZxF03miAuDIzD3GUlTDyZcBL9/xhRFymof7pPulU
         YhmHORcwwHiczDf1HHypj8Bl8F/pQaYb+M4O0Ep+dd1SwIWvcEySoL1LFQ/npC4EDgKt
         S2B3c4QSUxF0Oc6zU+xrGZ0sACC1tPTY2WVb06qsIMrgIS486MWUeF0Gvzyax7ObtMc7
         lYQhp2JCfO0wAfqNfx0EtjFLAzR58ILRo6wnMzaCaV+2Gc23+oLE3V3/fxQwg6qutx24
         LYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaTJwOuEg93iQQbdS+3fyrSbZ2F6gvnRoRGn3vEwwlc=;
        b=xWnyLhZHJsrEwWQxkAyhXxpZhYFjxZDGiFm+X3uCI5IItDtmc7EywAqtuYmyj0biUj
         eraQIXmMDZKa42OZJpGph0iDwiohWdzsOBYYEYkPEcPoXWFNNmvxZyX/MNMasrXHa0JP
         +NVa2IdyxQfNRWodz2UIL0VTyfOr52e9BwoMradXdZcSiUV1COPYQ67SjDwaG8qo1XGb
         2nEct47rYU6y3ISOZxA1dpakNjX7JuO+hjnXoaW1pmG84OCb7BK0SpD6eMP97W2fztIp
         16VrNWUQ+rNOD/vCTL94U1lya80K5cx8/hj4q+1T/xmgU54gX/1Wqzjv5Qu40A2FKunH
         yu4w==
X-Gm-Message-State: ACrzQf0L/rr6taG7y5G4m6ZzEt9s/mLuqJrcAzV20OXX1s3gJLvio2Ee
        SeT5A8DttduXKyNZO/2Ju+Pugw==
X-Google-Smtp-Source: AMsMyM4lAKNM3kgTfz4JjX9/gfimDSCwGs+K08lNtqHYthW7vm65NZKtwJ65yFtOI0uccMwqOvzROw==
X-Received: by 2002:a62:164d:0:b0:562:bc4e:253 with SMTP id 74-20020a62164d000000b00562bc4e0253mr11752301pfw.26.1666240544915;
        Wed, 19 Oct 2022 21:35:44 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902ed9300b00173411a4385sm11623239plj.43.2022.10.19.21.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 21:35:23 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:05:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        Bhavna Yadav <bhavna.yadav@st.com>,
        Deepak Sikri <deepak.sikri@st.com>,
        Vijay Kumar Mishra <vijay.kumar@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vipin Kumar <vipin.kumar@st.com>,
        Vipul Kumar Samar <vipulkumar.samar@st.com>
Subject: Re: [PATCH 2/6] arm: dts: spear600: Fix clcd interrupt
Message-ID: <20221020043520.eitwswwxjlrso5jq@vireshk-i7>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
 <20221019133208.319626-3-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019133208.319626-3-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-22, 15:32, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Interrupt 12 of the Interrupt controller belongs to the SMI controller,
> the right one for the display controller is the interrupt 13.
> 
> Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  arch/arm/boot/dts/spear600.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
> index fd41243a0b2c..9d5a04a46b14 100644
> --- a/arch/arm/boot/dts/spear600.dtsi
> +++ b/arch/arm/boot/dts/spear600.dtsi
> @@ -47,7 +47,7 @@ clcd: clcd@fc200000 {
>  			compatible = "arm,pl110", "arm,primecell";
>  			reg = <0xfc200000 0x1000>;
>  			interrupt-parent = <&vic1>;
> -			interrupts = <12>;
> +			interrupts = <13>;
>  			status = "disabled";
>  		};

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
