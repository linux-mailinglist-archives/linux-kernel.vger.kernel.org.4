Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D573D42A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFYUjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 16:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFYUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:39:11 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F69B;
        Sun, 25 Jun 2023 13:39:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 989DD6E3;
        Sun, 25 Jun 2023 20:39:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 989DD6E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1687725550; bh=91KDkRnMDMkm4N0w41LCfJDj2m5VI4NpTsLsFSLzOpg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G+4t+1Ntam7xjexenOC304wsk0nBhdNKPM0FeXhBrDv/yRwEI1Mp9lS86YIt0z1Zy
         AbBsfQKBdSlKUQWt+QVIivwX8KwTX2PYkspYW9F7wsOjB3coYYOwPaAFF3O046QSIe
         59bwzZJu5r1jGmSP7mLCh2lhutjDphoywRQU9WJNjSLjnuBMRqrnBa7SxzvnZr5Z1x
         g+jtbAh92YsnxBzX17F+x/zs6nvBVOZdNAa/80vFSfguUuS+o5kEdpHrH8rfsTGkUg
         LMf2QWKxHzk0GzQuEilotmTQlsXVGovUM/NPfPEhkWmER7yqvLttu8nA6HSQNMw/HL
         EWt7XHcNPIbmg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?utf-8?B?Qmo=?= =?utf-8?B?w7ZybiBUw7ZwZWw=?= 
        <bjorn@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3 2/3] Documentation: riscv: Add early boot document
In-Reply-To: <CAHVXubhk2xf59XbNiRYKdr4J1yadpeX0KMgW1cFMR4GRN97MYA@mail.gmail.com>
References: <20230623095547.51881-1-alexghiti@rivosinc.com>
 <20230623095547.51881-2-alexghiti@rivosinc.com>
 <87o7l6mgxg.fsf@meer.lwn.net>
 <CAHVXubhk2xf59XbNiRYKdr4J1yadpeX0KMgW1cFMR4GRN97MYA@mail.gmail.com>
Date:   Sun, 25 Jun 2023 14:39:09 -0600
Message-ID: <877crrl1jm.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

>> Please don't use :c:func:.  If you just write setup_vm(), all the right
>> magic will happen.
>
> The magic indeed happens with virt_to_phys()/phys_to_virt(), but not
> with setup_vm(): is there something we should do when declaring those
> functions?

If the function in question has no kerneldoc comment, there will be
nothing to make the magic link to.  In other words, if you want it to
link to the documentation, the documentation needs to actually exist :)

Thanks,

jon
