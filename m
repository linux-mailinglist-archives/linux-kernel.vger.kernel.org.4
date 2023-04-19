Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B646E7111
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjDSCQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjDSCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:16:57 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3609D2681;
        Tue, 18 Apr 2023 19:16:53 -0700 (PDT)
Message-ID: <03d46708ca8adaf2fe98689e04c98541.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1681870610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwuO365E3uWJjHSCA6WvcUrrebXU0puVdAVof+NAIBk=;
        b=prf48IjvaTQG15ExjQ/iMTOUBexRi1XKhmRMZWqjIfwDnPeBw5B81xfseexaew9Q1TfKtv
        eZ7CljqWYTnugydnfn9aUtYvvl4dW7wIIMUqgg8FUbfW/POzf1ryjQVdJv/hyQTNM63Ag6
        ygygP9aIImvP6OGEv2/oykEvw1zfpSozjFkrMzbjkPxkqkLXg8N6E6P2Kr3QvwyiksAk04
        UBDW0NpTKc2dSAk8v6Tb1Gy5gadJbU92BgsZB35Ha+IiknBdwXWO4hq6aclO4eMZP97hvS
        IYmnhZvSmxbclMK9UxJDPCsoS0j2j/1iVwaby70TV941cWK4HmWrs68ouhQuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1681870610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xwuO365E3uWJjHSCA6WvcUrrebXU0puVdAVof+NAIBk=;
        b=CuhbOYftU+3lzams5OIgKou8sm6usykvy8iEAiiO0vhMDTt40Tb+feXmEV3jyMFTNwm2Zi
        rN0tcEhXYzdcBGbXc8P8Ug+KR2iqjVIY+noKPYBvEO2A+71B/uowYCBCfTBTsVpKuM5a9D
        cCCpF1OwGULVDgT3Y3ti78l9gFJ3643mL27/8Ym/sAMeEBFuUaOJ/bylZKD/j5Vb16rz7U
        zWp2BefO4C/kFClXizk/HLhmTPPIPjQ6xubcRRhjMOD/fzCyq8nKeyDnKx8FZlYvw1T41e
        eb4RAQXYRqtsI3Zv7zvSpnKWQAjtnPpSoyTpcZAqVcPJKEmcphOR0ThdaHYHww==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1681870610; a=rsa-sha256;
        cv=none;
        b=izNevIs0sGaspWAvKtlZKGm8XHoRXRhjpwxfC36SVd//nNpIKJlJoUrHAeapwgyQRFjwe0
        Itnk5ePF+56GcN6KX9YTvzM93EDVCnIzUiKlvn5QZTSO25tcr3XTNvOiA6CLRMdeayYoDJ
        3JYPFWXWqhjYAuQtRMSEizFY/t+CY0MAvLmevReQvXBIDUUMPY7jz7f92FSu+4FhYMWwbs
        8RYspDbxN5vmhXiAJ/yxQwD3hafu49ledalfHUg+4EiK+sOVVzKC3OVZyU2fKUpQVLHiwj
        UXiwn7LTGgNwMMrLRngmF26yVWrATDyzKu6NoHGEILMYssC5yzG51ArwZ7PH3A==
From:   Paulo Alcantara <pc@manguebit.com>
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     dhowells@redhat.com,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Long Li <longli@microsoft.com>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix unbuffered read
In-Reply-To: <1692048.1681857607@warthog.procyon.org.uk>
References: <1692048.1681857607@warthog.procyon.org.uk>
Date:   Tue, 18 Apr 2023 23:16:45 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> If read() is done in an unbuffered manner, such that, say,
> cifs_strict_readv() goes through cifs_user_readv() and thence
> __cifs_readv(), it doesn't recognise the EOF and keeps indicating to
> userspace that it returning full buffers of data.
>
> This is due to ctx->iter being advanced in cifs_send_async_read() as the
> buffer is split up amongst a number of rdata objects.  The iterator count
> is then used in collect_uncached_read_data() in the non-DIO case to set t=
he
> total length read - and thus the return value of sys_read().  But since t=
he
> iterator normally gets used up completely during splitting, ctx->total_len
> gets overridden to the full amount.
>
> However, prior to that in collect_uncached_read_data(), we've gone through
> the list of rdatas and added up the amount of data we actually received
> (which we then throw away).
>
> Fix this by removing the bit that overrides the amount read in the non-DIO
> case and just going with the total added up in the aforementioned loop.
>
> This was observed by mounting a cifs share with multiple channels, e.g.:
>
> 	mount //192.168.6.1/test /test/ -o user=3Dshares,pass=3D...,max_channels=
=3D6
>
> and then reading a 1MiB file on the share:
>
> 	strace cat /xfstest.test/1M  >/dev/null
>
> Through strace, the same data can be seen being read again and again.
>=20=20=20=20=20
> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rathe=
r than a page list")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> cc: Long Li <longli@microsoft.com>
> cc: Enzo Matsumiya <ematsumiya@suse.de>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> ---
>  fs/cifs/file.c |    4 ----
>  1 file changed, 4 deletions(-)

Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
