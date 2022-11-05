Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C7761D881
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 08:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiKEHaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 03:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEHaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 03:30:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DC063F3;
        Sat,  5 Nov 2022 00:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F4A60010;
        Sat,  5 Nov 2022 07:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237B8C433D6;
        Sat,  5 Nov 2022 07:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667633399;
        bh=6IiMdbZsgzS37KjkCeoZ8h+9owxEr+PN946azyQzNAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fA9h1nEpq+vOJ4PWoPZQS0kvdjBAPapRvLleNwYqh8Jb0/DIRjtmRFuynEEAenrg+
         SGfkXINPccVxdA9Zgb7GcnCkxYeu1F1YapqjgzpBP5f5LVAFtyQ/S8cclkPCA+C9SA
         qlxibe2ACNfRNFCBd8CKb8ORVAdaNTnRaKIEtj47x86U+MjE2fhSjC/pCOw8y6FP5X
         Xu0xDlRBSi+pvtPhcGHKoMVoA3H4AA/uFyHvj068wo9JMxIjPkV9Wg896/OVPypsYD
         YU5PT/tHAHNkhW+zui3t5xUZdenFz+z2OdX7BUW/idtZ0PBkUW16ucQGxiIXzfOso7
         Z5sIUHXTdLUWg==
Date:   Sat, 5 Nov 2022 12:59:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/13] phy: qcom-qmp-usb: fix sc8280xp binding
Message-ID: <Y2YQ8sut+wM8y2Z7@matsya>
References: <20221028160435.26948-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028160435.26948-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-22, 18:04, Johan Hovold wrote:
> [ Resending with devicetree list on CC ]
> 
> This series fixes the USB PHY devicetree binding for SC8280XP and adds
> support for the new updated binding to the driver.
> 
> The first half of the series clean up the driver in preparation for
> supporting SC8280XP and its new binding that drops the legacy child node
> and the (incomplete) description of register subregions.

Applied, thanks

-- 
~Vinod
