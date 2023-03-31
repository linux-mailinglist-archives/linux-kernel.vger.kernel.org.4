Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64C6D21D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjCaN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjCaN4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:56:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603394209;
        Fri, 31 Mar 2023 06:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B260ECE2FAA;
        Fri, 31 Mar 2023 13:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CA4C433D2;
        Fri, 31 Mar 2023 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680270997;
        bh=tdyhWVZJWvQtIo0NCyXFaWOwidIkaHKhv9pdGq4fVQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9OoGaVubXM/eClKx+159bJoqo9SvH2DaXpy8MKbmY6AlIxKF4gdF82Ltqgco2AJR
         6mxmV/uBXx+gHt1oIDre2jrQnB/wfio/MekU8vNdR12saUj8db+1HXVPdNk/Ylfwj/
         li6UszggnmqSMDpYyQCu20kzwKdggP3N+MYdhPnT3pL8lBRBL6tSCJ95H487B2TiXK
         Az4W/saYwIG/OON/8G/5hFe6d46emtE1jHvRYhR3ct0ypdpjdQT9Gk+PxqYD3Iyslz
         cNaiHnfxV/pHFrAI4FOvBY61dt8fo+r4SXUEi+/ha6kMgJAqE+sv5zOxc08DitWcPC
         7DZ+PQEHEpBUg==
Date:   Fri, 31 Mar 2023 19:26:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Danila Tikhonov <danila@jiaxyga.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidwronek@gmail.com
Subject: Re: [PATCH v2 0/2] phy: qcom-qmp-ufs: Add support for SM7150
Message-ID: <ZCbmkRgCQCRHJHNQ@matsya>
References: <20230311231733.141806-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311231733.141806-1-danila@jiaxyga.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-23, 02:17, Danila Tikhonov wrote:
> This series adds UFS QMP support for Qualcomm SM7150 SoC.
> 
> Changes in v2:
> - Switch to new bindings (qcom,sc8280xp-qmp-ufs-phy.yaml)
> - Fix compilation error
> - Switch to 0xff instead of 0xFF
> - Add offsets
> - Set no_pcs_sw_reset to true
> - Add Dmitry Reviewed-by on patch 2
> - Link to v1: https://lore.kernel.org/all/20230309185049.170878-1-danila@jiaxyga.com/

Applied, thanks

-- 
~Vinod
