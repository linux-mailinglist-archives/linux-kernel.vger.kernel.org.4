Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80966D05CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjC3NDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjC3NCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:02:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEE6B45F;
        Thu, 30 Mar 2023 06:02:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED9B7B828A3;
        Thu, 30 Mar 2023 13:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C927FC433D2;
        Thu, 30 Mar 2023 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680181358;
        bh=C6dFmm/p5tMbyA1UIquMV4y+sL1G8AxR93yAzlqeNGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7BKkpe0SPmL731XOeBfUzG3VVmW3ICVWpsA5BcknC0GmyB/d9GuFDLsKsB8HY8Pk
         aWM139TpETbYf5fMXLZfXqZt4Cp4eYj1Ozmj1JfhaYF+980wqW03oYkCV5BXzMYM6m
         HbHvXOklMhFfh1Fdx32TQU+vmFQX02TzRlxCqQ/8q+cC8zTEjs3oGxoof2qM6oNjqh
         ZQ+uEJjJLKDs7Jt6UR3IFBUlnLV0Y5802S6ESAiJNBJGkJ/h8Us148IxnsR1cRczvA
         /iAM5hXsH+vZqjZkZHNX2kpVbakkV7Rqcs1bCp6iCb5+Or3JcdGNn4OP4TY6ULc6lE
         i0TIHG7rgCgoA==
Date:   Thu, 30 Mar 2023 14:02:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: add nvram function
Message-ID: <20230330130233.GP434339@google.com>
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230320135710.1989-4-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023, Johan Hovold wrote:

> Add an 'nvram' pattern property and a reference to the corresponding
> SDAM DT schema.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks

--
Lee Jones [李琼斯]
