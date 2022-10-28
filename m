Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908456114CA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJ1Okc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJ1OkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:40:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9902A262
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:40:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h206so1230916iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdFPbI9AK3FyJkpwR5zkrgfiO40EXwxvLRsP+mpM3SE=;
        b=Wgt9+n1SAvZENzUQhyQS6OXt/uYSXxJdF5iUwlVT7R1PG+2qWSTAN1kNUziYczha19
         JohX5T6wUJnQ/VX2Day2z1B1G0Rfkq4mtsxouikt54aUFi8txWzPw+b0RBtetTB4Ki8j
         /TUmDCUVC2HzE8n1C516E7yna4ixeT1VZ4ESfnj7yirOLnKgZfPY9afPwfACwdK4fN3P
         wGvkm1YlxeWaK4YFcftT4E4W3+b88CEICFqwgxOQ+xE9urGq74DE1i7SmBUbk4HobRsK
         F5ex3Z40qFEreH/x2l6RtQCKqmt9B9WwPuTueXfXvsHj7imEypPQLUbuLFagyObYgXO2
         GdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdFPbI9AK3FyJkpwR5zkrgfiO40EXwxvLRsP+mpM3SE=;
        b=Psu/CLzut2qaql9AHPJKZG9LRqXSRWcfS9e4u8o5aVUU02ISmWZ8vs014hlvgkTnf7
         CfNMU1NscTKRWt1KRpt4RPnPlPzSZO/Fp+k/qc/ttCjWcUziPTnCfZVvcD4XjnUi5AQ0
         IHwfL2KQBCa0xtVTeV5W/pby+GbhI/Jg5iPHaGex3s3pFvw0u0jjD448fkcAEq0L5hEb
         wgUNfqr9ITs8FOBxIw4qXOemIfAgmWoWRitudIgUSGcJI7Sx8h8Rsxme2xPwDORgYQdx
         alIZl/SG2KZAcgGD0n24jCfb1orMQeJ6fS5+LpXzB7kzpnrnKedPLIUpTvzjBHAKJ14B
         PLxA==
X-Gm-Message-State: ACrzQf06Kkwv2KowgOSwmfE8MP7VD12HWjZmSXN+HBAhjfsaUe2WzseI
        2ICvD3MZVV7N6TgpJDEmRrCb5gjxuHl3gQLzwGLTSAY/NUY=
X-Google-Smtp-Source: AMsMyM7GN8kQKMUccd524EUfbyfc0QzvpHNgFPQjx94WltFkbNTocYBGDXv4TPzh1+UcQRBf3vV/ncSBaIqAwUM5ufA=
X-Received: by 2002:a02:62cc:0:b0:363:d7ea:f3d with SMTP id
 d195-20020a0262cc000000b00363d7ea0f3dmr35500578jac.120.1666968013989; Fri, 28
 Oct 2022 07:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
In-Reply-To: <20221019204626.3813043-1-cristian.marussi@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 28 Oct 2022 16:40:02 +0200
Message-ID: <CAKfTPtBJy4SdbYUNHFn2ZXEO_pnaMPYibfjXWNBnXy49P2h78Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, peter.hilber@opensynergy.com,
        nicola.mazzucato@arm.com, tarek.el-sherbiny@arm.com,
        quic_kshivnan@quicinc.com
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

On Wed, 19 Oct 2022 at 22:46, Cristian Marussi <cristian.marussi@arm.com> w=
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
> This approach has a few drawbacks:
>
> - the SCMI Server under test MUST be reachable through a mailbox based
>   SCMI transport: any other SCMI Server placement is not possible (like i=
n
>   a VM reachable via SCMI Virtio). In order to cover other placements in
>   the current scenario we should write some sort of test driver for each
>   and every existent SCMI transport and for any future additional transpo=
rt
>   ...this clearly does not scale.
>
> - even in the mailbox case the userspace Compliance suite cannot simply
>   send and receive bare SCMI messages BUT it has to properly lay them out
>   into the shared memory exposed by the mailbox test driver as expected b=
y
>   the transport definitions. In other words such a userspace test
>   application has to, not only use a proper transport driver for the syst=
em
>   at hand, but it also has to have a comprehensive knowledge of the
>   internals of the underlying transport in order to operate.
>
> - last but not least, the system under test has to be specifically
>   configured and built, in terms of Kconfig and DT, to perform such kind =
of
>   testing, it cannot be used for anything else, which is unfortunate for
>   CI/CD deployments.
>
> This series introduces a new SCMI Raw mode support feature that, when
> configured and enabled exposes a new interface in debugfs through which:
>
> - a userspace application can inject bare SCMI binary messages into the
>   SCMI core stack; such messages will be routed by the SCMI regular kerne=
l
>   stack to the backend Server using the currently configured transport
>   transparently: in other words you can test the SCMI server, no matter
>   where it is placed, as long as it is reachable from the currently
>   configured SCMI stack.
>   Same goes the other way around on the reading path: any SCMI server rep=
ly
>   can be read as a bare SCMI binary message from the same debugfs path.
>
> - as a direct consequence of this way of injecting bare messages in the
>   middle of the SCMI stack (instead of beneath it at the transport layer)
>   the user application has to handle only bare SCMI messages without havi=
ng
>   to worry about the specific underlying transport internals that will be
>   taken care of by the SCMI core stack itself using its own machinery,
>   without duplicating such logic.
>
> - a system under test, once configured with SCMI Raw support enabled in
>   Kconfig, can be booted without any particular DT change.
>
> In V2 the runtime enable/disable switching capability has been removed
> (for now) since still not deemed to be stable/reliable enough: as a
> consequence when SCMI Raw support is compiled in, the regular SCMI stack
> drivers are now inhibited permanently for that Kernel.
>
> In V4 it has been added the support for transports lacking a completion_i=
rq
> or configured forcibly in polled mode.
>
> A quick and trivial example from the shell...reading from a sensor
> injecting a properly crafted packet in raw mode:
>
>         # INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=3D1 (binary lit=
tle endian)
>         root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x0=
0\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message
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
> ...merge requests are in progress...for now it is just a mean for me to
> test the testing API ... O_o)
>
> The series is based on v6.1-rc1.
>
> Having said that (in such a concise and brief way :P) ...
>
> ...any feedback/comments are welcome !

Hi Cristian,

I have tested your series with an optee message transport layer and
been able to send raw messages to the scmi server PTA

FWIW

Tested-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> Thanks,
> Cristian
>
> ---
> V3 --> v4
> - rebased on v6.1-rc1
> - addedd missing support for 'polled' transports and transport lacking a
>   completion_irq (like smc/optee)
> - removed a few inlines
> - refactored SCMI Raw RX patch to make use more extensively of the regula=
r
>   non-Raw RX path
> - fix handling of O_NONBLOCK raw_mode read requests
>
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
> [2]: https://gitlab.arm.com/tests/scmi-tests/-/commits/raw_mode_support_d=
evel/
>
>
> Cristian Marussi (11):
>   firmware: arm_scmi: Refactor xfer in-flight registration routines
>   firmware: arm_scmi: Simplify chan_available transport operation
>   firmware: arm_scmi: Use dedicated devices to initialize channels
>   firmware: arm_scmi: Refactor polling helpers
>   firmware: arm_scmi: Refactor scmi_wait_for_message_response
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
>  drivers/firmware/arm_scmi/common.h         |   72 +-
>  drivers/firmware/arm_scmi/driver.c         |  521 +++++---
>  drivers/firmware/arm_scmi/mailbox.c        |    4 +-
>  drivers/firmware/arm_scmi/optee.c          |    4 +-
>  drivers/firmware/arm_scmi/raw_mode.c       | 1244 ++++++++++++++++++++
>  drivers/firmware/arm_scmi/raw_mode.h       |   29 +
>  drivers/firmware/arm_scmi/smc.c            |    4 +-
>  drivers/firmware/arm_scmi/virtio.c         |    2 +-
>  11 files changed, 1827 insertions(+), 155 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw
>  create mode 100644 drivers/firmware/arm_scmi/raw_mode.c
>  create mode 100644 drivers/firmware/arm_scmi/raw_mode.h
>
> --
> 2.34.1
>
