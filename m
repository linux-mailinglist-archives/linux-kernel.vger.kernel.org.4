Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94CE6D0C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjC3RNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjC3RNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:13:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B85F0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5488FB8299A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18153C433D2;
        Thu, 30 Mar 2023 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680196415;
        bh=wWSgR9AkZHCwKY4Gi/gf7WqROztpZ2hEKHfJXx6b3u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1ecYRM69Itk/EfYQffdZypCZbzSQEZ+rC6oOQdjFq6/esbz4pEOTkugAMIycwKPw
         78OSDz7/q81PcC+TGoVl3qlUEySTYdam+4dYhVrKgoV4c5b0axjSE+Wa7Y1UgUl0i2
         6p2W+hF58mawYX/Q+hf0CfezP31VnczduCqA1u/bKgz//qkiqPTUnbJXJpshPrDxJO
         XEV5gxLd4mZBOap2mpAthe9JSavAZbmWYLXLl4YT5K2WJySIE8pQUVvNuSZ4i/B9Oa
         6skHv/ISPGA8V6UcfM3GiDm3wBz/R5rtyI6PEI+rsWhSuiy4Mds0heKPGr2afkIBev
         WxSjfbqEe+f2w==
Date:   Thu, 30 Mar 2023 18:13:30 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] mfd: intel-lpss: Add Intel Meteor Lake PCH-S LPSS PCI IDs
Message-ID: <20230330171330.GD548901@google.com>
References: <20230330132618.4108665-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330132618.4108665-1-jarkko.nikula@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023, Jarkko Nikula wrote:

> Add Intel Meteor Lake PCH-S also called as Meteor Point-S LPSS PCI IDs.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied, thanks

--
Lee Jones [李琼斯]
