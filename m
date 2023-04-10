Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526036DC8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjDJPwc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDJPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:52:31 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 308BD3A8F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:52:29 -0700 (PDT)
Received: from loongson.cn (unknown [209.85.221.44])
        by gateway (Coremail) with SMTP id _____8DxAf+7MDRk1SgZAA--.39034S3;
        Mon, 10 Apr 2023 23:52:28 +0800 (CST)
Received: from mail-wr1-f44.google.com (unknown [209.85.221.44])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxSL23MDRk97scAA--.28392S3;
        Mon, 10 Apr 2023 23:52:25 +0800 (CST)
Received: by mail-wr1-f44.google.com with SMTP id e22so4764895wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 08:52:25 -0700 (PDT)
X-Gm-Message-State: AAQBX9coGhf1LFwxNKLD+s0oeS/FPBz8PL1f8obOKn8TQGAVOp3ddZlL
        Sx9/1gy8MkK566KMXem7B3i9bHxWkDDqSV0f8D15wQ==
X-Google-Smtp-Source: AKy350Z0SXibTASV3V5jFFGhYCSINQf+RkhcRYX2e1vgAs/Dg/6ZVuBxJjoOStAac+wkhGxIvtRbo4DzJAGY/ij5v9E=
X-Received: by 2002:a5d:6a8c:0:b0:2e5:e0e8:9c8d with SMTP id
 s12-20020a5d6a8c000000b002e5e0e89c8dmr1838322wru.13.1681141942492; Mon, 10
 Apr 2023 08:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230410115734.93365-1-wangrui@loongson.cn> <b80e083baa49f0443abee66eb888fac920f66e79.camel@xry111.site>
 <CAHirt9ib2LPXMbxb+UCJB1MsBnUuWNLb5+uyqcR5Wiw2fsJi6w@mail.gmail.com> <8aeb6d8dc4cbe8c992b69d75d8953d59b71a2c38.camel@xry111.site>
In-Reply-To: <8aeb6d8dc4cbe8c992b69d75d8953d59b71a2c38.camel@xry111.site>
From:   WANG Rui <wangrui@loongson.cn>
Date:   Mon, 10 Apr 2023 23:52:10 +0800
X-Gmail-Original-Message-ID: <CAHirt9hMbQcq34Dgtc5u3=841_hzjUc4TYiEbhchZO=jkCvbVA@mail.gmail.com>
Message-ID: <CAHirt9hMbQcq34Dgtc5u3=841_hzjUc4TYiEbhchZO=jkCvbVA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Improve memory ops
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-CM-TRANSID: AQAAf8DxSL23MDRk97scAA--.28392S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
        BjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
        xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
        j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
        aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7V
        AKI48JMxAqzxv262kKe7AKxVWUXVWUAwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
        CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:36 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> Hmm, yep, GCC does not take the advantage of -mstrict-align expanding
> memcpy etc.  I'll add it into my TODO list for GCC 14.

Great! It looks like you already have some good ideas, and I look
forward to hearing your good news.

Rui

