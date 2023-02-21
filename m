Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B569E957
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBUVQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjBUVQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:16:26 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326B31E12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677014173; bh=Ib/cS2Qh96O4CctBXZz55Jmef1wJrs3tR80qdd/yMQA=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=EsVhkeSS3S7Y0pEjLub56SxG2hEUoh6SsgfBTc8EHc0tIKD0oGzF+6BRWoYGmoOtwTZ1mUJD1IvslYKTOE7TwTsiLzYEvUtjtbUIjIyL5bkvABAIWmQ4wj6acqOhU5/3m2BVQZ5IarPiU62pW2mqRFt1JZCknzkNCYDRbIjGj7E8AVSdnAAso15bpD+6Wf65PfpIPtaLrkap1RY8MZvtgWnvNSAoXhPZLIdprKyPziMJtZSBnGQP9zrLgjE+LL2jYGy5d2+tzLG+REotaJa5I+VK1ZsjAgArgVTqtr6FrKcrvW2T3NTs1LO8YlLvzqiX+tb8IjSMAEiZDc6DH6oC8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677014173; bh=k/U6JCZMbNT0GaMzBW3KRkb5Xs7xWlyZRig9JCC/SMN=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=hgMXRDvirL7iL9NJhzUAXb5av8gJEHXbGLy2heXy/eomgn7rY1+x7ut64M80iZDLcWnLQyQ6IkQUjp2t10YDNTCgzNset4z72ux9PiTszmUi38JceEVa5hCfY758brtVnrZnyNhHqKqJRJp6ubXLbpRR3kNvWm/fhCe23DJBYZqa0sU+s0ck1zDSIfiAnOJ8gl6YfCdMEwy7PU4Z+No+9wZWxl+1htuGUVI+ThqdXksxu272Gut96nUBQ/zVXkp9qp8wjbKSBYcp51L+gHd/JsLKpWCu7XkX5XBoM/IPzIh7bx7670JsKManuQHtV+zgr2t0EkUZtfQqNdON52KbgA==
X-YMail-OSG: xTZfUWIVM1kvLp0Mm.eE.ZYGH1PBbal8O228UcE2YGRG92qqWMELk7Z_HBusKWG
 je0TmCT5KkUJru5KzqXN4blalUCXZbjZBCAOU7CjjnW6rGHEIELItAachw3iqSMTzK5LZTAhNUok
 XUHx0ninY48zOD7_Cdd.DssI5yZjXunyzask.IZub50pie6nov4IJyZsWTDHk6R3HbyfBlv4M29C
 _GVo4B69CxwzmOQz3ugtF75uCbsECK7p4fx5MpVpOnt1xrgC0TF5Uj3x1nZ.FWyrxm4MGWeHpEsn
 mXD410sZH0SemDRmK_ODRXvFYSVoCoPocF6C62JD0YhNiHytIft0Yi3lg_MXdUI9UDqpmS_WUoUt
 fG.Xps1td_OPZzcLfxpRh41wCTLjHboiZUUwiI2O.ZDTcm5u0sgdEWZ759dCf.sDiXXSPUmZEdaQ
 rUbLVx41fkp2c06.QKUrxZYgoDcm5H093APWGzTVcNLtegc1._1y2BShWjef8C9SR46Q1VtEDJCS
 wkR.fJY_bT65OZI5fPWFM_EuAXps524yie.lHmIZnTyvgfsEHoOItoMXHWa7Xx80pcnKXtRgAG5Q
 .sntnPK1MHx8w8QyNbOB5Pzjf1OnNLGL9a1pbxQKRqwlMIdq6GI5DEddnbEALfASMxNss80nBjky
 yUXKJpIFtAmwB4OjrCf5iotLgbEqWNJRjGZrd.OKYjDkcexEBHPpS8B1YOlkv.__k_9r0n2GiZ0W
 JKBjQ3b9WEe_2wS9HkzP_kDBDhEBdKLRClR_4kAQUvELsqHI_bhCvnPappwiIwD1pmkjI90mPvKC
 Ts.8KSj4zNnGdzsfLGMO6rDO0ZMwL6LGc92IGxSz1lxxQ6r0JS_dpXm440BfUomcD6xAhtGt8CKW
 7yZJ_IZ_HkXdVowD8v..L.AwxmXaaXKEMjKY0USicuB_37VFRpbkODiWvQNZWFeUxgKZmw6hF3du
 hozsEpmJ2c8GlhPNAMYcBw4qAHADiKB36eJbobt4Ixo7rm3a5ZqVmkaF1PnzSPPir92U_zAFYy_r
 1GWsUnqBo7_sBQX5qQo5h_t4C1wfbjFnFKjSYJz8x_f48qXHAlLLolMr_9cX.ruRa3tWBNMb_BI_
 OR1IJfsVx_X6mYzep07W4q7pNNImuVsnWt0_NYOpPhBr.YFNtHW5t2dVmJxMLnhAVTqmg_Hsm2e0
 mxHFyHtqcDa4QV0hpyFQVFQF5v8Mn8Ggk3vRBx8Pz7IVJ23CJOeHTe4G.OAQMEacio24BQn6Ku3.
 NJuigqLnz3t861tkaPRvSFzTiGIDIZ_631JnTmi7RVquoIvHH2avA9cu4kiKB9U1owehxu6GWIui
 eI28ZLhFZwLj1ZDLtmWoDPFNj336bPpbV9Pu5Y_cjj3Y2b2cak3FFy4AZPq.sP8bb9YTA9F.9SDe
 dn6KdC1qqdR7ppqABP6vRvFDyC7qBnr0ouc5c6zzTkQl7ku5ZjMdvnmAB3MKnpnm7ZUS8Wgnpp7S
 idlNOA4o2V58DTQvjH9LsiaHUS_D8R9YtxcxaqJRnrzaFkL.oqNjkei3jIyWbt3LWF7rQwbo7eEj
 voi7xpzLhgYj7uykPkxH9hDVPTf3oHpYHnWgccCv8MU0vwgKgsmbyTAAP7jVDIobvZYp2KyWvUTb
 230doTm_dG_IxGyNYIfdFghGO_BcWDDN1sF.fEhIwXo.SeEBhADKI5z.a6OOcSUYowgfX4cMOzFP
 D9qkOhTolY4GmS6OAbNbJCxWpnsP5aCsCRFy7U_7yipd4R6zcrfLI4OqiaK7hQswmyVtgnRU5l2p
 kke5JbnfEMpvOmTCbhP5GMsZj_Tnb9WCa97Fgf_lkvQP08shVkgiqTF5sIbeslHVYXirqrSVXEpP
 iocIPeRpnkiQN3zYGIEcY4fzK0YcPyNhboKe1VNy4rtSwxA5IXX0PECUlq5dJcHQ1AxdezHmO9yJ
 Fjh5yz8N.90Er7Ij2aM5MVp45l4kie.ZzDKHWjzTAz1IVIMVUEe_YPYcpOEoLgK6NHZOQawHnm9u
 IVIQHstaIcDOE8_mO6wF44ynAIeWuth2ZTExBpGmPLxM_kKMV6.B2eCv.Xfk.E7oJ5BWy2XSzaK8
 RDXvgNH32ks61dLa59mqu59e6IOSwMvi2majgaM7fkE.HhW0gzPt9p6feoArhqLPHJzwSdBQNoCb
 yD50rxah.9wIJsDEP64eUIwZWig6Gf9XthgxzK_tdg3aFL88iYI9T43JX0RmkgqgLGo9jRQdf4Jg
 aIpCNHEYOqsn303NbqfUJ_IVmj8eJqPDP6GLJMqIaZPNt5xidbGNEl8WNxc2IwmZFfgS_LHBi
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Feb 2023 21:16:13 +0000
Received: by hermes--production-ne1-746bc6c6c4-8sf8l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7427840e83a31f83050c1968654ec381;
          Tue, 21 Feb 2023 21:16:09 +0000 (UTC)
Message-ID: <5c203a3e-3f92-9e23-c2c2-8f82baed3a47@schaufler-ca.com>
Date:   Tue, 21 Feb 2023 13:16:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v6.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <5c203a3e-3f92-9e23-c2c2-8f82baed3a47.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.21183 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the Smack pull request for v6.3.

There is only one change, a fix for an edge case when
resetting the CIPSO representation of a Smack label.
The change has had a good spell in next and passes all
tests. Thank you.

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.3

for you to fetch changes up to ccfd889acb06eab10b98deb4b5eef0ec74157ea0:

  smackfs: Added check catlen (2023-02-21 11:22:02 -0800)

----------------------------------------------------------------
One fix for resetting CIPSO labeling.

----------------------------------------------------------------
Denis Arefev (1):
      smackfs: Added check catlen

 security/smack/smackfs.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

