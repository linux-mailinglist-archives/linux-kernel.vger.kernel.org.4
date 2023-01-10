Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91EA663C31
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAJJFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbjAJJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:04:32 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D552D192A5;
        Tue, 10 Jan 2023 01:03:03 -0800 (PST)
Received: from loongson.cn (unknown [112.20.112.33])
        by gateway (Coremail) with SMTP id _____8BxrOrFKb1jKrMAAA--.2152S3;
        Tue, 10 Jan 2023 17:03:01 +0800 (CST)
Received: from [192.168.100.127] (unknown [112.20.112.33])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+TCKb1jhE4XAA--.5820S3;
        Tue, 10 Jan 2023 17:03:00 +0800 (CST)
Message-ID: <5813531d-6b58-9b2d-cff1-b6f296021746@loongson.cn>
Date:   Tue, 10 Jan 2023 17:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: move cpu-capacity to a shared
 loation
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, palmer@dabbelt.com
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org
References: <20230104180513.1379453-1-conor@kernel.org>
 <20230104180513.1379453-2-conor@kernel.org>
From:   Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20230104180513.1379453-2-conor@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX+TCKb1jhE4XAA--.5820S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr4xArW3Ar17JFyDuw15Jwb_yoWruF1xp3
        9rCFWxJ3WftFy7Jas7XF17Jr40gry7Aa1UGF1kKw1kGwn8ArWrt3WSvws8ZF4UCry0yFW7
        tF10g340gr10yr7anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 1/5/23 02:05, Conor Dooley 写道:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> RISC-V uses the same generic topology code as arm64 & while there
> currently exists no binding for cpu-capacity on RISC-V, the code paths
> can be hit if the property is present.
>
> Move the documentation of cpu-capacity to a shared location, ahead of
> defining a binding for capacity-dmips-mhz on RISC-V. Update some
> references to this document in the process.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

> ---
> I wasn't sure what to do with reference [1], but since the property will
> be the same on RISC-V, I left it as is.
> ---
>   Documentation/devicetree/bindings/arm/cpus.yaml               | 2 +-
>   .../devicetree/bindings/{arm => cpu}/cpu-capacity.txt         | 4 ++--
>   Documentation/scheduler/sched-capacity.rst                    | 2 +-
>   Documentation/translations/zh_CN/scheduler/sched-capacity.rst | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
>   rename Documentation/devicetree/bindings/{arm => cpu}/cpu-capacity.txt (98%)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 01b5a9c689a2..a7586295a6f5 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -257,7 +257,7 @@ properties:
>   
>     capacity-dmips-mhz:
>       description:
> -      u32 value representing CPU capacity (see ./cpu-capacity.txt) in
> +      u32 value representing CPU capacity (see ../cpu/cpu-capacity.txt) in
>         DMIPS/MHz, relative to highest capacity-dmips-mhz
>         in the system.
>   
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/cpu/cpu-capacity.txt
> similarity index 98%
> rename from Documentation/devicetree/bindings/arm/cpu-capacity.txt
> rename to Documentation/devicetree/bindings/cpu/cpu-capacity.txt
> index cc5e190390b7..f28e1adad428 100644
> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> +++ b/Documentation/devicetree/bindings/cpu/cpu-capacity.txt
> @@ -1,12 +1,12 @@
>   ==========================================
> -ARM CPUs capacity bindings
> +CPU capacity bindings
>   ==========================================
>   
>   ==========================================
>   1 - Introduction
>   ==========================================
>   
> -ARM systems may be configured to have cpus with different power/performance
> +Some systems may be configured to have cpus with different power/performance
>   characteristics within the same chip. In this case, additional information has
>   to be made available to the kernel for it to be aware of such differences and
>   take decisions accordingly.
> diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
> index 805f85f330b5..8e2b8538bc2b 100644
> --- a/Documentation/scheduler/sched-capacity.rst
> +++ b/Documentation/scheduler/sched-capacity.rst
> @@ -260,7 +260,7 @@ for that purpose.
>   
>   The arm and arm64 architectures directly map this to the arch_topology driver
>   CPU scaling data, which is derived from the capacity-dmips-mhz CPU binding; see
> -Documentation/devicetree/bindings/arm/cpu-capacity.txt.
> +Documentation/devicetree/bindings/cpu/cpu-capacity.txt.
>   
>   3.2 Frequency invariance
>   ------------------------
> diff --git a/Documentation/translations/zh_CN/scheduler/sched-capacity.rst b/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
> index 3a52053c29dc..e07ffdd391d3 100644
> --- a/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
> +++ b/Documentation/translations/zh_CN/scheduler/sched-capacity.rst
> @@ -233,7 +233,7 @@ CFS调度类基于实体负载跟踪机制（Per-Entity Load Tracking, PELT）
>   
>   arm和arm64架构直接把这个信息映射到arch_topology驱动的CPU scaling数据中（译注：参考
>   arch_topology.h的percpu变量cpu_scale），它是从capacity-dmips-mhz CPU binding中衍生计算
> -出来的。参见Documentation/devicetree/bindings/arm/cpu-capacity.txt。
> +出来的。参见Documentation/devicetree/bindings/cpu/cpu-capacity.txt。
>   
>   3.2 频率不变性
>   --------------

