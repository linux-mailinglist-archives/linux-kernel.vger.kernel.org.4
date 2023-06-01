Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38771968D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjFAJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjFAJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A071D126;
        Thu,  1 Jun 2023 02:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34C97615AC;
        Thu,  1 Jun 2023 09:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E770C433D2;
        Thu,  1 Jun 2023 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685610842;
        bh=ysr19ykWuCDaS2xafT1YDerKvtGKlTxvqTLcdhIJ5PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDFLVauXWDELZgAWHW918L6ZBHpnxeRShvPkfGZLW/Pu3xelY/wvG/KwLdd2mIt5A
         OzwdqiRiJrGXXwDCJ5wWydEsUla0AQn53w4boHt2Ublkqv98I8miaxcW8M9HFys+Q2
         u8fVIFt+iyVeQYFaSy8ILsAwpkjeYGJFIMzrUi6A=
Date:   Thu, 1 Jun 2023 10:14:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Panait, Dragos Marian" <dragos.panait@windriver.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.1 1/1] bluetooth: Add cmd validity checks at the start
 of hci_sock_ioctl()
Message-ID: <2023060116-brush-entail-0d8c@gregkh>
References: <20230530122629.231821-1-dragos.panait@windriver.com>
 <20230530122629.231821-2-dragos.panait@windriver.com>
 <2023053043-duo-collide-fd9c@gregkh>
 <PH0PR11MB495229C3DABA728EE5C8A19EFA489@PH0PR11MB4952.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB495229C3DABA728EE5C8A19EFA489@PH0PR11MB4952.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:06:11AM +0000, Panait, Dragos Marian wrote:
> Done! (without the cover letter for newer kernels :))

All now queued up, thanks.

You could have just send a one sentance email saying "Please apply
commit XYZ to all stable kernels please" which would have been much
simpler and easier for you :)

thanks,

greg k-h
