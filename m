Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6554769410E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjBMJ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBMJZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:25:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB815C8D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:25:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76B8FB80E15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F7AC433A7;
        Mon, 13 Feb 2023 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676280310;
        bh=VnuDtpouDgwVlLpnixSYPUGpmwgIa3hlM9urXtzlhvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cRNuUwUcjQDnPdZQD2RIdYo4Yr0z57XZwJhizae7btX0J9GC1zhxjjR4tfcNfVYet
         qfXMe36aMspV4xTrWlWAd7iKeV1BGGPFAlTdetowW6mufHflCDDpbJYpm3swDixG1i
         PyCyI9PG4tgTG0fr/VrocRGgZDWTnqbDGz0XTyvDm6JnnvqB9NWg3LIvQnX6mWHVv9
         blRK4T6NExG9/er6CBkJ/pMrI0MLxtSOg5o4zPD2bEazKrpyt6KKdfJbNb2f2QepHa
         yAn+fJ7qP7PsJbAyXQqmdFvMKrrj8Qn0I87GWCxVvn+8i8ulICItLQE+LC8nkAkFpf
         QYLZMhaQwmsFg==
Message-ID: <cc338b66-f0f5-d9b7-81d3-b15bccc9d463@kernel.org>
Date:   Mon, 13 Feb 2023 17:25:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] f2fs: make kobj_type structures constant
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230209-kobj_type-f2fs-v1-1-b6feedbdd4a8@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/9 11:20, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
