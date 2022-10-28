Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF961121A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJ1NA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJ1NAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:00:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE998C89;
        Fri, 28 Oct 2022 06:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6053B82A02;
        Fri, 28 Oct 2022 13:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BA6C433C1;
        Fri, 28 Oct 2022 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666962044;
        bh=ePeMsjxXdLiOOfUUzNUw3FJDyNeX4zvzgeUxZV88UCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dn+wSexzopWxdmzMsf7LuHWXqxeG0MYEp/zawI/K8pl0nbOdoVRBD27i4Z2ls8RK6
         ysPuZIoeq2hcMYpPv8CEX+DMrMSmX1RVwEZjQu2IPyKm3Y6AzOdOMQjlgaafnH/av4
         6FhJGopEYEAVFMQwgDynqx9HSlHygir2z0U9hBcqEZbliOjiJFgLlztZ940qDHrbq8
         Cc802FXXlEr/QjZJ8+HOMkpJWbtOK71l2CZshSCOKTtQva7jhlf/AA65Otzxd1Rn5Q
         K++OYCTqh4iWsZ0kLsduLdcVR45mzJCaAiDtufMVkoVExwvxFdbJX+P0P33UqGQvKx
         s3tkrk0IMjeXA==
Date:   Fri, 28 Oct 2022 18:30:40 +0530
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
Subject: Re: [PATCH 00/10] phy: qcom-qmp-ufs: fix sc8280xp binding
Message-ID: <Y1vSeMpXqLsPBOLZ@matsya>
References: <20221024090041.19574-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024090041.19574-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-10-22, 11:00, Johan Hovold wrote:
> This series fixes the UFS PHY devicetree binding for SC8280XP and adds
> support for the new updated binding to the driver.
> 
> The first half of the series clean up the driver in preparation for
> supporting SC8280XP and its new binding that drops the legacy child node
> and the (incomplete) description of register subregions.

Applied, thanks

-- 
~Vinod
