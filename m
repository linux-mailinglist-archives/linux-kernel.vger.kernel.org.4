Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF95F0556
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiI3GuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiI3GuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A8C58B6F;
        Thu, 29 Sep 2022 23:50:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B658362255;
        Fri, 30 Sep 2022 06:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C6DC433D6;
        Fri, 30 Sep 2022 06:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664520606;
        bh=npOlSinhtyjOuNPJQMTR5Tx4sGOymtqPxvSpKcyMJZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZVjJRXSlfnoV9tFBCNHXRpUwvHjnL8yKrJFhmAyE7Wm2ReOfmIrTHJlTK7DEIirr
         kwuDgwjj0bg4RX0HMY2VPooX8lTR+Coe2Uems58QaMqYDSJ54r1Oh0UNYvmXFfd9gc
         XweNdAjTU/cKMCbxt+Wfo8Xfful/em0fJCIuXRQ4=
Date:   Fri, 30 Sep 2022 08:50:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrice.chotard@foss.st.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Audu <jerome.audu@st.com>
Subject: Re: [PATCH] usb: dwc3: st: Rely on child's compatible instead of name
Message-ID: <YzaRm4Jtbr4F26Gt@kroah.com>
References: <20220930064406.510330-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930064406.510330-1-patrice.chotard@foss.st.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 08:44:06AM +0200, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> To ensure that child node is found, don't rely on child's node name
> which can take different value, but on child's compatible name.
> 
> Cc: Jerome Audu <jerome.audu@st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

What commit id does this fix?

Who reported the problem?

thanks,

greg k-h
