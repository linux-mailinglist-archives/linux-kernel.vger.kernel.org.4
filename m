Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13C72AFB3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 01:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjFJXbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 19:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFJXbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 19:31:11 -0400
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531030F7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1686439865;
        bh=tXNXBoX/8GWPAzhXpR088r8mBroUaYWOvlVGNgeHP54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QUIZZLNWsxy9FQkbR2yluVKdvB6uTBQTY+2lCOb5ht41ZWGLzPFsiAczavHRltlZ3
         0fwpVj0ZUBPdLsCdiEck3xyq99dJk5CjGqkZ1WM7K95M9GQqb5qPyUwo2SSPve9MRL
         jHrQt9O1OYxAqFpHZwSJJAwFHCFOKyH46fXtFgsc=
Received: from localhost ([101.224.149.128])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 7C416E97; Sun, 11 Jun 2023 07:31:04 +0800
X-QQ-mid: xmsmtpt1686439864tva22xybf
Message-ID: <tencent_72C3F44CD3565F83575F5632D9574C331208@qq.com>
X-QQ-XMAILINFO: N55MlACpQQDvPmFA5/PFp+NUprXsnOa3gaeg+T0xnTJErPckCigM5gNWVKebJn
         Z0dB47tzM2nUg/kItl8WxsIjNkYDSHK4N8yC6Om9OrzKTGRQrCaNS4XbBM10EZHbkfuVQbXeDRCs
         YQz1kdqebSWsVPgNi0w5DDHschLNwO2nBiCwbEZxiLN9A5s0lNsjSIFifyyt70hVadNYpsn/6GzF
         EBENGowGgu1IAIcrvQp8+CpszIfeV3aIXWMYEkr8BvTrPzfiluExXEm1dYjMkQI63Huun2A+MSHs
         y2GfDN23pwkOBrfWD05k1C9SLI9o3m4lz2qbIjkjVoaUySKePNOivS2FfIsQK81QnxfdId07OZCj
         9PvQNtKeNpjzIMlhWaSqFcdjXPCfP+gY+RQpcVVNUHOqyd17qxrtE9Wwy48orR+JMYx9lmMkPL0D
         faFQb8aCbk/YCrPRdC8RPJCzeK0k3JWOAoCfTQ7e+O+7ctlFHnNhGqQ4DTuWsd0jfM6NJb6WvwmG
         he8VW0FMNSKboloBNI04CAPmohAESTgUO1jPuWPqJ1CVUAXq1k2qgM3lcyBvAEEx5P72oJqtchkd
         iDUXjna4Xe/AHxiO7gY9KRe1D12RmxIFg3ESKsHRMnWpAlmqhdjoefjkG4wE05E4XHsXXxHAmVzV
         0jdlcnZzwmG9F3wiPc/zXBkj++7SUz9C5gjD2nCtR8iMewQ/7syLuKtVWENmRGFQ0LgjelgjxGq1
         XowJ6G09mS+DT6Q91z42+mEggtL2/+KqLDpsQCyptehxFDoi4uZCIsa+30N9e8pJgIxrFQv0dwN7
         HmRPy2l3HnPmRo94+Fd/AC/1xt7y4lOrYIkG0vPd8+d1hA42nWzelpcFp+DGf/+oyH/bt+isyhUo
         QrWfJsS3hUByijKI2z4DStf/Id5+Jrb+oTrsfM9jHbJyQjRNW3piqtGAKnjgc58w40T0wJZYOvqQ
         EW15Wqlu7+VMYoBZQmbgItqozuu4ht
Date:   Sun, 11 Jun 2023 07:31:03 +0800
From:   Woody Zhang <woodylab@foxmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move memblock_allow_resize() after lm is ready
X-OQ-MSGID: <ZIUHtxzmBi8h3JM+@dev>
References: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
 <20230610-ultimate-moisture-630c7672358b@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610-ultimate-moisture-630c7672358b@spud>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 04:44:19PM +0100, Conor Dooley wrote:
>On Sat, Jun 10, 2023 at 07:43:20AM +0800, Woody Zhang wrote:
>$subject: "riscv: move memblock_allow_resize() after lm is ready"
>
>s/lm/linear map/ if you resubmit, please.

Thanks, will send a v2.

>
>> The initial memblock metadata is accessed from kernel image mapping. The
>> regions arrays need to "reallocated" from memblock and accessed through
>> linear mapping to cover more memblock regions. So the resizing should
>> not be allowed until linear mapping is ready. Note that there are
>> memblock allocations when building linear mapping.
>> 
>> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
>
>What commit does this fix?

Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")

Will add this tag in v2.

Woody

