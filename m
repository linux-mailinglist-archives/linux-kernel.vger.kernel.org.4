Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D277D6ED413
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjDXSEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDXSEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7095C5258;
        Mon, 24 Apr 2023 11:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BC216263A;
        Mon, 24 Apr 2023 18:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CB6C433D2;
        Mon, 24 Apr 2023 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682359481;
        bh=V0ffEm/i184djrWxkIFcYKtwLFV+mTuutr/4KggWZ5I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mIP5nZ10N2d57+W/Ha1zyN5Wll2UX3rU/PotCYzDPnA1Gqp1PVtdv7PEmcHukZqgW
         uUu8MxUGngPhFbygD5piqK0RUfcxKJVfeQn10VkDFbKW0ZLMeUTeZSeNE0YxryB04w
         jbupJBzG310HXeb+h9zQErqSOB1a+WljcmboCNoEwwIVwlMCBUmJKcPai5jbPzjCb6
         HrHkbKBdrN8O6Axf7iEhdD6wfcGA7SJlrffy5C8ZKfCzoq/F8T2bJyzrifRWsmUqWr
         opPk9qmyRa0wInHo6j3bIqKCrky8Anm45pE7fTncgb5PEjdbXZxExz5JXVu3ef92iw
         YZDhY3MUWu0FA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E006915404E7; Mon, 24 Apr 2023 11:04:40 -0700 (PDT)
Date:   Mon, 24 Apr 2023 11:04:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, boqun.feng@gmail.com,
        qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update qiang1.zhang@intel.com to
 qiang.zhang1211@gmail.com
Message-ID: <5092e921-d31b-405d-be30-5bbf9c28fb7d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230424115107.1627076-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424115107.1627076-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 07:51:07PM +0800, Zqiang wrote:
> The qiang1.zhang@intel.com will no longer be used, update to
> qiang.zhang1211@gmail.com.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Queued and pushed, thank you!

							Thanx, Paul

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e03067b857a2..72c8efa5bbd5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17643,7 +17643,7 @@ M:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  R:	Lai Jiangshan <jiangshanlai@gmail.com>
> -R:	Zqiang <qiang1.zhang@intel.com>
> +R:	Zqiang <qiang.zhang1211@gmail.com>
>  L:	rcu@vger.kernel.org
>  S:	Supported
>  W:	http://www.rdrop.com/users/paulmck/RCU/
> -- 
> 2.32.0
> 
