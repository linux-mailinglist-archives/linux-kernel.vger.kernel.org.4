Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1862B087
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKPB1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiKPB1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:27:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B172A73F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:27:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5DF0B818C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68951C433C1;
        Wed, 16 Nov 2022 01:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668562022;
        bh=Y3uxS6iMsv3XE43b4DvFFElMclDXzniG3rvb2AlsUYU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dnnbEARC5arfUp13mQbauvQRDw+dQy8zu7W74a0kMJ+VTiVAY0B1X12SNpjwwp1S6
         Kn6kgVLEGavkkA7L6nru/FmfGfe841E4xCUw6AxcffcikNGb3jgIcg9M5NUJ0DOgp9
         9RnhlTHdbMeqsexJRxlyHDbTjxO8ybNhjPG2gF4Zjh+s8hj6sX0aLxBcu3EGRRZfve
         svRVhqh/KpnDsccVowTe1uZay+YoHZCLxmsYgaEc+3ws2of8GDbGSNUtc5Gm8XuYQ2
         RmZh8Hk/xiTSsSL2ahdZ/jBWp7KHZINfmqqJfzkBIAACMiHqJWrNhkjIoU/YPkKwrF
         EHXuT+GDCHr+w==
Message-ID: <9736c882-b2b2-3479-270b-bb8f49a75b61@kernel.org>
Date:   Wed, 16 Nov 2022 09:26:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/3] f2fs: cleanup for 'f2fs_tuning_parameters'
 function
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
 <20221115063537.59023-3-Yuwei.Guan@zeekrlife.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221115063537.59023-3-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/15 14:35, Yuwei Guan wrote:
> A cleanup patch for 'f2fs_tuning_parameters' function.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
