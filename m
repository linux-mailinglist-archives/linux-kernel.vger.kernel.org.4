Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4376BC9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCPItW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCPItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:49:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B519F19
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23FD4B820AD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EF1C433EF;
        Thu, 16 Mar 2023 08:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678956553;
        bh=6wnFsnrhXRbuycrd5u/IQx7nZFVKBubAgA80mnUg5hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLESccR4tZsYZtYqsuDpzKQlijij+5F9/UItPvHU/pnVaXtXkVXEd0HAMZFdwjolX
         hXXhFk/5Wk3vq0oTWSQXI3//AIwkvFDaa4cVbX95dKMSOA4YgtBjZlcwfLTni+6rD5
         Ujhgg1ypjCDspeWTvGTmOTS+E2ItySS+RcoTrnUg=
Date:   Thu, 16 Mar 2023 09:49:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
Cc:     outreachy@lists.linux.dev, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, zoo868e@gmail.com, jerrykang026@gmail.com,
        cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v4 1/2] staging: vme_user: add space around operators
Message-ID: <ZBLYB1+4GI1ge6Q8@kroah.com>
References: <57006c151d4d95550b987143a6650f8b3594ddea.1678899549.git.eng.mennamahmoud.mm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57006c151d4d95550b987143a6650f8b3594ddea.1678899549.git.eng.mennamahmoud.mm@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 07:00:06PM +0200, Menna Mahmoud wrote:
> Add a space before and after the operator, for readability.
> 
> Reported by checkpatch script:
> 
> " CHECK: spaces preferred around that '+', '<<' and '>>' ".
> 
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>

This patch, and patch 2/2, do not apply to my staging-next branch at
all.  Are you sure you generated it properly?

Please rebase it and try it again.

thanks,

greg k-h
