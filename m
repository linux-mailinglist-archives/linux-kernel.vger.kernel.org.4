Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C187B70E098
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbjEWPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbjEWPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5D1B9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70DB163244
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DA9C433EF;
        Tue, 23 May 2023 15:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684855985;
        bh=osoUBAnh7wvCQvzNl0PgfYGMWjN8YEhX5fAYqCQLKzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CsD5FvOLNBtOHCzlORiS08JfHlTgrKDJ5DgzJRAMX8Szo0TGh/MNFDjkA+4xEI7QY
         0bfWA20QCAULF/6bcwFB8NE6zUyyyn3k0vBLfhFoqI8nPBO4wt42saFO/RVE3Zu2Bi
         eeMy2Q8jX8KFs+xm5e8cex9vAK5wFKb1WAxTcXB3om6BBMzThwoU6Sq+pFwkO/5GRU
         dB60z6Ya+Z9QtgAur3ziHuqpCRg8jez52BE0Kt6txc8lRoMu2Bk5WcDwpSIbT5Xuw+
         gbtfRIEKPDv6JCdg7Ojri/pc3mE9N9OmRYYCbhZkqsu0YQIcFi1YuqptIZV13m8FEQ
         kA6x4UUKTr5TA==
Date:   Tue, 23 May 2023 08:33:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dinan Gunawardena <dinan.gunawardena@netronome.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] bitfield: suggest using bitwise OR when combining
 bitfields
Message-ID: <20230523083304.4a02d16b@kernel.org>
In-Reply-To: <9b872036-42ce-2d08-2e98-12bf0abf7095@axentia.se>
References: <9b872036-42ce-2d08-2e98-12bf0abf7095@axentia.se>
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

On Tue, 23 May 2023 14:16:30 +0200 Peter Rosin wrote:
> Logical OR fails to deliver the desired result. Most of the time.
> 
> Fixes: 3e9b3112ec74 ("add basic register-field manipulation macros")
> Fixes: e2192de59e45 ("bitfield: add FIELD_PREP_CONST()")

Fixes tags for comment changes are an overkill. The change looks good.

Who are you expecting to take this patch? Feel free to repost this
CCing netdev@ so networking can take it, otherwise maybe Andrew will?
Not sure..
