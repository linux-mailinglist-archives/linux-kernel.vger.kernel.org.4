Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533FC71A396
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjFAQDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFAQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D94B3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D9E862DEF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB0AC433D2;
        Thu,  1 Jun 2023 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685635391;
        bh=g7Jl5yrwpXlNDhMxhubxbj3MMq91RwrWaao0HlEgncI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IW7dhn4BQ1nsKxaOjLM/rYG2xMimBeJkbyGd0kKInYao5NND70+CKY97V2zzYPy1y
         LNchgIWLDuT8qoa59syvz0WsTifHSvzZOk8IeMuZE7z/TfpJ61+bdPjKcSOLVsAuFh
         DaYIDJvIBiAnX9POMxzImDzLRzAuFe0iIhi8bpjgEVQMFUfpXllqRpfUfBAXiqeQ8H
         o4f4/3VjXSH8Z1RmJn11c6Z+v+Nz5WeKonEgx3W80pOhkqIIFG/bj0+1vl13/2640b
         ubgdEpabuU5kJ1YJH+URUgPIAVhR3KyyKTf8GwcoOE97ms0SGLc+VvHfT4cBKCBYte
         jWV2IhkXRJovQ==
Date:   Thu, 1 Jun 2023 09:03:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next] ethtool: ioctl: improve error checking for
 set_wol
Message-ID: <20230601090310.167e81b2@kernel.org>
In-Reply-To: <ZHi/aT6vxpdOryD8@corigine.com>
References: <1685566429-2869-1-git-send-email-justin.chen@broadcom.com>
        <ZHi/aT6vxpdOryD8@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 17:55:21 +0200 Simon Horman wrote:
> + Daniil Tatianin <d-tatianin@yandex-team.ru>, Andrew Lunn <andrew@lunn.ch>
>   as per ./scripts/get_maintainer.pl --git-min-percent 25 net/ethtool/ioctl.c

Sorry to chime in but always prefer running get_maintainer on the patch
rather than a file path. File path misses stuff like Fixes tags.
If it was up to me that option would have been removed :(
