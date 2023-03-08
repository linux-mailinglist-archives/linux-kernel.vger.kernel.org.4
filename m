Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1C66B0E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjCHQIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjCHQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:07:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CFDB4821
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:07:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91F67B81D19
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA810C4339B;
        Wed,  8 Mar 2023 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678291337;
        bh=fhveztIW2Scf9hHcIk/TT/UvSVnPAoZ6RauSy71m6fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vjDb7jsGDlF1i/Qn1FJ49JfIoWh6LIW5eiGSa7YmLLjkl0zhGorheuT3kpazsBlJb
         07FVqLFOJkLWk6MfgR5BZrFo0NIu/qr+glkfck84RUI7RIqdKcOZVYPus1QyRVO5rr
         tYlrpp3oRACc1FMzd9CkQdQVIAY6qvoC/Vu3WPlY=
Date:   Wed, 8 Mar 2023 17:02:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shibo Li <zzutcyha@163.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: Fix some alignment matching open
 parenthesis issue
Message-ID: <ZAixhhkuQVeCIqJ2@kroah.com>
References: <20230226122820.194074-1-zzutcyha@163.com>
 <20230302050502.52356-1-zzutcyha@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302050502.52356-1-zzutcyha@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 05:05:02AM +0000, Shibo Li wrote:
> This patch fixes some alignment matching open parenthesis issue.
> 
> Signed-off-by: Shibo Li <zzutcyha@163.com>
> ---
> Changes since v2:
>  - Undo and fix some bracket misalignment issues.
> 
> Changes since v1:
>  - Fix some irregular indentation issues.
> ---
>  drivers/staging/rtl8712/rtl871x_mlme.c | 150 +++++++++++++------------
>  1 file changed, 76 insertions(+), 74 deletions(-)

Does not apply to my tree :(
