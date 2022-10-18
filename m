Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68BC6031F6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJRSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJRSGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:06:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48E25BC3E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5838FB820E7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 18:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8383C433C1;
        Tue, 18 Oct 2022 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666116377;
        bh=jOXaDczxiScuv/YfoJVuifpwsM6Z4ZxF6TxU4fTwIKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxyuqJfGXpcVbAJvBYB52FVEflSAZhghBRpojIwEuPIRjbeR3/p7opmiG9VQODmBW
         lMa2XpLOnpOfpC4e4ZFLSq5m/K31bKxssGHI1/ga59FWZDR9Qd7uER5ky/fWUkgMY4
         jBr5cNSKGCU/ygzW5omGbsh5DYbMGBZL2FNLV3fI=
Date:   Tue, 18 Oct 2022 20:06:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rts5208: Replace instances of udelay by
 usleep_range
Message-ID: <Y07rFoNKajyn/Y3j@kroah.com>
References: <Y07OcqPNjSihOByt@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
 <Y07dExeWY5lXgKLr@kroah.com>
 <Y07nLWIEKR1cCkIg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07nLWIEKR1cCkIg@kroah.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 07:49:33PM +0200, Greg KH wrote:
> On Tue, Oct 18, 2022 at 07:06:27PM +0200, Greg KH wrote:
> 
> <snip>
> 
> For some reason you sent this only to me, which is a bit rude to
> everyone else on the mailing list.  I'll be glad to respond if you
> resend it to everyone.

Oops, wrong response, I'll send this to the private response that was
sent to me, not this one :)
