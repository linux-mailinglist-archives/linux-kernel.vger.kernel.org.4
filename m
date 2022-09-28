Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF56E5EDFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiI1PKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiI1PKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18ED5FB7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:10:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D43D261EC5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534E3C433C1;
        Wed, 28 Sep 2022 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664377818;
        bh=tVn4NiSft2/YNBCbDod/pGzgd2fEpresnSiIOMobb5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCQ6xX4KtDozh2tR2qc5iYfuKLKrS+T6p9xQcQNAfLppqxPyd86aHGxGdoeujy+4K
         yeizo6oSarzVpd2j8otVnqOWHIV8tnjGNC3Pii8uJKe+N/NLZxWg/ox/j1QRburCq+
         N+oTSfNoh196AQBJuW7iQjvWTIDJasn3r4YMRrhHiLxwIATPUfyHdHD41J/Ac7G/7J
         k5jt65Nw7387wNGqfLVnBd19GxlSMyC9haXj8rb0vISwHMQEYrWbIDmMkvQidIKU/w
         0Rg17G/6Yg+nZSu7ayIuTJPqj9EXcwzTmGtW5BQ5WyNE7F2dvxYiY8yCWkLkIc2dXW
         //l7zMJ/ZeD9w==
Date:   Wed, 28 Sep 2022 16:10:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, colin.foster@in-advantage.com
Subject: Re: [PATCH -next] mfd: ocelot-spi: Add missing MODULE_DEVICE_TABLE
Message-ID: <YzRj1gE5AZXzsFXW@google.com>
References: <20220922103703.1731266-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922103703.1731266-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022, Yang Yingliang wrote:

> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Fixes: f3e893626abe ("mfd: ocelot: Add support for the vsc7512 chip via spi")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mfd/ocelot-spi.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
