Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6FF5F8D19
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiJISV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiJISVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAC11B9FE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C88260C4A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB67C433D6;
        Sun,  9 Oct 2022 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665339683;
        bh=mjDDMByZ3oY5zipTJxN+1vFMvZKh37rqliInd680G2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KPS5KSbw70/70tSmYw3+7n+kx40hm+6bn0cP7S3kblRYO6+3/D5bEwBhxpiPa2pZU
         5bjLG5rbw5wFvkMBq137iqTDkGlBUBs1wG7mpkp0Rfa9iEqG4L9bTaoIR9/4COO/DW
         0pljXQHR9ltZ+3URxGBLisZyRxoMk/4i0Xsotcog=
Date:   Sun, 9 Oct 2022 20:22:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] staging: rtl8192u: fix spelling typo in comment
Message-ID: <Y0MRTlpjuG3rJX9o@kroah.com>
References: <20221009085746.3149599-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009085746.3149599-1-13667453960@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 04:57:46PM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>

Again, why a 163.com address?

thanks,

greg k-h
