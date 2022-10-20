Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64043605B76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJTJsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiJTJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298001905C9;
        Thu, 20 Oct 2022 02:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A506D61A97;
        Thu, 20 Oct 2022 09:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D35C433C1;
        Thu, 20 Oct 2022 09:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666259311;
        bh=EWg2c2AgwAaw/YZy71aIoNZJWUST4zAX/8vc4OFM3cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPpgP4zYanx0koPMPzn/bmuFTdSS5wUdIsSKLUmdT5wQmL6MJe63tet5x1LyJsJIL
         KsD4UCbUtjWrmKjyd6a8wOUnn8DEuQD11zDXTXm/P+NGBtjXx66h9sClWZzS+Ina2b
         JlkCCG4VkVNpYyLvxAnmXqxfn4eMJx7uW4f3TMzw=
Date:   Thu, 20 Oct 2022 11:48:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cuijinpeng666@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] perf: Use strscpy() instead of strlcpy()
Message-ID: <Y1EZbJGoIFY2NX1V@kroah.com>
References: <20221020085411.398450-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020085411.398450-1-cui.jinpeng2@zte.com.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 08:54:11AM +0000, cuijinpeng666@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> ---

Please ignore based on this response:
	https://lore.kernel.org/r/Y1EVnZS9BalesrC1@kroah.com
