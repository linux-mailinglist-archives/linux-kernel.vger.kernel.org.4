Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5F74C183
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGIIGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGIIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 04:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB4498;
        Sun,  9 Jul 2023 01:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D38B60B98;
        Sun,  9 Jul 2023 08:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02147C433C7;
        Sun,  9 Jul 2023 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688890009;
        bh=0TqUItfFmw9XF/dUbR/31TtViLA8sLj/7zXNb23mZIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXzP/SMt6ZkLRM7KekXOM/lUYUAP3pwnzXK0K6XdHQzzuQhRxR2nHjf/4du3NugaB
         xOUip8Ebco5pGaal+y74mvIuuMRLIPDv2G9wTBuEaMG2PxjW8+lqwH1bq2FLCES+6/
         1cjBeqx3ag9msu+V6KFAUVFyPMaAY36fQwZF1fWc=
Date:   Sun, 9 Jul 2023 10:06:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Frank Li <Frank.Li@nxp.com>, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, imx@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>,
        Jun Li <jun.li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
        Prashanth K <quic_prashk@quicinc.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] usb: cdns3: fix incorrect calculation of
 ep_buf_size when more than one config
Message-ID: <2023070924-uncolored-bootleg-77d6@gregkh>
References: <20230707230015.494999-2-Frank.Li@nxp.com>
 <f803653c-8967-b187-8339-fbec0cdeef25@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f803653c-8967-b187-8339-fbec0cdeef25@web.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 05:18:38PM +0200, Markus Elfring wrote:
> …
> > The fix involves checking the private flags EP_CLAIMED instead of relying
> > on the "claimed" flag.
> …
> 
> Please choose an imperative change suggestion.

Please do not review USB kernel patches, the comments you make are not
helpful for developers and will be ignored.

greg k-h
