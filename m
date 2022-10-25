Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A8960C396
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJYGDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJYGDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:03:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412FE105CEC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 23:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5298B81A6B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D688C433C1;
        Tue, 25 Oct 2022 06:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666677798;
        bh=VjooGWrvIG8ReDXfvIhQuOnTWhKI2n0HmhUzZot1ahw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TPktgCjJIjwm9FO3O58SW7xbMojD8GVaT9P4buRRw6wBODSV7lz/1qk2T20svq4ba
         dMPmXnogy8w8kaCfwT5D3947reVtUT3G/Iz+qz18Eke/n9OXzZzkP6++uy6kvE9/5o
         Day31pNOXxFiMgDKSA6fmkFqtS3nbJAoI/mCANDXcxQ1fx30sUanX59MWMKPXqroGP
         /7BnW8SmdJmh+97U/edvN5mks0EBUDithXrXe8bP4oZL4obZBbmG889rMoIh1Iqa6H
         7eJbFiKXSLYx1UEQEDDpPqZzbQY7TdmERgL80QK58KiwFFnvHSZepONcgNWiSJIvvC
         XEbT8qzqG3C7Q==
Message-ID: <eaae3f50-1859-ae9c-addd-51731ccf076a@kernel.org>
Date:   Tue, 25 Oct 2022 14:03:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] f2fs: remove batched_trim_sections node
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221025030831.53888-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221025030831.53888-1-frank.li@vivo.com>
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

On 2022/10/25 11:08, Yangtao Li wrote:
> commit 377224c47118("f2fs: don't split checkpoint in fstrim") obsolete
> batch mode and related sysfs entry.
> 
> Since this testing sysfs node has been deprecated for a long time, let's
> remove it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
