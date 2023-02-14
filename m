Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FD86955F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBNB2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBNB2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:28:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10808CA16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 17:28:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A22A061370
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0794FC433EF;
        Tue, 14 Feb 2023 01:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676338122;
        bh=jm9YyOWT4bqZelfFgkVGCaz0lc5SMubRRyouq/SgH58=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uXSy/FtW7WIassgQj2aKleR3goACFpS/HdCZJ/ghRbvYLkYmVKTLrVF/LJBynxeHt
         HTEihAF5mgin6CbKBb6hRM2pTa75BkZMs53HaniK2RPHwarxWcSzpVKNCRZo2bU3bv
         kz6HiuNA8lpcjyDylytK1J37btCPrv8JSp4sk8vju5fBbw0MJpA81cawGx6EPAuZC1
         DhZDIRQY60ShTV1hHS5wsYo0Gd0TFo5jYFAFhx7dN2NF9emEsukE5QsYNeob1SIOXs
         fFcUK8erUTqj7+V3MQ6voajo5Q+yJ6enk01zhuU1jKSE6KeP2f3452z/AlVnpftYPX
         RZDRd4VOYM96A==
Message-ID: <089f35d1-4516-a47d-222d-fc7b86330272@kernel.org>
Date:   Tue, 14 Feb 2023 09:28:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 1/2] f2fs: export ipu policy in debugfs
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230213141825.22858-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230213141825.22858-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/13 22:18, Yangtao Li wrote:
> Export ipu_policy as a string in debugfs for better readability and
> it can help us better understand some strategies of the file system.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
