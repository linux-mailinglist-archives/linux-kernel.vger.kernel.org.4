Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522366E9240
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjDTLRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjDTLQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE579005;
        Thu, 20 Apr 2023 04:13:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47EF86182A;
        Thu, 20 Apr 2023 11:12:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A0CC433D2;
        Thu, 20 Apr 2023 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681989121;
        bh=ki1I+acTvaNeCF2/hcBCCeIphdRJsZPU6VtB7/o13sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Y+ThRgyj9oNFM7XcwX4qEiVBh/iUA4zdKXG5Osv5F6q1GkDp75gGerbiwrQ6a1BG
         /ZrlyORFuPCuu4VZ4BfII7t8DjSYd5MbxNhWMEvaZRWuPkea5lW9y16Ls2TT8FCaLm
         wiktB+MYHQzrHVcVqMy081RW9IivXslxPx2UkB2w=
Date:   Thu, 20 Apr 2023 13:11:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] tty: n_gsm: add missing description to gsm_config
Message-ID: <ZEEd_oOvJYranmzN@kroah.com>
References: <20230420085017.7314-1-daniel.starke@siemens.com>
 <20230420085017.7314-3-daniel.starke@siemens.com>
 <2f2b20e4-34cd-a154-022f-c76c1b0e06c5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2b20e4-34cd-a154-022f-c76c1b0e06c5@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 11:08:32AM +0200, Jiri Slaby wrote:
> On 20. 04. 23, 10:50, D. Starke wrote:
> > From: Daniel Starke <daniel.starke@siemens.com>
> > 
> > Currently, all available structure fields in gsmmux.h except those
> > for gsm_config are commented.
> > 
> > Fix this by adding appropriate comments to the not commented fields.
> > Note that 'mru' and 'mtu' refer to the size without basic/advanced option
> > mode header and byte stuffing as defined in the standard in chapter 5.7.2.
> 
> Maybe you can start documenting them using kernel-doc? And convert the
> others and expose them all to Documentation and finally to:
> https://www.kernel.org/doc/html/latest/
> ?

I agree, this should be done in kerneldoc format please.

thanks,

greg k-h
