Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A0C732704
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbjFPGFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjFPGFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74E02D5A;
        Thu, 15 Jun 2023 23:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF6260C67;
        Fri, 16 Jun 2023 06:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151A1C433C0;
        Fri, 16 Jun 2023 06:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686895509;
        bh=FzDDNPNYOwo13RD4KhYBHnL5WU5dlJvvuFXByHSyYnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHHXl8ijtGPhR5emf8yS4Au9GDHbhkHxznQiyGaj2L1KeQps3CWmEKxoH2qhf2ibH
         QBHXBi7n+0MNl5MiQW8i98WyNtXr/p1cC5nqoDusWOAE6c6SYF4DsZJ3y4Werw1MEG
         RjhSiP3gM1xIbJnqgh0Kg9Ev1Qsc4rLPQ2UsHfMM=
Date:   Fri, 16 Jun 2023 08:05:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        heikki.krogerus@linux.intel.com, sebastian.reichel@collabora.com,
        heiko@sntech.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        huangtao@rock-chips.com, william.wu@rock-chips.com,
        jianwei.zheng@rock-chips.com, yubing.zhang@rock-chips.com,
        wmc@rock-chips.com
Subject: Re: usb: typec: tcpm: add get max power support
Message-ID: <2023061639-emerald-endorse-2f64@gregkh>
References: <20230616022157.25877-1-frank.wang@rock-chips.com>
 <f6c9fc11-df51-5ff8-c744-3325c20643b0@roeck-us.net>
 <45886fef-b84a-5704-0a08-100a20296323@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45886fef-b84a-5704-0a08-100a20296323@rock-chips.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 11:13:08AM +0800, Frank Wang wrote:
> Hi Guenter,
> 
> On 2023/6/16 10:26, Guenter Roeck wrote:
> > On 6/15/23 19:21, Frank Wang wrote:
> > > Traverse fixed pdos to calculate the maximum power that the charger
> > > can provide, and it can be got by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
> > > property.
> > > 
> > 
> > Wasn't this already v3 before ? What happened to the version, and the
> > change log ?
> > Or is this a completely different/new patch ?
> > 
> 
> Yes, it is the v3 patch before which has been hold for a long time, Gregkh
> asked me to rebase it  and resubmit, so should I also add an "RESEND" tag in
> subject?

Yes, please do, otherwise we have no idea what is going on here.

Please resend v4 with all of the change information.

thanks,

greg k-h
