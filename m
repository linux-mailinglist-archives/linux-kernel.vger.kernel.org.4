Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC350741C61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjF1XVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjF1XVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:21:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE21FFB;
        Wed, 28 Jun 2023 16:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1805061495;
        Wed, 28 Jun 2023 23:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E599C43395;
        Wed, 28 Jun 2023 23:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687994494;
        bh=ACoNJqLmMSSKski9UCPiO0yxsg2i09dtScgv0JdZFvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uD2CtfXMM5ou1hcT50s50ZeFg3pVLaSzaO8YMHupEIWxxXA28Cu9pZBAT4OGQ7tUz
         x+EG5VnLasN9TUHrwoB6pLdxrrK//+PjIi0qEk58ZBf75puprXixf0ObHLsjUMKkiX
         iu1Z7dYadqQ3hdlDJS1OBLpyYk/TLJwx6dyL9YQ08Vdl0EKbHX9LJTzvhvOp+8a0Cx
         YXI+q5ChigUkJhch8n62DxUDaw5VSOEOixR9Sj75K12Qzq/Aor3nhdykaCYEmtNtno
         xo4wkO3PS51nf3Z85+BST+mVhi2OWQFcQbH+wkC1W9h3Cei60Wvn1lwIYiahMGy6nk
         MkYM/cKTURpBQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso135753e87.1;
        Wed, 28 Jun 2023 16:21:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDzvqM0VrYoUWx9qojSqgMW41V3NqJbfi3aQUgSW+So1u//y13Ll
        9DYSq6KbmM4Q1JtpY78mzSz/DRQq4udYrPuu6A==
X-Google-Smtp-Source: ACHHUZ6U3aFUeGZz0HgXWANEq4Y9/CIXuHi9Rs47yHyROTuI3TxVl70to/g+u37ZzNDZ8NJm8X1MQ/0CnnJyhJj0jiM=
X-Received: by 2002:a19:ca5a:0:b0:4f8:62a6:8b2 with SMTP id
 h26-20020a19ca5a000000b004f862a608b2mr10514066lfj.46.1687994492270; Wed, 28
 Jun 2023 16:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <1687955688-20809-2-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1687955688-20809-2-git-send-email-quic_mojha@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 28 Jun 2023 17:21:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VXCoxadtLZjRJVqE4BGVrqVkndwkYJCbxW0rGGk=zsA@mail.gmail.com>
Message-ID: <CAL_Jsq+VXCoxadtLZjRJVqE4BGVrqVkndwkYJCbxW0rGGk=zsA@mail.gmail.com>
Subject: Re: [PATCH v4 01/21] docs: qcom: Add qualcomm minidump guide
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 6:36=E2=80=AFAM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> Add the qualcomm minidump guide for the users which
> tries to cover the dependency and the way to test
> and collect minidump on Qualcomm supported platforms.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  Documentation/admin-guide/index.rst         |   1 +
>  Documentation/admin-guide/qcom_minidump.rst | 293 ++++++++++++++++++++++=
++++++
>  2 files changed, 294 insertions(+)
>  create mode 100644 Documentation/admin-guide/qcom_minidump.rst
>
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-gu=
ide/index.rst
> index 43ea35613dfc..251d070486c2 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -120,6 +120,7 @@ configure specific aspects of kernel behavior to your=
 liking.
>     perf-security
>     pm/index
>     pnp
> +   qcom_minidump
>     rapidio
>     ras
>     rtc
> diff --git a/Documentation/admin-guide/qcom_minidump.rst b/Documentation/=
admin-guide/qcom_minidump.rst
> new file mode 100644
> index 000000000000..a3a8cfee4555
> --- /dev/null
> +++ b/Documentation/admin-guide/qcom_minidump.rst
> @@ -0,0 +1,293 @@
> +Qualcomm Minidump Feature
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +Introduction
> +------------
> +
> +Minidump is a best effort mechanism to collect useful and predefined
> +data for first level of debugging on end user devices running on
> +Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
> +or subsystem part of SoC crashes, due to a range of hardware and
> +software bugs. Hence, the ability to collect accurate data is only
> +a best-effort. The data collected could be invalid or corrupted, data
> +collection itself could fail, and so on.
> +
> +Qualcomm devices in engineering mode provides a mechanism for generating
> +full system RAM dumps for post-mortem debugging. But in some cases it's
> +however not feasible to capture the entire content of RAM. The minidump
> +mechanism provides the means for selecting region should be included in
> +the ramdump.
> +
> +::
> +
> +   +-----------------------------------------------+
> +   |   DDR                       +-------------+   |
> +   |                             |      SS0-ToC|   |
> +   | +----------------+     +----------------+ |   |
> +   | |Shared memory   |     |         SS1-ToC| |   |
> +   | |(SMEM)          |     |                | |   |
> +   | |                | +-->|--------+       | |   |
> +   | |G-ToC           | |   | SS-ToC  \      | |   |
> +   | |+-------------+ | |   | +-----------+  | |   |
> +   | ||-------------| | |   | |-----------|  | |   |
> +   | || SS0-ToC     | | | +-|<|SS1 region1|  | |   |
> +   | ||-------------| | | | | |-----------|  | |   |
> +   | || SS1-ToC     |-|>+ | | |SS1 region2|  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | || SS2-ToC     | |   | | |  ...      |  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | ||  ...        | |   |-|<|SS1 regionN|  | |   |
> +   | ||-------------| |   | | |-----------|  | |   |
> +   | || SSn-ToC     | |   | | +-----------+  | |   |
> +   | |+-------------+ |   | |                | |   |
> +   | |                |   | |----------------| |   |
> +   | |                |   +>|  regionN       | |   |
> +   | |                |   | |----------------| |   |
> +   | +----------------+   | |                | |   |
> +   |                      | |----------------| |   |
> +   |                      +>|  region1       | |   |
> +   |                        |----------------| |   |
> +   |                        |                | |   |
> +   |                        |----------------|-+   |
> +   |                        |  region5       |     |
> +   |                        |----------------|     |
> +   |                        |                |     |
> +   |  Region information    +----------------+     |
> +   | +---------------+                             |
> +   | |region name    |                             |
> +   | |---------------|                             |
> +   | |region address |                             |
> +   | |---------------|                             |
> +   | |region size    |                             |
> +   | +---------------+                             |
> +   +-----------------------------------------------+
> +       G-ToC: Global table of contents
> +       SS-ToC: Subsystem table of contents
> +       SS0-SSn: Subsystem numbered from 0 to n
> +
> +It depends on targets how the underlying hardware taking care of the
> +implementation part for minidump like above diagram is for shared
> +memory and it is possible that this could be implemented via memory
> +mapped regions but the general idea remain same.
> +
> +In this document, SMEM will be used as the backend implementation of
> +minidump.
> +
> +SMEM as backend
> +----------------
> +
> +The core of minidump feature is part of Qualcomm's boot firmware code.
> +It initializes shared memory (SMEM), which is a part of DDR and
> +allocates a small section of it to minidump table, i.e. also called
> +global table of contents (G-ToC). Each subsystem (APSS, ADSP, ...) has
> +its own table of segments to be included in the minidump, all
> +references from a descriptor in SMEM (G-ToC). Each segment/region has
> +some details like name, physical address and its size etc. and it
> +could be anywhere scattered in the DDR.
> +
> +Minidump kernel driver concept
> +------------------------------
> +::
> +
> +  Minidump Client-1     Client-2      Client-5    Client-n
> +         |               |              |             |
> +         |               |    ...       |   ...       |
> +         |               |              |             |
> +         |               |              |             |
> +         |               |              |             |
> +         |               |              |             |
> +         |               |              |             |
> +         |               |              |             |
> +         |           +---+--------------+----+        |
> +         +-----------+  qcom_minidump(core)  +--------+
> +                     |                       |
> +                     +------+-----+------+---+
> +                            |     |      |
> +                            |     |      |
> +            +---------------+     |      +--------------------+
> +            |                     |                           |
> +            |                     |                           |
> +            |                     |                           |
> +            v                     v                           v
> + +-------------------+      +-------------------+     +-----------------=
-+
> + |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm=
 |
> + |                   |      |                   |     |                 =
 |
> + +-------------------+      +-------------------+     +-----------------=
-+
> +   Shared memory              Memory mapped IO           Resource manage=
r
> +    (backend)                   (backend)                   (backend)
> +
> +
> +Kernel implementation of minidump driver is divided into two parts one i=
s,
> +the core implementation called frontend driver ``qcom_minidump.c`` and t=
his
> +is the driver will be exposing the API for clients and the other part is=
,
> +backend driver and its depends whether it is based on SMEM, MMIO or some
> +other way corressponding driver will be hooking itself up with the core
> +driver to get itself working. As of now, at a time one and only one back=
end
> +can be attached to the front-end either it is HOST or a guest VM.
> +
> +Qualcomm minidump kernel driver adds the capability to add Linux region
> +to be dumped as part of RAM dump collection. At the moment, shared memor=
y
> +driver creates platform device for minidump driver and give a means to
> +APSS minidump to initialize itself on probe.
> +
> +This driver provides ``qcom_minidump_region_register`` and
> +``qcom_minidump_region_unregister`` API's to register and unregister
> +APSS minidump region. It also gives a mechanism to update physical/virtu=
al
> +address for the client whose addresses keeps on changing, e.g., current =
stack
> +address of task keeps on changing on context switch for each core. So th=
ese
> +clients can update their addresses with ``qcom_minidump_update_region``
> +API.
> +
> +The driver also supports registration for the clients who came before
> +minidump driver was initialized. It maintains pending list of clients
> +who came before minidump and once minidump is initialized it registers
> +them in one go.
> +
> +To simplify post-mortem debugging, driver creates and maintain an ELF
> +header as first region that gets updated each time a new region gets
> +registered.
> +
> +The solution supports extracting the RAM dump/minidump produced either
> +over USB or stored to an attached storage device.
> +
> +Dependency of minidump kernel driver
> +------------------------------------
> +
> +It is to note that whole of minidump depends on Qualcomm boot
> +firmware whether it supports minidump or not. So, if the minidump
> +SMEM ID is present in shared memory, it indicates that minidump
> +is supported from boot firmware and it is possible to dump Linux
> +(APSS) region as part of minidump collection.
> +
> +How a kernel client driver can register region with minidump
> +------------------------------------------------------------
> +
> +Client driver can use ``qcom_minidump_region_register`` API's to
> +register and ``qcom_minidump_region_unregister`` to unregister
> +their region from minidump driver.
> +
> +Client needs to fill their region by filling ``qcom_minidump_region``
> +structure object which consists of the region name, region's
> +virtual and physical address and its size.
> +
> +Below is one sample client driver snippet which tries to allocate
> +a region from kernel heap of certain size and it writes a certain
> +known pattern (that can help in verification after collection
> +that we got the exact pattern, what we wrote) and registers it with
> +minidump.
> +
> + .. code-block:: c
> +
> +  #include <soc/qcom/qcom_minidump.h>
> +  [...]
> +
> +
> +  [... inside a function ...]
> +  struct qcom_minidump_region region;
> +
> +  [...]
> +
> +  client_mem_region =3D kzalloc(region_size, GFP_KERNEL);
> +  if (!client_mem_region)
> +       return -ENOMEM;
> +
> +  [... Just write a pattern ...]
> +  memset(client_mem_region, 0xAB, region_size);
> +
> +  [... Fill up the region object ...]
> +  strlcpy(region.name, "REGION_A", sizeof(region.name));
> +  region.virt_addr =3D client_mem_region;
> +  region.phys_addr =3D virt_to_phys(client_mem_region);
> +  region.size =3D region_size;
> +
> +  ret =3D qcom_minidump_region_register(&region);
> +  if (ret < 0) {
> +       pr_err("failed to add region in minidump: err: %d\n", ret);
> +       return ret;
> +  }
> +
> +  [...]
> +
> +
> +Test
> +----
> +
> +Existing Qualcomm devices already supports entire RAM dump (also called
> +full dump) by writing appropriate value to Qualcomm's top control and
> +status register (tcsr) in ``driver/firmware/qcom_scm.c`` .
> +
> +SCM device Tree bindings required to support download mode
> +For example (sm8450) ::
> +
> +       / {
> +
> +       [...]
> +
> +               firmware {
> +                       scm: scm {
> +                               compatible =3D "qcom,scm-sm8450", "qcom,s=
cm";
> +                               [... tcsr register ... ]
> +                               qcom,dload-mode =3D <&tcsr 0x13000>;
> +
> +                               [...]
> +                       };
> +               };
> +
> +       [...]
> +
> +               soc: soc@0 {
> +
> +                       [...]
> +
> +                       tcsr: syscon@1fc0000 {
> +                               compatible =3D "qcom,sm8450-tcsr", "sysco=
n";
> +                               reg =3D <0x0 0x1fc0000 0x0 0x30000>;
> +                       };
> +
> +                       [...]
> +               };
> +       [...]
> +
> +       };
> +
> +User of minidump can pass ``qcom_scm.download_mode=3D"mini"`` to kernel
> +commandline to set the current download mode to minidump.
> +Similarly, ``"full"`` is passed to set the download mode to full dump
> +where entire RAM dump will be collected while setting it ``"full,mini"``
> +will collect minidump along with fulldump.
> +
> +Writing to sysfs node can also be used to set the mode to minidump::
> +
> +       echo "mini" > /sys/module/qcom_scm/parameter/download_mode
> +
> +Once the download mode is set, any kind of crash will make the device co=
llect
> +respective dump as per set download mode.
> +
> +Dump collection
> +---------------
> +
> +The solution supports extracting the minidump produced either over USB o=
r
> +stored to an attached storage device.
> +
> +By default, dumps are downloaded via USB to the attached x86_64 machine
> +running PCAT (Qualcomm tool) software. Upon download, we will see
> +a set of binary blobs starting with name ``md_*`` in PCAT configured dir=
ectory
> +in x86_64 machine, so for above example from the client it will be

So I can't use my QCom laptop or M1 MacBook? This text won't age well,
so perhaps reword it.

Rob
