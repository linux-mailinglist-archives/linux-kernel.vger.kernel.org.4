Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD38A73CE0E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjFYCem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFYCei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:34:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105B11B;
        Sat, 24 Jun 2023 19:34:37 -0700 (PDT)
X-QQ-mid: bizesmtp71t1687660461t4hq4z3o
Received: from [192.168.1.114] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 25 Jun 2023 10:34:19 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: 3Jh+sxPGtVmluKPKd5EUFDmRpnFkoh2ELXvzLjAxRXXaPj8SVbvXWVCCTaHze
        v0SK3Wfa5mGPnjWlH+2ZUJpX+Qj+SHOJ+jhbbZ3BPKh3j7kBykWtYKDj59Obz4iOgi0kfzN
        Hy+hS9pnPE5sEY0TWplX2piMdCNBDW+2wvJGsK3yoXAuYqmWGwY32LWOq3ws/986c5qLbp9
        /huydVpiaEDyDs/8WH26qbOaCPJETst29tstzmwhRM+IspIT7X50lLOVw9YJ6Cfm3Yi864Q
        rCuDEjTGPO8I4/o6CWkBt+x8TckBAGEeUisqHdvvrQ9eStxbEpb8NZ6TR17eduEtlgwOd5q
        MmZCUzltkUIVBMW2aq4fW1WnhCEDpClaiy+Zt7u5hLyY20eh5U=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10716706576352357094
Message-ID: <F2A85F463CC9E2BC+a141a56b-4685-8fb1-4eb7-aa5dcf18f9f2@tinylab.org>
Date:   Sun, 25 Jun 2023 10:34:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] Documentation: arm: Add bootargs to the table of
 added DT parameters
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20230623095547.51881-1-alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <20230623095547.51881-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/23 17:55, Alexandre Ghiti 写道:
> The bootargs node is also added by the EFI stub in the function
> update_fdt(), so add it to the table.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   Documentation/arm/uefi.rst | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
> index baebe688a006..2b7ad9bd7cd2 100644
> --- a/Documentation/arm/uefi.rst
> +++ b/Documentation/arm/uefi.rst
> @@ -50,7 +50,7 @@ The stub populates the FDT /chosen node with (and the kernel scans for) the
>   following parameters:
>   
>   ==========================  ======   ===========================================
> -Name                        Size     Description
> +Name                        Type     Description
>   ==========================  ======   ===========================================
>   linux,uefi-system-table     64-bit   Physical address of the UEFI System Table.
>   
> @@ -67,4 +67,6 @@ linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format.
>   
>   kaslr-seed                  64-bit   Entropy used to randomize the kernel image
>                                        base address location.
> +
> +bootargs                    String   Kernel command line
>   ==========================  ======   ===========================================

Reviewed-by: Song Shuai <songshuaishuai@tinylab.org>
-- 
Thanks
Song Shuai

