Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2B374A150
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGFPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFPog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27284CE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:44:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C9C60BEC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE362C433C8;
        Thu,  6 Jul 2023 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688658275;
        bh=bMABdl+5mCBcPYoYi5ad8hwP76ZhZJrs6kKcX7qC/oc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZiIl5FR7GEqBWmRPrQRwxkVFBdOU/g4Z7qFnzQearUQpc46s4tKhkpjMg2KawIrys
         MgdcIZqfu9aTBxr27lQFOSAPdt3LfVGgYGi+aNXkEPc6RGmBa9ps7MrZEu8ekvvCQn
         pT1pzWATA5Iu5PrcX+uylWBTSwiCWkBerpKe+1Ou6m5XL2WpiAjkoch/R6n3XwYojB
         YsMfzXaDGjOBMaWrZVY51fB+LADOED4ywNZFXEyPifRt2jVsjl0jUWZojylrZYcCMs
         Ylj22aWxs3LlP4picrmKWBDwjiJ88DoAyWItMOxDabHsyhCBCms0J7FK0D45kky2TO
         SQ0KtwZwS+/Lw==
Date:   Thu, 6 Jul 2023 08:44:33 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmforbes@linuxtx.org
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
Message-ID: <20230706084433.5fa44d4c@kernel.org>
In-Reply-To: <20230706145154.2517870-1-jforbes@fedoraproject.org>
References: <20230706145154.2517870-1-jforbes@fedoraproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jul 2023 09:51:52 -0500 Justin M. Forbes wrote:
> The rmnet driver is useful for chipsets that are not hidden behind
> NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
> NET_VENDOR_QUALCOMM as there is no dependency here.
> 
> Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>

Examples of the chipsets you're talking about would be great to have in
the commit message.
-- 
pw-bot: cr
