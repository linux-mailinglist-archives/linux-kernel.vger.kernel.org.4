Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD406073D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJUJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJUJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:18:54 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4A1EA560;
        Fri, 21 Oct 2022 02:18:37 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.134.neoplus.adsl.tpnet.pl [95.49.29.134])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 07AA91F95C;
        Fri, 21 Oct 2022 11:18:29 +0200 (CEST)
Message-ID: <c39e27fb-e69f-0d1e-16bb-2acc0b5a5b1e@somainline.org>
Date:   Fri, 21 Oct 2022 11:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] arm64: defconfig: build-in Qualcomm SC7180 and SM8450
 interconnects
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021032702.1340963-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221021032702.1340963-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.10.2022 05:27, Krzysztof Kozlowski wrote:
> On Qualcomm SC7180 and SM8450 SocS, the typical debug console serial
> port is part of GENI Serial Engine QUP Wrapper Controller which uses
> interconnects.  This means that without interconnect drivers, the serial
> might not probe.  Without serial console, the root might not be mounted
> by initramfs:
> 
>   + REASON=No init found. Try passing init= bootarg. PS1=(initramfs
>   ...
>   (initramfs) run-init -c /dev/console -n /root /sbin/init
>   run-init: opening console: No such file or directory
> 
> This means that interconnect drivers on these Qualcomm SoCs cannot be
> modules and must be built-in to mount rootfs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/configs/defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2af94d3c1c11..c1b7fb44e381 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1301,7 +1301,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8916=m
>  CONFIG_INTERCONNECT_QCOM_MSM8996=m
>  CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>  CONFIG_INTERCONNECT_QCOM_QCS404=m
> -CONFIG_INTERCONNECT_QCOM_SC7180=m
> +CONFIG_INTERCONNECT_QCOM_SC7180=y
>  CONFIG_INTERCONNECT_QCOM_SC7280=y
>  CONFIG_INTERCONNECT_QCOM_SC8180X=y
>  CONFIG_INTERCONNECT_QCOM_SC8280XP=y
> @@ -1309,7 +1309,7 @@ CONFIG_INTERCONNECT_QCOM_SDM845=y
>  CONFIG_INTERCONNECT_QCOM_SM8150=m
>  CONFIG_INTERCONNECT_QCOM_SM8250=m
>  CONFIG_INTERCONNECT_QCOM_SM8350=m
> -CONFIG_INTERCONNECT_QCOM_SM8450=m
> +CONFIG_INTERCONNECT_QCOM_SM8450=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  CONFIG_EXT4_FS_POSIX_ACL=y
