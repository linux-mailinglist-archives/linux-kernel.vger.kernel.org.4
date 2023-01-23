Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D736777B8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAWJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjAWJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:49:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3567812872;
        Mon, 23 Jan 2023 01:49:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A8460CF3;
        Mon, 23 Jan 2023 09:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9B7C433EF;
        Mon, 23 Jan 2023 09:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674467352;
        bh=Wppp6t1Ew72CCxHbUTMXjfWwq1RzWKtBIGTCgXrV6+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s8TGGfZY+muNsno5nkyAUL96stSqfnbAFFMWnCuYtR3s7rZPUWMBqarhjDIq4SZTp
         Brk6a7xJMl4X5DZv/Mx6cY2w16P38+rEvZhTgNtnDdIdIFRG2vyalPltvbSELGW/RC
         jXriJgnClu9JPiHLZAXsU102QZncLMZrhBumgFGw/41BIWlgk3dnyv1irEQQ57l2UP
         1F9f4uyVoz22wbPiISV744mOL7mEOOQhXj5gcTIVuDO5gFGCAK8x3VGg5yUAmoxAp6
         3sBtWwsjMnthm7wItlldlNa1dGz/EhExwE+AmnwCURPinjnLRu1Cbrc2Fwucvtd/y1
         8BVmit0xKpscA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJtRt-0000K7-Ac; Mon, 23 Jan 2023 10:49:09 +0100
Date:   Mon, 23 Jan 2023 10:49:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] phy: qcom-qmp-ufs: Add SM8550 support
Message-ID: <Y85YFfvMg1f/e6EC@hovoldconsulting.com>
References: <20230117142015.509675-1-abel.vesa@linaro.org>
 <20230117142015.509675-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117142015.509675-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:20:15PM +0200, Abel Vesa wrote:
> Add SM8550 specific register layout and table configs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
