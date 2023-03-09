Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B242C6B272D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCIOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCIOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:41:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A8014221
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E00FDB81E60
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11663C433D2;
        Thu,  9 Mar 2023 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678372879;
        bh=kJ/cQDrVKU2O5jbGyyeonMsCJOSRTfaSPyolev3MCfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tL6J6of6FlJ9PEKCUzzD0Vkx6U+AlUbs4H/274ZyL2qDFfANCQhHG4uawA1Pli0my
         oXarNV1619OuFNScqFpe948ApecfCvKfVIwloMof+VspaoYM/7pcrIfb4ytVD+OZDH
         /yxrSa3Jaj1OgQW4iWyb4UAOpCW7UGqND9wuwnB0=
Date:   Thu, 9 Mar 2023 15:41:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Santosh Mahto <eisantosh95@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH] staging: android: ashmem.c: Declared file operation with
 const keyword
Message-ID: <ZAnwDL/GyCSC6xDa@kroah.com>
References: <20230305190057.17482-1-eisantosh95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305190057.17482-1-eisantosh95@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:30:57AM +0530, Santosh Mahto wrote:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-

What kernel did you make this against?  This is not in my tree anymore.

thanks,

greg k-h
