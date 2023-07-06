Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87D074A61D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGFVqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGFVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:46:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F127E90
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:46:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8a8154f9cso8396765ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688680011; x=1691272011;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNi/IufnbMEMmIYXZ/wf1/LO6krGFVyjl9tQSF72+B0=;
        b=M1oTkO5RyIT5ONpZYq4JUC5F0qKdwhTZn89dRhbPUjuqUzgfQx3rO1RmjmOzD0eX5Q
         0sAj2Wadr8WsQivNN3bz8SKMgPN7yVS6JI/T1ien1zjqMZQ8sCeWjNCuQFtN3HJc1hXO
         qnyLwwE5BCXWOlNU5kOZFarqJr/+4+b1JG016/C2gwNU7EuSGuSMMOEFXfPlfJ/1i/Hg
         1jHGIoZkSHRez+oZLhA4YNs1+wIuzTsXxtJH/KtwaHhH258jm2OvKEyO6UZDSStklzR0
         32l4evn9EjFn9N0/X3TWCuZY9zmGzyQHJfYq+WVGdasOSEaWQ1OafcKS44aDXVVZX8Ci
         rVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688680011; x=1691272011;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNi/IufnbMEMmIYXZ/wf1/LO6krGFVyjl9tQSF72+B0=;
        b=bNshafNLMuPYLO9L106k11oeOiw905OAvmGv/oL6XkrHs1DBczYZUVkfpF6qO8rj2X
         JLxrtf0/tBDHMhxRlcef4kPkMY34tlQ/zp0dIOlzOyAc7lT0K5ziaTgvIA8yd4qJK5DT
         e4+5L8ytsT2+/tiqCCD8haf3lgygd+IGPVkymx3w3tJD3xEIDLZdwRgnnAmubmVWcTsb
         UbVvnMPEkdWAAmh4nis/d+IE9QMSWof+uH0BFdZBNYdeYyiKGi/JHBB76V5ZUE86Lb/h
         bnc+ZWl2OSsPR96KuH0ZiGLvjm+OE56WLuHbXiKicDzJ3icvohuMXWtswjDCmZE2tkDC
         fbXQ==
X-Gm-Message-State: ABy/qLZ1/a7muXT1h7jXfLA8Fi3YTZ4MPY3NaD4FHfv+vfJLwWGB9syZ
        wz5hF7jVkHDaMi9xIdo1mwf9fQ==
X-Google-Smtp-Source: APBJJlF+X0KmiIKjuZDmk5537yorVa9KnlcKxVe3cLUx4XTg7EFQ0d9PIZTElsyekXpylROYbY9gFA==
X-Received: by 2002:a17:903:446:b0:1b6:783d:9ba7 with SMTP id iw6-20020a170903044600b001b6783d9ba7mr4241983plb.27.1688680011289;
        Thu, 06 Jul 2023 14:46:51 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902bf4b00b001b84cd8814bsm1849090pls.65.2023.07.06.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 14:46:50 -0700 (PDT)
Date:   Thu, 06 Jul 2023 14:46:50 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jul 2023 14:46:00 PDT (-0700)
Subject:     Re: linux-next: Tree for Jul 6 (arch/riscv/)
In-Reply-To: <62e993a5-0bb4-40dc-6399-f60525300a6c@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-6e5d4a84-8aef-406d-b0cd-8f195f531354@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 14:36:05 PDT (-0700), rdunlap@infradead.org wrote:
>
>
> On 7/6/23 14:32, Palmer Dabbelt wrote:
>> On Thu, 06 Jul 2023 14:27:53 PDT (-0700), rdunlap@infradead.org wrote:
>>>
>>>
>>> On 7/5/23 18:57, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Please do *not* add any v6.6 related stuff to your linux-next included
>>>> branches until after v6.5-rc1 has been released.
>>>>
>>>> Changes since 20230705:
>>>>
>>>
>>> on riscv64:
>>>
>>> WARNING: modpost: vmlinux: section mismatch in reference: $xrv64i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x14 (section: .text.unlikely.set_bit.constprop.0) -> numa_nodes_parsed (section: .init.data)
>>>
>>>
>>> Full randconfig file is attached.
>>
>> Thanks, I'm giving it a look.  Do you happen to also have your toolchain version easily availiable?  The mapping symbols are new and we've seen some odd stuff happen, something is likely broken somewhere...
>
> I'm using gcc-13.1.0 from  https://mirrors.edge.kernel.org/pub/tools/crosstool/

Cool, those are pretty easy to run.  I've yet to actually reproduce the
failures, but I'd guess we just want to ignore the mapping symbols with
something like

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b29b29707f10..2f801469301d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -614,6 +614,18 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 		/* Expoline thunks are linked on all kernel modules during final link of .ko */
 		if (strstarts(symname, "__s390_indirect_jump_r"))
 			return 1;
+
+	/*
+	 * RISC-V defines various special symbols that start with "$".  The
+	 * mapping symbols, which exist to differentiate between incompatible
+	 * instruction encodings when disassembling, show up all over the place
+	 * and are generally not meant to be treated like other symbols.  So
+	 * just ignore any of the special symbols.
+	 */
+	if (info->hdr->e_machine == EM_RISCV)
+		if (symname[0] == '$')
+			return 1;
+
 	/* Do not ignore this symbol */
 	return 0;
 }

I haven't even built that, though...

These also trip up backtraces, so we probably need something over there as
well.
