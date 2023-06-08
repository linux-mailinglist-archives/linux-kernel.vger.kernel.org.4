Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1172869E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjFHRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjFHRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74842D42
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8429164FF3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64A3C433EF;
        Thu,  8 Jun 2023 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686246655;
        bh=11REmXWWjFODHTSLIcR4Gb+IgR7yipN/NC8KTCz0CXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvlCRcKuA1UINtHrsdXKqPOB0XVsDS7naaO6VQ2LLB9tLpPNeyCUpfbz7jMhISN7v
         uwW2N5mE0skNCZs1MVg1rGBcumu6xgwkRZAgtOFG6ed9Z+TOQe3T6ouF6gIAd+rTWG
         vJT008gKBJ4S+7uADT3vuhlPBamiJ6TmVKD8qLWo9LK9LFbFZ2bFoyyc5zQ8sh732N
         Q5oC9J1JBBULBPfHh6DTn79p+jflp07Zw/ZmshltT4v4s3YtEGpyrNBqHf6lVfWGwP
         S1QzPKoOZmYhkLDOyUYaEB7hMahqjCMx0it3zjPvoM9gqIQmbgwF9fWHy0MA48IZR8
         HvY5Y3/1lmhqA==
Date:   Thu, 8 Jun 2023 18:50:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     krzysztof.kozlowski@linaro.org, conor@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mfd: stpmic1: fixup main control register and
 bits naming
Message-ID: <20230608175051.GM3572061@google.com>
References: <20230602062426.3947116-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602062426.3947116-1-sean@geanix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023, Sean Nyekjaer wrote:

> Fixup main control register and bits naming so the match the naming from
> the datasheet.
> 
> https://www.st.com/resource/en/datasheet/stpmic1.pdf
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Lee Jones <lee@kernel.org>
> ---
> Changes since v1:
>  - None
> 
> Changes since v2:
>  - None
> 
>  drivers/mfd/stpmic1.c       |  4 ++--
>  include/linux/mfd/stpmic1.h | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
