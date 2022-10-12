Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E155FC814
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJLPQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJLPQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:16:13 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D007101C3;
        Wed, 12 Oct 2022 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z1V7rPBXjBzr2kqRD67Kh5Hz8Tm/5unrsDPeXYdp7Is=; b=D2Dp99G6LnpBE3jXmqQ+LMSC7E
        2MV6RHyMDVhfL4RkgFpPiYos8ffnDVk5GnqrN3oRXVM2BXquo4OjjRWTvJTgZn6sbBIRZIz8subCx
        q5xu8fwwD4AtaMrkeL9w15QYg2yW2I3uYza6SuFO+WhGq8pQE4tx84DEcsUd25CyzStLFmrQcbcv+
        hvk6zOt9P/bfK54biPfwTXynbN+nSxSGDcP58ZcH+0qulmTyff2TbYJ3fMh7iaBSyTxFNVx9Afrpa
        CEivguKItNtlBH2NIkxk06mFiPsndGmaIKz1oYWa7xVOY6kVydawEwLhinKTGHcCVDsg+cw5931ZS
        t6jsfD1w==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oidSm-000Gy7-09; Wed, 12 Oct 2022 17:16:04 +0200
Message-ID: <b5c84c70-6ba4-bf7b-e788-eb7eddbad47c@igalia.com>
Date:   Wed, 12 Oct 2022 12:15:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-6-keescook@chromium.org>
 <b06cdd10-3372-0613-6719-21c2fc664d05@igalia.com>
 <202210111518.A626065@keescook>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202210111518.A626065@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 19:20, Kees Cook wrote:
> On Tue, Oct 11, 2022 at 05:35:48PM -0300, Guilherme G. Piccoli wrote:
>> On 11/10/2022 17:01, Kees Cook wrote:
>>> +L:	linux-hardening@vger.kernel.org
>>
>> Just curious, why linux-hardening was the picked list?
> 
> It's where the bulk of other things I work on end up living, and there's
> an active patchwork instance, so it'll do patch lifetime tracking for
> us:
> https://patchwork.kernel.org/project/linux-hardening/list/
> 

Makes sense, and very nice that it has the patchwork set!
Thanks,


Guilherme
