Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6911460C956
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiJYKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiJYKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:03:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C524C01F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:57:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF02FB81CA8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A675C433D6;
        Tue, 25 Oct 2022 09:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666691865;
        bh=VjDlq0AaoBymNcBx1nVzZmGo9amGo5mxHdD1e4npnZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kRTqgiTcCvphUEJlaXiGnv8IYg/g46ExcavLmLfuOO82trBAyeUtLL8n9tHMy8gkH
         Bd2/HxYecRMmTK6yptl7UguxMgaMi1pXMGU5P7SIIuD5iTsmIc6IFS1E88/yMuCrCa
         9GBfKqukCn+nmyBksfQeR8FnBAQRVhmDXtVXsco3dDqeARAPjjx+bEY51MwNDWc7Go
         tjFMxjtAHNca6pXkf2i9roQDj0kJz6hcgtoQjH99P1GsoPIJdHgIhriyNJGF7Nr+nn
         Fg4DRL8s35i7Ew6Z1NJdTP6VEXO1ZnRmsqS8zcFHAxsx95mwQo4puKdKl8EA7BcJu7
         vRS9NcLl9J6Ew==
Message-ID: <9f654a98-8833-8546-5c03-9814aea86995@kernel.org>
Date:   Tue, 25 Oct 2022 17:57:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3] f2fs: cleanup in f2fs_create_flush_cmd_control()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221025080526.9331-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221025080526.9331-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/25 16:05, Yangtao Li wrote:
> Just cleanup for readable, no functional changes.
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
