Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249CD6E936C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjDTLyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjDTLym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1681DE69
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A78640AA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA63DC433EF;
        Thu, 20 Apr 2023 11:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681991680;
        bh=TVwOAXArVM41zt0la3jWQ3TCndHiXtlLav5yTK1LQuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jl5jfOiaNab8Z6bwSnJ51yf0bOwhPpMJv8dTl5PdsBMmW9w+Xt7r9yAE7RT8tPenX
         tziSTthpGc52P1jiQCZ2vEkN50JsWhtwmH467ls7Cj8SrKlKIhvTMY8R4rnNxt3wmN
         c/l+tVzyzwjp3eMiQK87lVOdJGkYXmX/+SPZKtiY=
Date:   Thu, 20 Apr 2023 13:54:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     f44f44e4-25c0-4489-96e9-8ca63fa294d7@kili.mountain
Cc:     error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: wlan-ng: replace rate macros
Message-ID: <ZEEn_UfhXEtTGf-8@kroah.com>
References: <ZD6OqBOp1ezQDgMu@kernelhacking.kernelhacking.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD6OqBOp1ezQDgMu@kernelhacking.kernelhacking.example.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

That has to be "Signed-off-by:"

