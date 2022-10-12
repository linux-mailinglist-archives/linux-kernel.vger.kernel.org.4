Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDC45FCEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJLXZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJLXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:25:15 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD12DAAC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 16:25:07 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 5269720706;
        Thu, 13 Oct 2022 01:25:05 +0200 (CEST)
MIME-Version: 1.0
Date:   Thu, 13 Oct 2022 01:11:23 +0200
From:   konrad.dybcio@somainline.org
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996: remove bogus ufs_variant node
In-Reply-To: <20221012215613.32054-1-luca@z3ntu.xyz>
References: <20221012215613.32054-1-luca@z3ntu.xyz>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <f52bff659bba370220a76f72ec32fa0c@somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-12 23:56, Luca Weiss wrote:
> This ufs_variant node seems to be a remnant from downstream devicetree.
Totally [1]


Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad

[1] 
https://android.googlesource.com/kernel/msm/+/dff8939cd46ee6b95535d68c54b8bd05ddb6bc1e
> 
> As it doesn't seem to be used by anything upstream, remove it from the
> dtsi.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index c0a2baffa49d..87e9aef951ab 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -1995,10 +1995,6 @@ ufshc: ufshc@624000 {
>  			lanes-per-direction = <1>;
>  			#reset-cells = <1>;
>  			status = "disabled";
> -
> -			ufs_variant {
> -				compatible = "qcom,ufs_variant";
> -			};
>  		};
> 
>  		ufsphy: phy@627000 {
