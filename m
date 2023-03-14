Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D726B88CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCNC6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCNC62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7264A5D3;
        Mon, 13 Mar 2023 19:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2D36615B7;
        Tue, 14 Mar 2023 02:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822EAC433EF;
        Tue, 14 Mar 2023 02:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678762703;
        bh=Nb8YLzjaaehcZH0JrxOOWy7fGSmJiXf3DWqXOfHBR6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2/wEEZvquI9MUwzKs+cfUVrNcZbyzIfrv7NUiqliCM8fQWjfdE6ymgrQNQw01f9g
         vDQKqxo5Fsj7tIDvcBhWjeZBXh+rThzP+BSio4SR/5evG/r4oENqnC2k/b4ognr8hm
         ILA5NplU52S5OF2701ASj/BJucVquF7K/azKW+brOUecigRsO91yBJM2m5+coddA0j
         euH3Lcut0r5+TwI6FAQpiH7ktjtXmjKaVyA7AByye1diYYVffUIJ7iL055xwpxVgwc
         HGhXrsbBBqZbr1pqx6kBScqsqMwvAHAkwx3E6MoIhw/4C0KT8MDwKy+37B3kwVVRJ9
         kXq3c6OjKA1gQ==
Date:   Tue, 14 Mar 2023 10:58:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] ARM: dts: imx6sll: e70k02: fix usbotg1 pinctrl
Message-ID: <20230314025815.GJ143566@dragon>
References: <20230226131214.278911-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226131214.278911-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 09:12:12PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> usb@2184000: 'pinctrl-0' is a dependency of 'pinctrl-names'
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied all, thanks!
