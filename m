Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA0B71340A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjE0KhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjE0KhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:37:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE9010A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 03:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20AF260B81
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15E3C433D2;
        Sat, 27 May 2023 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685183822;
        bh=d69AAhBzpUC0eOvHS0/YI/AvoeOO4D0EBrByjnwcrzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUtO/deUrGniO0a+n+KCYtwmLQphTh6YanAQUwv4V0vdyu8gt1FjmDQAO1lOW6xIb
         qxQ5lG9PJjEXCNZxqo4uIybg85UJWq2q5N5B8yx5u4VSmkYdMMtEFl9qdoD5Xm38hd
         EeTqJ3PAxzEf6rA7S4h/i+qtAPklVhCqLIVb4NajIaspDWL4tjnsViTAfxPx1yVnsH
         GSjkGih+69Y7Cl8PMFbxn6anPhCZa4nKa6TJyysqY0i1zlNhi+vgYMiQOAbTPbVyFG
         vgLZXy7sAvsauUldvqMsWydMded+TxiWMeeCfq6z+6dwGJrRfhM3ZPrap0n0PnuW9t
         E2bWCgO3ULhGw==
Date:   Sat, 27 May 2023 16:06:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 00/26] ASoC/soundwire: add support for ACE2.x
Message-ID: <ZHHdSjXwyHvBezkG@matsya>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-23, 15:10, Bard Liao wrote:
> This series uses the abstraction added in past kernel cycles to provide
> support for the ACE2.x integration. The existing SHIM and Cadence
> registers are now split in 3 (SHIM, IP, SHIM vendor-specific), with some
> parts also moved to the HDaudio Extended Multi link structures. Nothing
> fundamentally different except for the register map.
> 
> This series only provides the basic mechanisms to expose SoundWire-based
> DAIs. The PCI parts and DSP management will be contributed later, and the
> DAI ops are now empty as well.
> 
> The change is mainly on SoundWire. It would be better to go through
> SoundWire tree.

Applied, thanks

-- 
~Vinod
