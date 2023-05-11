Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9178C6FF6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbjEKQRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbjEKQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:17:28 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF513E70
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683821846; bh=tBePyjOsobbrh0POLBOAWPIX2IJq3gFqvcNAxxVll90=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=Pky1pr12kC0hniYc8eOYsrwiYqOfy8leelrXe41rJKlT2EWoHC36sPpMenNk2bVESNhxDc0jDw32y8qaKLaNPW2OFRTSgeqOuySK6hCuNEjiZYIB7T2xXVOtQvWk1tIx2hsHUKt5sProrgkhm7NlAn/L/3QGX+zwvOlC6cB8By8k+xUzltvanfbl3h1Hj9xRHZ9xX1bzfMC7tZPo+gvV8RkP7X9LpGhjfF4vrujKAm3sFSK3IY9CEws+PDIY1r61B1og235knq8xkj4wtrKX1Mg43qRcKQHsi6Aw4xuAbT1PwNlFOPhazXDlXoWeQ9JxD842Cdjwev3MLiIKLi5YQg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683821846; bh=tuxVHm9t5X9p3QUiihBvLvdkUBpEiZ9Kuii+oT7AyQ9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YUT8ebnoO1912eok2zEKmY+pIBp7jV8ty1z7Iew9UMUOwdrC5MAFVkjkOhBJypKAW/fb37T+JyNAvoBO++wQVU0Z49v93mchI/BCW6y5OcoV0zOUi9+5KwktyUu53H051Qi3rxDpPAIrKt1zDtYZUKASudLSRAVXi5Ii68EhIqER1uLDK7KAq2FYxBHiFYevC2F4VLavzo4X8HDs351jAEdNj/4QrAacYZ0LXa71DYDKP3RtoawbgIiWVRdhMuGmtIAHkhWh9IKp6yiSe1c+jlK7UZhGf3m8OxLBEn4t+rdVCJkM25Ksp3wxPUgbnnYe7rz3uCNxLW2+fdnXzKJQ+A==
X-YMail-OSG: LOLywCcVM1kVBzrWmlPsSC.VjpPcFpU21umt3pn0wgdqp2nFtK5cFH0DlnWWNap
 ABIC7vdbnor.9bdMG9QCyAwOLqN.4iBueEzzSUQFtPSzhgDAnEF7YqMcwqOrm6jo.606xgDlaMJA
 1NnflFz8TYpO..NxumgTyLszys2FQlKap0u9OZ9VHi.HnZQM7LX8VbP.WBpyL241gMjFTnZDrP5z
 xO1mjZtD.UVTXuPQQrueXEyacpYFyDIfFdRNhATsqS77U0kTaD0scXtS359B4tmYl2X4qTwTC0Uo
 tYZKT.bfLq4pL0u9yJDLiyEQmdyXOlJagv7SVZqXyTE23J9ncnyq2FspIaiUX4AtcH4WIejXBQ9T
 P5WHXmubw7dyAJ0EH.NcLIrCngXS1YfKAEvDCFwMB.nf6GxJnmMv69SXLufbI1AmFFw3g7SQT3ye
 GV7Uaob144m39wSy.zVFlt1p0RL9j1V.pBVND5PidMC9LlubzKunrODq95VUiZkzWpWTIWjuVkrs
 uQJSr3odesfNGh1KHmFRXkCufLEQ.JzfioTG9o9Yr5O6aLTV07yCx7H4vs93tnB4OzVfz3.qhwJP
 aBX7f8pI91w37FO_psoPiJ5qpDZANKpYcOawQfQurO2qJT5NmXzKA9zaKj0tRszBr3nDREZBaEcs
 q_vtt9tNe7gQezdv8lRo36KEFtJqzkIby4LMd2boTnNujnvOXdgndzYkaHISwQMzoKIxrjaDo3WC
 Qh3kYJc4.FGP9OxF_ofO9kN828tzYCN1tLB.B7Seg8bMSu6ydnn_lrvkfnLtdqq9kyPvVR8ZjMCT
 aN4S5xSwSzEWh12yllymIaAhB.V_ocMS4G2SqjlacPkIYC4HftFcWbd8ntuthkpIvmxkqJLk8Tjh
 FmHUH.KJU3WrXN7W0oyPFitki9dxO6cmQYIlqzYCiEujqG0fJQ2tzpEv9uuByy6SU0l0jq_qdbTm
 Gs27ybGiwViMY9mxUgoy8WvSgZR0knsbka437OHkoDDwwoDKjIIwJwuU9sl7Bq0ytuCkv1ioYn14
 wikcNLdXTZovG7lxenrqg6ypd_xkklYpEgjLF.2zwV4FKR_3JJ1QU4zfGSg2p5ggqm4v_hkSIukp
 A.QpBc_1DXd1IOiwv4CsQijNnsG1fnPIvMorTyQ1srlrJbU4j.PBh5kmNEQMEifzFhXHA81drazj
 vwTofEkVQ70Lm9DABfcVPkZj0TyrdJIjcRYZ4Y.Bm8_HN7bYcTlYzZB5X2MCl6_VH2hK0zzOiEKP
 YmoeO09yWKFUFfH7rkLCEfwc6K9AtXDnIF_3Xf8DX4yyoDFZp8GcXDXDWuE56RrQMFNHikLpA.Iu
 eV4Q_8JOrWxoqq_oISEgnl8TehIB9wJ_1Rr9WltDNshqUsZoq.OinMr.O.Qk1JpgEwq2A4lT6CRF
 rgt0Fg3WvLyamABcKUVKB_uFcW.GoRrMoROPgd1OfiQ6hmhrWFv5Yzy526UjQ29rcQQ0csdQoWKz
 8jlVj.UKfqKZ9soG8EGUoJDrMgl1tTeQJs3gHttmdI8uMuFy.pXCK4kpy_dRsyZ7UicNkbeNuR2m
 9ungLrqqtaGUX6Y5b7u04_uZNEnzpduhqND8bDCXx9t49u4XqHGi9MYJ7R9.oLS9myY_9ZdB5svf
 pzXnrAKyOyx9U0scsW5IJwLX8cY66teCm4lhORXMB6cMpzYtf3pYQWYa6fyRCaZe7LWVCkIzjei3
 JDAHR5HZ5TfSkrLxyzpGD0eTtg3AfYmkr3gcz.SY6MNdn3e890ukssfvFZ2UOdrH87gH5fAS3NAz
 _mYloXYBlTkDyAaJ2lZ6KLdjKqyyeNCPTYjSG7cLQ5UfiYb2FNLtMxbe9PGD57LbIwotd_qakknq
 qIfeQ7bmNn8KXAvCYmp04a7gvTNGp.QFPe3lONtdKG8Mbv9e8Fi0YUHrXphf42ZwjsB0bXcGXu1k
 2Df1wX8D7y0fQNhqJIP4R5j8zYC3HSxo6r4hrVoqPi_AXff5KiCLEggNOBSU3AD.Av2b9GgBsRs5
 ZdNdEIPZzu0uAOTBZqj4W1ydMp5JJEl7_zR3j3vhlzXOy1HOcP01UMXq2YfMIbm_pvbnNJFyhG8V
 QhO8x3H8HWJaRsZw.qMwd3gu9Zv7awBoKLNBk7IxhCn2zkfj.haxjYT9Ikrusra863uH0xeyBKX5
 ADNDH2dymFQ.AZXMAEa6JUVOXYw2KPlmOGwukDK1_ZaIm.yZyDqB_fjT6RkW9XCysahuQ2atqagt
 ZGZj4LHSM7sFj2tn9hERXIneWCNIJ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4d41208e-0f56-4c5d-a9ca-d36dcaf86d48
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 11 May 2023 16:17:26 +0000
Received: by hermes--production-ne1-574d4b7954-hz4nw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c439c490bbc67d9fb7ebb8e5a3da94e7;
          Thu, 11 May 2023 16:17:21 +0000 (UTC)
Message-ID: <b645e195-7875-9fc3-a8de-6676dfe800b8@schaufler-ca.com>
Date:   Thu, 11 May 2023 09:17:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/2] capability: Introduce CAP_BLOCK_ADMIN
Content-Language: en-US
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Frederick Lawler <fred@cloudflare.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230511070520.72939-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2023 12:05 AM, Tianjia Zhang wrote:
> Separated fine-grained capability CAP_BLOCK_ADMIN from CAP_SYS_ADMIN.
> For backward compatibility, the CAP_BLOCK_ADMIN capability is included
> within CAP_SYS_ADMIN.
>
> Some database products rely on shared storage to complete the
> write-once-read-multiple and write-multiple-read-multiple functions.
> When HA occurs, they rely on the PR (Persistent Reservations) protocol
> provided by the storage layer to manage block device permissions to
> ensure data correctness.
>
> CAP_SYS_ADMIN is required in the PR protocol implementation of existing
> block devices in the Linux kernel, which has too many sensitive
> permissions, which may lead to risks such as container escape. The
> kernel needs to provide more fine-grained permission management like
> CAP_NET_ADMIN to avoid online products directly relying on root to run.
>
> CAP_BLOCK_ADMIN can also provide support for other block device
> operations that require CAP_SYS_ADMIN capabilities in the future,
> ensuring that applications run with least privilege.

Can you demonstrate that there are cases where a program that needs
CAP_BLOCK_ADMIN does not also require CAP_SYS_ADMIN for other operations?
How much of what's allowed by CAP_SYS_ADMIN would be allowed by
CAP_BLOCK_ADMIN? If use of a new capability is rare it's difficult to
justify.

>
> Tianjia Zhang (2):
>   capability: Introduce CAP_BLOCK_ADMIN
>   block: use block_admin_capable() for Persistent Reservations
>
>  block/ioctl.c                       | 10 +++++-----
>  include/linux/capability.h          |  5 +++++
>  include/uapi/linux/capability.h     |  7 ++++++-
>  security/selinux/include/classmap.h |  4 ++--
>  4 files changed, 18 insertions(+), 8 deletions(-)
>
