Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1E674CF0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjATGCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjATGB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:01:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB9E2B2A9;
        Thu, 19 Jan 2023 22:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674194486; bh=2HTFXG94hmGf8elB+ZGfbE05fbZFJ3N1BBWe/PnHMYg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=CXCcqAAjf3jrbmcESAaVjifzWD4XGAJDWhDIcbzxTaTmr1yuchXTueHqsio/yrb1G
         ft49Gqn5tkv90edo1fBSQhNqVZgk2FWuqPuRssbw523kEuH7370SgiDblq+0LM9GVM
         4l9fU+cLNOYFHj6shVb/g4oO0GoXNFYQlwJwrlmbyHjnsrka8EEU31FQc+0g5X4pmd
         irFf++3FKQvCOA5RwocFNPKtd26VOgNsQlPAby4oDnONg8M9fcEgobQQK2rEYfMFQl
         FGGAYy6HbRbAGeCz7le7lxMU8hrK05QKrtDRVpwSGxu3mDVzEsJk8igpld3PatNLLN
         20pJI5/+oseGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.244]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1oSR1g3vaz-00rI6r; Fri, 20
 Jan 2023 07:01:26 +0100
Message-ID: <c9b77d7df95c2ae354e655ada0f34ea3c83f0bba.camel@gmx.de>
Subject: Re: [ANNOUNCE] 5.10.162-rt78
From:   Mike Galbraith <efault@gmx.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Date:   Fri, 20 Jan 2023 07:01:23 +0100
In-Reply-To: <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk>
References: <Y8VSslRJZpFbo1/u@uudg.org>
         <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com> <Y8krsVFguwWLy+zT@duo.ucw.cz>
         <Y8lCspFtQ0wg6uCy@uudg.org> <Y8mwF0m+M1+e/fz/@eldamar.lan>
         <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ny3ueawLfOJf2WQgVtegw2ap7gBT/CvPRPQCFdlKZODxWZ2vuuA
 iRFFo+iiO8MWT288kxpCwH0BDCRWL8yS9dIOh5CoYDyUvSq8iDhSt2CUdGLI1JCxImxl9z1
 wgmbXrFgEGdPokq2cJ74qPSo5Uj/JU1dFoCRIY/PEP6xWFvcLM27VWGwE9xKK4dkqw2AL3j
 CjgJwcwY7ZGGGoBoTafzA==
UI-OutboundReport: notjunk:1;M01:P0:IAKBSwuht70=;NhdDCTifPmQI9s9BFfDJr57WvvA
 gBAf2dcNknJMlcmwerzfG/Brur9S1wXfcqig3zCDMrvmYihzp3tujk1RQNS597xK/2S6Pd71d
 jm2RrXZ2JXhnPklpH7kOnEmDxV7zAWg6mHy/CbieFEAsjO9P7ECSeU7fzpetRUY0Qgi3uJuFE
 o8+cc2Pml/NmUzyFbWjatt8mgot+6pKNZTK089/PQmu1M3K2Z3t/nSh0Z4v955/l0KJQ9TMwF
 5506z7U+n7ELvrBwkpatWTF562DA3sbvyHqKgfdCY5ac7PXtCCs55xLwBeAdV4ko/nqqijWO+
 k6JomYHRu+pmQLAcUJhmQ8dK7Zt4TqSSqDmGEsK4vz9dfLx+rXAqf33RHggO5rfj4afywhQdL
 8zw7PIYj8F/kvYBiUvy6Cdnp9lyGRBqUp4cHpqbB26fPK+lDeQpsuRFmbX2maysOMs9vZQtt/
 0r3OX3yOTyOoHXHDvP8FlL0MhMpDzDdxZiFjATvPZJ98Q8Rc2/sTaMyVNRLPs4VNmnEP/1XDr
 gSSHTvSqMObqiYwPl0t4sRGittA0ArzVv0ij9a0ABgEgjPaRnjG+Yg18Q1+8/vqBqVMkaaoK0
 vuPbVwqq4Ms3/b9zi5tlj0tLEWKuxexsD8WWsCT/Fd9aQHUpDRGMegHS77yaOhGc5AIWS0GIJ
 x9xWOQxH99cI5hjVm3+qDFqOd47HfgHMbBaFiS/W8lc1t1LJrpxoHrWRzVzUk10Os4CteTp19
 UbmunKzQkj/omL/Csn0NLAF3k6BfcSVqe8lcb+mc989DOG1itipR/4nStVCofyPHcZ8WEwjUI
 ICDwwLU7UqUBUZ2dRTYptv0Q2P1UgKjal6O9VRsDoz8/zwcftSC18cem25IwSZNN4Xbd/l/BX
 PRHUIxWcWPj6eTjiptxJqcnpXvNmwM6JEGnLY3m78NOJLbdKgCKn7VCk6gx/TYEn5xAEdtBHb
 G5b3CHZANeiPaOb2RM5ReyLmx3w=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-19 at 16:09 -0700, Jens Axboe wrote:
>
> I guess we need to twiddle that asm to deal with eg 16 bits, rather than
> attempt to backport any TIF removal patches.

Hm, 'mov' gets past the weird ass rules committee, so seems it should
be trivial for someone who speaks arm.  This built/booted once on rpi4.

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index d5bc1dbdd2fd..a4931bff8ea9 100644
=2D-- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -751,7 +760,12 @@ SYM_CODE_START_LOCAL(ret_to_user)
 	bl	trace_hardirqs_off
 #endif
 	ldr	x19, [tsk, #TSK_TI_FLAGS]
+#ifndef CONFIG_PREEMPT_RT
 	and	x2, x19, #_TIF_WORK_MASK
+#else
+	mov	x2, #_TIF_WORK_MASK
+	and	x2, x19, x2
+#endif
 	cbnz	x2, work_pending
 finish_ret_to_user:
 	user_enter_irqoff

