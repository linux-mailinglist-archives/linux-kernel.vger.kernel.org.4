Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94C46FA301
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjEHJKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjEHJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D5319D7B;
        Mon,  8 May 2023 02:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F216F61CEA;
        Mon,  8 May 2023 09:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BD6C433EF;
        Mon,  8 May 2023 09:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683537000;
        bh=lvnrhXc1yCKmnMtOBPDRvHxMxBg3yKrzJG5/GZcaw4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go76Wsw+cdJr4iE0cqwDon553UuihbZG1WbD5TGzhUzJ81te1AdBqTIP3kZhSJ61f
         VAw7FX5wbx/Fe5nDbGj49yYNhAxRwnH3cfHU8cbT7f9xMF9p0U0KN5ctCCrVKvxpoq
         3P88hIA5UsJyU3U0lDIsnf0Q+EmnWsadOzRrTEMHcEgt7yIonmC5s5svJIotEw88S+
         JIASNU2vw2GvEbFEnaMYK7NXKCYBa8O5Vv24wx6B73q6FOGtxEdjouDJd3FkBM1ylI
         wchDihSGC3nnBmMnEsQxfKP684upSLK6TPyEaGFg/9MIHbtyTJ4eYpv9CXy1vegcyI
         rYH4UOZ685U8g==
Date:   Mon, 8 May 2023 14:39:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] phy: qcom-qmp: fix init-count imbalance
Message-ID: <ZFi8Y32DcmtfxYdF@matsya>
References: <20230502103810.12061-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502103810.12061-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-23, 12:38, Johan Hovold wrote:
> Two of the dedicated QMP PHY drivers suffer from a long-standing bug in
> the common-block initialisation code.

Applied, thanks

-- 
~Vinod
