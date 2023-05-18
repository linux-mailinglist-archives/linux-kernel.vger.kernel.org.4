Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63949707A31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjERGRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjERGRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:17:19 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321562698
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:17:15 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id zWwipDLQ5jCyEzWwiphDGq; Thu, 18 May 2023 08:17:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684390627;
        bh=lHzeDDfUlQX3RH1HXK0XsiQwqk7lqO7xwS/nUPsFcJ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QOwSADmn96OEyVdr0c7A5uO5YPGAzWOZyiU0QJi2BiJnl6Pt/jVDU1puyRiTyZws/
         Y5tgDazDLcZP61+sofQWEaUzFmCo0OO3KL5ppkUwxna38ivSWqlzxe/mUZZ1rXkBfp
         6Rp4irTvkCaJn4X3tLsg6SoKwxS/gR8ua5sEN23+I8R5pTd+oCUXqHYeCsDOp8mY76
         97Tem981S6ocQ5+IaqA1Mwtaxs0IIs8nu2gCVPx6XIXtmRs4DujC8efA6TySfcKIym
         vV87QeD5I5LOb2G3S8Te7GQQOpsBUbwlMG0xvsE9ME3RHih7r/o0HiJ8GPUNYWfPtB
         Qu9l6av+Y2AHg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 18 May 2023 08:17:07 +0200
X-ME-IP: 86.243.2.178
Message-ID: <bd9f392c-93e5-7147-0f21-f6732b210df5@wanadoo.fr>
Date:   Thu, 18 May 2023 08:17:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: AW: [PATCH] wifi: ath12k: Remove some dead code
Content-Language: fr
To:     Walter Harms <wharms@bfs.de>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c17edf0811156a33bae6c5cf1906d751cc87edd4.1682423828.git.christophe.jaillet@wanadoo.fr>
 <d0c5ed33fb1644328fbdc5d7aba20a97@bfs.de>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <d0c5ed33fb1644328fbdc5d7aba20a97@bfs.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 25/04/2023 à 14:10, Walter Harms a écrit :
> Does  mcs = ATH12K_HE_MCS_MAX make sense ?
> 

Based on [1], I would say yes, WMI_RATE_PREAMBLE_HE (i.e. 11) looks like 
a valid value.

CJ

[1]: https://www.7signal.com/info/mcs

> re,
>   wh
> ________________________________________
> Von: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Gesendet: Dienstag, 25. April 2023 13:57:19
> An: Kalle Valo; David S. Miller; Eric Dumazet; Jakub Kicinski; Paolo Abeni
> Cc: linux-kernel@vger.kernel.org; kernel-janitors@vger.kernel.org; Christophe JAILLET; ath12k@lists.infradead.org; linux-wireless@vger.kernel.org; netdev@vger.kernel.org
> Betreff: [PATCH] wifi: ath12k: Remove some dead code
> 
> ATH12K_HE_MCS_MAX = 11, so this test and the following one are the same.
> Remove the one with the hard coded 11 value.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/net/wireless/ath/ath12k/dp_rx.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index e78478a5b978..79386562562f 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1362,11 +1362,6 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
>           * Firmware rate's control to be skipped for this?
>           */
> 
> -       if (flags == WMI_RATE_PREAMBLE_HE && mcs > 11) {
> -               ath12k_warn(ab, "Invalid HE mcs %d peer stats",  mcs);
> -               return;
> -       }
> -
>          if (flags == WMI_RATE_PREAMBLE_HE && mcs > ATH12K_HE_MCS_MAX) {
>                  ath12k_warn(ab, "Invalid HE mcs %d peer stats",  mcs);
>                  return;
> --
> 2.34.1
> 
> 

