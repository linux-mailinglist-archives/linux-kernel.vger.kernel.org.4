Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F286866CB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjBANZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjBANZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:25:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AD94C0C;
        Wed,  1 Feb 2023 05:25:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 438A0B8218B;
        Wed,  1 Feb 2023 13:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C49C433D2;
        Wed,  1 Feb 2023 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257942;
        bh=m+7xfJY2QuIs0LiTvWRIRniZk0c6MbfS5LgsPsE+s6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qgMj9a7z7B8rtMsJy3GbnF5yrUWpokZIHTjIntJCPrkQg9jFKwK42ZcP/M0vqLjRm
         cV8E3+qUhDwFyNEgctl1I5mP5f8RbhZggIPLJNjiILTfyxDjyzzyiyCrV8z4I2fDC4
         KT0pxm6cXLqiZ84DLlv1SCUGaMRuGooIlazemHgCj5J5kUVLwQP0NDzIBvUE3O0GzT
         6ufVIjNaBIpjJYB5imjrvcdtBrG53e4pWBXg3afx9kVVYTQvd003ojGMl+K+h4oxWw
         y6E8tEwrKXWo6eEQCbhbXF2kViCFXgcJZyCAqfnMYu7nmgiC2CRFII3EhJQiQ2x7Cg
         DbvqZ/das6QAQ==
Message-ID: <5f7f8d14-6769-83dd-ec36-416b4fdb38e9@kernel.org>
Date:   Wed, 1 Feb 2023 14:25:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] WIP: dt-bindings: soc: qcom: convert GLINK binding to
 yaml
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220424135609.22388-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220424135609.22388-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2022 15:56, David Heidelberg wrote:
> Convert Qualcomm GLINK binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - fix multiple issues
>  - V2 is JUST a placeholder until I get back to it! Do NOT review yet.
> ---
>  .../bindings/soc/qcom/qcom,glink.txt          | 94 ------------------
>  .../bindings/soc/qcom/qcom,glink.yaml         | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 94 deletions(-)

Thanks David for the work.

It has been 9 months, so I assume the work is abandoned and you are not
going to continue with this.

Best regards,
Krzysztof

