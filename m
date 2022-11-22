Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342CF634266
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiKVRXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKVRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:23:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C974CD8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:23:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41384617F7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32308C433C1;
        Tue, 22 Nov 2022 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669137795;
        bh=fLj4Wy9rUz6oahsBgORRZ5gFN+pclqEnQCAl9bLrDxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DCrgzdxUzDnscbgU5vX/ft+08Jk2H8HKMTalx+c/jd6iK3h2asAdL58lpg6YiRuO
         Gw1R4q8sQPFI7P26hZkr956pdBcvwhAyJbpcttLluPqTSVYv6aAkM0KHzce3Z8o35P
         vW6RO94+Y2TD6yuEM5lJEXHbeWY6kjGQzg4AHOTE=
Date:   Tue, 22 Nov 2022 18:23:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] slimbus: fixes for 6.1
Message-ID: <Y30FgFPQRkTHAONV@kroah.com>
References: <20221118065228.6773-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118065228.6773-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 06:52:26AM +0000, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here are two important fixes in slimbus one is to fix the presence rate table as per
> the MiPi spec and other is fix a build error.
> 
> If its not too late, can you take them for 6.1.

Already in 6.1-rc6, right?

thanks,

greg k-h
