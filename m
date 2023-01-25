Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310867C13F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbjAYX7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbjAYX7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:59:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020362D29;
        Wed, 25 Jan 2023 15:59:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F4143B81C62;
        Wed, 25 Jan 2023 23:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DC7C433EF;
        Wed, 25 Jan 2023 23:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674691162;
        bh=5pMC0vMZRaHwULyqjHP7JoscMUuykFnMk1w/z8KZXn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmJtzh1qR4YwnAmsb3SkCup6sP2luMjt0OALXJiTmSCatVcR7Toys8GbntA31D+Am
         dpY/I9z8fOZd0iHIh2cFoNwao62Au5NZNlhv51kcwDPkM5cdHX6Zo734Z+cyAr2615
         GIYrcf0AYJXlAhIfWCElUD14bfHsV0dSOu+qPnfnd6uIRAHYomiSHJ+nBCOvaR4KxQ
         AcV/9SdeN+QolSWUIbeej2S7KNI5fWOzv4gAHH53C/XabalfMImr86/S7+XFSA7nUR
         g2heBcA+hMlOmlKMu0MJoXDYlBQL6hCyiA87WqdN7+iAHuweEHN/W0XSDj7bDKf5Yo
         oTRs9k3gYvhSQ==
Date:   Thu, 26 Jan 2023 07:59:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: sl28: get MAC addresses from VPD
Message-ID: <20230125235915.GH20713@T480>
References: <20230105152230.2814812-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105152230.2814812-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 04:22:30PM +0100, Michael Walle wrote:
> Now that it is finally possible to get the MAC addresses from the OTP
> memory, use it to set the addresses of the network devices.
> 
> There are 8 reserved MAC addresses in total per board. Distribute them
> as follows:
> 
> +----------+------+------+------+------+------+
> |          | var1 | var2 | var3 | var4 | kbox |
> +----------+------+------+------+------+------+
> | enetc #0 |   +0 |      |      |   +0 |   +0 |
> | enetc #1 |      |      |   +0 |   +1 |   +1 |
> | enetc #2 |      |   +2 |      |      |   +2 |
> | enetc #3 |      |   +3 |      |      |   +3 |
> | felix p0 |      |   +0 |      |      |   +4 |
> | felix p1 |      |   +1 |      |      |   +5 |
> | felix p2 |      |      |      |      |   +6 |
> | felix p3 |      |      |      |      |   +7 |
> | felix p4 |      |      |      |      |      |
> | felix p5 |      |      |      |      |      |
> +----------+------+------+------+------+------+
> 
> An empty cell means, the port is not available and thus doesn't need an
> ethernet address.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
