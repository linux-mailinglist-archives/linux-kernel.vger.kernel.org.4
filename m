Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEEB659ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiL3RJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiL3RJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:09:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F951901E;
        Fri, 30 Dec 2022 09:09:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C32FB81CEA;
        Fri, 30 Dec 2022 17:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C198C433EF;
        Fri, 30 Dec 2022 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672420184;
        bh=JOyOOPHb4ZGilsFo4o531BT2E+thHzuywmesWMld4ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LDnzZ5HvuNwR+gTS0iPNsbLzW3p1QPyUSj4zb20QOFJhb3U/mMVnPjvmsxEURNyVI
         6h8j7IQhwuOiQySsQfHsqix/CoEMB479JS1e65FOj/cZEWn95kXsRoj1ZkOaotFhA1
         unvSXA6QZ0v0mfW9fDJ1W4S9z8yJ9921/QDhnVFGZnQyov1l7MZfaG2PP6qzixMavf
         m5gBrEh3YY7XwbzoOvg5vOOGaXYZs+FK/bzdLjaxf+Sc7+36DNHtZRr5Vb3XTxs81k
         G9xqiUpjUIkOPCGtoFcoBBCn9VBbjHSAplunO4sCmI/D2A9TrjIFLq/3Nbkjzvl9Cm
         YC1vwdLlv0Y2g==
Date:   Fri, 30 Dec 2022 17:23:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: iio/adc: qcom,spmi-iadc: document
 PM8226 compatible
Message-ID: <20221230172301.6bbfaf3e@jic23-huawei>
In-Reply-To: <98992679-47bb-24d3-d253-48fefb4a45f5@linaro.org>
References: <20221228230421.56250-1-rayyan@ansari.sh>
        <20221228230421.56250-5-rayyan@ansari.sh>
        <98992679-47bb-24d3-d253-48fefb4a45f5@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 09:47:27 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 29/12/2022 00:04, Rayyan Ansari wrote:
> > Document the compatible for the IADC used on PM8226.
> > 
> > Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>  
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied to the togreg branch of iio.git and initially pushed out as testing for 0-day
to take a poke at it.

Thanks,

Jonathan

> 
> Best regards,
> Krzysztof
> 

