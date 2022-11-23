Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0E63596E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbiKWKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiKWKOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:14:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5B85162
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:02:55 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:02:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669197774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPrP1joPmfEK1Cg29zIoO/4RM/DZ4zWYnl/Vrc+/azw=;
        b=wjGpX6LLwdkC7k8OfqNT6RmTadMtyUstDRc2R71oSuFyDzmTq4U6o4gK4e5bJHP8LCmFKz
        niqj2jT61o2kKltrRSHp/rArSi1If0JLt7CDz/pkTLOWd0ixpw+Unj1BGn4aWxmxXioPgj
        E9FpOVLBlshkovN76YlebBrRqq307EHXWT9JQg3Vpg/+qy+Wb9B8CgbgChdelWj3lOZfYj
        /dSiwhsvzpKhF4Mf0btrrKaOwrrTBNW65f+0ypVuvWSF1f8Op9ZHzxBKXNmKZkU7BRM16W
        dnzTKg7TPW3O96h/Btb8fTITBLja/ghsp06ZRuC73tzrlbbU2tvcDVoyDeOXNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669197774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPrP1joPmfEK1Cg29zIoO/4RM/DZ4zWYnl/Vrc+/azw=;
        b=P2VzyOXZBCMoG5U2ugLiIZSRpVrzV/scT7dfjIhZ16ACo9YBtBMNAQpY96gvu/yEo/GPV+
        vgb9wi3jwFjkvuAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RDTSCP | IA32_TSC_AUX on x86-32
Message-ID: <Y33vzIy8Yw49R7am@linutronix.de>
References: <Y33r3w6xvEeZH2XY@linutronix.de>
 <Y33vAaDu84tU8jf6@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y33vAaDu84tU8jf6@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-23 10:59:29 [+0100], Borislav Petkov wrote:
> On Wed, Nov 23, 2022 at 10:46:07AM +0100, Sebastian Andrzej Siewior wrote:
> > Is the format OS specific and not for user purpose or could IA32_TSC_AUX
> > be setup on 32bit?
>=20
> I don't see why not.
>=20
> I mean, we wanna remove 32-bit but if you wanna still improve it...
>=20
> :-)

Do we have a schedule for the removal? I mean we talk about it for
years=E2=80=A6

Sebastian
