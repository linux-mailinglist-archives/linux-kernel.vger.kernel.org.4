Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6C662972
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjAIPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjAIPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:09:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBEFB94;
        Mon,  9 Jan 2023 07:09:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87ABB61165;
        Mon,  9 Jan 2023 15:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BACC433EF;
        Mon,  9 Jan 2023 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673276993;
        bh=2kIP3L1wWIjQqgSeLLlnsvTS3fRCyU9DXUFZ/TVnjuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxz94DM+mEx2aL2SgllefcbUc7VO+xh4J41AqR/r+FbyYqVKMqwZZ2k1XNXZNmb23
         ZbaRpnU4h61VM6jhwqOOQsp7sruisQfql3o8/70L7pBNPj8yT0IZ3W4SRnBCc1uX46
         z5cv7pfbwqJvVxCx/s9qIYu0gfp5SgEQILukmYtqdxtaOGB9frtlbn1cfeiRyVQxGD
         NpHWSNa2NiTKHTbzhIkUO0dlUe6RMGPfRe/NZBF/FS9q0D1WDHPo5++nmH2AsA8OPk
         xfeQRB7xdu35KElolRlRAzO/uhokgXBRg4EHUDq3TazpJ0eg7bR0RV1nRQn7MT4glP
         MrTfwII91QT9w==
Date:   Mon, 9 Jan 2023 09:09:51 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V0 1/1] bootconfig: Increase max size of bootconfig from
 32 KB to 256 KB for DCC support
Message-ID: <20230109150951.ikdlkr6lmiapesmu@builder.lan>
References: <cover.1673261071.git.quic_schowdhu@quicinc.com>
 <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:01:05PM +0530, Souradeep Chowdhury wrote:
> Increasing the memory size of bootconfig to be able to handle a max number of
> 8192 nodes to be fitted in memory size of 256KB.
> 

This states what the patch does, but not why.

The description you put in the cover letter does capture the why, but
the cover-letter won't be part of the git history (and if it was,
there's no reason to keep the motivation separate from the change). So
please move the motivation into the commit message.

Also, there's generally no reason to have a cover-letter for a
single patch "series". So please skip the --cover-letter.

Regards,
Bjorn

> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  include/linux/bootconfig.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index 1611f9d..64d233b 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -55,11 +55,11 @@ struct xbc_node {
>  } __attribute__ ((__packed__));
>  
>  #define XBC_KEY		0
> -#define XBC_VALUE	(1 << 15)
> -/* Maximum size of boot config is 32KB - 1 */
> +#define XBC_VALUE	(1 << 18)
> +/* Maximum size of boot config is 256KB - 1 */
>  #define XBC_DATA_MAX	(XBC_VALUE - 1)
>  
> -#define XBC_NODE_MAX	1024
> +#define XBC_NODE_MAX	8192
>  #define XBC_KEYLEN_MAX	256
>  #define XBC_DEPTH_MAX	16
>  
> -- 
> 2.7.4
> 
