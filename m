Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865735FAD23
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJKHA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJKHAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:00:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB74E20374;
        Tue, 11 Oct 2022 00:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xRh5EidNMM8jWX56bJG2POpLa4tTba0hWVv95MhnLA4=;
        t=1665471614; x=1666681214; b=hRLsYr8Q71169x9BSUib8BLrXqxRC4e8ZlF7xdQSpfGjA23
        6X/vYZ6SiGdyLCZDODSad8LJV/u85Q2O7cLccQ2VdJ6aNEVzbJgaSFL2+5XjJXSAfEjhToytxi0DI
        IE2VjcIaT5VwvcQAXKfeTUwahnCfZHvCTSycOSNgux/MvanRd7iejYkq3ks5YL09qysH+HliX+Kej
        1ssHjGnrAPL0fwSf0QPh6/9kf2mKNDAuVM+rySAZLbxI32T/sylhpwfDmvzmDWhJIx5UK1tK6hkwH
        xmYhHAg6BIGNnk+fUluBv0gJynwHn8logpmiyiq9+n6cGkVpVcI8VwRaljBWj8xQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oi9F0-003rPq-2O;
        Tue, 11 Oct 2022 08:59:50 +0200
Message-ID: <0d8be2bcb891a56c42760c8e955877841046458b.camel@sipsolutions.net>
Subject: Re: [fortify] 54d9469bc5:
 WARNING:at_net/wireless/wext-core.c:#wireless_send_event
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kees Cook <keescook@chromium.org>,
        kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hawkins Jiawei <yin31149@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 11 Oct 2022 08:59:49 +0200
In-Reply-To: <202210102312.1CC8197@keescook>
References: <202210110943.6f16f1ea-yujie.liu@intel.com>
         <202210102312.1CC8197@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-10 at 23:17 -0700, Kees Cook wrote:
> On Tue, Oct 11, 2022 at 11:46:21AM +0800, kernel test robot wrote:
> > commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 ("fortify: Add run-tim=
e WARN for cross-field memcpy()")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > [...]
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> > [...]
> > [   95.913726][   T36] memcpy: detected field-spanning write (size 16) =
of single field "&compat_event->pointer" at net/wireless/wext-core.c:623 (s=
ize 4)
>=20
> This was fixed with:
> e3e6e1d16a4c ("wifi: wext: use flex array destination for memcpy()")
>=20
> I expect this will land before -rc1 closes, but Johannes will know more
> about the schedule.
>=20

Yes, we're planning to send a pull request today, so that should go to
Linus with the net pull request tomorrow.

johannes
