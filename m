Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2166BFDB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjAPNeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjAPNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:34:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755261D926;
        Mon, 16 Jan 2023 05:34:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C6D5B80E71;
        Mon, 16 Jan 2023 13:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD114C433EF;
        Mon, 16 Jan 2023 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673876041;
        bh=+BeVk5ADMRX/LgEN+27hKwVSaaKOD/XwA1InAi7XTlQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BR/SMW3+VFdDJASlL/TTomGv66SCHXj11SBfga4wH5qpQNujzUuFfQtp2FGArN6t5
         szurM81Yn3DMCbo6am9VlBUrRNr96ScDg6+/joWZvVb77MG30r/T0O89YJ6RSk0v0a
         elnHFe8pD0CvrQSP+pSc2KN4/l2PGb+NBiT3ZpaJ85PP3hxiJ6XbuJlEgc7um28uSy
         w/o5SULkORUnzEKtV+R6xwMtXuYP+izgvw1RUG8RJhRWFE0Gn5Sg6BIHXNck1/zXn8
         f6zi4PZvArv4tu3X+cbSP0N7ax9V8NMUe5GpearHo80Gq3RPlPREnbYpe4SXl0GEA1
         uZKfTQVKKQXeg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw89: Fix a typo in debug message
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221223102058.162179-1-standby24x7@gmail.com>
References: <20221223102058.162179-1-standby24x7@gmail.com>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, pkshih@realtek.com,
        linux-wireless@vger.kernel.org,
        Masanari Iida <standby24x7@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167387603739.32134.16325882268156516097.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 13:34:00 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fixes a spelling typo in debug message.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

e20c9f656654 wifi: rtw89: Fix a typo in debug message

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221223102058.162179-1-standby24x7@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

