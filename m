Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5A6484F1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLIPXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiLIPWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:22:55 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C92BC0C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:22:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670599341; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=cxmKipMp6SYO/LcHtw1yx8o9hDdhtm94Ju1EQ6Ss/yZywEWpZduCBV9dfx8UzUy2wgQFRaRtnD9CCV+K80AOnLJamGQ2vzPzk1GbPtBaEv0EeOPNxProTCXQLim0koxDmLxX90DhDo8nGX1WAazkCncOajlEC3IWxGp02ngaqB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1670599341; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6JPEYvBFFf3frgLUC1Ir8L8ve0YtqwwoZbm6TNaJ1fI=; 
        b=dMqA55gQ9O/7w/4TlhmIZqMI3Ci5TlNtthgPBxJnk9QiZWStc8wwB9y0/m8ql6+U3gbgB0KenQjxkKQxbKVEzn4AYAmREQX5vBxMi8iup/7EdST3MX+eJMsM5+nQY/DKGiEpM8jljNvWPBbY2HeQB6y5+sT3EgCv7PA//AnUPHs=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670599341;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=6JPEYvBFFf3frgLUC1Ir8L8ve0YtqwwoZbm6TNaJ1fI=;
        b=FaLFXGicv7TwQVH+oouXgYrIkpnBsOJEcZjE3nof1/IvXehEnxxILiA1AnoxpyV4
        hctCv30YzcsT3mj2zJcc/UOkdv1/FphH3MFkDBOU7Gf4D6fA90gi4F68OwJvSRkk4ue
        QdQCJpRTbOcgZzJR9nDy+REjln8TmonL9SEPIIK0=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1670599330020835.4880674962899; Fri, 9 Dec 2022 20:52:10 +0530 (IST)
Date:   Fri, 09 Dec 2022 20:52:10 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "syzbot" <syzbot+6f7fe2dbc479dca0ed17@syzkaller.appspotmail.com>
Cc:     "dri-devel" <dri-devel@lists.freedesktop.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs" <syzkaller-bugs@googlegroups.com>
Message-ID: <184f77ac8d0.791edf3b143932.142182656112496550@siddh.me>
In-Reply-To: <0000000000005752c105ef640d84@google.com>
References: <0000000000005752c105ef640d84@google.com>
Subject: Re: [syzbot] WARNING in drm_wait_one_vblank
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Dec 2022 17:41:23 +0530, syzbot wrote
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
I keep getting "ERROR: Out of memory at tomoyo_realpath_from_path." and
cannot reproduce the crash...
