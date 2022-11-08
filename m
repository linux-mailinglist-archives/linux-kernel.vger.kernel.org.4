Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CADC621827
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiKHPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiKHPYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:24:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F8758008
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:24:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7106162D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF55FC433D6;
        Tue,  8 Nov 2022 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667921076;
        bh=7Kkj3s9i5Z3CtrQ+nXP5RA1Np+Wvq8MyJU9cemugTEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fD2YSI7O2qwUJGbHPHHSMQHTt5Vpu0qapuUYN/LKnPtQyJL9ECij74X6Os9eTiR1q
         UXr6EfMwQBZCCLQrDEA8sZ0aWynlowrGffGSdsukC/bSDrckBan6kxYQpBNeKmSOTH
         ERW+IamIdPYnITLIEnaMq6kopR8poUXpys/A6n9g=
Date:   Tue, 8 Nov 2022 16:24:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jacob Bai <jacob.bai.au@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] staging: rtl8192e: replace macro defines with
 ARRAY_SIZE
Message-ID: <Y2p0sAPrglrmIAGb@kroah.com>
References: <cover.1667723306.git.jacob.bai.au@gmail.com>
 <13fddf4affd15a58c191be717ddee75772849f4e.1667723306.git.jacob.bai.au@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fddf4affd15a58c191be717ddee75772849f4e.1667723306.git.jacob.bai.au@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 07:31:18PM +1100, Jacob Bai wrote:
> use ARRAY_SIZE() to replace  macro defines

Odd extra " " character here.

Please write better changelog text, this is not very descriptive at all.

thanks,

greg k-h
