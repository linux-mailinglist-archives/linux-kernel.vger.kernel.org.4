Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7496266D655
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 07:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjAQG0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 01:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjAQGZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 01:25:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8887D166E5;
        Mon, 16 Jan 2023 22:25:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2127F61195;
        Tue, 17 Jan 2023 06:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C87C433EF;
        Tue, 17 Jan 2023 06:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673936709;
        bh=Thp28YsZz2lq8b1khFzysyZJYiSV8xClCrJdvqiye54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H9WUqhJOGNXpYZAqHJ9B139BMMOKckyQFLpL9y3ILJDvUebayuD4ETHRkK/Ntz4ue
         S1h9m3bUjsuN4UtKRYzppaRjH7HHEgga0vKD0IDbj5Ed/l/O+s8xkAuj2urzCgOyMa
         ugTQwF4sHluRifcyjpR6j0rZf2AVEEXcekNtNYs0zz+3+XxrudurM8VczeO5/pBNlI
         RjbO/h/7d818rBjGW+GZE43iWPmnO35f+9Mdv7xhWbSWrW55XqM+vPdC9/U9R5g1Bp
         8jCq/wbMx9+GHDslAUibM2CwoFjyfse3d0pRvC4vlSfNZCUPwRjCHLpP9R7niyGqFI
         QHcvtujvuAPMw==
Date:   Tue, 17 Jan 2023 11:55:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org
Subject: Re: [PATCH v6 00/12] ufs: qcom: Add HS-G4 support
Message-ID: <Y8Y/QX1KzWy2m3v5@matsya>
References: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114071009.88102-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-23, 12:39, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds HS-G4 support to the Qcom UFS driver and PHY driver.
> The newer Qcom platforms support configuring the UFS controller and PHY
> in dual gears (i.e., controller/PHY can be configured to run in two gear
> speeds). This is accomplished by adding two different PHY init sequences
> to the PHY driver and the UFS driver requesting the one that's required
> based on the platform configuration.
> 
> Initially the ufs-qcom driver will use the default gear G2 for enumerating
> the UFS device. Afer enumeration, the max gear supported by both the
> controller and device would be found out and that will be used thereafter.
> But for using the max gear after enumeration, the ufs-qcom driver requires
> the UFS device to be reinitialized. For this purpose, a separate quirk has
> been introduced in the UFS core along with a callback and those will be used
> by the ufs-qcom driver.

Applied, thanks

-- 
~Vinod
