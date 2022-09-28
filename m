Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383705ED57B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiI1G5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiI1G4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:56:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAE833A12;
        Tue, 27 Sep 2022 23:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC600B81F11;
        Wed, 28 Sep 2022 06:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDE1C433D6;
        Wed, 28 Sep 2022 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664348163;
        bh=fDL4KM3SLbjnOHLuzZCPeLEILZAa8CkGK5raCV6cwVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QY7S+3dxsyfaNKGc2yEwtrKOMR+9cyitVGs4/DAD//Or1MpCspCGVuah5qkZiDIDt
         Oe9yTcP53mXb8zvVIU9q+i8PLqSdd5M2B31TckLqRZ3UbwXDZUnUV8vMUw2YEnwarG
         j5/Z1zaO+ia6TRdoErxbEDrQF3wu8z2cy2pgJQAE=
Date:   Wed, 28 Sep 2022 08:56:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Chi <raychi@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, mchehab+huawei@kernel.org,
        Albert Wang <albertccwang@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Puma Hsu <pumahsu@google.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [Patch v3] usb: core: stop USB enumeration if too many retries
Message-ID: <YzPwAcprHugj++RX@kroah.com>
References: <20220908104019.3080989-1-raychi@google.com>
 <YyxP2/GLgyp5Cq66@kroah.com>
 <Yyx8BbxM97FeNwJ7@rowland.harvard.edu>
 <CAPBYUsA8gs82kk1b6Hee94P+hEut=RY9NQci4NTNTuOKOvVY+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPBYUsA8gs82kk1b6Hee94P+hEut=RY9NQci4NTNTuOKOvVY+g@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:37:55AM +0800, Ray Chi wrote:
> BTW, I found a new mail tree is created after the patch v4 is
> uploaded, but the patch is downloaded by mbox.

I do not understand what you mean by this.

> What do I do if I want to keep the original mail tree?

Why would you want to do that?

You can keep the threading if you use the correct option to
git-send-email but you really don't want to do that.

thanks,

greg k-h
