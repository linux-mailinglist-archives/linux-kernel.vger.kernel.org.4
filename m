Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20058614674
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKAJPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKAJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911D01172;
        Tue,  1 Nov 2022 02:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D2DA6155D;
        Tue,  1 Nov 2022 09:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A615FC433C1;
        Tue,  1 Nov 2022 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667294127;
        bh=m0bQJCuR34eboAqGIoPZurlkpYyhyfRbDb4uAe3s1KE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kMzAqMUDaj6YD2hWi9YLS+xXF9/sg9dq2sB23L9zV675OcnmMHLEyv1DPf8BTVwN6
         unWvMhC3iJTTblMbLjjpTopMeWGdo7Cpqqdc4yRAq+zMU1o/1koYkJY3C9P/fbbawb
         GpOyR4uPq4eZpypLf7cpM9nletWcaJIS94thBKCY53asPEM7ScqovNmZi/DkZlsajl
         OstIAPREybHeHBeax3MHh2txDsoeWn4u+lHtXGqgJ34s3YMnlVib4/bnbPTapK6rvw
         iwboE01RbsRYMaFfRHI3j2fG5NZLJP3MupeWjxZaGqIwaYfClQL6CU45z9Sby671Yr
         /vc0/jwe+ohRw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: airo: do not assign -1 to unsigned char
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221024162843.535921-1-Jason@zx2c4.com>
References: <20221024162843.535921-1-Jason@zx2c4.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166729412401.15005.1682705386476857844.kvalo@kernel.org>
Date:   Tue,  1 Nov 2022 09:15:26 +0000 (UTC)
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> With char becoming unsigned by default, and with `char` alone being
> ambiguous and based on architecture, we get a warning when assigning the
> unchecked output of hex_to_bin() to that unsigned char. Mark `key` as a
> `u8`, which matches the struct's type, and then check each call to
> hex_to_bin() before casting.
> 
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Patch applied to wireless.git, thanks.

e6cb8769452e wifi: airo: do not assign -1 to unsigned char

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221024162843.535921-1-Jason@zx2c4.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

