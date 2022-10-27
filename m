Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD160EFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiJ0GSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiJ0GR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:17:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC0C5092;
        Wed, 26 Oct 2022 23:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CB9FB824D5;
        Thu, 27 Oct 2022 06:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ECCC433D6;
        Thu, 27 Oct 2022 06:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666851476;
        bh=sdur/CX4mb9Hgnw8S+kcHybFTYA0yaE4f7pqknSjcVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9PBINzAnwbvpX8DlpLpvOgYnewcNptI0M/Qpf6sL+TpOkKG6CSop9aMySD56Mmm+
         SSFTNKNal8U1uqv3cwcd+Uu+8+fa4hx11+wNRdc9faD2nfnF1g+MboB36gpxUaT8Ap
         gX/iwKnAEiDMgNfOx441sx7jsTeOAiRjl7BM5zfY=
Date:   Thu, 27 Oct 2022 08:18:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     mathias.nyman@intel.com, badhri@google.com, howardyen@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] add xhci hooks for USB offload
Message-ID: <Y1oiyeTF9uywMUZx@kroah.com>
References: <20221027004050.4192111-1-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027004050.4192111-1-albertccwang@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:40:47AM +0800, Albert Wang wrote:
> This patchset is to proviode the USB offload function which allows to
> offload some xHCI operations on co-processor.
> 
> *** BLURB HERE ***

No blurb?

And isn't this a v2 of this patchset?  What changed from the previous
submission?

thanks,

greg k-h
