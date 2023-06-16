Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CC2732968
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbjFPIDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244486AbjFPIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:03:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0742965;
        Fri, 16 Jun 2023 01:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B203962FB8;
        Fri, 16 Jun 2023 08:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D62C433C9;
        Fri, 16 Jun 2023 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686902610;
        bh=Rv0CEfUf3lAtuXHRkW2o8+9meytXFbTIwmHLdrelU0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/fEVhN4gZBfXzqO9ZDNi/o2qJSY2AqkKYqK8ZQ5ohQAiC2gyb+xLQ43eFUT+AnmX
         DsJRD8RattictBGw+vtVQxoMYRAJRwe577xY3NGEfHn2UB2+9y/zGt26YmbKQ8sZYm
         tg+E1vKljWd80jZfalGJov9Ngb6GPVlAZyQv3DT0=
Date:   Fri, 16 Jun 2023 10:03:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "min15.li" <min15.li@samsung.com>
Cc:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, wsa@kernel.org, vkoul@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add capacity validation in bdev_add_partition()
Message-ID: <2023061635-numerous-amplifier-f78b@gregkh>
References: <CGME20230616030739epcas5p31e705be33bf080f988702d42534ad32f@epcas5p3.samsung.com>
 <20230616110557.12106-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616110557.12106-1-min15.li@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:05:57AM +0000, min15.li wrote:
> In the function bdev_add_partition(),there is no check that the start
> and end sectors exceed the size of the disk before calling add_partition.
> When we call the block's ioctl interface directly to add a partition,
> and the capacity of the disk is set to 0 by driver,the command will
> continue to execute.
> v1->v2: check for overflows of the start + length value and put
> the capacity check at the beginning of the function.
> 
> Signed-off-by: min15.li <min15.li@samsung.com>

I doubt you sign documents as "min15.li", right? :)

Please fix.

You also forgot a "changes" list below the --- line saying what changed
from the previous submission.

thanks,

greg k-h
