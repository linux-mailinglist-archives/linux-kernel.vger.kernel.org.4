Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2237F6BE220
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCQHvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCQHvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:51:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555789F02;
        Fri, 17 Mar 2023 00:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37DEDCE1F6D;
        Fri, 17 Mar 2023 07:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5F1C433EF;
        Fri, 17 Mar 2023 07:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679039467;
        bh=9xrYmzI6NAuNQ56Z2bORp63LUgeGm0k+tVwu6MPxQFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFJWyz61ldMIuokiosuUAY6SYkl2D/9WgOwnrazSDOEuvnbFSDC/ErYC2RydXxUwt
         Si2qOwVfRtJT32vFMCPUfbxj84CAmp6IHKsGg1p+JARtTRdgpLT50gOjFiePM8MmU7
         eVqQ5puZshaXBApkeGn+SkXFU10YZxfGIQJmMnNbUoKhE3oxqvFnhZy5qKarRkFhuH
         PbD/TyvBb3WqRxI3uOi+yEt912YmUQa8ltcURBFuP2ubtZ5DA2r8MdW/6C+CWayFfo
         bg7gDTlqFiG2imJLNzwtx/0tf0ujcixLZ+rCVt3yPbOXv92zSxARLSMd8nRgpxMVlb
         5PMW9p1yLDCTA==
Date:   Fri, 17 Mar 2023 07:51:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: leds: spmi-flash-led: Add pm6150l
 compatible
Message-ID: <20230317075101.GZ9667@google.com>
References: <20221209-fp4-pm6150l-flash-v1-0-531521eb2a72@fairphone.com>
 <20221209-fp4-pm6150l-flash-v1-1-531521eb2a72@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221209-fp4-pm6150l-flash-v1-1-531521eb2a72@fairphone.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022, Luca Weiss wrote:

> Add the compatible for the flash-led block found on pm6150l PMIC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
