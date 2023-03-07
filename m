Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A7C6AE968
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCGRXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCGRXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:23:25 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384636479;
        Tue,  7 Mar 2023 09:18:56 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF1C02D3;
        Tue,  7 Mar 2023 17:18:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF1C02D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678209536; bh=8mHF0O3YfgYgjO86Zx5MqmA2n1FtdZ5q94ZnAzXKQHk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TA1Kh1nUJp+ndkKE7tTuK49XstwoJ79hgmzatGO49o4kG7v8UGieor19lTh7MOZYi
         ZqZr78FxJgkMgFYuBKlpP3hpFKPSX5xNK0i8Nk4NPfwhsCb6sQFGqPhr06i5gWom/K
         4cc+uf7U603k/ij91CMd9/m8zg4MFrD2v8mvl8b4E3ZNbd6TNPQ52blbx6zvKMSa2P
         kcz0om7VsEQgXN0IQFCOVkP35IaKXCqTS0kUdwOeHeoxcscOeZp5DnrKjVjVUn4wYv
         DPcrGCNDvI9BiGktazub2xVnS9rjus2Wy/Rdyk4uwaLm+9Bag0oEtA+R3xIDhnMz2H
         235zXcBXZ2tLw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Palmer Dabbelt <palmer@rivosinc.com>, suagrfillet@gmail.com
Cc:     alexs@kernel.org, siyanteng@loongson.cn, robh@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        leyfoon.tan@starfivetech.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        suagrfillet@gmail.com
Subject: Re: [PATCH] sched/doc: supplement CPU capacity with RISC-V
In-Reply-To: <87wn41wi9b.fsf@meer.lwn.net>
References: <mhng-90a89c61-02e7-4f1a-b18d-189d9b7fff72@palmer-ri-x1c9a>
 <87wn41wi9b.fsf@meer.lwn.net>
Date:   Tue, 07 Mar 2023 10:18:55 -0700
Message-ID: <87y1o8o4xs.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Palmer Dabbelt <palmer@rivosinc.com> writes:
>
>> Happy to take this through the RISC-V tree, but I'll hold off for a bit 
>> and let the doc folks have a chance to chime in (or just pick it up).  
>> I'm planning on sending something later this week either way.
>
> "Doc folks" are fine if you just include this one in the pull you're
> doing.

So it looks like that didn't happen...so I'll go ahead and apply this to
my fixes branch.

Thanks,

jon
