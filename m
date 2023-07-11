Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58B274E5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjGKEOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKEOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:14:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7871A8;
        Mon, 10 Jul 2023 21:14:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEB57612E1;
        Tue, 11 Jul 2023 04:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518CAC433C8;
        Tue, 11 Jul 2023 04:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689048877;
        bh=/NT8j5dTImyDDiBcLBerEKRFvktbfWBQTuwILJurgBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0xb7wdHITbH1KagxXY1mBrMYPgJq56cnkg4HXbW0CUrZHkV5XYIv3hUqnD0YBEyz
         aKCRNr8QUZGt5oJxktjEmbt7E+5oitUhUgBlYPgV9l4GtsXLcG4zLtOAtdq6fnCZBl
         0ECV5QSqWAY6ZYuU3zuOiztQ0BbX7x8xagbdtqzHbei8JOh/orw9z6aXyGAg2+ywrb
         bfhq1lDYMHzpTObWkGwvewiElTMpF4KPWcitBtwgizYcG8Y/KiOe1cMsdLr/QNCLNT
         4TksycOHPTSJ5ghE16r6tvjJeEoTslpekyNRyfldKWHtcLDkL6lI0JI1FD01mmaclR
         fu8yC0RtYuvxA==
Date:   Tue, 11 Jul 2023 09:44:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org
Subject: Re: [PATCH net-next] MAINTAINERS: Add another mailing list for
 QUALCOMM ETHQOS ETHERNET DRIVER
Message-ID: <ZKzXKCpoN0Zz4cCs@matsya>
References: <20230710195240.197047-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710195240.197047-1-ahalaney@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-07-23, 14:50, Andrew Halaney wrote:
> linux-arm-msm is the list most people subscribe to in order to receive
> updates about Qualcomm related drivers. Make sure changes for the
> Qualcomm ethernet driver make it there.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
