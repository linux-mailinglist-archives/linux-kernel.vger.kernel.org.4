Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C3A5EEC8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiI2Dnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2Dnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:43:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897011284BD;
        Wed, 28 Sep 2022 20:43:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c24so180769plo.3;
        Wed, 28 Sep 2022 20:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6xwVt7ZiN2nbV0+Qlx1V9YDad8//rzIzJA6lCQIJXog=;
        b=VB+spiqzXsD9zSCD8e+BYc7iWQtg1Tmcx+GyyIdYYGZ9wWMpXUjModQucx73vxme56
         +4CWik8D3Pkmq1A6/eDWPNljZFqlbr0GescNnLzn6mRd5tUZT4suIiOUad6EpXJKCbwB
         r4vCmhLBp1qqId4EVtnpUR3xZOTR31qIEsakgpgwY1JbsHC5YhukDNkRWxlLsFZOTIs8
         DXXBE1Dgpm0W4wZCsoyO8ydD9XcA6Qenteu/exAWCYHqQ6Fy17/1MyTHgfvdEogtfcTf
         7kvllZgNTGkhkb2sJSft9c5q0/LCk4mZyEd13UGnAXRw4KOLHZbCB33uTkH8BNJMHAxG
         azhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6xwVt7ZiN2nbV0+Qlx1V9YDad8//rzIzJA6lCQIJXog=;
        b=SB/Lz4D2FzH+HBDVw4U9/F1F2QiP9A/68AwuU9vUIfPRj5mDfHtItRwYiOwS3HRgZy
         0nEuC+W4OM715j1PKK89nw8ororr3FOoiKuv4r1n0PmIdyaf/FIfAr0RhEyQpWHIj4ir
         sNX3+DlgOefRP/5M8jZfK0WB0szBt9Hm0uwLZiQ5nfiDIlK2GRNMYrQwmkiF6+TY2JXe
         JTBn+Qc/1H6WRH7gPpLqFzP9YdH2cVEq0HIn4FNIwQtkrHlt8nmoFS73f+PzJaGbkDUh
         eQqYxu1C9BWP3IM0m4DHlWYEbmG2rOOBJyNJcTWCsvN8bPI9rYrbtg+AT49F8q/EuIkn
         mg+A==
X-Gm-Message-State: ACrzQf3LJk40vaRIg5Xu6lVUBQLd+NqyVKn4JEd0EAIMZUaqDOo69QzE
        L6hxQuHMjXd/a8fijRlzoOA=
X-Google-Smtp-Source: AMsMyM6zKzqFoBqfjiB84n87Cja7hoH+onGtwk1jfbZRPFfpUvf7ctYzOSmkiQGomduhCnEkRoCzXA==
X-Received: by 2002:a17:90a:d908:b0:206:122:35d1 with SMTP id c8-20020a17090ad90800b00206012235d1mr1344435pjv.245.1664423020874;
        Wed, 28 Sep 2022 20:43:40 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-79.three.co.id. [180.214.233.79])
        by smtp.gmail.com with ESMTPSA id e1-20020a621e01000000b00537a8d2c2easm3557097pfe.80.2022.09.28.20.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 20:43:40 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 27FB410925C; Thu, 29 Sep 2022 10:43:37 +0700 (WIB)
Date:   Thu, 29 Sep 2022 10:43:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] docs: gunyah: Introduce Gunyah Hypervisor
Message-ID: <YzUUaIx+azyzFDNX@debian.me>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-2-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q0eTYf0QdFrQIfAA"
Content-Disposition: inline
In-Reply-To: <20220928195633.2348848-2-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q0eTYf0QdFrQIfAA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 12:56:20PM -0700, Elliot Berman wrote:
> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gun=
yah/index.rst
> new file mode 100644
> index 000000000000..959f451caccd
> --- /dev/null
> +++ b/Documentation/virt/gunyah/index.rst
> @@ -0,0 +1,114 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Gunyah Hypervisor
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   message-queue
> +
> +Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and=
 runs in
> +a higher CPU privilege level. It does not depend on any lower-privileged=
 operating system
> +for its core functionality. This increases its security and can support =
a much smaller
> +trusted computing base than a Type-2 hypervisor.
> +
> +Gunyah is an open source hypervisor. The source repo is available at
> +https://github.com/quic/gunyah-hypervisor.
> +
> +Gunyah provides these following features.
> +
> +- Scheduling:
> +
> +  A scheduler for virtual CPUs (vCPUs) on physical CPUs and enables time=
-sharing
> +  of the CPUs. Gunyah supports two models of scheduling:
> +
> +    1. "Behind the back" scheduling in which Gunyah hypervisor schedules=
 vCPUS on its own
> +    2. "Proxy" scheduling in which a delegated VM can donate part of one=
 of its vCPU slice
> +       to another VM's vCPU via a hypercall.
> +
> +- Memory Management:
> +
> +  APIs handling memory, abstracted as objects, limiting direct use of ph=
ysical
> +  addresses. Memory ownership and usage tracking of all memory under its=
 control.
> +  Memory partitioning between VMs is a fundamental security feature.
> +
> +- Interrupt Virtualization:
> +
> +  Uses CPU hardware interrupt virtualization capabilities. Interrupts ar=
e handled
> +  in the hypervisor and routed to the assigned VM.
> +
> +- Inter-VM Communication:
> +
> +  There are several different mechanisms provided for communicating betw=
een VMs.
> +
> +- Virtual platform:
> +
> +  Architectural devices such as interrupt controllers and CPU timers are=
 directly provided
> +  by the hypervisor as well as core virtual platform devices and system =
APIs such as ARM PSCI.
> +
> +- Device Virtualization:
> +
> +  Para-virtualization of devices is supported using inter-VM communicati=
on.
> +
> +Architectures supported
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +AArch64 with a GIC
> +
> +Resources and Capabilities
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Some services or resources provided by the Gunyah hypervisor are describ=
ed to a virtual machine by
> +capability IDs. For instance, inter-VM communication is performed with d=
oorbells and message queues.
> +Gunyah allows access to manipulate that doorbell via the capability ID. =
These devices are described
> +in Linux as a struct gunyah_resource.
> +
> +High level management of these resources is performed by the resource ma=
nager VM. RM informs a
> +guest VM about resources it can access through either the device tree or=
 via guest-initiated RPC.
> +
> +For each virtual machine, Gunyah maintains a table of resources which ca=
n be accessed by that VM.
> +An entry in this table is called a "capability" and VMs can only access =
resources via this
> +capability table. Hence, virtual Gunyah devices are referenced by a "cap=
ability IDs" and not a
> +"resource IDs". A VM can have multiple capability IDs mapping to the sam=
e resource. If 2 VMs have
> +access to the same resource, they may not be using the same capability I=
D to access that resource
> +since the tables are independent per VM.
> +
> +Resource Manager
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The resource manager (RM) is a privileged application VM supporting the =
Gunyah Hypervisor.
> +It provides policy enforcement aspects of the virtualization system. The=
 resource manager can
> +be treated as an extension of the Hypervisor but is separated to its own=
 partition to ensure
> +that the hypervisor layer itself remains small and secure and to maintai=
n a separation of policy
> +and mechanism in the platform. On arm64, RM runs at NS-EL1 similar to ot=
her virtual machines.
> +
> +Communication with the resource manager from each guest VM happens with =
message-queue.rst. Details
> +about the specific messages can be found in drivers/virt/gunyah/rsc_mgr.c
> +
> +::
> +
> +  +-------+   +--------+   +--------+
> +  |  RM   |   |  VM_A  |   |  VM_B  |
> +  +-.-.-.-+   +---.----+   +---.----+
> +    | |           |            |
> +  +-.-.-----------.------------.----+
> +  | | \=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/             |    |
> +  |  \=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D/     |
> +  |            Gunyah               |
> +  +---------------------------------+
> +
> +The source for the resource manager is available at https://github.com/q=
uic/gunyah-resource-manager.
> +
> +The resource manager provides the following features:
> +
> +- VM lifecycle management: allocating a VM, starting VMs, destruction of=
 VMs
> +- VM access control policy, including memory sharing and lending
> +- Interrupt routing configuration
> +- Forwarding of system-level events (e.g. VM shutdown) to owner VM
> +
> +When booting a virtual machine which uses a devicetree, resource manager=
 overlays a
> +/hypervisor node. This node can let Linux know it is running as a Gunyah=
 guest VM,
> +how to communicate with resource manager, and basic description and capa=
bilities of
> +this VM. See Documentation/devicetree/bindings/firmware/gunyah-hyperviso=
r.yaml for a description
> +of this node.

The documentation LGTM.

> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/=
virt/gunyah/message-queue.rst
> new file mode 100644
> index 000000000000..e130f124ed52
> --- /dev/null
> +++ b/Documentation/virt/gunyah/message-queue.rst
> <snipped>...
> +The diagram below shows how message queue works. A typical configuration=
 involves
> +2 message queues. Message queue 1 allows VM_A to send messages to VM_B. =
Message
> +queue 2 allows VM_B to send messages to VM_A.
> +
> +1. VM_A sends a message of up to 1024 bytes in length. It raises a hyper=
call
> +   with the message to inform the hypervisor to add the message to
> +   message queue 1's queue.
> +2. Gunyah raises the corresponding interrupt for VM_B when any of these =
happens:
> +   a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is =
the typical case.
> +   b. Explicility with gh_msgq_push command from VM_A.
> +   c. Message queue has reached a threshold depth.
> +3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
> +

The nested list above should be separated with blank lines to be
rendered properly:

---- >8 ----

diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/vi=
rt/gunyah/message-queue.rst
index e130f124ed525a..afaad99db215e6 100644
--- a/Documentation/virt/gunyah/message-queue.rst
+++ b/Documentation/virt/gunyah/message-queue.rst
@@ -20,9 +20,11 @@ queue 2 allows VM_B to send messages to VM_A.
    with the message to inform the hypervisor to add the message to
    message queue 1's queue.
 2. Gunyah raises the corresponding interrupt for VM_B when any of these ha=
ppens:
+
    a. gh_msgq_send has PUSH flag. Queue is immediately flushed. This is th=
e typical case.
    b. Explicility with gh_msgq_push command from VM_A.
    c. Message queue has reached a threshold depth.
+
 3. VM_B calls gh_msgq_recv and Gunyah copies message to requested buffer.
=20
 For VM_B to send a message to VM_A, the process is identical, except that =
hypercalls

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Q0eTYf0QdFrQIfAA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzUUZAAKCRD2uYlJVVFO
o1q4APwP+/ERjbxXRPWCORGC4UT/SNYUj+eaww/Whwnueht3ogD/UzH9N4wlowyV
bpGIEj6dozRHKf0F907Ypqs4bZQmLw4=
=xA7F
-----END PGP SIGNATURE-----

--Q0eTYf0QdFrQIfAA--
