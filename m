Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D172D726
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238715AbjFMBwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjFMBwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F398
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F347F63060
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3444DC433EF;
        Tue, 13 Jun 2023 01:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686621136;
        bh=EKQf9AUcQkPpeKpp8S2CTMWBdQam6LzX/JCZk9FnDZk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q9ljurLQy5R/F040JQA3pUPEN3VOulN7aVTGlIXAvs27kNkZdSLIvxq2HTDo6eOoy
         w37s8Uk9+9KeyqG/EkXtifnZiphSigiBy9i2hVs1e3iMkJppdD/Vt6rySor/b9Zd4l
         BxXwt4BTY2gdzdsh5hnmZ+6fwK2zgHoI//fLRvb17dkF/XsQW5tzTP0k5xlz8rRqll
         Rj7cDJPYVmCvXpp2tbe6YFP9XXRpKRrAkQZNTlwaOwS4y/FztpciwCGBgeh+Rcc+h5
         g23SW2+VkUWwJmViu665/vSB6JxsjrNwnPrVeSSCwnxMTvaA9G1KVYrhs/9wsbn+fL
         ViNs4pJoBOTxQ==
Message-ID: <974680a9-ffcb-1290-80a6-c4791ec988c0@kernel.org>
Date:   Tue, 13 Jun 2023 09:52:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 3/6] f2fs: add helper to get inode chksum from inode
 page
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org
References: <20230612030121.2393541-1-shengyong@oppo.com>
 <20230612030121.2393541-4-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230612030121.2393541-4-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
