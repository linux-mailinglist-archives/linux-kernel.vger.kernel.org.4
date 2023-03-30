Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D06D039F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjC3Ln4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjC3Lnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:43:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796FA5D8;
        Thu, 30 Mar 2023 04:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD24FB825D9;
        Thu, 30 Mar 2023 11:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C36DC433D2;
        Thu, 30 Mar 2023 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680176505;
        bh=rXmzWmTdCua+brsYvFqbKxn45paN2GvTet5Tq2mmJ9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZI4++sUZof2fZHnuW8OAYRFY06/ZfHv2/L5vUKKlAfCxGaSMV4/hfCjNaUiQO5yQM
         pytFRuO12MGnEICMVERMaY77u56BaJPAFfv/HLns8ZM0ELOZHcJa2CSt6RQtFGVYLX
         qmxVV2+9z0Fp/om8qmoYk4Rc8YNM0IF9bg5n249BQ5goE9Dq9O4d7kyZ2+2teq9vwZ
         fYr65AxbVH7Wp3jBdLFVpkwK6s8UPGTSLoT9GjWIMx+LEeVXz2SUjc1h7QM5tRyWT/
         5AIBEfs9ljftixgqGKZfktlEknC4r/t/dhNPPXBIvG3MwMB02KEldAli+DfdrqxTz5
         zJ1Z/8t0PCrXg==
Date:   Thu, 30 Mar 2023 12:41:39 +0100
From:   Lee Jones <lee@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 04/14] dt-bindings: mfd: qcom,spmi-pmic: add compatible
 for pmm8654au
Message-ID: <20230330114139.GB434339@google.com>
References: <20230314183043.619997-1-brgl@bgdev.pl>
 <20230314183043.619997-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230314183043.619997-5-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> PMM8654au is the SPMI PMIC variant used on sa8775p-ride. Add a compatible
> for it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Lee Jones <lee@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
