Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAED706C76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjEQPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1666FCC;
        Wed, 17 May 2023 08:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FE4760FBD;
        Wed, 17 May 2023 15:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C00C433D2;
        Wed, 17 May 2023 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684336682;
        bh=cWcgy+WXrTxYPzrTHi3+xEB3IMvot8diduwzGD+rAso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Muyi2vS/UZSeib2ZIaK3A6mhcUzwDoUbr430Vj/VgbMDPlC3VtXusO6AFKADj13Ae
         nce3X9fosN7mCH8Z/Mriu/yKFbDEStAJwvQB3LBsOPpsGKxvjSYIkaY4sH/jxqSgtN
         U5HhKEyL7kthKjPRqQLsZ3BFOhUZGlYPIlfZx68cYZREnygb62F7W8iW7xZwb1Zs14
         Zw1iM4OHEI3nwFXOkkvZooXjGLhc891+Vqy74qFNcjTbQ73ePph2CyLj88aQF+RN/d
         t3RztcR+0HOoiOiZJa9eklzDMxFp9oxvxPuV6rxkY+H/qW4voVA3zGts/6Whkp8aLi
         1OibkELrhSwiA==
Date:   Wed, 17 May 2023 08:18:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     yunchuan <yunchuan@nfschina.com>
Cc:     rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: bna: bnad: Remove unnecessary (void*)
 conversions
Message-ID: <20230517081801.508322e7@kernel.org>
In-Reply-To: <bea72de9-5f97-16a9-6703-05789ed53c1d@nfschina.com>
References: <20230516201739.21c37850@kernel.org>
        <bea72de9-5f97-16a9-6703-05789ed53c1d@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 13:14:11 +0800 yunchuan wrote:
> =E5=9C=A8 2023/5/17 11:17, Jakub Kicinski =E5=86=99=E9=81=93:
> > On Wed, 17 May 2023 10:27:05 +0800 wuych wrote: =20
> >> Pointer variables of void * type do not require type cast. =20
> > What tool are you using to find these.
> > How many of such patches will it take to clean up the entire tree? =20
>=20
> I use the scripts I found on the=C2=A0 kernel Newbies to find these.
>=20
> website: https://kernelnewbies.org/KernelJanitors/Todo/VoidPointerConvs

How many of such patches will it take to clean up all of net/ and drivers/n=
et ?=20
