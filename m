Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F026C5ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCVXpq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 19:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjCVXpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:45:23 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18CE23861;
        Wed, 22 Mar 2023 16:45:06 -0700 (PDT)
Received: from p508fd58e.dip0.t-ipconnect.de ([80.143.213.142] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pf88b-0005eN-AT; Thu, 23 Mar 2023 00:45:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/arm: dts: rockchip: Fix DSI node names
Date:   Thu, 23 Mar 2023 00:45:00 +0100
Message-ID: <5196838.kQq0lBPeGt@phil>
In-Reply-To: <591bf126-1ab7-8a5d-0d3a-1cac4cd9b112@gmail.com>
References: <20230319174105.43978-1-robh@kernel.org>
 <591bf126-1ab7-8a5d-0d3a-1cac4cd9b112@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 19. März 2023, 20:36:20 CET schrieb Johan Jonker:
> 
> On 3/19/23 18:41, Rob Herring wrote:
> > DSI bus/controller nodes should be named 'dsi' rather than 'mipi'.
> 
> There's already a serie that does that.

I've now applied Johan's patches that fixed a lot of these
naming issues and also the other things uncovered after the
yaml conversion.

Heiko


