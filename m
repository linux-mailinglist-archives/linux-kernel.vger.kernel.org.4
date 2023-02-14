Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA069674C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjBNOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjBNOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:47:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23EC2697
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:47:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B27F9B81DE0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530AEC433D2;
        Tue, 14 Feb 2023 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676386067;
        bh=0qblf0jEJnP6moGuBgThbeGRShhIJvPpcCKFDlUakRM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XgQQHoOKJZmRG0taxlLeTZIrQ91KwV70BMXkH9F+MscHmynq2u0wcLIIc3+6ENv6Q
         fy/U5gzMSAGPTwZkMMw5ZR9wncge8u647HaRXlbkIb1p5pDevUpsB/018DsFCxh211
         UEz2S/3QaX7Kzr2iV0dvQa2ovdgWtO6fel8z5c38aPSh/lXB3w++CyAFR+oZVQdWVZ
         lx/RvHV6QCeS7AFODwl51c5KsGyGhkLRh0Y11QmmMUszuofq/Hmabs+IGT0/DKkcnw
         qZyY57hKCUutL40TA2dt9FZjSNCOK/K6+9DZ+8R7+TA9idWh9QLfvbPK+59NtkDGN6
         K9Fvd/CNGqttg==
Message-ID: <29654f49-e4ff-3419-e96b-2d01caab5c71@kernel.org>
Date:   Tue, 14 Feb 2023 22:47:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: make kobj_type structures constant
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Gao Xiang <xiang@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230209-kobj_type-erofs-v1-1-078c945e2c4b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/9 11:21, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

