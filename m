Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F400B60ABCA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbiJXN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiJXNyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6543BD051;
        Mon, 24 Oct 2022 05:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3930861325;
        Mon, 24 Oct 2022 12:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38768C433D7;
        Mon, 24 Oct 2022 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666615422;
        bh=D2PZQrDtlP+eiP0Nd/UbqdKsgYkhQBlz39Na1mE1SOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq0skJQWuazhFpK+nEcDNGRmPO4Sf91zVDEiPtM4lv3CQ/bseoieGrgKQ9i8tIlHD
         2fc4j7oYpjILgnHtcrtEJDloJa5Fg8N6ZYPD5vaLDD3d0l7yuKG292UjMAwUJVyY4K
         PWdOgcPf5KSfXDFIfcz9AQjPD/WuUEAFZzDXw5FAj4D+qlauIoj6e4n/NRzpEZQaif
         LWPna5PU5vlOL5pVYN+UT4fJO9KKHQCYULkoPlOtYnd7sKgIdAc/TbOkOwDca6V1IM
         eaiC59lduOdhFaz7cQ6U9bCmr+PulFflwJYb/Z2N/2bKTbL3hAFS8W5VOB0rO09y9s
         iq2LGNvbQD8Uw==
Date:   Mon, 24 Oct 2022 13:43:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom,tcsr: add sc8280xp binding
Message-ID: <Y1aIeeazaDVPfDSc@google.com>
References: <20221007121110.5432-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221007121110.5432-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2022, Johan Hovold wrote:

> Add a binding for the SC8280XP TCSR.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

NB: Didn't apply cleanly, so ensure you review my fix-up.

-- 
Lee Jones [李琼斯]
