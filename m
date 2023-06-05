Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB91723276
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjFEVpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjFEVpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EFE102;
        Mon,  5 Jun 2023 14:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D95D62B28;
        Mon,  5 Jun 2023 21:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E862CC433D2;
        Mon,  5 Jun 2023 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686001503;
        bh=KFXw32cPDNNnIK/7hhnlFMPPfkd6tPmyWt92f/5b6nw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a5WzR13FOYJnMfM3sD0pbqRI4pyhT3HY8Il/3DpCZQlVNBA+S+UIlkugSqBwpXlFl
         tIW9LNavviuhHUvvNB0zFgH5834y5p5x6xtxKIJ3qQ2Em7ylN+D+3at0+fzWXZl/6X
         hg58A+Wp5Uw7HX+YwKtvuOsvyN5OJeiyjT013b8H15PkGJe4YUSJw8P8xv6vczRIZD
         CPCZq2OVP02sm/w1dKH4KvnlYEdgtj7HdsUFOHC1rXdf5IK+auj8EuoN1hFWF6A7ZX
         8owkXy4AkQ4xgwg/QKFEZ0eqTSk/4R4fdD0iwiL1p/aSP0hKSnf/iuTdWThMmA14jd
         IVQKxx5AdJA0w==
Date:   Mon, 5 Jun 2023 14:45:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: net: phy: realtek: Support external PHY clock
Message-ID: <20230605144501.31f49920@kernel.org>
In-Reply-To: <20230605151953.48539-1-detlev.casanova@collabora.com>
References: <20230605151953.48539-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Jun 2023 11:19:50 -0400 Detlev Casanova wrote:
> Some PHYs can use an external clock that must be enabled before
> communicating with them.

Please add a [PATCH v4 0/0] prefix to the subject of the cover letter
(or use --cover-letter with git format-patch to generate the template).
Otherwise patchwork doesn't realize this is a cover letter.
