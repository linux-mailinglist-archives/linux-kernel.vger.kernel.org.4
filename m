Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7106AE709
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCGQpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjCGQo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:44:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1C90B7C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:42:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0166AB81980
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B682EC433EF;
        Tue,  7 Mar 2023 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207298;
        bh=lLfjyQIx2kb9s8HLCQqUqaN2K7UMLPIc7fimQs2suzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZ6Q62tVh5pDMoiBigTSHZoXiZ2W7j5w39dpB4UpniDRTM0KbzzOehwV/Jx7RbvC0
         aCha8lGQ4tg7gV+yZLYhopB6YHpbnVpJUNezbHBrEqGmVWPWWHXkOau+B5t9tK9VGu
         Yl1u1s46RLCrnb8l1m9gUg02i5heN0fXUzhpr5ESdY7ALAHxOBhA0F3oGNbwIv2Q7z
         WPiS+1WBzVQA1pXf7lExMa2xe52342xXwbAfYVz7/O7yl87TEUp5zJWts2se83e5ia
         puj1bGY5mX5Nr9ZSwMx4+Bibj/R8rd7x0ijkSm7jrkAsa3waRKie/xoMhX1jWptREA
         7zD266og+7UqA==
Date:   Tue, 7 Mar 2023 17:41:34 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples/pidfd: Fix build
Message-ID: <20230307164134.ewwy6y5dsv2bjijg@wittgenstein>
References: <20230307110910.93077-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307110910.93077-1-mic@digikod.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 12:09:10PM +0100, Mickaël Salaün wrote:
> Fix a typo that made the pidfd-metadata program never build.
> 
> Fixes: 60fb0b123971 ("samples: pidfd: build sample program for target architecture")
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20230307110910.93077-1-mic@digikod.net
> ---

Thanks for catching that!
Reviewed-by: Christian Brauner <brauner@kernel.org>
