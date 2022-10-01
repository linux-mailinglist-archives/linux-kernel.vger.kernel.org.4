Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E695F1CDA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJAOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJAOgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:36:05 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA358521
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664634958; bh=vxt0scj2WI8k0i1OmYCcdDb1bWHVTBE3/rho9ilmZaw=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=gbr4XEWxfeD2RUurAR6moiA+8kVk5cbmYqbro6sHGH/dih18Dzy6GUJs5Y4VuDqqmiPbqKp9RWuj48yh8bXYZbDGrFH7RJo3z+Mqjd/xKJw5ubwZ7pAuqlX7TImVQHhroNuwmfONoIzLF2QZLFoZCvaIhQV73Ns2eOgGc01G1x1VHUP6474i5Cse/7ALCFGllhOKhF2fNuBT34h/zqYYpLTMi3ukhkBrulJO+1jStVLbYY696+7O2wQk1hmvspp/iBgP1vx2EzAIcjF3Ju84KbW8uuDdzEdhqAXso3NwyOH/iFC0iDd1bQM3OF+zXVt8kXZ7ds3bYY3Bkc5pBDPH7w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1664634958; bh=T87kChdqKKUL+LVlTgksZH6VtJt3KXndbAMwO3Cbufd=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=XiR/6I/g6nu/uKBSaZSt5xUGRZZ/XQSmLC9dGc/CbxBQS5dGmb63Hk1OEn1mgWRqqadDVo/7aVLtrlyWzM7vc+KxjJoVpqI9ADpkSHn+GJD2MeMMXMu2oSPj1ApwfFVx8wxRfts/Gx5qFjJ6uSVnWbff7b+vbFxDjZNabLYASbkgt6P51cYRNi1Ayx0lfXWLe96JrtErrGWDJFL3O4DuHWFyzYDIEGyGNuulOqftLJRUyg7/DkvlUVj6LthmSm6eCh8jn5e4oEvuMSkzbidiRaOS41JsGXg/i8qJCTM6EwcyN1YtH70e6DRrSfpjgcQZSu9tjK77uEcFHhPhoYQjlQ==
X-YMail-OSG: .mVPwH4VM1mzmeo0q2o8RkQhiaTlDzy_rb3D4n.I449gMftCUDk5Y7M8XQxBY8w
 SYQmkRFbrpM3xpb.R.dUHy4M49kdHyk6EUmLYljPegHvUlG8v14LUhKY8KDUBwROJ55teldBQ6PO
 6MJr3ANPW_q7UyX9U30VwBz1smKszXAkvqIZmRwTPLq_g6w6NpFGhh8tVwrlHw0mnrndOlR1r4zq
 JNA.6VsWY9r6.j.U5Sxn3GwKV3y0AuujtersLuOseJwgicicPCPVfivSfR07gJUY_K5MSqF5gr49
 4zuY.UK7EaX9ITiNJ9xfpgTX4eo05o.UPYxTOZhRm6BEdXj7JrXlb1VFgKOuXMRgssTSNQBMYR8S
 AVuspP8deeZpfVOiIZbHZbBPoF3delQNK9NcHSV5OOXqtRLimGBuOQaDtLg6Bxx2InwmMzzFl7qW
 39L9z9yVYlSFcCo9ZMBLmBkGMJKpDaDvx3PtMsIRfgtXoRdFNLcUxOcqtbNIG7DlxH1wy2F2NOtb
 ZBCg32dAi_nxNUVSXFHte9X0a4INV7FzsLkeYpl.4Cm8u7M7jBJdZVqwi8N12k.QBlKaceZ59rJB
 Vwka7GsgLEEU4kwH6T.xgjc.piBvWa1QJuiYNDwgCXZS_qlEP4jVr17VDx4FXgUH91ZWQmPmQ5jO
 6fObsOpgE.VO5s39GtlBzQDSyZws6Hkp_jYMUE3G.gloDnoFzS4y4fGuN3LPnDff7NIw27_AM6b3
 X4eA98zXpklq93GPAekhmLYW6IShYWgijljXBYlrlSc.A6VnWmhhUtMz4ogmOHGZqp8HY0T.GDrs
 QCtEnM6MFF9GQxQgRm1rSHWA72Po6yTatvfrvemvaOO2gJsUJWXWwZwt2CoZocPRwKwKsnSGmFtL
 E56xJ_CuALi2MSXW0c05tcKaOYiullpXRncIervsl.UrA3O9gfTfNUHntzH7AtaMe4gUwmFR9cLT
 VFswxYolFxuUsfmQFLGjLDx.Bwo3fairgn3gJ99DKTk9XPFTc24Ki7zcVU9IuPeb2AylvlfTz3t9
 gcUP9bl6KboGF2c3gGx5zz11HT0.Si3a4Miz93CJMKwFs_E4UdPn3gkojtuWXZMsXvXI.BqMLMNc
 REr91JlHFVrv.eEk6B6mCNZFqPl0V61WUxiOY4RF9mOwDFfBHC1ujkWwx5a9.qAnToUPjD1q2Kp7
 6BNGSzFx_CpVWY8x1GdHo1C9py3FqTFvnjxVAiwq8BHPo1LVvjM5wnlaYm27lM7UApl1mqBRXaQb
 NaONyd4pmAYpkzFuZE9KYfaJCGsc8a.sadErC4GfqtRltYFRQla_tDbdhoeJHtRQH9l2iubgYKN2
 fq7ih0s7VWXHkR0kGSWgrSugHcFu0a0Tsr2ufq9k3vC8mFyPneEJ.eSPw4NnyiWkoXkfpLg.ultg
 yU7VoqKfxluIfQCBJHGUfleMd2FOZ2EHqMW0fkWX8Jvaf9ddtOT30uqdGcKp5rW8oLl_gmjC7csX
 1FZeJ3zImToW0EQchSvnn_WAPwPLbxmYDfqKr.Ma2D1VExbNvCLsUiGherLoNWiK2uYCkJsFVnnO
 QCCAFXfV4kFFmj0g6aIl9JVq2W2Y7qgM9CM7tzkdFV3fvvWTHothewFdpwd3zBTQVdVrUKFAPTq9
 TzBkMV.iQSMziaGBsmpcY7.m7_mnnkPJy7HAZqdkwrR3hXXJAAjeeZPzdBoUcKNKZCeSM1dW4Ip5
 A2adv3u77GcaP6I8EQRoQ5OkqIokEsJpu._vzf0bApD8DmQ1QLJAtDHqiTjuKHfdo7743p2KW.1r
 juyXrBzcT2d2cz0PBm2S7odd055apGqnfOCSh_ISG9meiME8AeCQm21NwGLdQrjaDqVo0TQrX8.H
 CPuT8V5.SUwhKFyuDY4o9U_jAzxsk4Wg3ck8xb7fp61sXd6TwyjuKnvoqrLJrdC_4zB0E7SzoiF8
 OHkF6M4raPglLdl5pUQiGkaU_9_Of8jP8I_xIIRte353YnxGDAM5E7dHU5fdcHQNLx6VnVh0FOaU
 zo._E4HhfBmAmalCPzHoiJWHPd29I1B1XLmCoUwOsCgzMKP0dBxNSRgKzhO1lQnvhpB5HZZtNufa
 K.pZOjlJ.vOx.FU2GDLHDsN__TSrbWRWjL3i9m5aGtDrnqzMmtPuFJ9rnnGlhmylpVtROtcuHdAR
 ZvQZ.leGrIZBFbdy3BK36Zph7HFs7AbwkKj684ravjD9.yfWC2VfCFSrye3KfAqYSf9.R8AZzYM2
 CxMKKJOSQ9jq1QTd60brBsPVAXsPmbrbMpl3ujfvpyjRoP7rnCGaUTNrlOkKFeVUL8MKW6_x9ZzB
 ADUZzej8O8Xe1vp9jMFU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 1 Oct 2022 14:35:58 +0000
Received: by hermes--production-ne1-6944b4579f-2q8q8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f225e0ff16af69e7cd92456424fba450;
          Sat, 01 Oct 2022 14:35:57 +0000 (UTC)
Message-ID: <37208884-5153-d922-e787-e830860df05e@schaufler-ca.com>
Date:   Sat, 1 Oct 2022 07:35:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <37208884-5153-d922-e787-e830860df05e.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.20702 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the Smack pull request for v6.1.

There are two minor code clean-ups. One removes constants
left over from the old mount API. The other gets rid of an
unneeded variable. The other change fixes a flaw in handling
IPv6 labeling. All have spent time in -next and pass Smack
regression tests. Thank you.

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.1

for you to fetch changes up to cc71271f5b793d619f8a7d2ef905374102533c75:

  smack: cleanup obsolete mount option flags (2022-09-27 10:33:03 -0700)

----------------------------------------------------------------
Smack updates for v6.1

----------------------------------------------------------------
Lontke Michael (1):
      SMACK: Add sk_clone_security LSM hook

Xiu Jianfeng (1):
      smack: cleanup obsolete mount option flags

Xu Panda (1):
      smack: lsm: remove the unneeded result variable

 security/smack/smack.h     |  9 ---------
 security/smack/smack_lsm.c | 20 +++++++++++++++++---
 2 files changed, 17 insertions(+), 12 deletions(-)

