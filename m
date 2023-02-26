Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B2C6A3361
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBZSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBZSH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:07:58 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9632E83D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:07:57 -0800 (PST)
Date:   Sun, 26 Feb 2023 18:07:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1677434873; x=1677694073;
        bh=MgscLBLGN/ifegX/E2ZdVzuj7Lb8hmet4x4+SBvRYy0=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=eOuX3p4JQ6y5JdK6o0sIAFumoUFHvA6x+U8z6RnsB3VBrERg/kUXvN0IfAUW9RaUE
         cNQpF2JB9HozYeEr7wY3HsXHnJMSBRLFOF3M8ca0f/JqPQkXt/Iw1iCuIhU6hNhfjX
         KGs+/x2JHnSml5pjYMUAkuWsJCtYSGIMKEGRpcL35WaxThDkoaKKc/enpvYCo0RzQM
         qKfS7sfZEQ2AZslE2FIXJd7gs9kakqlLCqU7Xewy3QojandfhlwPOdHKCahGu3TEny
         dbrl4/Um83wgowBRd8jsiBErNmayE2tFiPzS3fBcggVEQ69ngxDSxCSgACXkM4T2wj
         BdeR6SHPQddSQ==
To:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
From:   Jari Ruusu <jariruusu@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Announce loop-AES-v3.8a file/swap crypto package
Message-ID: <OrY2hkUbE-7Ql7C7Wk0GKugtL91KMyKnPJh1yLaGMaEKbkm2t3yRFXZ_hoI4vQyomZiMGFVxR-w0DbkMEotADIvPQwBaTlKtXshFwycQMHk=@protonmail.com>
Feedback-ID: 22639318:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop-AES changes since previous release:
- Worked around kernel interface changes on 6.2 kernels.

bzip2 compressed tarball is here:

    https://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.8a.tar.bz2
    md5sum f23ac0fac491dbd716020929b9ed894a

    https://loop-aes.sourceforge.net/loop-AES/loop-AES-v3.8a.tar.bz2.sign

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189

