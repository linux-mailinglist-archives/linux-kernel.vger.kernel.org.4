Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090616522B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiLTOeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiLTOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:33:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832201903F;
        Tue, 20 Dec 2022 06:33:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D10EB815D7;
        Tue, 20 Dec 2022 14:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0BBC433D2;
        Tue, 20 Dec 2022 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671546827;
        bh=0U6gLEZ1YHjHIZNoK6k1noV8t4YWfSb4o6Pg9YVcIOo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=SYPHtgYtgQs8Js2Ckg9neth0T3LOMELzxa0sTEx/Rkn/4VzIC3H5iCDafwmTdEfvq
         +NpotLCkq9YyeRXExowRozZl9daAWopJbnFFs3Ok5yzQwgiGG3Oc0fRsYqgE15j4bS
         8HuFWbe5Fw/6byPs3S5IOENt4hbCnj6qO6wzKQVHae5KQtJmRo968fTe//lMBUHRZX
         8QcilyhUzHLj43LZ6R/rfgC775N/cJXHIO2CEXdAa5yyXb0mUKERB5h4ym/Xd0oHAc
         zwQsQzobVvEM27gwWcOrfU7AJyXE8tJydu5Rzw7p8pLwHu8tSghQlcWNx3fTfxy60b
         s6rOdLdYwWZuA==
Date:   Tue, 20 Dec 2022 15:33:48 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioannis Iliopoulos <jxftw2424@gmail.com>
Subject: Re: [PATCH] HID: Ignore HP Envy x360 eu0009nv stylus battery
In-Reply-To: <20221124174932.6105-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2212201533380.9000@cbobk.fhfr.pm>
References: <20221124174932.6105-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022, José Expósito wrote:

> Battery status is reported for the HP Envy x360 eu0009nv stylus even
> though it does not have battery.
> 
> Prevent it from always reporting the battery as low (1%).
> 
> Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/823
> Reported-by: Ioannis Iliopoulos <jxftw2424@gmail.com>
> Tested-by: Ioannis Iliopoulos <jxftw2424@gmail.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Applied, thanks José.

-- 
Jiri Kosina
SUSE Labs

