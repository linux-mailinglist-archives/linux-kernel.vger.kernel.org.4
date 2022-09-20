Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D570A5BDCC9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiITF7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiITF67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:58:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82ACCE;
        Mon, 19 Sep 2022 22:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EAE5B824B3;
        Tue, 20 Sep 2022 05:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9F7C433C1;
        Tue, 20 Sep 2022 05:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663653536;
        bh=l68gYqIECVHbcJW8Ghg4eOhz0XMjBPdI8w2LylAoy+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSmmjCBorN8pQSjiyCHVPLIggWZGW8w3F+d8IETIEvmuIrOViAkDTGMG/brTpCYGV
         g8Y7TbYs1rS34nP8SprVIsw+lecXlvdpuq38HblpPzAfu7kL7AcZb5roQ/FI72hmfO
         m/sl+vXrq8DIErYU5v1tLK61vf7M7zUSYh5Tilx8VkF7PSnSieiPHqlI2AovefcJok
         FoZOL66EAV4odwFF5u2hDf5TrncJM+XYsQOwDa+JT2vLElSAe+pzE5L3j4TGwLJgy6
         bJV73zHaOqM13TwNisYxGjiHzV7wCDX4V4nw/S7EVJawt3Cz1IE9uSAl6aPW8sejgV
         os95SqVb0ykNA==
Date:   Tue, 20 Sep 2022 11:28:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] phy: qcom-qmp: further clean ups
Message-ID: <YylWnIc6RWfzaxM/@matsya>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907110728.19092-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-09-22, 13:07, Johan Hovold wrote:
> This series clean up the QMP PHY drivers somewhat after the recent
> driver split.
> 
> Included are also some fixes for runtime PM not being disabled on driver
> unbind.

Applied, thanks

-- 
~Vinod
