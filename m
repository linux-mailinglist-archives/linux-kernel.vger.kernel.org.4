Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE03F72344D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjFFBEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjFFBEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:04:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7367113
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 18:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 635A462BB4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A872BC433EF;
        Tue,  6 Jun 2023 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686013458;
        bh=r3Gwz3uXuL11j2qCuQ3fB6IOkg5vQV9Hv0Qe6Pfl7W8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vNtMq2mjj96fX8Po7xrYRi7yWOG2vBfijGSFP62ba+Do9QRUm+aHAkp0vitsFuD4n
         mSTCZvbBg5edjlH89OXNjDKM1a0Hy0KhjcKKS8/LiM+zQDVe+OhbrCu+FkeS3gDlVa
         yEgPZVBd+Gg8V0v3wZJg5l6VCB5CyWRUOFrhglIdUF2hCedBCS25yW40JmZS48jix+
         f7KzKfiMMx/KaJcUXLdd3p9XZZseaJJHMi6Eycdd4fM1PIDaFDkXJYgPymYoC1KJn3
         txN4FqcctBrY+S19GDjB7Tifc5I+OalIlDTegoKOoxvcvW/IpdWMsH7O+3uZIQTMen
         AKHgzyIGu1CjA==
Message-ID: <c71460d5-5d4a-e614-ddd5-3f708fd01011@kernel.org>
Date:   Tue, 6 Jun 2023 09:04:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: remove power-of-two limitation of
 zoned device
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20230531175214.3561692-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230531175214.3561692-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/1 1:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Remove power-of-two limitation for zoned device, since zoned devices
> don't have it.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
