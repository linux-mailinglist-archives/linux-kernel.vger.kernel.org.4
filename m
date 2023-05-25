Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8796F710B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbjEYLy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbjEYLyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FD397;
        Thu, 25 May 2023 04:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B05619D0;
        Thu, 25 May 2023 11:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AB6C433D2;
        Thu, 25 May 2023 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685015673;
        bh=yXZLjlUFVFHvH63iorAG2OYiK40XGG0ldq70nvT1LEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d0lx+BlXBW/xUsIE+/dkKUPR97iPr0VZf9W7k/0jUEs2TRygd2opXRRVm+bguIBxQ
         rCqG4KVn6tcduP+stzIX8LFPe2XESXTKfn6V8w9jqwK9O8cZwT6maAGc5OqIDei0RC
         2oeTJld6DZ3M36SmGzvZOuC1660EGo8SilQIpXikG9pmPLn+U/FpRJexcXbOXNJlLI
         ANeKHJAEZD+igxwusQbcaXvtc/lV4o/IpFk48cDt7zDBETP4l9whNoQQV6ZN1FJO5c
         Ujr4GlKj7XCVcU6u1oSPCEkBLCbYiSLr69rabudVmMZ6h+8bMDpRPDyQOVFZvMFj6F
         kUmV3aOXeH+0A==
Date:   Thu, 25 May 2023 12:54:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_fenglinw@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: leds: qcom,spmi-flash-led: add
 PMI8998
Message-ID: <20230525115426.GN423913@google.com>
References: <20230518133113.273880-1-me@dylanvanassche.be>
 <20230518133113.273880-2-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518133113.273880-2-me@dylanvanassche.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023, Dylan Van Assche wrote:

> Document compatible for PMI8998 Torch and Flash LED controller.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
