Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCA646FE9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLHMlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:41:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00F58000;
        Thu,  8 Dec 2022 04:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED05AB823A1;
        Thu,  8 Dec 2022 12:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE46C433D6;
        Thu,  8 Dec 2022 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670503305;
        bh=dMXfN+dLPHMlr3tBQTVs8tArv5agk8+7shaxgICP7cM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLpkQSwKeuifV1wHpWPjzlu7yRwXMDOMdMa2PAtYMnxABzQn0MtAW0YDsAj0sMuwc
         C9F36/oEPh/05y9gVgTEifbhrgQwN/tSRZFGCBxGqJhw12b0Tp3Ryi2Bcl0QQV2NRs
         U+O0y53tuAO/f+UMdl2ED65aWjfq7fhMdv7h66nkXboHYAgl6dRd2VPomZWaUsGJVa
         0TPbm8MQLdOhlRNIztYHyZN23CbaYrnPyCp+BUdCA7IE9Dx2eSm9RahhIvEqJXphgS
         EyZvE4Bn1bEEV5Hl3m7L8x6fsuQ7NSiv3db9VXoCJYjtwIhs5ZhBvaz5x44uoSoSfG
         VgGHH7LmS3Ixw==
Date:   Thu, 8 Dec 2022 12:41:40 +0000
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: qcom_rpm: Use devm_of_platform_populate() to
 simplify code
Message-ID: <Y5HbhJCBFXWIIAid@google.com>
References: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
 <fd997dc92b9cee219e9c55e22959a94f4bbf570b.1668949256.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd997dc92b9cee219e9c55e22959a94f4bbf570b.1668949256.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022, Christophe JAILLET wrote:

> Use devm_of_platform_populate() instead of hand-writing it.
> This simplifies the code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This changes the order of the clean-ups if the .remove() function is called
> but it looks fine to me.
> ---
>  drivers/mfd/qcom_rpm.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
