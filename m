Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BA0737141
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjFTQPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFTQPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:15:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A62F4;
        Tue, 20 Jun 2023 09:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8329461315;
        Tue, 20 Jun 2023 16:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88ABC433C0;
        Tue, 20 Jun 2023 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687277748;
        bh=vLu8A87e4PVV+1rfngkXDGdxWaIobIfJxgp7T9HvP3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RKZkJLXfap69ZUlvUbdPlheJZ53McsjHEkRWmsy9BntNQaPOa5mQkG5yScfnCeD3p
         d7vw0z/ywJFr3AzCLCNtVT0cfiB97SUFYpBW0AgAhUCFfZgliYjC1XLihsYGXymOVS
         KPFXHDSD/wcudqMocJl7uoQEsPSNqrvQ4279zK6eG4EChCJfvKlQbkcWujqF05h3zD
         ICzvT/fNZY/knt1Av/iSsDaceWgl8eB71CmWsQR065ykhgdAY3NNrRVi3p2dGCxxAo
         DxSRWPAqGxs9ExbDgw2eIpi07HoJm8WhL+JZNFoj2RcRAHoQozLxnYhn4lEkShGHIW
         kkiR5xLDb7uUA==
Date:   Tue, 20 Jun 2023 09:15:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Saeed Mahameed <saeedm@nvidia.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Shay Drory <shayd@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the net-next tree
Message-ID: <20230620091547.43aae17e@kernel.org>
In-Reply-To: <20230613163114.1ad2f38d@canb.auug.org.au>
References: <20230613163114.1ad2f38d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 16:31:14 +1000 Stephen Rothwell wrote:
> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst:57: ERROR: Unexpected indentation.
> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst:61: ERROR: Unexpected indentation.

Hi Saeed, what's the ETA on the fix for this?
