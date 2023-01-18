Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967A7672460
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjARRCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjARRCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:02:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6ED4616E;
        Wed, 18 Jan 2023 09:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 142B9B81DDB;
        Wed, 18 Jan 2023 17:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ACBC433EF;
        Wed, 18 Jan 2023 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674061318;
        bh=a84FGLCSP4PpD8EGf1sRH+8aTGt6Fj6ydtWWlmpcOz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+8hO2MhIPUNgLfP48afah90W+Xs8YWIoEM837iIGMbMTL70AX7vhr44TyV2s1iwJ
         nwrwhv+UDdojkiAXIHJEB8GlLE3fRrC7rmQNU7rbR8FlgTAtxBIpPUXpn37rCmx9JR
         eiAq8sPtnW5wl0afAiEZ1q7kB0aQUpUbh5EU/NJgXVwzemSUk8K0+M+MNMrDI/IDel
         HwrUAmr0LJ4cwisZKlI3rvezNllGf1+VS0fO9FhCOnNKuZJwjpBu1XdDPdwJr3ZSKP
         lzuy4C+gLABq6/Op0lsxSY4ciwQS0XGnniAku5nEmV7tnVuE6VvSjA7xIrCMnjjHvz
         I3c2Zw+bOqyGA==
Date:   Wed, 18 Jan 2023 22:31:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        kishon@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip: convert
 rockchip-dp-phy.txt to yaml
Message-ID: <Y8gmAiHMcU4ekkUk@matsya>
References: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
 <Y8GeBzNJvhMeh3sn@matsya>
 <8eca0d59-8db3-b66e-f219-0a256a9b0c79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eca0d59-8db3-b66e-f219-0a256a9b0c79@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-23, 20:58, Johan Jonker wrote:
> 
> 
> On 1/13/23 19:08, Vinod Koul wrote:
> > On 29-12-22, 10:44, Johan Jonker wrote:
> >> Convert rockchip-dp-phy.txt to yaml.
> > 
> > This series fails to apply, pls rebase
> 
> Hi Vinod, Heiko,
> 
> This serie and others must be combined in the right order to grf.yaml.
> Maybe better that Heiko does that with your ACK.

Sure:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
