Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8EC66A1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjAMS1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjAMS0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:26:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C57A7DE2E;
        Fri, 13 Jan 2023 10:21:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18359622CC;
        Fri, 13 Jan 2023 18:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A477DC433D2;
        Fri, 13 Jan 2023 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673634099;
        bh=tWt/37/DUHtIfoFRxoBH6pc5cjTsClvEGdHWSa/YyJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nN5SRtxlC7Gg1oDu7kOWHxD1mO73wz+1GrJhLh9qFV+8JrX7LVTVgdZudnADAsrFx
         A+xfQKPuA5qiHOMUW92idfUvEuMQG48l2NAGe1aD7/JX75qr4X0hRlJUJs/W8Uf0lF
         REuFSr+UReGbj7O4PIcctmBYnFK+jyHE6iX8qYWf4rr9fZKwiW4rX2yTVmnhpuYB5u
         if4Ly45tUzzE3lgf+bH4oKblt7qd5UsoN6Q4etMHHhPZgbfir0rOv0ooGXWFMO6/dV
         D36D3S7WLr41GkUlHGhu75sF15l8Te0Pdwfwj+hvXpTZx90iq+IMsrSGwgKTcp/MSy
         5jLYRiQ9v4ePA==
Date:   Fri, 13 Jan 2023 23:51:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lux Aliaga <they@mint.lgbt>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: phy: Add QMP UFS PHY compatible for
 SM6125
Message-ID: <Y8GhL0B1llPLLAhX@matsya>
References: <20230108195336.388349-1-they@mint.lgbt>
 <20230108195336.388349-3-they@mint.lgbt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108195336.388349-3-they@mint.lgbt>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-23, 16:53, Lux Aliaga wrote:
> Document the QMP UFS PHY compatible for SM6125.

Applied, thanks

-- 
~Vinod
