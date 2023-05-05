Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483856F837F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjEENII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjEENH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDF41E980;
        Fri,  5 May 2023 06:07:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4E963DF7;
        Fri,  5 May 2023 13:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1E7C433D2;
        Fri,  5 May 2023 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683292074;
        bh=79GP8oXho+dfqQeJ9uzaGIMD8UOrca7fRPGnKMX7260=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZicXFbz5jZNyVMlORYCz7kdzL7JnEhsJD8hTUYsluy8Ja7g6QjmtmrtEtzTBhfWXw
         1MKOD8EZGapobKYgPTi/t5pOw74CzsRHSQoD7vsn9Xi+QRRSy/mHpyemajBuVjWOTM
         zfx+JyQOc2dl+rVq4LyVtCbmNippsL6CbGNM+0kiLfkWCI0BI4Hg9rfdo/bI8rvO1a
         3EKzQJXd5ZM8GCxTJmo8KeBdfpWgy4yi/X+BKdKt5L6yMAyWMsmsG5QHTu2sAmJZru
         ziIQ/oBWQajqkALiJp/UpygjmsDaicyIus2cLG9TJLuiDOBevUsWyRB6KQzb9sfu8L
         KKn8JK8W9vnJw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] wifi: ath10k: Use list_count_nodes()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <e6ec525c0c5057e97e33a63f8a4aa482e5c2da7f.1682541872.git.christophe.jaillet@wanadoo.fr>
References: <e6ec525c0c5057e97e33a63f8a4aa482e5c2da7f.1682541872.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168329207040.10223.8921513791102227473.kvalo@kernel.org>
Date:   Fri,  5 May 2023 13:07:52 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> ath10k_wmi_fw_stats_num_peers() and ath10k_wmi_fw_stats_num_vdevs() really
> look the same as list_count_nodes(), so use the latter instead of hand
> writing it.
> 
> The first ones use list_for_each_entry() and the other list_for_each(), but
> they both count the number of nodes in the list.
> 
> Compile tested only.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

fd7bc9d9d467 wifi: ath10k: Use list_count_nodes()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e6ec525c0c5057e97e33a63f8a4aa482e5c2da7f.1682541872.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

