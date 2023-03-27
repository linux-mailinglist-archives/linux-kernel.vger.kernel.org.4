Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D726CAACB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjC0Qi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0Qi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:38:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D2012F;
        Mon, 27 Mar 2023 09:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2846137B;
        Mon, 27 Mar 2023 16:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378EDC433EF;
        Mon, 27 Mar 2023 16:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679935135;
        bh=F060jgHqbH6lD6Iawlogyvh44iIfQh/1fPwjaXIGgow=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HN7XlhW0sXNs2xzrjFb1y4F7wVw1z5qXURrxybRr2I488/gOB+m+l3QxFljvORllg
         LiIlERYPWXcLpdBsYFoPc5OM+B19W8bRIN29sEjLYBSGHtDkrXPanysMUpMZAXTtG2
         yGulzHdRm8ERG+MgVrLGtDmAloKxlt4+j6FT6uDHE/TC1DCDOwml8J64HG4b6EDJV7
         oiHkpqktWVbwFugpZpXOKK5qg9d8fbkvOyxW0lrKWhJ61mw7FZPwOmMvZvi6wVxD0X
         Tv6ptamlZ3Lzy2ptqUUvookWQvrAbisi1sL4ClGkiz/PoENH6DnpeQehkc3pKSS+H4
         wjze1Yqn5Z4pg==
Message-ID: <79723c14ff5dcd2388fa20bf8a5105b1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230319163217.226144-1-robh@kernel.org>
References: <20230319163217.226144-1-robh@kernel.org>
Subject: Re: [PATCH] clk: ti: Use of_address_to_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, Tero Kristo <kristo@kernel.org>
Date:   Mon, 27 Mar 2023 09:38:52 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2023-03-19 09:32:17)
> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next
