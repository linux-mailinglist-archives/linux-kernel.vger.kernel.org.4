Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D795F9A66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiJJHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiJJHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:48:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288AD6D9FA;
        Mon, 10 Oct 2022 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=513x/yo9r7ERdKoxcYysKwNVDSS4aBdSVdhZlM/nr5M=;
        t=1665387926; x=1666597526; b=NpZAcOk1gu1HSrx/sH2vW2JBWRrlTUDAXznmYGpyU9f2iFX
        P1Kqoiiq2bx4u8suzzc2iITyq3JxEd9qniwSm7Kl4wiKWAWh9Bzq01kgJ0FfOT2RrF84cGgvip5Ej
        6LUTAcR11SljMOICULwt2HKQUAWn0XiFoBLE0HDjkLSJ0h/0AAEuuOv36bDhEFSweRFlaYmyCvnPc
        YehcvUPRND/rkJmAvvupqyzBdAMNbeE5KKe4MGL/OzANP3SnRisUcgQA/RD5kz9UkTyDJQ+sUCfm+
        PEUrB/ig+ZaNZcBld4s8BzvlRjm6xxIFlrjVt6+TCiqD5/JfvsInAa4w/teQWflA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ohnTT-002wgd-0l;
        Mon, 10 Oct 2022 09:45:19 +0200
Message-ID: <ad6a722a0caa50c3f369e97b0f03180f62806fa7.camel@sipsolutions.net>
Subject: Re: [bug][6.1] Enable run-time checking of dynamic memcpy() and
 memmove() lengths causes warning on every boot at
 net/wireless/wext-core.c:623 (size 4)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linville@tuxdriver.com, Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>
Date:   Mon, 10 Oct 2022 09:45:18 +0200
In-Reply-To: <CABXGCsMmvxi9kCZ+sUm+Vb_jxaPXE308GAwkUmiduuJXh_o2fg@mail.gmail.com>
References: <CABXGCsMmvxi9kCZ+sUm+Vb_jxaPXE308GAwkUmiduuJXh_o2fg@mail.gmail.com>
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

On Sun, 2022-10-09 at 16:39 +0500, Mikhail Gavrilov wrote:
> Hi!
> Enable run-time checking of dynamic memcpy() and memmove() lengths
> causes warning on every boot:
> [   19.544552] ------------[ cut here ]------------
> [   19.545634] memcpy: detected field-spanning write (size 16) of
> single field "&compat_event->pointer" at net/wireless/wext-core.c:623
> (size 4)
>=20

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commi=
t/?id=3De3e6e1d16a4cf7b63159ec71774e822194071954


johannes
