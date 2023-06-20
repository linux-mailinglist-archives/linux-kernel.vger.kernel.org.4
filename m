Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39173736EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjFTOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjFTOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031795;
        Tue, 20 Jun 2023 07:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C5ED61268;
        Tue, 20 Jun 2023 14:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AB7C433C8;
        Tue, 20 Jun 2023 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687272259;
        bh=yL5DA14mFoSGL/VWFKbyx+Ms2m3EKZwSgE456FUefno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ta9sRsXh8kHjCemjTOrXqHrUQw/sfNjh9qO12rTscw1/NhbLn4mEURrOMnq0NTlqw
         GLpJM0zPjbzBwsi8020Hmj64FaxkfQtYGXAz+CMU4O4SCdKEN83wV9+eoY4YUM8OpA
         vuESOZVDU+CqssneVu9Qn6OT9HywN7dlnPRnXHuPvp9smEE+SqQzHF+DvQG9tJMvVe
         GsHO6NcyEHBXyE0DvQfZr6qfIO8Pj/dy2fpc8gW/ZGxk2Ttj0T+bPbExYtKJ86T9nA
         P0+x2zsFPBCzGQY83SsYMoQWjPXgywmVkduI7J7RyI6VT4jKyAvhIcI2/MPhvREIyx
         csEuuSdgIYnXw==
Date:   Tue, 20 Jun 2023 10:44:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Steve French <stfrench@microsoft.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>, pc@cjr.nz, pc@manguebit.com,
        ematsumiya@suse.de, lsahlber@redhat.com, sprasad@microsoft.com,
        vl@samba.org, metze@samba.org
Subject: Re: [PATCH AUTOSEL 6.1 07/16] smb3: missing null check in
 SMB2_change_notify
Message-ID: <ZJG7QRnLpnA17OVU@sashalap>
References: <20230615113816.649135-1-sashal@kernel.org>
 <20230615113816.649135-7-sashal@kernel.org>
 <ZIy6cGtTFLZ5emr3@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZIy6cGtTFLZ5emr3@duo.ucw.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:39:28PM +0200, Pavel Machek wrote:
>Hi!
>
>> From: Steve French <stfrench@microsoft.com>
>>
>> [ Upstream commit b535cc796a4b4942cd189652588e8d37c1f5925a ]
>>
>> If plen is null when passed in, we only checked for null
>> in one of the two places where it could be used. Although
>> plen is always valid (not null) for current callers of the
>> SMB2_change_notify function, this change makes it more consistent.
>
>Changelog explains problem can not happen, so... is this important
>enough to backport?

Have you confirmed whether it's indeed the case on all the trees we
support?

-- 
Thanks,
Sasha
