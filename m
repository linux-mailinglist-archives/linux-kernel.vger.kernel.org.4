Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956F26FA6C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjEHKYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjEHKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF9E26461;
        Mon,  8 May 2023 03:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 819C4618C4;
        Mon,  8 May 2023 10:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5E7C433D2;
        Mon,  8 May 2023 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683541382;
        bh=c/YHsoXXuZrBTOn2FSuZcrPJg8AnO65IRgva4Rff1io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1I/n/yTGDg15cLb0MWGhSrnGEBH89PYENy8c6akSL2uCHwCkNTzmcJdh108j/AZb
         HWDjoPj87flsD6BEEntDeVzbFtsdKxrBwHpqp5PW9ELH4jn71wi9LK37T/ZgbJNeWT
         5y+9fL/t+LivW/L65vr0yI7DlzRlJ8udRIaa265hBkDtJRzqWDsbQ9soplen+hxj7Z
         yW5d/ekRfP5eqoOMST8RG9hVuvWZ4FezCLZZ2gFJMKhlC684Ahx4r257CbJh+w31AS
         3oUqBe08cAaWqoowSF+MKB9C25Jvgt1Nnikps+HQxhfCOpnor5MEejv7pHgGJPlBaU
         TvZdkegCdeodw==
Date:   Mon, 8 May 2023 15:52:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: phy: qmp-ufs: tweak clock and
 clock-names for sa8775p
Message-ID: <ZFjNgoWFciBdd9U5@matsya>
References: <20230419120914.173715-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419120914.173715-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-23, 14:09, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> maxItems is already globally set to 3. To make the binding easier to read
> and remove redundancy, set minItems to 3 for sa8775p as this platform
> requires exactly three clocks.

Applied, thanks

-- 
~Vinod
