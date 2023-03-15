Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78116BBA99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCORLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCORLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:11:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBED8090B;
        Wed, 15 Mar 2023 10:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F415B81DD4;
        Wed, 15 Mar 2023 17:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EE2C433D2;
        Wed, 15 Mar 2023 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678900288;
        bh=If13N7i8i1Xa26DsNzNudcLPrKbKs3XYk41neN9vAoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQMk1kWtLqA5u84i0f25GcsMQn8JM7ekPBvqGLNKLiOBztSd1V+dtx3RaeS45btpX
         iJtCqHgNKyYZF64fQuJPh5HS2J7EIfXZCrUS6qQFFA/gPoP60uQ5pYNJz4fJ68KRxH
         UXmncpYcyZgazZO2bRkMgrMrctz38XwghUd41TxBwUCwc37MH1jP94FefIWASxF9OS
         ocqE6XhI/SKzvyunoSVwc/lsY6HXXZyimUogzdlFB/Dt6vJu2UQ2euSeWHp7MhoZBS
         qfGiSy4bQDwLKRmPXk+vhrhT3AyDjdJrKMbN1DmaFT9hH6xoOxoeewPuVWuzOHyWZM
         jPUAlfWpnKtQA==
Date:   Wed, 15 Mar 2023 17:11:22 +0000
From:   Lee Jones <lee@kernel.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_c_skakit@quicinc.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        marijn.suijten@somainline.org, luca@z3ntu.xyz,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH RESEND] leds: qcom-lpg: Release node reference before
 returning
Message-ID: <20230315171122.GF9667@google.com>
References: <ZAI/6w7k7k0ep1x/@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZAI/6w7k7k0ep1x/@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Mar 2023, Deepak R Varma wrote:

> The iterator for_each_available_child_of_node() increments the refcount
> of the child node it is processing. Release such a reference when the
> loop needs to breaks due to en error during its execution.
> Issue identified using for_each_child.cocci Coccinelle semantic patch.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Please note:
>    - The proposed change is compile tested only. I do not have the
>      necessary hardware to perform additional testing. Please suggest if there
>      is an alternate means available to further test this change.
>    - Included authors/experts for this driver for guidance as suggested by
>      Lee Jones <lee@kernel.org> and resending the patch.
>
>
>  drivers/leds/rgb/leds-qcom-lpg.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
