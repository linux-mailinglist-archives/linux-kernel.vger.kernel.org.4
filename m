Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF96F827B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjEEMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEEMCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7F1C0FA;
        Fri,  5 May 2023 05:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE83963D97;
        Fri,  5 May 2023 12:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52167C433D2;
        Fri,  5 May 2023 12:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683288150;
        bh=nbaPAqCZ0ApBkXNXBOc2q5/hPJyXqyM1jtg1d1NSImQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oBVIJZ8gfjJPFebPgZDymaw2OqePdHrgpsH/82m4mYRkC0xkVJby4S5uSI+ua7uUM
         3qfR3ROKQFpIkJzUnfc1QVu6iQ2CRFlmjEQAfTmg01RKYixOQAqvNZkzWLZbGlhTnR
         nGC0Dg4nUk4FquZzBvLRnf4CnsK18QQg2HgYgJssT7XcK75qWAG7YlMsgQo3KNvzdK
         8Aye1rgH03MF2PryyEiQR0UgojTWxurrw7TqVB67s0GIAigSuQ2xLJTbklgj8qnbcd
         fhHueJ3AdeXxtdbOoCL/rpj1J+uEbvvFhvwoTQe10Souei2UXO9IWjMCnHDsfCpyN/
         83KG89ucSagiw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] wifi: mwifiex: Use list_count_nodes()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <e77ed7f719787cb8836a93b6a6972f4147e40bc6.1682537509.git.christophe.jaillet@wanadoo.fr>
References: <e77ed7f719787cb8836a93b6a6972f4147e40bc6.1682537509.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168328814540.30117.8252541774240707709.kvalo@kernel.org>
Date:   Fri,  5 May 2023 12:02:27 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> mwifiex_wmm_list_len() is the same as list_count_nodes(), so use the latter
> instead of hand writing it.
> 
> Turn 'ba_stream_num' and 'ba_stream_max' in size_t to keep the same type
> as what is returned by list_count_nodes().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

c401bde6ead4 wifi: mwifiex: Use list_count_nodes()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e77ed7f719787cb8836a93b6a6972f4147e40bc6.1682537509.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

