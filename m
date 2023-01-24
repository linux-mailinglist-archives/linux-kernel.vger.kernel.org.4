Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00AC679B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjAXOKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjAXOKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:10:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB4042BE7;
        Tue, 24 Jan 2023 06:10:09 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:10:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674569407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0brk5AuYt/Z43z1Y7a44Lu0tn4S6xeP5dY+DtWSsCw=;
        b=F3dCKHymDFasmy7j1zaCAP8FWbSXFbBFz8sigEeaBILiuSQ0qxlgFIIKWIMU2r3zUcwVV+
        at6iAJx67p/dkMyyoetN74F6ED267pk6LsEtFhXDK653kNOC/uTuCs4ZOTBkCgrYeP4JjW
        TtbjnoiR7v0lPEjX2RpCpvZZWGaiUUUNIUIvnkYn3mI+JNljJX8dJJc1Z76JxM5Qwt+6ER
        5uz+hUOV1izIvK+xRVtnXzJoplzRFXJZgUbj9+pRqdDohxvtd1Uy2v9aPtHkI5eF7ndnxY
        xBExL5qnTbTL+RO1g1AATFfXcdZTuZszlazPbDeGNmATpbNNV44GxJfZU8XAUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674569407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0brk5AuYt/Z43z1Y7a44Lu0tn4S6xeP5dY+DtWSsCw=;
        b=LeUTHJ8te7L9EUECS/vIh9O6U3pgwxsQ12wJW2nWq1nUkzRp+waWZN9PjuCASBpC5e/sRT
        2PsAkakYBmTBi4Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [rt-devel:linux-6.2.y-rt-rebase] [printk]  5342b8e20b:
 hwsim.ap_ft_eap_cui.fail
Message-ID: <Y8/mviV4zZbxgy1x@linutronix.de>
References: <202301242146.213fe56e-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202301242146.213fe56e-oliver.sang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-24 21:23:54 [+0800], kernel test robot wrote:
> d144a18b3d136079 5342b8e20b15e5fb37e49de2435
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6           83%           5:6     hwsim.ap_ft_eap_cui.fail
>            :6          100%           6:6     hwsim.ap_ft_many.fail
>            :6          100%           6:6     hwsim.ap_ft_pmf_bip_cmac_12=
8.fail
=E2=80=A6
> Roaming association rejected
> Traceback (most recent call last):
>   File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 534, in m=
ain
>     t(dev, apdev)
>   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_ft.py", line 1519, in t=
est_ap_ft_eap_cui
>     generic_ap_ft_eap(dev, apdev, vlan=3DFalse, cui=3DTrue)
>   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_ft.py", line 1485, in g=
eneric_ap_ft_eap
>     run_roams(dev[0], apdev, hapd, hapd1, ssid, passphrase, eap=3DTrue,
>   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_ft.py", line 273, in ru=
n_roams
>     dev.roam(ap1['bssid'])
>   File "/lkp/benchmarks/hwsim/tests/hwsim/wpasupplicant.py", line 1238, i=
n roam
>     raise Exception("Roaming association rejected")
> Exception: Roaming association rejected
> FAIL ap_ft_eap_cui 2.405507 2023-01-21 20:29:33.761610
> passed 0 test case(s)
> skipped 0 test case(s)
> failed tests: ap_ft_eap_cui

This looks unrelated to the commit question. Please check.

Sebastian
