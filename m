Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C4D72D71E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbjFMBtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238478AbjFMBsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:48:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11081715
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4129161228
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC5BC433EF;
        Tue, 13 Jun 2023 01:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686620917;
        bh=EKQf9AUcQkPpeKpp8S2CTMWBdQam6LzX/JCZk9FnDZk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KiV3xtRZV0GXj6BNuY4NmZT1iAHoKUDUnds4QJ9EBrd8SJKxe8suc3kBx+SCAkaU8
         WZRm1tCZe5p9yALQvBObgaSkTwf+rq1kSEfO/KNzp9Z8xxDDTSf6d44jJVczRZtouU
         fIClli0cXVb3z91YnrBHbfRtkUfw10BI+tH9R1J9ztk7pXHNqrJfrvCOL7y4QActvF
         H61o1F3cU9f/9oRVgELIqFkCDVtfzPCzTA6I7FXQ2y7xWY+wN5ZPfWXeAbWlEX6q6J
         jaM8mmdWLmPvpEIUJB4p/4K/Fmt9jmuyIa2ks/sYtI+v2H5mqsoN+QUPpQhxbbMGCl
         sUaZBnXT3/Ocw==
Message-ID: <45faec38-aeaf-d89e-4542-e87e5edc049a@kernel.org>
Date:   Tue, 13 Jun 2023 09:48:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 2/6] f2fs: cleanup MIN_INLINE_XATTR_SIZE
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
References: <20230612030121.2393541-1-shengyong@oppo.com>
 <20230612030121.2393541-3-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230612030121.2393541-3-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/12 11:01, Sheng Yong wrote:
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
