Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD71E622A9B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKILcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiKILca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:32:30 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF82DA8C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:32:28 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667993547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yu+w3QHApO1TE2YmVSkeE9AnWV+eYHtsSJh4PBsvKg=;
        b=pEMkcgyDVRTho3dCslvw5uAjkUeTmBUMKnIjLPUtnxUlcXOsVbDAoM7LFvyfvv4YPJpCXz
        SYnTMdhBHnt3hudbQnN6f8sTckrsquf/XU85CbpnKWoygOcchlnek3xwIcHDqWuDG3Zjrd
        nBH2scm75Ip+tG2TlxoO/y9wAOE7WGE=
Date:   Wed, 09 Nov 2022 11:32:27 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <6e32f14ae25909138e40b2cfd7448ed8@linux.dev>
Subject: Re: [6.1.0-rc3-next-20221104] Boot failure - kernel BUG at
 mm/memblock.c:519
To:     "Sachin Sant" <sachinp@linux.ibm.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>
Cc:     "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        "open list" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <74979021-D386-4402-BD70-167531C7405B@linux.ibm.com>
References: <74979021-D386-4402-BD70-167531C7405B@linux.ibm.com>
 <e00989c4a69943cb4f60fc7ffaa06f8c@linux.dev>
 <Y2oLYB7Tu7J91tVm@linux.ibm.com>
 <E2499567-0D0F-44DA-AC68-1E279009A6DE@linux.ibm.com>
 <58779468e28e026a1aa30a42ca7e8aec@linux.dev>
 <4fee7f2b0e99e256465ef6e7656c6349@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

November 9, 2022 6:55 PM, "Sachin Sant" <sachinp@linux.ibm.com> wrote:=0A=
=0A>> On 09-Nov-2022, at 3:55 PM, Yajun Deng <yajun.deng@linux.dev> wrote=
:=0A>> =0A>> November 9, 2022 6:03 PM, "Yajun Deng" <yajun.deng@linux.dev=
> wrote:=0A>> =0A>>> Hey Mike,=0A>> =0A>> Sorry, this email should be sen=
t to Sachin but not Mike.=0A>> Please forgive my confusion. So:=0A>> =0A>=
> Hey Sachin,=0A>> Can you help me test the attached file?=0A>> Please us=
e this new patch instead of the one in memblock tree.=0A> =0A> Thanks for=
 the fix. With the updated patch kernel boots correctly.=0A> =0A=0AThanks=
 for your test results.=0A=0AHi Mike,=0ADo you have any other suggestions=
 for this patch? If not, I'll send a v3 patch.=0A=0A> Tested-by: Sachin S=
ant <sachinp@linux.ibm.com <sachinp@linux.ibm.com>>=0A> =0A> - Sachin
