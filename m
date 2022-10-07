Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B569E5F79AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJGOXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:23:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D92CBFDC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:23:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f37so7518184lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRXNlcvBI2JoI6fkdHN2tQaylbXiE286pxaqOug11bs=;
        b=GTDsAHmtwBXUy28AlAFp1X+/1Cg/gArbL/zOzwFSsHygIvQ9LXb7PiJZks2SOHIwBV
         mLou+F8pQFqNNF9FrGe9bjTkUZWVCWcL2Q97C/IAphJuuAeIGi2LbEPsNBh2Wq/BmSxh
         SS4r4G0y2h52BRr+1zZZVpkRpF3hi9hCuHsQ1z94GdZacR+rk3lfVgohl/7ndkn/Y9k6
         E5Fzx+TKjrr1PMhYX/nuV6RBb4URW8V5qLO4UPAHINKI//ujb0QkIMxs2WEVHZmwRuDn
         xbccLOxdz74kTcXZJaioU7xRkKiMq3QQ6LxLhO0eJ4gbdwjYoxrnAop9QoMdv1VU/NxI
         JlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRXNlcvBI2JoI6fkdHN2tQaylbXiE286pxaqOug11bs=;
        b=eaGd8jZpoz2z9kT+ZAFvoHZnj/CJzRHsF8wcDzKYvqxNf6imNbxuuV/brthWSpWKP4
         xYlzU20oJ6bqdlAWrY0uZtPST4XYOH74T2H441EyLh0JbjnVBAFlM/tJBl4uHo6SPYF8
         g1PtIqhcCDGkrI6XZxR8tgldYOaXHAE5C4y0LzjNHuPu4VPUjvU6eczeXt49rcA/qXT4
         EFz1prxBQkBRMdf2EcpzrKRGbYv+44QT1l5zRajSkEnfgrssPz7ObKSpYoXLgJ3ZxpA9
         MVUH9CJ8Eavf/uPYl6B2AuJYvkOAGTO5y7Lq2oG3p1hKq2foO5lkWcjYTZ+nHELDCS3B
         qBRA==
X-Gm-Message-State: ACrzQf1Cgaqlwmxkv5VRDbNXnXl95iiPkTZHpVqM49ureO0XrzWJRYUk
        rK3K2fsjq1sauGcASTJjcyep7spCetuBLQjSggL/DQ==
X-Google-Smtp-Source: AMsMyM6NrorSsER1YnP+jmo2kHwQyvH+hsinjK2oUYAqXWCyhH6AFuz1venaDP32RmoBlxmBqcBJ6WbU7Fzhv19xf/Q=
X-Received: by 2002:a05:6512:22c3:b0:4a2:7da9:440c with SMTP id
 g3-20020a05651222c300b004a27da9440cmr1945586lfu.490.1665152624355; Fri, 07
 Oct 2022 07:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220903183042.3913053-1-cristian.marussi@arm.com>
In-Reply-To: <20220903183042.3913053-1-cristian.marussi@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 7 Oct 2022 16:23:33 +0200
Message-ID: <CAKfTPtAt4803k1WpQru+8Sg5PFkSXaSF6b6wNeyu6yCiypVUEw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Introduce a unified API for SCMI Server testing
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Sat, 3 Sept 2022 at 20:31, Cristian Marussi <cristian.marussi@arm.com> w=
rote:
>
> Hi all,
>
> This series aims to introduce a new SCMI unified userspace interface mean=
t
> to ease testing an SCMI Server implementation for compliance, fuzzing etc=
.,
> from the perspective of the OSPM agent (non-secure world only ...)
>
> It is proposed as a testing/development facility, it is NOT meant to be a
> feature to use in production, but only enabled in Kconfig for test
> deployments.
>
> Currently an SCMI Compliance Suite like the one at [1] can only work by
> injecting SCMI messages at the SCMI transport layer using the mailbox tes=
t
> driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
> the related replies from the SCMI backend Server.
>

...

>
> In V2 the runtime enable/disable switching capability has been removed
> (for now) since still not deemed to be stable/reliable enough: as a
> consequence when SCMI Raw support is compiled in, the regular SCMI stack
> drivers are now inhibited permanently for that Kernel.
>
> A quick and trivial example from the shell...reading from a sensor
> injecting a properly crafted packet in raw mode:
>
>         # INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=3D1 (binary lit=
tle endian)
>         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x0=
0\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message

I have tried your patchset with an SCMI server using an optee-os
transport channel but I have a timed out error when trying your
example above to read sensor1

#  echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00
> /sys/kernel/debug/scmi_raw/message
# [   93.306690] arm-scmi firmware:scmi0: timed out in RAW response -
HDR:00005406

and there no response available when trying to read it with
# cat /sys/kernel/debug/scmi_raw/message


The sensor 1 can be successfully read in normal mode:
# cat /sys/class/hwmon/hwmon0/temp1_input
25000
#

In both case, the SCMI server received the requests and replied successfull=
y

Could it be that you process the answer differently in case of raw mode ?

>
>         # READING BACK THE REPLY...
>         root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi_raw/message |=
 od --endian=3Dlittle -t x4
>         0000000 00005406 00000000 00000335 00000000
>         0000020
>
> while doing that, since Raw mode makes (partial) use of the regular SCMI
> stack, you can observe the messages going through the SCMI stack with the
> usual traces:
>
>               bash-329     [000] ..... 14183.446808: scmi_msg_dump: pt=3D=
15 t=3DCMND msg_id=3D06 seq=3D0000 s=3D0 pyld=3D0100000000000000
>    irq/35-mhu_db_l-81      [000] ..... 14183.447809: scmi_msg_dump: pt=3D=
15 t=3DRESP msg_id=3D06 seq=3D0000 s=3D0 pyld=3D3503000000000000
>
>
> ..trying to read in async when the backend server does NOT supports async=
s:
>
>         # AN ASYNC SENSOR READING REQUEST...
>         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x0=
0\\x00\\x00\\x01\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message_async
>
>               bash-329     [000] ..... 16415.938739: scmi_msg_dump: pt=3D=
15 t=3DCMND msg_id=3D06 seq=3D0000 s=3D0 pyld=3D0100000001000000
>    irq/35-mhu_db_l-81      [000] ..... 16415.944129: scmi_msg_dump: pt=3D=
15 t=3DRESP msg_id=3D06 seq=3D0000 s=3D-1 pyld=3D
>
>         # RETURNS A STATUS -1 FROM THE SERVER NOT SUPPORTING IT
>         root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi_raw/message |=
 od --endian=3Dlittle -t x4
>         0000000 00005406 ffffffff
>         0000010
>
> Note that this was on a JUNO, BUT exactly the same steps can be used to
> reach an SCMI Server living on a VM reachable via virtio as long as the
> system under test if properly configured to work with a virtio transport.
>
> In a nutshell the exposed API is as follows:
>
> /sys/kernel/debug/scmi_raw/
> =E2=94=9C=E2=94=80=E2=94=80 errors
> =E2=94=9C=E2=94=80=E2=94=80 message
> =E2=94=9C=E2=94=80=E2=94=80 message_async
> =E2=94=9C=E2=94=80=E2=94=80 notification
> =E2=94=9C=E2=94=80=E2=94=80 reset
> =E2=94=9C=E2=94=80=E2=94=80 transport_max_msg_size
> =E2=94=9C=E2=94=80=E2=94=80 transport_rx_timeout_ms
> =E2=94=94=E2=94=80=E2=94=80 transport_tx_max_msg
>
> where:
>
>  - message*: used to send sync/async commands and read back immediate and
>    delayed responses (if any)
>  - errors: used to report timeout and unexpected replies
>  - reset: used to reset the SCMI Raw stack, flushing all queues from
>    received messages still pending to be read out (useful to be sure to
>    cleanup between test suite runs...)
>  - notification: used to read any notification being spit by the system
>    (if previously enabled by the user app)
>  - transport*: a bunch of configuration useful to setup the user
>    application expectations in terms of timeouts and message
>    characteristics.
>
> Each write corresponds to one command request and the replies or delayed
> response are read back one message at time (receiving an EOF at each
> message boundary).
>
> The user application running the test is in charge of handling timeouts
> and properly choosing SCMI sequence numbers for the outgoing requests: no=
te
> that the same fixed number can be re-used (...though discouraged...) as
> long as the suite does NOT expect to send multiple in-flight commands
> concurrently.
>
> Since the SCMI core regular stack is partially used to deliver and collec=
t
> the messages, late replies after timeouts and any other sort of unexpecte=
d
> message sent by the SCMI server platform back can be identified by the SC=
MI
> core as usual and it will be reported under /errors for later analysis.
> (a userspace test-app will have anyway properly detected the timeout on
>  /message* ...)
>
> All of the above has been roughly tested against a standard JUNO SCP SCMI
> Server (mailbox trans) and an emulated SCMI Server living in a VM (virtio
> trans) using a custom experimental version of the scmi-tests Compliance
> suite patched to support Raw mode and posted at [2]. (still in developmen=
t
> ...certainly not up for review as of now...it is just a mean for me to
> test the testing API ... O_o)
>
> The series is based on sudeep/for-next/scmi [3] on top of:
>
> commit 40d30cf680cb ("firmware: arm_scmi: Harmonize SCMI tracing message =
format")
>
> Still todo:
>
> - needs more complete testing, ideally running to completion at least the=
 full
>   SCMI compliance suite at [2] to use it as a reference
> - more feedback on the API
>
> Having said that (in such a concise and brief way :P) ...
>
> ...any feedback/comments are welcome !
>
> Thanks,
> Cristian
>
> ---
> v2 --> v3
> - fixed some sparse warning on LE and __poll_t
> - reworked and simplified deferred worker in charge of xfer delayed waiti=
ng
> - allow for injection of DT-unknown protocols messages when in Raw mode
>   (needed for any kind of fuzzing...)
>
> v1 --> v2
> - added comments and debugfs docs
> - added dedicated transport devices for channels initialization
> - better channels handling in Raw mode
> - removed runtime enable, moved to static compile time exclusion
>   of SCMI regular stack
>
> [1]: https://gitlab.arm.com/tests/scmi-tests
> [2]: https://gitlab.arm.com/linux-arm/scmi-tests-cm/-/commits/raw_mode_su=
pport_V3/
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.g=
it/log/?h=3Dfor-next/scmi
>
> Cristian Marussi (9):
>   firmware: arm_scmi: Refactor xfer in-flight registration routines
>   firmware: arm_scmi: Simplify chan_available transport operation
>   firmware: arm_scmi: Use dedicated devices to initialize channels
>   firmware: arm_scmi: Add xfer raw helpers
>   firmware: arm_scmi: Move errors defs and code to common.h
>   firmware: arm_scmi: Add raw transmission support
>   firmware: arm_scmi: Add debugfs ABI documentation for Raw mode
>   firmware: arm_scmi: Reject SCMI drivers while in Raw mode
>   firmware: arm_scmi: Call Raw mode hooks from the core stack
>
>  Documentation/ABI/testing/debugfs-scmi-raw |   88 ++
>  drivers/firmware/arm_scmi/Kconfig          |   13 +
>  drivers/firmware/arm_scmi/Makefile         |    1 +
>  drivers/firmware/arm_scmi/common.h         |   51 +-
>  drivers/firmware/arm_scmi/driver.c         |  389 ++++--
>  drivers/firmware/arm_scmi/mailbox.c        |    4 +-
>  drivers/firmware/arm_scmi/optee.c          |    4 +-
>  drivers/firmware/arm_scmi/raw_mode.c       | 1235 ++++++++++++++++++++
>  drivers/firmware/arm_scmi/raw_mode.h       |   29 +
>  drivers/firmware/arm_scmi/smc.c            |    4 +-
>  drivers/firmware/arm_scmi/virtio.c         |    2 +-
>  11 files changed, 1714 insertions(+), 106 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw
>  create mode 100644 drivers/firmware/arm_scmi/raw_mode.c
>  create mode 100644 drivers/firmware/arm_scmi/raw_mode.h
>
> --
> 2.32.0
>
