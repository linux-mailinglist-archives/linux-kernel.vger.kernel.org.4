Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9E6B6080
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 21:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCKU3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 15:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKU3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 15:29:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18396A2F0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 12:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=J3DyTIvOV/2SVP81VtW3lO9g8GsGdpbqAk1yKC2K1qc=;
        t=1678566561; x=1679776161; b=NBzrTIa4/+r6ffNQwBGx2mNdixsz1POrtCzZCRaqhbJdGq9
        z0RcSuGXUn/8X0SGYzr65W193nY5do2bZybDWWf3KDbx8Db3CHWY0Td6laNxa54KNLULafah9Di/F
        l+HxKpWGEtwy2upjna1hY0MAFYdc07685NldMpV5h8iq2k9VE4uf+0OY5rnqIbWTQF9fcQ8zuaQQO
        AmTQOte9pxpiZIM/XWu8utBglOqP0e4rQPNNSO5FRjGusAKcLQWCvuuhK40ifZ9jM53g/lMcDhbai
        VkcxtWrtNR4Fx4YPMp23BLkJy+dgcmwIYerjvvwYKs7IaPgzFuibOXkviPn2bfhg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pb5q2-000TLz-1F;
        Sat, 11 Mar 2023 21:29:10 +0100
Date:   Sat, 11 Mar 2023 21:29:06 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Woodhouse <dwmw2@infradead.org>, mark.rutland@arm.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
CC:     catalin.marinas@arm.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, quic_qiancai@quicinc.com,
        valentin.schneider@arm.com, will@kernel.org, woodylin@google.com
Subject: Re: [PATCH] Reset task stack state in bringup_cpu()
In-Reply-To: <2873ac05521c218c5a7911741e91ed073df26fc2.camel@infradead.org>
References: <2873ac05521c218c5a7911741e91ed073df26fc2.camel@infradead.org>
Message-ID: <11A8071B-D9FC-418A-B0B5-D2AE608F740A@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>Hm, in the !CONFIG_GENERIC_SMP_IDLE_THREAD case, idle_thread_get() will
>have returned NULL=2E Won't these then crash?
>
>Admittedly that seems to be *only* for UM, as all other architectures
>with SMP seem to set CONFIG_GENERIC_SMP_IDLE_THREAD=2E

UM doesn't even have SMP, so maybe CONFIG_GENERIC_SMP_IDLE_THREAD can just=
 be removed?

johannes=20
--=20
Sent from my phone=2E 
