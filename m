Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2806C541C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCVSvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVSvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:51:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183BD5F202;
        Wed, 22 Mar 2023 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=8gnV16b2sLU+6b0caYswgVJPdT7uNZgrISRUOsr2Qe0=; b=QY1O9GHLPhYxeZOf4XKMs57h8Z
        dNLvlJ9x1di0suXSCfJIc1XWwLqJvYUKlNvFQyVQOZ0utwjxe8gsx0SR5CfQ8QSvMQYaOIn1nAyWS
        0MoYILoY/O5oYcwqRaV6GNe8mR7C3nXeWM//yvk3w5OoKYQRE6BDAnfJ7SFzn81BRTT/+WVxARyCb
        PEX8i5RTRSHLv86xVM9OcLQGj30SD+dUb8t+mdCVXKEJe+T3vTVsqPFSpjEef6wCLKoz/Bnw1ZEU4
        /WWWHrUccUswLIBxnLdAeQCLHvjnx3rj5dkbFApPQ9dr9j0Q3DWCMXYeeL9ZiylUdvP4AcBaBgfms
        xXo3JjXg==;
Received: from [2601:1c2:980:9ec0::21b4]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pf3Xy-00H4j9-0w;
        Wed, 22 Mar 2023 18:50:54 +0000
Message-ID: <c5db0099-a7fd-8f1c-16ad-8388d3cf6a05@infradead.org>
Date:   Wed, 22 Mar 2023 11:50:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] of: fix htmldocs build warnings
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
 <20230310113258.463f836c@canb.auug.org.au>
 <20230322180032.1badd132@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230322180032.1badd132@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/23 00:00, Stephen Rothwell wrote:
> Fix these htmldoc build warnings:
> 
> include/linux/of.h:115: warning: cannot understand function prototype: 'const struct kobj_type of_node_ktype; '
> include/linux/of.h:118: warning: Excess function parameter 'phandle_name' description in 'of_node_init'
> 
> Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node creation functions")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/of.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Replaces "[PATCH] of: fix htmldocs build warning" and additionally
> fixes the new warning about phandle that Randy reported.
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 9b7a99499ef3..d55dab9ad728 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -100,10 +100,12 @@ struct of_reconfig_data {
>  	struct property		*old_prop;
>  };
>  
> +extern const struct kobj_type of_node_ktype;
> +extern const struct fwnode_operations of_fwnode_ops;
> +
>  /**
>   * of_node_init - initialize a devicetree node
>   * @node: Pointer to device node that has been created by kzalloc()
> - * @phandle_name: Name of property holding a phandle value
>   *
>   * On return the device_node refcount is set to one.  Use of_node_put()
>   * on @node when done to free the memory allocated for it.  If the node
> @@ -111,9 +113,6 @@ struct of_reconfig_data {
>   * whether to free the memory will be done by node->release(), which is
>   * of_node_release().
>   */
> -/* initialize a node */
> -extern const struct kobj_type of_node_ktype;
> -extern const struct fwnode_operations of_fwnode_ops;
>  static inline void of_node_init(struct device_node *node)
>  {
>  #if defined(CONFIG_OF_KOBJ)

-- 
~Randy
