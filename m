Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5C5F3A88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJDAXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJDAXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:23:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BD252B7;
        Mon,  3 Oct 2022 17:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FE42B817AE;
        Tue,  4 Oct 2022 00:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7349C433C1;
        Tue,  4 Oct 2022 00:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664843017;
        bh=Gs43qf3DDHsvtjiIMtx/5dYvrO0oAY2klB135mBGItA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQ7ZhMCPCJI1uVVzE+pygUvwzDIjmT6gRWeukBP3JhRfqQroRJXyYVWQT7lySPgaO
         bzosoR3EV7EvpBTiEXv2L/UWyfswjIioLSBYTNhF+uNQ2h/yPu8ospQ73CRvxHkMFo
         tNSNqVMsGxfkNs9+wpQLuXwrEFp84LsF8jPdFjCed4IST6e2h9u509TxKWWVhjMxZc
         UKSyiSVW8URn/Fiaqt2yN7gGtIyQZ7LJK2igDINjbjr/+YLuGS2rcqfgEstiVLaZrT
         vgkpmX7FtNav7Y76tBXRPF/jrYL0xx7dL6KkTAiGbFDhFTsrIqeSX7SrDyJYZnAIe8
         8UcVSsKtYVevA==
Date:   Mon, 3 Oct 2022 19:23:33 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 3/3] pinctrl: qcom: add sdm670 pinctrl
Message-ID: <20221004002333.g5yfjx6lol3pmc23@baldur>
References: <20221001210725.60967-1-mailingradian@gmail.com>
 <20221001210725.60967-4-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001210725.60967-4-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 05:07:25PM -0400, Richard Acayan wrote:
> The Snapdragon 670 has a Top-Level Mode Multiplexer (TLMM) for various
> features. Add a driver to support it.
> 
> Link: https://android.googlesource.com/kernel/msm/+/de5a12173c7fa6d65bedee9ad36af55b2dbfeb36%5E%21/#F6
> Link: https://android.googlesource.com/kernel/msm/+/04f083156d9b9f3bfcf204c1c6da88632fbb3863%5E%21/#F22
> Link: https://android.googlesource.com/kernel/msm/+/54837652e3400ecc63ccc78b2193faf4f349a32e%5E%21/#F0
> Link: https://android.googlesource.com/kernel/msm/+/f0409b07174ceca217f8b7fd255418feff06092d%5E%21/#F0
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>

Pending the question about overriding reserved_gpios, the rest of this
patch looks good.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
