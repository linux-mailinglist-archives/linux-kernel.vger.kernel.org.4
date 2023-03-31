Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109D56D21CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjCaNyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjCaNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A940D8;
        Fri, 31 Mar 2023 06:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 175F962960;
        Fri, 31 Mar 2023 13:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89164C433EF;
        Fri, 31 Mar 2023 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680270877;
        bh=ShYnQF5sGPRHsnfF+6Il0ZMGhTHQ6CjbrVEJ8a5DiWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEd7lMx4zWzXFf7MKFXQMTXkO4hwvPwKXvO2KCsL/RuOFFneh+YeADbS93K1Xi9i/
         3xwPL/+iKOAsYUxzFJlrA1GufAWQr0oTRV3zS6XPeLODbBkpINv2e+mMbKr+nq5zEX
         kOQEpZl1y/DXh2OrNAbKfDd7RtEeteBfIv4B+mxkpA4H1d5HWvcZGzKzQbVBfgEJW5
         dm1PGTi3FX2/0Ae8r9amXHpY12B5wJuMJDOyS9+OvhVPbWNTx+hAMfNAZjtTIRvdK3
         3Bs4//h1VR+W+BMRWenWisR3SDUqV8+ac07/zdtJQ4Bs2RxzMA8UzjYecE7tT5SFqv
         PS9QjSq6gir9Q==
Date:   Fri, 31 Mar 2023 19:24:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add support for PCIe PHY in SDX65
Message-ID: <ZCbmGPfIup4YuEF0@matsya>
References: <1679035114-19879-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679035114-19879-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-03-23, 12:08, Rohit Agarwal wrote:
> Hi,
> 
> Changes in v3:
>  - Addressed minor comments from Krzysztof of removing redundant binding
>    usage in commit message.
> 
> Changes in v2:
>  - Addressing Dmitry's comments and adjusting according to new bindings.
>  - Rebased on top of 6.3-rc1.

Applied, thanks

-- 
~Vinod
