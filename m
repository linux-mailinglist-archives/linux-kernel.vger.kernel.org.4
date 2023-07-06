Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA61E74A167
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjGFPsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjGFPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA01BF6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1E5D60B9C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 15:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDC3C433C7;
        Thu,  6 Jul 2023 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688658481;
        bh=4ASIsjcCMXJ6y3BmrH23jMs2Uiv/tnU9i09G/DMp9i8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PsUdJCiPG2ZCBQJG2eka4OFYlYQdogV7Ar1J3g9NEI4VfTjSoAJIf2dOK1IqK95mh
         I6iP+r5jNWf0hUmQPPtTotHi0NUu3m6MhV17q9t9Kc/8r/RBzehV4vqneSrlBRN4hx
         V/0CTuE9xT4Zi89Tn0ntAd+l8vI13+yuRfUqJ1iMik7xwSVVzDkbWx22XOlbiCK+ab
         h74R6h3/AfHD3ybFrrBLc/nK6GimGlcfzUtEMQdUKqnKoPIKioiD0ZyJbVFBgMSO7E
         isukZTMpyXvCbBlvwNjdcqWyyc8nFqXbLQ3y6nItWHjnjyTu2kir8us3LIvhc514Dd
         5bJ5BFF0jG0Yg==
Date:   Thu, 6 Jul 2023 08:48:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        simon.horman@corigine.com
Subject: Re: [PATCH net v2] net:thunder:Fix resource leaks in
 device_for_each_child_node() loops
Message-ID: <20230706084800.579bd030@kernel.org>
In-Reply-To: <20230706123021.8174-1-machel@vivo.com>
References: <20230706123021.8174-1-machel@vivo.com>
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

On Thu,  6 Jul 2023 20:30:11 +0800 Wang Ming wrote:
> The device_for_each_child_node() loop in
> bgx_init_of_phy() function should have
> fwnode_handle_put() before break
> which could avoid resource leaks.
> This patch could fix this bug.

Don't ignore previous feedback
-- 
pw-bot: cr
