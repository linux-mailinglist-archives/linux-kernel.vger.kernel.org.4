Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C969567157B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARHyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjARHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:24 -0500
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9184DE31
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1674026643;
        bh=W3y7SXxlqmuaiDN1VFmGYREeBAf0rKvsIwCh+dZqj3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XSq+IGjDtS96Evu7CCeFZV/ZHBY2bZIV1tgEgqSmKGhhhV4iCgYg76laMDatiax5u
         9Ka8YIgVxOW+LxxJbVyN2UI7rlFSu9FZiFb/QHZ/AK1XJvkJaG+Rq/yc6/GvJbAfsv
         fOht20SrDWeUB+eL7uhwFqssc8G0ziGlreqYoQuE=
Received: from localhost.localdomain ([111.199.188.149])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 5FBA78C8; Wed, 18 Jan 2023 15:23:59 +0800
X-QQ-mid: xmsmtpt1674026639tnc9jsvaw
Message-ID: <tencent_6BA336883F064B42805919971C2AC6AFF508@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTjBzRjR6taHxYvv7EIMRdR4+2QPNbnb7dIn19MGZXo4uiQYPUUh
         alzSBzPRl6Lh0FXdSN88xkGYK8aWGjig/4LUyLtHcTYzshMLKw3Q9ktcQJJdcN3/9E8q7Kn10nCx
         6AfRKdTIRZXKAY2GuLwcnwi+fjgi0MqhTlZmxb8H1BwxH6XOxYM2vM7cCKzY5ZaA7CWX+QKPkMN1
         4v3Mnpt67LjlOT4cHqaNKz1paU4bFf88M3uNIow0pY+yx2dV04tGZcHVVJrdxLYvo/ULmLZczYAL
         hj7OA5vigWvIhyhRVwRRd2aVdZu54JlFBBoFZjZqPp5ouHHM0EoRPW0vSiXvIa4PpV8lQVnNO/yN
         jdVMh1Wttzo8n8/kwG6k6hosksf0ufRSTLFkMaoBxzhrYwIfcVK5aqdm5k/CabMH93RKqPYvs88w
         9WoLsZ/6nG60o4eyTB5qg2f1IiCRhseU2HHMAI/K0ur95uzicHCvY7oKMAYqhzv0fDy1lzBHaAyD
         wCVlnNVmgv7LT7fyYuVI8Pkn2oRmTtkVSzOOmwudXffA96s/KzmGr51ppy1IrLWAkaZPV3cOTExn
         uMd8y5CXw4WBW5Lfuwq44M8eigPELAPI+7fu/bbcS0EzjclC4ryaRgOtbzaxBs05a9bHT2nHgGQM
         vtCg85xAulO2e3+XMS0hg6qSq9cNAC7jnZnHKAY3wilCQgN5UQDt6IToWSLXA6Jbw1I/5uDvX3md
         WEM9WE/mtM1h2Ko456RWqcLUELZ3y4Wg4GCWLix8swElnkaIV0kh6C1J0wwALcoljA8pzO6A8hNg
         1biupjf9iAvdKICK1gEb9crSaEmDlqF/OwXONdv6kop5hd6/l4eWhacGHsd1maU7n1TVvaaZs3Rz
         AsTnEW7TBPV4t8S1OjYklIbfamYOcasqN5hgWcFdeInBAFyq8ZC6qqLgX0wNa2I71k2JzTUDk8ak
         4MX4SXNblkju1cP7o3cNHZ/hGeV9L3L1AuL2vaFCj5DEPsTC+Xrl5X7ZSBqxST7TzFT9yplFY=
From:   Rong Tao <rtoax@foxmail.com>
To:     vbabka@suse.cz
Cc:     42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        roman.gushchin@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, yhs@fb.com
Subject: Re: [PATCH] mm: Functions used internally should not be put into
Date:   Wed, 18 Jan 2023 15:23:58 +0800
X-OQ-MSGID: <20230118072358.63932-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <ae5ccd01-f43f-1228-414b-48491e477768@suse.cz>
References: <ae5ccd01-f43f-1228-414b-48491e477768@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vlastimil.

Thank you for your reply. Indeed, BTF can eliminate the existing problem
of data structure parsing. But as far as the current BCC[0] code is
concerned, more surgery may be required.

Now the bcc problem[1] should probably be solved by the bcc itself using
BTF, and should not bother the kernel. I hope the maintenance engineers
at BCC can agree with this. Thanks again.

[0] https://github.com/iovisor/bcc
[1] https://github.com/iovisor/bcc/issues/4438

Best wishes.

Rong Tao
