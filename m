Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8526686A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbjALWOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbjALWOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:14:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63A66986
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:08:05 -0800 (PST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9F27C3F76A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1673561283;
        bh=xAEr7b8eWHGA69/IdRu8mUtv76MS8HNh8m/8P7DLctU=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=KXhpverrPQ3+CxF5e+Pa0QvOUI0vG19pKL1zJuqOK1msE8KcXh9TwhCA5DQ6rer52
         6aYP53RqU9X0qGfaJ5xKsq2DNztF3+mzPJAJMlIjdQWJXhskFW/cWR3caWRzsZuTnR
         FCuuj1hzmEVy8h8nhxl9NxH+xxEWqoFmdG/oVy9Hog+Z/BcTIcPky0tAyL0j7SXs5m
         Dwp1inBu1dBDLrF0sPmUnonAbZDVyxoLIrWOT+jm48LqP1fb/siZv5o8WOAXaTPRcq
         oq4g+Cv3Gdm8YAj+x9zWiju7g8nf33LqjN9FO9577H6nQEDDAJD7PVdGxSgFo7mOZa
         JSqvOncB34Avg==
Received: by mail-io1-f70.google.com with SMTP id d24-20020a5d9bd8000000b006ee2ddf6d77so12044489ion.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAEr7b8eWHGA69/IdRu8mUtv76MS8HNh8m/8P7DLctU=;
        b=OyUByDCuApbnH8hf4+6zhV4LBt/djJp7ILe4u0C4O9qq9idOFd/NCbY507EluyVoE+
         lo1MLyNgAFrQxXxOISSD2tfZx5QsKJO/QcpY/Jqnj/j7EXULZgiXswTYTVtujoZQnNr+
         QjsWENMBoQLhFePBiqzhmQkj7Ld4PaJIV9JLyRPluQ/tUz0/TZZS5P9Gboe7FRV2z3LB
         CBU4k5LNGd2TDMxsFlT4a3RqMnbWGxKzf1SWhT99qd5/QPUl7j090HCRnYfDp7argLYN
         pg78RmJVMwiaend6vX/ke2lX12ZVdYc+fNkNN4L2PddPRtmIiKMei/PuEqUJRpwPcbK7
         Ymcg==
X-Gm-Message-State: AFqh2kr8xok/4c4+y3hoS3iTj0CnsHWHXNX7ZY3XD9MbAb6p5Fp62rPK
        SPL21rBx9zjea5nfnzCHZISaaW7R5f+3I2Bbxa1kub9rCLP4F92f0GnF06lkQ1L0oAqvZ3vBEoY
        A4eZC1uxu9OQAL4KIv9k3EaHG+Y7Vhhp7w/ySoF6ITw==
X-Received: by 2002:a5d:81ca:0:b0:704:56dd:23fd with SMTP id t10-20020a5d81ca000000b0070456dd23fdmr9211231iol.16.1673561282357;
        Thu, 12 Jan 2023 14:08:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsby2dkq2YRqi31nToci8CrjuSW0E0XDFSo5sQVKzX9MBZCgLrS/8uBKb1KQLNwOz1ZMUmIHA==
X-Received: by 2002:a5d:81ca:0:b0:704:56dd:23fd with SMTP id t10-20020a5d81ca000000b0070456dd23fdmr9211220iol.16.1673561282066;
        Thu, 12 Jan 2023 14:08:02 -0800 (PST)
Received: from xps13.dannf ([38.15.56.166])
        by smtp.gmail.com with ESMTPSA id c8-20020a6bfd08000000b006bbfb3856d6sm6353789ioi.5.2023.01.12.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:08:01 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:07:59 -0700
From:   dann frazier <dann.frazier@canonical.com>
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Roi Dayan <roid@nvidia.com>, Maor Dickman <maord@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ran Drori <rdrori@nvidia.com>,
        Frode Nordahl <frode.nordahl@canonical.com>
Subject: Re: [PATCH 5.15 049/230] net/mlx5e: Check action fwd/drop flag
 exists also for nic flows
Message-ID: <Y8CEv90mCZkmuFAq@xps13.dannf>
References: <20220711090604.055883544@linuxfoundation.org>
 <20220711090605.473699898@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711090605.473699898@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 11:05:05AM +0200, Greg Kroah-Hartman wrote:
> From: Roi Dayan <roid@nvidia.com>
> 
> [ Upstream commit 6b50cf45b6a0e99f3cab848a72ecca8da56b7460 ]
> 
> The driver should add offloaded rules with either a fwd or drop action.
> The check existed in parsing fdb flows but not when parsing nic flows.
> Move the test into actions_match_supported() which is called for
> checking nic flows and fdb flows.
> 
> Signed-off-by: Roi Dayan <roid@nvidia.com>
> Reviewed-by: Maor Dickman <maord@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

hey Sasha,

  A contact at Nvidia tells me that this has caused a regression w/
OVN HW offload. To fix that, commit 7f8770c7 ("net/mlx5e: Set action
fwd flag when parsing tc action goto") is also required.

 I'm not really sure what flagged this patch for stable, so I don't
know whether to suggest it be reverted, or that additonal patch be
applied. Roi - what's your thought?

  -dann

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index 3aa8d0b83d10..fe52db591121 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -3305,6 +3305,12 @@ static bool actions_match_supported(struct mlx5e_priv *priv,
>  	ct_flow = flow_flag_test(flow, CT) && !ct_clear;
>  	actions = flow->attr->action;
>  
> +	if (!(actions &
> +	      (MLX5_FLOW_CONTEXT_ACTION_FWD_DEST | MLX5_FLOW_CONTEXT_ACTION_DROP))) {
> +		NL_SET_ERR_MSG_MOD(extack, "Rule must have at least one forward/drop action");
> +		return false;
> +	}
> +
>  	if (mlx5e_is_eswitch_flow(flow)) {
>  		if (flow->attr->esw_attr->split_count && ct_flow &&
>  		    !MLX5_CAP_GEN(flow->attr->esw_attr->in_mdev, reg_c_preserve)) {
> @@ -4207,13 +4213,6 @@ static int parse_tc_fdb_actions(struct mlx5e_priv *priv,
>  		attr->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>  	}
>  
> -	if (!(attr->action &
> -	      (MLX5_FLOW_CONTEXT_ACTION_FWD_DEST | MLX5_FLOW_CONTEXT_ACTION_DROP))) {
> -		NL_SET_ERR_MSG_MOD(extack,
> -				   "Rule must have at least one forward/drop action");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	if (esw_attr->split_count > 0 && !mlx5_esw_has_fwd_fdb(priv->mdev)) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "current firmware doesn't support split rule for port mirroring");
