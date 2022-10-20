Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9660657F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJTQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJTQNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:13:39 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B481BC151
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666282417; bh=ajaWYsokvzfFnXQP5pL1h4wSWcb995Jmi4L6ZZXfF5I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tlQ94PBDbVZ464NzFGhGI1Fr4e05sX7cg5BeKWxv3V293MQFShdvR+p9+s3JHy7Rgt7NK+JIR6RtAWY0LaHHdPxU+rMwJZs5QVYOIPtZ/9+uMB29RgVfr6+bj/MXDIN+DfgIW70dnjvpfm0gLIDdjd+VQllEO5GKlt+pLKA6ivCUwgjB3mqOIo/+Ohgm5GjpxlsuvwACpfNvvd4ADVPwLzANPoS7KpQlmQbI31qQWsHcz9IfQvN/WcTaRFXm/uOMc843AoELy+G27/3U9dsWUY2obkYFCOGAe7TnK7sCKQgt+xgMDv8qjTs9Yl5NcwrpjE0KFBkb0Aw+cPGMBffFsg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666282417; bh=rzVfJB5FqIz9yH3i3C4FFN/u38IJFEyk1iv3frnLvou=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dJjjg2GF0utfe9m3fW4K7szGpT048GZGcr0oGelxlo9hhO9foqk8VCbzqI28kKEZWmbeJlMvt/5JqUIF9QP/sz4iMCxzvh9YYGVx4AmtF5och/XwGYc1WLi2W0iHNdPkdypwwmIjISouWexWOm13pk84dX8ZpD2uiPGMwpoA72SO2XMdL15FZKgMC52sfbBT4JlnBvj36FyELGi/KI/50DV7HyMC6IeaVoH+1l1YMC1mGO/L456ATPgX/A80jp67maYP3mKH05LTrklGX+8BoLVH1fBwHIMfTQI9hOM7DdSxDRQG+SBRxlW8+gTjRTXbbt7iAI8kjg6haOPoKZd0Ww==
X-YMail-OSG: 9M6vgrsVM1nOwPUtjF8DEhcOv8zHugxZwc4TQIZMJt.oo_bcVpQFI6z6XT13KpS
 QbAhFYNbGO9Uu3Gl1x8VnyWoFpmtjsYloRDa2mERcmgRo30MKIQvSBcVBrtyjfOv4uolRYRg4p64
 UY.bkVagQFn898x87V7xK06uTIDZQgk_axhZH38ogLpkcukgZt6DBRXfiiO9wa2pnEkjh1iic5yq
 n6_LL9kgkdCwYKUpPHL7eW1VnbXwaLob6gZ5NVIdvRVKsJ_8XpDLnQqIXdR2.uS6OLVXeWB5lPtL
 G1975Q4xdcRtVz1.XqnLrSjebFof1KBOxbvJb8ElXhfDV.v76mfYjKhynHRFOkOt83qfttG6WIbc
 PsrcYIUxTsrV2eRDu7GC3_woeF6zCyJXHvnXVE5XduPXE9q.qZ1CDvjwtspc6ZuxtKgTaSmDH3On
 5YJBv1l3mX.l2hLqTUyblvJt3mShR9A2i0hBP2fuuD_4u_zN.9qa_F30CUgc7qpwnQzez4Wv_rEx
 1pPq.qejNSICXsh0RgpvsV1Eqt6q_yTqYYYfpDP41YwDm2nv1FkHimHm88HgYZlkmtP0jaIZ0YmB
 DfdELE2XQUfU3LFrroEjbxZBMGF7yHCW6ke_iX.7k2tnc81GsKeJpfAjWVpij8s3qHKaYynDsKeC
 AoDSc8USDIFbGwdQXj8LCKU44vNXVs.PPrQPz6YYGxbQPtBYX42zhXJMC1PVCyZkhAOdS30_t8Wy
 _ouTxrCC9pxihVgKJr8d45z55NNftMUynZxhGyonwJNsZiLvaqTNy2d1mZq4MflIhLHLmBsRbUq0
 KQifyiPF.5PZz.Fw5juHhHJx.AArY56BEpvvUItEii0OIyxrsFFUfR6IDsaBVsjG4KQtO7XC.ckw
 BaPaV6ZCVHPxbLUMjpjUkeXuBbS6UDtwSgeiy2Xj_GLw6Qu33dfTeoisL_JKdJdHIakzeHUZy32L
 5X6Haf6oKyMOp.TZxuh7khcybvTRM0zuljocn22x7CXEO2DP1uVd3jdFqkRVOCvewY6VlYejCmcK
 btSWv4t.8bZjykNQLSaPX5Z1RZUinll1YHJ6xJC8M60qOjh.Nrvs9r3kZlXo7irP3RlHxlu9NS2.
 6DUTYyQYXeCY5Xxenk6nlV4ISBIjpjcmZENpjEM8DsyjuDTrUE225S35PNw6QK4z.MsTwM.5g6hd
 9IbiGEjbkyXoKrP4gIXCq2b2BBTPjp6_aqA7fv1ZQ2a.jwZ8yukb6_Dy_.J1K951XogT4TWKbvvW
 IGDw73Tkf8iLSxnsAqNVlFjl4eNrelJ8pcHnYU7VlYdiunbh0zAU4VP0lxuHaVoHvL_0UCjKEReS
 m2lPMzIOyrZAyed1XdHHPFUHKQII91rnnOXI7hlM8bMlwtZkb3WYBF6_BEisLKeFdmkiXGKwR5Ap
 LYlG2kydIyrkZqka7MwEJNxUvvwh8_cAaGvmYGSajiYKe3JwAoQ2skm7j1F51mjFVUHZJH1CX2RU
 KKmaU.HoMdAsfdXxPdgjyiEcLXGXiO33dMVBnTqJzEekKDptkeiuiq87xeOn6ZqQaBVn6tOCwYwt
 FkLhkDq_rUtdgNRJd14SfP7xifm3YRd59Qu.gS0YgVj1A8ljLQHg.cUeHPYc_AC.t9qLsnxLfmz4
 hq3R2U0BsNq2acgLrx9VUVc.71H2zt7kfJNdWSo7YDms1V5kCFAf5NTPjenN0nrjeQk3q2kWUV3k
 s6mzBdd6MpcHpYbdLksjcOjKdbm36zlW1ub8p9Dv2gmXvfwBtK.aQduqzq39sU9AEqMJhepuzEYQ
 3DQ8VCvhtF0M1AZpsU7ffDs1Zqmv1s2dKVSVsCoquYynHScoFjSK1PQR6Ueakzig.aAd2Iug8WCg
 okU0qAkMrL2bNR3QSMqnExCc8YQ7Idgw2Mz4ececyyUm8h5wsg45RayDFzAn_jwJEJe3wLifvzjw
 .jbVlpWCh1PCPC0XBK.KbROjpHtGD2JXEWt52e5mUM7FJ6hTyObOGJi_LZtR5bmuld0JPdbrxRBN
 G7HDbBhIXnzxDMyCHTvFHES4K7L1MCHJrBa8Qa.PVrSG2QGiEAs0QzpdBDKNDTiB9G3aF7DRkZ1b
 mXUa6QbGoN31L4k2YmjReIuGlJb8VWBf3LvciwiwP7Da5yi_Ytxp0RVfXdx60egJQUaxAIOsWPpv
 d8CINNhwBFF7hGIDShpw07HG5hKTft5mIIVzmBYV5jgdLa..KVCl7XpNgs.gloEg4pDDDqXmrC2G
 up1VOQb6pxUP2UUcOuoq74MQ5s__6p44mbs5KJhmFaSdjyy.RZ7tkLfIPB7vtiuWDlpJqxqvC9ET
 aat9MJWSclr45e026
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 16:13:37 +0000
Received: by hermes--production-gq1-754cb59848-zdkt4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1f2e01732a1ec2c64f92c880c6263bd8;
          Thu, 20 Oct 2022 16:13:34 +0000 (UTC)
Message-ID: <332a5987-8f4e-e26c-cfa5-5121cfa71ba9@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 09:13:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v38 06/39] LSM: lsm_self_attr syscall for LSM self
 attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-7-casey@schaufler-ca.com>
 <CAHC9VhQbr1zgyvzM9zB97+rzO-Rcy6CUt_3-54ED-SEanVWyRQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQbr1zgyvzM9zB97+rzO-Rcy6CUt_3-54ED-SEanVWyRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/2022 8:44 AM, Paul Moore wrote:
> On Tue, Sep 27, 2022 at 3:57 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a system call lsm_self_attr() to provide the security
>> module maintained attributes of the current process. Historically
>> these attributes have been exposed to user space via entries in
>> procfs under /proc/self/attr.
> Hi Casey,
>
> I had hoped to get to review these patches earlier this week, I know
> you are very anxious to see something happen here, but unfortunately
> that didn't work out and I'm now in a position of limited network
> access and time for a bit.  I will do my best to at least comment on
> the new syscall related additions, but thankfully you've already
> started to get some good comments from others so I'm hopeful that will
> help you keep moving forward.

Thanks. I just got back to work myself. Hopefully the comments will prove
useful. I'm just getting to them.

> One comment I did want to make, and it's important: please separate
> the LSM syscall patches from the LSM stacking patches.  While the
> stacking patches will obviously be dependent on the syscall patches,
> the syscall patches should not be dependent on stacking.  However, the
> LSM syscall patches must be designed from the start to support
> multiple, simultaneous LSMs.

OK. I will refactor into two patch sets. The first will be the syscalls
for getting the LSM attributes and the second will be the stacking changes.
The prctl() I proposed to set the "display" LSM will be in the second, as
it makes no sense to have without anything to change. I have not to date
included the SO_PEERCONTEXT that would be required for complete stacking.
Would you like to see that included in the syscall patches?


> Thanks.

Thank you.

