Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF92C5EFDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiI2TOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiI2TOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:14:49 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241F113FB7;
        Thu, 29 Sep 2022 12:14:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1A3C734;
        Thu, 29 Sep 2022 19:14:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1A3C734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664478883; bh=Dalettx/wHDsttqTo3jOHGLJpEGvUL0FT9FOrU3OHUk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GCyY6RY75+MFCi3d8nVUAQfiifX83mm/aCo0SYVRXyBXTo/a562MU0aM4s5v4UdTB
         tU1rbpchTHXGd92VrpoX/RPD4TYgNnDMT7lbq92YQvRMyAmV4V7zZDB6GzHr7L+op4
         BFrfX1bkqa2x+rEh0oO/1TIP+5bif8mWMRqhzybIZmfXuipOHXVZbKKVamdRWZsmQb
         i24kmKwL3HMMKrlQjMBwVCdgOANh2IOsa+UdZ76cqxUOmUK9Kuefb38w13u+lcysc9
         3VOP5mBAbUw6WVHLf/U6rStYJfsTFXkxok+XzXTFxlyswKGzXZi1Dxl6d6bOPanU0r
         CGHict7VMRwMA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs/doc-guide: Add documentation on SPHINX_IMGMATH
In-Reply-To: <2429b482-089e-8678-2c10-176cab612426@gmail.com>
References: <a67e3279-6bc7-ee2c-2b49-9275252460b0@gmail.com>
 <2429b482-089e-8678-2c10-176cab612426@gmail.com>
Date:   Thu, 29 Sep 2022 13:14:43 -0600
Message-ID: <875yh6hu1o.fsf@meer.lwn.net>
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

Akira Yokosawa <akiyks@gmail.com> writes:

> On Fri, 16 Sep 2022 19:08:05 +0900, Akira Yokosawa wrote:
>> Now that building html docs with math expressions does not need texlive
>> packages, remove the note on the requirement in the "Sphinx Install"
>> section.
>> 
>> Instead, add sections of "Math Expressions in HTML" and "Choice of Math
>> Renderer".
>> Describe the effect of setting SPHINX_IMGMATH in the latter section.
>> 
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
> Gentle ping.
>
> Jon, is there anything I need to do for improving this?

Nope, just need to wait for me to recover from the fall European tour...
applied now, thanks.

jn
