Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6DD68BC3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjBFMEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjBFMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:04:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C1012F1D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:04:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3B50B80E8F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C9DC4339B;
        Mon,  6 Feb 2023 12:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675685050;
        bh=0ElBG/tsKvSFjd4MWYG9jeVwoY79Aae2Dbf4TPBq+Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9qzNc6jtmtWwCoV4vCvqX6Ln7yWJUJIBGTnC5uazjfynlY/dFACFPjmFMW2z0bBw
         AnN+QnoAhCRQ8Mjn9Ul4iC0v8EJRiPR5yLwLJ0Ild62g3XGq5zMYiU6AhAR48n7CZS
         c+dAj7ZmKg7i7/1ROMO7G42ldLFQAqeXV9kPRP4s=
Date:   Mon, 6 Feb 2023 13:04:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>
Subject: Re: [RESEND PATCH 30/37] nvmem: core: fix
 nvmem_layout_get_match_data()
Message-ID: <Y+Dst2V9mfJbVrzD@kroah.com>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
 <20230206102759.669838-31-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230206102759.669838-31-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:27:52AM +0000, Srinivas Kandagatla wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This function was trying to match wrong OF node (parent device's)
> against an of_match_table. It was always returning NULL.
> 
> Make it match layout's OF node against layout's of_match_table.
> 
> Note: __maybe_unused is needed to avoid:
> warning: variable 'layout_np' set but not used [-Wunused-but-set-variable]
> (of_match_node() is no-op without CONFIG_OF).
> 
> Fixes: 61a093b4a0e0 ("nvmem: core: introduce NVMEM layouts")

Nit, how can you have a git commit id if you are sending me patches to
be applied to my tree?

That's never going to work, sorry.

greg k-h
