Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02E06F0389
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbjD0JlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243235AbjD0JlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87F11BF3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4034C63C12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98685C433D2;
        Thu, 27 Apr 2023 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682588476;
        bh=125u3tejLNQJF6kLDB/UavqRQ6HJYDcAsZo9N4ED0EU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lz9bLlPFKGR3jYl/Cwqy8ldlc7wA21wcKS+5oQGFK1XphjkebhNZTqbWxMfTfDdPj
         LNBK5XUnc6lRfTSyKhZwyGHskrzj+BoqElDDDzKGrTAJXBTi8W8YAL1wYamQYBK8Mx
         UPfDoJmGcgAoZepIT43nl+aklwhqxFQ+4Y365UbsJEBxKr2vxfMQXDbCmntX4zoadI
         /L+YAp0IJD/2Qjrlo6T6DHIAffWIh1eOsNvn9ajGPX8e50n5I67yT64kIg/9SlfWxK
         siDlNt8ygwRiXHnEvhtxwztYzNe6LpFaj4q8s8cC19vSRqGYigZKmIArmbr9qlt+nr
         6m6Q26iIzRNzQ==
Message-ID: <444a931b-1122-c4b5-52eb-f45ed146f05b@kernel.org>
Date:   Thu, 27 Apr 2023 17:41:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] f2fs: add sanity check for proc_mkdir
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230425160611.79848-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230425160611.79848-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/26 0:06, Yangtao Li wrote:
> Return -ENOMEM when proc_mkdir failed.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
