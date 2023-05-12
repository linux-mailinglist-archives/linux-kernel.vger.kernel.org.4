Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3962670036C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbjELJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbjELJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607D11602;
        Fri, 12 May 2023 02:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB55865422;
        Fri, 12 May 2023 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252CBC433AC;
        Fri, 12 May 2023 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683882627;
        bh=kUiWU6lZcVcCsvBfK0GM03OeHi8GVKMv4D/U9jZXzF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdaUzy4bLYXxpoevkE7hgsxmdHDrXE0lz6npy1lCRiSVzZ5p3FZfrKoBYb4gBSg5s
         qTtNH6dC6+GHQERSnAZ/ArJeX1y3Qw3vZI42MUKvTDkH7XZg6g6x7NrhaPKS0mUFZm
         WnPZWF7m9co+oPCq0fcTXKQcBHp1wJxAlp1bZhEhgSVVhJK/cWyfNXV+cSAP+xsDCI
         X5kKY/C2UEmDBInVTBgAv8WoElXXahZYa8KQ4K6cxXINglTj9jA78X7/3KufQtpvAD
         +UCtzT14GdXJ6Ohk1f4ReTbL4px1jVLnud/wCXPBTt7cmBj0nNf4B6GOy6Yx96PWKC
         uQ+MHkOMJfxpw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pxOne-0002j6-JQ; Fri, 12 May 2023 11:10:54 +0200
Date:   Fri, 12 May 2023 11:10:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] phy: qcom-qmp-combo: Extend phy_mutex to all
 phy_ops
Message-ID: <ZF4Cnl9n_bntLKf7@hovoldconsulting.com>
References: <20230510031930.1996020-1-quic_bjorande@quicinc.com>
 <20230510031930.1996020-4-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510031930.1996020-4-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:19:25PM -0700, Bjorn Andersson wrote:
> The phy core ensures mutual exclusion across the ops for a given phy,
> but the upcoming introduction of USB Type-C orientation switching might
> race with the DisplayPort phy operations. So extend the mutual exclusion
> to cover the remaining ops as well, to avoid concurrent reconfiguration
> of the hardware.
> 
> Reported-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
