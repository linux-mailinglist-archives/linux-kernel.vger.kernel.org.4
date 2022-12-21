Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237A652D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiLUGug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLUGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:50:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15671F2C4;
        Tue, 20 Dec 2022 22:50:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11D11CE069B;
        Wed, 21 Dec 2022 06:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFCAC433D2;
        Wed, 21 Dec 2022 06:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671605426;
        bh=U6+9Gwyf/ZjHK0IGXTirkwcpFdXD759YiV1SeECGbpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHBRsUVA0RUm2XZ/+qaZMRw/FdgCMa25yNGWjjhsN98VQWW2yDynL/OPDFsXqaefl
         G/qM5ThGS1DV66oejXhnqf/0pF5L2kcr9wE2zxPiyEsIvpL8AZhKVaA7QHbIQDdjQ3
         I0GC7cFpGvq57DI0/ZqeZG8PSMdbG6lndbMSiutg=
Date:   Wed, 21 Dec 2022 07:50:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rajmohan.mani@intel.com
Subject: Re: [PATCH] thunderbolt: Do not report errors if on-board retimers
 are found
Message-ID: <Y6Ksriv+VQQ9e4g/@kroah.com>
References: <20221220223006.3145568-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220223006.3145568-1-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:30:06PM -0800, Utkarsh Patel wrote:
> tb_retimer_scan() returns error even when on-board retimers are found.
> 
> Fixes: 1e56c88adecc ("thunderbolt: Runtime resume USB4 port when retimers are scanned")
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Please do not put a blank line between the "Fixes" tag and your
signed-off-by.

And is this also needed in stable kernels?  If so, add the proper tag
please.

thanks,

greg k-h
