Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4712F71037F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbjEYDvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYDvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0057CE2;
        Wed, 24 May 2023 20:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D8464259;
        Thu, 25 May 2023 03:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A1FC433D2;
        Thu, 25 May 2023 03:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684986707;
        bh=bk0RnniuXaXu7zObzQhlgQoNOyofQ/cAuLuVklUpRbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQGGBnUWoAIkkvvMOtc6CdLCWiSqHviqUVbtLWISrAPE3Ar06HsbWgc8rcGlcD1SR
         biqtkppaVI3ifUrSTecR941zfDvDLviEsFPgWnngy4ox17hDsotrGDy4PoIofkuCB4
         exyihfajFLzirqCYCTI+ogAaW9FpyYRMVoO/gqy+ZNC+eO+70OtHJNYi/TBRQFUqu6
         MGlbj6+RUISeIFcI2My5GkNE73jEmmf4wHwgnd/Og0rbMqo94blYJ8Tg33k1CBgzn8
         8DQrMHSZ1zcRT63xm5PS40jPeMKHn1vasBRUT6Bv4rOo6frFkLJX/DjpEBqhEwdbNz
         Q9xh3HaaP/3BQ==
Date:   Wed, 24 May 2023 20:55:38 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     tremblay.gabriel@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change the interrupt from level_low to edge_falling
Message-ID: <20230525035538.wcdpqmaumz5ad4r5@ripper>
References: <20230502-gtremblay-x13s-keyboard-v1-1-6bc3e59b0d39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502-gtremblay-x13s-keyboard-v1-1-6bc3e59b0d39@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:31:14PM -0400, Gabriel Tremblay via B4 Relay wrote:
> From: Gabriel Tremblay <tremblay.gabriel@gmail.com>
> 
> 
> 
> ---
> Lenovo's x13s internal keyboard shows responsivity issues when fast
> typing occurs. The problem is not replicated with external HID keyboard.
> 
> This fix tries to alleviate the problem but requires further testing
> and commenting.
> 

This is interesting, can you tell us a little bit more about why/how
this improves the situation? Perhaps that could help someone with
schematics to look into this further as well.

Regards,
Bjorn

> Signed-off-by: Gabriel Tremblay <tremblay.gabriel@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index bdcba719fc38..e8d7f02c9bf3 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -639,7 +639,7 @@ keyboard@68 {
>  		reg = <0x68>;
>  
>  		hid-descr-addr = <0x1>;
> -		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts-extended = <&tlmm 104 IRQ_TYPE_EDGE_FALLING>;
>  		vdd-supply = <&vreg_misc_3p3>;
>  		vddl-supply = <&vreg_s10b>;
>  
> 
> ---
> base-commit: 84e2893b4573da3bc0c9f24e2005442e420e3831
> change-id: 20230502-gtremblay-x13s-keyboard-289935f922e2
> 
> Best regards,
> -- 
> Gabriel Tremblay <tremblay.gabriel@gmail.com>
> 
