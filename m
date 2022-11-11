Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617E862581F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiKKKWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiKKKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:21:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FC212A8B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:20:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0425961F35
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675EEC433C1;
        Fri, 11 Nov 2022 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668162037;
        bh=MvaSTrv8RylylSx6mbqhSZIIc1HuqTr7XT/FG/ZSMW8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kT/w/4Q+34VkdaAvV7KrYgVdkPtC17P0sf0XsFpEsa7mf3lSDrIKvH7LzbAUASfWO
         Ed3e/CkyFJYR2QbRA7UYDjFbFiTH8M/fWcdCwumGUK/O+YJuwJetbMqwCD1h9Dclu3
         rOamB5vuONEBB3gON7gMQMtYsRYtK1+MMqVWVcQjbQ3cMxvTjL3ZrTLdcjw8WKxsMC
         EL582gRwbpf8HnurENxT14/YVX9uTWBp/m/vdHK86OUWo946XyqmujBarlPCOZ6ZCL
         aH9k1N9kwisWnyv8E/4n4m7acsO0NJeEEQVcXd48gCCuc3TWkNIRWZ+ZwuGnqSUIpC
         f1djglQ4lgk6w==
Message-ID: <28030a50-b3e9-e361-ad32-ca26d4756063@kernel.org>
Date:   Fri, 11 Nov 2022 18:20:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/2] f2fs: move set_file_temperature into
 f2fs_new_inode
Content-Language: en-US
To:     Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221111100830.953733-1-shengyong@oppo.com>
 <20221111100830.953733-2-shengyong@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221111100830.953733-2-shengyong@oppo.com>
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

On 2022/11/11 18:08, Sheng Yong wrote:
> Since the file name has already passed to f2fs_new_inode(), let's
> move set_file_temperature() into f2fs_new_inode().
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
