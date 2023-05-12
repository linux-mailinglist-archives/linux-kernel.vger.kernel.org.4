Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990D700418
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbjELJlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbjELJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E010A0A;
        Fri, 12 May 2023 02:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55A46544D;
        Fri, 12 May 2023 09:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA94C433D2;
        Fri, 12 May 2023 09:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683884450;
        bh=6wecwsHGtZttDNU8OcAsJfy+kOtssm2wkELv1zAQEzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQYwaoaGhfdBkDq+lQi/1to1xAetsfGYq/Pjx3lb5bH5QBe4l757dl/vBNyHoCsF9
         0Uk7KBUZkucN4FELY+TZIFCfgPLuP4HZZAAw8GXj5DjCoCY7XHil0o/uV9IrmkdrY5
         ryfI3fo7FVTLAWnonF83Yu/CLsWhmhsZkOGCXF23CUsZO1LO4rgSE61BuHWKPkWwgI
         1oUmSxtbR+5ILlU3sh539XUyFgAc81eXMBloLY5C8sVBEK6H7F/o6kUJKewvPoVnhs
         r9L/0ZXjGNS4ODEJunU2M23RnOM9szjDpGuV4BJW7DMpXAgFhFq5teNf2/gbvCJK5F
         D+bW91sIss7ZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pxPH3-0003D0-VH; Fri, 12 May 2023 11:41:18 +0200
Date:   Fri, 12 May 2023 11:41:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sc8280xp-crd: Add QMP to
 SuperSpeed graph
Message-ID: <ZF4JvTxOeW_A5Gnw@hovoldconsulting.com>
References: <20230510031930.1996020-1-quic_bjorande@quicinc.com>
 <20230510031930.1996020-8-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510031930.1996020-8-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:19:29PM -0700, Bjorn Andersson wrote:
> With support for the QMP combo phy to react to USB Type-C switch events,
> introduce it as the next hop for the SuperSpeed lanes of the two USB
> Type-C connectors, and connect the output of the DisplayPort controller
> to the QMP combo phy.
> 
> This allows the TCPM to perform orientation switching of both USB and
> DisplayPort signals.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Tested-by: Abel Vesa <abel.vesa@linaro.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on HDK8450
> Tested-by: Johan Hovold <johan+linaro@kernel.org>	# X13s
> ---
> 
> Changes since v1:
> - DP input is port@2

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
