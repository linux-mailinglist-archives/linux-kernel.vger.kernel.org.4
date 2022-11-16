Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211A862C6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiKPRzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238983AbiKPRzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:55:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F86174E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:55:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01A88B81DFC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE38C433D6;
        Wed, 16 Nov 2022 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621348;
        bh=ub48C02noIW/OV9PluuOB7JxdfcDg0P0C/dwu4Gz3CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYCpy98CiGkC7jR4POz+DjZA4cuOEjDlK4QLog7sXQybVQGxgoH0qx+lDMA4MUlhH
         89/ZZ1VJe8qcf4ax0zoci9eRBfzDOY2HpWwol+KGDgNwZFhCpLxhacmxMRap83T1E4
         O3pPJeCTeZA7PHYIimxNEf1Xoa4MY8qVMfHlz3GlbTbkWtVPGQSEQwCe59kvW+dl9Y
         W0DNEcpJZ5kXm+0a0zpbWOm/PU/aJJVJdKm4/8vF1KPXf4oGrO26z0WIr0Prm0tfpX
         81SkIjWbt1xb6IMOmjStdqAGHSVvnvl2j3rU+OcPtqYN91rzPAF76hJau23CycIBV1
         WmQSy0jnq4b4g==
Date:   Wed, 16 Nov 2022 17:55:42 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 08/18] mfd: max77843: Drop useless mask_invert flag on
 irqchip
Message-ID: <Y3UkHoMjbfe5xP+b@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-9-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112151835.39059-9-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022, Aidan MacDonald wrote:

> Setting mask_invert to false is pointless because that's the
> default. The flag is also deprecated, so drop it.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/max77843.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
