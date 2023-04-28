Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98216F1ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbjD1Oux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjD1Oun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:50:43 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C826A5;
        Fri, 28 Apr 2023 07:50:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8683B37E;
        Fri, 28 Apr 2023 14:50:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8683B37E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682693442; bh=Smvf1SZe/VpXmNmj4kak6qasoAtMRIIGN77Gamt5xbU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=E0z4uHk1q4di8eEFomIrW7kpUDyr+hhkxCM0SGh2zgNg8dMa2v/zf3xzbSZ9gNtMc
         gZoUUUseYYxtoS+IOf27cbqmUACPv7KWIFscw2QFwWp79uWPKGOQdgQ87k38ZJjHEg
         ZxyQqIma1dO54VMuDslC8vz8HiNYbhnJFBCvTqFxXGJuuRoQYNXcx4QcKjwjIXKuLo
         5H8A4JKkrrITrTinDKQcFynglDr8LTsizThtdl7Kr4p4sVtfo08+jKDjsbFk9G7/Ek
         2dkHZCJxSdLST4vwUX94qb6e3JOZG/An/m1hdnnAI7BCuOBPVfJxkZLA+g3AVj3Mcn
         HbbNqcJ3W/ngA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>, wangdeming@inspur.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shibata@linuxfoundation.org
Subject: Re: [PATCH] Documentation/translations/ja_JP/SubmittingPatches: fix
 some typos
In-Reply-To: <71c91ae5-2ed7-cfd5-7b7f-6cb5a0141816@gmail.com>
References: <20230428091018.1558-1-wangdeming@inspur.com>
 <71c91ae5-2ed7-cfd5-7b7f-6cb5a0141816@gmail.com>
Date:   Fri, 28 Apr 2023 08:50:41 -0600
Message-ID: <871qk4awn2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Your patch is rejected by "git am".
>
> In the header part of your email, I see these fields:
>
>> X-Mailer: git-send-email 2.31.1
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset="y"
>> Content-Transfer-Encoding: 8bit
>
> This looks broken.
> Please make sure your email header has a proper Content-Type
> as shown below:
>
>     Content-Type: text/plain; charset=UTF-8

This something that git send-email does on occasion; it's truly
obnoxious, and I have no idea why.  I end up fixing up patches by hand
when I see it.  If the change itself is OK, I can manage it from here.

Thanks,

jon
