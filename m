Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB07412D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjF1NoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjF1NoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:44:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744710D5;
        Wed, 28 Jun 2023 06:44:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso5255931a12.1;
        Wed, 28 Jun 2023 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687959851; x=1690551851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBv8cSvMkvEF1DkMG98bpwrqP7g4vFh1aUZStsMNl9c=;
        b=Zlc1pZYlLshNBMDIZeLIFmudEhsNNxdVueSsNAVMmfG4YxQ5KunHGM745IFd7VoEgK
         1K8lzl+LKzAx7oVBL2Z7/riAJsBCfX3z3JxqCM4NYJqigC6ie/9DZodlWiN4vLRfqoLw
         1w9HzZ/FUWEOhXXRUYOAcvypkfOtRyWXrFq71+rU9WgAaTDPYPzPVtiQwi+bjxrZQs6q
         CwbheXFyDke1BS+YBQ1eNbNQ8fqaq0DHMCGULn+sq+9tIlD/9B5uqQtkyIUiHQQXvL7y
         Jlq3IPRIL6OEaKSq/QPsSV81eMiY0be/JYlz3qWw5dZLOkUkewIVXrBJo/eGFE8IDVBa
         mtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959851; x=1690551851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBv8cSvMkvEF1DkMG98bpwrqP7g4vFh1aUZStsMNl9c=;
        b=PwY9Sh99HC8hU6/o3Krt7uXt8VJw+5sRWbTqP0qmwws11T2h8C2E73ofBfThrxc14K
         ed7H1d14AYyM+oU3vsYYm+nsiKAF12Rr33S4mNCUU4bXo1lGRorlbJz4M2H6+JJTsN1D
         P6essoZ5GXDOxnqlB6zQDPu8iwmXA86HaONm6pZI2tiWMb4lcPMjTUY2UC6YRfINP7L2
         AtWV/SN/eYg4+sGYgOs08nSpJ3c0qEdFWWoEfvNaxrtxE+uSvg2YZc06lp1c7XH9qf56
         quyAm199xZwIBItMY1YcFTxBY45yn0XFnKaVplufuFqXAqROYGmtfjs9WVSHzHpSyib9
         K1Eg==
X-Gm-Message-State: AC+VfDx/SP7geF29/hJ61kp2ASMNN4b6TzYchKFclYIZihbVP2Rr1qUx
        W8ma6LLzZ8ihrYtaCGNv3/TTLFcOzkEkY8HGDvY=
X-Google-Smtp-Source: ACHHUZ7oXZBHs6NMhkxsGsw96wOEqS7BEMbTZjUoi8ySOd5bxD2bpIiiZDa91fCITCubHFaPraFG5y3NUElfmp3zhrc=
X-Received: by 2002:aa7:c593:0:b0:51d:93c8:99ff with SMTP id
 g19-20020aa7c593000000b0051d93c899ffmr8089366edq.36.1687959851110; Wed, 28
 Jun 2023 06:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <1687955688-20809-5-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1687955688-20809-5-git-send-email-quic_mojha@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Jun 2023 16:43:34 +0300
Message-ID: <CAHp75VfF=TVBiTBGeDuGdROPFbS=zbc4ABjPL1cCfWe0rTxhQA@mail.gmail.com>
Subject: Re: [PATCH v4 04/21] soc: qcom: Add Qualcomm APSS minidump (frontend)
 feature support
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:35=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> Minidump is a best effort mechanism to collect useful and predefined
> data for first level of debugging on end user devices running on
> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
> or subsystem part of SoC crashes, due to a range of hardware and
> software bugs. Hence, the ability to collect accurate data is only
> a best-effort. The data collected could be invalid or corrupted,
> data collection itself could fail, and so on.
>
> Qualcomm devices in engineering mode provides a mechanism for
> generating full system ramdumps for post mortem debugging. But in some
> cases it's however not feasible to capture the entire content of RAM.
> The minidump mechanism provides the means for selecting region should
> be included in the ramdump. The solution supports extracting the
> ramdump/minidump produced either over USB or stored to an attached
> storage device.
>
> Minidump kernel driver implementation is divided into two parts for
> simplicity, one is minidump core which can also be called minidump
> frontend(As API gets exported from this driver for registration with
> backend) and the other part is minidump backend i.e, where the underlying
> implementation of minidump will be there. There could be different way
> how the backend is implemented like Shared memory, Memory mapped IO
> or Resource manager based where the guest region information is passed
> to hypervisor via hypercalls.
>
> Minidump Client-1     Client-2      Client-5    Client-n
>          |               |              |             |
>          |               |    ...       |   ...       |
>          |               |              |             |
>          |               |              |             |
>          |               |              |             |
>          |               |              |             |
>          |               |              |             |
>          |               |              |             |
>          |           +---+--------------+----+        |
>          +-----------+  qcom_minidump(core)  +--------+
>                      |                       |
>                      +------+-----+------+---+
>                             |     |      |
>                             |     |      |
>             +---------------+     |      +--------------------+
>             |                     |                           |
>             |                     |                           |
>             |                     |                           |
>             v                     v                           v
>  +-------------------+      +-------------------+     +------------------=
+
>  |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm =
|
>  |                   |      |                   |     |                  =
|
>  +-------------------+      +-------------------+     +------------------=
+
>    Shared memory              Memory mapped IO           Resource manager
>     (backend)                   (backend)                   (backend)
>
> Here, we will be giving all analogy of backend with SMEM as it is the
> only implemented backend at present but general idea remains the same.

the general

>
> The core of minidump feature is part of Qualcomm's boot firmware code.
> It initializes shared memory (SMEM), which is a part of DDR and
> allocates a small section of it to minidump table i.e also called

the minidump

> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
> their own table of segments to be included in the minidump, all
> references from a descriptor in SMEM (G-ToC). Each segment/region has
> some details like name, physical address and it's size etc. and it
> could be anywhere scattered in the DDR.
>
> qcom_minidump(core or frontend) driver adds the capability to add APSS
> region to be dumped as part of ram dump collection. It provides
> appropriate symbol register/unregister client regions.
>
> To simplify post mortem debugging, it creates and maintain an ELF
> header as first region that gets updated upon registration
> of a new region.

...

> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/kallsyms.h>

> +#include <linux/kernel.h>

Why?

And again a lot of missing headers, like

bug.h
dev_printk.h
errno.h
export.h
mutex.h
slab.h

> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/string.h>

...

> +/*
> + * In some of the Old Qualcomm devices, boot firmware statically allocat=
es 300
> + * as total number of supported region (including all co-processors) in

regions

> + * minidump table out of which linux was using 201. In future, this limi=
tation
> + * from boot firmware might get removed by allocating the region dynamic=
ally.
> + * So, keep it compatible with older devices, we can keep the current li=
mit for

So, to keep...

> + * Linux to 201.
> + */

...

> +static struct elf_shdr *elf_shdr_entry_addr(struct elfhdr *ehdr, int idx=
)
> +{
> +       struct elf_shdr *eshdr =3D (struct elf_shdr *)((size_t)ehdr + ehd=
r->e_shoff);

Interesting casting pointer to a size_t. Perhaps void * would work
more explicitly?
Ditto for all other cases like this.

> +       return &eshdr[idx];
> +}

...

> +       old_idx +=3D strscpy((strtab + old_idx), name, MAX_REGION_NAME_LE=
NGTH);

(Parentheses are not needed)

strscpy() might return a very big number in this case. Is it a problem?

...

> +unlock:

out_unlock: ?

Ditto for other similar cases.

> +       mutex_unlock(&md_lock);
> +       return ret;

...

> +       /*
> +        * Above are some prdefined sections/program header used

predefined

> +        * for debug, update their count here.
> +        */

...

> +#ifndef _QCOM_MINIDUMP_INTERNAL_H_
> +#define _QCOM_MINIDUMP_INTERNAL_H_

> +#include <linux/elf.h>

Not sure I see how it's used. You may provide forward declarations for
the pointers.

> +#include <soc/qcom/qcom_minidump.h>

+ kconfig.h for IS_ENABLED() ?

MIssing forward declaration:
struct device;

...

>  #ifndef _QCOM_MINIDUMP_H_
>  #define _QCOM_MINIDUMP_H_

+ types.h for phys_addr_t.

...

> + * @size:      Number of byte to dump from @address location,

bytes

> + *             and it should be 4 byte aligned.

--=20
With Best Regards,
Andy Shevchenko
