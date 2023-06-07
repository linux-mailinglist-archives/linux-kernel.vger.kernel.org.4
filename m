Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC6726361
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbjFGOxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241202AbjFGOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:53:38 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539E419BA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686149610; bh=z7WfrWLOqj/e0upze66XgMmqNTjW0KB/uXTWmgLmriE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IwOD6iDEYKlTs53Gq2fKQ8K5sHGNPaGMeQCgOwP1ZEoT1/U5AZ7L7BYbyNl5CARVM5osQVjRDgx+ggxoSzhQBQqXD0haNk6xwyl/JcA8PlCiDc5jFyX5Cwy4k2HkM986vuhOa+4ejbqWk1EXQ6TEjIc2lFud292S5tWmObqsH3/RzcK7T4LR9IfpLHKM0pXUUt9C4B/tV2GOItQDCiMYz1r0FRcCfZKveN4911ooVXpXfP0+ozplhOguiCnSJ6HkQDXdfHou9iY5nSqqVbURFBZaBHnZEYnGbh5KJeLNKbXWmqmGJSKZVNDCR9pfCgp4pYDCOnKNVJyEVDUkeJn3CA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686149610; bh=IhA1zhFnyTiBCtwiEK1UOksqddNI45WkDLitQEBFAgs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pPH1EsitPEbAPr1ZNrlBQdcAlA6S+Xa4ASbKHldv9IrzH3UbcsLLcKAssyD3SkpAe9w4nfFodtNx+UlkyS0cSUfuZhbdRKaRGsWHXp8gewGqQKwlvvd6uaQmE0eVWUxP8ygtOU+exo9LgqY+tOHQxlPcLECzk0hJ4diGHn/FHUVx51gar64neiEhm6R2/o9VhRq7OtpsTK18gR+INEK+idlD5nytO1mZJlycL6ud/D4N+guS6MxbmQfTUe1M443kSaq3SWbt3VsWIazrzElH0IPWjtQn0gLuAJtRy0kXmvMZptEu44h5DrF0Ql/qOIz0KasgJRXVO8GoyBxbCO+MBg==
X-YMail-OSG: HZ8w05cVM1m3uCKwU.xgOV6FcbkpdEsE1AcpGau1kS6PSznjO7U6CxIU9W5ajuj
 FYRo3GGuP5SNHPTd5VQzfmK.QmHeIRRdBnp9Qk05sKdu75v1MR7RtSLlf7lXm9FUXfVjuf67xTIM
 xIHVSFXNbda8G.LYy9xHsMr8ClTqWAOVVPyUESxhDQqUStFN.RGg7vCLy0XjnxblZn3IWgsatLKW
 zq.g.slsNwexNPLQsz_fmRL3zMvv15bTA7cBlwYrQcNxU0VNf.2zJPafoUOS2DkH4eYil9KLgnuw
 9_8rCvmApC4ZkUvVvAHJdGvNrXxWAdXQo7m20Z1yTYo7BcwPX.yhc1VPuiQMpVvFtFGYaOJQINok
 Z2aToE5SBXIcSnL09Rk9u_38TABmXEUxYXzx2iAW8eCZbhIYIxj70zakFtbPAQfL71jolqkdICYE
 t.ynv0hKEkrpdHrKEKNPdbd_SKqfvkJOHe1PG4YNd_lmA5v3vR0N2j5bt78VxkZqj5Axb74nZmJf
 9vUaT4ziSWmEhjzrw3dK2V3wUC90EHwfEGMZ8hjRkgCPI0eLZVu5634u.wQ2111pR3f54r0JzrlP
 SBM5RrU2wr1xswRVKQzyhy23WM6MlAzPM9afyz1Gt8ccSl6VREy0GWab9Fo3NTLwyp4wCf30czzQ
 YfVODYY4pN0qTLnjslzG.ctngEhqf2EURqs88_tk3C3MG6Qpdt3eA1uxVk9gqvXpZgrDwDCh4pd.
 tFlKq8T7jLJgaq9kCxiKDP.vd_kjIwtBxWM0JzzAHZhMvsMEnl.ZZK7kzc0VkVNCzRrhHntb0Ai2
 YsxzvGiz2dFAPI5okHm2lCLAEQ5LiXaecjfjeFnqTndhKzvCA7c9c81NKttfT_0e67WqN5813eOe
 y6eanJGaL7bSGKDjV3r0vurW0pThhUNzVw4rZUaILqxMZi48wSjsn2OFR1Dnat.wja8w.L5Jsu9H
 8zTGbkobt.A2afJcMW7Es_AX6zjpNILPStC6lF87qeCYqJK2cATBY.u1Uv7OBuo.6PBCKpoqkAg2
 hXCZN23f8Goyy_hfOWfTmPYbuKjnfrw9modscsH74mPyoG_11SZROCkw_Em7yqErVm0AiyMchuZX
 h2nxzhe.k5XZABs_aERkjlmr_cCyrIvMicbVYNWh6YAWvWJwJ.TrbB.P9CNTyxEpUXQ4SsEn2kW2
 4NwMEo_lSb4lUlfySMKSqOkz5F50KKbqnyIfXTRNdTcO1AkyAJbueL.kXnARov7RQg8LELtPZQFa
 LugHaeityGYC5aNif_.B67lYh5dLgmqpN.YYJPMR5peeQqSMMuTgdQzqXUxkxou.JpXMzV7i.Q_8
 stdiirH7s6jRCH1IGL7i75rKLxhXpvEzi7vbNKF0ev29lps97ZNbFLurY.IBrEu6qe1HxqbntdGW
 CC4t3Yyk0pCyNETLMP0yaqC8SWfiPbg5kQnvpeW8fYo6EfdfX7O67WwEzya.FkxAS3E7luh1t8Ym
 JZrUiBukXyRrxDPTvKgqgj1vLHKMWYocUceLsUePRV0q2x1sJ_iCGzVY.NwzcM.rRmXk.rp0ZpDf
 VTcD2etxJUY9cxirt6hCCs11OB3Rvzixzd7ZOL47GQao8FsaFlRdsSqUNalkKGWjMlb2rx_GaPoj
 DqQaHY3rcfmbrKWUPh1ZpbnU8sRtmb_Hykhxty44acQwWgwW8Y8Yi0DbCkMvhjEIKXaYUhnD_9rr
 SK8YC._gQZ_BwazV14gGCwBx60IiDhqST1_v0baCjtEx0rTWhQz.IRwV5KTWzGOLlN2dDNl04v2d
 iJC6EWWrMpZ_juwPzdkMkv2hFaeTTZGz3p0z2UHaabysgDvTWJbJmOmt49lqof27Ua3Q6kaCNx35
 sHCUo27kBWucnSOT3YWPkKmaZPtsbJeon61JknIqBZjOd6XbbAWpnaMNWNHnE.XvsbmhcdkoEEOe
 k.JKl0m7lmip883pSuw0rp36ZQGo_SHz88kmJ_5y_MxD1l.AQdYqAEGCtDvTcyr_.L9366l7s1KM
 etNrmRf0e19Yo87RXseh5BG2ifoTCm9ifGkhjmO8p22d_qU92w3G35O6HFWcipmcVmHLbR.Heiqh
 w5eGl9NPOBDUPCsa8i0gN0N3rK_.CIccf5llwCF8D83xPvt4Hjgjzyrl5KgggWlRPMwqblNfGOpD
 eqDl0iGCiw0ytOyB2VLzAxpl7.1XrYFVQRhfsCXKdwwmlfJiPE0BysZOTXP7mRU74jmCIX8.7AkQ
 IVLdZOvlXbz97xy0GiAl.D2E2DybCSI4d5TE1FbYeRZcuLoBhQ6Y1uHea.kuIfbhXh.uY3l5T.Bh
 8Toc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4431ee77-b22c-414a-a327-2407aa43a036
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Jun 2023 14:53:30 +0000
Received: by hermes--production-ne1-574d4b7954-scd6l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 488c8e207d1d5833bf01dbe7d214ec9f;
          Wed, 07 Jun 2023 14:53:29 +0000 (UTC)
Message-ID: <91852af1-eb93-7740-850a-35e5dce9915d@schaufler-ca.com>
Date:   Wed, 7 Jun 2023 07:53:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC][PATCH 0/5] Smack transmute fixes
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230607123612.2791303-1-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230607123612.2791303-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21516 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/2023 5:36 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> The first two patches are obvious fixes, the first restricts setting the
> SMACK64TRANSMUTE xattr only for directories, and the second makes it
> possible to set SMACK64TRANSMUTE if the filesystem does not support xattrs
> (e.g. ramfs).
>
> The remaining fixes are optional, and only required if we want filesystems
> without xattr support behave like those with xattr support. Since we have
> the inode_setsecurity and inode_getsecurity hooks to make the first group
> work, it seems useful to fix inode creation too (SELinux should be fine).
>
> The third patch is merely a code move out of the 'if (xattr)' condition.
> The fourth updates the security field of the in-memory inode directly in
> smack_inode_init_security() and marks the inode as instantiated, and the
> fifth adds a security_inode_init_security() call in ramfs to initialize the
> security field of the in-memory inodes (needed to test transmuting
> directories).
>
> Both the Smack (on xfs) and IMA test suite succeed with all patches
> applied.
>
> By setting the ROOT variable to a ramfs mountpoint, the results are:
>
> Without the patches:
> 86 Passed, 9 Failed, 90% Success rate
>
> With the patches:
> 93 Passed, 2 Failed, 97% Success rate
>
> The remaining two failures are:
> 2151  ioctl(4, BTRFS_IOC_CLONE or FICLONE, 3) = -1 EOPNOTSUPP (Operation not supported)
> 2152  lsetxattr("./targets/proc-attr-Snap", "security.SMACK64EXEC", "Pop", 3, 0) = -1 EOPNOTSUPP (Operation not supported)
>
> The first one is likely due ramfs lack of support for ioctl() while the
> second could be fixed by handling SMACK64EXEC in smack_inode_setsecurity().
>
> The patch set applies on top of:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=next
>
> plus:
>
> https://github.com/cschaufler/smack-next/commits/next
>
> plus:
>
> https://lore.kernel.org/linux-integrity/20230603191518.1397490-1-roberto.sassu@huaweicloud.com/
>
> The ramfs patch potentially could be useful to correctly initialize the
> label of new inodes in the initramfs, assuming that it will be fully
> labeled with support for xattrs in the cpio image:
>
> https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/
>
> Ramfs inode labels will be set from xattrs with the inode_setsecurity hook.
>
> Roberto Sassu (5):
>   smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
>   smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()
>   smack: Always determine inode labels in smack_inode_init_security()
>   smack: Initialize the in-memory inode in smack_inode_init_security()
>   ramfs: Initialize security of in-memory inodes
>
>  fs/ramfs/inode.c           | 27 +++++++++++
>  security/smack/smack_lsm.c | 93 ++++++++++++++++++++++----------------
>  2 files changed, 82 insertions(+), 38 deletions(-)

I will run these through my test cycle, but they look good at first glance.
Thank you.

