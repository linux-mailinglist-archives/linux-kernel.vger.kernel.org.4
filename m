Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311C6717A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjARJ1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjARJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:23:17 -0500
Received: from fx304.security-mail.net (smtpout30.security-mail.net [85.31.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F05D907
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:48:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx304.security-mail.net (Postfix) with ESMTP id 75B279D06D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674031685;
        bh=QVq+CBzYDDMb5kunZdCzN9uja8zmEoG988yADPtX/T8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gXjP663Wf1F7ZYR/1plbm3DX9jXpBDYmGTDuP43BdZdwrbtqGPIsY6xZjBGqbbFei
         /LUOhZR7DWXxebbup6O1EjOTpUd5GQkJVXIFMiI0lfaNl3M+1VfmikLMhC1l20PfEI
         Ccwl/kSY09gt3isJoHq9R3lctIf0/WYfx5wtgF4w=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id 534809D021; Wed, 18 Jan 2023 09:48:05 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx304.security-mail.net (Postfix) with ESMTPS id B70559D065; Wed, 18 Jan
 2023 09:48:04 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 8AA0D27E0431; Wed, 18 Jan 2023
 09:48:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 6F12027E0430; Wed, 18 Jan 2023 09:48:04 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 wmXiccehnwry; Wed, 18 Jan 2023 09:48:04 +0100 (CET)
Received: from [127.0.0.1] (unknown [192.168.37.161]) by zimbra2.kalray.eu
 (Postfix) with ESMTPSA id 0848227E042C; Wed, 18 Jan 2023 09:48:03 +0100
 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <1338a.63c7b244.b5e0c.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6F12027E0430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674031684;
 bh=u1A225PZFoQvqVh5iwZ9W91wmLPAtvqDIF8coPkNg+c=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=amcMjdTAVc8wXgTP0xRgi2L1N2LgatYKKpRZAOu2dPzCgCqdUD0XRI0Y7x5oZ7sIf
 jl13FWTdi3h2lQ83bosZkUW6tRZ4l7ZFChipih+8hFnw3+O3TdGY3nMctuE5A38wHc
 NN5x67RLS1qdq8IrwDKG04l4MkbUCv4+C+4CPcNs=
Message-ID: <eaba8723-606b-4f77-c647-afb3071f7496@kalray.eu>
Date:   Wed, 18 Jan 2023 09:48:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 02/25] kvx: Add ELF-related definitions
Content-Language: en-us
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Clement Leger <clement.leger@bootlin.com>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-3-ysionneau@kalray.eu>
 <875ydnmhcv.fsf@email.froward.int.ebiederm.org>
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <875ydnmhcv.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/01/2023 22:35, Eric W. Biederman wrote:
> Yann Sionneau <ysionneau@kalray.eu> writes:
>
>> Add ELF-related definitions for kvx, including: EM_KVX,
>> AUDIT_ARCH_KVX and NT_KVX_TCA.
> Has someone written an SYSVABI architecture specification for
> your architecture?

Internally at Kalray we have an ABI document, I started a discussion 
about its publication.

It will not be part of the V2, but I'm working on it.

>
> I feel uncomfortable with the linux-kernel headers being the
> authoritative place for the ELF abi definitions.
>
> Especially since the linux kernel does not deal with relocations,
> and the kernel headers could diverge from the real world and no one
> would notice..
>
> I know at least at one point the linux standards base was taking
> up the work on collecting up some of these definitions.  I would
> be happy if there was anything outside of the linux kernel that
> people could refer too.

I completely agree with you!

Thanks for the review.

-- 

Yann





