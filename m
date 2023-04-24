Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A356ED40D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjDXSBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjDXSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:01:46 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475C66A42
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682359304; bh=LDdbfV0FTymlREW57vx/yjHO76KrDdQYhhj7T88dg2A=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=jC6zVL4hl8e3305nMOGFDf5d245P3M4DnOteFt+WuR3oGk/3MuQfeQBtO6yCkrVuDW6tzy+1jksuh9cUOCj1o2P4YLAJ2RHPmNLLTNJVixIBwAmFH1AisIWTgqgR7trzrXPFpNil0O8Ditkny8JKh4YsFHDnXz8ozVQ3Fcx/BcWpkIdEcL6EwOdfYFGYMUeHg9pQ2TALVxdgwb0774SMVzs/krB2lF65jxrQOq2Ex5JCTcnIznv346kRGPsRpKQnjeqANBBzsYuirHbkuLg9ZSzHdYxnrxJBpA2/UqoyU0pBapc5Lb5qwVlEwQ9JQjoYOt0zQrD7qXFlb1s51/e5qQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682359304; bh=eVFhDHSbUoB2pmUAra4dDEQRX7R8G08k4lXsASPWyQZ=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=BYSIJ+jnjl2QSey38HMUlboGEMBU7G9FBwJexWdqUnGzG4cbaCnQ7RscVDfCVGnlmG3vbsSf/4oLmsLkUNFQ4E1xbYLxHBJwMQySGnwqkdgOHyw8zZKld9bzBUIyXNNMK9LIwpZIeabmeIFBZDSq9ezZuQm0tmjjg8weGZf2perzMWBVAKI0qWIgt9M+IjKgPw35tAiz6oavnVCSQJ8uIKifIqmzJPLxcO2pN8hiRAv+qt6e2B38LrCzH9Q5Wl5dBnl8/OtV8ZX3M38DTZtzwZywqg4DuaG23R8MQgpOw/gEP9+wFZWsKc7FUVvPugDTBhBz3f5ZxLfliq8zp7iKkg==
X-YMail-OSG: zq2M8vAVM1m5SJpliuC8IxDLYUJFCjNvyQed1KYvU1e3H5oddcPT0P5tLcP8w9A
 lrwPODnxAqSfxVjhbecAmTPchcepumbPYvo_4AUJFdWgFPyh4P76MGcd9mZKVPpvBSS5o0p3i1Pj
 SUXoigzwg93vqTmL4426pxgbbCNGJI.SRnMaCYvkUHMwonuE7AXGZDWK7rSomT6qv554sTsGXVW8
 T.ITu8pPRfc1ZMu0_Ed7EKDsYKnOfFHLEdDv9hxFVHRusAzNLFHV9fQMN03QBMKeOwbi.uZx3v1r
 e1UHZC4SGNufPmoc7epiU.x5O5G4zNLgqbju7h2d6CPgezm7mLiF7Hm99HLs2dIPF9FNhbPSMkXa
 MS59Qqym2Zci4ptfEZZH8bktCLiTG7q2VkkD_JCKe2YEKW_WESZHXc7pUz1T6Ts7xMbhwhgx2ZLt
 84OG.3alDRlwWk6NpIiK3JaMQeRJ6wDrK8YtWyOfLdebjeQ3ngbf6UgPE9PQWTUS09WTc.BdCUQr
 RDcgAQAV8742TXbMuOjaZeY7ZDnjW7TrorLtaYXgSEmX5v8PWqhJTDcm.dD84MgZjVl0M_NiGC2j
 qu6v.Y04G99Ldz4ht8p2DfM8kJOceShTF8HKGjQn2v_oR1JZMfE0z2Ph4qqkku.WGRBKoNAdaZRl
 5wR6sN4pkV4oOCv_dk4ec7CeNxOcoS..Y.LjuW3qQV3hIP.g7bt1OVCfSjJC0_MSQru8LmkbKsDC
 5nFBjhin7nykWESNjcCRiiF6FGmdDkRrp9l70yL13LLqkU9GLOprLfnW94xtSk3desWlX1_9xumb
 NItO7RmWgtQUdealfLSRZl5qOTE3bWm30Hs.3kAB7Bs9ViTbxtjLhjHuyfLby1O_ulqNvJcjRb4J
 HmnS_UfF.JaMgiKFTHTXOX3q53lIwL_dehkV177_BVNN6cSIKByvl7PMGevK1k47CT3z3t2c3YDm
 cKpGM4fS.BUIVo.H6cZIC9rD0Okh6nUDCUAMAY2McRjCbh1T1tYfPI9ZCaCy.qlRzlJOPIDa3Gjx
 eOPhYuojeKbFE3.0VHIJjr8cTI_lohjR3lP0JhEQdH1B2yLyELVBr52EKzVI6IEva3sj5EblY_sI
 x1wGppe3cQ.BixopIVaO9SSExP95zs31jj0pCo.7nf3dmjzYtnUVBw.T4L4Vk.9j2hX1IzZI8B71
 dtFPmUrvlrtq2.Nl3xoZnmGyUsKfrNpxdE4QnuiQBivnFvb2NNTg0_q2zPVg0jmIFD6oieQsor5A
 NTvyOT0hRNirsU0020dt5FZeS0QeMMXaNYjQPYysGatY1yLln8WDksI3qrZWws5SyoMmax7Xxw7I
 eI3WhhwYpvdfPOhmyIfhaO9jemV0tx7_npBShp4Ub15BevykXcn9_qgXIVlCSYdypyHqfzhtTrb5
 FD9g1mx3pXeM7xf1a7AAoCh8T7iGlBX8pLYrCch2zjc5uCVDDWYm_Q.75W6cYKbweJCf4GnlTt7Q
 O1cMyinnuXDl6vafm2XqG5OHzWT0UUxV4WHG1iaTzT7tP8BlZqUf5CBIW2J2EMPXxbuXVUjn1We_
 N5Wa9M2Bbhc0Fln6kuTvgXW7iZeYOeUjxesn2rnCIGhTvoaSIP5HocugEzHyo0W7sRdwDxXKe1Bw
 .v6wlOOW6HlzDJYjJtCrIqGdF.biMt6qGbzUsoXn_zaT6NtQJ_pk0YidfPdWj0nuvBQfedMkAO1n
 HW2LsKV5rG7XEl7SMBICM6YqmQQWxvOUwGBFGhp7xo6qTfYwWczssqg.A9GEVjE7vrSYxr.SEJKx
 yCJUglAyLMBU3EYOZ7whxVZsiR.3Lc_NQNkSQ7kpmXJFKOhGXxjMA0Ey9JGH66j7cyJUXkmLoRyO
 qBg2BHTBowcCxx1ZyLbnDr2KBoURB.gufS27uXfF19Qul7uhhL7ahsmk_uPMCDcDe1BQ0SN3MCmS
 o.HFKxLYwLGUrbW9VD5JsEA05hk3gUlMrZ7CubE9wERGLz5cVgdUum.zT6nvUbAw16NHM41u.skv
 04_NNqsV_jpnSSjJZQeTC_.ZumG0QMMYdlhf3dP6OeIzl1Wk7.FY0C4IWzOni8KF.YmdE1EQvMxH
 Yth53Wz6ZdYfIWCbPIl7EfY76E1YraaDprv_uhfxTk66tmWI.iZ_DP6hGwdnnC53nOu2c9j72g2v
 bOrHj__n8qhxflfneRoyVa95OafOmjPkoASBH9j53_zRk.buzJCtMrqfObIgMdkYgQ1q02bo3TXh
 uzWr_91.Au93wDnz894STe1wwiT3IK7o6d87z5V8eKikwvW_9V9KCRnROR16AdZNBROkZGSQeTeO
 T_A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 88875046-ed5d-424d-96d0-d75325c6c71d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Apr 2023 18:01:44 +0000
Received: by hermes--production-bf1-5f9df5c5c4-84ds6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 277c7ed0f5ba8fcd32580b947df2f797;
          Mon, 24 Apr 2023 18:01:42 +0000 (UTC)
Message-ID: <d4160d44-6dd4-abdf-e125-e3f5673445c9@schaufler-ca.com>
Date:   Mon, 24 Apr 2023 11:01:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        XU pengfei <xupengfei@nfschina.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v6.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <d4160d44-6dd4-abdf-e125-e3f5673445c9.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the Smack pull request for v6.4.

There are two changes. One is the removal of an unnecessary cast.
The other is more substantial. The mount option processing introduced
with the mount rework makes copies of mount option values. There is
no good reason to make copies of Smack labels, as they are maintained
on a list and never removed. The code now uses pointers to entries
on the list, reducing processing time and memory use. These changes
have been in the next branch and pass all tests. Thank you.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.4

for you to fetch changes up to de93e515db306767549bb29a926f523ca2a601ab:

  Smack: Improve mount process memory use (2023-04-05 08:46:14 -0700)

----------------------------------------------------------------
Smack updates for v6.4

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Improve mount process memory use

XU pengfei (1):
      smack_lsm: remove unnecessary type casting

 security/smack/smack_lsm.c | 64 +++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

