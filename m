Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4425EFA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiI2Qa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiI2QaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AAC8321C;
        Thu, 29 Sep 2022 09:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E548761ACC;
        Thu, 29 Sep 2022 16:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B120C433D6;
        Thu, 29 Sep 2022 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664468991;
        bh=wD4h7Ye1enR6jvQBnb+w+E3Do4eyYBH0ttJ/UlmdQ+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQ7mp/So08kaHU+pHJnXeuG+TSPO7NRryzNNjBxVAtrYp7DuC4s8n5Z51m1ipXDxy
         h0IV2c7la5On/yVqF9gy7OYiXVlfvwnSs9Ep54Iz9dZhJz5ewL1shu1KwKiripdDkp
         DIhY4iri6ohlqZ9sp0gs9vbDQuOIzJ2fJxUVuXDPdMQZZDRqUTauwhbd1jBTaLmIO1
         gk9vbjuwDAA+5r6Ez4McgiSwFgH2qTNzdsqJLcx3hLPKN/2F5qKUOuQDFSysANBv94
         MP0LV248vkqICAxY1pFUbKJeKtHyuMPBqChpEo9DN+tGt3LDHOepR3aofm3S4IgtUu
         px3TAKN/DbNpA==
Date:   Thu, 29 Sep 2022 11:29:48 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Alex Elder <elder@ieee.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
Subject: Re: [PATCH V14 3/7] MAINTAINERS: Add the entry for DCC(Data Capture
 and Compare) driver support
Message-ID: <20220929162948.pcn65m7tj2uusssv@builder.lan>
References: <cover.1664383851.git.quic_schowdhu@quicinc.com>
 <5e4e1f6a8c617b33afb7016d4bef4e2f0cd7ef4a.1664383851.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e4e1f6a8c617b33afb7016d4bef4e2f0cd7ef4a.1664383851.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 10:41:13PM +0530, Souradeep Chowdhury wrote:
> Added the entries for all the files added as a part of driver support for
> in yaml format.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cddc0ae..0fa438b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5720,6 +5720,14 @@ F:	include/linux/tfrc.h
>  F:	include/uapi/linux/dccp.h
>  F:	net/dccp/
>  
> +DCC QTI DRIVER
> +M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/ABI/testing/debugfs-driver-dcc
> +F:	Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
> +F:	drivers/soc/qcom/dcc.c
> +
>  DECnet NETWORK LAYER
>  L:	linux-decnet-user@lists.sourceforge.net
>  S:	Orphan
> -- 
> 2.7.4
> 
