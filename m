Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE03C73838C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFUMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjFUMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCF41721;
        Wed, 21 Jun 2023 05:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BCF46154D;
        Wed, 21 Jun 2023 12:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B528AC433C9;
        Wed, 21 Jun 2023 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687349722;
        bh=EG5iUSsfn8L9pIBnxfzaaIw74ssf8U24lAZVXDLQ1f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGbz0dzhwtKzjxDxcMTkB2BXGIeQ6H75D/OcGk3xUHPx1s6+/l2phthvC0I2IxC1R
         4gdyKHSA0fUBk4hTsr1+P8aQyFx2D/M2yHs2ZW63sMBN9iDvbZbLjqGdGXr6BBLVbV
         Z4vngki/CMLXxdXtgq919R9KSI2jXxS/F/58OBWtHb16RoUDS2sb8xYgJFQsZIjqnk
         5QaekNmYFaapRjXIFRbGBDfz+aNJaXKsUztisxqX3KYL/n7cZLrIqusuuqOWNQazCl
         ZSwvoBCS/+GtqspMu/iGbpEqn+I+1wajTd1zuGkpv+ur78Md/JhCXpxr4ByaJPvOZb
         biy87sjX8Zk6Q==
Date:   Wed, 21 Jun 2023 17:45:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH v2 0/3] phy: add the SerDes/SGMII driver for
 Qualcomm SoCs
Message-ID: <ZJLp1uPklyG+EWbK@matsya>
References: <20230619091336.194914-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619091336.194914-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-23, 11:13, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new PHY driver and its DT bindings (reviewed by DT maintainers).
> 
> This is a sub-series of [1] with only the patches targetting the PHY subsystem
> as they can go in independently.

Applied, thanks

-- 
~Vinod
