Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C86CF3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjC2UAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjC2UAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902866EAD;
        Wed, 29 Mar 2023 12:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CD6961DAD;
        Wed, 29 Mar 2023 19:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B33C433EF;
        Wed, 29 Mar 2023 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680119995;
        bh=dF3hRt65Q1BYXB5E3JiwIQldFAdauhIFIboOIzQnDog=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aalDHl5XSJ9tMw61nQ8xsYQQg0KrROv03tyYykzS7/oOxDlHreFro6YBbZMeI32Mi
         GJuq0VcD/Btxb3xiQ7by1d0GFQjxMCWl52SZefz8BCHRrpAVYjoE9xcAW2nht2MMgP
         E4So2MpU624tVJYJx+cGlCO51xvU/l5drxjWqh89KC/PSQ5NdLCz1qPYrxEGt4+etU
         ZBJQjd6WCUe+b5uw+4H8oOUWpGslnsLcu7BX5cAT4BQfpmG+fmQYfOIKhtmHgHuJAB
         61adAa+GZCVnLdNvDBrQEutQ46vINvO9UULxI0diw3Ufvz0mIoetmflgfDjNNFBSqa
         lLrCvqQkzrKFA==
Message-ID: <dedc866a1014f22e31324357e98e1b61.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202302081540136870117@zte.com.cn>
References: <202302081540136870117@zte.com.cn>
Subject: Re: [PATCH] clk: bm1880: use devm_platform_get_and_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     mani@kernel.org, ye.xingchen@zte.com.cn
Date:   Wed, 29 Mar 2023 12:59:53 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ye.xingchen@zte.com.cn (2023-02-07 23:40:13)
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>=20
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>=20
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---

Mani?
