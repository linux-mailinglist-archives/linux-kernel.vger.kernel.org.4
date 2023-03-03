Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4616AA4B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjCCWmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjCCWlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:41:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD64BDE7;
        Fri,  3 Mar 2023 14:41:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64A12B81A21;
        Fri,  3 Mar 2023 22:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D13BC433D2;
        Fri,  3 Mar 2023 22:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677881122;
        bh=guToG2I34ng8XWnE8hM/eM3AI8PF4JRhV6Pbkk05RFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkYzpX1r0CKatoAsaFSvgLOdiW7BdWvWq5bgdWgxyBSlII1qigeVm0ujawgyuWtWx
         00ADtzeWMA0bbDOMRyobfc/7gsSLEWpa9Jq4XWzHN0AoJ9qArCEgdSZxag6lqEo5KP
         hidqB/OI7PDemcvFb+hlgk3p9Uj0MIKpNdTUO2aUI8supKM5k2mS3hY6dimXVA2jsc
         HvCIKuoFVsu5C3KH+WtHd6Ss4RtL1FicxMpyJ3geDqZqjLPdSp0DnW5GXIZaveITsu
         H3VjyMCqgwmT0fKvCZKVCIRM3Gqt96tCqoO5XXU51dWdcXtlnKnd4/SJI9fgmx7fFv
         fg3kDm+Qh+xCA==
Date:   Fri, 3 Mar 2023 22:05:15 +0000
From:   Lee Jones <lee@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mfd: qcom,tcsr: Add compatible for sm8450
Message-ID: <20230303220515.GU2420672@google.com>
References: <1675336284-548-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1675336284-548-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023, Mukesh Ojha wrote:

> Document the qcom,sm8450-tcsr compatible.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Change in v4:
>   - added Acked-by.
> 
> Change in v3:
>   - Align with new format mentioned at
>     Documentation/devicetree/bindings/arm/qcom-soc.yaml    
> 
> Change in v2:
>   - Considering here it as v2 as this patch came out from comment
>     made on its v1 https://lore.kernel.org/lkml/c5dc8042-717b-22eb-79f6-d18ab10d6685@linaro.org/
> 
> 
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
