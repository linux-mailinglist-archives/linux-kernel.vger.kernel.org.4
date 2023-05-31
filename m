Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAC717B75
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjEaJMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbjEaJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3480E4C;
        Wed, 31 May 2023 02:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38812636DE;
        Wed, 31 May 2023 09:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95457C433D2;
        Wed, 31 May 2023 09:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685524312;
        bh=dF+I5mL0Q8plAB+9FBUAtkmdRhndhxU6IkZbc2o3sws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQ2n96TvBTG3hCT+uNITL88gMPQbauET5d0JhFouMdJLm6DTPns3uWRrHmVzAj285
         qkaISQWcPp0oakWTUq0IDwOJbZ/gtMDLD3YlVZ3FFmmWPYzEVAyPlX8RL+/JB1Jqcs
         wMZhJ7EVr2cG/b5Zf+oXw0cfyhjd8WAHkQUYH4eg4AkT54OPDQDGbwt1Am7U4X3hpF
         Ln09x4i7u9txQKbpkgHQWBCIk8tscmrsMppq8hI67F7n4tqxykbeLJIkx6+h3OXot5
         gbVhV5/PGMAaOKND+jGAQBCBVlDBcVz1iXzBElxYx1aTctYQoiAeICJTsx+KSo+kaa
         dSZF3WVxo5y4g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q4Hs3-0000w0-Ip; Wed, 31 May 2023 11:11:56 +0200
Date:   Wed, 31 May 2023 11:11:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 0/2] Bluetooth: fix bdaddr quirks
Message-ID: <ZHcPW2Utn4rQWIu5@hovoldconsulting.com>
References: <20230424133542.14383-1-johan+linaro@kernel.org>
 <ZHYHRW-9BN4n4pPs@hovoldconsulting.com>
 <CABBYNZ+ae5h-KdAKwvCRNyDPB3W4nzyuEBzPdw72-8DLb9BAsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+ae5h-KdAKwvCRNyDPB3W4nzyuEBzPdw72-8DLb9BAsw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 01:06:01PM -0700, Luiz Augusto von Dentz wrote:
> On Tue, May 30, 2023 at 7:25 AM Johan Hovold <johan@kernel.org> wrote:
> > On Mon, Apr 24, 2023 at 03:35:40PM +0200, Johan Hovold wrote:

> > > These patches fixes a couple of issues with the two bdaddr quirks:

> > Any further comments to this series, or can this one be merged for 6.5
> > now?
> 
> Looks like this was removed from Patchwork since it has passed 30 days
> without updates, could you please resend it so CI can pick it up and
> test it again.

Both series resent:

	https://lore.kernel.org/lkml/20230531085759.2803-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20230531090424.3187-1-johan+linaro@kernel.org/

Getting both of these, or at least the first one, into 6.4 would of
course be even better.

Thanks.

Johan
