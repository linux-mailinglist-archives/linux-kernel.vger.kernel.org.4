Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03FF6E936F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjDTLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDTLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:55:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BEA26B3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA97163C11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94E1C433EF;
        Thu, 20 Apr 2023 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681991706;
        bh=43j8qb1ztwNnMs51aRYQjPVBIAJAJiKtU4LCBkzhueM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlG6v86o+r5l9DVeWkbmZ5aByPVNz2ysZ6LPONbCqvsrQcaOj+i1Tza+FhpShbYcc
         b94R6WQfYU4cQ7+wVp9gNO3ybBsndvVwjh64MUkExN6GfclEStK8hSpti+cXamVDdn
         eB/LMU1Jb7f4xneHRjdOCSCXtEiuw1ZvRI708Jww=
Date:   Thu, 20 Apr 2023 13:55:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luke Koch <lu.ale.koch@gmail.com>
Cc:     error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: wlan-ng: replace rate macros
Message-ID: <ZEEoFxsTuAxAS7Ep@kroah.com>
References: <ZD6OqBOp1ezQDgMu@kernelhacking.kernelhacking.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD6OqBOp1ezQDgMu@kernelhacking.kernelhacking.example.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 02:35:52PM +0200, Luke Koch wrote:
> Change p80211msg_dot11req_scan_results rate members to struct arrays
> instead of individually numbered member structs.
> Replace macros to set rates with loops to avoid checkpatch warning
> and adhere to linux coding style.
> 
> Reported by checkpatch:
> 
> CHECK: Macro argument reuse 'N' - possible side-effects?
> 
> Signed off by: Luke Koch <lu.ale.koch@gmail.com>

Resend without the odd reply-to...

This has to be "Signed-off-by:"
