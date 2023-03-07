Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A86AE4D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCGPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCGPeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:34:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDBA81CC5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:34:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E99106146C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 15:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B47C433EF;
        Tue,  7 Mar 2023 15:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678203248;
        bh=Dn9EqSnkRGm4O9GvunZmjMZDcFNzVqS+z9c2o7I2WIQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=LhFZbk5Hq+Lq80Xx6oL1OxUtfcmurqh8fvDfQlqU2FYCQo7aIN7Rcgn9gXoKikTss
         jDrbbQcDOp3ebgxQF1uZAon9Pc1WPiNIeAtyDzIbmgDPJZxqOTUC6XgRf5pTIf14qV
         QfKuyFNZYC36sQ6PkXeFaPCIqge8/uAVG4mN6OM7GdKJE5xT54Pbi2EOj0RRzIUTqM
         q4BnEtU2nwAGQs2znCN0ZaGD3dcu26N5n6PXG/DseKgeuuVDDsdgP5PZ7ZWIXAd7en
         KtXjzTQ/2BziQxPSQQyjBx1c0lwTfAsSxZ/F4La1GHFaMnAtp70AvZ1q92O2qcmF7V
         en70vwv0dPBHw==
Message-ID: <fa14c118-ae41-6aee-d2dd-23730ef6a93b@kernel.org>
Date:   Tue, 7 Mar 2023 23:34:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230216135324.18406-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: convert to use bitmap API
In-Reply-To: <20230216135324.18406-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/16 21:53, Yangtao Li wrote:
> Let's use BIT() and GENMASK() instead of open it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
