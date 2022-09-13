Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB28C5B6C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiIMLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIMLEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:04:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11921B873;
        Tue, 13 Sep 2022 04:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7A0FB80E45;
        Tue, 13 Sep 2022 11:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E4CC433C1;
        Tue, 13 Sep 2022 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663067079;
        bh=IQyyHTBiUn1e9HWsmP2j5v65pldmRulf8fHO7IJYFtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWEDd01PIjqB7OcnVpxXvXnS3gfd6kb7MgDe21h5dnGOMX15D4+cOnBOGf7N9BfRu
         AC8n3ykg6zoSdoRBJO1iJBwwWSYdjotWdkN4x2DXBeUFRgwLnrUsx+VD2o6ko3cB9o
         CKg0NVnNHlFXbMXu1viaqqepLF0/wEss8GNHx530=
Date:   Tue, 13 Sep 2022 13:05:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sunghwan jung <onenowy@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "usb: storage: Add quirk for Samsung Fit flash"
Message-ID: <YyBj3/qTZiGUlV/3@kroah.com>
References: <20220913105059.10248-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913105059.10248-1-onenowy@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 07:50:59PM +0900, sunghwan jung wrote:
> This reverts commit 86d92f5465958752481269348d474414dccb1552, which fix the timeout issue for "Samsung Fit Flash".
> 
> But the commit affects not only "Samsung Fit Flash" but also other usb storages that use the same controller and causes severe performance regression.

Please wrap your changelog text at 72 columns like your editor asked you
to when you made the commit.

Also, this is v2, please mark it as such and properly describe what
changed from v1 in the properly location as the documentation asks you
to.

Please fix up and send v3.

thanks,

greg k-h
