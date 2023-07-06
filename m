Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CEC74A5EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjGFVcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjGFVcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:32:43 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D61BF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:32:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55b1238a013so887817a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688679158; x=1691271158;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6v/ILGDbyO6izqW0/CzDnGZbd6OjuOMQSm83GDcJTo=;
        b=ycQN4SuI86QJ69YA41U57qJyI5IB1K4PefdWdSeAGvL2//RXCpt16YPSRvpSgNZMQ+
         huEfQoBKxicH82/xLldnayx9uqqfSIQQD6/7WOZ4rfAmkGF6/ViAIpjJ1NSPTBkQw/6r
         CWlK3punnKzR0Db8gNyzl63oc6tqNolNiwO2JxLvf2HU+WE+mF0dHeNwQmXKwDQymMom
         8pF2sajUDgwzNCmqc9WQnGcWIP2YqAeJ2BopF2lUrW7vfboiPosB7cSOkT3NLByMThUH
         JRblsIor2yR+5Jl/1NIlo7lg3GhPsHYIDgWvFOxn5Pg3npMPE29+ZH7PVYrLvADP58e1
         jfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688679158; x=1691271158;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6v/ILGDbyO6izqW0/CzDnGZbd6OjuOMQSm83GDcJTo=;
        b=S1ITex8eaw+R1kBGAMbG9AfRPBSXuPuIGzXWS8/yAsp6S8+gkg92PaOLm6Muv8tHkh
         ttq7cYHndkOxjZh5/z4/UoEC5BY+p9eIgRWBjBCBMiQu6ZSwnB8rEKJ0GmX8xf+1Kx7X
         9jKb6MGeTT2UXxze4o7EX6Hm8NswNVoywevdNWL01A1gnuzRkN/Gm2nAoNG4ExD3Pu93
         udZqa5dsWG5Uu/wT3jBZCYTkwbaptesbSncI/yRzfowDybiwe78jGd3sRz44GFWJ492k
         hXt02wBzLdPGgQS5apNc1ZUBF/q7JSKd811IfQqY/2DdtSLKlOo8gWGjHefP5TzH/Kqd
         9Hbg==
X-Gm-Message-State: ABy/qLYs8pgAatjLpjTzvseokP1caAFXXaI6qX93waNEpIQgCFYda7Ze
        xtyDouUB+lRBY8zFZxfdriG31A==
X-Google-Smtp-Source: APBJJlEsMDo/o3Ml7k+rB/oRadWtQM90v+nx/vC5/uWVqs97yvJbqK2JmJngQaF5+v4IZtUvjxTMcQ==
X-Received: by 2002:a17:902:c951:b0:1b8:3e15:46a1 with SMTP id i17-20020a170902c95100b001b83e1546a1mr3944703pla.67.1688679157789;
        Thu, 06 Jul 2023 14:32:37 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b001b549fce345sm1835412plc.230.2023.07.06.14.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 14:32:37 -0700 (PDT)
Date:   Thu, 06 Jul 2023 14:32:37 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jul 2023 14:31:51 PDT (-0700)
Subject:     Re: linux-next: Tree for Jul 6 (arch/riscv/)
In-Reply-To: <9d9e2902-5489-4bf0-d9cb-556c8e5d71c2@infradead.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-a4ed8be3-1e00-4604-ac93-29d893829988@palmer-ri-x1c9a>
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

On Thu, 06 Jul 2023 14:27:53 PDT (-0700), rdunlap@infradead.org wrote:
>
>
> On 7/5/23 18:57, Stephen Rothwell wrote:
>> Hi all,
>>
>> Please do *not* add any v6.6 related stuff to your linux-next included
>> branches until after v6.5-rc1 has been released.
>>
>> Changes since 20230705:
>>
>
> on riscv64:
>
> WARNING: modpost: vmlinux: section mismatch in reference: $xrv64i2p1_m2p0_a2p1_zicsr2p0_zifencei2p0_zihintpause2p0_zmmul1p0+0x14 (section: .text.unlikely.set_bit.constprop.0) -> numa_nodes_parsed (section: .init.data)
>
>
> Full randconfig file is attached.

Thanks, I'm giving it a look.  Do you happen to also have your toolchain 
version easily availiable?  The mapping symbols are new and we've seen 
some odd stuff happen, something is likely broken somewhere...
