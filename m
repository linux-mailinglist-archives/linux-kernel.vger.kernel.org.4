Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107CE646FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLHMlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHMlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:41:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F6058000;
        Thu,  8 Dec 2022 04:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36B24B823A8;
        Thu,  8 Dec 2022 12:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AC0C433D6;
        Thu,  8 Dec 2022 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670503278;
        bh=guRXS28m/8dvPiWOssAoPyp+RdnQmwEIlChPgMBYOc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N6iHS4cFWQRisqelIhLwLxtxPCuj/mVxKb8MKEyqCDVoBjbAGtKh45pJtiAoNAa9a
         VlzXHdiRDrBHvIHO/M/HBt3naizFo/9p0YbUZ/QsG7gpr9S4DLo6yK+GgReDiwMnjR
         0nxsI6WEsGjArAba0kAipL3OBk+AI80So3CviVS63FM3sGd6CRNQlliFIonV6lTvQl
         uGRHWJCGkbxdgVSQV/V4ZMPw1hjMlZP9XRdcqgzas1cTrqODvb0EwaBrI+Z3LIS0PC
         TNpwwTLDMrTruEGdjBfIGEe7tD+cGpT/ybl1dqa2j4YLfxzDIjdDMOl/8fqvTWlPyd
         CJCZwi3WwpWUQ==
Date:   Thu, 8 Dec 2022 12:41:13 +0000
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: qcom_rpm: Fix an error handling path in
 qcom_rpm_probe()
Message-ID: <Y5Hbado70xVuy3iq@google.com>
References: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022, Christophe JAILLET wrote:

> If an error occurs after the clk_prepare_enable() call, a corresponding
> clk_disable_unprepare() should be called.
> 
> Simplify code and switch to devm_clk_get_enabled() to fix it.
> 
> Fixes: 3526403353c2 ("mfd: qcom_rpm: Handle message RAM clock")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This changes the order of the clean-ups if the .remove() function is called
> but it looks fine to me.
> ---
>  drivers/mfd/qcom_rpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
