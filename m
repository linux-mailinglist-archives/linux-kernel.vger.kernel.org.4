Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0EB6461C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLGTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGTdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:33:44 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932174385D;
        Wed,  7 Dec 2022 11:33:43 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D66BE44A;
        Wed,  7 Dec 2022 19:33:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D66BE44A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670441623; bh=OunyzDEn0hexTZKE6iJIUjkBndX+Ri10/Lc2KEbBMNo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=d4WaCIAQfv5VJ1n8MpuZpeAyKcU4m8oCSbkGbv9ILOGg1FU3VEGcNpRCc3vZCPUkC
         fi4Yg9fCBcHs5HFYHr3tC017XmgAUW5/SesRCz2wP1MCv8GAtN/GK2ZMfjSwbK+usX
         AngKVNBBo/av9hucBPkP1LVUDj1qYqfLWW6S369xrLT28/XLHQXpKtHMVlNrvYXzyF
         ckYI0If+XgXVK8JJ6w1mWirlSEsZ+E9RoHGuKmtSXAY5yEG4tWN+QlFIL+BF68dfTA
         tBOWnnmj13RNXzK+4YHtJ4QqMq4lv17h4+Ghkp83yw7VUwtGK+GLHHAmc3AWbndNhn
         YNzbxfzRMmA+g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>, akiyks@gmail.com,
        ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org
Subject: Re: [PATCH v3 1/2] docs: Move rustdoc output, cross-reference it
In-Reply-To: <5887a9cd-b48e-e2af-7639-3f9ff53fcd8a@amd.com>
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
 <20221206153151.771038-2-carlos.bilbao@amd.com> <87359r39gg.fsf@intel.com>
 <5887a9cd-b48e-e2af-7639-3f9ff53fcd8a@amd.com>
Date:   Wed, 07 Dec 2022 12:33:37 -0700
Message-ID: <871qpbknzi.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> On 12/7/22 2:27 AM, Jani Nikula wrote:
>> Also, please don't use "here" as the link text.
>
> Why not?

Among other things, that makes things harder for people using screen
readers and other assistive technology.

Thanks,

jon
