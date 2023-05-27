Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093A67134D2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjE0Mxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE0Mxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A35EC;
        Sat, 27 May 2023 05:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9224F60E17;
        Sat, 27 May 2023 12:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5449C433EF;
        Sat, 27 May 2023 12:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685192026;
        bh=N/EnLfHwO3WlFpOOLqPLdk8rGLmqTF0iXJQdX85aQDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPERW7uVGfSugxVvbAD51G8RwQVmSS0zFfNh83Y/o4ZRTpYrpblA0HR8tt7YuFBsR
         HgmgBTNVJ3DVJL01gqmUda6y/9L92at0Ucs3xalIH6LctJ3QEYAZrmnZYhf1VxKMjN
         ffxWm4uR2nosOZlkz6dDlzpQplxZiY9B+TGwjzwwnTaaOC026+Ja4fXexSJJ5RPrMp
         Xj4fVggCH139CFfVZGujLPjKzivZ1swX6iKB729AO12ZHYXHoP0Ito+BmmGdv0kxvj
         XNn5oOKg42zZG4NB4BzmSqHpV/VBueqWQxYE57EfElvdFgViiXei29Y9rplpKBRCsY
         ECPWzg6nXnl6w==
Date:   Sat, 27 May 2023 20:53:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mm-venice-gw700x: remove invalid
 props from fan-controller
Message-ID: <20230527125333.GU528183@dragon>
References: <20230522193219.1477158-1-tharvey@gateworks.com>
 <20230522193219.1477158-2-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522193219.1477158-2-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 12:32:17PM -0700, Tim Harvey wrote:
> Remove the invalid #address-cells and #size-cells nodes from
> the fan-controller.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied 2/4, 3/4 and 4/4, thanks!
