Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE96C6BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjCWPFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCWPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36D223C41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C59EB626D1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62D2C433EF;
        Thu, 23 Mar 2023 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679583861;
        bh=WAcjZojhhSuQUCzIIJ3hb3ljjDgbnopqWnjYc0qdEH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9X0mulMB60vHScvVYPKS7jOMrD2c64JL/ug6hCmrR5G4pQLoIPxFqws9brvl3TeO
         lnBaRFOKdYX3QtSUjkk6tuyR77IZlR/0/tkBltWnPrN0W+GVFe9SvK8FjuHeuVWL+6
         I69ikSm6TC6Cr3M/oxl4sHlKVrxFGju6k3GjTebU=
Date:   Thu, 23 Mar 2023 16:04:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] staging: most: fix line ending with '(' in video
Message-ID: <ZBxqcgj9U9tAnlIa@kroah.com>
References: <ZBxL/yqLU1dEQlta@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxL/yqLU1dEQlta@khadija-virtual-machine>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:54:23PM +0500, Khadija Kamran wrote:
> Splitting function header to multiple lines because of 80 characters per
> line limit, results in ending the function call line with '('.
> This leads to CHECK reported by checkpatch.pl
> 
> Move the function parameters right after the '(' in the function call
> line.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/most/video/video.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Why is this a RESEND?
