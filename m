Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B639F5B65E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiIMC7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIMC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:59:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD34F65B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D1BEB80E13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A873C433D7;
        Tue, 13 Sep 2022 02:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663037939;
        bh=Iuuhzzq+GhRVr/IvNg5kSnLKv8rP3SeJsSTWDYFcbh0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=inEYw3f9y8DakPYxBvnlGpUl6JJckq91J5p6hIOUNDbGPw6BDpIBIHB1S+ijwegL7
         I1QmOuBrsMkJX4qolz4w3CUfzBrDZ0IDiwMfx4OpUqUBMk/9ChXu1QC3uIoQU39roK
         Az30b7douIb2pNnsZNd2eQxDyf/OH7I+n5464M9FfTM6gcZdkccEqxZEGA/AhJLJgp
         tFn8/g656rsFcHNZqYD06fJzXLL8eRFHG5uAqkYohJKSoCljaddOJVpDci5lJye0sr
         Ky8TZBMU9fg/5ZIiJs3XAtpYy+9LN3FHAykCeUJqcU0MTJ3Kpivy4a8DeWvZS6KJiv
         n03vR26zgDNhQ==
Message-ID: <934dca55-c3ec-56bb-63c4-83decd27d2f5@kernel.org>
Date:   Tue, 13 Sep 2022 10:58:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: flush pending checkpoints when
 freezing super
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220819231514.3609958-1-jaegeuk@kernel.org>
 <YwaD7mJpMLhEm5wd@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YwaD7mJpMLhEm5wd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/25 4:02, Jaegeuk Kim wrote:
> This avoids -EINVAL when trying to freeze f2fs.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
