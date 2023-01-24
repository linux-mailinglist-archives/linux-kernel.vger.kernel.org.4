Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7061B679037
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjAXFpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjAXFps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:45:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2ED3BDB9;
        Mon, 23 Jan 2023 21:45:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC5B6B81061;
        Tue, 24 Jan 2023 05:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D010C4339E;
        Tue, 24 Jan 2023 05:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674539102;
        bh=ScyvuQegV5fO5JfKO+uV9dbs09GznxoP8p2RacsRoQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aieViE0VmzSNNzQQLemLOpdylwN3jL7h9CPVewNebScLHhnL6HbDltpq7BhXWJJvL
         LXfTknZc9hhbCzA5B46rD3D5TN51FTYw+ytSFgSdInkHjI2g8VtiYcPbPTXhm+OxHU
         DD5mlN7P8/CCSHzUj5k4rZYLrpbTCxIxHyVbvSs2YdwMidEkmVZimrZgISpBkSCrfn
         4ilHh3eV0pBTOe0dZSE2a09NlORVhdAvHRneo1OrNwNlv3MqPNTdhGj1dxNpvyMr4v
         11v+OCkvfU2AAAxr8lg7mwMHgpY1AgeGNiYA8FQT2SWO6eKTvIkQmM4kaOGL37Vse3
         P0x5P4osYN0Yw==
Date:   Tue, 24 Jan 2023 14:44:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V1] bootconfig: Increase max nodes of bootconfig from
 1024 to 8192 for DCC support
Message-Id: <20230124144457.00fb60b872c701d70808215e@kernel.org>
In-Reply-To: <1674536682-18404-1-git-send-email-quic_schowdhu@quicinc.com>
References: <1674536682-18404-1-git-send-email-quic_schowdhu@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 10:34:42 +0530
Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:

> The Data Capture and Compare(DCC) is a debugging tool that uses the bootconfig
> for configuring the register values during boot-time. Increase the max nodes
> supported by bootconfig to cater to the requirements of the Data Capture and
> Compare Driver.

Thanks, this looks good to me :)

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  include/linux/bootconfig.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index 1611f9d..ca73940 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -59,7 +59,7 @@ struct xbc_node {
>  /* Maximum size of boot config is 32KB - 1 */
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
