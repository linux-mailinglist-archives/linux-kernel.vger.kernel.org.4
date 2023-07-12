Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCC74FC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGLAnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjGLAnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:43:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A210CF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3557061646
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71293C433C7;
        Wed, 12 Jul 2023 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689122591;
        bh=3axPrmw4y+Z5QNRDwLTeMrlIrd2WntruvKqrhdFFYmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mwTt0ZwrbSwt6DgNqES8kDj+5RMcNhfrQrbiWg0dVFfvUkMt0HKJWl6p2R8Kie5mT
         D6dnVGoSIFngz+BxVvaxkZNE2Rza1kdSPp6calPGoldzViiWnkS6L7J3KG7j7CMO5Z
         lk+d1pzgL061te0QQLJqjnOm4w6UGxUH4TKTV7eKWdOtx17Rvx2j8PLmtUpz2nbyOd
         /pDGiZ0F2YiZO6K0EaITAa4PfkVdkKr/G2M4XIE0vzZrMT7aUWSP5mmsaPEW/out3w
         EVz6Sq1xySXp6gzoper8xpSruI/hqhbKaRfpUtfaoBJ+U5C8UsUZ2WfYWoMGXKSlL+
         dp0sDmQyr3VcQ==
Date:   Tue, 11 Jul 2023 17:43:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <20230711174310.081a2574@kernel.org>
In-Reply-To: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 13:06:24 +0300 Andy Shevchenko wrote:
> The bit operations take boolean parameter and return also boolean
> (in test_bit()-like cases). Don't threat booleans as integers when
> it's not needed.

I don't have a strong opinion on the merit.
But I feel like the discussion is a waste of everyone's time,
so to discourage such ambivalent patches I'm going to drop this.
-- 
pw-bot: reject
