Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D966165F7A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbjAEXe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjAEXer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:34:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF8972D0D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 15:34:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jn22so40946750plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MA5FpAoor/X9X4ZcIOIcH0RLPWb1EdHduuT3aSWvngo=;
        b=i07iiD7SHvOYpThWCInIqJK0jGhisZlLdZbgsCn0g5/TgXf11QG7WBr7+QRd14Vgfa
         TGZSVOxENfl9EHSe+RgoTwS3lTVxoxOuEC5tNmF/riDp7GsJm5wCAxlfqnr8kbxUWli5
         VLGhmH7jZpeaN5DYUjp0anPMnPWEYP4DxZzmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA5FpAoor/X9X4ZcIOIcH0RLPWb1EdHduuT3aSWvngo=;
        b=Vhz1ahDLnYUdx6zMfaXKn9aZd5btlckKH/qKClXgsH2/HBePAaCqFhU7gyThnw+d4O
         TAKXfHlAHIweswxT9wHG5+0BuU2QgpiFbXIwe1xgGiI1vK2+qE7xlx0qj+CssBXU57Mz
         aPEtQ5QsJckt8Cwk1/D3hyiL3MtRM90GQgKG5g6IWERujG6zVojutoMPjIgCVY8Cap4D
         YsgOBeXbW5hSiKnSfVM3DaK5f5bCq1OrZevNwFJPG+ubGsqIv6eTY47xWlbBI6Vj2I6+
         ryF7rPzVWp50wrAtLkdZ2UVNRywSFIvjAp2ZKkEJaOvmY+QsPTyz8+3eUrqV047pTXKC
         m3pw==
X-Gm-Message-State: AFqh2kpJS0DY1ndnCC5WHiJWOiMaYpiv8Up6sugxgLzgCAKXaXalzdXB
        Xcre6ygdpmjTcnI9UHcDhXugLw==
X-Google-Smtp-Source: AMrXdXsLpWlWqOEF+eN4NMnfrxYYqZ2EM5TLt8TAFqfbhUq/UQouWDTLf0ANVSWUWm1Z1WB6NIsMbQ==
X-Received: by 2002:a17:902:aa8f:b0:189:e55d:ec72 with SMTP id d15-20020a170902aa8f00b00189e55dec72mr51873694plr.20.1672961683913;
        Thu, 05 Jan 2023 15:34:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ab8f00b001769206a766sm26314836plr.307.2023.01.05.15.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 15:34:43 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:34:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ethtool: Replace 0-length array with flexible array
Message-ID: <202301051534.D850BE8734@keescook>
References: <20230105214126.never.757-kees@kernel.org>
 <20230105152731.44d4cbfb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105152731.44d4cbfb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 03:27:31PM -0800, Jakub Kicinski wrote:
> On Thu,  5 Jan 2023 13:41:34 -0800 Kees Cook wrote:
> > Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> > "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> > using -fstrict-flex-arrays=3:
> 
> You gotta CC netdev to get it into patchwork etc.

Oops, thanks. I'm not sure how that went missing. v2 sent.

-- 
Kees Cook
