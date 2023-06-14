Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4C730522
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjFNQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjFNQhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588512684;
        Wed, 14 Jun 2023 09:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E183D64098;
        Wed, 14 Jun 2023 16:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47470C433C0;
        Wed, 14 Jun 2023 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686760611;
        bh=Q3hI23JS1gH/eq1EjaREWFCzmK5MREhtpdlNyvHwILw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tGKyM3FjC2pgb3RtrwXwRJCRJ1N4a2SUETeR/4kWmc0UAqN9jqE0kr6vFBs6Grhad
         fzurYJye5OzfWYTrTc8CB11rauV5Ks8bRSiwAhVbolNLcOW77vRd6NdK665sjQtyyN
         RfyBL0VFgAbnVIzH9DxI2wJhaHXbcrMe4+VEkNFmzHdBqD/yKII4y0XafZQ4pVT4RA
         TZtcUaBdm74ggGAwP5N+V7oYOvpttb+ndspnhp7TIrj62Uy7Iij/TrPjJ8WRr4E1LJ
         ci88t4/dTPvvh/X6Fsg5CwPbCqFNNsd7EckkgZ8WkQGEFDIPKQ+uSBZmr49oU2XMxr
         WFk7qXKHDKQMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CE03BCE2246; Wed, 14 Jun 2023 09:36:50 -0700 (PDT)
Date:   Wed, 14 Jun 2023 09:36:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     joel@joelfernandes.org, mmpgouride@gmail.com, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] Docs/RCU/rculist_nulls: Fix hlist_head field name
 of 'obj'
Message-ID: <43943609-f80c-4b6a-9844-994eef800757@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230613182434.88317-1-sj@kernel.org>
 <20230613182434.88317-4-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613182434.88317-4-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 06:24:33PM +0000, SeongJae Park wrote:
> The example code snippets on rculist_nulls.rst are assuming 'obj' to
> have the 'hlist_head' field named 'obj_node', but a sentence is wrongly
> mentioning 'obj->obj_node.next' as 'obj->obj_next'.  Fix it.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/RCU/rculist_nulls.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> index 94a8bfe9f560..5cd6f3f8810f 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -86,7 +86,7 @@ Quoting Corey Minyard::
>  2) Insertion algorithm
>  ----------------------
>  
> -We need to make sure a reader cannot read the new 'obj->obj_next' value
> +We need to make sure a reader cannot read the new 'obj->obj_node.next' value

I do like this being more specific, but if we are going do add this
level of specificity, shouldn't we refer to a definition of ->obj_node?

(I queued and pushed 1/4 and 2/4, thank you, and stopped here.)

							Thanx, Paul

>  and previous value of 'obj->key'. Otherwise, an item could be deleted
>  from a chain, and inserted into another chain. If new chain was empty
>  before the move, 'next' pointer is NULL, and lockless reader can not
> -- 
> 2.25.1
> 
