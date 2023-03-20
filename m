Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0596C110E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCTLpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjCTLpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2837158AC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D7B56149D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D81C433EF;
        Mon, 20 Mar 2023 11:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679312693;
        bh=CHx32plH/8ZPNfLvdZDyAv14pUpvBNpy/SnN9m3SZ+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rw71ikQwxwHPh0LUoWeifO2qPO1q6+4tHyXlbhKMCVwQ1SErE8AH0a7oCpjDOxBqv
         Q8CkXbq/BrA3ndnYFBaFUAeAlmzQS9nebhCg4OTR8Pig67o05t6XoTM7okXaYedchs
         uuNMWj1hchYJXWq7XHQvvtTxAnnpPyl1Ql6OYsklp2R8kblwWxgtr+1LijWAjB2iGv
         7yptd1lcoX8JS3QCOgqc9fNFptwl1jmQl7U/vSHtt/lUNU43ocZTnteHeXWV50HgVv
         lfQTW28s7jRsGvSNHQ5hSthrpNEIbzEM2zXwnaeL7sUps96boGwOhlpjY7skqa/Wrp
         8SZlhIw+JrLQw==
Date:   Mon, 20 Mar 2023 17:14:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] phy: marvell: drop of_match_ptr for ID table
Message-ID: <ZBhHMNAuETEutCNY@matsya>
References: <20230312132611.352654-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312132611.352654-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-23, 14:26, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).  This
> also fixes !CONFIG_OF error:

Applied both, thanks

-- 
~Vinod
