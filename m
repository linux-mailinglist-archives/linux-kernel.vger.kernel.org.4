Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707C572F126
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbjFNAu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjFNAuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:50:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D32199C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 17:50:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4BBB634A3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0250EC433C8;
        Wed, 14 Jun 2023 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686703852;
        bh=BPkeVu8OxPotzWhrp9aHUHfVrW4/Skp7NV1QkalCka0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hMuC7m1k1oCYmdNL8W4eaq/Fvq7MovlhxOr/OnphL+JQKlG4/ZU3zJOb/L4gKtCys
         2q2duUg4/aq3zcgK1ztZ6DigIO2B+rjDS3OLvJa/1V2dHQTF53Dt5BJugftKUECuaM
         gkHPShP4miWFR5HLA40hNR8MmqGZ2k7tBsjMbsAIz2Kg5GMbtyldxMLB4Z6Uv44yOU
         jQtmRmbCSWxZ90iy3aBDWsV65uhNc5Org6RcU2csRHj+h31HUiXztoV5VjmEPFcSpJ
         TV4zQPDg7SWfA1b/aeC2Oy7Kujl8dlWJgnsbDW4ybN26mE/HFGi70f8xVfDjwGDNlX
         YmaTJ5Y9EcqXA==
Date:   Tue, 13 Jun 2023 17:50:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
        chuck.lever@oracle.com
Subject: Re: [PATCH net-next] tools: ynl-gen: fix nested policy attribute
 type
Message-ID: <20230613175051.32196c59@kernel.org>
In-Reply-To: <20230613231709.150622-1-arkadiusz.kubalewski@intel.com>
References: <20230613231709.150622-1-arkadiusz.kubalewski@intel.com>
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

On Wed, 14 Jun 2023 01:17:07 +0200 Arkadiusz Kubalewski wrote:
> When nested multi-attribute is used in yaml spec, generated type in
> the netlink policy is NLA_NEST, which is wrong as there is no such type.
> Fix be adding `ed` sufix for policy generated for 'nest' type attribute
> when the attribute is parsed as TypeMultiAttr class.

I CCed you on my changes which address the same issue, they have
already been merged:

https://lore.kernel.org/all/20230612155920.1787579-1-kuba@kernel.org/

I think that covers the first two patches. What am I missing? :S
