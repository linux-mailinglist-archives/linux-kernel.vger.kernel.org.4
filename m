Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A447377E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjFTXM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFTXMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57DBE4D;
        Tue, 20 Jun 2023 16:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B01161355;
        Tue, 20 Jun 2023 23:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA044C433C0;
        Tue, 20 Jun 2023 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687302773;
        bh=/5bo5g8W/lm+VG0x/hbqsgLrUWsHXxhUqcF2voXbXaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecuBldW1MvxlzxJCGJu7MuN+UooZhW2XgN/sTn8vil32wpc2DSVeX1y5MQ+XlMOtE
         20bi7GSxt3neVcORbjudncSX91n3XQ5IQvoBRxry6j4J5vqh9e0orakpxAPgZA+0ik
         +xVgd2D8AQiXpl8NWb+ZFjkV8PuW7IRwQYZgGd/vJCHGiN2P/o+eJqmwG09bdBjuMV
         AJju+DAOliwcjI1+dGhCSToLHa/LqNJE1jjeFj0KYs1YkaHtiWQ/9C6ARTMLg+8OOn
         rZSES3KnxefFtkUu47U7Bs7csUdVpIbA2sr3sZxrB/fxpiSnvEhl2Yjs/5kPM2/yOh
         +Nje54+2iBFBQ==
Date:   Tue, 20 Jun 2023 16:12:52 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Saeed Mahameed <saeedm@nvidia.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Shay Drory <shayd@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the net-next tree
Message-ID: <ZJIydCHR5dB3PoKO@x130>
References: <20230613163114.1ad2f38d@canb.auug.org.au>
 <20230620091547.43aae17e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230620091547.43aae17e@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jun 09:15, Jakub Kicinski wrote:
>On Tue, 13 Jun 2023 16:31:14 +1000 Stephen Rothwell wrote:
>> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst:57: ERROR: Unexpected indentation.
>> Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst:61: ERROR: Unexpected indentation.
>
>Hi Saeed, what's the ETA on the fix for this?
>
Hi, I will provide a fix by tomorrow.

Thanks.


