Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CED5EF2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiI2Jt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiI2Jtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:49:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE8A14C05C;
        Thu, 29 Sep 2022 02:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1C7EB82344;
        Thu, 29 Sep 2022 09:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890AEC433D6;
        Thu, 29 Sep 2022 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664444858;
        bh=P7XwxAbuvX3oO+CxJnr9NJMBu0qgVOHSB1KFjXqva+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pklEAkikzIO+JhMkCuI5KpDJOk+bNZTYWk543Cl7H89ppZ/tPg+34I7jsNY71D/5W
         rSeSo2gaxeFr2gi4NfAXXDnfgjumGqmjutqmoczTHQX4piTZqqFTpR4GzepUtTlcv7
         qumGk3WCv15hJpmM0g1iZ+0DD+dbmmphMXiFXBNpAlT+iEXCbD2ogmFc4zls5IWY+C
         6xTaYLpABSxd7Owg4QncUqzc94Xl7SipqcGYpIXOje2FgUPynYVUgLHJyEQzK0Ebrw
         lMTsGV/t4MD5+ld3e9jSGaQl6Oqa70uHGfbS2vpEBXwJbHsmX0pgvG2v8BIO/N8k6n
         tgZhUWoGSc9Eg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odq8v-0006Hd-1J; Thu, 29 Sep 2022 11:47:45 +0200
Date:   Thu, 29 Sep 2022 11:47:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] phy: qcom-qmp: more fixes and cleanups
Message-ID: <YzVpwR3jhtKOy8Ap@hovoldconsulting.com>
References: <20220929092916.23068-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929092916.23068-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:29:05AM +0200, Johan Hovold wrote:
> Here's the next batch of QMP driver fixes and cleanups.

> Johan Hovold (11):
>   phy: qcom-qmp: fix obsolete lane comments
>   phy: qcom-qmp-combo: drop unused UFS reset
>   phy: qcom-qmp-pcie: drop unused common-block registers
>   phy: qcom-qmp-pcie: clean up power-down handling
>   phy: qcom-qmp-pcie: move power-down update

>   phy: qcom-qmp-pcie-msm8996: clean up power-down handling
>   phy: qcom-qmp-combo: clean up power-down handling
>   phy: qcom-qmp-ufs: clean up power-down handling
>   phy: qcom-qmp-usb: clean up power-down handling
>   phy: qcom-qmp-pcie: clean up clock lists

I forgot to add Dmitry's reviewed-by tag to patches 6 through 10 when
resending. Sorry about that.

>   phy: qcom-qmp-pcie: drop bogus register update
> 
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 30 +++---------
>  .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 12 ++---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 49 +++++--------------
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 24 ++++-----
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 22 +++------
>  5 files changed, 38 insertions(+), 99 deletions(-)

Johan
